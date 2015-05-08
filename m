From: jbagg@lenbrook.com (Jonathan Bagg)
Date: Fri, 8 May 2015 15:45:56 -0400
Subject: imx6 sata cdrom driver issue
In-Reply-To: <2901871.Bfl6KrJo7t@wuerfel>
References: <5539101D.1020909@lenbrook.com> <3757889.IHh7sEV0GH@wuerfel>
 <5547DEA7.8080009@lenbrook.com> <2901871.Bfl6KrJo7t@wuerfel>
Message-ID: <554D1274.70804@lenbrook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-05-05 06:48 AM, Arnd Bergmann wrote:
> On Monday 04 May 2015 17:03:35 Jonathan Bagg wrote:
>> On 15-05-04 02:37 PM, Arnd Bergmann wrote:
>>> On Friday 01 May 2015 11:32:49 Jonathan Bagg wrote:
>>>> On 15-04-24 03:58 AM, Arnd Bergmann wrote:
>>>>> On Thursday 23 April 2015 11:30:37 Jonathan Bagg wrote:
>>>>>
>>>>> Do you have two SATA ports on one controller, with the other one being
>>>>> conneced to a disk drive?
>>>> Not when this error happened, but the CD-ROM was connected through a
>>>> port multiplier.  One time I noticed sda device appear so I mounted it
>>>> and it was the CD-ROM filesystem!
>>> Very strange, I'm sure something went wrong there and either the SATA
>>> host or the CDROM driver does not work well with a port multiplier.
>>>
>>> Is there a way for you to reproduce the problem without the multiplier?
>>>
>>>>> My best guess is that something in the error handling of
>>>>> drivers/ata/ahci_imx.c causes a reset of the entire bus and that
>>>>> triggers the other bugs. Can you instrument that error handling to
>>>>> see what's going on?
>>>>>
>>>> Also tried a cubox
>>>> <https://www.solid-run.com/products/cubox-i-mini-computer/>, (imx6)
>>>> running  Linux OpenELEC 3.14.18 #1 SMP Sun Sep 14 12:22:14 EDT 2014
>>>> armv7l GNU/Linux
>>> Can you find out if there is a port multiplier in that machine?
>> I've tried with and without a multiplier.  I have a port multiplier on a
>> development board that I can connect between the CDROM and Sabre SATA
>> port or connect the CDROM directly to the Sabre SATA port .
>>> Does it list the sda device in /proc/partitions, or just the /dev/sr0?
>> sda is only listed in /proc/partitions if I connect up a HDD.  The issue
>> where the CDROM filesystem mounting as sda1 has never reproduced.
>>
>> I've also discovered, and it is 100% reproducible, that with the HDD and
>> CDROM connected using the port multiplier, the kernel never lists the
>> partition on the HDD.  If I connect the HDD directly to the Sabre or
>> connect the HDD to the Sabre using the multiplier without the CDROM,
>> /dev/sda1 will exist.
> Ok, interesting. Does the same happen if you connect that port
> multiplier to a PC?
I don't think the host sata port on the PC I tried supported 
multipliers.  I tried the port multiplier on a imx53 Quick Start Board 
and it worked fine.  We've also discovered that cdparanoia (audio CD 
ripper) fails to recognize the CDROM drive 100% of the time on imx6 with 
or without the port multiplier.  On the imx53 Quick Start Board, running 
the same kernel, just a different device tree, cdparanoia works great 
with and without the port multiplier. If you apply the attached patch to 
enable sata debug output, the imx6 output is different than the imx53's....

cdparanoia -vsQ
dmesg | grep CDB

imx53

ata_scsi_dump_cdb: CDB (1:0,0,-571258880) 00 00 4a 01 00 00 10 00 00
CDB rbuf: [4a 01 00 00 10 00 00 00 08]
CDB rbuf: 00000000: 00 06 04 56 00 02 00 00

imx6 - third line is always zeros

ata_scsi_dump_cdb: CDB (1:0,0,-1122908160) 00 00 4a 01 00 00 10 00 00
CDB rbuf: [4a 01 00 00 10 00 00 00 08]
CDB rbuf: 00000000: 00 00 00 00 00 00 00 00

We also tried kernel versions 3.12, 3.14, 3.19 and most recent 4.x, all 
are effected.  imx6 sata support didn't exists in 3.10, so we couldn't 
go further back.

https://community.freescale.com/message/514169#514169



-- 
Jonathan Bagg
Embedded Systems Developer
NAD Electronics | Lenbrook Industries Limited
633 Granite Court, Pickering, Ontario, Canada L1W 3K1 | 905-831-0799 ext 4478 | http://www.nadelectronics.com

-------------- next part --------------
A non-text attachment was scrubbed...
Name: ata_debug.patch
Type: text/x-patch
Size: 1450 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150508/1aa9edc8/attachment.bin>
