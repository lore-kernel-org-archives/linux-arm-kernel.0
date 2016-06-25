From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 25 Jun 2016 23:08:28 +0100
Subject: orion5x: initrd fails to load due to reserved memory
In-Reply-To: <20160625194625.GA16705@jirafa.cyrius.com>
References: <20160625162040.GA15367@jirafa.cyrius.com>
 <20160625171615.GC1041@n2100.armlinux.org.uk>
 <20160625194625.GA16705@jirafa.cyrius.com>
Message-ID: <20160625220827.GD1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 25, 2016 at 12:46:25PM -0700, Martin Michlmayr wrote:
> Anyway, I don't think the problem is that the kernel is too large.
> This u-boot always loads the ramdisk 2 MB after the kernel, and
> setting 0x0500000 as loadAddr (therefore 0x0700000 for the initrd)
> works fine.

Okay, it's not the zImage then...
> 
> > > Booting the image (@ 0x400000) with RamDisk (@ 0x600000)...
> > > 
> > > Unfortunately, with 4.x, this leads to:
> > > 
> > > INITRD: 0x00600040+0x00727f12 overlaps in-use memory region - disabling initrd
> > 
> > Right, so the kernel worked out that something else overwrote the
> > initramfs.  If you boot with memblock=debug, and memblock should
> > dump out the memory and reserved regions.
> 
> Thanks.  I've attached logs with loadAddr=0x0400000 (the default,
> which fails) and loadAddr=0x0500000 (which boots fine).

At this point, I stopped reading, and just looked at the logs.  Sorry
if there was something more relevant in the rest of the email...

=== p-0x0400000 ===
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.6.0-1-marvell (debian-kernel at lists.debian.org) (gcc version 5.4.0 20160609 (Debian 5.4.0-4) ) #1 Debian 4.6.2-1 (2016-06-15)
> [    0.000000] CPU: Feroceon [41069260] revision 0 (ARMv5TEJ), cr=a005317f
> [    0.000000] CPU: VIVT data cache, VIVT instruction cache
> [    0.000000] Machine: HP Media Vault mv2120
> [    0.000000] Clearing invalid memory bank 0KB at 0xffffffff
> [    0.000000] Clearing invalid memory bank 0KB at 0xffffffff
> [    0.000000] Clearing invalid memory bank 0KB at 0xffffffff
> [    0.000000] Ignoring unrecognised tag 0x00000000
> [    0.000000] Ignoring unrecognised tag 0x00000000
> [    0.000000] Ignoring unrecognised tag 0x00000000
> [    0.000000] Ignoring unrecognised tag 0x41000403
> [    0.000000] memblock_reserve: [0x00000000008200-0x0000000060646f] flags 0x0 arm_memblock_init+0x20/0x17c
> [    0.000000] INITRD: 0x00600040+0x00727f12 overlaps in-use memory region - disabling initrd

Right, so we can see that the first memblock_reserve() overlaps the
initrd, and if we look a little further down the kernel messages:

> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> [    0.000000]     vmalloc : 0xc8800000 - 0xff800000   ( 880 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc051993c   (5191 kB)
> [    0.000000]       .init : 0xc051a000 - 0xc0562000   ( 288 kB)
> [    0.000000]       .data : 0xc0562000 - 0xc05bdcb0   ( 368 kB)
> [    0.000000]        .bss : 0xc05bdcb0 - 0xc0606470   ( 290 kB)

The kernel's BSS ends at 0x60646f into RAM.  So the kernel's BSS overlaps
the ramdisk.  Hence, the _uncompressed_ kernel is too large.

=== p-0x0500000 ===
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.6.0-1-marvell (debian-kernel at lists.debian.org) (gcc version 5.4.0 20160609 (Debian 5.4.0-4) ) #1 Debian 4.6.2-1 (2016-06-15)
> [    0.000000] CPU: Feroceon [41069260] revision 0 (ARMv5TEJ), cr=a005317f
> [    0.000000] CPU: VIVT data cache, VIVT instruction cache
> [    0.000000] Machine: HP Media Vault mv2120
> [    0.000000] Clearing invalid memory bank 0KB at 0xffffffff
> [    0.000000] Clearing invalid memory bank 0KB at 0xffffffff
> [    0.000000] Clearing invalid memory bank 0KB at 0xffffffff
> [    0.000000] Ignoring unrecognised tag 0x00000000
> [    0.000000] Ignoring unrecognised tag 0x00000000
> [    0.000000] Ignoring unrecognised tag 0x00000000
> [    0.000000] Ignoring unrecognised tag 0x41000403
> [    0.000000] memblock_reserve: [0x00000000008200-0x0000000060646f] flags 0x0 arm_memblock_init+0x20/0x17c
> [    0.000000] memblock_reserve: [0x00000000700040-0x00000000e27f51] flags 0x0 arm_memblock_init+0xf4/0x17c

Here, we can see that the kernel occupies the same space in memory, but
because the ramdisk is loaded a little higher, everything works out fine.

What I'm surprised about, however, is that the kernel zImage is 2MB, but
it apparently didn't overwrite the ramdisk - the decompressor would have
relocated itself after the data section of the kernel image.  In other
words, 0x5bdcb0+2MB+padding.  That surely takes it into the ramdisk
even at 0x700040.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
