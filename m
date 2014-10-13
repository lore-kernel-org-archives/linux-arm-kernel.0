From: stuartl@vrt.com.au (Stuart Longland)
Date: Tue, 14 Oct 2014 08:45:33 +1000
Subject: Where is DRAM initialisation done?
Message-ID: <543C560D.5070305@vrt.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I have a silly question that I'm hoping someone can answer.  I'm porting
the mainline Linux kernel across to the Technologic Systems
TS-7670[1]/TS-7400[2] series of industrial embedded computers (as their
stock kernel is quite old).

My work at the moment is sitting at
http://bne.vrt.com.au/technologicsys/ with git in the following
repositories:

- git://git.longlandclan.yi.org/for-upstream/technologicsys/u-boot.git
(ts7670 branch)

http://git.longlandclan.yi.org/?p=for-upstream/technologicsys/u-boot.git;a=shortlog;h=ts7670
-
git://git.longlandclan.yi.org/for-upstream/technologicsys/linux-stable.git
(ts7670-3.16.4 branch)

http://git.longlandclan.yi.org/?p=for-upstream/technologicsys/linux-stable.git;a=shortlog;h=ts7670-3.16.4

These devices are based on the Freescale i.MX286 system on chip, and are
similar to the Freescale MX28EVK.  Two versions of this board exists,
one uses a 128MB RAM chip (Samsung K4T16G164QF) and the other uses a
256MB RAM chip (Memphis AG MEM2G16D2ABG-25).

The 128MB one pretty much booted with slight modifications to the
MX28EVK port.  The 256MB one is giving me quite a bit of grief, and I
suspect it's because of how the DRAM is initialised.

The following is the oops message I get whilst the machine is booting
up.  Sometimes it crashes after the "Uncompressing Linux... done,
booting the kernel.", which hints that my DRAM init in U-Boot may not be
completely kosher.

