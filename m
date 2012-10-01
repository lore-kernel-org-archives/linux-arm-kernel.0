From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Mon, 1 Oct 2012 12:27:17 +0530
Subject: Booting vanilla kernel on the beaglebone
In-Reply-To: <20120930082802.GA15392@netboy.at.omicron.at>
References: <20120930082802.GA15392@netboy.at.omicron.at>
Message-ID: <50693ECD.4000000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/30/2012 1:58 PM, Richard Cochran wrote:
> 
> I just received by very own beaglebone, and I would like to add PTP
> hardware clock support for the CPTS unit, but I naturally want to do
> this with the latest mainstream kernel and not the hacked up arago 3.2
> kernel that ships with the board.
> 
> Does any vanilla kernel even boot on this board?
> If so, which ones, and how?
> 
> I have tried a few variations of kernel/u-boot without any luck.
> The u-boot that came with the board is
> 
>   U-Boot 2011.09-00000-gf63b270-dirty (Apr 24 2012 - 09:51:01)
>   arm-angstrom-linux-gnueabi-gcc (GCC) 4.5.4 20120305 (prerelease)
>   GNU ld (GNU Binutils) 2.20.1.20100303
> 
> and I also tried the latest version:
> 
>   U-Boot 2012.10-rc1-00148-g4668a08 (Sep 30 2012 - 09:35:20)
>   arm-none-linux-gnueabi-gcc (Sourcery G++ Lite 2009q1-203) 4.3.3
>   GNU ld (Sourcery G++ Lite 2009q1-203) 2.19.51.20090205
> 

Mainline u-boot boots up fine on BeagleBone, I just tried it on my Bone
(A5 version)

U-Boot SPL 2012.10-rc1-00148-g4668a08 (Oct 01 2012 - 11:34:06)
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.img


U-Boot 2012.10-rc1-00148-g4668a08 (Oct 01 2012 - 11:34:06)

I2C:   ready
DRAM:  256 MiB
WARNING: Caches not enabled
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
Using default environment

Net:   cpsw
Hit any key to stop autoboot:  0
U-Boot#


As far as kernel is concerned, All the required patches have been merged
for v3.7, so if you use linux-next/master branch, you should be able to
boot without any issues. You just need to apply one minor patch which is
left behind - https://patchwork.kernel.org/patch/1499411/

I have just tested it to cross-check and it boots up fine with
linux-next/master branch. I have pasted boot log below for your reference.



U-Boot#
U-Boot# mmc rescan 0
U-Boot# fatload mmc 0 80000000 am335x-evm.dtb
reading am335x-evm.dtb

5172 bytes read
U-Boot# fatload mmc 0 81000000 uImage
reading uImage

3835400 bytes read
U-Boot# fatload mmc 0 82000000 ramdisk-pm.gz
reading ramdisk-pm.gz

2022580 bytes read
U-Boot# setenv bootargs console=ttyO0,115200n8 mem=256M root=/dev/ram rw
initrd=0x82000000,16MB ramdisk_size=65536 earlyprintk=serial
U-Boot# bootm 81000000 - 80000000
## Booting kernel from Legacy Image at 81000000 ...
   Image Name:   Linux-3.6.0-rc7-next-20120928-00
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3835336 Bytes = 3.7 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 80000000
   Booting using the fdt blob at 0x80000000
   Loading Kernel Image ... OK
OK
   Loading Device Tree to 8fe67000, end 8fe6b433 ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.6.0-rc7-next-20120928-00001-g820ede3
