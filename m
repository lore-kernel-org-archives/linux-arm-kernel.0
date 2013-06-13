From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Thu, 13 Jun 2013 04:46:11 +0000
Subject: [PATCH 13/14] ARM: AM33XX: hwmod data: irq, dma and addr info
 clean up
In-Reply-To: <87mwqvar92.fsf@linaro.org>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com>
 <1369845494-30231-14-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.02.1306060355320.15042@utopia.booyaka.com>
 <87zjv2ooxi.fsf@linaro.org> <51B58FE9.5040309@ti.com>
 <877gi1ew3r.fsf@linaro.org> <51B6A43C.10301@ti.com>
 <79CD15C6BA57404B839C016229A409A83ECAF76E@DBDE04.ent.ti.com>
 <87mwqvar92.fsf@linaro.org>
Message-ID: <79CD15C6BA57404B839C016229A409A83ECB31C3@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at linaro.org]
> Sent: Thursday, June 13, 2013 4:09 AM
> To: Hiremath, Vaibhav
> Cc: Vutla, Lokesh; Paul Walmsley; Shilimkar, Santosh; tony at atomide.com;
> linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org; R,
> Sricharan; Nayak, Rajendra
> Subject: Re: [PATCH 13/14] ARM: AM33XX: hwmod data: irq, dma and addr
> info clean up
> 
> Hi Vaibhav,
> 
> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
> 
> [...]
> 
> > Paul/Kevin/Santosh,
> >
> > AM335x is booting up from Mainline, starting from v3.7, that?s where
> HWMOD data got merged to
> > Mainline.
> >
> > We have discussed on this in the past as well, let me explain the
> issue here in detail
> > again for everybody -
> 
> Thanks for the detail.
> 
> In my case, after more debug, it appears that where I was putting the
> DTB in memory from u-boot was not working.   Using the addresses you
> used gets things working again.  Thanks.
> 
> u-boot mainline (v2013.04) for BeagleBone has defaults that don't work
> appear together:
> 
> U-Boot# printenv loadaddr
> loadaddr=0x80200000
> U-Boot# printenv fdtaddr
> fdtaddr=0x80F80000
> 

I tried above address and it is booting up for me, below is the log for your reference -


Boot LOG:
=========================================

U-Boot SPL 2013.04-00274-ga71d45d (Jun 12 2013 - 10:54:45)
musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
USB Peripheral mode controller at 47401000 using PIO, IRQ 0
musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
USB Host mode controller at 47401800 using PIO, IRQ 0
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.img


U-Boot 2013.04-00274-ga71d45d (Jun 12 2013 - 10:54:45)

I2C:   ready
DRAM:  512 MiB
WARNING: Caches not enabled
NAND:  No NAND device found!!!
0 MiB
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
*** Warning - readenv() failed, using default environment

musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
USB Peripheral mode controller at 47401000 using PIO, IRQ 0
musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
USB Host mode controller at 47401800 using PIO, IRQ 0
Net:   <ethaddr> not set. Validating first E-fuse MAC
cpsw, usb_ether
Hit any key to stop autoboot:  0
U-Boot#
U-Boot#
U-Boot#
U-Boot#
U-Boot#
U-Boot#
U-Boot# mmc rescan
U-Boot# fatload mmc 0 0x80F80000 am335x-bone.dtb
reading am335x-bone.dtb
8865 bytes read in 6 ms (1.4 MiB/s)
U-Boot# fatload mmc 0 0x80200000 uImage
reading uImage
4044224 bytes read in 464 ms (8.3 MiB/s)
U-Boot# fatload mmc 0 82000000 ramdisk-pm.gz
reading ramdisk-pm.gz
2022580 bytes read in 235 ms (8.2 MiB/s)
U-Boot# setenv bootargs console=ttyO0,115200n8 mem=256M root=/dev/ram rw initrd=0x82000000,32MB ramdisk_size=65536 earlyprintk=serial omap_wdt.nowayout=60
U-Boot# bootm 0x80200000 - 0x80F80000
## Booting kernel from Legacy Image at 80200000 ...
   Image Name:   Linux-3.10.0-rc5-00054-g75da4e1
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    4044160 Bytes = 3.9 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 80f80000
   Booting using the fdt blob at 0x80f80000
   Loading Kernel Image ... OK
