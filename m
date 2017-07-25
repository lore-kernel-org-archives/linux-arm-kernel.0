From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 25 Jul 2017 20:44:38 +0200 (CEST)
Subject: No Ethernet on Raspberry Pi 3 in v4.13-rc1
In-Reply-To: <38cfb4d7-c356-d2b2-0367-69ef3417d941@arm.com>
References: <5650979e-ea55-0337-2edd-d2c3e8ad0e37@suse.de>
 <b849a4dc-a095-6bb4-caf1-a1f7470bed91@arm.com>
 <1435162494.87709.1500959996834@email.1und1.de>
 <38cfb4d7-c356-d2b2-0367-69ef3417d941@arm.com>
Message-ID: <378781535.113835.1501008278477@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Robin Murphy <robin.murphy@arm.com> hat am 25. Juli 2017 um 15:21 geschrieben:
> 
> From the subsequent fallout (which on closer inspection looks more to do
> with calling into uninitialised SWIOTLB state than the arm64 DMA code
> actually doing anything wrong), I'd guess dev->dma_pfn_offset is
> probably 0 as well, which further points to the wrong device. Maybe
> something's changed lower down in the USB core? Turning on tracing and
> booting with "tp_printk trace_event=swiotlb_bounced" on the command line
> should shed a bit more light on what's going on.

