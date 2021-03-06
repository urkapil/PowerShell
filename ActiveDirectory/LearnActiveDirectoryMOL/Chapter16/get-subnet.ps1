<#
 Code listings from:
  Active Directory Management in a Month of Lunches
  Chapter 16

 All code supplied "as is" as an example to illustrate the text. No guarantees or warranties are supplied with this code.
 It is YOUR responsibilty to test if for suitability in YOUR environment.
 The comments match the section headings in the chapter
#>
$allnets = @()
$subnets = [ADSI]"LDAP://CN=Subnets,CN=Sites,CN=Configuration,DC=Manticore,DC=org"
foreach ($subnet in $subnets.children) {
    $net = [ADSI]"$($subnet.Path)"
    $data = "" | select Name, Location, Site, Description
    $data.name = $($net.cn)
    $data.Location = $($net.location)
    $data.Description = $($net.description)
    $st = $($net.siteobject).split(",")
    $data.site = $st[0].Replace("CN=","")
    $allnets += $data
}
$allnets | Format-Table