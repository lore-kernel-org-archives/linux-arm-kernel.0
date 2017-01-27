From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 27 Jan 2017 21:46:12 +0200
Subject: [PATCH v2 0/8] Pad retentions support for Exynos5433
In-Reply-To: <1485419634-28331-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170126083401eucas1p20b4794fe46ccf2189bf734f0d8e3c536@eucas1p2.samsung.com>
 <1485419634-28331-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170127194612.44dmadsqw6vv5f23@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 09:33:46AM +0100, Marek Szyprowski wrote:
> Hello,
> 
> This patchset is a first step to add support for all power domains on
> Exynos5433 SoCs. This patchset contains patches for Exynos pin control
> driver and Exynos LPASS MFD driver, which are needed to make the
> platform ready for adding power domains support.
> 
> Patches in this patchset depends on each other. They are order in such a
> way to make the changes bisectable.
> 
> Patch #3 has runtime dependency on #1.
> Patch #5 has runtime dependency on #3.
> Patch #6 has runtime dependency on #4.
> 
> This patchset also directly depends on the "Move pad retention control to
> Exynos pin controller driver" patchset:
> https://www.spinics.net/lists/arm-kernel/msg556074.html
> 
> Patches have been generated on top of linux-next from 25th January 2017.
> 
> This is a part of a larger task, which goal is to add support for power
> domains on Exynos5433 SoCs / TM2 boards. All patches needed to get it
> working have been pushed to the following git repo:
> https://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.10-next-tm2-pd
>
I tried your branch above on Odroid U3 and it fails to boot.
next-20170125 works fine. exynos_defconfig, booting from microSD.

Board hangs (silently) on:
[    2.283437] usb 1-3: new high-speed USB device number 3 using exynos-ehci
[    2.473786] usb 1-3: New USB device found, idVendor=0424, idProduct=3503
[    2.474856] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.482656] hub 1-3:1.0: USB hub found
[    2.486017] hub 1-3:1.0: 3 ports detected
[   55.037205] random: crng init done

Full log attached.

Best regards,
Krzysztof

-------------- next part --------------
U-Boot 2017.01-rc2-00044-g8653b94a8f5a (Jan 06 2017 - 18:05:55 +0200)

CPU:   Exynos4412 @ 1 GHz
Model: Odroid based on Exynos4412
Board: Odroid based on Exynos4412
Type:  u3
DRAM:  2 GiB
LDO20 at VDDQ_EMMC_1.8V: set 1800000 uV; enabling
LDO22 at VDDQ_EMMC_2.8V: set 2800000 uV; enabling
LDO21 at TFLASH_2.8V: set 2800000 uV; enabling
MMC:   SAMSUNG SDHCI: 0, EXYNOS DWMMC: 1
Net:   No ethernet found.
Hit any key to stop autoboot:  0
Odroid #
Odroid # run nn
reading boot.scr
2051 bytes read in 22 ms (90.8 KiB/s)
## Executing script at 42000000
reading /zImage
4641960 bytes read in 226 ms (19.6 MiB/s)
reading /dtbs/exynos4412-odroidu3.dtb
54779 bytes read in 41 ms (1.3 MiB/s)
reading /initramfs-linux.img
** Unable to read file /initramfs-linux.img **
Kernel image @ 0x40007fc0 [ 0x000000 - 0x46d4a8 ]
## Flattened Device Tree blob at 40800000
   Booting using the fdt blob at 0x40800000
   Loading Device Tree to 4ffef000, end 4ffff5fa ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0xa00
