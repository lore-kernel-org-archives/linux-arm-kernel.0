From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Thu, 28 Jan 2016 05:49:22 +0000
Subject: [PATCH] ARM: dts: porter: add MAX3355 support
In-Reply-To: <4506196.xOgpYRO52t@wasted.cogentembedded.com>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
 <4506196.xOgpYRO52t@wasted.cogentembedded.com>
Message-ID: <SG2PR06MB0919D09C1146EAC0681EE109D8DA0@SG2PR06MB0919.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> From: linux-renesas-soc-owner at vger.kernel.org [mailto:linux-renesas-soc-owner at vger.kernel.org] On Behalf Of Sergei
> Shtylyov
> Sent: Wednesday, January 27, 2016 7:14 AM
> 
> Now that Maxim Integrated MAX3355 'extcon' driver and device tree bindings
> are upstream along with the 'extcon' hook  in the Renesas USBHS driver, we
> can add  MAX3355 device node to  the Porter device tree and properly refer
> to it from the USBHS node instead of using  "renesas,enable-gpio" property
> which only allowed checking the USB ID pin  at the driver probe time;  now
> this  pin's  state can be monitored dynamically!
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

I tested this patch on Porter, but interrupt of "usb-otg" didn't happened
even if I connected/disconnected a usb convert cable (usb micro-ab to A).
Remarks: I confirmed that the usb convert cable worked correctly on other board.

Do I need other settings for this?

