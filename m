From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 27 Jul 2018 17:28:03 +0100
Subject: bcm2837: tons of DMA mask not set in 4.18.0-rc6-next-20180727
In-Reply-To: <325098108.159647.1532708245242@email.1und1.de>
References: <325098108.159647.1532708245242@email.1und1.de>
Message-ID: <aee486c9-e503-ce1a-9102-82712be2db62@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On 27/07/18 17:17, Stefan Wahren wrote:
> Hi,
> 
> i was noticed that recent linux-next on Raspberry Pi 3 (32 bit) doesn't boot anymore. So i tested todays linux-next with multi_v7_defconfig and i'm getting a lot of DMA mask not set warnings. At least USB dwc2 is broken.
> 
> Any suggestions before i start to bisect?

https://patchwork.kernel.org/patch/10547231/

Although the upside of this hiccup is that it should give us a fair view 
of how many active drivers are still relying on implicit default DMA 
masks - I'm now waiting for kernelci's boot chart to catch up with 
today's -next to see the full fallout...

Robin.

> 
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.18.0-rc6-next-20180727-ga7c3c081e (jenkins at golem) (gcc version 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #2 SMP Fri Jul 27 16:57:59 CEST 2018
> [    0.000000] CPU: ARMv7 Processor [410fd034] revision 4 (ARMv7), cr=10c5383d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] OF: fdt: Machine model: Raspberry Pi 3 Model B Rev 1.2
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: UEFI not found.
> [    0.000000] cma: Reserved 64 MiB at 0x37000000
> [    0.000000] On node 0 totalpages: 242688
> [    0.000000]   DMA zone: 1536 pages used for memmap
> [    0.000000]   DMA zone: 0 pages reserved
> [    0.000000]   DMA zone: 196608 pages, LIFO batch:63
> [    0.000000]   HighMem zone: 46080 pages, LIFO batch:15
> [    0.000000] random: get_random_bytes called from start_kernel+0xa0/0x46c with crng_init=0
> [    0.000000] percpu: Embedded 17 pages/cpu @(ptrval) s40012 r8192 d21428 u69632
> [    0.000000] pcpu-alloc: s40012 r8192 d21428 u69632 alloc=17*4096
> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 241152
> [    0.000000] Kernel command line: bcm2708_fb.fbwidth=1920 bcm2708_fb.fbheight=1200 bcm2708_fb.fbswap=1 dma.dmachans=0x7f35 bcm2709.boardrev=0xa02082 bcm2709.serial=0x53a68e44 bcm2709.uart_clock=48000000 smsc95xx.macaddr=B8:27:EB:A6:8E:44 vc_mem.mem_base=0x3ec00000 vc_mem.mem_size=0x40000000  dwc_otg.lpm_enable=0 root=PARTUUID=533cb580-02 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    0.000000] Memory: 875000K/970752K available (12288K kernel code, 1597K rwdata, 4656K rodata, 2048K init, 394K bss, 30216K reserved, 65536K cma-reserved, 118784K highmem)
> [    0.000000] Virtual kernel memory layout:
>                     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>                     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>                     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
>                     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
>                     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
>                     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
>                       .text : 0x(ptrval) - 0x(ptrval)   (13280 kB)
>                       .init : 0x(ptrval) - 0x(ptrval)   (2048 kB)
>                       .data : 0x(ptrval) - 0x(ptrval)   (1598 kB)
>                        .bss : 0x(ptrval) - 0x(ptrval)   ( 395 kB)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu:     RCU event tracing is enabled.
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=4.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> [    0.000009] Persistent clock returned invalid value
> [    0.000010] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 2147483647500ns
> [    0.000040] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
> [    0.000095] bcm2835: system timer (irq = 27)
> [    0.002422] arch_timer: cp15 timer(s) running at 19.20MHz (phys).
> [    0.002439] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
> [    0.002457] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
> [    0.002471] Switching to timer-based delay loop, resolution 52ns
> [    0.002982] Console: colour dummy device 80x30
> [    0.003582] console [tty0] enabled
> [    0.014272] Calibrating delay loop (skipped), value calculated using timer frequency.. 38.40 BogoMIPS (lpj=192000)
> [    0.014315] pid_max: default: 32768 minimum: 301
> [    0.015325] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.015362] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.018340] CPU: Testing write buffer coherency: ok
> [    0.018848] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.019850] Setting up static identity map for 0x300000 - 0x3000a0
> [    0.020755] rcu: Hierarchical SRCU implementation.
> [    0.023152] EFI services will not be available.
> [    0.023635] smp: Bringing up secondary CPUs ...
> [    0.024891] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.026166] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
> [    0.027377] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
> [    0.027468] smp: Brought up 1 node, 4 CPUs
> [    0.027533] SMP: Total of 4 processors activated (153.60 BogoMIPS).
> [    0.027551] CPU: All CPU(s) started in HYP mode.
> [    0.027566] CPU: Virtualization extensions available.
> [    0.030528] devtmpfs: initialized
> [    0.071604] VFP support v0.3: implementor 41 architecture 3 part 40 variant 3 rev 4
> [    0.072472] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    0.072539] futex hash table entries: 1024 (order: 4, 65536 bytes)
> [    0.075482] pinctrl core: initialized pinctrl subsystem
> [    0.080800] DMI not present or invalid.
> [    0.082911] NET: Registered protocol family 16
> [    0.086160] DMA: preallocated 256 KiB pool for atomic coherent allocations
> [    0.106203] cpuidle: using governor menu
> [    0.107555] No ATAGs?
> [    0.107671] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
> [    0.107709] hw-breakpoint: maximum watchpoint size is 8 bytes.
> [    0.113698] Serial: AMBA PL011 UART driver
> [    0.191547] AT91: Could not find identification node
> [    0.195875] vgaarb: loaded
> [    0.199761] SCSI subsystem initialized
> [    0.200266] libata version 3.00 loaded.
> [    0.201382] usbcore: registered new interface driver usbfs
> [    0.201647] usbcore: registered new interface driver hub
> [    0.201878] usbcore: registered new device driver usb
> [    0.204590] pps_core: LinuxPPS API ver. 1 registered
> [    0.204609] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.204714] PTP clock support registered
> [    0.205107] EDAC MC: Ver: 3.0.0
> [    0.212842] clocksource: Switched to clocksource arch_sys_counter
> [    0.462807] simple-framebuffer 3e795000.framebuffer: DMA mask not set
> [    0.463107] simple-framebuffer 3e795000.framebuffer: framebuffer at 0x3e795000, 0x465000 bytes, mapped to 0x(ptrval)
> [    0.463142] simple-framebuffer 3e795000.framebuffer: format=r5g6b5, mode=1920x1200x16, linelength=3840
> [    0.496923] Console: switching to colour frame buffer device 240x75
> [    0.526647] simple-framebuffer 3e795000.framebuffer: fb0: simplefb registered!
> [    0.563473] NET: Registered protocol family 2
> [    0.565612] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes)
> [    0.565835] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
> [    0.566113] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
> [    0.566436] TCP: Hash tables configured (established 8192 bind 8192)
> [    0.567046] UDP hash table entries: 512 (order: 2, 16384 bytes)
> [    0.567244] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
> [    0.568347] NET: Registered protocol family 1
> [    0.570011] RPC: Registered named UNIX socket transport module.
> [    0.570148] RPC: Registered udp transport module.
> [    0.570256] RPC: Registered tcp transport module.
> [    0.570363] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.570511] PCI: CLS 0 bytes, default 64
> [    0.578512] Initialise system trusted keyrings
> [    0.578985] workingset: timestamp_bits=31 max_order=18 bucket_order=0
> [    0.625547] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    0.629525] NFS: Registering the id_resolver key type
> [    0.629703] Key type id_resolver registered
> [    0.629802] Key type id 0.632750] pstore: using deflate compression
> [    0.635561] Key type asymmetric registered
> [    0.635669] Asymmetric key parser 'x509' registered
> [    0.635878] bounce: pool size: 64 pages
> [    0.636199] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
> [    0.636366] io scheduler noop registered
> [    0.636460] io scheduler deadline registered (default)
> [    0.637423] io scheduler cfq registered
> [    0.637518] io scheduler mq-deadline registered (default)
> [    0.637641] io scheduler kyber registered
> [    0.650713] pinctrl-bcm2835 3f200000.gpio: DMA mask not set
> [    0.660654] raspberrypi-exp-gpio soc:firmware:gpio: DMA mask not set
> [    0.663355] bcm2835-pwm 3f20c000.pwm: DMA mask not set
> [    0.670146] bcm2835-clk 3f101000.cprman: DMA mask not set
> [    0.677729] bcm2835-aux-clk 3f215000.aux: DMA mask not set
> [    0.683159] bcm2835-dma 3f007000.dma: DMA mask not set
> [    0.691692] raspberrypi-power soc:power: DMA mask not set
> [    0.909245] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    0.916259] bcm2835-aux-uart 3f215040.serial: DMA mask not set
> [    0.917416] 3f215040.serial: ttyS1 at MMIO 0x0 (irq = 53, base_baud = 31250000) is a 16550
> [    1.713104] console [ttyS1] enabled
> [    1.720042] SuperH (H)SCI(F) driver initialized
> [    1.726427] msm_serial: driver initialized
> [    1.730992] STMicroelectronics ASC driver initialized
> [    1.738028] STM32 USART driver initialized
> [    1.752012] bcm2835-rng 3f104000.rng: DMA mask not set
> [    1.764730] bcm2835-rng 3f104000.rng: hwrng registered
> [    1.829036] brd: module loaded
> [    1.886545] loop: module loaded
> [    1.915424] libphy: Fixed MDIO Bus: probed
> [    1.932571] CAN device driver interface
> [    1.944765] bgmac_bcma: Broadcom 47xx GBit MAC driver loaded
> [    1.959050] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [    1.972028] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    1.985348] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
> [    1.999458] igb: Copyright (c) 2007-2014 Intel Corporation.
> [    2.017748] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
> [    2.032553] usbcore: registered new interface driver pegasus
> [    2.045659] usbcore: registered new interface driver asix
> [    2.058380] usbcore: registered new interface driver ax88179_178a
> [    2.071755] usbcore: registered new interface driver cdc_ether
> [    2.084970] usbcore: registered new interface driver smsc75xx
> [    2.098074] usbcore: registered new interface driver smsc95xx
> [    2.111034] usbcore: registered new interface driver net1080
> [    2.123850] usbcore: registered new interface driver cdc_subset
> [    2.136810] usbcore: registered new interface driver zaurus
> [    2.149464] usbcore: registered new interface driver cdc_ncm
> [    2.164412] dwc2 3f980000.usb: DMA mask not set
> [    2.176475] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    2.189835] ehci-pci: EHCI PCI platform driver
> [    2.201236] ehci-platform: EHCI generic platform driver
> [    2.213486] ehci-orion: EHCI orion driver
> [    2.224389] SPEAr-ehci: EHCI SPEAr driver
> [    2.235172] ehci-st: EHCI STMicroelectronics driver
> [    2.246814] ehci-exynos: EHCI EXYNOS driver
> [    2.257679] ehci-atmel: EHCI Atmel driver
> [    2.268306] tegra-ehci: Tegra EHCI driver
> [    2.278867] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    2.291505] ohci-pci: OHCI PCI platform driver
> [    2.302420] ohci-platform: OHCI generic platform driver
> [    2.314193] SPEAr-ohci: OHCI SPEAr driver
> [    2.324666] ohci-st: OHCI STMicroelectronics driver
> [    2.336045] ohci-atmel: OHCI Atmel driver
> [    2.347487] usbcore: registered new interface driver usb-storage
> [    2.368401] i2c /dev entries driver
> [    2.378609] i2c-bcm2835 3f205000.i2c: DMA mask not set
> [    2.392038] i2c-bcm2835 3f804000.i2c: DMA mask not set
> [    2.405081] i2c-bcm2835 3f805000.i2c: DMA mask not set
> [    2.416670] i2c-bcm2835 3f805000.i2c: Could not read clock-frequency property
> [    2.445184] bcm2835-wdt 3f100000.watchdog: DMA mask not set
> [    2.458398] bcm2835-wdt 3f100000.watchdog: Broadcom BCM2835 watchdog timer
> [    2.476197] pwrseq_simple wifi-pwrseq: DMA mask not set
> [    2.488624] sdhci: Secure Digital Host Controller Interface driver
> [    2.501121] sdhci: Copyright(c) Pierre Ossman
> [    2.513793] Synopsys Designware Multimedia Card Interface Driver
> [    2.528271] sdhost-bcm2835 3f202000.mmc: DMA mask not set
> [    2.638855] sdhost-bcm2835 3f202000.mmc: loaded - DMA enabled (>1)
> [    2.651679] sdhci-pltfm: SDHCI platform and OF driver helper
> [    2.666407] sdhci-iproc 3f300000.sdhci: DMA mask not set
> [    2.710972] mmc1: SDHCI controller on 3f300000.sdhci [3f300000.sdhci] using PIO
> [    2.726155] leds-gpio leds: DMA mask not set
> [    2.737791] ledtrig-cpu: registered to indicate activity on CPUs
> [    2.750545] raspberrypi-firmware soc:firmware: DMA mask not set
> [    2.764183] usbcore: registered new interface driver usbhid
> [    2.776259] usbhid: USB HID core driver
> [    2.788025] bcm2835-mbox 3f00b880.mailbox: DMA mask not set
> [    2.800413] bcm2835-mbox 3f00b880.mailbox: mailbox enabled
> [    2.821379] NET: Registered protocol family 10
> [    2.835637] Segment Routing with IPv6
> [    2.845912] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [    2.861402] NET: Registered protocol family 17
> [    2.872312] can: controller area network core (rev 20170425 abi 9)
> [    2.885243] NET: Registered protocol family 29
> [    2.896104] can: raw protocol (rev 20170425)
> [    2.906717] can: broadcast manager protocol (rev 20170425 t)
> [    2.918732] can: netlink gateway (rev 20170425) max_hops=1
> [    2.931967] Key type dns_resolver registered
> [    2.943518] Registering SWP/SWPB emulation handler
> [    2.956819] Loading compiled-in X.509 certificates
> [    2.968248] kmemleak: Kernel memory leak detector initialized
> [    2.968258] kmemleak: Automatic memory scanning thread started
> [    2.991818] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
> [    3.007161] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
> [    3.010695] 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 (irq = 81, base_baud = 0) is a PL011 rev2
> [    3.019132] mmc0: host does not support reading read-only switch, assuming write-enable
> [    3.035352] serial serial0: tty port ttyAMA0 registered
> [    3.061177] mmc0: new high speed SDHC card at address 1234
> [    3.078288] ------------[ cut here ]------------
> [    3.079863] mmcblk0: mmc0:1234 SA32G 29.3 GiB
> [    3.089626] WARNING: CPU: 0 PID: 30 at ./include/linux/dma-mapping.h:516 rpi_firmware_property_list+0x2e8/0x318
> [    3.117462] Modules linked in:
> [    3.127137] CPU: 0 PID: 30 Comm: kworker/0:1 Not tainted 4.18.0-rc6-next-20180727-ga7c3c081e #2
> [    3.127143] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
> [    3.154895] Hardware name: BCM2835
> [    3.165075] Workqueue: events deferred_probe_work_func
> [    3.177118] [<c03125b4>] (unwind_backtrace) from [<c030d008>] (show_stack+0x10/0x14)
> [    3.191947] [<c030d008>] (show_stack) from [<c0e07268>] (dump_stack+0x8c/0xa0)
> [    3.206334] [<c0e07268>] (dump_stack) from [<c0345ea4>] (__warn+0xe0/0xf8)
> [    3.220407] [<c0345ea4>] (__warn) from [<c0345fd4>] (warn_slowpath_null+0x40/0x48)
> [    3.235295] [<c0345fd4>] (warn_slowpath_null) from [<c0c6dd9c>] (rpi_firmware_property_list+0x2e8/0x318)
> [    3.252277] [<c0c6dd9c>] (rpi_firmware_property_list) from [<c0c6de28>] (rpi_firmware_property+0x5c/0xa8)
> [    3.269469] [<c0c6de28>] (rpi_firmware_property) from [<c0c6df10>] (rpi_firmware_probe+0x9c/0x1a4)
> [    3.286058] [<c0c6df10>] (rpi_firmware_probe) from [<c0940184>] (platform_drv_probe+0x48/0x98)
> [    3.302292] [<c0940184>] (platform_drv_probe) from [<c093e360>] (really_probe+0x1d0/0x2bc)
> [    3.318164] [<c093e360>] (really_probe) from [<c093e5b0>] (driver_probe_device+0x60/0x160)
> [    3.334082] [<c093e5h_drv) from [<c093e120>] (__device_attach+0xd0/0x138)
> [    3.366359] [<c093e120>] (__device_attach) from [<c093d544>] (bus_probe_device+0x84/0x8c)
> [    3.382356] [<c093d544>] (bus_probe_device) from [<c093d9e0>] (deferred_probe_work_func+0x60/0x8c)
> [    3.399232] [<c093d9e0>] (deferred_probe_work_func) from [<c035f5d4>] (process_one_work+0x218/0x508)
> [    3.416365] [<c035f5d4>] (process_one_work) from [<c0360704>] (worker_thread+0x2a8/0x5c0)
> [    3.432611] [<c0360704>] (worker_thread) from [<c0365268>] (kthread+0x14c/0x154)
> [    3.448064] [<c0365268>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
> [    3.463343] Exception stack(0xeeae1fb0 to 0xeeae1ff8)
> [    3.476425] 1fa0:                                     00000000 00000000 00000000 00000000
> [    3.492794] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    3.509162] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    3.523947] ---[ end trace f293f8dc66336d54 ]---
> [    3.536678] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [    3.551663] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [    3.568281] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
> [    3.570451] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [    3.599101] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [    3.617393] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [    3.632381] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 1 config (-12 81)
> [    3.648706] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [    3.663671] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 1 config (-12 81)
> [    3.680011] pwrseq_simple: probe of wifi-pwrseq failed with error -12
> [    3.697439] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [    3.712488] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 2 config (-12 82)
> [    3.728869] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [    3.743928] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 2 state (-12 82)
> [    3.760262] leds-gpio: probe of leds failed with error -12
> [    3.776285] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [    3.793698] hctosys: unable to open rtc device (rtc0)
> [    3.808438]  mmcblk0: p1 p2
> [    3.826938] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [    3.828932] EXT4-fs (mmcblk0p2): INFO: recovery required on readonly filesystem
> [    3.857771] EXT4-fs (mmcblk0p2): write access will be enabled during recovery
> [    3.904641] EXT4-fs (mmcblk0p2): recovery complete
> [    3.930149] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
> [    3.946988] VFS: Mounted root (ext4 filesystem) readonly on device 179:2.
> [    3.963873] random: fast init done
> [    3.984683] devtmpfs: mounted
> [    3.999849] Freeing unused kernel memory: 2048K
> [    4.034028] mmc1: new high speed SDIO card at address 0001
> [    4.049793] Run /sbin/init as init process
> [    4.580123] systemd[1]: System time before build time, advancing clock.
> [    4.681042] random: systemd: uninitialized urandom read (16 bytes read)
> [    4.701146] systemd[1]: systemd 232 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
> [    4.729138] systemd[1]: Detected architecture arm.
> [    4.774225] systemd[1]: Set hostname to <raspberrypi>.
> [    4.853598] random: systemd: uninitialized urandom read (16 bytes read)
> [    4.862305] random: systemd-cryptse: uninitialized urandom read (16 bytes read)
> [    5.330756] systemd[1]: Created slice System Slice.
> [    5.378708] systemd[1]: Mounting Debug File System...
> [    5.424142] systemd[1]: Created slice system-serial\x2dgetty.slice.
> [    5.474304] systemd[1]: Listening on Journal Socket.
> [    5.523551] systemd[1]: Lis1]: Listening on Syslog Socket.
> [    7.030567] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
> [    7.285208] systemd-journald[104]: Received request to flush runtime journal from PID 1
> [    9.257387] usb_phy_generic phy: DMA mask not set
> [    9.257941] usb_phy_generic phy: phy supply vcc not found, using dummy regulator
> [    9.258318] usb_phy_generic phy: Linked as a consumer to regulator.0
> [    9.261015] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [    9.288550] vchiq: module is from the staging directory, the quality is unknown, you have been warned.
> [    9.296066] bcm2835_vchiq 3f00b840.mailbox: DMA mask not set
> [    9.302443] vchiq: vchiq_init_state: slot_zero = (ptrval), is_master = 0
> [    9.312104] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [    9.312120] bcm2835_vchiq 3f00b840.mailbox: failed to set channelbase
> [    9.312124] vchiq: could not load vchiq
> [    9.312268] bcm2835_vchiq: probe of 3f00b840.mailbox failed with error -12
> [    9.312919] Unable to handle kernel paging request at virtual address f0eea1b8
> [    9.329249] pgd = (ptrval)
> [    9.340867] [f0eea1b8] *pgd=2ebd5811, *pte=00000000, *ppte=00000000
> [    9.356099] Internal error: Oops: 7 [#1] SMP ARM
> [    9.369459] Modules linked in: vchiq(C) phy_generic
> [    9.383083] CPU: 0 PID: 184 Comm: vchiq-recy/0 Tainted: G        WC        4.18.0-rc6-next-20180727-ga7c3c081e #2
> [    9.402256] Hardware name: BCM2835
> [    9.414427] PC is at recycle_func+0xa0/0x504 [vchiq]
> [    9.414449] LR is at create_object+0x1e0/0x274
> [    9.432979] Unable to handle kernel paging request at virtual address f0eea02c
> [    9.441296] pc : [<bf00891c>]    lr : [<c047532c>]    psr: a0000113
> [    9.457653] pgd = (ptrval)
> [    9.472561] sp : ed49bf00  ip : ec922168  fp : bf01d3a4
> [    9.472567] r10: bf01d000  r9 : bf00887c  r8 : bf01d3a4
> [    9.472572] r7 : ed49a000  r6 : f0eea194  r5 : ecbdf7c0  r4 : c1604c48
> [    9.472578] r3 : bf01d6d4  r2 : bf018d14  r1 : bf01d4ae  r0 : eca88600
> [    9.472586] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [    9.472591] Control: 10c5383d  Table: 2d4b406a  DAC: 00000051
> [    9.472602] Process vchiq-recy/0 (pid: 184, stack limit = 0x(ptrval))
> [    9.472608] Stack: (0xed49bf00 to 0xed49c000)
> [    9.472625] bf00: c1604c48 ed3288c0 ed329880 c0f074a4 eca88600 c0e1fad8 00000001 bf01d340
> [    9.484216] [f0eea02c] *pgd=2ebd5811
> [    9.498090] bf20: c036f674 ed4a5ba4 00000000 bf01d6b4 f0eea194 bf01d4ac bf01d4ae bf01d6d4
> [    9.498103] bf40: fff9fee9 bf018d14 00000000 1c9102d0 ffffe000 ffffe000 ecbdf7c0 1c9102d0
> [    9.498114] bf60: ffffe000 ecbdf840 ecbdf7c0 00000000 ed49a000 bf01d3a4 bf00887c ed4a5b9c
> [    9.498125] bf80: ecbdf85c c0365268 ed49a000 ecbdf7c0 c036511c 00000000 00000000 00000000
> [    9.498136] bfa0: 00000000 00000000 00000000 c03010e8 00000000 00000000 00000000 00000000
> [    9.511899] , *pte=00000000
> [    9.526889] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    9.526900] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [    9.526965] [<bf00891c>] (recycle_func [vchiq]) from [<c0365268>] (kthread+0x14c/0x154)
> [    9.541964] , *ppte=00000000
> [    9.557598] [<c0365268>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
> [    9.557605] Exception stack(0xed49bfb0 to 0xed49bff8)
> [    9.557618] bfa0:                                     00000000 00000000 00000000 00000000
> [    9.587013] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    9.587023] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    9.587038] Code: e58d1038 e58d2044 e58d303c e59d6030 (e5963024)
> [    9.587187] ---[ end trace f293f8dc66336d55 ]---
> [    9.600177] Internal error: Oops: 7 [#2] SMP ARM
> [    9.600187] Modules linked in: vchiq(C) phy_generic
> [    9.918623] CPU: 3 PID: 185 Comm: vchiq-sync/0 Tainted: G      D WC        4.18.0-rc6-next-20180727-ga7c3c081e #2
> [    9.937590] Hardware name: BCM2835
> [    9.949561] PC is at sync_func+0x20/0x454 [vchiq]
> [    9.962826] LR is at kthread+0x14c/0x154
> [    9.975249] pc : [<bf00b28c>]    lr : [<c0365268>]    psr: 60000113
> [    9.990052] sp : ed4a3f10  ip : 00000000  fp : ecbdf89c
> [   10.003760] r10: bf01d3a4  r9 : bf00b26c  r8 : bf01d3a4
> [   10.017442] r7 : f0eea000  r6 : 00000000  r5 : ecbdf7c0  r4 : ecbdf880
> [   10.032474] r3 : c1604c48  r2 : f0eea020  r1 : 00008104  r0 : bf01d3a4
> [   10.047478] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   10.063112] Control: 10c5383d  Table: 2cbf806a  DAC: 00000051
> [   10.077336] Process vchiq-sync/0 (pid: 185, stack limit = 0x(ptrval))
> [   10.092297] Stack: (0xed4a3f10 to 0xed4a4000)
> [   10.105113] 3f00:                                     ed4a3f74 c0e1fad8 00000001 00000000
> [   10.121882] 3f20: c036f674 ed4a5ba4 00000000 00000003 00000000 c0e20010 2e2c4000 00000000
> [   10.138644] 3f40: c160504c ed4a5ba0 00000000 1c9102d0 ffffe000 ffffe000 ecbdf7c0 00000000
> [   10.155437] 3f60: ffffe000 ecbdf880 ecbdf7c0 00000000 ed4a2000 bf01d3a4 bf00b26c ed4a5b9c
> [   10.172282] 3f80: ecbdf89c c0365268 ed4a2000 ecbdf7c0 c036511c 00000000 00000000 00000000
> [   10.189155] 3fa0: 00000000 00000000 00000000 c03010e8 00000000 00000000 00000000 00000000
> [   10.206020] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   10.222810] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [   10.239557] [<bf00b28c>] (sync_func [vchiq]) from [<c0365268>] (kthread+0x14c/0x154)
> [   10.255641] [<c0365268>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
> [   10.270984] Exception stack(0xed4a3fb0 to 0xed4a3ff8)
> [   10.284144] 3fa0:                                     00000000 00000000 00000000 00000000
> [   10.300574] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   10.316977] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [   10.331689] Code: e24dd054 e1a0a000 e590701c e3081104 (e592200c)
> [   10.346043] ---[ end trace f293f8dc66336d56 ]---
> [   10.393838] bcm2835_thermal 3f212000.thermal: DMA mask not set
> [   10.415335] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [   10.580443] Bluetooth: Core ver 2.22
> [   10.593233] NET: Registered protocol family 31
> [   10.606478] Bluetooth: HCI device and connection manager initialized
> [   10.607170] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [   10.621224] Bluetooth: HCI socket layer initialized
> [   10.649592] Bluetooth: L2CAP socket layer initialized
> [   10.663309] Bluetooth: SCO socket layer initialized
> [   10.752085] vc4_hdmi 3f902000.hdmi: DMA mask not set
> [   10.753745] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [   10.759514] Bluetooth: HCI UART driver ver 2.3
> [   10.759522] Bluetooth: HCI UART protocol H4 registered
> [   10.760447] Bluetooth: HCI UART protocol Broadcom registered
> [   10.765381] vc4_hdmi 3f902000.hdmi: ignoring dependency for device, assuming no driver
> [   10.792736] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [   10.794558] vc4_vec 3f806000.vec: DMA mask not set
> [   10.806949] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 0 config (-12 80)
> [   10.820766] vc4_vec 3f806000.vec: ignoring dependency for device, assuming no driver
> [   10.836720] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [   10.853492] vc4_txp 3f004000.txp: DMA mask not set
> [   10.864487] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 0 config (-12 80)
> [   10.881993] vc4_hvs 3f400000.hvs: DMA mask not set
> [   10.896999] hci_uart_bcm: probe of serial0-0 failed with error -12
> [   10.913229] vc4_crtc 3f206000.pixelvalve: DMA mask not set
> [   10.984006] vc4_crtc 3f207000.pixelvalve: DMA mask not set
> [   10.998261] vc4_crtc 3f807000.pixelvalve: DMA mask not set
> [   11.013158] vc4_v3d 3fc00000.v3d: DMA mask not set
> [   11.026147] vc4_v3d 3fc00000.v3d: ignoring dependency for device, assuming no driver
> [   11.045844] vc4-drm soc:gpu: DMA mask not set
> [   11.047230] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [   11.077151] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [   11.126816] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [   11.153729] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
> [   11.171215] cfg80211: failed to load regulatory.db
> [   11.213364] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> [   11.247322] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43430-sdio for chip BCM43430/1
> [   11.272510] raspberrypi-firmware soc:firmware: coherent DMA mask is unset
> 
