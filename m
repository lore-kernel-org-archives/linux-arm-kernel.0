From: angus@akkea.ca (Angus Ainslie)
Date: Wed, 24 May 2017 05:47:23 -0600
Subject: CHIPPro NAND issue with 4.12 rc1
In-Reply-To: <20170524063408.wjo3tn6j6ymwmnns@flea.home>
References: <399ea126f3b18071fbe46bfc9787df6b@www.akkea.ca>
 <20170520171418.4e8a47e0@bbrezillon>
 <6f3cefa6c54776f82160ed8954f4d0d4@www.akkea.ca>
 <20170521074535.4a4ba6dd@bbrezillon>
 <20170522070117.mwk4gm34o7idedye@flea.home>
 <63aca137397dc3700a34993205c8cfba@www.akkea.ca>
 <20170523195239.6nsv4ydrt4u7q6ge@flea.home>
 <a022aed57030622591a8e7eb97a59ff1@www.akkea.ca>
 <20170524063408.wjo3tn6j6ymwmnns@flea.home>
Message-ID: <4433203750148fbd8f7404ffb67304ff@www.akkea.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-24 00:34, Maxime Ripard wrote:
> On Tue, May 23, 2017 at 10:05:14PM -0600, Angus Ainslie wrote:
>> On 2017-05-23 13:52, Maxime Ripard wrote:
>> >
>> > Ok, good.
>> >
>> > If you unrevert those patches, and add clk_ignore_unused to the kernel
>> > command line, is it still broken?
>> >
>> > Maxime
>> 
>> 
>> If I use the clk_ignore_unused flag with the patches below then the 
>> kernel
>> can boot and mount the nand.
>> 
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun5i.c
>> b/drivers/clk/sunxi-ng/ccu-sun5i.c
>> index 5c476f9..700944c 100644
>> --- a/drivers/clk/sunxi-ng/ccu-sun5i.c
>> +++ b/drivers/clk/sunxi-ng/ccu-sun5i.c
>> @@ -251,7 +251,7 @@ static SUNXI_CCU_GATE(ahb_mmc1_clk, "ahb-mmc1",
>> "ahb",
>>  static SUNXI_CCU_GATE(ahb_mmc2_clk,    "ahb-mmc2",     "ahb",
>>                       0x060, BIT(10), 0);
>>  static SUNXI_CCU_GATE(ahb_nand_clk,    "ahb-nand",     "ahb",
>> -                     0x060, BIT(13), 0);
>> +                     0x060, BIT(13), CLK_IS_CRITICAL);
>>  static SUNXI_CCU_GATE(ahb_sdram_clk,   "ahb-sdram",    "ahb",
>>                       0x060, BIT(14), CLK_IS_CRITICAL);
>>  static SUNXI_CCU_GATE(ahb_emac_clk,    "ahb-emac",     "ahb",
> 
> That doesn't really make much sense, clk_ignore_unused and
> CLK_IS_CRITICAL are roughly doing the same thing
> 
> Could you paste the whole kernel logs?
> 
> Maxime

Here you go

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.12.0-rc2TNCPro-dirty (angus at midas) (gcc 
version 5.4.0 20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) ) #15 SMP 
Tue May 23 20:36:04 MDT 2017
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), 
cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing 
instruction cache
[    0.000000] OF: fdt: Machine model: NextThing C.H.I.P. Pro
[    0.000000] Memory policy: Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] percpu: Embedded 16 pages/cpu @cfe86000 s34252 r8192 
d23092 u65536
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pages: 64687
[    0.000000] Kernel command line: root=ubi0:rootfs rootfstype=ubifs rw 
earlyprintk ubi.mtd=4 clk_ignore_unused
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 
bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 
bytes)
[    0.000000] Memory: 247424K/260788K available (7168K kernel code, 
389K rwdata, 1584K rodata, 1024K init, 262K bss, 13364K reserved, 0K 
cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xd0000000 - 0xff800000   ( 760 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xcfead000   ( 254 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0800000   (8160 kB)
[    0.000000]       .init : 0xc0a00000 - 0xc0b00000   (1024 kB)
[    0.000000]       .data : 0xc0b00000 - 0xc0b61640   ( 390 kB)
[    0.000000]        .bss : 0xc0b68970 - 0xc0baa364   ( 263 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, 
Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU debugfs-based tracing is enabled.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, 
nr_cpu_ids=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] clocksource: timer: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 79635851949 ns
[    0.000000] clocksource: timer: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 6370868154 ns
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns, 
wraps every 21474836475000000ns
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [tty0] enabled
[    0.090000] Calibrating delay loop... 1001.88 BogoMIPS (lpj=5009408)
[    0.090000] pid_max: default: 32768 minimum: 301
[    0.090000] Mount-cache hash table entries: 1024 (order: 0, 4096 
bytes)
[    0.090000] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 
bytes)
[    0.090000] CPU: Testing write buffer coherency: ok
[    0.090000] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.090000] Setting up static identity map for 0x40100000 - 
0x40100060
[    0.090000] smp: Bringing up secondary CPUs ...
[    0.090000] smp: Brought up 1 node, 1 CPU
[    0.090000] SMP: Total of 1 processors activated (1001.88 BogoMIPS).
[    0.090000] CPU: All CPU(s) started in SVC mode.
[    0.090000] devtmpfs: initialized
[    0.090000] VFP support v0.3: implementor 41 architecture 3 part 30 
variant c rev 3
[    0.090000] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.090000] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.090000] pinctrl core: initialized pinctrl subsystem
[    0.090000] NET: Registered protocol family 16
[    0.090000] DMA: preallocated 256 KiB pool for atomic coherent 
allocations
[    0.090000] cpuidle: using governor ladder
[    0.090000] cpuidle: using governor menu
[    0.100000] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.110000] SCSI subsystem initialized
[    0.110000] usbcore: registered new interface driver usbfs
[    0.110000] usbcore: registered new interface driver hub
[    0.110000] usbcore: registered new device driver usb
[    0.110000] pps_core: LinuxPPS API ver. 1 registered
[    0.110000] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[    0.110000] PTP clock support registered
[    0.110000] Advanced Linux Sound Architecture Driver Initialized.
[    0.110000] Bluetooth: Core ver 2.22
[    0.110000] NET: Registered protocol family 31
[    0.110000] Bluetooth: HCI device and connection manager initialized
[    0.110000] Bluetooth: HCI socket layer initialized
[    0.110000] Bluetooth: L2CAP socket layer initialized
[    0.110000] Bluetooth: SCO socket layer initialized
[    0.110000] clocksource: Switched to clocksource timer
[    0.110000] simple-framebuffer 4febc000.framebuffer: framebuffer at 
0x4febc000, 0x135600 bytes, mapped to 0xd0080000
[    0.110000] simple-framebuffer 4febc000.framebuffer: format=x8r8g8b8, 
mode=640x440x32, linelength=2880
[    0.120000] Console: switching to colour frame buffer device 80x27
[    0.120000] simple-framebuffer 4febc000.framebuffer: fb0: simplefb 
registered!
[    0.130000] NET: Registered protocol family 2
[    0.130000] TCP established hash table entries: 2048 (order: 1, 8192 
bytes)
[    0.140000] TCP bind hash table entries: 2048 (order: 2, 16384 bytes)
[    0.140000] TCP: Hash tables configured (established 2048 bind 2048)
[    0.140000] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.140000] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.150000] NET: Registered protocol family 1
[    0.150000] RPC: Registered named UNIX socket transport module.
[    0.150000] RPC: Registered udp transport module.
[    0.160000] RPC: Registered tcp transport module.
[    0.160000] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.160000] workingset: timestamp_bits=30 max_order=16 bucket_order=0
[    0.170000] NFS: Registering the id_resolver key type
[    0.180000] Key type id_resolver registered
[    0.180000] Key type id_legacy registered
[    0.180000] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 248)
[    0.190000] io scheduler noop registered
[    0.190000] io scheduler deadline registered
[    0.190000] io scheduler cfq registered (default)
[    0.200000] io scheduler mq-deadline registered
[    0.200000] io scheduler kyber registered
[    0.200000] sun4i-usb-phy 1c13400.phy: could not find pctldev for 
node /soc at 01c00000/pinctrl at 01c20800/usb0-id-pin at 0, deferring probe
[    0.210000] sun5i-pinctrl 1c20800.pinctrl: initialized sunXi PIO 
driver
[    0.270000] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    0.300000] 1c28400.serial: ttyS0 at MMIO 0x1c28400 (irq = 27, 
base_baud = 1500000) is a U6_16550A
[    0.910000] console [ttyS0] enabled
[    0.940000] 1c28c00.serial: ttyS2 at MMIO 0x1c28c00 (irq = 28, 
base_baud = 1500000) is a U6_16550A
[    0.950000] nand: device found, Manufacturer ID: 0x98, Chip ID: 0xdc
[    0.960000] nand: Toshiba TC58NVG2S0H 4G 3.3V 8-bit
[    0.970000] nand: 512 MiB, SLC, erase size: 256 KiB, page size: 4096, 
OOB size: 256
[    0.990000] Bad block table not found for chip 0
[    0.990000] Bad block table not found for chip 0
[    1.000000] Scanning device for bad blocks
[    1.020000] random: fast init done
[    1.760000] random: crng init done
[    3.510000] Bad eraseblock 1292 at 0x000014300000
[    3.960000] Bad eraseblock 1536 at 0x000018000000
[    3.970000] Bad eraseblock 1537 at 0x000018040000
[    4.920000] Bad block table written to 0x00001ffc0000, version 0x01
[    4.940000] Bad block table written to 0x00001ff80000, version 0x01
[    4.950000] 5 ofpart partitions found on MTD device 1c03000.nand
[    4.950000] Creating 5 MTD partitions on "1c03000.nand":
[    4.960000] 0x000000000000-0x000000400000 : "SPL"
[    4.970000] 0x000000400000-0x000000800000 : "SPL.backup"
[    4.980000] 0x000000800000-0x000000c00000 : "U-Boot"
[    4.990000] 0x000000c00000-0x000001000000 : "env"
[    4.990000] 0x000001000000-0x000020000000 : "rootfs"
[    5.000000] libphy: Fixed MDIO Bus: probed
[    5.010000] CAN device driver interface
[    5.020000] usbcore: registered new interface driver asix
[    5.020000] usbcore: registered new interface driver ax88179_178a
[    5.030000] usbcore: registered new interface driver cdc_ether
[    5.040000] usbcore: registered new interface driver net1080
[    5.050000] usbcore: registered new interface driver rndis_host
[    5.050000] usbcore: registered new interface driver cdc_subset
[    5.060000] usbcore: registered new interface driver zaurus
[    5.070000] usbcore: registered new interface driver cdc_ncm
[    5.070000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) 
Driver
[    5.080000] ehci-platform: EHCI generic platform driver
[    5.090000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    5.100000] ohci-platform: OHCI generic platform driver
[    5.100000] usbcore: registered new interface driver cdc_acm
[    5.110000] cdc_acm: USB Abstract Control Model driver for USB modems 
and ISDN adapters
[    5.120000] usbcore: registered new interface driver usbserial
[    5.130000] usbcore: registered new interface driver 
usbserial_generic
[    5.140000] usbserial: USB Serial support registered for generic
[    5.150000] udc-core: couldn't find an available UDC - added [g_cdc] 
to list of pending drivers

