From: klightspeed@killerwolves.net (Ben Peddell)
Date: Sat, 11 Jan 2014 01:48:21 +1000
Subject: [PATCH RFC RFT 0/2] ARM: Kirkwood: Synology DT files
In-Reply-To: <20140110145841.GF15937@n2100.arm.linux.org.uk>
References: <1389052027-16819-1-git-send-email-andrew@lunn.ch>
 <52CE312B.3060108@killerwolves.net> <20140109165557.GB9681@lunn.ch>
 <52CF4652.3030207@killerwolves.net>
 <20140110112846.GG27432@n2100.arm.linux.org.uk>
 <52CFFF07.5080806@killerwolves.net> <20140110142548.GG9681@lunn.ch>
 <20140110145841.GF15937@n2100.arm.linux.org.uk>
Message-ID: <52D01645.3060103@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/14 00:58, Russell King - ARM Linux wrote:
> On Fri, Jan 10, 2014 at 03:25:48PM +0100, Andrew Lunn wrote:
>> On Sat, Jan 11, 2014 at 12:09:11AM +1000, Ben Peddell wrote:
>>> Bytes transferred = 1954736 (1dd3b0 hex)
>>> Marvell>> setenv bootargs console=ttyS0,115200 ip=off initrd=0x00800040,0x0013FFC0 root=/dev/md0 rw syno_hw_version=DS211j ihd_num=2 netif_num=1 earlyprintk
>>
>> I don't see you loading the initrd into RAM at 0x0080 0000.
> 
> However, the kernel _is_ being told that the initrd is at 0x00800040.
> 
>>> Uncompressing Linux... done, booting the kernel.
>>> [    0.000000] Booting Linux on physical CPU 0x0
>>> [    0.000000] Linux version 3.13.0-rc7-ds211j+ (root at lurch) (gcc version 4.8.2 (Gentoo 4.8.2 p1.3, pie-0.5.8) ) #2 Thu Jan 9 08:52:24 EST 2014
>>> [    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
>>> [    0.000000] CPU: VIVT data cache, VIVT instruction cache
>>> [    0.000000] Machine model: Synology DS210 v10, v20, v30, DS211j
>>> [    0.000000] bootconsole [earlycon0] enabled
>>> [    0.000000] INITRD: 0xf8280040+0x000f993c is not a memory region - disabling initrd
>>
>> The kernel is correct. There is no RAM here. That is in the IOMEM
>> space.
> 
> But here the kernel has ignored the command line parameter and instead
> used the one passed via DT.  That is not correct - command line parameters
> must always override ATAGs or DT.
> 
> (That's irrespective of whether what's actually being asked of the kernel
> is correct or not - the principle here applies that command line parameters
> override, and in this case they aren't.)


Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.13.0-rc7-ds211j+ (klightspeed at lurch) (gcc version 4.8.2 (Gentoo 4.8.2 p1.3, pie-0.5.8) ) #4 Sat Jan 11 01:20:05 EST 2014
[    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] FDT initrd_start=0xf8280040  initrd_end=0xf83c0000
[    0.000000] Machine model: Synology DS210 v10, v20, v30, DS211j
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Kernel Parameter initrd=0x00800040,0x0013ffc0
[    0.000000] INITRD: 0xf8280040+0x0013ffc0 is not a memory region - disabling initrd
...
[    1.316624] Trying to unpack rootfs image as initramfs...
[    1.322097] Unable to handle kernel paging request at virtual address b8280040


First, FDT fills in initrd_start and initrd_end:

--- start drivers/of/fdt.c line 704 early_init_dt_check_for_initrd() ---
        initrd_start = (unsigned long)__va(start);
        initrd_end = (unsigned long)__va(end);
        initrd_below_start_ok = 1;
--- end ---

Then the initrd parameter is parsed into phys_initrd_start and phys_initrd_size:

--- start arch/arm/mm/init.c line 52 early_initrd() ---
                phys_initrd_start = start;
                phys_initrd_size = size;
--- end ---

phys_initrd_start and phys_initrd_size is then overwritten from initrd_start and initrd_end:

--- start arch/arm/mm/init.c line 351 arm_memblock_init() ---
        /* FDT scan will populate initrd_start */
        if (initrd_start) {
                phys_initrd_start = __virt_to_phys(initrd_start);
                phys_initrd_size = initrd_end - initrd_start;
        }
--- end ---

initrd_start and initrd_end are still set, and so unpack_to_rootfs() tries to access it.
