From: a.aubert@overkiz.com (Antoine Aubert)
Date: Mon, 7 Sep 2015 09:31:07 +0200
Subject: at91sam9 Main crystal frequency problems
Message-ID: <55ED3D3B.8060700@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I currently bring up a board based on AT91SAM9G25cu, and I having
problems of watchdogs resets.

We use linux-4.04 mainline, and i found some weird warnings on kernel
traces, concerning main clk.

[    0.000000] Main crystal frequency not set, using approximate value
[    0.000000] master clk is overclocked
[    0.000000] sched_clock: 32 bits at 128 Hz, resolution 7812500ns,
wraps every 16777216000000000ns
[    0.007812] Calibrating delay loop... 198.76 BogoMIPS (lpj=775168)

I set crystal clock in the DT, but it doesn't seems to work.. I feel
that the board works out of the specified range.

So here comes my questions:
Can there be a relationship with watchdog problems ? (1 per day)
Why is it that the frequency of Crystal is not found ?

I attached my DT, and kernel prints.

Thanks for your help.

-- 
Antoine Aubert
a.aubert at overkiz.com
-------------- next part --------------
ll /proc/device-tree/clocks/*
-r--r--r--    1 root     root             7 Sep  7 09:13 /proc/device-tree/clocks/name

/proc/device-tree/clocks/adc_op_clk:
-r--r--r--    1 root     root             4 Sep  7 09:14 #clock-cells
-r--r--r--    1 root     root             4 Sep  7 09:14 clock-frequency
-r--r--r--    1 root     root            12 Sep  7 09:14 compatible
-r--r--r--    1 root     root             4 Sep  7 09:14 linux,phandle
-r--r--r--    1 root     root            11 Sep  7 09:14 name
-r--r--r--    1 root     root             4 Sep  7 09:14 phandle

/proc/device-tree/clocks/main_xtal:
-r--r--r--    1 root     root             4 Sep  7 09:14 #clock-cells
-r--r--r--    1 root     root             4 Sep  7 09:14 clock-frequency
-r--r--r--    1 root     root            12 Sep  7 09:14 compatible
-r--r--r--    1 root     root             4 Sep  7 09:14 linux,phandle
-r--r--r--    1 root     root            10 Sep  7 09:14 name
-r--r--r--    1 root     root             4 Sep  7 09:14 phandle

/proc/device-tree/clocks/slow_xtal:
-r--r--r--    1 root     root             4 Sep  7 09:14 #clock-cells
-r--r--r--    1 root     root             4 Sep  7 09:14 clock-frequency
-r--r--r--    1 root     root            12 Sep  7 09:14 compatible
-r--r--r--    1 root     root             4 Sep  7 09:14 linux,phandle
-r--r--r--    1 root     root            10 Sep  7 09:14 name
-r--r--r--    1 root     root             4 Sep  7 09:14 phandle

-------------- next part --------------
cat /sys/kernel/debug/clk/clk_summary
   clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
----------------------------------------------------------------------------------------
 slow_xtal                                0            0       32768          0 0  
    slow_osc                              0            0       32768          0 0  
 main_xtal                                1            1    12000000          0 0  
    main_osc                              1            1    12000000          0 0  
       mainck                             2            2    12000000          0 0  
          utmick                          2            2   480000000          0 0  
             usbck                        2            2    48000000          0 0  
                udpck                     0            0    48000000          0 0  
                uhpck                     1            1    48000000          0 0  
          pllack                          1            1   800000000          0 0  
             plladivck                    1            1   400000000          0 0  
                smdclk                    0            0   400000000          0 0  
                   smdck                  0            0   400000000          0 0  
                masterck                 11           11   133333333          0 0  
                   ddrck                  1            1   133333333          0 0  
                   usart3_clk             0            0   133333333          0 0  
                   usart2_clk             0            0   133333333          0 0  
                   usart1_clk             0            0   133333333          0 0  
                   usart0_clk             1            1   133333333          0 0  
                   uhphs_clk              3            3   133333333          0 0  
                   udphs_clk              0            0   133333333          0 0  
                   uart1_clk              0            0   133333333          0 0  
                   uart0_clk              0            0   133333333          0 0  
                   twi2_clk               0            0   133333333          0 0  
                   twi1_clk               0            0   133333333          0 0  
                   twi0_clk               0            0   133333333          0 0  
                   tcb0_clk               2            2   133333333          0 0  
                   ssc0_clk               0            0   133333333          0 0  
                   spi1_clk               0            0   133333333          0 0  
                   spi0_clk               0            0   133333333          0 0  
                   smd_clk                0            0   133333333          0 0  
                   pwm_clk                2            1   133333333          0 0  
                   pioCD_clk              2            2   133333333          0 0  
                   pioAB_clk              2            2   133333333          0 0  
                   mci1_clk               0            0   133333333          0 0  
                   mci0_clk               0            0   133333333          0 0  
                   macb0_clk              2            2   133333333          0 0  
                   dma1_clk               1            1   133333333          0 0  
                   dma0_clk               1            1   133333333          0 0  
                   adc_clk                0            0   133333333          0 0  
 adc_op_clk                               0            0     5000000          0 0  
 slow_rc_osc                              1            1       32768   50000000 0  
    slck                                  1            1       32768   50000000 0  
       prog0                              0            0       32768   50000000 0  
          pck0                            0            0       32768   50000000 0  
       prog1                              0            0       32768   50000000 0  
          pck1                            0            0       32768   50000000 0  
 main_rc_osc                              0            0    12000000   50000000 0
-------------- next part --------------
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.0.4 (antoine at compile-embedded) (gcc version 4.9.1 (GCC) ) #1 Thu Sep 3 09:25:30 CEST 2015
[    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=0005317f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine model: Overkiz Kizbox mini
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] AT91: Detected soc type: at91sam9x5
[    0.000000] AT91: Detected soc subtype: at91sam9g25
[    0.000000] On node 0 totalpages: 32768
[    0.000000] free_area_init_node: node 0, pgdat c03dabac, node_mem_map c7ef9000
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32768 pages, LIFO batch:7
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: panic=5 root=ubi0:root rootfstype=ubifs rw ubi.mtd=ubi console=ttyS0,115200 earlyprintk 
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 125616K/131072K available (2698K kernel code, 133K rwdata, 988K rodata, 128K init, 194K bss, 5456K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc03a1f54   (3688 kB)
[    0.000000]       .init : 0xc03a2000 - 0xc03c2000   ( 128 kB)
[    0.000000]       .data : 0xc03c2000 - 0xc03e37c0   ( 134 kB)
[    0.000000]        .bss : 0xc03e37c0 - 0xc0414394   ( 195 kB)
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] Main crystal frequency not set, using approximate value
[    0.000000] master clk is overclocked
[    0.000000] sched_clock: 32 bits at 128 Hz, resolution 7812500ns, wraps every 16777216000000000ns
[    0.007812] Calibrating delay loop... 198.76 BogoMIPS (lpj=775168)
[    0.070312] pid_max: default: 32768 minimum: 301
[    0.078125] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.085937] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.093750] CPU: Testing write buffer coherency: ok
[    0.101562] Setting up static identity map for 0x20290e20 - 0x20290e9c
[    0.109375] devtmpfs: initialized
[    0.117187] pinctrl core: initialized pinctrl subsystem
[    0.148437] NET: Registered protocol family 16
[    0.156250] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.179687] AT91: Power Management
[    0.187500] gpio-at91 fffff400.gpio: at address fefff400
[    0.195312] gpio-at91 fffff600.gpio: at address fefff600
[    0.203125] gpio-at91 fffff800.gpio: at address fefff800
[    0.210937] gpio-at91 fffffa00.gpio: at address fefffa00
[    0.218750] pinctrl-at91 ahb:apb:pinctrl at fffff400: initialized AT91 pinctrl driver
[    0.226562] tcb_clksrc: tc0 at 16.166 MHz
[    0.265625] at_hdmac ffffec00.dma-controller: Atmel AHB DMA Controller ( cpy slave ), 8 channels
[    0.281250] at_hdmac ffffee00.dma-controller: Atmel AHB DMA Controller ( cpy slave ), 8 channels
[    0.296875] usbcore: registered new interface driver usbfs
[    0.296875] usbcore: registered new interface driver hub
[    0.304687] usbcore: registered new device driver usb
[    0.312500] Switched to clocksource tcb_clksrc
[    0.335937] NET: Registered protocol family 2
[    0.335937] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.343750] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.351562] TCP: Hash tables configured (established 1024 bind 1024)
[    0.359375] TCP: reno registered
[    0.359375] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.367187] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.375000] NET: Registered protocol family 1
[    0.382812] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.390625] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.398437] io scheduler noop registered (default)
[    0.406250] f801c000.serial: ttyS1 at MMIO 0xf801c000 (irq = 30, base_baud = 8333333) is a ATMEL_SERIAL
[    0.414062] fffff200.serial: ttyS0 at MMIO 0xfffff200 (irq = 16, base_baud = 8333333) is a ATMEL_SERIAL
[    0.421875] console [ttyS0] enabled
[    0.429687] bootconsole [earlycon0] disabled
[    0.453125] brd: module loaded
[    0.476562] loop: module loaded
[    0.492187] atmel_nand 40000000.nand: Use On Flash BBT
[    0.492187] atmel_nand 40000000.nand: Using dma0chan0 for DMA transfers.
[    0.500000] nand: device found, Manufacturer ID: 0x01, Chip ID: 0xf1
[    0.507812] nand: AMD/Spansion S34ML01G2
[    0.507812] nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    0.515625] atmel_nand 40000000.nand: minimum ECC: 4 bits in 512 bytes
[    0.523437] atmel_nand 40000000.nand: Initialize PMECC params, cap: 4, sector: 512
[    0.531250] Bad block table found at page 65472, version 0x01
[    0.539062] Bad block table found at page 65408, version 0x01
[    0.546875] 2 ofpart partitions found on MTD device atmel_nand
[    0.546875] Creating 2 MTD partitions on "atmel_nand":
[    0.554687] 0x000000000000-0x000000020000 : "bootstrap"
[    0.562500] 0x000000020000-0x000008000000 : "ubi"
[    0.578125] macb f802c000.ethernet (unnamed net_device) (uninitialized): invalid hw address, using random
[    0.585937] libphy: MACB_mii_bus: probed
[    0.671875] macb f802c000.ethernet eth0: Cadence MACB rev 0x0001010c at 0xf802c000 irq 26 (0a:90:3d:11:5b:1c)
[    0.679687] macb f802c000.ethernet eth0: attached PHY driver [Micrel KSZ8081 or KSZ8091] (mii_bus:phy_addr=f802c000.etherne:01, irq=-1)
[    0.687500] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.695312] ehci-atmel: EHCI Atmel driver
[    0.695312] atmel-ehci 700000.ehci: EHCI Host Controller
[    0.703125] atmel-ehci 700000.ehci: new USB bus registered, assigned bus number 1
[    0.710937] atmel-ehci 700000.ehci: irq 32, io mem 0x00700000
[    0.734375] atmel-ehci 700000.ehci: USB 2.0 started, EHCI 1.00
[    0.734375] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.742187] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.750000] usb usb1: Product: EHCI Host Controller
[    0.750000] usb usb1: Manufacturer: Linux 4.0.4 ehci_hcd
[    0.757812] usb usb1: SerialNumber: 700000.ehci
[    0.765625] hub 1-0:1.0: USB hub found
[    0.765625] hub 1-0:1.0: 3 ports detected
[    0.773437] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.781250] ohci-atmel: OHCI Atmel driver
[    0.781250] at91_ohci 600000.ohci: USB Host Controller
[    0.789062] at91_ohci 600000.ohci: new USB bus registered, assigned bus number 2
[    0.796875] at91_ohci 600000.ohci: irq 32, io mem 0x00600000
[    0.859375] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    0.867187] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.875000] usb usb2: Product: USB Host Controller
[    0.875000] usb usb2: Manufacturer: Linux 4.0.4 ohci_hcd
[    0.882812] usb usb2: SerialNumber: at91
[    0.890625] hub 2-0:1.0: USB hub found
[    0.890625] hub 2-0:1.0: 1 port detected
[    0.898437] AT91: Starting after general reset
[    0.906250] at91sam9_wdt: enabled (heartbeat=15 sec, nowayout=1)
[    0.914062] hidraw: raw HID events driver (C) Jiri Kosina
[    0.914062] usbcore: registered new interface driver usbhid
[    0.921875] usbhid: USB HID core driver
[    0.929687] TCP: cubic registered
[    0.929687] NET: Registered protocol family 17
[    0.945312] ubi0: attaching mtd1
[    1.343750] ubi0: scanning is finished
[    1.367187] ubi0: attached mtd1 (name "ubi", size 127 MiB)
[    1.375000] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976 bytes
[    1.382812] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 2048
[    1.390625] ubi0: VID header offset: 2048 (aligned 2048), data offset: 4096
[    1.390625] ubi0: good PEBs: 1019, bad PEBs: 4, corrupted PEBs: 0
[    1.398437] ubi0: user volume: 9, internal volumes: 1, max. volumes count: 128
[    1.406250] ubi0: max/mean erase counter: 2/1, WL threshold: 4096, image sequence number: 288141040
[    1.414062] ubi0: available PEBs: 102, total reserved PEBs: 917, PEBs reserved for bad PEB handling: 16
[    1.421875] ubi0: background thread "ubi_bgt0d" started, PID 292
[    1.468750] input: gpio_keys as /devices/platform/gpio_keys/input/input0
[    1.500000] UBIFS: background thread "ubifs_bgt0_7" started, PID 351
[    1.515625] UBIFS: recovery needed
[    1.593750] UBIFS: recovery completed
[    1.593750] UBIFS: mounted UBI device 0, volume 7, name "root"
[    1.601562] UBIFS: LEB size: 126976 bytes (124 KiB), min./max. I/O unit sizes: 2048 bytes/2048 bytes
[    1.609375] UBIFS: FS size: 49393664 bytes (47 MiB, 389 LEBs), journal size 9023488 bytes (8 MiB, 72 LEBs)
[    1.617187] UBIFS: reserved for root: 0 bytes (0 KiB)
[    1.617187] UBIFS: media format: w4/r0 (latest is w4/r0), UUID 778BA019-0C14-4BE8-857A-A31BF387B571, small LPT model
[    1.625000] VFS: Mounted root (ubifs filesystem) on device 0:13.
[    1.632812] devtmpfs: mounted
[    1.632812] Freeing unused kernel memory: 128K (c03a2000 - c03c2000)
[    2.695312] random: dd urandom read with 54 bits of entropy available
[    3.000000] UBIFS: background thread "ubifs_bgt0_8" started, PID 415
[    3.023437] UBIFS: recovery needed
[    3.148437] UBIFS: recovery completed
[    3.148437] UBIFS: mounted UBI device 0, volume 8, name "apps"
[    3.156250] UBIFS: LEB size: 126976 bytes (124 KiB), min./max. I/O unit sizes: 2048 bytes/2048 bytes
[    3.164062] UBIFS: FS size: 49393664 bytes (47 MiB, 389 LEBs), journal size 9023488 bytes (8 MiB, 72 LEBs)
[    3.171875] UBIFS: reserved for root: 0 bytes (0 KiB)
[    3.171875] UBIFS: media format: w4/r0 (latest is w4/r0), UUID B11D014C-5838-40FE-AE66-E6FAE0EC2398, small LPT model
[    5.671875] macb f802c000.ethernet eth0: link up (100/Full)
[   10.914062] random: nonblocking pool is initialized
-------------- next part --------------
A non-text attachment was scrubbed...
Name: at91-kizboxmini.dts
Type: audio/vnd.dts
Size: 2484 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150907/06bcf6f1/attachment-0001.dts>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150907/06bcf6f1/attachment-0001.sig>
