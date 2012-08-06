#!/usr/bin/perl

# Script name: listdir.pl
# Author: William Smith
# Course number: ITEC400-V1WW (SU11)
# Script functionality:
# Assignment number: 6-1

####################################################
# Test Scenarios
# All output names shall be in ascending order.
# Case #1: ./listdir.pl
# Case #2: ./listdir.pl -l
# Case #3: ./listdir.pl -d <directory>
# Case #4: ./listdir.pl -l -d <directory>
# Case #5: ./listdir.pl -l .
#####################################################

print `flush`;
thank();        #print thank header
use Getopt::Std;        # use declaration with the options function

getopts("ld:") or usage() and exit;     #accept only options l and d
$dOption = $opt_d;      # Store the d option to a variable
$lOption = $opt_l;      # Store the l option to a variable
$newDIR;

# If there is no option selected
if(!$lOption)
{
        nooption(); #call nooption file
}

# If option l is entered
elsif($lOption)
{
        loption(); #call loption file
}

# If option d is selected
else
{
        #display usage and exit
        print "\n";usage() ;"\n";
        exit 1;

}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~SUB ROUTINES~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# openDIR subroutine
#       -If -d option is not entered, then open the current directory.
#       -If -d option is entered, then check and open if it is a valid directory.
#       -Store all the files in the specify directory to an array

sub openDIR
{
        if($dOption)    #check if -d option is entered
        {
                chomp($dOption);        #trim space
                if (-d $dOption)        #check if it is a valid directory

                {
                        chdir($dOption);#change to specify directory
                        opendir($THISDIR,$dOption);    #open directory
                }
                # Print out error message when invalid directory is entered
                else {print "\n\t ==>\"$dOption\" is  Invalid Directory.\n\n";exit 1;}
        }
        else {opendir($THISDIR,".");}#open the specify directory
        @DIRLIST = readdir($THISDIR);#store all files to an array
        @DIRLIST = sort(@DIRLIST); #!SORTED ARRAY!
}

# nooption subroutine -print this output when there is no option specified
sub nooption
{
        openDIR();      #call openDIR() method
        print "File Names\n";#print header
        print "---------------\n";
        # Print out the result
        foreach $result(@DIRLIST){if(-f $result){print "$result\n";}}
        closedir($THISDIR);#close directory.
        exit 1;
}

sub loption # l option subroutine
{
        openDIR();      #call openDIR() method
        print "\n";
        # Print header
        printf ("\%-25s", " File Name");
        printf ("\%7s", "Size");
        printf " ";
        printf ("\%-10s", "Owner");
        printf ("\%-15s\n", "Group");
        printf ("\%-25s", "------------- ");
        printf ("\%7s", "------");
        printf " ";
        printf ("\%-10s", "---------");
        printf ("\%-15s\n", "-----------");
        # Print output
        foreach $result (@DIRLIST)
        {
                if(-f $result) # Verify that the result is a file
                {
                        $size  = -s $result;
                        $group = (stat($result))[5];
                        $group = getgrgid($group);
                        $user  = (stat($result))[4];
                        $user  = getpwuid($user);

                        # Print out file name
                        printf ("\%-25s", "$result");
                        # File size = 7 space reserve, RIGHT Alignment
                        printf ("\%7s", "$size");
                        printf " ";
                        # File Owner = 10 spaces reserve, LEFT Agliment
                        print ("\%-10s", "$user");
                        # File Group = 15 spaces reserve, LEFT Agliment
                        printf ("\%-15s\n", "$group");
                }

        }
        closedir($THISDIR);
        exit 1;
}
# This is the usage document which is used to display the usage error message
sub usage{
        print STDERR << "EOF";
        usage: $0 [-l][-d dir]
        -l : Display the long list(File Name, Size, Owner and Group.
        -d dir : scan directory.
        NOTE: all the options have to start with '-' sign.
EOF
}
# This is the thank subroutine
sub thank
{

# Print out the header
print `flush`;
print `clear`;

print "\n\n\n\n\n\n\n\n\t###################################\n";
print "\t#    Thank for using our script   #";
print "\n\t###################################\n\n";

}
				
