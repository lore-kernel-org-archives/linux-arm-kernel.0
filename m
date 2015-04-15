From: mwelling@ieee.org (Michael Welling)
Date: Wed, 15 Apr 2015 09:09:45 -0500
Subject: AM335x OMAP2 common clock external fixed-clock registration
In-Reply-To: <552E0688.1020903@ti.com>
References: <20150414211734.GA28974@deathray>
 <552E0688.1020903@ti.com>
Message-ID: <20150415140945.GA30787@deathray>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 15, 2015 at 09:34:48AM +0300, Tero Kristo wrote:
> On 04/15/2015 12:17 AM, Michael Welling wrote:
> >Greetings,
> >
> >I have developed an AM3354 based SoM and it uses an external SI5351 clock
> >generator to drive the clock inputs for an external duart and I2S audio
> >master clock. With the registration according to the documentation the
> >reference clock is not being detected and hence the clock generator is
> >not working as expect.
> >
> >After trying many different things, I started to look around the mailing
> >lists to find information related to this issue.
> >
> >I came acrossed post that has the exact same issue:
> >https://lkml.org/lkml/2013/2/18/468
> >
> >Seeing as the patch did not land upstream, I am wondering if there is
> >a solution that I am not seeing.
> >
> >I am willing to provide a patch given appropriate guidance.
> 
> Hi Michael,
> 
> The info on the email you referenced is kind of obsolete, TI SoCs
> are calling of_clk_init() during boot now, and thus external clock
> nodes should be registered fine also. Maybe you can provide the
> actual DTS patch you are trying out so we can help better...? Are

See attached patch and console output.

> you seeing any boot time error / warning prints for your new clock?

With the debug messages on you see that the reference clock is not being
detected.

Whilest debugging I found that the of_clk_get is returning an error no matter
which clock I pass it:
http://lxr.free-electrons.com/source/drivers/clk/clk-si5351.c#L1131

> 
> -Tero
-------------- next part --------------
A non-text attachment was scrubbed...
Name: som-3354.patch
Type: text/x-diff
Size: 14862 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150415/fb6fcefc/attachment-0001.bin>
-------------- next part --------------
U-Boot SPL 2015.04-rc2-00210-g26fcaa0-dirty (Mar 18 2015 - 15:49:29)


U-Boot 2015.04-rc2-00210-g26fcaa0-dirty (Mar 18 2015 - 15:49:29)

       Watchdog enabled
I2C:   ready
DRAM:  512 MiB
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
SF: Detected N25Q128 with page size 256 Bytes, erase size 64 KiB, total 16 MiB
Net:   cpsw, usb_ether
Hit any key to stop autoboot:  0 
cpsw Waiting for PHY auto negotiation to complete.. done
link up on port 0, speed 100, full duplex
Using cpsw device
TFTP from server 192.168.1.1; our IP address is 192.168.1.2
Filename 'zImage-3354'.
Load address: 0x82000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #########################################
         2.9 MiB/s