> Uncompressing Linux... done, booting the kernel.
> HTLLCLLC
> 
> U-Boot 2014.10-rc3-01358-g6b08bf9 (Oct 13 2014 - 16:35:22)
> 
> CPU:   Freescale i.MX28 rev1.2 at 454 MHz
> BOOT:  SSP SD/MMC #0, 3V3
> DRAM:  256 MiB
> NAND:  2048 MiB
> MMC:   MXS MMC: 0, MXS MMC: 1
> mxsmmc_init: initialising MMC
> *** Warning - bad CRC, using default environment
> 
> In:    serial
> Out:   serial
> Err:   serial
> Net:   FEC0 [PRIME]
> Hit any key to stop autoboot:  0 
> mxsmmc_init: initialising MMC
> switch to partitions #0, OK
> mmc0 is current device
> mxsmmc_init: initialising MMC
> reading boot.scr
> ** Unable to read file boot.scr **
> reading zImage
> 2702088 bytes read in 816 ms (3.2 MiB/s)
> Booting from mmc ...
> reading imx28-technologic-ts7400.dtb
> 20723 bytes read in 32 ms (631.8 KiB/s)
> Kernel image @ 0x42000000 [ 0x000000 - 0x293b08 ]
> ## Flattened Device Tree blob at 41000000
>    Booting using the fdt blob at 0x41000000
>    Loading Device Tree to 4fb32000, end 4fb3a0f2 ... OK
> 
> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.16.4-vrt-ts7670-00013-g895600c (stuartl at rikishi) (gcc version 4.7.3 (Gentoo Hardened 4.7.3-r1 p1.4, pie-0.5.5) ) #3 Mon Oct 13 16:30:23 EST 2014
> [    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=0005317f
> [    0.000000] CPU: VIVT data cache, VIVT instruction cache
> [    0.000000] Machine model: Technologic Systems TS-7400/TS-7670
> [    0.000000] Memory policy: Data cache writeback
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
> [    0.000000] Kernel command line: console=ttyAMA0,115200 root=/dev/mmcblk0p3 rw rootwait
> [    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> [    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> [    0.000000] Memory: 243880K/262144K available (5214K kernel code, 308K rwdata, 1872K rodata, 230K init, 8203K bss, 18264K reserved)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
> [    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
> [    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc06f3fb0   (7088 kB)
> [    0.000000]       .init : 0xc06f4000 - 0xc072dbb0   ( 231 kB)
> [    0.000000]       .data : 0xc072e000 - 0xc077b3d0   ( 309 kB)
> [    0.000000]        .bss : 0xc077b3d0 - 0xc0f7e1c8   (8204 kB)
> [    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.000000] NR_IRQS:16 nr_irqs:16 16
> [    0.000047] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956969942ns
> [    0.001817] Console: colour dummy device 80x30
> [    0.001978] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [    0.002008] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.002031] ... MAX_LOCK_DEPTH:          48
> [    0.002052] ... MAX_LOCKDEP_KEYS:        8191
> [    0.002072] ... CLASSHASH_SIZE:          4096
> [    0.002092] ... MAX_LOCKDEP_ENTRIES:     32768
> [    0.002111] ... MAX_LOCKDEP_CHAINS:      65536
> [    0.002131] ... CHAINHASH_SIZE:          32768
> [    0.002151]  memory used by lock dependency info: 5167 kB
> [    0.002171]  per task-struct memory footprint: 1152 bytes
> [    0.002294] Calibrating delay loop... 226.09 BogoMIPS (lpj=1130496)
> [    0.071169] pid_max: default: 32768 minimum: 301
> [    0.071838] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.071901] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.078368] CPU: Testing write buffer coherency: ok
> [    0.082108] Setting up static identity map for 0x404f47d0 - 0x404f4828
> [    0.097416] devtmpfs: initialized
> [    0.106674] pinctrl core: initialized pinctrl subsystem
> [    0.113536] regulator-dummy: no parameters
> [    0.171156] NET: Registered protocol family 16
> [    0.172950] DMA: preallocated 256 KiB pool for atomic coherent allocations
> [    0.258789] Serial: AMBA PL011 UART driver
> [    0.260984] 80074000.serial: ttyAMA0 at MMIO 0x80074000 (irq = 223, base_baud = 0) is a PL011 rev2
> [    0.553572] console [ttyAMA0] enabled
> [    0.626545] mxs-dma 80004000.dma-apbh: initialized
> [    0.642150] mxs-dma 80024000.dma-apbx: initialized
> [    0.649562] 3P3V: 3300 mV 
> [    0.654699] vddio-sd0: 3300 mV 
> [    0.659963] fec-3v3: 3300 mV 
> [    0.664883] usb_vbus: 5000 mV 
> [    0.670039] can-3v3: 3300 mV 
> [    0.676589] SCSI subsystem initialized
> [    0.683026] usbcore: registered new interface driver usbfs
> [    0.689143] usbcore: registered new interface driver hub
> [    0.695486] usbcore: registered new device driver usb
> [    0.712722] pps_core: LinuxPPS API ver. 1 registered
> [    0.717888] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.727287] PTP clock support registered
> [    0.741001] Switched to clocksource mxs_timer
> [    0.870451] Unable to handle kernel paging request at virtual address 4b110408
> [    0.877906] pgd = c0004000
> [    0.880655] [4b110408] *pgd=00000000
> [    0.884431] Internal error: Oops: 5 [#1] ARM
> [    0.888731] Modules linked in:
> [    0.891834] CPU: 0 PID: 1 Comm: swapper Not tainted 3.16.4-vrt-ts7670-00013-g895600c #3
> [    0.899864] task: cf440000 ti: cf42e000 task.ti: cf42e000
> [    0.905312] PC is at kmem_cache_alloc+0x48/0x158
> [    0.909957] LR is at kmem_cache_alloc+0xb0/0x158
> [    0.914602] pc : [<c00cd530>]    lr : [<c00cd598>]    psr: 20000053
> [    0.914602] sp : cf42fde0  ip : c08b1dc4  fp : c0f577f0
> [    0.926099] r10: 000000e3  r9 : cf008170  r8 : c00ea328
> [    0.931342] r7 : 000005dd  r6 : 000000d0  r5 : 4b110208  r4 : cf401380
> [    0.937887] r3 : 00000200  r2 : 00000000  r1 : cf4403d8  r0 : 00000000
> [    0.944434] Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
> [    0.951851] Control: 0005317f  Table: 40004000  DAC: 00000017
> [    0.957617] Process swapper (pid: 1, stack limit = 0xcf42e1c0)
> [    0.963469] Stack: (0xcf42fde0 to 0xcf430000)
> [    0.967865] fde0: cf0fb730 cf008170 cf0fb904 cf0fb8a0 cf453000 cf0fb8a0 12400000 00008124
> [    0.976079] fe00: 000000e3 c00ea328 c0747a98 cf0fb8a0 cf0fb730 c00eb908 c0747a98 cf0fb8a0
> [    0.984293] fe20: cf0fb730 c00eb950 cf0fb8a0 c0272460 000361e8 00000002 c066a114 cf0fb8a0
> [    0.992506] fe40: cf0fb730 c066a114 12400000 000000e3 cf119c70 c0272610 c04fea2c 00000000
> [    1.000718] fe60: cf0fb76c cf4753c0 c066a114 c06954b8 c06437a8 c0f57868 cf42e000 c007959c
> [    1.008932] fe80: c04fea2c c02727b0 00000000 cf4753c0 c074a9f4 c008185c c04fea2c c06fdf58
> [    1.017143] fea0: cf59b9c0 c0f59e7c 00000000 c0f577f0 00000000 cf4753c0 c0f57870 c06fdf58
> [    1.025352] fec0: 00000000 cf42e000 00000000 c06fe0c4 00000004 00000001 00000000 c00cdbf0
> [    1.033565] fee0: c0739178 c0739178 c0739178 cf583a40 c077b3e0 c0008968 cf440000 c073d7c4
> [    1.041773] ff00: 00000000 00000004 00000000 cf440000 00000000 00000000 00000000 c004a944
> [    1.049985] ff20: cfffcd4e c0538174 0000007a c00310c8 00000001 c004aa54 c063be64 c06c916c
> [    1.058195] ff40: 00000005 00000005 c073d788 c072d7fc 00000005 c0727234 c077b3e0 c06f4514
> [    1.066408] ff60: 0000007a c0727244 00000000 c06f4c3c 00000005 00000005 c06f4514 0f534b59
> [    1.074616] ff80: 00000000 c04e9060 00000000 c04e9060 00000000 00000000 00000000 00000000
> [    1.082828] ffa0: 00000000 c04e9068 00000000 c00096e0 00000000 00000000 00000000 00000000
> [    1.091037] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.099247] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 4b596b7b 4b594f59
> [    1.107499] [<c00cd530>] (kmem_cache_alloc) from [<c00ea328>] (alloc_inode+0x54/0x9c)
> [    1.115383] [<c00ea328>] (alloc_inode) from [<c00eb908>] (new_inode_pseudo+0x8/0x40)
> [    1.123163] [<c00eb908>] (new_inode_pseudo) from [<c00eb950>] (new_inode+0x10/0x28)
> [    1.130873] [<c00eb950>] (new_inode) from [<c0272460>] (debugfs_mknod.part.12.constprop.15+0x1c/0x110)
> [    1.140227] [<c0272460>] (debugfs_mknod.part.12.constprop.15) from [<c0272610>] (__create_file+0xbc/0x1d4)
> [    1.149924] [<c0272610>] (__create_file) from [<c007959c>] (trace_create_file+0x18/0x40)
> [    1.158056] [<c007959c>] (trace_create_file) from [<c008185c>] (event_create_dir+0x13c/0x4d4)
> [    1.166622] [<c008185c>] (event_create_dir) from [<c06fe0c4>] (event_trace_init+0x16c/0x230)
> [    1.175098] [<c06fe0c4>] (event_trace_init) from [<c0008968>] (do_one_initcall+0x80/0x1cc)
> [    1.183403] [<c0008968>] (do_one_initcall) from [<c06f4c3c>] (kernel_init_freeable+0xec/0x1b4)
> [    1.192061] [<c06f4c3c>] (kernel_init_freeable) from [<c04e9068>] (kernel_init+0x8/0xe4)
> [    1.200192] [<c04e9068>] (kernel_init) from [<c00096e0>] (ret_from_fork+0x14/0x34)
> [    1.207796] Code: e5935000 e3550000 0a000023 e5943014 (e7951003) 
> [    1.214144] ---[ end trace 1cddfc6beabee6c4 ]---
> [    1.218869] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    1.218869] 
> [    1.228055] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    1.228055] 

In the old kernel[3] (based on Freescale's fork of 2.6.35), there was
some DRAM init code stuffed in arch/arm/mach-mx28, which Technologic
Systems patched to make it work.

Does anyone happen to know where in the mainline kernel this is done, if
at all?

Regards,
-- 
Stuart Longland
Systems Engineer
     _ ___
\  /|_) |                           T: +61 7 3535 9619
 \/ | \ |     38b Douglas Street    F: +61 7 3535 9699
   SYSTEMS    Milton QLD 4064       http://www.vrt.com.au

1. http://wiki.embeddedarm.com/wiki/TS-7670
2. http://wiki.embeddedarm.com/wiki/TS-7400-V2
3. https://github.com/embeddedarm/linux-2.6.35.3-imx28/tree/master/
