From: a.aubert@overkiz.com (Antoine Aubert)
Date: Mon, 16 Jan 2017 11:54:23 +0100
Subject: USB: OHCI: high softirq load
In-Reply-To: <ad8a54c3-c83d-109f-5cc5-7e77e9deff12@overkiz.com>
References: <bd83e3b2-b329-3635-2917-0ffe61d3535f@overkiz.com>
 <20170116100220.0b00658e@bbrezillon>
 <ad8a54c3-c83d-109f-5cc5-7e77e9deff12@overkiz.com>
Message-ID: <d49db4ac-fbeb-23ce-d48c-bd087c314328@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also, I made a big misunderstanding

With EHCI + OHCI = high level of softirq (USB2.0)

OHCI only = normal level

Le 16/01/2017 ? 11:31, Antoine Aubert a ?crit :
> Thx for your answer Boris
>
> Le 16/01/2017 ? 10:02, Boris Brezillon a ?crit :
>> Hi Antoine,
>>
>> On Mon, 16 Jan 2017 08:45:58 +0100
>> Antoine Aubert <a.aubert@overkiz.com> wrote:
>>
>>> Hi,
>>>
>>> Im working on a AT91SAM9G25cu board
>>> (arch/arm/boot/dts/at91-kizboxmini.dts). We use linux-4.1.31, and when
>>> OHCI is enabled, I got some wired effects.
>> Can you test on a more recent kernel (4.9 or 4.10-rc4)?
> I'll give a try, just need little time ;)
>>> eg with 3 FTDI pluged, interrupts: more than 3.5k/s, cpu softirq > 24%,
>>> loadavg > 0.5
>> Can you check which interrupt is triggered (cat /proc/interrupts),
> cat /proc/interrupts
>            CPU0      
>  16:       2286  atmel-aic   1 Level     pmc, at91_tick, at91_rtc, ttyS0
>  17:          0       PMC  17 Level     main_rc_osc
>  18:          0       PMC   0 Level     main_osc
>  19:          0       PMC  16 Level     mainck
>  20:          0       PMC   1 Level     clk-plla
>  21:          0       PMC   6 Level     clk-utmi
>  22:          0       PMC   3 Level     clk-master
>  23:     945527  atmel-aic  17 Level     tc_clkevt
>  24:      21815  atmel-aic  20 Level     at_hdmac
>  25:          0  atmel-aic  21 Level     at_hdmac
>  30:     120299  atmel-aic  24 Level     eth0
>  31:   22783651  atmel-aic  22 Level     ehci_hcd:usb1, ohci_hcd:usb2
>  99:          0      GPIO  16 Edge      PB_RST
> 100:          0      GPIO  17 Edge      PB_PROG
> Err:          0
>
>>  and
>> enable debug messages in drivers/usb/host/ohci-at91.c?
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.1.31 (antoine at ltp.antoine) (gcc version
> 4.9.2 (GCC) ) #1 Mon Jan 16 11:04:03 CET 2017
> [    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=0005317f
> [    0.000000] CPU: VIVT data cache, VIVT instruction cache
> [    0.000000] Machine model: Overkiz Kizbox Mini RailDIN
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] Memory policy: Data cache writeback
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
> Total pages: 32512
> [    0.000000] Kernel command line: panic=5 oops=panic root=ubi0:root
> rootfstype=ubifs ubi.mtd=ubi rw console=ttyS0,115200 earlyprintk
> loglevel=7 dyndbg='file ohci-at91.c +p'
> [    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
> [    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536
> bytes)
> [    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> [    0.000000] Memory: 125076K/131072K available (3204K kernel code,
> 136K rwdata, 1116K rodata, 132K init, 84K bss, 5996K reserved, 0K
> cma-reserved)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> [    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
> [    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc04404b4   (4322 kB)
> [    0.000000]       .init : 0xc0441000 - 0xc0462000   ( 132 kB)
> [    0.000000]       .data : 0xc0462000 - 0xc0484310   ( 137 kB)
> [    0.000000]        .bss : 0xc0484310 - 0xc0499550   (  85 kB)
> [    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.000000] NR_IRQS:16 nr_irqs:16 16
> [    0.000000] clocksource pit: mask: 0x7ffffff max_cycles: 0x7ffffff,
> max_idle_ns: 7167226906 ns
> [    0.000000] sched_clock: 32 bits at 128 Hz, resolution 7812500ns,
> wraps every 16777215996093750ns
> [    0.007812] Calibrating delay loop... 198.76 BogoMIPS (lpj=775168)
> [    0.078125] pid_max: default: 32768 minimum: 301
> [    0.085937] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.093750] Mountpoint-cache hash table entries: 1024 (order: 0, 4096
> bytes)
> [    0.101562] CPU: Testing write buffer coherency: ok
> [    0.101562] Setting up static identity map for 0x20008400 - 0x2000847c
> [    0.117187] dynamic_debug:ddebug_tokenize: unclosed quote: file
> [    0.125000] dynamic_debug:ddebug_exec_query: tokenize failed
> [    0.132812] devtmpfs: initialized
> [    0.164062] clocksource jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 14931722236523437 ns
> [    0.171875] pinctrl core: initialized pinctrl subsystem
> [    0.179687] NET: Registered protocol family 16
> [    0.187500] DMA: preallocated 256 KiB pool for atomic coherent
> allocations
> [    0.195312] AT91: Detected SoC family: at91sam9x5
> [    0.203125] AT91: Detected SoC: at91sam9g25, revision 1
> [    0.226562] gpio-at91 fffff400.gpio: at address fefff400
> [    0.234375] gpio-at91 fffff600.gpio: at address fefff600
> [    0.242187] gpio-at91 fffff800.gpio: at address fefff800
> [    0.250000] gpio-at91 fffffa00.gpio: at address fefffa00
> [    0.257812] pinctrl-at91 ahb:apb:pinctrl at fffff400: initialized AT91
> pinctrl driver
> [    0.265625] clocksource tcb_clksrc: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 114675631333 ns
> [    4.718750] UDP hash table entries: 256 (order: 0, 4096 bytes)
> [    4.726562] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> [    4.734375] NET: Registered protocol family 1
> [    4.742187] futex hash table entries: 256 (order: -1, 3072 bytes)
> [    4.789062] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    4.804687] io scheduler noop registered (default)
> [    4.812500] fffff200.serial: ttyS0 at MMIO 0xfffff200 (irq = 16,
> base_baud = 8333333) is a ATMEL_SERIAL
> [    4.820312] console [ttyS0] enabled
> [    4.828125] bootconsole [earlycon0] disabled
> [    4.851562] brd: module loaded
> [    4.882812] loop: module loaded
> [    4.898437] atmel_nand 40000000.nand: Use On Flash BBT
> [    4.898437] atmel_nand 40000000.nand: Using dma0chan0 for DMA transfers.
> [    4.906250] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xf1
> [    4.914062] nand: Micron MT29F1G08ABAEAWP
> [    4.921875] nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048,
> OOB size: 64
> [    4.929687] atmel_nand 40000000.nand: minimum ECC: 4 bits in 512 bytes
> [    4.929687] atmel_nand 40000000.nand: Initialize PMECC params, cap:
> 4, sector: 512
> [    4.945312] Bad block table found at page 65472, version 0x01
> [    4.945312] Bad block table found at page 65408, version 0x01
> [    4.953125] 2 ofpart partitions found on MTD device atmel_nand
> [    4.960937] Creating 2 MTD partitions on "atmel_nand":
> [    4.968750] 0x000000000000-0x000000020000 : "bootstrap"
> [    4.976562] 0x000000020000-0x000008000000 : "ubi"
> [    4.992187] macb f802c000.ethernet (unnamed net_device)
> (uninitialized): invalid hw address, using random
> [    5.000000] libphy: MACB_mii_bus: probed
> [    5.093750] macb f802c000.ethernet eth0: Cadence MACB rev 0x0001010c
> at 0xf802c000 irq 30 (8e:06:02:88:ed:97)
> [    5.101562] macb f802c000.ethernet eth0: attached PHY driver [Micrel
> KSZ8081 or KSZ8091] (mii_bus:phy_addr=f802c000.etherne:01, irq=-1)
> [    5.109375] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    5.117187] ehci-atmel: EHCI Atmel driver
> [    5.125000] atmel-ehci 700000.ehci: EHCI Host Controller
> [    5.125000] atmel-ehci 700000.ehci: new USB bus registered, assigned
> bus number 1
> [    5.140625] atmel-ehci 700000.ehci: irq 31, io mem 0x00700000
> [    5.156250] atmel-ehci 700000.ehci: USB 2.0 started, EHCI 1.00
> [    5.156250] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> [    5.164062] usb usb1: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [    5.171875] usb usb1: Product: EHCI Host Controller
> [    5.179687] usb usb1: Manufacturer: Linux 4.1.31 ehci_hcd
> [    5.179687] usb usb1: SerialNumber: 700000.ehci
> [    5.187500] hub 1-0:1.0: USB hub found
> [    5.195312] hub 1-0:1.0: 3 ports detected
> [    5.203125] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    5.203125] ohci-atmel: OHCI Atmel driver
> [    5.210937] at91_ohci 600000.ohci: start
> [    5.210937] at91_ohci 600000.ohci: USB Host Controller
> [    5.218750] at91_ohci 600000.ohci: new USB bus registered, assigned
> bus number 2
> [    5.226562] at91_ohci 600000.ohci: irq 31, io mem 0x00600000
> [    5.289062] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
> [    5.296875] usb usb2: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [    5.304687] usb usb2: Product: USB Host Controller
> [    5.304687] usb usb2: Manufacturer: Linux 4.1.31 ohci_hcd
> [    5.312500] usb usb2: SerialNumber: at91
> [    5.320312] hub 2-0:1.0: USB hub found
> [    5.320312] at91_ohci 600000.ohci:
> ohci_at91_hub_control(c7a86800,0xa006,0x2900,0x0000,c78b8b60,000f)
> [    5.320312] at91_ohci 600000.ohci: wHubCharacteristics 0x0002
> [    5.328125] at91_ohci 600000.ohci: wHubCharacteristics after 0x0001
> [    5.328125] hub 2-0:1.0: 1 port detected
> [    5.328125] at91_ohci 600000.ohci:
> ohci_at91_hub_control(c7a86800,0xa000,0x0000,0x0000,c78b8b80,0004)
> [    5.328125] at91_ohci 600000.ohci:
> ohci_at91_hub_control(c7a86800,0x2303,0x0008,0x0001,c78b8c00,0000)
> [    5.328125] at91_ohci 600000.ohci: SetPortFeat: POWER
> [    5.328125] rtc rtc0: alarm rollover not handled
> [    5.335937] rtc rtc0: invalid alarm value: 1900-1-1 0:0:0
> [    5.343750] at91_rtc fffffeb0.rtc: rtc core: registered fffffeb0.rtc
> as rtc0
> [    5.351562] at91_rtc fffffeb0.rtc: AT91 Real Time Clock driver.
> [    5.359375] AT91: Starting after software reset
> [    5.367187] at91sam9_wdt: enabled (heartbeat=15 sec, nowayout=1)
> [    5.375000] hidraw: raw HID events driver (C) Jiri Kosina
> [    5.382812] usbcore: registered new interface driver usbhid
> [    5.382812] usbhid: USB HID core driver
> [    5.390625] NET: Registered protocol family 17
> [    5.398437] bridge: automatic filtering via arp/ip/ip6tables has been
> deprecated. Update your scripts to load br_netfilter if you need this.
> [    5.421875] ubi0: attaching mtd1
> [    5.429687] at91_ohci 600000.ohci:
> ohci_at91_hub_control(c7a86800,0xa300,0x0000,0x0001,c7980a00,0004)
> [    5.429687] at91_ohci 600000.ohci: GetPortStatus(0)
> [    5.546875] usb 1-1: new high-speed USB device number 2 using atmel-ehci
> [    5.703125] usb 1-1: New USB device found, idVendor=0424, idProduct=2512
> [    5.703125] usb 1-1: New USB device strings: Mfr=0, Product=0,
> SerialNumber=0
> [    5.718750] hub 1-1:1.0: USB hub found
> [    5.718750] hub 1-1:1.0: 2 ports detected
> [    5.906250] ubi0: scanning is finished
> [    5.929687] ubi0: attached mtd1 (name "ubi", size 127 MiB)
> [    5.937500] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976
> bytes
> [    5.945312] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 2048
> [    5.945312] ubi0: VID header offset: 2048 (aligned 2048), data
> offset: 4096
> [    5.953125] ubi0: good PEBs: 1019, bad PEBs: 4, corrupted PEBs: 0
> [    5.960937] ubi0: user volume: 9, internal volumes: 1, max. volumes
> count: 128
> [    5.968750] ubi0: max/mean erase counter: 22/16, WL threshold: 4096,
> image sequence number: 1226704751
> [    5.976562] ubi0: available PEBs: 94, total reserved PEBs: 925, PEBs
> reserved for bad PEB handling: 16
> [    5.984375] ubi0: background thread "ubi_bgt0d" started, PID 375
> [    6.039062] input: gpio_keys as /devices/soc0/gpio_keys/input/input0
> [    6.046875] at91_rtc fffffeb0.rtc: setting system clock to 2017-01-16
> 10:22:55 UTC (1484562175)
> [    6.062500] usb 1-1.1: new full-speed USB device number 3 using
> atmel-ehci
> [    6.085937] UBIFS (ubi0:7): background thread "ubifs_bgt0_7" started,
> PID 434
> [    6.109375] UBIFS (ubi0:7): recovery needed
> [    6.187500] usb 1-1.1: New USB device found, idVendor=2d71,
> idProduct=0703
> [    6.195312] usb 1-1.1: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [    6.203125] usb 1-1.1: Product: C
> [    6.210937] usb 1-1.1: Manufacturer: OVERKIZ SAS
> [    6.210937] usb 1-1.1: SerialNumber: 12-16
> [    6.234375] UBIFS (ubi0:7): recovery completed
> [    6.234375] UBIFS (ubi0:7): UBIFS: mounted UBI device 0, volume 7,
> name "root"
> [    6.242187] UBIFS (ubi0:7): LEB size: 126976 bytes (124 KiB),
> min./max. I/O unit sizes: 2048 bytes/2048 bytes
> [    6.250000] UBIFS (ubi0:7): FS size: 49393664 bytes (47 MiB, 389
> LEBs), journal size 9023488 bytes (8 MiB, 72 LEBs)
> [    6.257812] UBIFS (ubi0:7): reserved for root: 0 bytes (0 KiB)
> [    6.265625] UBIFS (ubi0:7): media format: w4/r0 (latest is w4/r0),
> UUID 8FB0025A-D045-4284-B10B-16D0A55EFC51, small LPT model
> [    6.281250] VFS: Mounted root (ubifs filesystem) on device 0:13.
> [    6.289062] devtmpfs: mounted
> [    6.289062] Freeing unused kernel memory: 132K (c0441000 - c0462000)
> [    6.359375] usb 1-1.2: new high-speed USB device number 4 using
> atmel-ehci
> [    6.476562] usb 1-1.2: New USB device found, idVendor=0424,
> idProduct=2512
> [    6.484375] usb 1-1.2: New USB device strings: Mfr=0, Product=0,
> SerialNumber=0
> [    6.492187] hub 1-1.2:1.0: USB hub found
> [    6.500000] hub 1-1.2:1.0: 2 ports detected
> [    6.789062] usb 1-1.2.1: new full-speed USB device number 5 using
> atmel-ehci
> [    6.921875] usb 1-1.2.1: New USB device found, idVendor=2d71,
> idProduct=0702
> [    6.921875] usb 1-1.2.1: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [    6.929687] usb 1-1.2.1: Product: B
> [    6.937500] usb 1-1.2.1: Manufacturer: OVERKIZ SAS
> [    6.945312] usb 1-1.2.1: SerialNumber: 12-16
> [    7.132812] usb 1-1.2.2: new high-speed USB device number 6 using
> atmel-ehci
> [    7.250000] usb 1-1.2.2: New USB device found, idVendor=0424,
> idProduct=2512
> [    7.257812] usb 1-1.2.2: New USB device strings: Mfr=0, Product=0,
> SerialNumber=0
> [    7.335937] hub 1-1.2.2:1.0: USB hub found
> [    7.382812] hub 1-1.2.2:1.0: 2 ports detected
> [    7.476562] usbcore: registered new interface driver usbserial
> [    7.476562] usbcore: registered new interface driver usbserial_generic
> [    7.484375] usbserial: USB Serial support registered for generic
> [    7.632812] usbcore: registered new interface driver ftdi_sio
> [    7.640625] usbserial: USB Serial support registered for FTDI USB
> Serial Device
> [    7.648437] ftdi_sio 1-1.1:1.0: FTDI USB Serial Device converter detected
> [    7.656250] usb 1-1.1: Detected FT232RL
> [    7.679687] usb 1-1.2.2.1: new full-speed USB device number 7 using
> atmel-ehci
> [    7.796875] usb 1-1.1: FTDI USB Serial Device converter now attached
> to ttyUSB0
> [    7.804687] ftdi_sio 1-1.2.1:1.0: FTDI USB Serial Device converter
> detected
> [    7.812500] usb 1-1.2.1: Detected FT232RL
> [    7.820312] cfg80211: Calling CRDA to update world regulatory domain
> [    7.828125] usb 1-1.2.2.1: New USB device found, idVendor=2d71,
> idProduct=0700
> [    7.835937] usb 1-1.2.2.1: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [    7.843750] usb 1-1.2.2.1: Product: A
> [    7.851562] usb 1-1.2.2.1: Manufacturer: OVERKIZ SAS
> [    7.851562] usb 1-1.2.2.1: SerialNumber: 12-16
> [    7.914062] usb 1-1.2.1: FTDI USB Serial Device converter now
> attached to ttyUSB1
> [    8.000000] ftdi_sio 1-1.2.2.1:1.0: FTDI USB Serial Device converter
> detected
> [    8.007812] usb 1-1.2.2.1: Detected FT232RL
> [    8.054687] usb 1-1.2.2.1: FTDI USB Serial Device converter now
> attached to ttyUSB2
> [    8.187500] usb 1-1.2.2.2: new high-speed USB device number 8 using
> atmel-ehci
> [    8.312500] usb 1-1.2.2.2: New USB device found, idVendor=7392,
> idProduct=7811
> [    8.320312] usb 1-1.2.2.2: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [    8.328125] usb 1-1.2.2.2: Product: 802.11n WLAN Adapter
> [    8.328125] usb 1-1.2.2.2: Manufacturer: Realtek
> [    8.335937] usb 1-1.2.2.2: SerialNumber: 00e04c000001
>
>> Thanks,
>>
>> Boris
>>
>>> This issue disappear when disabling OHCI and use EHCI only.
>>>
>>> What are the usual causes, and where to begin with ?
>>>
>>> Thanks in advance,
>>>
> Thanks,
>
