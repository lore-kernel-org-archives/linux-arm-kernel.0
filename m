From: maggu2810@gmail.com (Markus Rathgeb)
Date: Fri, 19 Jan 2018 00:29:06 +0100
Subject: [PATCH] ARM: dts: imx6qdl-udoo: Disable usbh1 to avoid kernel hang
In-Reply-To: <84391569-cdb9-1c17-7e37-6fdad954d549@maciej.szmigiero.name>
References: <1516278858-15464-1-git-send-email-fabio.estevam@nxp.com>
 <84391569-cdb9-1c17-7e37-6fdad954d549@maciej.szmigiero.name>
Message-ID: <CAOcK=COGi6AmhemVAkGirLoMhMo3Bg4Uy+2bOkK2o7+_dMmTPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hmm, did you get reports or checked that it actually hangs?
>
> As far as I remember last time I ran a kernel without Peter's power
> sequence library on this board it only wasn't able to communicate with
> the on-board USB hub (and devices behind it), but besides this was
> able to boot successfully.
> But my memory may be wrong since it was some time ago.

Sorry guys, it seems I have problems sending this mail to all the
recipients (at least the linux-arm-kernel list).
Last try!


Hi,
this has been reported by me.

Here my initial message and the attachments:

Hi,
after updating the linux system on my Udoo Quad it does not boot
successful anymore.
I've been inventing some time to gather information.

The system has been working "normal" using the kernel 4.12.10.
With kernel 4.13(.0) it does not work "normal" (problem description
follows shortly) anymore.
The problem still exist in 4.15-rc7.

So, starting with 4.13 the kernel hangs / system freezes before the
root filesystem gets mounted.
See attached boot-log-4.13.0-freeze.txt

If I add the parameter "ip=dhcp" to the kernel command line the kernel
does not freezes anymore, the root is mounted and the init system is
started.
See attached boot-log-4.13.0-workaround.txt

The other problem is that starting with 4.13 the system freeze if I
load the "rt2800usb" kernel module.

Please let me know if I could add more information or could do some
further tests etc.