- kernel : renesas.git / renesas-devel-20160127-v4.5-rc1 tag + this patch
- config : shmobile_defconfig + EXTCON + MAX3355 + and more
- board : Porter (Y-RCAR-M2-PORTER-A)
- log :
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.5.0-rc1-dirty (shimoda at shimoda-i7-pc) (gcc version 4.9.3 20141031 (prerelease) (Linaro GCC 2014.11) ) #45 SMP Thu Jan 28 13:49:08 JST 2016
[    0.000000] CPU: ARMv7 Processor [413fc0f2] revision 2 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] Machine model: Porter
[    0.000000] Ignoring memory block 0x200000000 - 0x240000000
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 262144
[    0.000000] free_area_init_node: node 0, pgdat c07308c0, node_mem_map ef7f9000
[    0.000000]   Normal zone: 1536 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 196608 pages, LIFO batch:31
[    0.000000]   HighMem zone: 65536 pages, LIFO batch:15
[    0.000000] PERCPU: Embedded 12 pages/cpu @ef7c0000 s17984 r8192 d22976 u49152
[    0.000000] pcpu-alloc: s17984 r8192 d22976 u49152 alloc=12*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260608
[    0.000000] Kernel command line: ignore_loglevel rw root=/dev/nfs ip=dhcp
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1031652K/1048576K available (4928K kernel code, 184K rwdata, 1908K rodata, 308K init, 290K bss, 16924K reserved, 0K cma-reserved, 262144K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06b604c   (6841 kB)
[    0.000000]       .init : 0xc06b7000 - 0xc0704000   ( 308 kB)
[    0.000000]       .data : 0xc0704000 - 0xc0732100   ( 185 kB)
[    0.000000]        .bss : 0xc0735000 - 0xc077d9a4   ( 291 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] Architected cp15 timer(s) running at 10.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
[    0.000004] sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every 4398046511100ns
[    0.000013] Switching to timer-based delay loop, resolution 100ns
[    0.000386] Console: colour dummy device 80x30
[    0.000680] console [tty0] enabled
[    0.000700] Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj=100000)
[    0.000723] pid_max: default: 32768 minimum: 301
[    0.000830] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000845] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001289] CPU: Testing write buffer coherency: ok
[    0.001474] CPU0: update cpu_capacity 1024
[    0.001489] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.001564] Setting up static identity map for 0x40009000 - 0x40009058
[    0.002502] Unable to boot CPU1 when MD21 is set
[    0.002520] CPU1: failed to boot: -524
[    0.002557] Brought up 1 CPUs
[    0.002569] SMP: Total of 1 processors activated (20.00 BogoMIPS).
[    0.002581] CPU: All CPU(s) started in SVC mode.
[    0.003315] devtmpfs: initialized
[    0.010845] VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
[    0.011227] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.011504] pinctrl core: initialized pinctrl subsystem
[    0.012122] NET: Registered protocol family 16
[    0.012294] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.015038] renesas_irqc e61c0000.interrupt-controller: driving 10 irqs
[    0.017503] sh-pfc e6060000.pfc: r8a77910_pfc support registered
[    0.021185] No ATAGs?
[    0.021207] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.021231] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.041040] gpio-regulator regulator at 1: Could not obtain regulator setting GPIOs: -517
[    0.041139] gpio-regulator regulator at 3: Could not obtain regulator setting GPIOs: -517
[    0.041603] vgaarb: loaded
[    0.041834] SCSI subsystem initialized
[    0.042233] libata version 3.00 loaded.
[    0.042444] usbcore: registered new interface driver usbfs
[    0.042501] usbcore: registered new interface driver hub
[    0.042554] usbcore: registered new device driver usb
[    0.043578] Advanced Linux Sound Architecture Driver Initialized.
[    0.044815] clocksource: Switched to clocksource arch_sys_counter
[    0.058596] NET: Registered protocol family 2
[    0.059004] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.059064] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.059160] TCP: Hash tables configured (established 8192 bind 8192)
[    0.059204] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.059233] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.059373] NET: Registered protocol family 1
[    0.060064] RPC: Registered named UNIX socket transport module.
[    0.060082] RPC: Registered udp transport module.
[    0.060093] RPC: Registered tcp transport module.
[    0.060104] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.060127] PCI: CLS 0 bytes, default 64
[    0.061237] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.062651] NFS: Registering the id_resolver key type
[    0.062692] Key type id_resolver registered
[    0.062704] Key type id_legacy registered
[    0.062729] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.064362] bounce: pool size: 64 pages
[    0.064431] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.064453] io scheduler noop registered
[    0.064467] io scheduler deadline registered
[    0.064487] io scheduler cfq registered (default)
[    0.065525] gpio_rcar e6050000.gpio: driving 32 GPIOs
[    0.065776] gpio_rcar e6051000.gpio: driving 26 GPIOs
[    0.066053] gpio_rcar e6052000.gpio: driving 32 GPIOs
[    0.066328] gpio_rcar e6053000.gpio: driving 32 GPIOs
[    0.066599] gpio_rcar e6054000.gpio: driving 32 GPIOs
[    0.066867] gpio_rcar e6055000.gpio: driving 32 GPIOs
[    0.067155] gpio_rcar e6055400.gpio: driving 32 GPIOs
[    0.067400] gpio_rcar e6055800.gpio: driving 26 GPIOs
[    0.067947] pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
[    0.068104] pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
[    0.068121] pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
[    0.068136] pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
[    0.068150] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.068192] pci 0000:00:00.0: [1033:0000] type 00 class 0x060000
[    0.068218] pci 0000:00:00.0: reg 0x10: [mem 0xee090800-0xee090bff]
[    0.068236] pci 0000:00:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
[    0.068434] pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310
[    0.068461] pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    0.068534] pci 0000:00:01.0: supports D1 D2
[    0.068548] pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
[    0.068746] pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320
[    0.068773] pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
[    0.068845] pci 0000:00:02.0: supports D1 D2
[    0.068858] pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
[    0.069055] PCI: bus0: Fast back to back transfers disabled
[    0.069072] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    0.069147] pci 0000:00:01.0: BAR 0: assigned [mem 0xee080000-0xee080fff]
[    0.069167] pci 0000:00:02.0: BAR 0: assigned [mem 0xee081000-0xee0810ff]
[    0.069205] pci 0000:00:01.0: enabling device (0140 -> 0142)
[    0.069246] pci 0000:00:02.0: enabling device (0140 -> 0142)
[    0.069423] pci-rcar-gen2 ee0d0000.pci: PCI: bus0 revision 11
[    0.069564] pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
[    0.069580] pci_bus 0001:01: root bus resource [io  0xee0c0000-0xee0c10ff]
[    0.069594] pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0c10ff]
[    0.069608] pci_bus 0001:01: No busn resource found for root bus, will use [bus 01-ff]
[    0.069640] pci 0001:01:00.0: [1033:0000] type 00 class 0x060000
[    0.069663] pci 0001:01:00.0: reg 0x10: [mem 0xee0d0800-0xee0d0bff]
[    0.069681] pci 0001:01:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
[    0.069863] pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310
[    0.069889] pci 0001:01:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    0.069962] pci 0001:01:01.0: supports D1 D2
[    0.069975] pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
[    0.070168] pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320
[    0.070194] pci 0001:01:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
[    0.070266] pci 0001:01:02.0: supports D1 D2
[    0.070279] pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
[    0.070476] PCI: bus1: Fast back to back transfers disabled
[    0.070492] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
[    0.070606] pci 0001:01:01.0: BAR 0: assigned [mem 0xee0c0000-0xee0c0fff]
[    0.070624] pci 0001:01:02.0: BAR 0: assigned [mem 0xee0c1000-0xee0c10ff]
[    0.070660] pci 0001:01:01.0: enabling device (0140 -> 0142)
[    0.070697] pci 0001:01:02.0: enabling device (0140 -> 0142)
[    0.070959] PCI host bridge /pcie at fe000000 ranges:
[    0.070984]    IO 0xfe100000..0xfe1fffff -> 0x00000000
[    0.071003]   MEM 0xfe200000..0xfe3fffff -> 0xfe200000
[    0.071021]   MEM 0x30000000..0x37ffffff -> 0x30000000
[    0.071035]   MEM 0x38000000..0x3fffffff -> 0x38000000
[    0.264153] rcar-pcie fe000000.pcie: PCIe link down
[    0.278314] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.279574] SuperH (H)SCI(F) driver initialized
[    0.279919] e6e60000.serial: ttySC0 at MMIO 0xe6e60000 (irq = 105, base_baud = 0) is a scif
[    1.250320] console [ttySC0] enabled
[    1.254672] [drm] Initialized drm 1.1.0 20060810
[    1.260004] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.266787] [drm] No driver support for vblank timestamp query.
[    1.273157] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[    1.282277] scsi host0: sata_rcar
[    1.285888] ata1: SATA max UDMA/133 irq 107
[    1.290762] renesas_spi e6b10000.spi: DMA available
[    1.296792] m25p80 spi0.0: s25fl512s (65536 Kbytes)
[    1.301962] 3 ofpart partitions found on MTD device spi0.0
[    1.307592] Creating 3 MTD partitions on "spi0.0":
[    1.312488] 0x000000000000-0x000000040000 : "loader_prg"
[    1.318859] 0x000000040000-0x000000440000 : "user_prg"
[    1.325085] 0x000000440000-0x000004000000 : "flash_fs"
[    1.331277] renesas_spi e6b10000.spi: probed
[    1.336702] CAN device driver interface
[    1.341298] rcar_can e6e80000.can: device registered (regs @ f08ea000, IRQ115)
[    1.349212] libphy: sh_mii: probed
[    1.355593] sh-eth ee700000.ethernet eth0: Base address at 0xee700000, 2e:09:0a:00:89:12, IRQ 106.
[    1.365356] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.372029] ehci-pci: EHCI PCI platform driver
[    1.376710] ehci-pci 0000:00:02.0: EHCI Host Controller
[    1.382064] ehci-pci 0000:00:02.0: new USB bus registered, assigned bus number 1
[    1.389744] ehci-pci 0000:00:02.0: irq 118, io mem 0xee081000
[    1.414163] ehci-pci 0000:00:02.0: USB 2.0 started, EHCI 1.00
[    1.420696] hub 1-0:1.0: USB hub found
[    1.424682] hub 1-0:1.0: 1 port detected
[    1.429078] ehci-pci 0001:01:02.0: EHCI Host Controller
[    1.434476] ehci-pci 0001:01:02.0: new USB bus registered, assigned bus number 2
[    1.442122] ehci-pci 0001:01:02.0: irq 119, io mem 0xee0c1000
[    1.464210] ehci-pci 0001:01:02.0: USB 2.0 started, EHCI 1.00
[    1.470671] hub 2-0:1.0: USB hub found
[    1.474641] hub 2-0:1.0: 1 port detected
[    1.478985] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.485321] ohci-pci: OHCI PCI platform driver
[    1.489927] ohci-pci 0000:00:01.0: OHCI PCI host controller
[    1.495644] ohci-pci 0000:00:01.0: new USB bus registered, assigned bus number 3
[    1.503236] ohci-pci 0000:00:01.0: irq 118, io mem 0xee080000
[    1.595067] hub 3-0:1.0: USB hub found
[    1.599015] hub 3-0:1.0: 1 port detected
[    1.603355] ohci-pci 0001:01:01.0: OHCI PCI host controller
[    1.609080] ohci-pci 0001:01:01.0: new USB bus registered, assigned bus number 4
[    1.616682] ohci-pci 0001:01:01.0: irq 119, io mem 0xee0c0000
[    1.704949] hub 4-0:1.0: USB hub found
[    1.708894] hub 4-0:1.0: 1 port detected
[    1.714314] mousedev: PS/2 mouse device common for all mice
[    1.720365] i2c /dev entries driver
[    1.727969] i2c-rcar e6530000.i2c: probed
[    1.735107] rcar_thermal e61f0000.thermal: 1 sensor probed
[    1.741272] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    1.746303] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[    1.751548] ata1: link resume succeeded after 1 retries
[    1.864182] ata1: SATA link down (SStatus 0 SControl 300)
[    1.924411] sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 97 MHz
[    1.932452] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[    2.114316] sh_mobile_sdhi ee160000.sd: mmc1 base at 0xee160000 clock rate 97 MHz
[    2.122647] usbcore: registered new interface driver usbhid
[    2.128363] usbhid: USB HID core driver
[    2.133902] ak4642-codec 2-0012: No cache used with register defaults set!
[    2.144969] rcar_sound ec500000.sound: probed
[    2.150032] NET: Registered protocol family 10
[    2.157203] sit: IPv6 over IPv4 tunneling driver
[    2.162417] NET: Registered protocol family 17
[    2.167011] can: controller area network core (rev 20120528 abi 9)
[    2.173362] NET: Registered protocol family 29
[    2.177933] can: raw protocol (rev 20120528)
[    2.182297] can: broadcast manager protocol (rev 20120528 t)
[    2.188095] can: netlink gateway (rev 20130117) max_hops=1
[    2.193775] Key type dns_resolver registered
[    2.198575] Registering SWP/SWPB emulation handler
[    2.205780] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.212546] [drm] No driver support for vblank timestamp query.
[    2.219809] rcar-du feb00000.display: No connectors reported connected with modes
[    2.227488] [drm] Cannot find any crtc or sizes - going 1024x768
[    2.241025] Console: switching to colour frame buffer device 128x48
[    2.253463] rcar-du feb00000.display: fb0:  frame buffer device
[    2.259597] [drm] Initialized rcar-du 1.0.0 20130110 on minor 0
[    2.266760] renesas_usbhs e6590000.usb: transceiver found
[    2.272488] renesas_usbhs e6590000.usb: gadget probed
[    2.277780] phy phy-e6590100.usb-phy.1: phy init failed --> -16
[    2.283893] renesas_usbhs e6590000.usb: probed
[    2.288492] sh-pfc e6060000.pfc: pin GP_7_23 already requested by ee090000.pci; cannot claim for e6590000.usb
[    2.298737] sh-pfc e6060000.pfc: pin-247 (e6590000.usb) status -22
[    2.305124] sh-pfc e6060000.pfc: could not request pin 247 (GP_7_23) from group usb0  on device sh-pfc
[    2.314734] renesas_usbhs e6590000.usb: Error applying setting, reverse things back
[    2.322632] renesas_usbhs e6590000.usb: failed to activate default pinctrl state
[    2.331932] asoc-simple-card sound: ak4642-hifi <-> ec500000.sound mapping ok
[    2.341065] hctosys: unable to open rtc device (rtc0)
[    2.425932] Micrel KSZ8041RNLI ee700000.etherne:01: attached PHY driver [Micrel KSZ8041RNLI] (mii_bus:phy_addr=ee700000.etherne:01, irq=367)
[    2.439009] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    5.358471] sh-eth ee700000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
[    5.367618] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    5.384155] Sending DHCP requests ., OK
[    5.457444] IP-Config: Got DHCP answer from 192.168.44.74, my address is 192.168.44.192
[    5.468607] IP-Config: Complete:
[    5.474789]      device=eth0, hwaddr=2e:09:0a:00:89:12, ipaddr=192.168.44.192, mask=255.255.255.0, gw=192.168.44.74
[    5.488457]      host=192.168.44.192, domain=shimoda-i7.org, nis-domain=(none)
[    5.498836]      bootserver=192.168.44.74, rootserver=192.168.44.74, rootpath=/var/lib/tftpboot/arm_linux/rootfs/debian/armel-wheezy     nameserver0=192.168.44.74
[    5.519858] SDHI0 VccQ: disabling
[    5.526303] SDHI2 VccQ: disabling
[    5.532911] ALSA device list:
[    5.538917]   #0: rsnd-dai.0-ak4642-hifi
[    5.549703] VFS: Mounted root (nfs filesystem) on device 0:13.
[    5.558922] devtmpfs: mounted
[    5.565079] Freeing unused kernel memory: 308K (c06b7000 - c0704000)
INIT: version 2.88 booting
[info] Using makefile-style concurrent boot in runlevel S.
[....] Starting the hotplug events dispatcher: udevd[    6.398307] udevd[864]: starting version 175
. ok
[ ok ] Synthesizing the initial hotplug events...done.
[ ok ] Waiting for /dev to be fully populated...done.
[    7.434946] random: nonblocking pool is initialized
[ ok ] Activating swap...done.
[ ok ] Cleaning up temporary files....
[ ok ] Activating lvm and md swap...done.
[....] Checking file systems...fsck from util-linux 2.20.1
done.
[ ok ] Mounting local filesystems...done.
[ ok ] Activating swapfile swap...done.
[ ok ] Cleaning up temporary files....
[ ok ] Setting kernel variables ...done.
[ ok ] Configuring network interfaces...done.
[ ok ] Cleaning up temporary files....
[....] Setting up ALSA...warning: 'alsactl restore' failed with error message 'Found hardware: "rsnd-dai_0-ak46" "" "" "" ""
Hardware is initialized using a generic method
alsactl: set_control:1328: failed to obtain info for control #4 (No such file or directory)
alsactl: set_control:1328: failed to obtain info for control #5 (No such file or directory)
alsactl: set_control:1328: failed to obtain info for control #6 (No such file or directory)
alsactl: set_control:1328: failed to obtain info for control #7 (No such file or directory)
alsactl: set_control:1328: failed to obtain info for control #8 (No such file or directory)
alsactl: set_control:1328: failed to obtain info for control #9 (No such file or directory)
alsactl: set_control:1328: failed to obtain info for control #10 (No such file or directory)
alsactl: set_control:1328: failed to obtain info for control #11 (No such file or directory)
alsactl: set_control:1328: failed to obtain info for control #12 (No such file or directory)
alsactl: set_control:1328: failed to obtain info for control #13 (No such file o[ ok ectory)'...done.
[ ok ] Setting up X socket directories... /tmp/.X11-unix /tmp/.ICE-unix.
INIT: Entering runlevel: 2
[info] Using makefile-style concurrent boot in runlevel 2.
[ ok ] Starting enhanced syslogd: rsyslogd.
[ ok ] Starting periodic command scheduler: cron.
[ ok ] Starting system message bus: dbus.

