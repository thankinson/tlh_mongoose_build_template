$dirLoc = $pwd; # this is where you set your directory. $pwd is a windows predefined var to retrive your curent directory
Set-Location $dirLoc;
# $installLocation = Read-Host -Prompt 'Input your directory'
$projectName = Read-Host -Prompt 'Enter project folder name';

# create directory for your app
New-Item -ItemType "directory" -path "$projectName";
$projectLoc = "$dirLoc\$projectName"

# asks if you want to create a database
$dbcheck = Read-Host -Prompt 'Create database directory for mongoDB using mongoose? [y or n] : ';
# checks if you want to set up a database 
if ($dbcheck -eq 'y'){
    $schemaName = Read-Host -Prompt 'What is your Schema name: ';
    New-Item -ItemType "directory" -Path "$projectLoc/src/db", "$projectLoc/src/$schemaName";
    New-Item -ItemType "file" -Path "$projectLoc\src\$schemaName\functions.js", "$projectLoc\src\$schemaName\model.js", "$projectLoc\src\db\connection.js", "$projectLoc\src\app.js";
    # populate file code here
    Get-Content -Path "$dirLoc\script\templates\mongo_db\connectionTemp.txt" | Add-Content -Path "$projectLoc\src\db\connection.js";
    Get-Content -Path "$dirLoc\script\templates\mongo_db\modelTemp.txt" | Add-Content -Path "$projectLoc\src\$schemaName\model.js";
} else {
    Write-Output "nothing happens";
}

# asks if you want to install the node modules for mongoose
$nodeCheck = Read-Host -Pprompt 'Do you want to install node moduals for mongoose? [y or n]: ';

if ($nodeCheck -eq 'y'){
    Set-Location "$projectLoc";
    New-Item -ItemType "file" -Path ".gitignore", ".env"
    npm init -y;
    npm i mongoose yargs dotenv
    Set-Location ..
    Get-Content -Path "$dirLoc\script\templates\envTemp\gitnoreTemp.txt" | Add-Content -Path "$projectLoc\.gitnore";
} else {
    Write-Output "Nothing happens"
}