(a0393758 at psplinux064) (gcc version 4.5.3 20110311 (prerelease) (GCC) )
#2 SMP Mon Oct 1 12:10:14 IST 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7),
cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model:
TI AM335x EVM
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] AM335X ES1.0 (neon )
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0eff000 s12928 r8192
d15744 u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 64768
[    0.000000] Kernel command line: console=ttyO0,115200n8 mem=256M
root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=65536
earlyprintk=serial
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072
bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 255MB = 255MB total
[    0.000000] Memory: 229120k/229120k available, 33024k reserved, 0K
highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06c09a0   (6883 kB)
[    0.000000]       .init : 0xc06c1000 - 0xc0711280   ( 321 kB)
[    0.000000]       .data : 0xc0712000 - 0xc079bdf0   ( 552 kB)
[    0.000000]        .bss : 0xc079be14 - 0xc0cf67f4   (5483 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=2 to nr_cpu_ids=1.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128
interrupts
[    0.000000] Total of 128 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 24000000 Hz
[    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps
every 178956ms
[    0.000000] OMAP clocksource: GPTIMER2 at 24000000 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.001114] Calibrating delay loop... 364.48 BogoMIPS (lpj=1425408)
[    0.107577] pid_max: default: 32768 minimum: 301
[    0.108244] Security Framework initialized
[    0.108450] Mount-cache hash table entries: 512
[    0.119655] CPU: Testing write buffer coherency: ok
[    0.120768] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.120857] Setting up static identity map for 0x804d25a0 - 0x804d2610
[    0.124171] Brought up 1 CPUs
[    0.124204] SMP: Total of 1 processors activated (364.48 BogoMIPS).
[    0.148451] pinctrl core: initialized pinctrl subsystem
[    0.156712] regulator-dummy: no parameters
[    0.159226] NET: Registered protocol family 16
[    0.160198] DMA: preallocated 256 KiB pool for atomic coherent
allocations
[    0.160221] ------------[ cut here ]------------
[    0.160262] WARNING: at arch/arm/mach-omap2/gpmc.c:866
gpmc_init+0x24c/0x294()
[    0.160277] Modules linked in:
[    0.160338] [<c001af1c>] (unwind_backtrace+0x0/0xf0) from
[<c0041690>] (warn_slowpath_common+0x4c/0x64)
[    0.160367] [<c0041690>] (warn_slowpath_common+0x4c/0x64) from
[<c00416c4>] (warn_slowpath_null+0x1c/0x24)
[    0.160392] [<c00416c4>] (warn_slowpath_null+0x1c/0x24) from
[<c06cb24c>] (gpmc_init+0x24c/0x294)
[    0.160420] [<c06cb24c>] (gpmc_init+0x24c/0x294) from [<c0008774>]
(do_one_initcall+0x34/0x180)
[    0.160449] [<c0008774>] (do_one_initcall+0x34/0x180) from
[<c06c18f8>] (kernel_init+0xfc/0x1cc)
[    0.160486] [<c06c18f8>] (kernel_init+0xfc/0x1cc) from [<c0013460>]
(ret_from_kernel_thread+0x10/0x18)
[    0.160731] ---[ end trace 1b75b31a2719ed1c ]---
[    0.189123] OMAP GPIO hardware version 0.1
[    0.205603] No ATAGs?
[    0.205632] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.291385] bio: create slab <bio-0> at 0
[    0.397985] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.399616] vbat: 5000 mV
[    0.407763] SCSI subsystem initialized
[    0.410699] usbcore: registered new interface driver usbfs
[    0.411336] usbcore: registered new interface driver hub
[    0.412976] usbcore: registered new device driver usb
[    0.418185] omap_i2c 44e0b000.i2c: bus 0 rev2.4.0 at 400 kHz
[    0.430606] Switching to clocksource gp_timer
[    0.586397] NET: Registered protocol family 2
[    0.589163] TCP established hash table entries: 8192 (order: 4, 65536
bytes)
[    0.589666] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.594582] TCP: Hash tables configured (established 8192 bind 8192)
[    0.594874] TCP: reno registered
[    0.594915] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.595365] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.596388] NET: Registered protocol family 1
[    0.598087] RPC: Registered named UNIX socket transport module.
[    0.598116] RPC: Registered udp transport module.
[    0.598132] RPC: Registered tcp transport module.
[    0.598148] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.599356] Trying to unpack rootfs image as initramfs...
[    0.601938] rootfs image is not initramfs (no cpio magic); looks like
an initrd
[    0.742658] Freeing initrd memory: 16384K
[    0.742860] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.948778] VFS: Disk quotas dquot_6.5.2
[    0.949078] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.952492] NFS: Registering the id_resolver key type
[    0.953097] Key type id_resolver registered
[    0.953128] Key type id_legacy registered
[    0.953331] jffs2: version 2.2. (NAND) (SUMMARY)  ? 2001-2006 Red
Hat, Inc.
[    0.954050] msgmni has been set to 479
[    0.958799] io scheduler noop registered
[    0.958833] io scheduler deadline registered
[    0.958931] io scheduler cfq registered (default)
[    0.962805] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.970634] omap_uart 44e09000.serial: did not get pins for uart0
error: -19
[    0.971303] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 88) is a
OMAP UART0
[    1.629186] console [ttyO0] enabled
[    1.671775] brd: module loaded
[    1.700068] loop: module loaded
[    1.710335] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.719012] OneNAND driver initializing
[    1.730808] usbcore: registered new interface driver asix
[    1.737454] usbcore: registered new interface driver cdc_ether
[    1.744674] usbcore: registered new interface driver smsc95xx
[    1.751319] usbcore: registered new interface driver net1080
[    1.758157] usbcore: registered new interface driver cdc_subset
[    1.765191] usbcore: registered new interface driver zaurus
[    1.771989] usbcore: registered new interface driver cdc_ncm
[    1.780711] usbcore: registered new interface driver cdc_wdm
[    1.786876] Initializing USB Mass Storage driver...
[    1.792825] usbcore: registered new interface driver usb-storage
[    1.799313] USB Mass Storage support registered.
[    1.804890] usbcore: registered new interface driver usbtest
[    1.812962] mousedev: PS/2 mouse device common for all mice
[    1.824234] i2c /dev entries driver
[    1.830793] Driver for 1-wire Dallas network protocol.
[    1.840350] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout
60 sec
[    1.854020] usbcore: registered new interface driver usbhid
[    1.859914] usbhid: USB HID core driver
[    1.865820] oprofile: no performance counters
[    1.873548] oprofile: using timer interrupt.
[    1.879162] TCP: cubic registered
[    1.882682] Initializing XFRM netlink socket
[    1.887434] NET: Registered protocol family 17
[    1.892324] NET: Registered protocol family 15
[    1.897507] Key type dns_resolver registered
[    1.902263] VFP support v0.3: implementor 41 architecture 3 part 30
variant c rev 3
[    1.910520] ThumbEE CPU extension supported.
[    1.927674] clock: disabling unused clocks to save power
[    1.941037] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    1.951940] RAMDISK: gzip image found at block 0
[    2.424389] VFS: Mounted root (ext2 filesystem) on device 1:0.
[    2.431470] Freeing init memory: 320K
mount: mounting none on /var/shm failed: No such file or directory
  ::
  :: Enabling hot-plug  : [SUCCESS]
  ::
  ::
   : Populating /dev    : [SUCCESS]
[SUCCESS]
  ::
  ::
  :: Setting PATH
  ::
   : syslogd            : [SUCCESS]
   : telnetd            : [SUCCESS]

Please press Enter to activate this console.
  ::
  :: Setting shell environment ...
  ::
   : Path
   : Aliases
   : Touch Screen
  ::
  :: Done
  ::
[root at arago /]#

> Thanks,
> Richard
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
