From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 9 Oct 2012 12:17:45 +0000
Subject: Booting vanilla kernel on the beaglebone
In-Reply-To: <20121009114326.GA4511@netboy.at.omicron.at>
References: <20120930082802.GA15392@netboy.at.omicron.at>
 <50693ECD.4000000@ti.com> <20121008191657.GA3281@netboy.at.omicron.at>
 <79CD15C6BA57404B839C016229A409A83EB39685@DBDE01.ent.ti.com>
 <20121009110049.GB2274@netboy.at.omicron.at>
 <79CD15C6BA57404B839C016229A409A83EB39D66@DBDE01.ent.ti.com>
 <20121009114326.GA4511@netboy.at.omicron.at>
Message-ID: <79CD15C6BA57404B839C016229A409A83EB39F42@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 17:13:26, Richard Cochran wrote:
> On Tue, Oct 09, 2012 at 11:19:28AM +0000, Hiremath, Vaibhav wrote:
> > On Tue, Oct 09, 2012 at 16:30:50, Richard Cochran wrote:
> > > On Tue, Oct 09, 2012 at 05:57:22AM +0000, Hiremath, Vaibhav wrote:
> > > > 
> > > > I use omap2plus_defconfig + CONFIG_ARM_APPENDED_DTB + CONFIG_ARM_ATAG_DTB_COMPAT and nothing more.
> > >                                          ^
> > > -----------------------------------------+  ???
> > > 
> > > But in the u-boot console example you post, you load the dtb into
> > > memory.
> > > 
> > 
> > Its standard mechanism to boot kernel with DT and it is nothing to do 
> > with .config. as mentioned before I have already submitted patch to add dtb 
> > target to 'make dtbs'.
> 
> You say that you use CONFIG_ARM_APPENDED_DTB, which means:
> 
>    CONFIG_ARM_APPENDED_DTB:
>    
>    With this option, the boot code will look for a device tree binary
>    (DTB) appended to zImage
>    (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
>    
>    This is meant as a backward compatibility convenience for those
>    systems with a bootloader that can't be upgraded to accommodate
>    the documented boot protocol using a device tree. 
> 
> But in the example you gave, you seem to load the dtb in the "normal"
> way, with a dtb-aware u-boot.
> 

You don't need this, I just explained what I am doing to boot it.
As I have my own old patch which enabled these two option in 
omap2plus_defconfig, which I just carry-forward everytime. 

I just tried with plain vanilla omap2plus_defconfig and it works for me.
Below is the log -


> So how do you boot this? With the APPENDED hack? Or just using a
> recent u-boot?
> 

Just with recent u-boot.

Thanks,
Vaibhav


Log -
==========================================
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
U-Boot#
U-Boot#
U-Boot#
U-Boot#
U-Boot# mmc rescan 0
U-Boot# fatload mmc 0 80000000 am335x-bone.dtb
reading am335x-bone.dtb

4391 bytes read
U-Boot# fatload mmc 0 81000000 uImage
reading uImage

3821560 bytes read
U-Boot# fatload mmc 0 82000000 ramdisk-pm.gz
reading ramdisk-pm.gz

2022580 bytes read
U-Boot# setenv bootargs console=ttyO0,115200n8 mem=256M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=65536 earlyprintk=serial
U-Boot# bootm 81000000 - 80000000
## Booting kernel from Legacy Image at 81000000 ...
   Image Name:   Linux-3.6.0-08931-g68ff7e3
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3821496 Bytes = 3.6 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 80000000
   Booting using the fdt blob at 0x80000000
   Loading Kernel Image ... OK
OK
   Loading Device Tree to 8fe67000, end 8fe6b126 ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.6.0-08931-g68ff7e3 (a0393758 at psplinux064) (gcc version 4.5.3 20110311 (prerelease) (GCC) ) #1 SMP Tue Oct 9 17:44:06 IST 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI AM335x BeagleBone
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] AM335X ES1.0 (neon )
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0efb000 s12864 r8192 d15808 u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64768
[    0.000000] Kernel command line: console=ttyO0,115200n8 mem=256M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=65536 earlyprintk=serial
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 255MB = 255MB total
[    0.000000] Memory: 229144k/229144k available, 33000k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06bb85c   (6863 kB)
[    0.000000]       .init : 0xc06bc000 - 0xc070c240   ( 321 kB)
[    0.000000]       .data : 0xc070e000 - 0xc0798ee8   ( 556 kB)
[    0.000000]        .bss : 0xc0798f0c - 0xc0cf3ab4   (5483 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=2 to nr_cpu_ids=1.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 interrupts
[    0.000000] Total of 128 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 24000000 Hz
[    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
[    0.000000] OMAP clocksource: GPTIMER2 at 24000000 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.001121] Calibrating delay loop... 364.48 BogoMIPS (lpj=1425408)
[    0.107577] pid_max: default: 32768 minimum: 301
[    0.108250] Security Framework initialized
[    0.108458] Mount-cache hash table entries: 512
[    0.118652] CPU: Testing write buffer coherency: ok
[    0.119785] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.119871] Setting up static identity map for 0x804ce298 - 0x804ce308
[    0.123042] Brought up 1 CPUs
[    0.123073] SMP: Total of 1 processors activated (364.48 BogoMIPS).
[    0.147724] pinctrl core: initialized pinctrl subsystem
[    0.156016] regulator-dummy: no parameters
[    0.158598] NET: Registered protocol family 16
[    0.159557] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.188486] OMAP GPIO hardware version 0.1
[    0.204625] No ATAGs?
[    0.204654] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.293226] bio: create slab <bio-0> at 0
[    0.402131] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.410001] SCSI subsystem initialized
[    0.413623] usbcore: registered new interface driver usbfs
[    0.414290] usbcore: registered new interface driver hub
[    0.415345] usbcore: registered new device driver usb
[    0.428831] omap_i2c 44e0b000.i2c: bus -1 rev2.4.0 at 400 kHz
[    0.441955] Switching to clocksource gp_timer
[    0.597129] NET: Registered protocol family 2
[    0.599927] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    0.600427] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.605341] TCP: Hash tables configured (established 8192 bind 8192)
[    0.605634] TCP: reno registered
[    0.605675] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.606032] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.607195] NET: Registered protocol family 1
[    0.608857] RPC: Registered named UNIX socket transport module.
[    0.608886] RPC: Registered udp transport module.
[    0.608903] RPC: Registered tcp transport module.
[    0.608919] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.610122] Trying to unpack rootfs image as initramfs...
[    0.612685] rootfs image is not initramfs (no cpio magic); looks like an initrd
[    0.770993] Freeing initrd memory: 16384K
[    0.771185] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.771821] CPU PMU: probing PMU on CPU 0
[    0.772051] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, 5 counters available
[    0.978472] VFS: Disk quotas dquot_6.5.2
[    0.978772] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.982461] NFS: Registering the id_resolver key type
[    0.983116] Key type id_resolver registered
[    0.983149] Key type id_legacy registered
[    0.983331] jffs2: version 2.2. (NAND) (SUMMARY)  (c) 2001-2006 Red Hat, Inc.
[    0.984069] msgmni has been set to 479
[    0.988653] io scheduler noop registered
[    0.988684] io scheduler deadline registered
[    0.988807] io scheduler cfq registered (default)
[    0.992666] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.000595] omap_uart 44e09000.serial: did not get pins for uart0 error: -19
[    1.001443] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 88) is a OMAP UART0
[    1.588108] console [ttyO0] enabled
[    1.632137] brd: module loaded
[    1.660230] loop: module loaded
[    1.671413] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.679560] OneNAND driver initializing
[    1.691146] usbcore: registered new interface driver asix
[    1.697852] usbcore: registered new interface driver cdc_ether
[    1.704944] usbcore: registered new interface driver smsc95xx
[    1.712108] usbcore: registered new interface driver net1080
[    1.718868] usbcore: registered new interface driver cdc_subset
[    1.725905] usbcore: registered new interface driver zaurus
[    1.732737] usbcore: registered new interface driver cdc_ncm
[    1.741523] usbcore: registered new interface driver cdc_wdm
[    1.747679] Initializing USB Mass Storage driver...
[    1.753595] usbcore: registered new interface driver usb-storage
[    1.760096] USB Mass Storage support registered.
[    1.765753] usbcore: registered new interface driver usbtest
[    1.773851] mousedev: PS/2 mouse device common for all mice
[    1.784873] i2c /dev entries driver
[    1.791403] Driver for 1-wire Dallas network protocol.
[    1.801002] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60 sec
[    1.814741] usbcore: registered new interface driver usbhid
[    1.820899] usbhid: USB HID core driver
[    1.826796] oprofile: using arm/armv7
[    1.831661] TCP: cubic registered
[    1.835441] Initializing XFRM netlink socket
[    1.840124] NET: Registered protocol family 17
[    1.845000] NET: Registered protocol family 15
[    1.850236] Key type dns_resolver registered
[    1.854894] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
[    1.863150] ThumbEE CPU extension supported.
[    1.880211] clock: disabling unused clocks to save power
[    1.893851] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    1.904775] RAMDISK: gzip image found at block 0
[    2.373495] VFS: Mounted root (ext2 filesystem) on device 1:0.
[    2.380564] Freeing init memory: 320K
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
