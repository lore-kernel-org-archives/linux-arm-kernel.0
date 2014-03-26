From: matthew_minter@xyratex.com (Matthew Minter)
Date: Wed, 26 Mar 2014 16:54:13 +0000
Subject: Armada XP (mvebu) PCIe memory (BAR/window) re-allocation
Message-ID: <CAFJTrDtBiO=nDNb3i38SavCw8oZHf_k2uiz-DS6DXzc-Ev6+xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using a custom board based around the Armada XP 230 (that's the dual
core one) we are trying to talk to some PCIe devices via a PLX PCIe
switch. However I have been able to reproduce these same results using
an Armada XP GP dev board as to show it is not a board defect causing
the issue.

We are trying to use a PCIe based ahci SSD to store some data on this
board (actually an m.2 card, but electronically identical to PCIe).
This is working well, we can see the switch, its upstream and
downstream ports and the SSD itself in the /sys/bus/pci file-system,
we can even mount the SSD and store and read data on it. This all
seems fine. We are using kernel version 3.14.0-rc7, I considered
trying a more upstream version but could not see any applicable
patches in next, or in the mvebu repo)

However the issues arrive when we try and use the hotplug features of
the board we are using (the same applies with the GP dev board and a
PLX dev board connected to it). If the SSD is connected at boot time,
we can safely hot-swap it but following the procedure: unbind the ahci
driver, remove it from the PCIe map using
/sys/bus/pci/device/xxxxx/remove, switch off the slot's power supply,
isolate the slot electronically, perform the swap, un-isolate the
slot, re-power the slot, rescan the pci bus. This also works great and
we can talk to the new SSD.

If the SSD is not plugged at boot however, this does not work properly
(This is definitely a kernel, not boot-loader issue as we can
disconnect the SSD while the bootloader is running and still have it
work as long as it gets plugged in before the kernel's PCIe
initialization). We perform the same sequence, this appears at first
to be ok, however after rescanning the pci bus, dmesg shows the
following errors (0000:01:00.0 is the switch upstream port,
0000:02:02.0 is the switch downstream port and 0000:04:00.0 is the
SSD):

[   83.135273] pcieport 0000:01:00.0: BAR 14: can't assign mem (size 0x100000)
[   83.135282] pcieport 0000:01:00.0: BAR 15: can't assign mem pref
(size 0x100000)
[   83.135292] pcieport 0000:02:02.0: BAR 14: can't assign mem (size 0x100000)
[   83.135300] pcieport 0000:02:02.0: BAR 15: can't assign mem pref
(size 0x100000)
[   83.135309] pci 0000:04:00.0: BAR 6: can't assign mem pref (size 0x10000)
[   83.135317] pci 0000:04:00.0: BAR 5: can't assign mem (size 0x2000)

Then when we try and attach the ahci driver, we get (predictably):

[   83.235749] ahci 0000:04:00.0: version 3.0
[   83.235802] ahci: probe of 0000:04:00.0 failed with error -22

It appears to me from a glance (though I have not examined the code
paths in detail) that performing a PCI rescan is not completely
reinitializing the bus, specifically it is not performing any
re-allocation of the PCI bar memory spaces which means the rescanned
devices will not be able to connect properly. Do we need to call
mvebu_pcie_setup_wins again or some other function in the kernel after
the rescan? I am a little surprised that the kernel is not
reconfiguring the BARs/windows after a rescan to fit the changed
config. Is there any way I can make this work? Any advice here would
be greatly appreciated, I would also be happy to try and write some
patches if it is really just the need to call the window and bar
initialization functions again after a rescan but would greatly
appreciate any opinions first.

Info dump ahead:

Boot log with SSD connected:

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 3.14.0-rc7 (root at orangebox) (gcc version 4.7.3 (Gentoo
4.7.3-r1 p1.3, pie-0.5.5) ) #9 SMP PREEMPT Mon Mar 24 17:47:43 GMT
2014
CPU: ARMv7 Processor [562f5842] revision 2 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine model: Xyratex Porter-v1
bootconsole [earlycon0] enabled
Truncating RAM at 00000000-3fffffff to -2f7fffff (vmalloc region overlap).
Memory policy: Data cache writealloc
PERCPU: Embedded 7 pages/cpu @ef1ee000 s5952 r8192 d14528 u32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 193040
Kernel command line: console=ttyS0,115200 earlyprintk=ttys0 rw
pm_disable mtdparts=armada-nand:8m(boot),8m(kernel),-(rootfs)
ubi.mtd=2 root=ubi0:rootfs rootfstype=ubifs
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 766932K/778240K available (2979K kernel code, 197K rwdata,
912K rodata, 137K init, 56K bss, 11308K reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc03d4fbc   (3892 kB)
      .init : 0xc03d5000 - 0xc03f7740   ( 138 kB)
      .data : 0xc03f8000 - 0xc04296d0   ( 198 kB)
       .bss : 0xc04296dc - 0xc04378b8   (  57 kB)
Preemptible hierarchical RCU implementation.
        Dump stacks of tasks blocking RCU-preempt GP.
        RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS:16 nr_irqs:16 16
sched_clock: 32 bits at 25MHz, resolution 40ns, wraps every 171798691800ns
Initializing Coherency fabric
Aurora cache controller enabled
l2x0: 16 ways, CACHE_ID 0x00000100, AUX_CTRL 0x1a696b12, Cache size: 1024 kB
Console: colour dummy device 80x30
Calibrating delay loop... 1196.85 BogoMIPS (lpj=5984256)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x2ef2f0 - 0x2ef324
Initializing Power Management Service Unit
Booting CPU 1
CPU1: Booted secondary processor
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
Brought up 2 CPUs
SMP: Total of 2 processors activated.
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 56 architecture 2 part 20 variant 9 rev 6
mvebu-soc-id: MVEBU SoC ID=0x7826, Rev=0x2
pinctrl core: initialized pinctrl subsystem
DMA: preallocated 256 KiB pool for atomic coherent allocations
irq: Cannot allocate irq_descs @ IRQ32, assuming pre-allocated
irq: Cannot allocate irq_descs @ IRQ67, assuming pre-allocated
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switched to clocksource armada_370_xp_clocksource
futex hash table entries: 512 (order: 3, 32768 bytes)
msgmni has been set to 1497
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
armada-xp-pinctrl f1018000.pinctrl: registered pinctrl driver
mvebu-pcie pcie-controller.2: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe8000000]
pci_bus 0000:00: root bus resource [bus 00-ff]
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus1: Fast back to back transfers disabled
pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus2: Fast back to back transfers disabled
pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:02:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:02:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus3: Fast back to back transfers enabled
PCI: bus4: Fast back to back transfers disabled
PCI: bus5: Fast back to back transfers enabled
pci 0000:00:01.0: BAR 14: assigned [mem 0xe0000000-0xe02fffff]
pci 0000:01:00.0: BAR 14: assigned [mem 0xe0000000-0xe00fffff]
pci 0000:01:00.0: BAR 15: assigned [mem 0xe0100000-0xe01fffff pref]
pci 0000:01:00.0: BAR 0: assigned [mem 0xe0200000-0xe021ffff]
pci 0000:02:02.0: BAR 14: assigned [mem 0xe0000000-0xe00fffff]
pci 0000:02:02.0: BAR 15: assigned [mem 0xe0100000-0xe01fffff pref]
pci 0000:02:01.0: PCI bridge to [bus 03]
pci 0000:04:00.0: BAR 6: assigned [mem 0xe0100000-0xe010ffff pref]
pci 0000:04:00.0: BAR 5: assigned [mem 0xe0000000-0xe0001fff]
pci 0000:02:02.0: PCI bridge to [bus 04]
pci 0000:02:02.0:   bridge window [mem 0xe0000000-0xe00fffff]
pci 0000:02:02.0:   bridge window [mem 0xe0100000-0xe01fffff pref]
pci 0000:02:03.0: PCI bridge to [bus 05]
pci 0000:01:00.0: PCI bridge to [bus 02-05]
pci 0000:01:00.0:   bridge window [mem 0xe0000000-0xe00fffff]
pci 0000:01:00.0:   bridge window [mem 0xe0100000-0xe01fffff pref]
pci 0000:00:01.0: PCI bridge to [bus 01-05]
pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe02fffff]
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
PCI: enabling device 0000:01:00.0 (0140 -> 0143)
PCI: enabling device 0000:02:01.0 (0140 -> 0143)
PCI: enabling device 0000:02:02.0 (0140 -> 0143)
PCI: enabling device 0000:02:03.0 (0140 -> 0143)
mv_xor f1060900.xor: Marvell shared XOR driver
mv_xor f1060900.xor: Marvell XOR: ( xor cpy )
mv_xor f1060900.xor: Marvell XOR: ( xor cpy )
mv_xor f10f0900.xor: Marvell shared XOR driver
mv_xor f10f0900.xor: Marvell XOR: ( xor cpy )
mv_xor f10f0900.xor: Marvell XOR: ( xor cpy )
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 19, base_baud =
15625000) is a 16550A
console [ttyS0] enabled
console [ttyS0] enabled
bootconsole [earlycon0] disabled
bootconsole [earlycon0] disabled
f1012100.serial: ttyS1 at MMIO 0xf1012100 (irq = 20, base_baud =
15625000) is a 16550A
mtip32xx Version 1.3.0
pxa3xx-nand f10d0000.nand: This platform can't do DMA on this device
nand: device found, Manufacturer ID: 0x2c, Chip ID: 0x38
nand: Micron MT29F8G08ABABAWP
nand: 1024MiB, SLC, page size: 4096, OOB size: 224
Bad block table found at page 262016, version 0x01
Bad block table found at page 261888, version 0x01
3 ofpart partitions found on MTD device pxa3xx_nand-0
Creating 3 MTD partitions on "pxa3xx_nand-0":
0x000000000000-0x000000800000 : "boot"
0x000000800000-0x000001000000 : "kernel"
0x000001000000-0x000040000000 : "rootfs"
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-orion: EHCI orion driver
orion-ehci f1050000.usb: EHCI Host Controller
orion-ehci f1050000.usb: new USB bus registered, assigned bus number 1
orion-ehci f1050000.usb: irq 26, io mem 0xf1050000
orion-ehci f1050000.usb: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usbcore: registered new interface driver usb-storage
rtc-mv f1010300.rtc: rtc core: registered f1010300.rtc as rtc0
UBI: attaching mtd2 to ubi0
random: nonblocking pool is initialized
UBI: scanning is finished
UBI: attached mtd2 (name "rootfs", size 1008 MiB) to ubi0
UBI: PEB size: 524288 bytes (512 KiB), LEB size: 516096 bytes
UBI: min./max. I/O unit sizes: 4096/4096, sub-page size 4096
UBI: VID header offset: 4096 (aligned 4096), data offset: 8192
UBI: good PEBs: 2008, bad PEBs: 8, corrupted PEBs: 0
UBI: user volume: 1, internal volumes: 1, max. volumes count: 128
UBI: max/mean erase counter: 2/1, WL threshold: 4096, image sequence
number: 3531581739
UBI: available PEBs: 0, total reserved PEBs: 2008, PEBs reserved for
bad PEB handling: 32
UBI: background thread "ubi_bgt0d" started, PID 885
rtc-mv f1010300.rtc: setting system clock to 2000-07-04 13:58:42 UTC (962719122)
UBIFS: background thread "ubifs_bgt0_0" started, PID 887
UBIFS: recovery needed
UBIFS: recovery completed
UBIFS: mounted UBI device 0, volume 0, name "rootfs"
UBIFS: LEB size: 516096 bytes (504 KiB), min./max. I/O unit sizes:
4096 bytes/4096 bytes
UBIFS: FS size: 1012064256 bytes (965 MiB, 1961 LEBs), journal size
33546240 bytes (31 MiB, 65 LEBs)
UBIFS: reserved for root: 4952683 bytes (4836 KiB)
UBIFS: media format: w4/r0 (latest is w4/r0), UUID
8BD77AAC-E543-41A2-842F-7011ADC039E0, small LPT model
VFS: Mounted root (ubifs filesystem) on device 0:10.
devtmpfs: mounted
Freeing unused kernel memory: 136K (c03d5000 - c03f7000)