Best regards,
Markus
-------------- next part --------------
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] random: get_random_bytes called from start_kernel+0x34/0x404 with crng_init=0
[    0.000000] Linux version 4.13.0-1-ARCH (builduser at leming) (gcc version 7.1.1 20170630 (GCC)) #1 SMP Tue Sep 5 02:22:08 UTC 2017
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: Udoo i.MX6 Quad Board
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 48 MiB at 0x4d000000
[    0.000000] percpu: Embedded 17 pages/cpu @ef693000 s37516 r8192 d23924 u69632
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260416
[    0.000000] Kernel command line: console=ttymxc1,115200 root=PARTUUID=a8f8549b-01 rw rootwait video=
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 963520K/1048576K available (11264K kernel code, 1017K rwdata, 4580K rodata, 2048K init, 899K bss, 35904K reserved, 49152K cma-reserved, 212992K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0c00000   (12256 kB)
[    0.000000]       .init : 0xc1100000 - 0xc1300000   (2048 kB)
[    0.000000]       .data : 0xc1300000 - 0xc13fe720   (1018 kB)
[    0.000000]        .bss : 0xc1409234 - 0xc14ea07c   ( 900 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] L2C-310 errata 752271 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
[    0.000000] Switching to timer-based delay loop, resolution 333ns
[    0.000007] sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 715827882841ns
[    0.000031] clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 637086815595 ns
[    0.002457] Console: colour dummy device 80x30
[    0.002488] Calibrating delay loop (skipped), value calculated using timer frequency.. 6.00 BogoMIPS (lpj=12000)
[    0.002504] pid_max: default: 32768 minimum: 301
[    0.002778] Security Framework initialized
[    0.002964] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.002979] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.003693] CPU: Testing write buffer coherency: ok
[    0.004021] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.004392] Setting up static identity map for 0x10100000 - 0x101000a0
[    0.005968] Hierarchical SRCU implementation.
[    0.007595] smp: Bringing up secondary CPUs ...
[    0.008293] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.009073] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.009834] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.009926] smp: Brought up 1 node, 4 CPUs
[    0.009946] SMP: Total of 4 processors activated (24.00 BogoMIPS).
[    0.009953] CPU: All CPU(s) started in SVC mode.
[    0.010950] devtmpfs: initialized
[    0.020692] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.021009] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.021031] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.023802] xor: measuring software checksum speed
[    0.063379]    arm4regs  :  1221.000 MB/sec
[    0.103380]    8regs     :   944.000 MB/sec
[    0.143378]    32regs    :   979.000 MB/sec
[    0.183378]    neon      :   893.000 MB/sec
[    0.183387] xor: using function: arm4regs (1221.000 MB/sec)
[    0.183484] pinctrl core: initialized pinctrl subsystem
[    0.185106] NET: Registered protocol family 16
[    0.187853] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.189872] cpuidle: using governor menu
[    0.190656] CPU identified as i.MX6Q, silicon rev 1.2
[    0.197266] vdd1p1: supplied by regulator-dummy
[    0.197807] vdd3p0: supplied by regulator-dummy
[    0.198275] vdd2p5: supplied by regulator-dummy
[    0.198776] vddarm: supplied by regulator-dummy
[    0.199207] vddpu: supplied by regulator-dummy
[    0.199694] vddsoc: supplied by regulator-dummy
[    0.209279] No ATAGs?
[    0.209423] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.209436] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.211086] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
[    0.212307] Serial: AMBA PL011 UART driver
[    0.291916] raid6: int32x1  gen()   104 MB/s
[    0.359444] raid6: int32x1  xor()   144 MB/s
[    0.427652] raid6: int32x2  gen()   165 MB/s
[    0.495446] raid6: int32x2  xor()   168 MB/s
[    0.563643] raid6: int32x4  gen()   191 MB/s
[    0.631500] raid6: int32x4  xor()   158 MB/s
[    0.699622] raid6: int32x8  gen()   223 MB/s
[    0.767548] raid6: int32x8  xor()   153 MB/s
[    0.835447] raid6: neonx1   gen()   615 MB/s
[    0.903422] raid6: neonx1   xor()   453 MB/s
[    0.971377] raid6: neonx2   gen()   661 MB/s
[    1.039395] raid6: neonx2   xor()   576 MB/s
[    1.107409] raid6: neonx4   gen()   541 MB/s
[    1.175392] raid6: neonx4   xor()   523 MB/s
[    1.243426] raid6: neonx8   gen()   500 MB/s
[    1.311441] raid6: neonx8   xor()   448 MB/s
[    1.311449] raid6: using algorithm neonx2 gen() 661 MB/s
[    1.311455] raid6: .... xor() 576 MB/s, rmw enabled
[    1.311463] raid6: using intx1 recovery algorithm
[    1.324606] mxs-dma 110000.dma-apbh: initialized
[    1.329807] vgaarb: loaded
[    1.330634] SCSI subsystem initialized
[    1.331095] usbcore: registered new interface driver usbfs
[    1.331159] usbcore: registered new interface driver hub
[    1.331261] usbcore: registered new device driver usb
[    1.332480] i2c i2c-1: IMX I2C adapter registered
[    1.332498] i2c i2c-1: can't use DMA, using PIO instead.
[    1.332983] i2c i2c-2: IMX I2C adapter registered
[    1.332999] i2c i2c-2: can't use DMA, using PIO instead.
[    1.333858] media: Linux media interface: v0.10
[    1.333909] Linux video capture interface: v2.00
[    1.333986] pps_core: LinuxPPS API ver. 1 registered
[    1.333995] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.334017] PTP clock support registered
[    1.334052] EDAC MC: Ver: 3.0.0
[    1.335076] Advanced Linux Sound Architecture Driver Initialized.
[    1.335619] NetLabel: Initializing
[    1.335629] NetLabel:  domain hash size = 128
[    1.335636] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.335700] NetLabel:  unlabeled traffic allowed by default
[    1.336054] clocksource: Switched to clocksource mxc_timer1
[    1.336249] VFS: Disk quotas dquot_6.6.0
[    1.336349] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.345822] NET: Registered protocol family 2
[    1.346422] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    1.346502] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    1.346631] TCP: Hash tables configured (established 8192 bind 8192)
[    1.346743] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    1.346786] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    1.346997] NET: Registered protocol family 1
[    1.347471] RPC: Registered named UNIX socket transport module.
[    1.347480] RPC: Registered udp transport module.
[    1.347489] RPC: Registered tcp transport module.
[    1.347496] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.347916] Unpacking initramfs...
[    1.714697] Freeing initrd memory: 5008K
[    1.715245] hw perfevents: no interrupt-affinity property for /soc/pmu, guessing.
[    1.715527] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available
[    1.718520] workingset: timestamp_bits=14 max_order=18 bucket_order=4
[    1.723650] zbud: loaded
[    1.726110] NFS: Registering the id_resolver key type
[    1.726137] Key type id_resolver registered
[    1.726145] Key type id_legacy registered
[    1.726162] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.727740] random: fast init done
[    1.733700] Key type asymmetric registered
[    1.733754] bounce: pool size: 64 pages
[    1.733822] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    1.733955] io scheduler noop registered
[    1.733965] io scheduler deadline registered
[    1.734280] io scheduler cfq registered (default)
[    1.734291] io scheduler mq-deadline registered
[    1.734300] io scheduler kyber registered
[    1.734552] io scheduler bfq registered
[    1.750159] imx-sdma 20ec000.sdma: Direct firmware load for imx/sdma/sdma-imx6q.bin failed with error -2
[    1.750179] imx-sdma 20ec000.sdma: external firmware not found, using ROM firmware
[    1.755235] imx-pgc-pd imx-pgc-power-domain.0: Linked as a consumer to 20dc000.gpc
[    1.755417] imx-pgc-pd imx-pgc-power-domain.1: Linked as a consumer to 20dc000.gpc
[    1.759290] Serial: 8250/16550 driver, 6 ports, IRQ sharing disabled
[    1.761829] Serial: AMBA driver
[    1.762662] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq = 62, base_baud = 5000000) is a IMX
[    2.669811] console [ttymxc1] enabled
[    2.685550] loop: module loaded
[    2.690167] Loading iSCSI transport class v2.0-870.
[    2.695529] iscsi: registered transport (tcp)
[    2.700917] ahci-imx 2200000.sata: fsl,transmit-level-mV not specified, using 00000024
[    2.708873] ahci-imx 2200000.sata: fsl,transmit-boost-mdB not specified, using 00000480
[    2.716910] ahci-imx 2200000.sata: fsl,transmit-atten-16ths not specified, using 00002000
[    2.725111] ahci-imx 2200000.sata: fsl,receive-eq-mdB not specified, using 05000000
[    2.735607] ahci-imx 2200000.sata: SSS flag set, parallel bus scan disabled
[    2.742623] ahci-imx 2200000.sata: AHCI 0001.0300 32 slots 1 ports 3 Gbps 0x1 impl platform mode
[    2.751438] ahci-imx 2200000.sata: flags: ncq sntf stag pm led clo only pmp pio slum part ccc apst 
[    2.761790] scsi host0: ahci-imx
[    2.765336] ata1: SATA max UDMA/133 mmio [mem 0x02200000-0x02203fff] port 0x100 irq 65
[    2.777481] libphy: Fixed MDIO Bus: probed
[    2.783101] fec 2188000.ethernet: 2188000.ethernet supply phy not found, using dummy regulator
[    2.792208] pps pps0: new PPS source ptp0
[    2.808657] libphy: fec_enet_mii_bus: probed
[    2.813552] fec 2188000.ethernet eth0: registered PHC device 0
[    2.822633] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.829196] ehci-pci: EHCI PCI platform driver
[    2.833707] ehci-platform: EHCI generic platform driver
[    2.839185] ehci-mxc: Freescale On-Chip EHCI Host driver
[    2.844648] ehci-omap: OMAP-EHCI Host Controller driver
[    2.850074] ehci-orion: EHCI orion driver
[    2.854281] ehci-exynos: EHCI EXYNOS driver
[    2.858643] tegra-ehci: Tegra EHCI driver
[    2.862853] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.869079] ohci-pci: OHCI PCI platform driver
[    2.873595] ohci-platform: OHCI generic platform driver
[    2.879038] ohci-exynos: OHCI EXYNOS driver
[    2.883845] usbcore: registered new interface driver uas
[    2.889240] usbcore: registered new interface driver usb-storage
[    2.895302] usbcore: registered new interface driver ums-cypress
[    2.901361] usbcore: registered new interface driver ums_eneub6250
[    2.907602] usbcore: registered new interface driver ums-freecom
[    2.913662] usbcore: registered new interface driver ums-isd200
[    2.919635] usbcore: registered new interface driver ums-usbat
[    2.932221] ci_hdrc ci_hdrc.0: EHCI Host Controller
[    2.937155] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
[    2.960077] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
[    2.965680] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.972503] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.979748] usb usb1: Product: EHCI Host Controller
[    2.984650] usb usb1: Manufacturer: Linux 4.13.0-1-ARCH ehci_hcd
[    2.990672] usb usb1: SerialNumber: ci_hdrc.0
[    2.995638] hub 1-0:1.0: USB hub found
[    2.999469] hub 1-0:1.0: 1 port detected
[    3.007620] snvs_rtc 20cc000.snvs:snvs-rtc-lp: rtc core: registered 20cc000.snvs:snvs-rtc-lp as rtc0
[    3.017487] i2c /dev entries driver
[    3.029629] sdhci: Secure Digital Host Controller Interface driver
[    3.035837] sdhci: Copyright(c) Pierre Ossman
[    3.041322] Synopsys Designware Multimedia Card Interface Driver
[    3.048211] VUB300 Driver rom wait states = 1C irqpoll timeout = 0400
[    3.048621] usbcore: registered new interface driver vub300
[    3.060733] usbcore: registered new interface driver ushc
[    3.066953] sdhci-pltfm: SDHCI platform and OF driver helper
[    3.073490] sdhci-esdhc-imx 2198000.usdhc: could not get ultra high speed state, work on normal mode
[    3.086564] ata1: SATA link down (SStatus 0 SControl 300)
[    3.092046] ahci-imx 2200000.sata: no device found, disabling link.
[    3.098335] ahci-imx 2200000.sata: pass ahci_imx..hotplug=1 to enable hotplug
[    3.128100] mmc0: SDHCI controller on 2198000.usdhc [2198000.usdhc] using ADMA
[    3.142390] ledtrig-cpu: registered to indicate activity on CPUs
[    3.148695] hidraw: raw HID events driver (C) Jiri Kosina
[    3.154437] usbcore: registered new interface driver usbhid
[    3.160044] usbhid: USB HID core driver
[    3.174814] NET: Registered protocol family 10
[    3.200714] Segment Routing with IPv6
[    3.204441] mmc0: host does not support reading read-only switch, assuming write-enable
[    3.208156] mip6: Mobile IPv6
[    3.208166] NET: Registered protocol family 17
[    3.208236] Key type dns_resolver registered
[    3.219945] ThumbEE CPU extension supported.
[    3.219955] Registering SWP/SWPB emulation handler
[    3.228469] registered taskstats version 1
[    3.228534] zswap: loaded using pool lzo/zbud
[    3.243146] Btrfs loaded, crc32c=crc32c-generic
[    3.249032] mmc0: new high speed SDHC card at address aaaa
[    3.255243] mmcblk0: mmc0:aaaa SL16G 14.8 GiB 
[    3.258268] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    3.258476] imx_thermal 2000000.aips-bus:tempmon: Extended Commercial CPU temperature grade - max:105C critical:100C passive:95C
[    3.259716] snvs_rtc 20cc000.snvs:snvs-rtc-lp: setting system clock to 1970-01-01 00:00:00 UTC (0)
[    3.259722] sr_init: No PMIC hook to init smartreflex
[    3.259823] sr_init: platform driver register failed for SR
[    3.260361] lcd_panel: disabling
[    3.260363] ALSA device list:
[    3.260367]   No soundcards found.

