From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Feb 2010 22:19:18 +0000
Subject: Separate/external initramfs, ATAG's, kernel panics ... Oh My!
In-Reply-To: <3d1967ab1002221407r1e10dff2l395b3d365ffe3a29@mail.gmail.com>
References: <3d1967ab1002221407r1e10dff2l395b3d365ffe3a29@mail.gmail.com>
Message-ID: <20100222221918.GA7772@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2010 at 05:07:21PM -0500, Brian Hutchinson wrote:
> First, while reading the fine ARM boot document about ATAG's, I
> realized that the u-boot (version 1.1.6) that shipped with our board
> had #define CONFIG_SETUP_MEMORY_TAGS and CONFIG_INITRD_TAG commented
> out.
> 
> Thinking that this was my problem ... I recompiled u-boot only to
> start getting the Kernel telling me it couldn't recognize my ATAG_MEM
> definitions and that INITRD: was outside physical memory.

What do you mean "it couldn't recognize my ATAG_MEM definitions" ?

The "INITRD: was outside physical memory" seems entirely reasonable
given what you're saying below:

> I've tried to wrap the cpio.gz in a u-boot image with:
> mkimage -A arm -O linux -T ramdisk -C gzip -a 0x200000 -e 0x200000 -n
> uInitramfs_busybox -d /home/hutch/squashfs/test.cpio.gz
> uInitramfs_busybox
> 
> This was used with a bootargs line in uboot of:
> bootargs initrd=0x200000
> ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netdev:any
> console=$consoledev,$baudrate $othbootargs;
> 
> Kernel is located at 0x20080000 and the cpio.gz mkimage file was
> stored at 0x20280000

Okay - you say the kernel is at 0x20080000, but this can't be, because
it needs to have a 32K offset - I assume you mean it's at 0x20008000.
So this presumably means that physical memory starts at 0x20000000.

So, the first problem with the above is that you're telling uboot to
load your ramdisk into physical address 0x200000 - below physical memory.
(In that case, is it unsurprising that the ATAG_INITRD caused a complaint?)

The second problem is that 0x20208000 - 0x20008000 = 0x00200000, or 2MB.
With the size of kernels today, 2MB is not sufficient space.  You want it
to be at least 16MB above the kernel.

The problem is that if the image gets corrupted, but it still looks like
a gzip, the gunzip code can get horribly confused and loop infinitely -
it sounds like this is what's happening.
