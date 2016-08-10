From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Thu, 11 Aug 2016 00:58:58 +0300
Subject: [BISECTED, REGRESSION] v4.7: Display lost on Kirkwood/OpenRD Client
Message-ID: <20160810215858.GA10648@raspberrypi.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

When upgrading from v4.6 --> v4.7, I lost the display/framebuffer on
OpenRD-Client (the only pcie device on the board).

Bisection points to:

eb13cf8345e94a02e9872ca3e909596a5ddb5f90 is the first bad commit
commit eb13cf8345e94a02e9872ca3e909596a5ddb5f90
Author: Andrew Lunn <andrew@lunn.ch>
Date:   Sun Apr 3 04:03:47 2016 +0200

    ARM: dts: kirkwood: Fixup pcie DT warnings

    PCIe has a range property, so the unit name should contain an address.
    Make use of the label to enable individual PCIe busses. Also, fixup
    the synology dtsi file which added a label pcie2 rather than using the
    existing pcie1 label.

    Signed-off-by: Andrew Lunn <andrew@lunn.ch>
    Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Any ideas how to get display working again?

Boot log with eb13cf8345e94a02e9872ca3e909596a5ddb5f90 (BAD):

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.6.0-rc1-mvebu-los_153e602-00009-geb13cf8 (aaro at amd-fx-6350) (gcc version 6.1.0 (GCC) ) #1 Thu Aug 11 00:42:14 EEST 2016
[    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=0005317f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine model: OpenRD Client
[    0.000000] Memory policy: Data cache writeback
[    0.000000] On node 0 totalpages: 131072
[    0.000000] free_area_init_node: node 0, pgdat c05f7838, node_mem_map dfbfa000
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 131072 pages, LIFO batch:31
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
[    0.000000] Kernel command line: console=tty console=ttyS0,115200 root=/dev/ram mtdparts=orion_nand:0x400000 at 0x100000(kernel),0x400000 at 0x500000(initramfs),0x1f700000 at 0x900000(scratch)
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 510160K/524288K available (4427K kernel code, 179K rwdata, 1304K rodata, 172K init, 599K bss, 14128K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff800000   ( 496 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05a0ffc   (5732 kB)
[    0.000000]       .init : 0xc05a1000 - 0xc05cc000   ( 172 kB)
[    0.000000]       .data : 0xc05cc000 - 0xc05f8c40   ( 180 kB)
[    0.000000]        .bss : 0xc05f8c40 - 0xc068eb44   ( 600 kB)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] clocksource: orion_clocksource: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 9556302233 ns
[    0.000007] sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 10737418237ns
[    0.000195] Console: colour dummy device 80x30
[    0.000580] console [tty0] enabled
[    0.000617] Calibrating delay loop... 1196.85 BogoMIPS (lpj=5984256)
[    0.090098] pid_max: default: 32768 minimum: 301
[    0.090217] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.090258] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.090807] CPU: Testing write buffer coherency: ok
[    0.091157] Setting up static identity map for 0x81e0 - 0x8238
[    0.091436] mvebu-soc-id: MVEBU SoC ID=0x6281, Rev=0x2
[    0.092639] devtmpfs: initialized
[    0.096287] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.096434] pinctrl core: initialized pinctrl subsystem
[    0.097010] NET: Registered protocol family 16
[    0.097460] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.098480] cpuidle: using governor menu
[    0.098893] Feroceon L2: Enabling L2
[    0.098954] Feroceon L2: Cache support initialised.
[    0.099318] [Firmware Info]: /ocp at f1000000/ethernet-controller at 72000/ethernet0-port at 0: local-mac-address is not set
[    0.099449] [Firmware Info]: /ocp at f1000000/ethernet-controller at 76000/ethernet1-port at 0: local-mac-address is not set
[    0.125308] vgaarb: loaded
[    0.125605] SCSI subsystem initialized
[    0.126153] libata version 3.00 loaded.
[    0.126457] usbcore: registered new interface driver usbfs
[    0.126557] usbcore: registered new interface driver hub
[    0.126636] usbcore: registered new device driver usb
[    0.127540] Advanced Linux Sound Architecture Driver Initialized.
[    0.128292] clocksource: Switched to clocksource orion_clocksource
[    0.146577] NET: Registered protocol family 2
[    0.147145] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.147227] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.147297] TCP: Hash tables configured (established 4096 bind 4096)
[    0.147378] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.147418] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.147572] NET: Registered protocol family 1
[    0.148262] RPC: Registered named UNIX socket transport module.
[    0.148330] RPC: Registered udp transport module.
[    0.148356] RPC: Registered tcp transport module.
[    0.148378] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.148419] PCI: CLS 0 bytes, default 32
[    0.149191] Unpacking initramfs...
[    1.543251] Freeing initrd memory: 2828K (c8000000 - c82c3000)
[    1.544422] futex hash table entries: 256 (order: -1, 3072 bytes)
[    1.567660] workingset: timestamp_bits=29 max_order=17 bucket_order=0
[    1.784664] NET: Registered protocol family 38
[    1.784993] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    1.785046] io scheduler noop registered
[    1.785293] io scheduler cfq registered (default)
[    1.786485] kirkwood-pinctrl f1010000.pin-controller: registered pinctrl driver
[    1.786846] GPIO line 28 (SelRS232or485) hogged as output/low
[    1.787592] irq: Cannot allocate irq_descs @ IRQ36, assuming pre-allocated
[    1.787773] GPIO line 34 (SelUARTorSD) hogged as output/high
[    1.788334] irq: Cannot allocate irq_descs @ IRQ68, assuming pre-allocated
[    1.788733] mv_xor f1060800.xor: Marvell shared XOR driver
[    1.833942] mv_xor f1060800.xor: Marvell XOR (Registers Mode): ( xor cpy intr )
[    1.834222] mv_xor f1060900.xor: Marvell shared XOR driver
[    1.869034] mv_xor f1060900.xor: Marvell XOR (Registers Mode): ( xor cpy intr )
[    1.869638] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    1.878480] console [ttyS0] disabled
[    1.878565] f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 26, base_baud = 12500000) is a 16550A
[    2.408466] console [ttyS0] enabled
[    2.412982] sata_mv f1080000.sata: version 1.28
[    2.413233] sata_mv f1080000.sata: slots 32 ports 2
[    2.461135] scsi host0: sata_mv
[    2.471109] scsi host1: sata_mv
[    2.474598] ata1: SATA max UDMA/133 irq 34
[    2.478770] ata2: SATA max UDMA/133 irq 34
[    2.483549] nand: device found, Manufacturer ID: 0xad, Chip ID: 0xdc
[    2.489982] nand: Hynix NAND 512MiB 3,3V 8-bit
[    2.494460] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    2.502115] Scanning device for bad blocks
[    2.817006] 3 cmdlinepart partitions found on MTD device orion_nand
[    2.823332] Creating 3 MTD partitions on "orion_nand":
[    2.828523] 0x000000100000-0x000000500000 : "kernel"
[    2.856914] 0x000000500000-0x000000900000 : "initramfs"
[    2.875907] 0x000000900000-0x000020000000 : "scratch"
[    2.897506] libphy: orion_mdio_bus: probed
[    2.970415] mv643xx_eth: MV-643xx 10/100/1000 ethernet driver version 1.4
[    3.547556] ata1: SATA link down (SStatus 0 SControl F300)
[    4.053723] mv643xx_eth_port mv643xx_eth_port.0 eth0: port 0 with MAC address 00:50:43:01:dc:35
[    5.137399] ata2: SATA link down (SStatus 0 SControl F300)
[    5.143654] mv643xx_eth_port mv643xx_eth_port.1 eth1: port 0 with MAC address 00:50:43:01:dc:36
[    5.152537] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.159137] ehci-pci: EHCI PCI platform driver
[    5.163691] ehci-orion: EHCI orion driver
[    5.167917] orion-ehci f1050000.ehci: EHCI Host Controller
[    5.173500] orion-ehci f1050000.ehci: new USB bus registered, assigned bus number 1
[    5.181391] orion-ehci f1050000.ehci: irq 30, io mem 0xf1050000
[    5.199852] orion-ehci f1050000.ehci: USB 2.0 started, EHCI 1.00
[    5.206850] hub 1-0:1.0: USB hub found
[    5.216874] hub 1-0:1.0: 1 port detected
[    5.221496] usbcore: registered new interface driver usb-storage
[    5.234341] rtc-mv f1010300.rtc: rtc core: registered f1010300.rtc as rtc0
[    5.241451] i2c /dev entries driver
[    5.258186] md: raid1 personality registered for level 1
[    5.279421] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel at redhat.com
[    5.288370] mvsdio f1090000.mvsdio: Got CD GPIO
[    5.344568] MV-CESA:Could not register sha1 driver
[    5.349464] MV-CESA:Could not register hmac-sha1 driver
[    5.355054] usbcore: registered new interface driver usbhid
[    5.360697] usbhid: USB HID core driver
[    5.387733] cs42l51 0-004a: Cirrus Logic CS42L51, Revision: 01
[    5.506826] mmc0: host does not support reading read-only switch, assuming write-enable
[    5.519443] mmc0: new high speed SDHC card at address e624
[    5.528545] mmcblk0: mmc0:e624 SU32G 29.7 GiB 
[    5.538351] usb 1-1: new high-speed USB device number 2 using orion-ehci
[    5.552800]  mmcblk0: p1 p2
[    5.689487] hub 1-1:1.0: USB hub found
[    5.696550] hub 1-1:1.0: 7 ports detected
[    5.898611] NET: Registered protocol family 17
[    5.910861] asoc-simple-card sound: cs42l51-hifi <-> i2s mapping ok
[    5.929252] cs42l51 0-004a: ASoC: mux DAC Mux has no paths
[    5.936602] rtc-mv f1010300.rtc: setting system clock to 2016-08-10 21:43:06 UTC (1470865386)
[    5.945383] ALSA device list:
[    5.948404]   #0: i2s-cs42l51-hifi
[    5.965069] Freeing unused kernel memory: 172K (c05a1000 - c05cc000)
[    5.971537] This architecture does not have kernel memory protection.
[    6.018360] usb 1-1.4: new high-speed USB device number 3 using orion-ehci
[    6.186043] usb-storage 1-1.4:1.0: USB Mass Storage device detected
[    6.197851] scsi host2: usb-storage 1-1.4:1.0
[    6.288321] usb 1-1.5: new high-speed USB device number 4 using orion-ehci
[    6.418350] usb-storage 1-1.5:1.0: USB Mass Storage device detected
[    6.428706] scsi host3: usb-storage 1-1.5:1.0
[    6.518313] usb 1-1.6: new high-speed USB device number 5 using orion-ehci
[    6.656436] usb-storage 1-1.6:1.0: USB Mass Storage device detected
[    6.667413] scsi host4: usb-storage 1-1.6:1.0
[    7.200222] scsi 2:0:0:0: Direct-Access     Ext Hard  Disk                 PQ: 0 ANSI: 5
[    7.209443] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    7.219057] sd 2:0:0:0: [sda] Spinning up disk...
[    7.430098] scsi 3:0:0:0: Direct-Access     Ext Hard  Disk                 PQ: 0 ANSI: 5
[    7.439470] sd 3:0:0:0: Attached scsi generic sg1 type 0
[    7.448929] sd 3:0:0:0: [sdb] Spinning up disk...
[    7.673974] scsi 4:0:0:0: CD-ROM            Lenovo   Slim_USB_Burner  8L32 PQ: 0 ANSI: 0
[    7.696675] sr 4:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[    7.705414] cdrom: Uniform CD-ROM driver Revision: 3.20
[    7.714609] sr 4:0:0:0: Attached scsi CD-ROM sr0
[    7.715023] sr 4:0:0:0: Attached scsi generic sg2 type 5
[    8.577307] EXT4-fs (mmcblk0p2): couldn't mount as ext3 due to feature incompatibilities
[    8.586138] EXT4-fs (mmcblk0p2): couldn't mount as ext2 due to feature incompatibilities
[    8.607522] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[    9.772086] Adding 4194300k swap on /dev/mmcblk0p1.  Priority:-1 extents:1 across:4194300k SS
[   10.476141] random: dropbear urandom read with 28 bits of entropy available
[   12.498305] .ready
[   12.501675] sd 2:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[   12.510173] sd 2:0:0:0: [sda] Write Protect is off
[   12.515017] sd 2:0:0:0: [sda] Mode Sense: 10 00 00 00
[   12.515787] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.529215]  sda: sda1
[   12.537948] sd 2:0:0:0: [sda] Attached SCSI disk
[   13.108304] .ready
[   13.111801] sd 3:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[   13.120298] sd 3:0:0:0: [sdb] Write Protect is off
[   13.125138] sd 3:0:0:0: [sdb] Mode Sense: 10 00 00 00
[   13.125911] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   13.139336]  sdb: sdb1
[   13.145960] sd 3:0:0:0: [sdb] Attached SCSI disk
[   13.223022] mv643xx_eth_port mv643xx_eth_port.0 eth0: link up, 1000 Mb/s, full duplex, flow control disabled