done
Bytes transferred = 5200008 (4f5888 hex)
Kernel image @ 0x82000000 [ 0x000000 - 0x4ed668 ]

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.0.0-rc7-00016-g7b43b47-dirty (michael at deathray) (gcc version 4.9.1 (GCC) ) #11 SMP Tue Apr 14 18:51:01 CDT 2015
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: EMAC SOM-3354M SOM-200ES
[    0.000000] cma: Reserved 16 MiB at 0x9e800000
[    0.000000] Memory policy: Data cache writeback
[    0.000000] On node 0 totalpages: 130816
[    0.000000] free_area_init_node: node 0, pgdat c0a529c0, node_mem_map dfa71000
[    0.000000]   Normal zone: 1152 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 130816 pages, LIFO batch:31
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] AM335X ES2.1 (sgx neon )
[    0.000000] PERCPU: Embedded 12 pages/cpu @dfa18000 s18496 r8192 d22464 u49152
[    0.000000] pcpu-alloc: s18496 r8192 d22464 u49152 alloc=12*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129664
[    0.000000] Kernel command line: console=ttyO0,115200n8 root=/dev/mmcblk0p1 ro rootfstype=ext4 rootwait debug earlyprintk=serial
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 482612K/523264K available (6794K kernel code, 642K rwdata, 2680K rodata, 444K init, 8243K bss, 24268K reserved, 16384K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0948e50   (9476 kB)
[    0.000000]       .init : 0xc0949000 - 0xc09b8000   ( 444 kB)
[    0.000000]       .data : 0xc09b8000 - 0xc0a58ac0   ( 643 kB)
[    0.000000]        .bss : 0xc0a58ac0 - 0xc12658b0   (8244 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Additional per-CPU info printed with stalls.
[    0.000000]  RCU restricting CPUs from NR_CPUS=2 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 interrupts
[    0.000000] OMAP clockevent source: timer2 at 26000000 Hz
[    0.000017] sched_clock: 32 bits at 26MHz, resolution 38ns, wraps every 165191049177ns
[    0.000069] OMAP clocksource: timer1 at 26000000 Hz
[    0.000896] Console: colour dummy device 80x30
[    0.000950] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000959] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000967] ... MAX_LOCK_DEPTH:          48
[    0.000975] ... MAX_LOCKDEP_KEYS:        8191
[    0.000983] ... CLASSHASH_SIZE:          4096
[    0.000990] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.000998] ... MAX_LOCKDEP_CHAINS:      65536
[    0.001005] ... CHAINHASH_SIZE:          32768
[    0.001012]  memory used by lock dependency info: 5167 kB
[    0.001021]  per task-struct memory footprint: 1152 bytes
[    0.001046] Calibrating delay loop... 996.14 BogoMIPS (lpj=4980736)
[    0.078896] pid_max: default: 32768 minimum: 301
[    0.079243] Security Framework initialized
[    0.079405] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.079420] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.082267] Initializing cgroup subsys blkio
[    0.082310] Initializing cgroup subsys memory
[    0.082399] Initializing cgroup subsys devices
[    0.082495] Initializing cgroup subsys freezer
[    0.082618] Initializing cgroup subsys perf_event
[    0.082698] CPU: Testing write buffer coherency: ok
[    0.084030] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.084142] Setting up static identity map for 0x806748a0 - 0x80674910
[    0.087552] Brought up 1 CPUs
[    0.087575] SMP: Total of 1 processors activated (996.14 BogoMIPS).
[    0.087586] CPU: All CPU(s) started in SVC mode.
[    0.090919] devtmpfs: initialized
[    0.093098] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
[    0.130337] omap_hwmod: tptc0 using broken dt data from edma
[    0.130713] omap_hwmod: tptc1 using broken dt data from edma
[    0.131067] omap_hwmod: tptc2 using broken dt data from edma
[    0.139043] omap_hwmod: debugss: _wait_target_disable failed
[    0.196258] pinctrl core: initialized pinctrl subsystem
[    0.230071] NET: Registered protocol family 16
[    0.235694] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.237787] cpuidle: using governor ladder
[    0.237817] cpuidle: using governor menu
[    0.244784] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.245577] OMAP GPIO hardware version 0.1
[    0.246826] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.248668] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.250522] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.263655] omap-gpmc 50000000.gpmc: could not find pctldev for node /pinmux at 44e10800/pinmux_gpmc_pins, deferring probe
[    0.263699] platform 50000000.gpmc: Driver omap-gpmc requests probe deferral
[    0.267534] No ATAGs?
[    0.267564] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.310333] edma-dma-engine edma-dma-engine.0: TI EDMA DMA engine driver
[    0.311153] of_get_named_gpiod_flags: can't parse 'gpio' property of node '/fixedregulator at 0[0]'
[    0.314814] SCSI subsystem initialized
[    0.315615] libata version 3.00 loaded.
[    0.316335] usbcore: registered new interface driver usbfs
[    0.316489] usbcore: registered new interface driver hub
[    0.316637] usbcore: registered new device driver usb
[    0.317421] omap_i2c 44e0b000.i2c: could not find pctldev for node /pinmux at 44e10800/pinmux_i2c0_pins, deferring probe
[    0.317459] platform 44e0b000.i2c: Driver omap_i2c requests probe deferral
[    0.321703] Switched to clocksource timer1
[    0.454603] NET: Registered protocol family 2
[    0.456449] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.456627] TCP bind hash table entries: 4096 (order: 5, 147456 bytes)
[    0.457823] TCP: Hash tables configured (established 4096 bind 4096)
[    0.458016] TCP: reno registered
[    0.458043] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.458214] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.459115] NET: Registered protocol family 1
[    0.460640] RPC: Registered named UNIX socket transport module.
[    0.460661] RPC: Registered udp transport module.
[    0.460672] RPC: Registered tcp transport module.
[    0.460681] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.462896] hw perfevents: enabled with armv7_cortex_a8 PMU driver, 5 counters available
[    0.467119] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.467432] audit: initializing netlink subsys (disabled)
[    0.467656] audit: type=2000 audit(0.460:1): initialized
[    0.472263] VFS: Disk quotas dquot_6.5.2
[    0.472413] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.474597] NFS: Registering the id_resolver key type
[    0.474963] Key type id_resolver registered
[    0.474978] Key type id_legacy registered
[    0.475147] jffs2: version 2.2. (NAND) (SUMMARY)  ?? 2001-2006 Red Hat, Inc.
[    0.479406] io scheduler noop registered
[    0.479439] io scheduler deadline registered
[    0.479491] io scheduler cfq registered (default)
[    0.481388] pinctrl-single 44e10800.pinmux: 142 pins at pa f9e10800 size 568
[    0.487822] pwm-backlight backlight: GPIO lookup for consumer enable
[    0.487848] pwm-backlight backlight: using device tree for GPIO lookup
[    0.487868] of_get_named_gpiod_flags: can't parse 'enable-gpios' property of node '/backlight[0]'
[    0.487881] of_get_named_gpiod_flags: can't parse 'enable-gpio' property of node '/backlight[0]'
[    0.487893] pwm-backlight backlight: using lookup tables for GPIO lookup
[    0.488064] pwm-backlight backlight: lookup for GPIO enable failed
[    0.488094] backlight supply power not found, using dummy regulator
[    0.492042] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.497622] omap_uart 44e09000.serial: no wakeirq for uart0
[    0.497656] of_get_named_gpiod_flags: can't parse 'rts-gpio' property of node '/ocp/serial at 44e09000[0]'
[    0.498244] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 154, base_baud = 3000000) is a OMAP UART0
[    1.342107] console [ttyO0] enabled
[    1.347792] omap_uart 48022000.serial: no wakeirq for uart0
[    1.353813] of_get_named_gpiod_flags: can't parse 'rts-gpio' property of node '/ocp/serial at 48022000[0]'
[    1.363990] 48022000.serial: ttyO1 at MMIO 0x48022000 (irq = 155, base_baud = 3000000) is a OMAP UART1
[    1.377472] omap_rng 48310000.rng: OMAP Random Number Generator ver. 20
[    1.385070] [drm] Initialized drm 1.1.0 20060810
[    1.390764] panel panel: GPIO lookup for consumer enable
[    1.396416] panel panel: using device tree for GPIO lookup
[    1.402219] of_get_named_gpiod_flags: parsed 'enable-gpios' property of node '/panel[0]' - status (0)
[    1.411970] panel panel: found enable GPIO
[    1.422597] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.429523] [drm] No driver support for vblank timestamp query.
[    1.472792] Console: switching to colour frame buffer device 60x34
[    1.480225] tilcdc 4830e000.lcdc: fb0:  frame buffer device
[    1.486110] tilcdc 4830e000.lcdc: registered panic notifier
[    1.492027] [drm] Initialized tilcdc 1.0.0 20121205 on minor 0
[    1.524479] brd: module loaded
[    1.543800] loop: module loaded
[    1.552121] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.560212] of_get_named_gpiod_flags: parsed 'cs-gpios' property of node '/ocp/spi at 48030000[0]' - status (0)
[    1.570611] of_get_named_gpiod_flags: parsed 'cs-gpios' property of node '/ocp/spi at 48030000[1]' - status (0)
[    1.587500] gpiochip_find_base: found new base at 504
[    1.593627] gpiochip_add: registered GPIOs 504 to 511 on device: mcp23s08
[    1.602666] m25p80 spi1.0: unrecognized JEDEC id bytes: ff, ff, ff
[    1.610113] CAN device driver interface
[    1.617177] c_can_platform 481cc000.can: c_can_platform device registered (regs=fa1cc000, irq=160)
[    1.628530] usbcore: registered new interface driver asix
[    1.634458] usbcore: registered new interface driver ax88179_178a
[    1.640937] usbcore: registered new interface driver cdc_ether
[    1.647236] usbcore: registered new interface driver smsc95xx
[    1.653382] usbcore: registered new interface driver net1080
[    1.659400] usbcore: registered new interface driver cdc_subset
[    1.665743] usbcore: registered new interface driver zaurus
[    1.671794] usbcore: registered new interface driver cdc_ncm
[    1.679037] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.685995] ehci-omap: OMAP-EHCI Host Controller driver
[    1.692040] usbcore: registered new interface driver cdc_wdm
[    1.698144] usbcore: registered new interface driver usb-storage
[    1.707480] am335x-phy-driver 47401300.usb-phy: GPIO lookup for consumer reset
[    1.715121] am335x-phy-driver 47401300.usb-phy: using device tree for GPIO lookup
[    1.722974] of_get_named_gpiod_flags: can't parse 'reset-gpios' property of node '/ocp/usb at 47400000/usb-phy at 47401300[0]'
[    1.734351] of_get_named_gpiod_flags: can't parse 'reset-gpio' property of node '/ocp/usb at 47400000/usb-phy at 47401300[0]'
[    1.745631] am335x-phy-driver 47401300.usb-phy: using lookup tables for GPIO lookup
[    1.753657] am335x-phy-driver 47401300.usb-phy: lookup for GPIO reset failed
[    1.761022] am335x-phy-driver 47401300.usb-phy: GPIO lookup for consumer vbus-detect
[    1.769128] am335x-phy-driver 47401300.usb-phy: using device tree for GPIO lookup
[    1.776967] of_get_named_gpiod_flags: can't parse 'vbus-detect-gpios' property of node '/ocp/usb at 47400000/usb-phy at 47401300[0]'
[    1.788884] of_get_named_gpiod_flags: can't parse 'vbus-detect-gpio' property of node '/ocp/usb at 47400000/usb-phy at 47401300[0]'
[    1.800708] am335x-phy-driver 47401300.usb-phy: using lookup tables for GPIO lookup
[    1.808726] am335x-phy-driver 47401300.usb-phy: lookup for GPIO vbus-detect failed
[    1.816722] 47401300.usb-phy supply vcc not found, using dummy regulator
[    1.828233] musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
[    1.839396] musb-hdrc: MHDRC RTL version 2.0 
[    1.843980] musb-hdrc: setup fifo_mode 4
[    1.848086] musb-hdrc: 28/31 max ep, 16384/16384 memory
[    1.853892] musb-hdrc musb-hdrc.0.auto: MUSB HDRC host driver
[    1.862785] musb-hdrc musb-hdrc.0.auto: new USB bus registered, assigned bus number 1
[    1.873128] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.880229] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.887849] usb usb1: Product: MUSB HDRC host driver
[    1.893062] usb usb1: Manufacturer: Linux 4.0.0-rc7-00016-g7b43b47-dirty musb-hcd
[    1.900876] usb usb1: SerialNumber: musb-hdrc.0.auto
[    1.910221] hub 1-0:1.0: USB hub found
[    1.914819] hub 1-0:1.0: 1 port detected
[    1.925676] am335x-phy-driver 47401b00.usb-phy: GPIO lookup for consumer reset
[    1.933374] am335x-phy-driver 47401b00.usb-phy: using device tree for GPIO lookup
[    1.941204] of_get_named_gpiod_flags: can't parse 'reset-gpios' property of node '/ocp/usb at 47400000/usb-phy at 47401b00[0]'
[    1.952593] of_get_named_gpiod_flags: can't parse 'reset-gpio' property of node '/ocp/usb at 47400000/usb-phy at 47401b00[0]'
[    1.963876] am335x-phy-driver 47401b00.usb-phy: using lookup tables for GPIO lookup
[    1.971898] am335x-phy-driver 47401b00.usb-phy: lookup for GPIO reset failed
[    1.979262] am335x-phy-driver 47401b00.usb-phy: GPIO lookup for consumer vbus-detect
[    1.987368] am335x-phy-driver 47401b00.usb-phy: using device tree for GPIO lookup
[    1.995205] of_get_named_gpiod_flags: can't parse 'vbus-detect-gpios' property of node '/ocp/usb at 47400000/usb-phy at 47401b00[0]'
[    2.007133] of_get_named_gpiod_flags: can't parse 'vbus-detect-gpio' property of node '/ocp/usb at 47400000/usb-phy at 47401b00[0]'
[    2.018958] am335x-phy-driver 47401b00.usb-phy: using lookup tables for GPIO lookup
[    2.026983] am335x-phy-driver 47401b00.usb-phy: lookup for GPIO vbus-detect failed
[    2.034981] 47401b00.usb-phy supply vcc not found, using dummy regulator
[    2.045415] musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
[    2.056499] musb-hdrc: MHDRC RTL version 2.0 
[    2.061048] musb-hdrc: setup fifo_mode 4
[    2.065175] musb-hdrc: 28/31 max ep, 16384/16384 memory
[    2.070936] musb-hdrc musb-hdrc.1.auto: MUSB HDRC host driver
[    2.080720] musb-hdrc musb-hdrc.1.auto: new USB bus registered, assigned bus number 2
[    2.089811] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    2.096956] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.104521] usb usb2: Product: MUSB HDRC host driver
[    2.109706] usb usb2: Manufacturer: Linux 4.0.0-rc7-00016-g7b43b47-dirty musb-hcd
[    2.117540] usb usb2: SerialNumber: musb-hdrc.1.auto
[    2.124711] hub 2-0:1.0: USB hub found
[    2.128756] hub 2-0:1.0: 1 port detected
[    2.137652] mousedev: PS/2 mouse device common for all mice
[    2.147011] input: ti-tsc as /devices/platform/ocp/44e0d000.tscadc/TI-am335x-tsc/input/input0
[    2.159357] omap_rtc 44e3e000.rtc: already running
[    2.166056] omap_rtc 44e3e000.rtc: rtc core: registered 44e3e000.rtc as rtc0
[    2.174300] i2c /dev entries driver
[    2.178022] Driver for 1-wire Dallas network protocol.
[    2.186852] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60 sec
[    2.195305] Driver 'mmcblk' needs updating - please use bus_type methods
[    2.203477] omap_hsmmc 48060000.mmc: GPIO lookup for consumer cd
[    2.209761] omap_hsmmc 48060000.mmc: using device tree for GPIO lookup
[    2.216657] of_get_named_gpiod_flags: can't parse 'cd-gpios' property of node '/ocp/mmc at 48060000[0]'
[    2.226223] of_get_named_gpiod_flags: can't parse 'cd-gpio' property of node '/ocp/mmc at 48060000[0]'
[    2.235740] omap_hsmmc 48060000.mmc: using lookup tables for GPIO lookup
[    2.242773] omap_hsmmc 48060000.mmc: lookup for GPIO cd failed
[    2.248873] omap_hsmmc 48060000.mmc: GPIO lookup for consumer wp
[    2.255167] omap_hsmmc 48060000.mmc: using device tree for GPIO lookup
[    2.262006] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/ocp/mmc at 48060000[0]'
[    2.271564] of_get_named_gpiod_flags: can't parse 'wp-gpio' property of node '/ocp/mmc at 48060000[0]'
[    2.281009] omap_hsmmc 48060000.mmc: using lookup tables for GPIO lookup
[    2.288030] omap_hsmmc 48060000.mmc: lookup for GPIO wp failed
[    2.332232] omap_hsmmc 481d8000.mmc: GPIO lookup for consumer cd
[    2.338525] omap_hsmmc 481d8000.mmc: using device tree for GPIO lookup
[    2.345420] of_get_named_gpiod_flags: can't parse 'cd-gpios' property of node '/ocp/mmc at 481d8000[0]'
[    2.354988] of_get_named_gpiod_flags: can't parse 'cd-gpio' property of node '/ocp/mmc at 481d8000[0]'
[    2.364456] omap_hsmmc 481d8000.mmc: using lookup tables for GPIO lookup
[    2.371458] omap_hsmmc 481d8000.mmc: lookup for GPIO cd failed
[    2.377577] omap_hsmmc 481d8000.mmc: GPIO lookup for consumer wp
[    2.383870] omap_hsmmc 481d8000.mmc: using device tree for GPIO lookup
[    2.390689] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/ocp/mmc at 481d8000[0]'
[    2.400248] of_get_named_gpiod_flags: can't parse 'wp-gpio' property of node '/ocp/mmc at 481d8000[0]'
[    2.409712] omap_hsmmc 481d8000.mmc: using lookup tables for GPIO lookup
[    2.416751] omap_hsmmc 481d8000.mmc: lookup for GPIO wp failed
[    2.462627] of_get_named_gpiod_flags: parsed 'gpios' property of node '/leds/led at 0[0]' - status (0)
[    2.473310] ledtrig-cpu: registered to indicate activity on CPUs
[    2.480119] usbcore: registered new interface driver usbhid
[    2.486056] usbhid: USB HID core driver
[    2.491721] oprofile: using arm/armv7
[    2.496361] TCP: cubic registered
[    2.499867] Initializing XFRM netlink socket
[    2.504577] NET: Registered protocol family 17
[    2.509299] NET: Registered protocol family 15
[    2.514002] can: controller area network core (rev 20120528 abi 9)
[    2.520614] NET: Registered protocol family 29
[    2.525393] can: raw protocol (rev 20120528)
[    2.529977] can: broadcast manager protocol (rev 20120528 t)
[    2.535965] can: netlink gateway (rev 20130117) max_hops=1
[    2.542166] Key type dns_resolver registered
[    2.546894] omap_voltage_late_init: Voltage driver support not added
[    2.553619] sr_dev_init: No voltage domain specified for smartreflex0. Cannot initialize
[    2.562108] sr_dev_init: No voltage domain specified for smartreflex1. Cannot initialize
[    2.571316] platform cpufreq-dt.0: Driver cpufreq-dt requests probe deferral
[    2.579506] ThumbEE CPU extension supported.
[    2.584079] Registering SWP/SWPB emulation handler
[    2.589096] SmartReflex Class3 initialized
[    2.594904] mmc0: MAN_BKOPS_EN bit is not set
[    2.605746] mmc0: new high speed MMC card at address 0001
[    2.614855] omap-gpmc 50000000.gpmc: GPMC revision 6.0
[    2.620417] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
[    2.632159] mmcblk0: mmc0:0001 MMC04G 3.52 GiB 
[    2.637681] mmcblk0boot0: mmc0:0001 MMC04G partition 1 16.0 MiB
[    2.647490] 8000000.uart: ttyS0 at MMIO 0x8000000 (irq = 0, base_baud = 1152000) is a 16550A
[    2.658129] mmcblk0boot1: mmc0:0001 MMC04G partition 2 16.0 MiB
[    2.670556]  mmcblk0: p1
[    2.677387] 8000008.uart: ttyS1 at MMIO 0x8000008 (irq = 0, base_baud = 1152000) is a 16550A
[    2.711807] usb 2-1: new high-speed USB device number 2 using musb-hdrc
[    2.720331] tps65910 0-002d: No interrupt support, no core IRQ
[    2.734918] vrtc: supplied by vmain
[    2.742218] vio: supplied by vmain
[    2.749188] vdd_mpu: supplied by vmain
[    2.756594] vdd_core: supplied by vmain
[    2.765485] vdig1: supplied by vmain
[    2.772734] vdig2: supplied by vmain
[    2.779296] vpll: supplied by vmain
[    2.786243] vdac: supplied by vmain
[    2.792857] vaux1: supplied by vmain
[    2.799242] vaux2: supplied by vmain
[    2.805891] vaux33: supplied by vmain
[    2.812617] vmmc: supplied by vmain
[    2.819067] vbb: supplied by vmain
[    2.829270] si5351 0-0060: si5351_pll_recalc_rate - plla: p1 = 261632, p2 = 0, p3 = 1, parent_rate = 0, rate = 0
[    2.845198] si5351 0-0060: si5351_msynth_recalc_rate - ms0: p1 = 5632, p2 = 0, p3 = 1, m = 6144, parent_rate = 0, rate = 0
[    2.860877] si5351 0-0060: si5351_clkout_round_rate - clk0: rdiv = 1, parent_rate = 18432000, rate = 18432000
[    2.871292] si5351 0-0060: si5351_msynth_round_rate - ms0: a = 48, b = 0, c = 1, divby4 = 0, parent_rate = 884736000, rate = 18432000
[    2.883849] Division by zero in kernel.
[    2.887862] CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted 4.0.0-rc7-00016-g7b43b47-dirty #11
[    2.896602] Hardware name: Generic AM33XX (Flattened Device Tree)
[    2.903008] Workqueue: deferwq deferred_probe_work_func
[    2.908505] [<c0015be4>] (unwind_backtrace) from [<c0012258>] (show_stack+0x10/0x14)
[    2.916631] [<c0012258>] (show_stack) from [<c066bbdc>] (dump_stack+0x84/0x9c)
[    2.924211] [<c066bbdc>] (dump_stack) from [<c031d8ec>] (Ldiv0+0x8/0x10)
[    2.931224] [<c031d8ec>] (Ldiv0) from [<c05704a0>] (si5351_pll_round_rate+0x3c/0x190)
[    2.939430] [<c05704a0>] (si5351_pll_round_rate) from [<c056caa8>] (clk_calc_new_rates+0x1dc/0x260)
[    2.948902] [<c056caa8>] (clk_calc_new_rates) from [<c056c9c8>] (clk_calc_new_rates+0xfc/0x260)
[    2.958005] Division by zero in kernel.
[    2.962030] CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted 4.0.0-rc7-00016-g7b43b47-dirty #11
[    2.970748] Hardware name: Generic AM33XX (Flattened Device Tree)
[    2.977133] Workqueue: deferwq deferred_probe_work_func
[    2.982622] [<c0015be4>] (unwind_backtrace) from [<c0012258>] (show_stack+0x10/0x14)
[    2.990712] [<c0012258>] (show_stack) from [<c066bbdc>] (dump_stack+0x84/0x9c)
[    2.998279] [<c066bbdc>] (dump_stack) from [<c031d8ec>] (Ldiv0+0x8/0x10)
[    3.005312] [<c031d8ec>] (Ldiv0) from [<c031d8bc>] (__aeabi_uidivmod+0x8/0x18)
[    3.012879] [<c031d8bc>] (__aeabi_uidivmod) from [<c05704c8>] (si5351_pll_round_rate+0x64/0x190)
[    3.022078] [<c05704c8>] (si5351_pll_round_rate) from [<c056caa8>] (clk_calc_new_rates+0x1dc/0x260)
[    3.031560] [<c056caa8>] (clk_calc_new_rates) from [<c056c9c8>] (clk_calc_new_rates+0xfc/0x260)
[    3.040641] Division by zero in kernel.
[    3.044673] CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted 4.0.0-rc7-00016-g7b43b47-dirty #11
[    3.053411] Hardware name: Generic AM33XX (Flattened Device Tree)
[    3.059776] Workqueue: deferwq deferred_probe_work_func
[    3.065265] [<c0015be4>] (unwind_backtrace) from [<c0012258>] (show_stack+0x10/0x14)
[    3.073382] [<c0012258>] (show_stack) from [<c066bbdc>] (dump_stack+0x84/0x9c)
[    3.080928] [<c066bbdc>] (dump_stack) from [<c031ce00>] (Ldiv0_64+0x8/0x18)
[    3.088225] [<c031ce00>] (Ldiv0_64) from [<c05704e0>] (si5351_pll_round_rate+0x7c/0x190)
[    3.096700] [<c05704e0>] (si5351_pll_round_rate) from [<c056caa8>] (clk_calc_new_rates+0x1dc/0x260)
[    3.106170] [<c056caa8>] (clk_calc_new_rates) from [<c056c9c8>] (clk_calc_new_rates+0xfc/0x260)
[    3.115280] si5351 0-0060: si5351_pll_round_rate - plla: a = 0, b = 0, c = 1, parent_rate = 0, rate = 0
[    3.125125] si5351 0-0060: si5351_msynth_recalc_rate - ms0: p1 = 5632, p2 = 0, p3 = 1, m = 6144, parent_rate = 0, rate = 0
[    3.137702] usb 2-1: New USB device found, idVendor=0424, idProduct=2512
[    3.144764] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.155260] hub 2-1:1.0: USB hub found
[    3.159354] hub 2-1:1.0: 2 ports detected
[    3.167784] si5351 0-0060: si5351_pll_set_rate - plla: p1 = 4294966784, p2 = 0, p3 = 1, parent_rate = 0, rate = 0
[    3.178577] si5351 0-0060: si5351_pll_recalc_rate - plla: p1 = 4294966784, p2 = 0, p3 = 1, parent_rate = 0, rate = 0
[    3.189999] si5351 0-0060: si5351_msynth_set_rate - ms0: p1 = 5632, p2 = 0, p3 = 1, divby4 = 0, parent_rate = 0, rate = 18432000
[    3.202118] si5351 0-0060: si5351_msynth_recalc_rate - ms0: p1 = 5632, p2 = 0, p3 = 1, m = 6144, parent_rate = 0, rate = 0
[    3.213686] si5351 0-0060: si5351_clkout_set_rate - clk0: rdiv = 128, parent_rate = 0, rate = 18432000
[    3.223696] omap_i2c 44e0b000.i2c: bus 0 rev0.11 at 400 kHz
[    3.234369] cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted freq: 1000000 KHz
[    3.291656] tilcdc 4830e000.lcdc: timeout waiting for framedone
[    3.331875] cpufreq: __cpufreq_add_dev: CPU0: Unlisted initial frequency changed to: 720000 KHz
[    3.401725] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6
[    3.408133] davinci_mdio 4a101000.mdio: detected phy mask fffffffc
[    3.419351] libphy: 4a101000.mdio: probed
[    3.423725] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver unknown
[    3.432182] davinci_mdio 4a101000.mdio: phy[1]: device 4a101000.mdio:01, driver unknown
[    3.442499] cpsw 4a100000.ethernet: Detected MACID = 6c:ec:eb:6c:8a:4b
[    3.453442] omap_rtc 44e3e000.rtc: setting system clock to 2015-02-26 04:13:35 UTC (1424924015)
[    3.462674] sr_init: No PMIC hook to init smartreflex
[    3.468302] sr_init: platform driver register failed for SR
[    3.538223] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mode. Opts: (null)
[    3.547109] VFS: Mounted root (ext4 filesystem) readonly on device 179:1.
[    3.558090] devtmpfs: mounted
[    3.562299] Freeing unused kernel memory: 444K (c0949000 - c09b8000)
INIT: version 2.88 booting
Starting udev
[    4.707396] udevd[88]: starting version 182
[   11.725776] EXT4-fs (mmcblk0p1): re-mounted. Opts: data=ordered
bootlogd: cannot allocate pseudo tty: No such file or directory
[   12.154807] random: dd urandom read with 53 bits of entropy available
ALSA: Restoring mixer settings...
/usr/sbin/alsactl: load_state:1729: No soundcards found...
INIT: Entering runlevel: 5
Configuring network interfaces... done.
Starting system message bus: dbus.
Starting Network Interface Plugging Daemon: eth0.
[   16.740773] net eth0: initializing cpsw version 1.12 (0)
[   16.822202] net eth0: phy found : id is : 0x221513
[   16.827491] libphy: PHY 4a101000.mdio:02 not found
[   16.832620] net eth0: phy 4a101000.mdio:02 not found on slave 1
Starting OpenBSD Secure Shell server: sshd
[   16.961158] EXT4-fs (mmcblk0p1): warning: maximal mount count reached, running e2fsck is recommended
[   17.035196] EXT4-fs (mmcblk0p1): re-mounted. Opts: data=ordered
[   17.100834] EXT4-fs (mmcblk0p1): re-mounted. Opts: data=ordered
done.
Starting rpcbind daemon...rpcbind: cannot create socket for udp6
rpcbind: cannot create socket for tcp6
done.
creating NFS state directory: done
starting statd: done
Starting advanced power management daemon: No APM support in kernel
(failed.)
Starting ntpd: done
Starting syslogd/klogd: done
Starting Lighttpd Web Server: lighttpd.