[    5.160000] i2c /dev entries driver
[    5.170000] axp20x-i2c 0-0034: AXP20x variant AXP209 found
[    5.180000] axp20x-gpio axp20x-gpio: AXP209 GPIO driver loaded
[    5.200000] input: axp20x-pek as 
/devices/platform/soc at 01c00000/1c2ac00.i2c/i2c-0/0-0034/axp20x-pek/input/input0
[    5.210000] ldo1: supplied by regulator-dummy
[    5.220000] ldo2: supplied by regulator-dummy
[    5.230000] ldo3: supplied by regulator-dummy
[    5.240000] ldo4: supplied by regulator-dummy
[    5.240000] ldo5: supplied by regulator-dummy
[    5.250000] dcdc2: supplied by regulator-dummy
[    5.260000] dcdc3: supplied by regulator-dummy
[    5.270000] axp20x-i2c 0-0034: AXP20X driver loaded
[    5.270000] IR NEC protocol handler initialized
[    5.280000] IR RC5(x/sz) protocol handler initialized
[    5.290000] IR RC6 protocol handler initialized
[    5.290000] IR JVC protocol handler initialized
[    5.300000] IR Sony protocol handler initialized
[    5.310000] IR SANYO protocol handler initialized
[    5.310000] IR Sharp protocol handler initialized
[    5.320000] IR MCE Keyboard/mouse protocol handler initialized
[    5.330000] IR XMP protocol handler initialized
[    5.340000] sunxi-wdt 1c20c90.watchdog: Watchdog enabled (timeout=16 
sec, nowayout=0)
[    5.350000] Bluetooth: HCI UART driver ver 2.3
[    5.350000] Bluetooth: HCI UART protocol H4 registered
[    5.360000] Bluetooth: HCI UART protocol BCSP registered
[    5.370000] Bluetooth: HCI UART protocol LL registered
[    5.380000] Bluetooth: HCI UART protocol ATH3K registered
[    5.380000] Bluetooth: HCI UART protocol Three-wire (H5) registered
[    5.390000] usbcore: registered new interface driver btusb
[    5.400000] Bluetooth: Generic Bluetooth SDIO driver ver 0.1
[    5.410000] sdhci: Secure Digital Host Controller Interface driver
[    5.410000] sdhci: Copyright(c) Pierre Ossman
[    5.420000] sunxi-mmc 1c0f000.mmc: allocated mmc-pwrseq
[    5.490000] sunxi-mmc 1c0f000.mmc: base:0xd021f000 irq:20
[    5.490000] sdhci-pltfm: SDHCI platform and OF driver helper
[    5.500000] usbcore: registered new interface driver usbhid
[    5.510000] usbhid: USB HID core driver
[    5.520000] sun4i-codec 1c22c00.codec: Codec <-> 1c22c00.codec 
mapping ok
[    5.530000] sunxi-mmc 1c0f000.mmc: card claims to support voltages 
below defined range
[    5.550000] NET: Registered protocol family 17
[    5.550000] can: controller area network core (rev 20170425 abi 9)
[    5.560000] NET: Registered protocol family 29
[    5.570000] can: raw protocol (rev 20170425)
[    5.570000] can: broadcast manager protocol (rev 20170425 t)
[    5.580000] can: netlink gateway (rev 20170425) max_hops=1
[    5.590000] Key type dns_resolver registered
[    5.600000] Registering SWP/SWPB emulation handler
[    5.620000] mmc0: new high speed SDIO card at address 0001
[    5.640000] ehci-platform 1c14000.usb: EHCI Host Controller
[    5.640000] ehci-platform 1c14000.usb: new USB bus registered, 
assigned bus number 1
[    5.660000] ehci-platform 1c14000.usb: irq 22, io mem 0x01c14000
[    5.700000] ehci-platform 1c14000.usb: USB 2.0 started, EHCI 1.00
[    5.700000] hub 1-0:1.0: USB hub found
[    5.710000] hub 1-0:1.0: 1 port detected
[    5.720000] ohci-platform 1c14400.usb: Generic Platform OHCI 
controller
[    5.730000] ohci-platform 1c14400.usb: new USB bus registered, 
assigned bus number 2
[    5.740000] ohci-platform 1c14400.usb: irq 23, io mem 0x01c14400
[    5.820000] hub 2-0:1.0: USB hub found
[    5.830000] hub 2-0:1.0: 1 port detected
[    5.830000] usb_phy_generic usb_phy_generic.0.auto: 
usb_phy_generic.0.auto supply vcc not found, using dummy regulator
[    5.850000] musb-hdrc musb-hdrc.1.auto: MUSB HDRC host driver
[    5.860000] musb-hdrc musb-hdrc.1.auto: new USB bus registered, 
assigned bus number 3
[    5.870000] hub 3-0:1.0: USB hub found
[    5.880000] hub 3-0:1.0: 1 port detected
[    5.890000] using random self ethernet address
[    5.890000] using random host ethernet address
[    5.900000] usb0: HOST MAC 7e:c8:32:58:d1:a6
[    5.910000] usb0: MAC 2e:53:ef:6e:05:cb
[    5.910000] g_cdc gadget: CDC Composite Gadget, version: King 
Kamehameha Day 2008
[    5.920000] g_cdc gadget: g_cdc ready
[    5.930000] ubi0: attaching mtd4
[    6.330000] g_cdc gadget: high-speed config #1: CDC Composite (ECM + 
ACM)
[    7.200000] ubi0: scanning is finished
[    7.220000] ubi0: attached mtd4 (name "rootfs", size 496 MiB)
[    7.230000] ubi0: PEB size: 262144 bytes (256 KiB), LEB size: 258048 
bytes
[    7.240000] ubi0: min./max. I/O unit sizes: 4096/4096, sub-page size 
1024
[    7.250000] ubi0: VID header offset: 1024 (aligned 1024), data 
offset: 4096
[    7.260000] ubi0: good PEBs: 1977, bad PEBs: 7, corrupted PEBs: 0
[    7.270000] ubi0: user volume: 1, internal volumes: 1, max. volumes 
count: 128
[    7.280000] ubi0: max/mean erase counter: 4/1, WL threshold: 4096, 
image sequence number: 1444477407
[    7.290000] ubi0: available PEBs: 1, total reserved PEBs: 1976, PEBs 
reserved for bad PEB handling: 33
[    7.310000] hctosys: unable to open rtc device (rtc0)
[    7.310000] clk: Not disabling unused clocks
[    7.320000] vcc3v0: disabling
[    7.330000] ALSA device list:
[    7.330000]   #0: sun4i-codec
[    7.340000] ubi0: background thread "ubi_bgt0d" started, PID 52
[    7.350000] UBIFS (ubi0:0): background thread "ubifs_bgt0_0" started, 
PID 53
[    7.460000] UBIFS (ubi0:0): recovery needed
[    7.710000] UBIFS (ubi0:0): recovery completed
[    7.720000] UBIFS (ubi0:0): UBIFS: mounted UBI device 0, volume 0, 
name "rootfs"
[    7.730000] UBIFS (ubi0:0): LEB size: 258048 bytes (252 KiB), 
min./max. I/O unit sizes: 4096 bytes/4096 bytes
[    7.750000] UBIFS (ubi0:0): FS size: 497774592 bytes (474 MiB, 1929 
LEBs), journal size 9420800 bytes (8 MiB, 37 LEBs)
[    7.760000] UBIFS (ubi0:0): reserved for root: 0 bytes (0 KiB)
[    7.770000] UBIFS (ubi0:0): media format: w4/r0 (latest is w5/r0), 
UUID 435F92C7-9BDF-4BEC-A27A-638EABBA49D3, small LPT model
[    7.790000] UBIFS (ubi0:0): full atime support is enabled.
[    7.800000] VFS: Mounted root (ubifs filesystem) on device 0:13.
[    7.810000] devtmpfs: mounted
[    7.820000] Freeing unused kernel memory: 1024K
[    8.190000] systemd[1]: systemd 215 running in system mode. (+PAM 
+AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ -SECCOMP 
-APPARMOR)
[    8.210000] systemd[1]: Detected architecture 'arm'.

Welcome to Linux!

[    8.290000] systemd[1]: Failed to insert module 'autofs4'
[    8.300000] systemd[1]: Failed to insert module 'ipv6'
[    8.310000] systemd[1]: Set hostname to <chippro>.
[    9.070000] systemd[1]: Cannot add dependency job for unit 
display-manager.service, ignoring: Unit display-manager.service failed 
to load: No such file or directory.
[    9.100000] systemd[1]: Starting Forward Password Requests to Wall 
Directory Watch.
[    9.120000] systemd[1]: Started Forward Password Requests to Wall 
Directory Watch.
[    9.130000] systemd[1]: Expecting device dev-ttyS0.device...
          Expecting device dev-ttyS0.device...
[    9.170000] systemd[1]: Expecting device dev-ttyGS0.device...
