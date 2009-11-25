From: pierre.savary@kerlink.fr (Pierre Savary)
Date: Wed, 25 Nov 2009 14:48:16 +0100
Subject: [ LPC3250 ] discontinuous DDR-Ram : problem of write buffer coherency
Message-ID: <002c01ca6dd5$f19eac90$d4dc05b0$@savary@kerlink.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
I need some help about a big problem on my board. Currently we work with a
custom board with LPC3250 (NXP) and two blocks of DDR-SDRAM. These blocks
are discontinuous.
We use the version 2.6.27.8 of the kernel and u-boot-2009.03. We modified
./arch/arm/mach-lpc32xx/include/mach/memory.h of our platform to be able to
work with 2*64Mo of RAM. This is the modification:
[...]
#if defined(CONFIG_MACH_LPC32XX_DRAM_SIZE_64)
/*
 * This support is added for systems that have 2 64MByte devices on
different
 * chip selects (DYCS0 and DYCS1). In this configuration, there is a memory
 * hole between the 2 devices such that the addresses are as follows:
 * DYCS0 - 0x80000000 - 0x83ffffff (node 0, 16Kpages)
 * DYCS1 - 0xa0000000 - 0xa3ffffff (node 1, 16Kpages)
 */
#define KVADDR_TO_NID(addr) \
      (((unsigned long) (addr) - PAGE_OFFSET) >> 26)

#define LOCAL_MAP_NR(addr) \
       (((unsigned long)(addr) & 0x03ffffff) >> PAGE_SHIFT)

#define __virt_to_phys(x) \
	((((unsigned long) (x) & ~0x04000000) - PAGE_OFFSET + PHYS_OFFSET)
|\
	(((unsigned long) (x) & 0x04000000) << 3))

#define __phys_to_virt(x) \
	((((unsigned long) (x) & ~0x20000000) - PHYS_OFFSET + PAGE_OFFSET)
|\
	(((unsigned long) (x) & 0x20000000) >> 3))
#endif
[...]


With this, it seems to work well... However we obtain some strange traces
during the boot:

Uncompressing
Linux.......................................................................
....................... done, booting the kernel.
?Linux version 2.6.27.8 (psa at fedora-psa)  (gcc version 4.3.2
(crosstool-NG-1.3.1) ) #805 PREEMPT Wed Nov 25 13:03:55 CET 2009
CPU: ARM926EJ-S [41069264] revision 4 (ARMv5TEJ), cr=00053177
Machine: xxxxxxxxx the LPC3250 Microcontroller
Memory policy: ECC disabled, Data cache writeback
CPU0: D VIVT write-back cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 2 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttyS0,115200n81 root=/dev/mtdblock5
rootfstype=yaffs2 init=/sbin/init panic=1 ethaddr=00:4B:03:00:00:16
mtdparts=lpc32xx_nand:256k(Bootstrap),256k(Bootloader),256k(U-Boot_Env),12m(
Kernel-initramfs),12m(RescueFS),36m(rootfs),-(userFS) no_console_suspend=0
mminit_loglevel=10
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 64MB 64MB = 128MB total
Memory: 125416KB available (3964K code, 250K data, 128K init)
Calibrating delay loop... 103.68 BogoMIPS (lpj=207360)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: <4>------------[ cut here ]------------
WARNING: at
/mnt/workdir/gestion_conf_klk/klk-SWe/sources/linux/linux-2.6.27.8/mm/vmallo
c.c:107 map_vm_area+0x114/0x1d0()
Modules linked in:
[<c032bfb8>] (dump_stack+0x0/0x14) from [<c004caf0>]
(warn_on_slowpath+0x4c/0x84)
[<c004caa4>] (warn_on_slowpath+0x0/0x84) from [<c009457c>]
(map_vm_area+0x114/0x1d0)
 r6:c4800800 r5:c4800000 r4:c04b8100
[<c0094468>] (map_vm_area+0x0/0x1d0) from [<c0094a2c>] (vmap+0x50/0x78)
[<c00949dc>] (vmap+0x0/0x78) from [<c001012c>]
(check_writebuffer_bugs+0x54/0x128)
 r5:c042b508 r4:c0409fb0
[<c00100d8>] (check_writebuffer_bugs+0x0/0x128) from [<c000899c>]
(start_kernel+0x28c/0x300)
 r7:c040bca4 r6:c0024f08 r5:c042b508 r4:c0433850
[<c0008710>] (start_kernel+0x0/0x300) from [<80008034>] (0x80008034)
 r6:c002530c r5:c042b9cc r4:00053175
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at
/mnt/workdir/gestion_conf_klk/klk-SWe/sources/linux/linux-2.6.27.8/mm/vmallo
c.c:107 map_vm_area+0x114/0x1d0()
Modules linked in:
[<c032bfb8>] (dump_stack+0x0/0x14) from [<c004caf0>]
(warn_on_slowpath+0x4c/0x84)
[<c004caa4>] (warn_on_slowpath+0x0/0x84) from [<c009457c>]
(map_vm_area+0x114/0x1d0)
 r6:c4800808 r5:c4802000 r4:c04b8100
[<c0094468>] (map_vm_area+0x0/0x1d0) from [<c0094a2c>] (vmap+0x50/0x78)
[<c00949dc>] (vmap+0x0/0x78) from [<c0010144>]
(check_writebuffer_bugs+0x6c/0x128)
 r5:c4800000 r4:c0409fb0
[<c00100d8>] (check_writebuffer_bugs+0x0/0x128) from [<c000899c>]
(start_kernel+0x28c/0x300)
 r7:c040bca4 r6:c0024f08 r5:c042b508 r4:c0433850
[<c0008710>] (start_kernel+0x0/0x300) from [<80008034>] (0x80008034)
 r6:c002530c r5:c042b9cc r4:00053175
---[ end trace 4eaa2a86a8e2da22 ]---
/mnt/workdir/gestion_conf_klk/klk-SWe/sources/linux/linux-2.6.27.8/mm/memory
.c:130: bad pmd a080041e.
failed, enabling work-around
[...]

In fact it causes some big issues during function of the board. When we do
some copy of files > 64Mo, we obtain freezes due to the problem of write
buffer...
How can we solve it? Have you an idea about this issue? It is really
critical for us... and we cannot change our kernel version.

Thanks in advance,
Best Regards,

Pierre
