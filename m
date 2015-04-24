From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 23 Apr 2015 22:25:08 -0600
Subject: BCM2836 (Raspberry Pi 2) port
In-Reply-To: <1429639796-2169-1-git-send-email-eric@anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
Message-ID: <5539C5A4.5070409@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2015 12:09 PM, Eric Anholt wrote:
> This is my first submission of a Raspberry Pi 2 port.  It can be found
> at https://github.com/anholt/linux/tree/bcm2836
> 
> I'm using the 2835 interrupt controller support, without adding the
> checks for ARM local interrupts first.  That means no support for IPIs
> (and thus no SMP), no PMU events, and no local timer (I'm using the
> same 2835 peripheral one).
> 
> It supports a similar featureset to Pi 1 at this point.  Serial and SD
> cards work.  Just one CPU supported.  USB (ethernet) works if you use
> U-Boot, or my mailbox series
> (https://github.com/anholt/linux/tree/bcm2836-mbox).

I can't quite get this to work. I think what's happening is that U-Boot
is over-writing the location of the code/data that the CPU1..3 pin loop
uses. Do you know what that address is so I can confirm that?

I suspect this because when I load the kernel/DT in U-Boot, or when I
jump to the kernel to boot it, I see lots of extra duplicated characters
on the UART, like all 4 CPUs are booting Linux. For example:

> Hit any key to stop autoboot:  0 
> U-Boot> setenv fdt_high fffffff
> U-Boot> boot
> switch to partitions #0, OK
> mmc0 is current device
> Scanning mmc 0:1...
> Found /extlinux/extlinux.conf
> Retrieving file: /extlinux/extlinux.conf
> reading /extlinux/extlinux.conf
> 429 bytes read in 18 ms (22.5 KiB/s)
> Boot menu
> 1:	Default kernel
> 2:	Backup kernel
> Enter choice: 1
> 1:	Default kernel
> Retrieving file: /extlinux/../zImage
> reading /extlinux/../zImage
> 3467376 bytes read in 1996 ms (1.7 MiB/s)
> append: earlyprintk loglevel=8 console=ttyAMA0 console=tty1 verbose rootwait root=/dev/mmcblk0p2 rw
> Retrieving file: /extlinux/../bcm2836-rpi-2-b.dtb
> reading /extlinux/../bcm2836-rpi-2-b.dtb  LLLiiinnnuuuxxx.........
> 
> 
> 
> 
> 
> 
> OOOuuuttt   ooofff   mmmeeemmmooorrryyy   wwwhhhiiillleee   aaallllllooocccaaatttiiinnnggg   ooouuutttpppuuuttt   bbbuuuffffffeeerrr
> 
>  -- System halted4572 bytes read in 33 ms (134.8 KiB/s)
> Kernel image @ 0x1000000 [ 0x000000 - 0x34e870 ]
> ## Flattened Device Tree blob at 02000000
>    Booting using the fdt blob at 0x2000000
>    Loading Device Tree to 0fffb000, end 0ffff1db ... OK
> 
> Starting kernel ...