Debian GNU/Linux 7 192.168.44.192 ttySC0

192 login: root
Password:
Last login: Thu Jan  1 00:00:17 UTC 1970 on ttySC0
Linux 192.168.44.192 4.5.0-rc1-dirty #45 SMP Thu Jan 28 13:49:08 JST 2016 armv7l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
root at 192:~#
root at 192:~# cat /proc/interrupts | grep usb
108:          0     GIC-0 139 Level     e6590000.usb
118:          1     GIC-0 140 Level     ehci_hcd:usb1, ohci_hcd:usb3
119:          0     GIC-0 145 Level     ehci_hcd:usb2, ohci_hcd:usb4
308:          0  e6055000.gpio  31 Edge      usb-otg
root at 192:~#
root at 192:~# cat /proc/interrupts | grep usb
108:          0     GIC-0 139 Level     e6590000.usb
118:          1     GIC-0 140 Level     ehci_hcd:usb1, ohci_hcd:usb3
119:          0     GIC-0 145 Level     ehci_hcd:usb2, ohci_hcd:usb4
308:          0  e6055000.gpio  31 Edge      usb-otg
root at 192:~#
root at 192:~# cd /sys/class/extcon/extcon0
root at 192:/sys/class/extcon/extcon0# cat state
USB=1
USB-HOST=0

Best regards,
Yoshihiro Shimoda