Boot log with eb13cf8345e94a02e9872ca3e909596a5ddb5f90^1 (GOOD):

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.6.0-rc1-mvebu-los_153e602-00008-g8b1750d (aaro at amd-fx-6350) (gcc version 6.1.0 (GCC) ) #1 Thu Aug 11 00:47:22 EEST 2016
[    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=0005317f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine model: OpenRD Client
[    0.000000] Memory policy: Data cache writeback
[    0.000000] On node 0 totalpages: 131072
[    0.000000] free_area_init_node: node 0, pgdat c05f7838, node_mem_map dfbfa000
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 131072 pages, LIFO batch:31
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
[    0.000000] Kernel command line: console=tty console=ttyS0,115200 root=/dev/ram mtdparts=orion_nand:0x400000 at 0x100000(kernel),0x400000 at 0x500000(initramfs),0x1f700000 at 0x900000(scratch)
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 510156K/524288K available (4427K kernel code, 179K rwdata, 1304K rodata, 172K init, 599K bss, 14132K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff800000   ( 496 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05a0ffc   (5732 kB)
[    0.000000]       .init : 0xc05a1000 - 0xc05cc000   ( 172 kB)
[    0.000000]       .data : 0xc05cc000 - 0xc05f8c40   ( 180 kB)
[    0.000000]        .bss : 0xc05f8c40 - 0xc068eb44   ( 600 kB)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] clocksource: orion_clocksource: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 9556302233 ns
[    0.000007] sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 10737418237ns
[    0.000194] Console: colour dummy device 80x30
[    0.000577] console [tty0] enabled
[    0.000614] Calibrating delay loop... 1196.85 BogoMIPS (lpj=5984256)
[    0.090097] pid_max: default: 32768 minimum: 301
[    0.090214] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.090255] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.090806] CPU: Testing write buffer coherency: ok
[    0.091156] Setting up static identity map for 0x81e0 - 0x8238
[    0.091436] mvebu-soc-id: MVEBU SoC ID=0x6281, Rev=0x2
[    0.092649] devtmpfs: initialized
[    0.096298] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.096443] pinctrl core: initialized pinctrl subsystem
[    0.097016] NET: Registered protocol family 16
[    0.097465] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.098490] cpuidle: using governor menu
[    0.098906] Feroceon L2: Enabling L2
[    0.098967] Feroceon L2: Cache support initialised.
[    0.099331] [Firmware Info]: /ocp at f1000000/ethernet-controller at 72000/ethernet0-port at 0: local-mac-address is not set
[    0.099463] [Firmware Info]: /ocp at f1000000/ethernet-controller at 76000/ethernet1-port at 0: local-mac-address is not set
[    0.125539] vgaarb: loaded
[    0.125836] SCSI subsystem initialized
[    0.126380] libata version 3.00 loaded.
[    0.126683] usbcore: registered new interface driver usbfs
[    0.126784] usbcore: registered new interface driver hub
[    0.126862] usbcore: registered new device driver usb
[    0.127776] Advanced Linux Sound Architecture Driver Initialized.
[    0.128522] clocksource: Switched to clocksource orion_clocksource
[    0.146795] NET: Registered protocol family 2
[    0.147360] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.147442] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.147512] TCP: Hash tables configured (established 4096 bind 4096)
[    0.147593] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.147633] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.147788] NET: Registered protocol family 1
[    0.148478] RPC: Registered named UNIX socket transport module.
[    0.148513] RPC: Registered udp transport module.
[    0.148572] RPC: Registered tcp transport module.
[    0.148594] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.148635] PCI: CLS 0 bytes, default 32
[    0.149406] Unpacking initramfs...
[    1.546549] Freeing initrd memory: 2832K (c8000000 - c82c4000)
[    1.547716] futex hash table entries: 256 (order: -1, 3072 bytes)
[    1.571748] workingset: timestamp_bits=29 max_order=17 bucket_order=0
[    1.786392] NET: Registered protocol family 38
[    1.786721] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    1.786773] io scheduler noop registered
[    1.787023] io scheduler cfq registered (default)
[    1.788218] kirkwood-pinctrl f1010000.pin-controller: registered pinctrl driver
[    1.788641] GPIO line 28 (SelRS232or485) hogged as output/low
[    1.789396] irq: Cannot allocate irq_descs @ IRQ36, assuming pre-allocated
[    1.789579] GPIO line 34 (SelUARTorSD) hogged as output/high
[    1.790108] irq: Cannot allocate irq_descs @ IRQ68, assuming pre-allocated
[    1.790778] mvebu-pcie mbus:pcie-controller: PCI host bridge to bus 0000:00
[    1.790819] pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
[    1.790849] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xefffffff]
[    1.790879] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.790926] pci 0000:00:01.0: [11ab:6281] type 01 class 0x060400
[    1.791204] PCI: bus0: Fast back to back transfers disabled
[    1.791240] pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.791447] pci 0000:01:00.0: [18ca:0027] type 00 class 0x030000
[    1.791476] pci 0000:01:00.0: reg 0x10: [mem 0x40000000-0x43ffffff pref]
[    1.791494] pci 0000:01:00.0: reg 0x14: [mem 0x44000000-0x4403ffff]
[    1.791511] pci 0000:01:00.0: reg 0x18: [io  0xf0000000-0xf000007f]
[    1.791547] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    1.791614] pci 0000:01:00.0: supports D1 D2
[    1.791817] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=none,locks=none
[    1.791898] PCI: bus1: Fast back to back transfers disabled
[    1.791931] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    1.791970] pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe5ffffff]
[    1.792004] pci 0000:00:01.0: BAR 7: assigned [io  0x10000-0x10fff]
[    1.792040] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0000000-0xe3ffffff pref]
[    1.792085] pci 0000:01:00.0: BAR 1: assigned [mem 0xe4000000-0xe403ffff]
[    1.792120] pci 0000:01:00.0: BAR 6: assigned [mem 0xe4040000-0xe404ffff pref]
[    1.792162] pci 0000:01:00.0: BAR 2: assigned [io  0x10000-0x1007f]
[    1.792193] pci 0000:00:01.0: PCI bridge to [bus 01]
[    1.792221] pci 0000:00:01.0:   bridge window [io  0x10000-0x10fff]
[    1.792251] pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe5ffffff]
[    1.792528] mv_xor f1060800.xor: Marvell shared XOR driver
[    1.849432] mv_xor f1060800.xor: Marvell XOR (Registers Mode): ( xor cpy intr )
[    1.849707] mv_xor f1060900.xor: Marvell shared XOR driver
[    1.889266] mv_xor f1060900.xor: Marvell XOR (Registers Mode): ( xor cpy intr )
[    1.889875] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    1.898716] console [ttyS0] disabled
[    1.898800] f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 26, base_baud = 12500000) is a 16550A
[    2.540308] console [ttyS0] enabled
[    2.544799] sata_mv f1080000.sata: version 1.28
[    2.545049] sata_mv f1080000.sata: slots 32 ports 2
[    2.592911] scsi host0: sata_mv
[    2.601790] scsi host1: sata_mv
[    2.605277] ata1: SATA max UDMA/133 irq 34
[    2.609458] ata2: SATA max UDMA/133 irq 34
[    2.614257] nand: device found, Manufacturer ID: 0xad, Chip ID: 0xdc
[    2.620693] nand: Hynix NAND 512MiB 3,3V 8-bit
[    2.625177] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    2.632832] Scanning device for bad blocks
[    2.948147] 3 cmdlinepart partitions found on MTD device orion_nand
[    2.954478] Creating 3 MTD partitions on "orion_nand":
[    2.959677] 0x000000100000-0x000000500000 : "kernel"
[    2.989301] 0x000000500000-0x000000900000 : "initramfs"
[    3.008268] 0x000000900000-0x000020000000 : "scratch"
[    3.029869] libphy: orion_mdio_bus: probed
[    3.102853] mv643xx_eth: MV-643xx 10/100/1000 ethernet driver version 1.4
[    3.687795] ata1: SATA link down (SStatus 0 SControl F300)
[    4.193960] mv643xx_eth_port mv643xx_eth_port.0 eth0: port 0 with MAC address 00:50:43:01:dc:35
[    5.277638] ata2: SATA link down (SStatus 0 SControl F300)
[    5.283900] mv643xx_eth_port mv643xx_eth_port.1 eth1: port 0 with MAC address 00:50:43:01:dc:36
[    5.292787] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.299385] ehci-pci: EHCI PCI platform driver
[    5.303939] ehci-orion: EHCI orion driver
[    5.308164] orion-ehci f1050000.ehci: EHCI Host Controller
[    5.313748] orion-ehci f1050000.ehci: new USB bus registered, assigned bus number 1
[    5.321627] orion-ehci f1050000.ehci: irq 30, io mem 0xf1050000
[    5.339998] orion-ehci f1050000.ehci: USB 2.0 started, EHCI 1.00
[    5.346940] hub 1-0:1.0: USB hub found
[    5.356947] hub 1-0:1.0: 1 port detected
[    5.361563] usbcore: registered new interface driver usb-storage
[    5.374358] rtc-mv f1010300.rtc: rtc core: registered f1010300.rtc as rtc0
[    5.381463] i2c /dev entries driver
[    5.398282] md: raid1 personality registered for level 1
[    5.419677] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel at redhat.com
[    5.428630] mvsdio f1090000.mvsdio: Got CD GPIO
[    5.485059] MV-CESA:Could not register sha1 driver
[    5.489954] MV-CESA:Could not register hmac-sha1 driver
[    5.495532] usbcore: registered new interface driver usbhid
[    5.501171] usbhid: USB HID core driver
[    5.505116] xgifb 0000:01:00.0: Relocate IO address: 10000 [00010030]
[    5.511636] pci 0000:00:01.0: enabling device (0140 -> 0143)
[    5.517364] xgifb 0000:01:00.0: chipid = 32
[    5.521605] xgifb: SR14=51 DramSzie 2000000 ChannelNum 1
[    5.527275] xgifb 0000:01:00.0: Framebuffer at 0xe0000000, mapped to 0xe2000000, size 32768k
[    5.535805] xgifb 0000:01:00.0: MMIO at 0xe4000000, mapped to 0xe1300000, size 256k
[    5.597294] xgifb 0000:01:00.0: No or unknown bridge type detected
[    5.603562] xgifb: Default mode is 800x600x16 (60Hz)
[    5.731186] Console: switching to colour frame buffer device 100x37
[    5.852733] cs42l51 0-004a: Cirrus Logic CS42L51, Revision: 01
[    5.861267] mmc0: host does not support reading read-only switch, assuming write-enable
[    5.927631] usb 1-1: new high-speed USB device number 2 using orion-ehci
[    6.017876] mmc0: new high speed SDHC card at address e624
[    6.086135] mmcblk0: mmc0:e624 SU32G 29.7 GiB 
[    6.168437]  mmcblk0: p1 p2
[    6.229655] hub 1-1:1.0: USB hub found
[    6.305795] hub 1-1:1.0: 7 ports detected
[    6.368858] NET: Registered protocol family 17
[    6.440076] asoc-simple-card sound: cs42l51-hifi <-> i2s mapping ok
[    6.513949] cs42l51 0-004a: ASoC: mux DAC Mux has no paths
[    6.578452] rtc-mv f1010300.rtc: setting system clock to 2016-08-10 21:48:48 UTC (1470865728)
[    6.646062] ALSA device list:
[    6.706990]   #0: i2s-cs42l51-hifi
[    6.780690] Freeing unused kernel memory: 172K (c05a1000 - c05cc000)
[    6.844424] This architecture does not have kernel memory protection.
[    6.968592] usb 1-1.4: new high-speed USB device number 3 using orion-ehci
[    7.198587] usb-storage 1-1.4:1.0: USB Mass Storage device detected
[    7.271253] scsi host2: usb-storage 1-1.4:1.0
[    7.438546] usb 1-1.5: new high-speed USB device number 4 using orion-ehci
[    7.628298] usb-storage 1-1.5:1.0: USB Mass Storage device detected
[    7.699687] scsi host3: usb-storage 1-1.5:1.0
[    7.848546] usb 1-1.6: new high-speed USB device number 5 using orion-ehci
[    8.046443] usb-storage 1-1.6:1.0: USB Mass Storage device detected
[    8.119458] scsi host4: usb-storage 1-1.6:1.0
[    8.330459] scsi 2:0:0:0: Direct-Access     Ext Hard  Disk                 PQ: 0 ANSI: 5
[    8.401830] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    8.471939] sd 2:0:0:0: [sda] Spinning up disk...
[    8.760333] scsi 3:0:0:0: Direct-Access     Ext Hard  Disk                 PQ: 0 ANSI: 5
[    8.829854] sd 3:0:0:0: Attached scsi generic sg1 type 0
[    8.898616] sd 3:0:0:0: [sdb] Spinning up disk...
[    9.183709] scsi 4:0:0:0: CD-ROM            Lenovo   Slim_USB_Burner  8L32 PQ: 0 ANSI: 0
[    9.266157] sr 4:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[    9.334937] cdrom: Uniform CD-ROM driver Revision: 3.20
[    9.422507] sr 4:0:0:0: Attached scsi CD-ROM sr0
[    9.422941] sr 4:0:0:0: Attached scsi generic sg2 type 5
[    9.822936] EXT4-fs (mmcblk0p2): couldn't mount as ext3 due to feature incompatibilities
[    9.892244] EXT4-fs (mmcblk0p2): couldn't mount as ext2 due to feature incompatibilities
[    9.972958] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[   11.212207] Adding 4194300k swap on /dev/mmcblk0p1.  Priority:-1 extents:1 across:4194300k SS
[   11.997418] random: dropbear urandom read with 29 bits of entropy available
[   13.878537] .ready
[   13.943665] sd 2:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[   14.016287] sd 2:0:0:0: [sda] Write Protect is off
[   14.083363] sd 2:0:0:0: [sda] Mode Sense: 10 00 00 00
[   14.084150] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   14.222325]  sda: sda1
[   14.292690] sd 2:0:0:0: [sda] Attached SCSI disk
[   14.568534] .ready
[   14.630855] mv643xx_eth_port mv643xx_eth_port.0 eth0: link up, 1000 Mb/s, full duplex, flow control disabled
[   14.764921] sd 3:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[   14.836926] sd 3:0:0:0: [sdb] Write Protect is off
[   14.903821] sd 3:0:0:0: [sdb] Mode Sense: 10 00 00 00
[   14.904525] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   15.042700]  sdb: sdb1
[   15.111425] sd 3:0:0:0: [sdb] Attached SCSI disk

A.