EMAC OpenEmbedded Linux - 5.0.0 - Beta
Copyright (C) 2014, EMAC, Inc.  All rights reserved.

Headless
som3517-som200

som3517-som200 login: [   19.822835] cpsw 4a100000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
root
Password: 
root at som3517-som200:~# cat /proc/version 
Linux version 4.0.0-rc7-00016-g7b43b47-dirty (michael at deathray) (gcc version 4.9.1 (GCC) ) #11 SMP Tue Apr 14 18:51:01 CDT 2015
root at som3517-som200:~# cat /sys/kernel/debug/
bdi/                   extfrag/               kprobes/               musb-hdrc.0.auto/      omap_mux/              pwm                    sleep_time             ubifs/                 
clk/                   fault_around_bytes     memblock/              musb-hdrc.0.auto.dsps/ pinctrl/               regmap/                suspend_stats          usb/                   
dma_buf/               gpio                   mmc0/                  musb-hdrc.1.auto/      pm_debug/              regulator/             tracing/               wakeup_sources         
dri/                   hid/                   mmc1/                  musb-hdrc.1.auto.dsps/ pm_qos/                sched_features         ubi/                   
root at som3517-som200:~# cat /sys/kernel/debug/clk/
adc_tsc_fck/                clk_summary                 dpll_core_m4_ck/            dpll_per_ck/                gpio2_dbclk/                mmc_clk/                    stm_clk_div_ck/             timer7_fck/
aes0_fck/                   clkdiv32k_ck/               dpll_core_m4_div2_ck/       dpll_per_m2_ck/             gpio3_dbclk/                mmu_fck/                    stm_pmd_clock_mux_ck/       trace_clk_div_ck/
cefuse_fck/                 clkdiv32k_ick/              dpll_core_m5_ck/            dpll_per_m2_div4_ck/        ieee5000_fck/               ms0/                        sys_clkin_ck/               trace_pmd_clk_mux_ck/
clk0/                       clkout2_ck/                 dpll_core_m6_ck/            dpll_per_m2_div4_wkupdm_ck/ l3_gclk/                    ms1/                        sysclk_div_ck/              usbotg_fck/
clk1/                       clkout2_div_ck/             dpll_core_x2_ck/            ehrpwm0_tbclk/              l3s_gclk/                   ms2/                        sysclkout_pre_ck/           virt_19200000_ck/
clk2/                       cpsw_125mhz_gclk/           dpll_ddr_ck/                ehrpwm1_tbclk/              l4_rtc_gclk/                plla/                       tclkin_ck/                  virt_24000000_ck/
clk_24mhz/                  cpsw_cpts_rft_clk/          dpll_ddr_m2_ck/             ehrpwm2_tbclk/              l4fw_gclk/                  pllb/                       timer1_fck/                 virt_25000000_ck/
clk_32768_ck/               dbg_clka_ck/                dpll_ddr_m2_div2_ck/        gfx_fck_div_ck/             l4hs_gclk/                  pruss_ocp_gclk/             timer2_fck/                 virt_26000000_ck/
clk_dump                    dbg_sysclk_ck/              dpll_disp_ck/               gfx_fclk_clksel_ck/         l4ls_gclk/                  rng_fck/                    timer3_fck/                 wdt1_fck/
clk_orphan_dump             dcan0_fck/                  dpll_disp_m2_ck/            gpio0_dbclk/                lcd_gclk/                   sha0_fck/                   timer4_fck/                 xtal/
clk_orphan_summary          dcan1_fck/                  dpll_mpu_ck/                gpio0_dbclk_mux_ck/         mcasp0_fck/                 smartreflex0_fck/           timer5_fck/                 
clk_rc32k_ck/               dpll_core_ck/               dpll_mpu_m2_ck/             gpio1_dbclk/                mcasp1_fck/                 smartreflex1_fck/           timer6_fck/                 
root at som3517-som200:~# cat /sys/kernel/debug/clk/clk_summary 
   clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