OK
   Using Device Tree in place at 80f80000, end 80f852a0

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.10.0-rc5-00054-g75da4e1 (a0393758 at psplinux064) (gcc version 4.5.3 20110311 (prerelease) (GCC) ) #1 SMP Wed Jun 12 10:51:03 IST 2013
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI AM335x BeagleBone
[    0.000000] cma: CMA: reserved 16 MiB at 8e800000
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] AM335X ES2.0 (neon )
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0f83000 s13632 r8192 d15040 u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64768
[    0.000000] Kernel command line: console=ttyO0,115200n8 mem=256M root=/dev/ram rw initrd=0x82000000,32MB ramdisk_size=65536 earlyprintk=serial omap_wdt.nowayout=60
[    0.000000] Booting kernel: `60' invalid for parameter `omap_wdt.nowayout'
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 255MB = 255MB total
[    0.000000] Memory: 195812k/195812k available, 66332k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0717e40   (7232 kB)
[    0.000000]       .init : 0xc0718000 - 0xc077a540   ( 394 kB)
[    0.000000]       .data : 0xc077c000 - 0xc0812748   ( 602 kB)
[    0.000000]        .bss : 0xc0812748 - 0xc0d76b98   (5522 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=2 to nr_cpu_ids=1.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 interrupts
[    0.000000] Total of 128 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: timer2 at 24000000 Hz
[    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
[    0.000000] OMAP clocksource: timer1 at 24000000 Hz
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
[    0.001358] Calibrating delay loop... 363.72 BogoMIPS (lpj=1818624)
[    0.119593] pid_max: default: 32768 minimum: 301
[    0.120264] Security Framework initialized
[    0.120460] Mount-cache hash table entries: 512
[    0.134531] CPU: Testing write buffer coherency: ok
[    0.136519] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.136607] Setting up static identity map for 0xc0504ff8 - 0xc0505068
[    0.140793] Brought up 1 CPUs
[    0.140823] SMP: Total of 1 processors activated (363.72 BogoMIPS).
[    0.140838] CPU: All CPU(s) started in SVC mode.
[    0.145003] devtmpfs: initialized
[    0.166693] omap_hwmod: debugss: _wait_target_disable failed
[    0.230142] pinctrl core: initialized pinctrl subsystem
[    0.236351] regulator-dummy: no parameters
[    0.241091] NET: Registered protocol family 16
[    0.251936] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.282410] OMAP GPIO hardware version 0.1
[    0.312014] No ATAGs?
[    0.312046] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.398189] bio: create slab <bio-0> at 0
[    0.412467] SCSI subsystem initialized
[    0.415411] usbcore: registered new interface driver usbfs
[    0.416049] usbcore: registered new interface driver hub
[    0.417035] usbcore: registered new device driver usb
[    0.419839] omap_i2c 44e0b000.i2c: could not find pctldev for node /pinmux at 44e10800/pinmux_i2c0_pins, deferring probe
[    0.419903] platform 44e0b000.i2c: Driver omap_i2c requests probe deferral
[    0.430813] Switching to clocksource timer1
[    0.619592] NET: Registered protocol family 2
[    0.622548] TCP established hash table entries: 2048 (order: 2, 16384 bytes)
[    0.622830] TCP bind hash table entries: 2048 (order: 4, 73728 bytes)
[    0.624078] TCP: Hash tables configured (established 2048 bind 2048)
[    0.624356] TCP: reno registered
[    0.624402] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.624748] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.626623] NET: Registered protocol family 1
[    0.629144] RPC: Registered named UNIX socket transport module.
[    0.629176] RPC: Registered udp transport module.
[    0.629192] RPC: Registered tcp transport module.
[    0.629209] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.630501] Trying to unpack rootfs image as initramfs...
[    0.633407] rootfs image is not initramfs (no cpio magic); looks like an initrd
[    0.929698] Freeing initrd memory: 32768K (c2000000 - c4000000)
[    0.929929] NetWinder Floating Point Emulator V0.97 (double precision)
[    1.191112] VFS: Disk quotas dquot_6.5.2
[    1.191622] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.195187] NFS: Registering the id_resolver key type
[    1.195835] Key type id_resolver registered
[    1.195867] Key type id_legacy registered
[    1.196055] jffs2: version 2.2. (NAND) (SUMMARY)  ? 2001-2006 Red Hat, Inc.
[    1.196790] msgmni has been set to 478
[    1.201528] io scheduler noop registered
[    1.201559] io scheduler deadline registered
[    1.201659] io scheduler cfq registered (default)
[    1.203470] pinctrl-single 44e10800.pinmux: 142 pins at pa f9e10800 size 568
[    1.209102] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.219674] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 88) is a OMAP UART0
[    1.834393] console [ttyO0] enabled
[    1.882450] brd: module loaded
[    1.910319] loop: module loaded
[    1.921131] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.939745] usbcore: registered new interface driver asix
[    1.946692] usbcore: registered new interface driver ax88179_178a
[    1.954307] usbcore: registered new interface driver cdc_ether
[    1.961165] usbcore: registered new interface driver smsc95xx
[    1.967981] usbcore: registered new interface driver net1080
[    1.974853] usbcore: registered new interface driver cdc_subset
[    1.981820] usbcore: registered new interface driver zaurus
[    1.988373] usbcore: registered new interface driver cdc_ncm
[    1.997216] usbcore: registered new interface driver cdc_wdm
[    2.004100] usbcore: registered new interface driver usb-storage
[    2.011102] usbcore: registered new interface driver usbtest
[    2.020244] mousedev: PS/2 mouse device common for all mice
[    2.034865] omap_rtc 44e3e000.rtc: rtc core: registered 44e3e000.rtc as rtc0
[    2.043174] 44e3e000.rtc: already running
[    2.049525] i2c /dev entries driver
[    2.054310] Driver for 1-wire Dallas network protocol.
[    2.065743] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60 sec
[    2.085316] ledtrig-cpu: registered to indicate activity on CPUs
[    2.094003] usbcore: registered new interface driver usbhid
[    2.099879] usbhid: USB HID core driver
[    2.106188] oprofile: no performance counters
[    2.114316] oprofile: using timer interrupt.
[    2.119754] TCP: cubic registered
[    2.123467] Initializing XFRM netlink socket
[    2.128168] NET: Registered protocol family 17
[    2.133042] NET: Registered protocol family 15
[    2.138255] Key type dns_resolver registered
[    2.143036] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
[    2.151220] ThumbEE CPU extension supported.
[    2.168166] omap_i2c 44e0b000.i2c: bus 0 rev0.11 at 400 kHz
[    2.183328] DCDC1: at 1500 mV
[    2.189549] vdd_mpu: 925 <--> 1325 mV at 1100 mV
[    2.197934] vdd_core: 925 <--> 1150 mV at 1100 mV
[    2.205976] LDO1: at 1800 mV
[    2.212226] LDO2: at 3300 mV
[    2.218164] LDO3: at 1800 mV
[    2.224240] LDO4: at 3300 mV
[    2.230065] tps65217 0-0024: TPS65217 ID 0xe version 1.2
[    2.301467] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6
[    2.307911] davinci_mdio 4a101000.mdio: detected phy mask fffffffe
[    2.318069] libphy: 4a101000.mdio: probed
[    2.322476] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver SMSC LAN8710/LAN8720
[    2.332671] Random MACID = d2:be:d7:26:fb:7e
[    2.343346] omap_rtc 44e3e000.rtc: setting system clock to 2000-01-01 23:13:33 UTC (946768413)
[    2.357708] RAMDISK: gzip image found at block 0
[    2.854280] VFS: Mounted root (ext2 filesystem) on device 1:0.
[    2.861960] devtmpfs: mounted
[    2.866023] Freeing unused kernel memory: 392K (c0718000 - c077a000)
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
[root at arago /]#
[root at arago /]# zcat /proc/config.gz | grep -r ATAG
CONFIG_ATAGS=y
CONFIG_ATAGS_PROC=y
[root at arago /]#
[root at arago /]# zcat /proc/config.gz | grep -r APPEND
# CONFIG_ARM_APPENDED_DTB is not set
[root at arago /]#
[root at arago /]#