[    0.000000] Linux version 4.10.0-rc5-next-20170125-00050-g0dc3a91a2fba (kozik at kozik-lap) (gcc version 6.2.0 20161005 (Ubuntu 6.2.0-5ubuntu12) ) #368 SMP PREEMPT Fri Jan 27 21:41:22 IST 2017
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt:Machine model: Hardkernel ODROID-U3 board based on Exynos4412
[    0.000000] Reserved memory: created DMA memory pool at 0xbf700000, size 8 MiB
[    0.000000] OF: reserved mem: initialized node region_mfc_right, compatible id shared-dma-pool
[    0.000000] Reserved memory: created DMA memory pool at 0xbe700000, size 16 MiB
[    0.000000] OF: reserved mem: initialized node region_mfc_left, compatible id shared-dma-pool
[    0.000000] cma: Reserved 64 MiB at 0xba400000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Samsung CPU ID: 0xe4412220
[    0.000000] Running under secure firmware.
[    0.000000] percpu: Embedded 16 pages/cpu @eefb9000 s34008 r8192 d23336 u65536
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 516352
[    0.000000] Kernel command line: console=tty1 console=ttySAC1,115200n8 root=PARTUUID=82ec0a4a-02 rw rootwait smsc95xx.macaddr=00:1e:06:61:7a:94  no_console_suspend
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1976632K/2071552K available (7168K kernel code, 279K rwdata, 2284K rodata, 1024K init, 319K bss, 29384K reserved, 65536K cma-reserved, 1219584K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0800000   (8160 kB)
[    0.000000]       .init : 0xc0b00000 - 0xc0c00000   (1024 kB)
[    0.000000]       .data : 0xc0c00000 - 0xc0c45f00   ( 280 kB)
[    0.000000]        .bss : 0xc0c47000 - 0xc0c96d68   ( 320 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=4
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C: platform modifies aux control register: 0x02070000 -> 0x3e470001
[    0.000000] L2C: platform provided aux values permit register corruption.
[    0.000000] L2C: DT/platform modifies aux control register: 0x02070000 -> 0x3e470001
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310: enabling full line of zeros but not enabled in Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 8 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x4100c4c8, AUX_CTRL 0x7e470001
[    0.000000] Exynos4x12 clocks: sclk_apll = 1000000000, sclk_mpll = 800000000
[    0.000000]  sclk_epll = 96000000, sclk_vpll = 350000000, arm_clk = 1000000000
[    0.000000] Switching to timer-based delay loop, resolution 41ns
[    0.000000] clocksource: mct-frc: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[    0.000004] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
[    0.000248] Console: colour dummy device 80x30
[    0.000903] console [tty1] enabled
[    0.000928] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[    0.000961] pid_max: default: 32768 minimum: 301
[    0.001046] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001069] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001478] CPU: Testing write buffer coherency: ok
[    0.001790] CPU0: thread -1, cpu 0, socket 10, mpidr 80000a00
[    0.030004] Setting up static identity map for 0x40100000 - 0x40100058
[    0.119992] smp: Bringing up secondary CPUs ...
[    0.200315] CPU1: thread -1, cpu 1, socket 10, mpidr 80000a01
[    0.280298] CPU2: thread -1, cpu 2, socket 10, mpidr 80000a02
[    0.360290] CPU3: thread -1, cpu 3, socket 10, mpidr 80000a03
[    0.360351] smp: Brought up 1 node, 4 CPUs
[    0.360417] SMP: Total of 4 processors activated (192.00 BogoMIPS).
[    0.360435] CPU: All CPU(s) started in SVC mode.
[    0.361227] devtmpfs: initialized
[    0.371920] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.372168] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.373950] pinctrl core: initialized pinctrl subsystem
[    0.374590] lcd0-power-domain has as child subdomain: tv-power-domain.
[    0.375416] NET: Registered protocol family 16
[    0.377168] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.378419] cpuidle: using governor menu
[    0.409143] SCSI subsystem initialized
[    0.409343] usbcore: registered new interface driver usbfs
[    0.409409] usbcore: registered new interface driver hub
[    0.409490] usbcore: registered new device driver usb
[    0.410050] s3c-i2c 13860000.i2c: slave address 0x00
[    0.410080] s3c-i2c 13860000.i2c: bus frequency set to 390 KHz
[    0.410542] s3c-i2c 13860000.i2c: i2c-0: S3C I2C adapter
[    0.410719] s3c-i2c 13870000.i2c: slave address 0x00
[    0.410747] s3c-i2c 13870000.i2c: bus frequency set to 97 KHz
[    0.411065] s3c-i2c 13870000.i2c: i2c-1: S3C I2C adapter
[    0.411207] s3c-i2c 13880000.i2c: slave address 0x00
[    0.411233] s3c-i2c 13880000.i2c: bus frequency set to 97 KHz
[    0.411429] s3c-i2c 13880000.i2c: i2c-2: S3C I2C adapter
[    0.411538] s3c-i2c 138e0000.i2c: slave address 0x00
[    0.411564] s3c-i2c 138e0000.i2c: bus frequency set to 97 KHz
[    0.411876] s3c-i2c 138e0000.i2c: i2c-8: S3C I2C adapter
[    0.412490] Advanced Linux Sound Architecture Driver Initialized.
[    0.413377] clocksource: Switched to clocksource mct-frc
[    0.421266] NET: Registered protocol family 2
[    0.421722] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.421811] TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
[    0.421964] TCP: Hash tables configured (established 8192 bind 8192)
[    0.422053] UDP hash table entries: 512 (order: 2, 24576 bytes)
[    0.422105] UDP-Lite hash table entries: 512 (order: 2, 24576 bytes)
[    0.422264] NET: Registered protocol family 1
[    0.422620] RPC: Registered named UNIX socket transport module.
[    0.422644] RPC: Registered udp transport module.
[    0.422661] RPC: Registered tcp transport module.
[    0.422678] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.423858] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.424208] workingset: timestamp_bits=30 max_order=19 bucket_order=0
[    0.430657] NFS: Registering the id_resolver key type
[    0.430706] Key type id_resolver registered
[    0.430724] Key type id_legacy registered
[    0.430767] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    0.431536] bounce: pool size: 64 pages
[    0.431693] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.431723] io scheduler noop registered
[    0.431740] io scheduler deadline registered
[    0.431877] io scheduler cfq registered (default)
[    0.431897] io scheduler mq-deadline registered
[    0.433431] 125b0000.exynos-usbphy supply vbus not found, using dummy regulator
[    0.439237] dma-pl330 12680000.pdma: Loaded driver for PL330 DMAC-141330
[    0.439270] dma-pl330 12680000.pdma:         DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    0.441766] dma-pl330 12690000.pdma: Loaded driver for PL330 DMAC-141330
[    0.441798] dma-pl330 12690000.pdma:         DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    0.442549] dma-pl330 12850000.mdma: Loaded driver for PL330 DMAC-141330
[    0.442579] dma-pl330 12850000.mdma:         DBUFF-64x8bytes Num_Chans-8 Num_Peri-1 Num_Events-32
[    0.494061] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.495894] 13800000.serial: ttySAC0 at MMIO 0x13800000 (irq = 53, base_baud = 0) is a S3C6400/10
[    0.496268] 13810000.serial: ttySAC1 at MMIO 0x13810000 (irq = 54, base_baud = 0) is a S3C6400/10
[    1.267780] console [ttySAC1] enabled
[    1.275320] exynos-hdmi 12d00000.hdmi: Failed to get supply 'vdd': -517
[    1.290270] brd: module loaded
[    1.295375] loop: module loaded
[    1.309140] random: fast init done
[    1.318865] s3c64xx-spi 13930000.spi: spi bus clock parent not specified, using clock at index 0 as parent
[    1.322902] s3c64xx-spi 13930000.spi: number of chip select lines not specified, assuming 1 chip select line
[    1.333776] libphy: Fixed MDIO Bus: probed
[    1.336988] usbcore: registered new interface driver r8152
[    1.342292] usbcore: registered new interface driver asix
[    1.347687] usbcore: registered new interface driver ax88179_178a
[    1.353749] usbcore: registered new interface driver cdc_ether
[    1.359557] usbcore: registered new interface driver smsc75xx
[    1.365304] usbcore: registered new interface driver smsc95xx
[    1.371002] usbcore: registered new interface driver net1080
[    1.376690] usbcore: registered new interface driver cdc_subset
[    1.382552] usbcore: registered new interface driver zaurus
[    1.388139] usbcore: registered new interface driver cdc_ncm
[    1.395179] dwc2 12480000.hsotg: Invalid value 1024 for param g-np-tx-fifo-size
[    1.401043] dwc2 12480000.hsotg: EPs: 16, dedicated fifos, 7808 entries in SPRAM
[    1.409298] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.414922] ehci-exynos: EHCI EXYNOS driver
[    1.419646] exynos-ehci 12580000.ehci: EHCI Host Controller
[    1.424658] exynos-ehci 12580000.ehci: new USB bus registered, assigned bus number 1
[    1.432518] exynos-ehci 12580000.ehci: irq 51, io mem 0x12580000
[    1.463415] exynos-ehci 12580000.ehci: USB 2.0 started, EHCI 1.00
[    1.464014] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.470649] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.477878] usb usb1: Product: EHCI Host Controller
[    1.482710] usb usb1: Manufacturer: Linux 4.10.0-rc5-next-20170125-00050-g0dc3a91a2fba ehci_hcd
[    1.491414] usb usb1: SerialNumber: 12580000.ehci
[    1.496554] hub 1-0:1.0: USB hub found
[    1.499835] hub 1-0:1.0: 3 ports detected
[    1.504425] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.510001] ohci-exynos: OHCI EXYNOS driver
[    1.514852] usbcore: registered new interface driver usb-storage
[    1.530924] usb3503 0-0008: switched to HUB mode
[    1.530999] usb3503 0-0008: usb3503_probe: probed in hub mode
[    1.535979] using random self ethernet address
[    1.540062] using random host ethernet address
[    1.544882] usb0: HOST MAC 7a:d4:f7:e7:93:e8
[    1.548792] usb0: MAC 7a:25:6d:db:b1:9e
[    1.552566] using random self ethernet address
[    1.557007] using random host ethernet address
[    1.561441] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
[    1.568031] g_ether gadget: g_ether ready
[    1.572014] dwc2 12480000.hsotg: bound driver g_ether
[    1.580371] mousedev: PS/2 mouse device common for all mice
[    1.711692] max77686-rtc max77686-rtc: rtc core: registered max77686-rtc as rtc0
[    1.714380] rtc rtc1: invalid alarm value: 1900-1-2 0:0:0
[    1.718981] s3c-rtc 10070000.rtc: rtc core: registered s3c as rtc1
[    1.725512] i2c /dev entries driver
[    1.732753] s3c2410-wdt 10060000.watchdog: watchdog inactive, reset disabled, irq disabled
[    1.737332] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel at redhat.com
[    1.748201] sdhci: Secure Digital Host Controller Interface driver
[    1.751299] sdhci: Copyright(c) Pierre Ossman
[    1.756052] s3c-sdhci 12530000.sdhci: clock source 2: mmc_busclk.2 (100000000 Hz)
[    1.763186] s3c-sdhci 12530000.sdhci: Got CD GPIO
[    1.823530] mmc0: SDHCI controller on samsung-hsmmc [12530000.sdhci] using ADMA
[    1.825409] Synopsys Designware Multimedia Card Interface Driver
[    1.831817] dwmmc_exynos 12550000.mmc: IDMAC supports 32-bit address mode.
[    1.838133] dwmmc_exynos 12550000.mmc: Using internal DMA controller.
[    1.844493] dwmmc_exynos 12550000.mmc: Version ID is 240a
[    1.849876] dwmmc_exynos 12550000.mmc: DW MMC controller at irq 110,32 bit host data width,128 deep fifo
[    1.859539] dwmmc_exynos 12550000.mmc: allocated mmc-pwrseq
[    1.864902] usb 1-2: new high-speed USB device number 2 using exynos-ehci
[    1.871688] mmc_host mmc1: card is polling.
[    1.903753] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63)
[    1.933547] dwmmc_exynos 12550000.mmc: 1 slots initialized
[    1.934664] s5p-secss 10830000.sss: s5p-sss driver registered
[    1.942516] usbcore: registered new interface driver usbhid
[    1.944707] usbhid: USB HID core driver
[    1.959692] NET: Registered protocol family 10
[    1.960359] Segment Routing with IPv6
[    1.962179] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.968428] NET: Registered protocol family 17
[    1.972486] NET: Registered protocol family 15
[    1.977036] Key type dns_resolver registered
[    1.981461] Registering SWP/SWPB emulation handler
[    1.987135] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 300000Hz, actual 297619HZ div = 84)
[    2.013136] [drm] Exynos DRM: using 12c10000.mixer device for DMA mapping operations
[    2.015626] exynos-drm exynos-drm: bound 12c10000.mixer (ops mixer_component_ops)
[    2.022899] exynos-drm exynos-drm: bound 12d00000.hdmi (ops hdmi_component_ops)
[    2.030045] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.036622] [drm] No driver support for vblank timestamp query.
[    2.042549] [drm] Initialized exynos 1.0.0 20110530 for exynos-drm on minor 0
[    2.050968] exynos-bus: new bus device registered: bus_dmc (100000 KHz ~ 400000 KHz)
[    2.053768] usb 1-2: New USB device found, idVendor=0424, idProduct=9730
[    2.053776] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.056426] smsc95xx v1.0.5
[    2.064078] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 200000Hz, actual 200000HZ div = 125)
[    2.084445] exynos-bus: new bus device registered: bus_acp (100000 KHz ~ 267000 KHz)
[    2.091742] exynos-bus: new bus device registered: bus_c2c (100000 KHz ~ 400000 KHz)
[    2.093515] mmc0: new high speed SDHC card at address 0007
[    2.094029] mmcblk0: mmc0:0007 SD16G 14.5 GiB
[    2.095502]  mmcblk0: p1 p2 p3
[    2.113868] exynos-bus: new bus device registered: bus_leftbus (100000 KHz ~ 200000 KHz)
[    2.120680] exynos-bus: new bus device registered: bus_rightbus (100000 KHz ~ 200000 KHz)
[    2.129026] exynos-bus: new bus device registered: bus_display (160000 KHz ~ 200000 KHz)
[    2.137031] exynos-bus: new bus device registered: bus_fsys (100000 KHz ~ 134000 KHz)
[    2.144828] exynos-bus: new bus device registered: bus_peri ( 50000 KHz ~ 100000 KHz)
[    2.149095] smsc95xx 1-2:1.0 eth0: register 'smsc95xx' at usb-12580000.ehci-2, smsc95xx USB 2.0 Ethernet, 5a:46:f5:aa:8d:36
[    2.154191] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 100000Hz, actual 100000HZ div = 250)
[    2.173243] exynos-bus: new bus device registered: bus_mfc (100000 KHz ~ 200000 KHz)
[    2.214263] max98090 1-0010: MAX98090 REVID=0x43
[    2.217699] max98090 1-0010: use default 2.8v micbias
[    2.225755] asoc-simple-card sound: HiFi <-> 3830000.i2s mapping ok
[    2.229872] input: gpio_keys as /devices/platform/gpio_keys/input/input0
[    2.266862] max77686-rtc max77686-rtc: setting system clock to 2017-01-27 19:43:23 UTC (1485546203)
[    2.283437] usb 1-3: new high-speed USB device number 3 using exynos-ehci
[    2.473786] usb 1-3: New USB device found, idVendor=0424, idProduct=3503
[    2.474856] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.482656] hub 1-3:1.0: USB hub found
[    2.486017] hub 1-3:1.0: 3 ports detected
[   55.037205] random: crng init done