----------------------------------------------------------------------------------------
 tclkin_ck                                0            0    12000000          0 0  
 virt_26000000_ck                         1            1    26000000          0 0  
    sys_clkin_ck                         11           23    26000000          0 0  
       timer6_fck                         0            1    26000000          0 0  
       timer3_fck                         0            1    26000000          0 0  
       dbg_sysclk_ck                      0            1    26000000          0 0  
       timer7_fck                         0            1    26000000          0 0  
       timer5_fck                         0            1    26000000          0 0  
       timer4_fck                         0            1    26000000          0 0  
       timer2_fck                         1            1    26000000          0 0  
       timer1_fck                         1            1    26000000          0 0  
       cefuse_fck                         0            0    26000000          0 0  
       dpll_per_ck                        2            2   960000000          0 0  
          usbotg_fck                      1            1   960000000          0 0  
          dpll_per_m2_ck                  3            4   192000000          0 0  
             mmc_clk                      0            3    96000000          0 0  
             clk_24mhz                    1            1    24000000          0 0  
                clkdiv32k_ck              1            1       32786          0 0  
                   clkdiv32k_ick           1            5       32786          0 0  
                      wdt1_fck            0            1       32786          0 0  
                      gpio3_dbclk           0            1       32786          0 0  
                      gpio2_dbclk           0            1       32786          0 0  
                      gpio1_dbclk           0            1       32786          0 0  
             dpll_per_m2_div4_ck           1            9    48000000          0 0  
             dpll_per_m2_div4_wkupdm_ck           1            2    48000000          0 0  
       dpll_disp_ck                       1            1    18000000          0 0  
          dpll_disp_m2_ck                 1            1    18000000          0 0  
             lcd_gclk                     1            1    18000000          0 0  
       dpll_ddr_ck                        1            1   400000000          0 0  
          dpll_ddr_m2_ck                  2            2   400000000          0 0  
             dpll_ddr_m2_div2_ck           1            1   200000000          0 0  
       dpll_mpu_ck                        1            1   275000000          0 0  
          dpll_mpu_m2_ck                  4            4   275000000          0 0  
       dpll_core_ck                       1            1  1000000000          0 0  
          dpll_core_x2_ck                 2            2  2000000000          0 0  
             dpll_core_m6_ck              0            0   500000000          0 0  
             dpll_core_m5_ck              1            1   250000000          0 0  
                cpsw_cpts_rft_clk           0            0   250000000          0 0  
                cpsw_125mhz_gclk           3            3   125000000          0 0  
             dpll_core_m4_ck              9           11   200000000          0 0  
                dbg_clka_ck               0            2   200000000          0 0  
                   trace_pmd_clk_mux_ck           0            1   200000000          0 0  
                      trace_clk_div_ck           0            1    50000000          0 0  
                   stm_pmd_clock_mux_ck           0            0   200000000          0 0  
                      stm_clk_div_ck           0            0    50000000          0 0  
                gfx_fclk_clksel_ck           0            1   200000000          0 0  
                   gfx_fck_div_ck           0            1   200000000          0 0  
                sysclk_div_ck             0            0   200000000          0 0  
                l4hs_gclk                 2            2   200000000          0 0  
                l4_rtc_gclk               0            0   100000000          0 0  
                dpll_core_m4_div2_ck          15           17   100000000          0 0  
                   l4ls_gclk             45           60   100000000          0 0  
                      ehrpwm2_tbclk           0            1   100000000          0 0  
                      ehrpwm1_tbclk           0            0   100000000          0 0  
                      ehrpwm0_tbclk           0            0   100000000          0 0  
                   l4fw_gclk              1            1   100000000          0 0  
                   l3s_gclk              10           10   100000000          0 0  
                   ieee5000_fck           0            0   100000000          0 0  
                mmu_fck                   0            0   200000000          0 0  
                l3_gclk                  13           15   200000000          0 0  
                   pruss_ocp_gclk           0            1   200000000          0 0  
       rng_fck                            2            2    26000000          0 0  
       aes0_fck                           1            2    26000000          0 0  
       sha0_fck                           1            1    26000000          0 0  
       smartreflex1_fck                   0            1    26000000          0 0  
       smartreflex0_fck                   0            1    26000000          0 0  
       mcasp1_fck                         0            1    26000000          0 0  
       mcasp0_fck                         0            1    26000000          0 0  
       dcan1_fck                          0            1    26000000          0 0  
       dcan0_fck                          0            1    26000000          0 0  
       adc_tsc_fck                        1            1    26000000          0 0  
 virt_25000000_ck                         0            0    25000000          0 0  
 virt_24000000_ck                         0            0    24000000          0 0  
 virt_19200000_ck                         0            0    19200000          0 0  
 clk_rc32k_ck                             0            1       32000          0 0  
    gpio0_dbclk_mux_ck                    0            1       32000          0 0  
       gpio0_dbclk                        0            1       32000          0 0  
 clk_32768_ck                             2            2       32768          0 0  
    sysclkout_pre_ck                      1            1       32768          0 0  
       clkout2_div_ck                     1            1       32768          0 0  
          clkout2_ck                      1            1       32768          0 0  
 xtal                                     0            0           0          0 0  
    pllb                                  0            0           0          0 0  
       ms2                                0            0           0          0 0  
          clk2                            0            0           0          0 0  
       ms1                                0            0           0          0 0  
          clk1                            0            0           0          0 0  
    plla                                  0            0           0          0 0  
       ms0                                0            0           0          0 0  
          clk0                            0            0           0          0 0 
