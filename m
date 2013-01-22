From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Tue, 22 Jan 2013 13:32:24 +0000
Subject: OMAP baseline test results for v3.8-rc4
In-Reply-To: <50FE66AC.2090306@mimc.co.uk>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
 <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
 <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
 <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
 <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
 <50FE66AC.2090306@mimc.co.uk>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECF3DD3@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 15:45:08, Mark Jackson wrote:
> On 22/01/13 02:24, Paul Walmsley wrote:
> > 
> > Hi guys,
> > 
> > Regarding the AM33xx test failures with appended DTBs, it would be very 
> > helpful if especially the TI people could try reproducing the problem.
> 
> My non-working setup (I'm using a recent U-Boot) is as follows ...
> 
> [Note that the DTB patch mentioned elsewhere in this thread seems to be *already* applied to -next]
> 
> $ git describe
> next-20130121
> $ make -j 8 ARCH=arm CROSS_COMPILE=arm-linux- omap2plus_defconfig
> $ make -j 8 ARCH=arm CROSS_COMPILE=arm-linux- menuconfig
> CONFIG_ARM_APPENDED_DTB=y
> CONFIG_ARM_ATAG_DTB_COMPAT=y
> CONFIG_EARLY_PRINTK=y
> $ make -j 8 ARCH=arm CROSS_COMPILE=arm-linux-
> $ cat arch/arm/boot/zImage arch/arm/boot/dtb/am335x-bone.dtb > arch/arm/boot/zImage-dtb.am335x-bone
> $ scripts/mkuboot.sh -A arm -O linux -C none -T kernel -a 0?80008000 -e 0?80008000 -n ?Linux? -d
> arch/arm/boot/zImage-dtb.am335x-bone arch/arm/boot/uImage-dtb.am335x-bone
> $ cp arch/arm/boot/uImage-dtb.am335x-bone /tftpboot/nanobone/uImage-dtb
> 
> And when I boot:-
> 
> U-Boot SPL 2013.01 (Jan 16 2013 - 15:20:58)
> OMAP SD/MMC: 0
> reading u-boot.img
> reading u-boot.img
> 
> 
> U-Boot 2013.01 (Jan 16 2013 - 15:20:58)
> 
> I2C:   ready
> DRAM:  256 MiB
> WARNING: Caches not enabled
> NAND:  No NAND device found!!!
> 0 MiB
> MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
> *** Warning - readenv() failed, using default environment
> 
> musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
> musb-hdrc: MHDRC RTL version 2.0
> musb-hdrc: setup fifo_mode 4
> musb-hdrc: 28/31 max ep, 16384/16384 memory
> USB Peripheral mode controller at 47401000 using PIO, IRQ 0
> musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
> musb-hdrc: MHDRC RTL version 2.0
> musb-hdrc: setup fifo_mode 4
> musb-hdrc: 28/31 max ep, 16384/16384 memory
> USB Host mode controller at 47401800 using PIO, IRQ 0
> Net:   cpsw, usb_ether
> Hit any key to stop autoboot:  0
> mmc0 is current device
> SD/MMC found on device 0
> reading uEnv.txt
> 167 bytes read in 3 ms (53.7 KiB/s)
> Loaded environment from uEnv.txt
> Importing environment from mmc ...
> Running uenvcmd ...
> cpsw Waiting for PHY auto negotiation to complete. done
> link up on port 0, speed 100, full duplex
> BOOTP broadcast 1
> BOOTP broadcast 2
> *** Unhandled DHCP Option in OFFER/ACK: 44
> *** Unhandled DHCP Option in OFFER/ACK: 46
> *** Unhandled DHCP Option in OFFER/ACK: 44
> *** Unhandled DHCP Option in OFFER/ACK: 46
> DHCP client bound to address 10.0.0.112
> Using cpsw device
> TFTP from server 10.0.0.100; our IP address is 10.0.0.112
> Filename '/nanobone/uImage-dtb'.
> Load address: 0x80000000
> Loading: #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          ###########
>          627.9 KiB/s
> done
> Bytes transferred = 3963919 (3c7c0f hex)
> ## Booting kernel from Legacy Image at 80000000 ...
>    Image Name:   Linux
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    3963855 Bytes = 3.8 MiB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
> 
> Starting kernel ...
> 
> 

Following works for me:

Kernel
===
git checkout next-20130122
make distclean
make omap2plus_defconfig
<Enable the appended DTB related options via menuconfig>
make -j7
cat arch/arm/boot/zImage arch/arm/boot/dts/am335x-bone.dtb > arch/arm/boot/zImage-dtb.am335x-bone
mkimage -A arm -O linux -C none -T kernel -a 0x80008000 -e 0x80008000 -n 'Linux' -d arch/arm/boot/zImage-dtb.am335x-bone arch/arm/boot/uImage-dtb.am335x-bone

U-Boot
===
Built from v2013.01

Bootlog
===
U-Boot SPL 2013.01 (Jan 22 2013 - 18:47:57)
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.img


U-Boot 2013.01 (Jan 22 2013 - 18:47:57)

I2C:   ready
DRAM:  256 MiB
WARNING: Caches not enabled
NAND:  No NAND device found!!!
0 MiB
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
*** Warning - readenv() failed, using default environment

musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
USB Peripheral mode controller at 47401000 using PIO, IRQ 0
musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
USB Host mode controller at 47401800 using PIO, IRQ 0
Net:   cpsw, usb_ether
Hit any key to stop autoboot:  0
U-Boot# setenv serverip 172.24.133.119
U-Boot# setenv bootfile uImage-dtb.am335x-bone
U-Boot# dhcp 80200000
link up on port 0, speed 100, full duplex
BOOTP broadcast 1
DHCP client bound to address 172.24.190.59
Using cpsw device
TFTP from server 172.24.133.119; our IP address is 172.24.190.59; sending through gateway 172.24.188.1
Filename 'uImage-dtb.am335x-bone'.
Load address: 0x80200000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         ##T ###############################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         ##########################################################
         183.6 KiB/s
done
Bytes transferred = 3956239 (3c5e0f hex)
U-Boot# setenv bootargs console=ttyO0,115200n8 debug ignore_loglevel earlyprintk=serial init=/bin/sh mem=128M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=65536
U-Boot# mmc rescan 0
U-Boot# fatload mmc 0 82000000 ramdisk-pm.gz
reading ramdisk-pm.gz
2022580 bytes read in 252 ms (7.7 MiB/s)
U-Boot# bootm 0x80200000
## Booting kernel from Legacy Image at 80200000 ...
   Image Name:   Linux
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3956175 Bytes = 3.8 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.8.0-rc4-next-20130122 (a0393953 at psplinux063) (gcc version 4.5.3 20110311 (prerelease) (GCC) ) #1 SMP Tue Jan 22 18:43:06 IST 2013
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI AM335x BeagleBone
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 32512
[    0.000000] free_area_init_node: node 0, pgdat c07d3ec0, node_mem_map c0d35000
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32512 pages, LIFO batch:7
[    0.000000] AM335X ES1.0 (neon )
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0e3d000 s13056 r8192 d15616 u36864
[    0.000000] pcpu-alloc: s13056 r8192 d15616 u36864 alloc=9*4096
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32256
[    0.000000] Kernel command line: console=ttyO0,115200n8 debug ignore_loglevel earlyprintk=serial init=/bin/sh mem=128M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=65536
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] Memory: 127MB = 127MB total
[    0.000000] Memory: 98944k/98944k available, 32128k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06e9880   (7047 kB)
[    0.000000]       .init : 0xc06ea000 - 0xc073e300   ( 337 kB)
[    0.000000]       .data : 0xc0740000 - 0xc07d6860   ( 603 kB)
[    0.000000]        .bss : 0xc07d6860 - 0xc0d317b0   (5484 kB)
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
[    0.001254] Calibrating delay loop... 364.48 BogoMIPS (lpj=1425408)
[    0.109085] pid_max: default: 32768 minimum: 301
[    0.109681] Security Framework initialized
[    0.109882] Mount-cache hash table entries: 512
[    0.121969] CPU: Testing write buffer coherency: ok
[    0.123774] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.123868] Setting up static identity map for 0x804ecd48 - 0x804ecdb8
[    0.127107] Brought up 1 CPUs
[    0.127140] SMP: Total of 1 processors activated (364.48 BogoMIPS).
[    0.130829] devtmpfs: initialized
[    0.146231] ttyO0 used as console in debug mode: uart0 clocks will not be gated
[    0.209016] pinctrl core: initialized pinctrl subsystem
[    0.216451] regulator-dummy: no parameters
[    0.219522] NET: Registered protocol family 16
[    0.220528] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.222118] omap-gpmc omap-gpmc: GPMC revision 6.0
[    0.251333] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.251927] OMAP GPIO hardware version 0.1
[    0.255800] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.259807] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.263355] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.278062] No ATAGs?
[    0.278097] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.282814] Serial: AMBA PL011 UART driver
[    0.361131] bio: create slab <bio-0> at 0
[    0.465566] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.476999] SCSI subsystem initialized
[    0.480100] usbcore: registered new interface driver usbfs
[    0.480733] usbcore: registered new interface driver hub
[    0.481725] usbcore: registered new device driver usb
[    0.484797] omap_i2c 44e0b000.i2c: did not get pins for i2c error: -19
[    0.487289] omap_i2c 44e0b000.i2c: bus 0 rev0.11 at 400 kHz
[    0.494498] DCDC1: at 1800 mV
[    0.497346] vdd_mpu: 925 <--> 1325 mV at 1275 mV
[    0.500720] vdd_core: 925 <--> 1150 mV at 1100 mV
[    0.503612] LDO1: at 1800 mV
[    0.506134] LDO2: at 3300 mV
[    0.509103] LDO3: at 3300 mV
[    0.511612] LDO4: at 3300 mV
[    0.513852] tps65217 0-0024: TPS65217 ID 0xf version 1.1
[    0.523930] Switching to clocksource gp_timer
[    0.692430] NET: Registered protocol family 2
[    0.694878] TCP established hash table entries: 1024 (order: 1, 8192 bytes)
[    0.695123] TCP bind hash table entries: 1024 (order: 3, 36864 bytes)
[    0.695757] TCP: Hash tables configured (established 1024 bind 1024)
[    0.696026] TCP: reno registered
[    0.696069] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.696653] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.697852] NET: Registered protocol family 1
[    0.699530] RPC: Registered named UNIX socket transport module.
[    0.699559] RPC: Registered udp transport module.
[    0.699576] RPC: Registered tcp transport module.
[    0.699592] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.700848] Trying to unpack rootfs image as initramfs...
[    0.703450] rootfs image is not initramfs (no cpio magic); looks like an initrd
[    0.841357] Freeing initrd memory: 16384K
[    0.841625] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.842474] CPU PMU: probing PMU on CPU 0
[    0.842520] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, 5 counters available
[    1.054500] VFS: Disk quotas dquot_6.5.2
[    1.054811] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.058444] NFS: Registering the id_resolver key type
[    1.059059] Key type id_resolver registered
[    1.059089] Key type id_legacy registered
[    1.059272] jffs2: version 2.2. (NAND) (SUMMARY)  ?? 2001-2006 Red Hat, Inc.
[    1.059967] msgmni has been set to 225
[    1.064654] io scheduler noop registered
[    1.064688] io scheduler deadline registered
[    1.064811] io scheduler cfq registered (default)
[    1.066454] pinctrl-single 44e10800.pinmux: 142 pins at pa f9e10800 size 568
[    1.072242] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.081518] omap_uart 44e09000.serial: did not get pins for uart0 error: -19
[    1.082185] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 88) is a OMAP UART0
[    1.810770] console [ttyO0] enabled
[    1.857842] brd: module loaded
[    1.888668] loop: module loaded
[    1.898978] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.907161] OneNAND driver initializing
[    1.919778] usbcore: registered new interface driver asix
[    1.926317] usbcore: registered new interface driver cdc_ether
[    1.933710] usbcore: registered new interface driver smsc95xx
[    1.940554] usbcore: registered new interface driver net1080
[    1.947405] usbcore: registered new interface driver cdc_subset
[    1.954393] usbcore: registered new interface driver zaurus
[    1.960925] usbcore: registered new interface driver cdc_ncm
[    1.970109] usbcore: registered new interface driver cdc_wdm
[    1.976072] Initializing USB Mass Storage driver...
[    1.982138] usbcore: registered new interface driver usb-storage
[    1.988616] USB Mass Storage support registered.
[    1.994334] usbcore: registered new interface driver usbtest
[    2.003751] mousedev: PS/2 mouse device common for all mice
[    2.014783] i2c /dev entries driver
[    2.021637] Driver for 1-wire Dallas network protocol.
[    2.033754] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60 sec
[    2.048194] usbcore: registered new interface driver usbhid
[    2.054080] usbhid: USB HID core driver
[    2.059877] oprofile: using arm/armv7
[    2.065057] TCP: cubic registered
[    2.068566] Initializing XFRM netlink socket
[    2.073446] NET: Registered protocol family 17
[    2.078271] NET: Registered protocol family 15
[    2.083554] Key type dns_resolver registered
[    2.088379] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
[    2.096622] ThumbEE CPU extension supported.
[    2.173009] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6
[    2.179436] davinci_mdio 4a101000.mdio: detected phy mask fffffffe
[    2.189615] libphy: 4a101000.mdio: probed
[    2.193878] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver SMSC LAN8710/LAN8720
[    2.204140] Random MACID = ca:fe:8a:07:ba:03
[    2.214820] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    2.226373] RAMDISK: gzip image found at block 0
[    2.691956] VFS: Mounted root (ext2 filesystem) on device 1:0.
[    2.699599] devtmpfs: mounted
[    2.703581] Freeing init memory: 336K
/bin/sh: can't access????oR?????????????.????VH?        ??
/ #

A dumb question... in your case what's the bootargs set? Note that the mainline
kernel for AM335x doesn't have MMC support yet and the default bootargs is set to
rootfs on MMC.

Regards,
Vaibhav