Boot log with SSD disconnected:

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 3.14.0-rc7 (root at orangebox) (gcc version 4.7.3 (Gentoo
4.7.3-r1 p1.3, pie-0.5.5) ) #9 SMP PREEMPT Mon Mar 24 17:47:43 GMT
2014
CPU: ARMv7 Processor [562f5842] revision 2 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine model: Xyratex Porter-v1
bootconsole [earlycon0] enabled
Truncating RAM at 00000000-3fffffff to -2f7fffff (vmalloc region overlap).
Memory policy: Data cache writealloc
PERCPU: Embedded 7 pages/cpu @ef1ee000 s5952 r8192 d14528 u32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 193040
Kernel command line: console=ttyS0,115200 earlyprintk=ttys0 rw
pm_disable mtdparts=armada-nand:8m(boot),8m(kernel),-(rootfs)
ubi.mtd=2 root=ubi0:rootfs rootfstype=ubifs
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 766932K/778240K available (2979K kernel code, 197K rwdata,
912K rodata, 137K init, 56K bss, 11308K reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc03d4fbc   (3892 kB)
      .init : 0xc03d5000 - 0xc03f7740   ( 138 kB)
      .data : 0xc03f8000 - 0xc04296d0   ( 198 kB)
       .bss : 0xc04296dc - 0xc04378b8   (  57 kB)
Preemptible hierarchical RCU implementation.
        Dump stacks of tasks blocking RCU-preempt GP.
        RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS:16 nr_irqs:16 16
sched_clock: 32 bits at 25MHz, resolution 40ns, wraps every 171798691800ns
Initializing Coherency fabric
Aurora cache controller enabled
l2x0: 16 ways, CACHE_ID 0x00000100, AUX_CTRL 0x1a696b12, Cache size: 1024 kB
Console: colour dummy device 80x30
Calibrating delay loop... 1196.85 BogoMIPS (lpj=5984256)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x2ef2f0 - 0x2ef324
Initializing Power Management Service Unit
Booting CPU 1
CPU1: Booted secondary processor
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
Brought up 2 CPUs
SMP: Total of 2 processors activated.
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 56 architecture 2 part 20 variant 9 rev 6
mvebu-soc-id: MVEBU SoC ID=0x7826, Rev=0x2
pinctrl core: initialized pinctrl subsystem
DMA: preallocated 256 KiB pool for atomic coherent allocations
irq: Cannot allocate irq_descs @ IRQ32, assuming pre-allocated
irq: Cannot allocate irq_descs @ IRQ67, assuming pre-allocated
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switched to clocksource armada_370_xp_clocksource
futex hash table entries: 512 (order: 3, 32768 bytes)
msgmni has been set to 1497
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
armada-xp-pinctrl f1018000.pinctrl: registered pinctrl driver
mvebu-pcie pcie-controller.2: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe8000000]
pci_bus 0000:00: root bus resource [bus 00-ff]
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus1: Fast back to back transfers disabled
pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus2: Fast back to back transfers disabled
pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:02:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:02:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus3: Fast back to back transfers enabled
PCI: bus4: Fast back to back transfers enabled
PCI: bus5: Fast back to back transfers enabled
pci 0000:00:01.0: BAR 14: assigned [mem 0xe0000000-0xe00fffff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xe0000000-0xe001ffff]
pci 0000:02:01.0: PCI bridge to [bus 03]
pci 0000:02:02.0: PCI bridge to [bus 04]
pci 0000:02:03.0: PCI bridge to [bus 05]
pci 0000:01:00.0: PCI bridge to [bus 02-05]
pci 0000:00:01.0: PCI bridge to [bus 01-05]
pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe00fffff]
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
PCI: enabling device 0000:01:00.0 (0140 -> 0143)
PCI: enabling device 0000:02:01.0 (0140 -> 0143)
PCI: enabling device 0000:02:02.0 (0140 -> 0143)
PCI: enabling device 0000:02:03.0 (0140 -> 0143)
mv_xor f1060900.xor: Marvell shared XOR driver
mv_xor f1060900.xor: Marvell XOR: ( xor cpy )
mv_xor f1060900.xor: Marvell XOR: ( xor cpy )
mv_xor f10f0900.xor: Marvell shared XOR driver
mv_xor f10f0900.xor: Marvell XOR: ( xor cpy )
mv_xor f10f0900.xor: Marvell XOR: ( xor cpy )
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 19, base_baud =
15625000) is a 16550A
console [ttyS0] enabled
console [ttyS0] enabled
bootconsole [earlycon0] disabled
bootconsole [earlycon0] disabled
f1012100.serial: ttyS1 at MMIO 0xf1012100 (irq = 20, base_baud =
15625000) is a 16550A
mtip32xx Version 1.3.0
pxa3xx-nand f10d0000.nand: This platform can't do DMA on this device
nand: device found, Manufacturer ID: 0x2c, Chip ID: 0x38
nand: Micron MT29F8G08ABABAWP
nand: 1024MiB, SLC, page size: 4096, OOB size: 224
Bad block table found at page 262016, version 0x01
Bad block table found at page 261888, version 0x01
3 ofpart partitions found on MTD device pxa3xx_nand-0
Creating 3 MTD partitions on "pxa3xx_nand-0":
0x000000000000-0x000000800000 : "boot"
0x000000800000-0x000001000000 : "kernel"
0x000001000000-0x000040000000 : "rootfs"
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-orion: EHCI orion driver
orion-ehci f1050000.usb: EHCI Host Controller
orion-ehci f1050000.usb: new USB bus registered, assigned bus number 1
orion-ehci f1050000.usb: irq 26, io mem 0xf1050000
orion-ehci f1050000.usb: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usbcore: registered new interface driver usb-storage
rtc-mv f1010300.rtc: rtc core: registered f1010300.rtc as rtc0
UBI: attaching mtd2 to ubi0
random: nonblocking pool is initialized
UBI: scanning is finished
UBI: attached mtd2 (name "rootfs", size 1008 MiB) to ubi0
UBI: PEB size: 524288 bytes (512 KiB), LEB size: 516096 bytes
UBI: min./max. I/O unit sizes: 4096/4096, sub-page size 4096
UBI: VID header offset: 4096 (aligned 4096), data offset: 8192
UBI: good PEBs: 2008, bad PEBs: 8, corrupted PEBs: 0
UBI: user volume: 1, internal volumes: 1, max. volumes count: 128
UBI: max/mean erase counter: 2/1, WL threshold: 4096, image sequence
number: 3531581739
UBI: available PEBs: 0, total reserved PEBs: 2008, PEBs reserved for
bad PEB handling: 32
UBI: background thread "ubi_bgt0d" started, PID 884
rtc-mv f1010300.rtc: setting system clock to 2000-07-04 13:58:35 UTC (962719115)
UBIFS: background thread "ubifs_bgt0_0" started, PID 886
UBIFS: recovery needed
UBIFS: recovery completed
UBIFS: mounted UBI device 0, volume 0, name "rootfs"
UBIFS: LEB size: 516096 bytes (504 KiB), min./max. I/O unit sizes:
4096 bytes/4096 bytes
UBIFS: FS size: 1012064256 bytes (965 MiB, 1961 LEBs), journal size
33546240 bytes (31 MiB, 65 LEBs)
UBIFS: reserved for root: 4952683 bytes (4836 KiB)
UBIFS: media format: w4/r0 (latest is w4/r0), UUID
8BD77AAC-E543-41A2-842F-7011ADC039E0, small LPT model
VFS: Mounted root (ubifs filesystem) on device 0:10.
devtmpfs: mounted
Freeing unused kernel memory: 136K (c03d5000 - c03f7000)

