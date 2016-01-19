From: nbd@openwrt.org (Felix Fietkau)
Date: Tue, 19 Jan 2016 10:53:26 +0100
Subject: CONFIG_CPU_SW_DOMAIN_PAN breakage on ARM11 MPCore
In-Reply-To: <20160119093845.GJ19062@n2100.arm.linux.org.uk>
References: <569D71F3.7000408@openwrt.org>
 <20160119093845.GJ19062@n2100.arm.linux.org.uk>
Message-ID: <569E0796.9000302@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-01-19 10:38, Russell King - ARM Linux wrote:
> On Tue, Jan 19, 2016 at 12:14:59AM +0100, Felix Fietkau wrote:
>> I just wasted a few hours debugging user space hangs after updating my
>> CNS3xxx device to Linux 4.4 - until I found this:
>> http://www.spinics.net/lists/arm-kernel/msg450888.html
> 
> Sorry about that.  What you've found is an investigatory patch, not
> a fix for it.
> 
>> I haven't seen any follow-up patches since that discussion in October,
>> and this patch resolves the issue in my test.
> 
> If you read the remainder of the thread, you'll notice that there was
> discussion about the problem and that isn't a proper fix.
> 
>> Could you guys please get this merged and pushed to stable to avoid
>> wasting other people's time as well?
> 
> No one understands what's going on with ARM11 MPcore (not even ARM Ltd
> people).  We certainly do not want to add the expense of writing to
> the DACR each and every time we want to do a TLB flush, and as Will
> said at the end of the thread, it should be predicated on ARM11 MPcore.
> We don't know which revisions of ARM11 MPcore are affected.
> 
> Please can you provide your boot messages so we can see what revision
> 11MPcore you have in your device.  Thanks.
> 
[    0.000000] Booting Linux on physical CPU 0x900
[    0.000000] Linux version 4.4.0 (nbd at nf.lan) (gcc version 5.2.0 (OpenWrt GCC 5.2.0 r48326) ) #8 SMP Tue Jan 19 00:06:54 CET 2016
[    0.000000] CPU: ARMv6-compatible processor [410fb024] revision 4 (ARMv7), cr=00c5787d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Gateworks Corporation Laguna Platform
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] PERCPU: Embedded 12 pages/cpu @c7edb000 s16512 r8192 d24448 u49152
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: console=ttyS0,115200 root=/dev/mtdblock3 rootfstype=squashfs,jffs2 noinitrd init=/etc/preinit
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 119144K/131072K available (3510K kernel code, 100K rwdata, 936K rodata, 5896K init, 202K bss, 11928K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff800000   ( 880 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc045fe6c   (4448 kB)
[    0.000000]       .init : 0xc0460000 - 0xc0a22000   (5896 kB)
[    0.000000]       .data : 0xc0a22000 - 0xc0a3b280   ( 101 kB)
[    0.000000]        .bss : 0xc0a3b280 - 0xc0a6daac   ( 203 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] clocksource: freerun: mask: 0xffffffffffff max_cycles: 0x179dd7f66, max_idle_ns: 28210892933900 ns
[    0.000000] smp_twd: clock not found -2
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836475000000ns
[    0.130000] console [ttyS0] enabled
[    0.140000] Calibrating local timer... 299.92MHz.
[    0.200000] Calibrating delay loop... 238.38 BogoMIPS (lpj=1191936)
[    0.270000] pid_max: default: 32768 minimum: 301
[    0.270000] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.280000] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.290000] CPU: Testing write buffer coherency: ok
[    0.290000] Setting up static identity map for 0x20008280 - 0x200082b8
[    0.370000] Brought up 2 CPUs
[    0.370000] SMP: Total of 2 processors activated (478.00 BogoMIPS).
[    0.380000] VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 4
[    0.390000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.400000] NET: Registered protocol family 16
[    0.400000] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.410000] L2C: DT/platform modifies aux control register: 0x02040000 -> 0x02540000
[    0.420000] L2C-310 errata 727915 769419 enabled
[    0.420000] L2C-310 cache controller enabled, 8 ways, 256 kB
[    0.430000] L2C-310: CACHE_ID 0x410000c4, AUX_CTRL 0x06540000
[    0.440000] laguna: using shared PCI interrupts: irq61
[    0.480000] SCSI subsystem initialized
[    0.480000] usbcore: registered new interface driver usbfs
[    0.490000] usbcore: registered new interface driver hub
[    0.490000] usbcore: registered new device driver usb
[    0.500000] pps_core: LinuxPPS API ver. 1 registered
[    0.500000] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.510000] clocksource: Switched to clocksource freerun
[    0.520000] NET: Registered protocol family 2
[    0.520000] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.520000] TCP bind hash table entries: 1024 (order: 1, 8192 bytes)
[    0.530000] TCP: Hash tables configured (established 1024 bind 1024)
[    0.540000] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.540000] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.550000] NET: Registered protocol family 1
[    0.660000] futex hash table entries: 512 (order: 2, 16384 bytes)
[    0.670000] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.680000] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME) (CMODE_PRIORITY) (c) 2001-2006 Red Hat, Inc.
[    0.690000] io scheduler noop registered
[    0.690000] io scheduler deadline registered (default)
[    0.700000] Serial: 8250/16550 driver, 3 ports, IRQ sharing disabled
[    0.700000] serial8250: ttyS0 at MMIO 0x78000000 (irq = 45, base_baud = 1500000) is a 16550A
[    0.710000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.720000] ehci-pci: EHCI PCI platform driver
[    0.720000] ehci-platform: EHCI generic platform driver
[    0.730000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.740000] ohci-platform: OHCI generic platform driver
[    0.740000] i2c /dev entries driver
[    0.750000] pca953x 0-0027: failed reading register
[    0.750000] pca953x: probe of 0-0027 failed with error -11
[    0.760000] at24 0-0050: 1024 byte 24c08 EEPROM, read-only, 0 bytes/write
[    0.780000] rtc-ds1672 0-0068: chip found, driver version 0.4
[    0.780000] rtc-ds1672 0-0068: rtc core: registered rtc-ds1672 as rtc0
[    0.790000] gsp 0-0029: gsp chip found
[    0.790000] sdhci: Secure Digital Host Controller Interface driver
[    0.800000] sdhci: Copyright(c) Pierre Ossman
[    0.810000] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.810000] NET: Registered protocol family 10
[    0.820000] NET: Registered protocol family 17
[    0.820000] bridge: automatic filtering via arp/ip/ip6tables has been deprecated. Update your scripts to load br_netfilter if you need this.
[    0.830000] 8021q: 802.1Q VLAN Support v1.8
[    0.840000] PCIe: Port[0] Enable PCIe LTSSM
[    0.840000] PCIe: Port[0] Check data link layer...
[    0.850000] Link up.
[    0.850000] PCI host bridge to bus 0000:00
[    0.850000] pci_bus 0000:00: root bus resource [io  0xac000000-0xacffffff]
[    0.860000] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xaaffffff]
[    0.870000] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.880000] pci 0000:00:00.0: unsupported PM cap regs version (7)
[    0.880000] PCI: bus0: Fast back to back transfers disabled
[    0.890000] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.900000] PCI: bus1: Fast back to back transfers disabled
[    0.900000] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.910000] PCI: bus2: Fast back to back transfers enabled
[    0.920000] pci 0000:01:00.0: PCI bridge to [bus 02]
[    0.920000] pci 0000:00:00.0: PCI bridge to [bus 01-02]
[    0.930000] PCIe: Port[1] Enable PCIe LTSSM
[    0.930000] PCIe: Port[1] Check data link layer...
[    0.940000] Link up.
[    0.940000] PCI host bridge to bus 0001:00
[    0.940000] pci_bus 0001:00: root bus resource [io  0xbc000000-0xbcffffff]
[    0.950000] pci_bus 0001:00: root bus resource [mem 0xb0000000-0xbaffffff]
[    0.960000] pci_bus 0001:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.960000] pci 0001:00:00.0: unsupported PM cap regs version (7)
[    0.970000] PCI: bus0: Fast back to back transfers disabled
[    0.980000] pci 0001:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.990000] PCI: bus1: Fast back to back transfers disabled
[    0.990000] PCIe map irq: 0001:01:00.00 slot 0, pin 1, irq: 62
[    1.000000] pci 0001:00:00.0: BAR 8: assigned [mem 0xb0000000-0xb01fffff]
[    1.000000] pci 0001:00:00.0: BAR 9: assigned [mem 0xb0200000-0xb02fffff pref]
[    1.010000] pci 0001:01:00.0: BAR 0: assigned [mem 0xb0000000-0xb01fffff 64bit]
[    1.020000] pci 0001:01:00.0: BAR 6: assigned [mem 0xb0200000-0xb020ffff pref]
[    1.030000] pci 0001:00:00.0: PCI bridge to [bus 01]
[    1.030000] pci 0001:00:00.0:   bridge window [mem 0xb0000000-0xb01fffff]
[    1.040000] pci 0001:00:00.0:   bridge window [mem 0xb0200000-0xb02fffff pref]
[    1.040000] pci 0000:01:00.0: PCI bridge to [bus 02]
[    1.050000] pci 0000:00:00.0: PCI bridge to [bus 01-02]
[    1.060000] pci 0001:00:00.0: PCI bridge to [bus 01]
[    1.060000] pci 0001:00:00.0:   bridge window [mem 0xb0000000-0xb01fffff]
[    1.070000] pci 0001:00:00.0:   bridge window [mem 0xb0200000-0xb02fffff pref]
[    1.070000] Running on Gateworks Laguna GW2388-SP208-A
[    1.100000] libphy: CNS3xxx MII Bus: probed
[    1.190000] eth0: RGMII PHY 0 on cns3xxx Switch
[    1.280000] eth1: RGMII PHY 1 on cns3xxx Switch
[    1.280000] dwc2 dwc2.0: Configuration mismatch. Forcing host mode
[    2.150000] dwc2 dwc2.0: DWC OTG Controller
[    2.150000] dwc2 dwc2.0: new USB bus registered, assigned bus number 1
[    2.160000] dwc2 dwc2.0: irq 63, io mem 0x00000000
[    2.160000] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.170000] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.180000] usb usb1: Product: DWC OTG Controller
[    2.180000] usb usb1: Manufacturer: Linux 4.4.0 dwc2_hsotg
[    2.190000] usb usb1: SerialNumber: dwc2.0
[    2.190000] hub 1-0:1.0: USB hub found
[    2.190000] hub 1-0:1.0: 1 port detected
[    2.200000] ehci-platform ehci-platform.0: EHCI Host Controller
[    2.210000] ehci-platform ehci-platform.0: new USB bus registered, assigned bus number 2
[    2.210000] ehci-platform ehci-platform.0: irq 64, io mem 0x82000000
[    2.240000] ehci-platform ehci-platform.0: USB 2.0 started, EHCI 1.00
[    2.240000] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    2.250000] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.260000] usb usb2: Product: EHCI Host Controller
[    2.260000] usb usb2: Manufacturer: Linux 4.4.0 ehci_hcd
[    2.270000] usb usb2: SerialNumber: ehci-platform.0
[    2.270000] hub 2-0:1.0: USB hub found
[    2.280000] hub 2-0:1.0: 1 port detected
[    2.280000] ohci-platform ohci-platform.0: Generic Platform OHCI controller
[    2.290000] ohci-platform ohci-platform.0: new USB bus registered, assigned bus number 3
[    2.300000] ohci-platform ohci-platform.0: irq 91, io mem 0x88000000
[    2.360000] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    2.370000] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.370000] usb usb3: Product: Generic Platform OHCI controller
[    2.380000] usb usb3: Manufacturer: Linux 4.4.0 ohci_hcd
[    2.380000] usb usb3: SerialNumber: ohci-platform.0
[    2.390000] hub 3-0:1.0: USB hub found
[    2.390000] hub 3-0:1.0: 1 port detected
[    2.400000] sdhci-cns3xxx sdhci-cns3xxx.0: No vmmc regulator found
[    2.410000] sdhci-cns3xxx sdhci-cns3xxx.0: No vqmmc regulator found
[    2.450000] mmc0: SDHCI controller on sdhci-cns3xxx.0 [sdhci-cns3xxx.0] using PIO
[    2.450000] console [ttyS0] disabled
[    2.460000] serial8250.0: ttyS0 at MMIO 0x78000000 (irq = 45, base_baud = 1500000) is a 16550A
[    3.450000] console [ttyS0] enabled
[    3.450000] serial8250.0: ttyS1 at MMIO 0x78400000 (irq = 46, base_baud = 1500000) is a 16550A
[    3.460000] serial8250.0: ttyS2 at MMIO 0x78800000 (irq = 47, base_baud = 1500000) is a 16550A
[    3.470000] physmap platform flash device: 01000000 at 10000000
[    3.480000] physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID 0x000001 Chip ID 0x002101
[    3.490000] Amd/Fujitsu Extended Query Table at 0x0040
[    3.490000]   Amd/Fujitsu Extended Query version 1.3.
[    3.500000] number of CFI chips: 1
[    3.500000] Creating 4 MTD partitions on "physmap-flash.0":
[    3.510000] 0x000000000000-0x000000040000 : "uboot"
[    3.510000] 0x000000040000-0x000000060000 : "params"
[    3.520000] 0x000000060000-0x000000260000 : "kernel"
[    3.520000] 0x000000260000-0x000001000000 : "rootfs"
[    3.530000] mtd: device 3 (rootfs) set to be root filesystem
[    3.540000] 1 squashfs-split partitions found on MTD device rootfs
[    3.540000] 0x000000440000-0x000001000000 : "rootfs_data"
[    3.550000] cns3xxx_spi_probe: setup CNS3XXX SPI Controller
[    3.570000] rtc-ds1672 0-0068: setting system clock to 1970-01-01 01:59:22 UTC (7162)
[    3.590000] Freeing unused kernel memory: 5896K (c0460000 - c0a22000)

[...]

root at OpenWrt:~# cat /proc/cpuinfo 
processor       : 0
model name      : ARMv6-compatible processor rev 4 (v6l)
BogoMIPS        : 238.38
Features        : half thumb fastmult vfp edsp java tls 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0xb02
CPU revision    : 4

processor       : 1
model name      : ARMv6-compatible processor rev 4 (v6l)
BogoMIPS        : 239.61
Features        : half thumb fastmult vfp edsp java tls 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0xb02
CPU revision    : 4

Hardware        : Gateworks Corporation Laguna Platform
Revision        : ea000012
Serial          : 0000000000000000
