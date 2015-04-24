From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Apr 2015 09:58:01 +0200
Subject: imx6 sata cdrom driver issue
In-Reply-To: <5539101D.1020909@lenbrook.com>
References: <5539101D.1020909@lenbrook.com>
Message-ID: <15678294.L2fz4hMtva@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 April 2015 11:30:37 Jonathan Bagg wrote:
> Spam Status: CRM114    
> On arm imx6, running mainline 3.19, mounting a SATA CDROM fails aprox 
> 1/20 times with this error....
> 
> root at freescale /tmp$ mount /dev/sr0 test/
> UDF-fs: warning (device sr0): udf_fill_super: No partition found (2)
> mount: mounting /dev/sr0 on test/ failed: Invalid argument
> 
> I've tried several disks and dvd drivers.  They all experience this 
> issue.  The same disks mount 100% of the time on an x86 machine.  Once 
> mounted, I can read data without issue.  Also tried a HDD on the same 
> SATA link, no issue.
> 
> Sometimes the kernel will dump out the attached backtrace on the mount 
> command.
> 

I think  you have a combination of two bugs:

a) something that mount() does leads to the 'sd' device being unregistered
b) something goes wrong in the cleanup of that device, which leads to
   the messages you see.

What is particularly strange here is the error about unregistering the
/disk/ rather than the cdrom.

Do you have two SATA ports on one controller, with the other one being
conneced to a disk drive?

My best guess is that something in the error handling of
drivers/ata/ahci_imx.c causes a reset of the entire bus and that
triggers the other bugs. Can you instrument that error handling to
see what's going on?

	Arnd