-------------- next part --------------
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] random: get_random_bytes called from start_kernel+0x34/0x404 with crng_init=0
[    0.000000] Linux version 4.13.0-1-ARCH (builduser at leming) (gcc version 7.1.1 20170630 (GCC)) #1 SMP Tue Sep 5 02:22:08 UTC 2017
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: Udoo i.MX6 Quad Board
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 48 MiB at 0x4d000000
[    0.000000] percpu: Embedded 17 pages/cpu @ef693000 s37516 r8192 d23924 u69632
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260416
[    0.000000] Kernel command line: console=ttymxc1,115200 ip=dhcp root=PARTUUID=a8f8549b-01 rw rootwait video=
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 963520K/1048576K available (11264K kernel code, 1017K rwdata, 4580K rodata, 2048K init, 899K bss, 35904K reserved, 49152K cma-reserved, 212992K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0c00000   (12256 kB)
[    0.000000]       .init : 0xc1100000 - 0xc1300000   (2048 kB)
[    0.000000]       .data : 0xc1300000 - 0xc13fe720   (1018 kB)
[    0.000000]        .bss : 0xc1409234 - 0xc14ea07c   ( 900 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] L2C-310 errata 752271 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
[    0.000000] Switching to timer-based delay loop, resolution 333ns
[    0.000008] sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 715827882841ns
[    0.000032] clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 637086815595 ns
[    0.002440] Console: colour dummy device 80x30
[    0.002474] Calibrating delay loop (skipped), value calculated using timer frequency.. 6.00 BogoMIPS (lpj=12000)
[    0.002490] pid_max: default: 32768 minimum: 301
[    0.002765] Security Framework initialized
[    0.002948] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.002963] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.003663] CPU: Testing write buffer coherency: ok
[    0.003992] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.004363] Setting up static identity map for 0x10100000 - 0x101000a0
[    0.005946] Hierarchical SRCU implementation.
[    0.007578] smp: Bringing up secondary CPUs ...
[    0.008278] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.009060] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.009815] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.009907] smp: Brought up 1 node, 4 CPUs
[    0.009929] SMP: Total of 4 processors activated (24.00 BogoMIPS).
[    0.009936] CPU: All CPU(s) started in SVC mode.
[    0.010921] devtmpfs: initialized
[    0.020719] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.021049] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.021070] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.023833] xor: measuring software checksum speed
[    0.063349]    arm4regs  :  1226.000 MB/sec
[    0.103348]    8regs     :   952.000 MB/sec
[    0.143350]    32regs    :  1012.000 MB/sec
[    0.183348]    neon      :   897.000 MB/sec
[    0.183358] xor: using function: arm4regs (1226.000 MB/sec)
[    0.183455] pinctrl core: initialized pinctrl subsystem
[    0.185073] NET: Registered protocol family 16
[    0.188072] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.190088] cpuidle: using governor menu
[    0.190893] CPU identified as i.MX6Q, silicon rev 1.2
[    0.197517] vdd1p1: supplied by regulator-dummy
[    0.198061] vdd3p0: supplied by regulator-dummy
[    0.198529] vdd2p5: supplied by regulator-dummy
[    0.199032] vddarm: supplied by regulator-dummy
[    0.199502] vddpu: supplied by regulator-dummy
[    0.199964] vddsoc: supplied by regulator-dummy
[    0.209527] No ATAGs?
[    0.209672] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.209685] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.211375] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
[    0.212546] Serial: AMBA PL011 UART driver
[    0.291893] raid6: int32x1  gen()   104 MB/s
[    0.359417] raid6: int32x1  xor()   143 MB/s
[    0.427594] raid6: int32x2  gen()   165 MB/s
[    0.495448] raid6: int32x2  xor()   169 MB/s
[    0.563567] raid6: int32x4  gen()   191 MB/s
[    0.631478] raid6: int32x4  xor()   158 MB/s
[    0.699368] raid6: int32x8  gen()   222 MB/s
[    0.767458] raid6: int32x8  xor()   153 MB/s
[    0.835411] raid6: neonx1   gen()   615 MB/s
[    0.903374] raid6: neonx1   xor()   454 MB/s
[    0.971370] raid6: neonx2   gen()   661 MB/s
[    1.039383] raid6: neonx2   xor()   576 MB/s
[    1.107385] raid6: neonx4   gen()   541 MB/s
[    1.175394] raid6: neonx4   xor()   523 MB/s
[    1.243395] raid6: neonx8   gen()   500 MB/s
[    1.311384] raid6: neonx8   xor()   448 MB/s
[    1.311392] raid6: using algorithm neonx2 gen() 661 MB/s
[    1.311399] raid6: .... xor() 576 MB/s, rmw enabled
[    1.311406] raid6: using intx1 recovery algorithm
[    1.324562] mxs-dma 110000.dma-apbh: initialized
[    1.329785] vgaarb: loaded
[    1.330621] SCSI subsystem initialized
[    1.331082] usbcore: registered new interface driver usbfs
[    1.331147] usbcore: registered new interface driver hub
[    1.331255] usbcore: registered new device driver usb
[    1.332463] i2c i2c-1: IMX I2C adapter registered
[    1.332482] i2c i2c-1: can't use DMA, using PIO instead.
[    1.332976] i2c i2c-2: IMX I2C adapter registered
[    1.332991] i2c i2c-2: can't use DMA, using PIO instead.
[    1.333847] media: Linux media interface: v0.10
[    1.333894] Linux video capture interface: v2.00
[    1.333973] pps_core: LinuxPPS API ver. 1 registered
[    1.333981] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.334002] PTP clock support registered
[    1.334038] EDAC MC: Ver: 3.0.0
[    1.335069] Advanced Linux Sound Architecture Driver Initialized.
[    1.335607] NetLabel: Initializing
[    1.335617] NetLabel:  domain hash size = 128
[    1.335625] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.335687] NetLabel:  unlabeled traffic allowed by default
[    1.336063] clocksource: Switched to clocksource mxc_timer1
[    1.336256] VFS: Disk quotas dquot_6.6.0
[    1.336360] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.345821] NET: Registered protocol family 2
[    1.346428] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    1.346507] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    1.346636] TCP: Hash tables configured (established 8192 bind 8192)
[    1.346748] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    1.346793] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    1.347003] NET: Registered protocol family 1
[    1.347495] RPC: Registered named UNIX socket transport module.
[    1.347505] RPC: Registered udp transport module.
[    1.347511] RPC: Registered tcp transport module.
[    1.347518] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.347941] Unpacking initramfs...
[    1.714776] Freeing initrd memory: 5008K
[    1.715356] hw perfevents: no interrupt-affinity property for /soc/pmu, guessing.
[    1.715640] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available
[    1.718605] workingset: timestamp_bits=14 max_order=18 bucket_order=4
[    1.723767] zbud: loaded
[    1.726213] NFS: Registering the id_resolver key type
[    1.726238] Key type id_resolver registered
[    1.726245] Key type id_legacy registered
[    1.726263] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.727858] random: fast init done
[    1.733239] Key type asymmetric registered
[    1.733295] bounce: pool size: 64 pages
[    1.733358] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    1.733496] io scheduler noop registered
[    1.733506] io scheduler deadline registered
[    1.733821] io scheduler cfq registered (default)
[    1.733831] io scheduler mq-deadline registered
[    1.733838] io scheduler kyber registered
[    1.734094] io scheduler bfq registered
[    1.749874] imx-sdma 20ec000.sdma: Direct firmware load for imx/sdma/sdma-imx6q.bin failed with error -2
[    1.749892] imx-sdma 20ec000.sdma: external firmware not found, using ROM firmware
[    1.754939] imx-pgc-pd imx-pgc-power-domain.0: Linked as a consumer to 20dc000.gpc
[    1.755120] imx-pgc-pd imx-pgc-power-domain.1: Linked as a consumer to 20dc000.gpc
[    1.759024] Serial: 8250/16550 driver, 6 ports, IRQ sharing disabled
[    1.761556] Serial: AMBA driver
[    1.762386] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq = 62, base_baud = 5000000) is a IMX
[    2.670024] console [ttymxc1] enabled
[    2.685885] loop: module loaded
[    2.690484] Loading iSCSI transport class v2.0-870.
[    2.695813] iscsi: registered transport (tcp)
[    2.701174] ahci-imx 2200000.sata: fsl,transmit-level-mV not specified, using 00000024
[    2.709129] ahci-imx 2200000.sata: fsl,transmit-boost-mdB not specified, using 00000480
[    2.717169] ahci-imx 2200000.sata: fsl,transmit-atten-16ths not specified, using 00002000
[    2.725372] ahci-imx 2200000.sata: fsl,receive-eq-mdB not specified, using 05000000
[    2.735871] ahci-imx 2200000.sata: SSS flag set, parallel bus scan disabled
[    2.742889] ahci-imx 2200000.sata: AHCI 0001.0300 32 slots 1 ports 3 Gbps 0x1 impl platform mode
[    2.751706] ahci-imx 2200000.sata: flags: ncq sntf stag pm led clo only pmp pio slum part ccc apst 
[    2.762126] scsi host0: ahci-imx
[    2.765673] ata1: SATA max UDMA/133 mmio [mem 0x02200000-0x02203fff] port 0x100 irq 65
[    2.777820] libphy: Fixed MDIO Bus: probed
[    2.783439] fec 2188000.ethernet: 2188000.ethernet supply phy not found, using dummy regulator
[    2.792546] pps pps0: new PPS source ptp0
[    2.808803] libphy: fec_enet_mii_bus: probed
[    2.813711] fec 2188000.ethernet eth0: registered PHC device 0
[    2.822742] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.829297] ehci-pci: EHCI PCI platform driver
[    2.833802] ehci-platform: EHCI generic platform driver
[    2.839273] ehci-mxc: Freescale On-Chip EHCI Host driver
[    2.844738] ehci-omap: OMAP-EHCI Host Controller driver
[    2.850161] ehci-orion: EHCI orion driver
[    2.854363] ehci-exynos: EHCI EXYNOS driver
[    2.858729] tegra-ehci: Tegra EHCI driver
[    2.862934] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.869154] ohci-pci: OHCI PCI platform driver
[    2.873664] ohci-platform: OHCI generic platform driver
[    2.879103] ohci-exynos: OHCI EXYNOS driver
[    2.883911] usbcore: registered new interface driver uas
[    2.889302] usbcore: registered new interface driver usb-storage
[    2.895361] usbcore: registered new interface driver ums-cypress
[    2.901417] usbcore: registered new interface driver ums_eneub6250
[    2.907656] usbcore: registered new interface driver ums-freecom
[    2.913712] usbcore: registered new interface driver ums-isd200
[    2.919681] usbcore: registered new interface driver ums-usbat
[    2.932280] ci_hdrc ci_hdrc.0: EHCI Host Controller
[    2.937237] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
[    2.960087] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
[    2.965682] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.972505] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.979748] usb usb1: Product: EHCI Host Controller
[    2.984647] usb usb1: Manufacturer: Linux 4.13.0-1-ARCH ehci_hcd
[    2.990670] usb usb1: SerialNumber: ci_hdrc.0
[    2.995647] hub 1-0:1.0: USB hub found
[    2.999454] hub 1-0:1.0: 1 port detected
[    3.007572] snvs_rtc 20cc000.snvs:snvs-rtc-lp: rtc core: registered 20cc000.snvs:snvs-rtc-lp as rtc0
[    3.017428] i2c /dev entries driver
[    3.029587] sdhci: Secure Digital Host Controller Interface driver
[    3.035794] sdhci: Copyright(c) Pierre Ossman
[    3.041276] Synopsys Designware Multimedia Card Interface Driver
[    3.048175] VUB300 Driver rom wait states = 1C irqpoll timeout = 0400
[    3.048555] usbcore: registered new interface driver vub300
[    3.060664] usbcore: registered new interface driver ushc
[    3.066877] sdhci-pltfm: SDHCI platform and OF driver helper
[    3.073435] sdhci-esdhc-imx 2198000.usdhc: could not get ultra high speed state, work on normal mode
[    3.086566] ata1: SATA link down (SStatus 0 SControl 300)
[    3.092025] ahci-imx 2200000.sata: no device found, disabling link.
[    3.098318] ahci-imx 2200000.sata: pass ahci_imx..hotplug=1 to enable hotplug
[    3.128108] mmc0: SDHCI controller on 2198000.usdhc [2198000.usdhc] using ADMA
[    3.142412] ledtrig-cpu: registered to indicate activity on CPUs
[    3.148711] hidraw: raw HID events driver (C) Jiri Kosina
[    3.154457] usbcore: registered new interface driver usbhid
[    3.160065] usbhid: USB HID core driver
[    3.174811] NET: Registered protocol family 10
[    3.200874] Segment Routing with IPv6
[    3.204603] mmc0: host does not support reading read-only switch, assuming write-enable
[    3.208142] mip6: Mobile IPv6
[    3.208151] NET: Registered protocol family 17
[    3.208222] Key type dns_resolver registered
[    3.220106] ThumbEE CPU extension supported.
[    3.220117] Registering SWP/SWPB emulation handler
[    3.220669] registered taskstats version 1
[    3.220748] zswap: loaded using pool lzo/zbud
[    3.243304] Btrfs loaded, crc32c=crc32c-generic
[    3.252093] mmc0: new high speed SDHC card at address aaaa
[    3.258304] mmcblk0: mmc0:aaaa SL16G 14.8 GiB 
[    3.258679] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    3.258858] imx_thermal 2000000.aips-bus:tempmon: Extended Commercial CPU temperature grade - max:105C critical:100C passive:95C
[    3.274971] snvs_rtc 20cc000.snvs:snvs-rtc-lp: setting system clock to 1970-01-01 00:00:00 UTC (0)
[    3.274978] sr_init: No PMIC hook to init smartreflex
[    3.275091] sr_init: platform driver register failed for SR
[    3.287857] Generic PHY 2188000.ethernet-1:06: attached PHY driver [Generic PHY] (mii_bus:phy_addr=2188000.ethernet-1:06, irq=-1)
[    3.287957] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    3.334213]  mmcblk0: p1
[    3.380077] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[    3.532496] usb 1-1: New USB device found, idVendor=0424, idProduct=2514
[    3.539222] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.547022] hub 1-1:1.0: USB hub found
[    3.550989] hub 1-1:1.0: 4 ports detected
[    3.844068] usb 1-1.3: new high-speed USB device number 3 using ci_hdrc
[    3.977994] usb 1-1.3: New USB device found, idVendor=148f, idProduct=5370
[    3.984895] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.992220] usb 1-1.3: Product: 802.11 n WLAN
[    3.996595] usb 1-1.3: Manufacturer: Ralink
[    4.000792] usb 1-1.3: SerialNumber: 1.0
[    6.364465] fec 2188000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[    6.376084] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    6.396061] Sending DHCP requests ., OK
[    6.415927] IP-Config: Got DHCP answer from 192.168.14.1, my address is 192.168.14.192
[    6.423870] IP-Config: Complete:
[    6.427118]      device=eth0, hwaddr=00:c0:08:88:24:8c, ipaddr=192.168.14.192, mask=255.255.255.0, gw=192.168.14.1
[    6.437482]      host=192.168.14.192, domain=fritz.box, nis-domain=(none)
[    6.444287]      bootserver=192.168.14.1, rootserver=192.168.14.1, rootpath=     nameserver0=192.168.14.1
[    6.454206] lcd_panel: disabling
[    6.457472] ALSA device list:
[    6.460460]   No soundcards found.
[    6.465656] Freeing unused kernel memory: 2048K
:: running early hook [udev]
Warning: /lib/modules/4.13.0-1-ARCH/modules.devname not found - ignoring
starting version 236
:: running hook [udev]
:: Triggering uevents...
:: performing fsck on '/dev/mmcblk0p1'
/dev/mmcblk0p1: recovering journal
/dev/mmcblk0p1: clean, 37714/972944 files, 389545/3888512 blocks
:: mounting '/dev/mmcblk0p1' on real root
[    7.664636] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mode. Opts: (null)
:: running cleanup hook [udev]
[    8.226335] systemd[1]: System time before build time, advancing clock.
[    8.309100] ip_tables: (C) 2000-2006 Netfilter Core Team
[    8.345183] systemd[1]: systemd 236 running in system mode. (+PAM -AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN default-hierarchy=hybrid)
[    8.366279] systemd[1]: Detected architecture arm.

Welcome to Arch Linux ARM!