Full dmesg output after failed rescan and ahci bind:

[   46.224192] pci_bus 0000:02: scanning bus
[   46.224259] pcieport 0000:02:01.0: scanning [bus 03-03] behind bridge, pass 0
[   46.224275] pcieport 0000:02:02.0: scanning [bus 04-04] behind bridge, pass 0
[   46.224290] pcieport 0000:02:03.0: scanning [bus 05-05] behind bridge, pass 0
[   46.224305] pcieport 0000:02:01.0: scanning [bus 00-00] behind bridge, pass 1
[   46.224318] pci_bus 0000:03: scanning bus
[   46.224328] pci_bus 0000:03: bus scan returning with max=03
[   46.224340] pci_bus 0000:03: busn_res: [bus 03] end is updated to 03
[   46.224353] pcieport 0000:02:02.0: scanning [bus 00-00] behind bridge, pass 1
[   46.224367] pci_bus 0000:04: scanning bus
[   46.224410] pci 0000:04:00.0: [144d:a800] type 00 class 0x010601
[   46.224495] pci 0000:04:00.0: reg 0x24: [mem 0x00000000-0x00001fff]
[   46.224515] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[   46.224536] pci 0000:04:00.0: calling pci_fixup_ide_bases+0x0/0x58
[   46.224660] pci 0000:04:00.0: PME# supported from D3hot D3cold
[   46.224672] pci 0000:04:00.0: PME# disabled
[   46.225090] pci_bus 0000:04: bus scan returning with max=04
[   46.225101] pci_bus 0000:04: busn_res: [bus 04] end is updated to 04
[   46.225116] pcieport 0000:02:03.0: scanning [bus 00-00] behind bridge, pass 1
[   46.225130] pci_bus 0000:05: scanning bus
[   46.225140] pci_bus 0000:05: bus scan returning with max=05
[   46.225148] pci_bus 0000:05: busn_res: [bus 05] end is updated to 05
[   46.225159] pci_bus 0000:02: bus scan returning with max=05
[   46.225167] pci_bus 0000:02: busn_res: [bus 02-05] end is updated to 05
[   46.225178] pci_bus 0000:01: bus scan returning with max=05
[   46.225186] pci_bus 0000:01: busn_res: [bus 01-05] end is updated to 05
[   46.225195] pci_bus 0000:00: bus scan returning with max=05
[   46.225267] pcieport 0000:01:00.0: BAR 14: can't assign mem (size 0x100000)
[   46.225277] pcieport 0000:01:00.0: BAR 15: can't assign mem pref
(size 0x100000)
[   46.225287] pcieport 0000:02:02.0: BAR 14: can't assign mem (size 0x100000)
[   46.225295] pcieport 0000:02:02.0: BAR 15: can't assign mem pref
(size 0x100000)
[   46.225304] pci 0000:04:00.0: BAR 6: can't assign mem pref (size 0x10000)
[   46.225312] pci 0000:04:00.0: BAR 5: can't assign mem (size 0x2000)
[   46.325621] ahci 0000:04:00.0: no of_node; not parsing pinctrl DT
[   46.325656] ahci 0000:04:00.0: version 3.0
[   46.325707] ahci: probe of 0000:04:00.0 failed with error -22

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------