I took a slightly different config which also works with 4.12 and break with 4.13-rc1:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.13.0-rc1-ARCH (stefan at Latitude-E4310) (gcc version 6.3.1 20170109 (Linaro GCC 6.3-2017.02)) #34 SMP Tue Jul 25 20:31:35 CEST 2017
[    0.000000] Boot CPU: AArch64 Processor [410fd034]
[    0.000000] Machine model: Raspberry Pi 3 Model B Rev 1.2
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Failed to reserve 512 MiB
[    0.000000] percpu: Embedded 3 pages/cpu @ffff80003ae90000 s125336 r8192 d63080 u196608
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 15089
[    0.000000] Kernel command line: earlyprintk console=ttyAMA0 bcm2708_fb.fbwidth=656 bcm2708_fb.fbheight=416 bcm2708_fb.fbswap=1 dma.dmachans=0x7f35 bcm2709.boardrev=0xa02082 bcm2709.serial=0x53a68e44 bcm2709.uart_clock=48000000 smsc95xx.macaddr=B8:27:EB:A6:8E:44 vc_mem.mem_base=0x3dc00000 vc_mem.mem_size=0x3f000000  dwc_otg.lpm_enable=0 console=ttyS0,115200 console=tty1 root=PARTUUID=29cb32be-02 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait tp_printk trace_event=swiotlb_bounced
[    0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 4, 1048576 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 3, 524288 bytes)
[    0.000000] Memory: 939712K/966656K available (11836K kernel code, 2400K rwdata, 5376K rodata, 1600K init, 1269K bss, 26944K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7bdfffff0000   (126847 GB)
[    0.000000]       .text : 0xffff000008080000 - 0xffff000008c10000   ( 11840 KB)
[    0.000000]     .rodata : 0xffff000008c10000 - 0xffff000009160000   (  5440 KB)
[    0.000000]       .init : 0xffff000009160000 - 0xffff0000092f0000   (  1600 KB)
[    0.000000]       .data : 0xffff0000092f0000 - 0xffff000009548200   (  2401 KB)
[    0.000000]        .bss : 0xffff000009548200 - 0xffff000009685988   (  1270 KB)
[    0.000000]     fixed   : 0xffff7fdffe7d0000 - 0xffff7fdffec00000   (  4288 KB)
[    0.000000]     PCI I/O : 0xffff7fdffee00000 - 0xffff7fdfffe00000   (    16 MB)
[    0.000000]     vmemmap : 0xffff7fe000000000 - 0xffff800000000000   (   128 GB maximum)
[    0.000000]               0xffff7fe000000000 - 0xffff7fe0000ec000   (     0 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff80003b000000   (   944 MB)
[    0.000000] random: get_random_u64 called from cache_random_seq_create+0x60/0x118 with crng_init=0
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] ftrace: allocating 43369 entries in 11 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000]  Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] arch_timer: WARNING: Invalid trigger for IRQ2, assuming level low
[    0.000000] arch_timer: WARNING: Please fix your firmware
[    0.000000] arch_timer: cp15 timer(s) running at 19.20MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
[    0.000006] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
[    0.000180] Console: colour dummy device 80x25
[    0.001202] console [tty1] enabled
[    0.001246] Calibrating delay loop (skipped), value calculated using timer frequency.. 38.40 BogoMIPS (lpj=192000)
[    0.001296] pid_max: default: 32768 minimum: 301
[    0.002076] Security Framework initialized
[    0.002106] Yama: becoming mindful.
[    0.002325] Mount-cache hash table entries: 8192 (order: 0, 65536 bytes)
[    0.002417] Mountpoint-cache hash table entries: 8192 (order: 0, 65536 bytes)
[    0.004540] ASID allocator initialised with 65536 entries
[    0.004664] Hierarchical SRCU implementation.
[    0.010622] EFI services will not be available.
[    0.010923] smp: Bringing up secondary CPUs ...
[    0.011453] Detected VIPT I-cache on CPU1
[    0.011509] arch_timer: WARNING: Invalid trigger for IRQ2, assuming level low
[    0.011512] arch_timer: WARNING: Please fix your firmware
[    0.011528] CPU1: Booted secondary processor [410fd034]
[    0.012110] Detected VIPT I-cache on CPU2
[    0.012141] arch_timer: WARNING: Invalid trigger for IRQ2, assuming level low
[    0.012144] arch_timer: WARNING: Please fix your firmware
[    0.012154] CPU2: Booted secondary processor [410fd034]
[    0.012684] Detected VIPT I-cache on CPU3
[    0.012715] arch_timer: WARNING: Invalid trigger for IRQ2, assuming level low
[    0.012717] arch_timer: WARNING: Please fix your firmware
[    0.012727] CPU3: Booted secondary processor [410fd034]
[    0.012834] smp: Brought up 1 node, 4 CPUs
[    0.013114] SMP: Total of 4 processors activated.
[    0.013142] CPU features: detected feature: 32-bit EL0 Support
[    0.013307] CPU: All CPU(s) started at EL2
[    0.015793] devtmpfs: initialized
[    0.022239] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.022309] futex hash table entries: 1024 (order: 1, 131072 bytes)
[    0.022999] pinctrl core: initialized pinctrl subsystem
[    0.023916] DMI not present or invalid.
[    0.024474] NET: Registered protocol family 16
[    0.028000] cpuidle: using governor ladder
[    0.028269] cpuidle: using governor menu
[    0.029692] vdso: 2 pages (1 code @ ffff000008c20000, 1 data @ ffff000009310000)
[    0.029739] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.030383] DMA: preallocated 256 KiB pool for atomic allocations
[    0.030911] Serial: AMBA PL011 UART driver
[    0.049727] HugeTLB registered 512 MiB page size, pre-allocated 0 pages
[    0.051674] ACPI: Interpreter disabled.
[    0.052370] vgaarb: loaded
[    0.053556] SCSI subsystem initialized
[    0.053990] usbcore: registered new interface driver usbfs
[    0.054069] usbcore: registered new interface driver hub
[    0.054178] usbcore: registered new device driver usb
[    0.054675] EDAC MC: Ver: 3.0.0
[    0.055011] dmi: Firmware registration failed.
[    0.055611] Advanced Linux Sound Architecture Driver Initialized.
[    0.056114] NetLabel: Initializing
[    0.056140] NetLabel:  domain hash size = 128
[    0.056164] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.056279] NetLabel:  unlabeled traffic allowed by default
[    0.057594] clocksource: Switched to clocksource arch_sys_counter
[    0.182792] VFS: Disk quotas dquot_6.6.0
[    0.182999] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
[    0.184087] simple-framebuffer 3db75000.framebuffer: framebuffer at 0x3db75000, 0x85400 bytes, mapped to 0xffff000009805000
[    0.184142] simple-framebuffer 3db75000.framebuffer: format=r5g6b5, mode=656x416x16, linelength=1312
[    0.187891] Console: switching to colour frame buffer device 82x26
[    0.191335] simple-framebuffer 3db75000.framebuffer: fb0: simplefb registered!
[    0.193151] pnp: PnP ACPI: disabled
[    0.203229] NET: Registered protocol family 2
[    0.205911] TCP established hash table entries: 8192 (order: 0, 65536 bytes)
[    0.207946] TCP bind hash table entries: 8192 (order: 1, 131072 bytes)
[    0.210134] TCP: Hash tables configured (established 8192 bind 8192)
[    0.212244] UDP hash table entries: 2048 (order: 0, 65536 bytes)
[    0.214363] UDP-Lite hash table entries: 2048 (order: 0, 65536 bytes)
[    0.216763] NET: Registered protocol family 1
[    0.219246] RPC: Registered named UNIX socket transport module.
[    0.221261] RPC: Registered udp transport module.
[    0.223251] RPC: Registered tcp transport module.
[    0.225191] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.228900] kvm [1]: 8-bit VMID
[    0.230805] kvm [1]: IDype id_legacy registered
[    0.283590] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.285369] SGI XFS with ACLs, security attributes, no debug enabled
[    0.303717] NET: Registered protocol family 38
[    0.305462] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    0.308778] io scheduler noop registered
[    0.310387] io scheduler deadline registered (default)
[    0.312143] io scheduler cfq registered
[    0.313777] io scheduler mq-deadline registered
[    0.315373] io scheduler kyber registered
[    0.317182] io scheduler bfq registered
[    0.319158] atomic64_test: passed
[    0.328445] ipmi message handler version 39.2
[    0.337902] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.341209] console [ttyS0] disabled
[    0.342867] 3f215040.serial: ttyS0 at MMIO 0x0 (irq = 61, base_baud = 31250000) is a 16550
[    1.197104] console [ttyS0] enabled
[    1.203172] msm_serial: driver initialized
[    1.209904] bcm2835-rng 3f104000.rng: hwrng registered
[    1.217568] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    1.228419] libphy: Fixed MDIO Bus: probed
[    1.235986] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.244308] ehci-pci: EHCI PCI platform driver
[    1.250478] ehci-platform: EHCI generic platform driver
[    1.257466] ehci-orion: EHCI orion driver
[    1.263190] ehci-msm: Qualcomm On-Chip EHCI Host Controller
[    1.270538] tegra-ehci: Tegra EHCI driver
[    1.276353] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.284312] ohci-pci: OHCI PCI platform driver
[    1.290560] ohci-platform: OHCI generic platform driver
[    1.297709] uhci_hcd: USB Universal Host Controller Interface driver
[    1.306437] usbcore: registered new interface driver uas
[    1.313751] usbcore: registered new interface driver usb-storage
[    1.321640] usbcore: registered new interface driver ums-alauda
[    1.329376] usbcore: registered new interface driver ums-cypress
[    1.337103] usbcore: registered new interface driver ums-datafab
[    1.344744] usbcore: registered new interface driver ums_eneub6250
[    1.352544] usbcore: registered new interface driver ums-freecom
[    1.360120] usbcore: registered new interface driver ums-isd200
[    1.367552] usbcore: registered new interface driver ums-jumpshot
[    1.375110] usbcore: registered new interface driver ums-karma
[    1.382334] usbcore: registered new interface driver ums-onetouch
[    1.389768] usbcore: registered new interface driver ums-realtek
[    1.397021] usbcore: registered new interface driver ums-sddr09
[    1.404156] usbcore: registered new interface driver ums-sddr55
[    1.411253] usbcore: registered new interface driver ums-usbat
[    1.418273] usbcore: registered new interface driver usbserial
[    1.425152] usbcore: registered new interface driver usbserial_generic
[    1.432693] usbserial: USB Serial support registered for generic
[    1.440885] mousedev: PS/2 mouse device common for all mice
[    1.450044] device-mapper: uevent: version 1.0.3
[    1.455933] device-mapper: ioctl: 4.36.0-ioctl (2017-06-09) initialised: dm-devel at redhat.com
[    1.466760] Machine is not compatible with mt8173-cpufreq
[    1.473600] sdhci: Secure Digital Host Controller Interface driver
[    1.480990] sdhci: Copyright(c) Pierre Ossman
[    1.487095] Synopsys Designware Multimedia Card Interface Driver
[    1.495432] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.567684] mmc0: SDHCI controller on 3f300000.sdhci [3f300000.sdhci] using PIO
[    1.577297] ledtrig-cpu: registered to indicate activity on CPUs
[    1.585085] dmi-sysfs: dmi entry is absent.
[    1.591052] hidraw: raw HID events driver (C) Jiri Kosina
[    1.598237] usbcore: registered new interface driver usbhid
[    1.605490] usbhid: USB HID core driver
[    1.611683] bcm2835-mbox 3f00b880.mailbox: mailbox enabled
[    1.617090] mmc0: new high speed SDHC card at address 0001
[    1.617693] mmcblk0: mmc0:0001 00000 29.8 GiB
[    1.622335]  mmcblk0: p1 p2
[    1.639605] drop_monitor: Initializing network drop monitor service
[    1.648144] ip_tables: (C) 2000-2006 Netfilter Core Team
[    1.655402] Initializing XFRM netlink socket
[    1.662316] NET: Registered protocol family 10
[    1.670909] Segment Routing with IPv6
[    1.676458] mip6: Mobile IPv6
[    1.681189] NET: Registered protocol family 17
[    1.687471] Key type dns_resolver registered
[    1.694865] registered taskstats version 1
[    1.700808] zswap: loaded using pool lzo/zbud
[    1.708435] Key type big_key registered
[    1.715236] Key type encrypted registered
[    1.724312] 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 (irq = 72, base_baud = 0) is a PL011 rev2
[    5.265460] console [ttyAMA0] enabled
[    5.284373] raspberrypi-firmware soc:firmware: Attached to firmware from 2017-05-15 16:57
[    5.347032] dwc2 3f980000.usb: 3f980000.usb supply vusb_d not found, using dummy regulator
[    5.383637] dwc2 3f980000.usb: 3f980000.usb supply vusb_a not found, using dummy regulator
[    5.471022] dwc2 3f980000.usb: DWC OTG Controller
[    5.491923] dwc2 3f980000.usb: new USB bus registered, assigned bus number 1
[    5.522064] dwc2 3f980000.usb: irq 41, io mem 0x3f980000
[    5.545422] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    5.574537] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.605424] usb usb1: Product: DWC OTG Controller
[    5.626188] usb usb1: Manufacturer: Linux 4.13.0-rc1-ARCH dwc2_hsotg
[    5.653623] usb usb1: SerialNumber: 3f980000.usb
[    5.674597] hub 1-0:1.0: USB hub found
[    5.691583] hub 1-0:1.0: 1 port detected
[    5.709740] hctosys: unable to open rtc device (rtc0)
[    5.732170] ALSA device list:
[    5.745944]   No soundcards found.
[    5.761534] md: Waiting for all devices to be available before autodetect
[    5.790696] md: If you don't use raid, use raid=noautodetect
[    5.815981] md: Autodetecting RAID arrays.
[    5.834224] md: autorun ...
[    5.847116] md: ... autorun DONE.
[    5.894169] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[    5.930036] VFS: Mounted root (ext4 filesystem) readonly on device 179:2.
[    5.968062] devtmpfs: mounted
[    5.989908] Freeing unused kernel memory: 1600K
[    6.137682] usb 1-1: new high-speed USB device number 2 using dwc2
[    6.137736] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d79d80 size=8 NO_FORCE
[    6.137754] dwc2 3f980000.usb: Cannot do DMA to address 0x0000000024d79d80
[    6.137771] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d72700 size=64 NO_FORCE
[    6.137779] dwc2 3f980000.usb: Cannot do DMA to address 0x0000000024d72700
[    6.138562] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d79d80 size=8 NO_FORCE
[    6.138570] dwc2 3f980000.usb: Cannot do DMA to address 0x0000000024d79d80
[    6.138581] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d72700 size=64 NO_FORCE
[    6.138589] dwc2 3f980000.usb: Cannot do DMA to address 0x0000000024d72700
[    6.138655] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d79d80 size=8 NO_FORCE
[    6.138663] dwc2 3f980000.usb: Cannot do DMA to address 0x0000000024d79d80
[    6.138674] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d72700 size=64 NO_FORCE
[    6.138681] dwc2 3f980000.usb: Cannot do DMA to address 0x0000000024d72700
[    6.357642] usb 1-1: device descriptor read/64, error -32
[    6.420281] systemd[1]: System time before build time, advancing clock.
[    6.497649] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d7d400 size=8 NO_FORCE
[    6.497671] dwc2 3f980000.usb: Cannot do DMA to address 0x0000000024d7d400
[    6.497686] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d76080 size=64 NO_FORCE
[    6.497693] dwc2 3f980000.usb: Cannot do DMA to address 0x0000000024d76080
[    6.497801] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d7d400 size=8 NO_FORCE
[    6.497809] dwc2 3f980000.usb: Cannot do DMA to address 0x0000000024d7d400
[    6.497820] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d76080 size=64 NO_FORCE
[    6.497827] dwc2 3f980000.usb: Cannot do DMA to address 0x0000000024d76080
[    6.497884] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d7d400 size=8 NO_FORCE
[    6.497895] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d76080 size=64 NO_FORCE
[    6.767606] usb 1-1: device descriptor read/64, error -32
[    7.103734] systemd[1]: systemd 233 running in system mode. (+PAM -AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD +IDN default-hierarchy=hybrid)
[    7.157624] usb 1-1: new high-speed USB device number 3 using dwc2
[    7.157664] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d76c80 size=8 NO_FORCE
[    7.157686] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d7f880 size=64 NO_FORCE
[    7.304546] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d76c80 size=8 NO_FORCE
[    7.305253] systemd[1]: Detected architecture arm64.
[    7.369500] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d7f880 size=64 NO_FORCE
[    7.369680] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d76c80 size=8 NO_FORCE
[    7.369692] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d7f880 size=64 NO_FORCE
[    7.505581] systemd[1]: Set hostname to <alarm>.
[    7.577794] usb 1-1: device descriptor read/64, error -32
[    7.629650] uart-pl011 3f201000.serial: no DMA platform data
[    7.717682] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d76c80 size=8 NO_FORCE
[    7.759839] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d7f880 size=64 NO_FORCE
[    7.802399] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d76c80 size=8 NO_FORCE
[    7.844561] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d7f880 size=64 NO_FORCE
[    7.887138] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d76c80 size=8 NO_FORCE
[    7.929426] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d7f880 size=64 NO_FORCE
[    7.994968] systemd[1]: Listening on Process Core Dump Socket.
[    8.023899] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    8.062090] systemd[1]: Listening on Journal Socket.
[    8.087225] systemd[1]: Listening on Journal Socket (/dev/log).
[    8.156061] systemd[1]: Listening on udev Control Socket.
[    8.177613] usb 1-1: device descriptor read/64, error -32
[    8.208056] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    8.253168] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    8.507731] usb 1-1: new high-speed USB device number 4 using dwc2
[    8.547742] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d77380 size=8 NO_FORCE
[    8.596619] systemd-journald[198]: Received request to flush runtime journal from PID 1
[    8.807702] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d7d080 size=8 NO_FORCE
[    9.067672] usb 1-1: device not accepting address 4, error -32
[    9.307662] usb 1-1: new high-speed USB device number 5 using dwc2
[    9.334282] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d7d700 size=8 NO_FORCE
[    9.587730] swiotlb_bounced: dev_name: 3f980000.usb dma_mask=7fffffff dev_addr=e4d7dd00 size=8 NO_FORCE
[    9.847705] usb 1-1: device not accepting address 5, error -32
[    9.881425] usb usb1-port1: unable to enumerate USB device
[   11.287698] random: crng init done

> 
> Robin.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
