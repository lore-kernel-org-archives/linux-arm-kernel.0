From: matthew_minter@xyratex.com (Matthew Minter)
Date: Mon, 31 Mar 2014 15:17:24 +0100
Subject: Armada XP (mvebu) PCIe memory (BAR/window) re-allocation
In-Reply-To: <20140326171828.GA31887@obsidianresearch.com>
References: <CAFJTrDt7OrtE4B52419F2KGbmXeLR9NEcgF6yMTMUBe5vdKwfg@mail.gmail.com>
 <20140326180634.4ac266b2@skate>
 <20140326171828.GA31887@obsidianresearch.com>
Message-ID: <CAFJTrDvb7gcLkv8-HqbJSLEj7V2Zg=5+pXFR2r3AZxG7waT6WA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

Just to give an update of what I have tried. I noticed that there was
a PCI quirk available for a similar PLX chip which forced the kernel
to see the slots as hot-plug slots (unfortunately some PLX chips
falsely report themselves to be non hotplug capable bridges from my
understanding). I tried extending this quirk to run on my chip also.
This significantly changed the results in that along with the use of
pci=hpmemsize=xM I managed to force the chip to pre-allocate some
memory for the hotplug slot. Specifically I added this line:
DECLARE_PCI_FIXUP_HEADER(0x10b5, 0x8617, quirk_hotplug_bridge);
to linux-3.14-rc7/drivers/pci/quirks.c

However the issue is that when trying to then rescan the PCI bus I
have a crash (I am not entirely sure if it is an oops or something
else) but it displays:
Internal error: : 1008 [#1] PREEMPT SMP ARM
then dumps a stack trace and my shell dies. From then on attempting to
perform any PCI operation will make the system hang and need a reboot.
I am not sure why this error occurs but think it may relate somehow to
the chips memory window allocations, however it could be something
completely different.

I am currently working on a way to modify the scan order as Jason as
suggested, as soon as I have worked out exactly how the scan order is
determined I will try modifying the DT or any code needed to force the
port with the PLX chip to be scanned last. However I first need to
read some more of the code to understand what it orders on, eg: order
in DT, bus number, memory address.

Thanks again guys,
Matt

In case anyone is interested, here is the dump I get when i have a
crash with pre-allocated memory:

Internal error: : 1008 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 1746 Comm: bash Not tainted 3.14.0-rc7 #18
task: eed72840 ti: ee794000 task.ti: ee794000
PC is at ahci_enable_ahci+0x10/0x7c
LR is at ahci_save_initial_config+0x28/0x24c
pc : [<c02510d8>]    lr : [<c02512cc>]    psr: 60070013
sp : ee795cb0  ip : ee795cd0  fp : ee795ccc
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : ee73b068  r6 : f0460000  r5 : ee6c9290  r4 : f0460004
r3 : 00000000  r2 : 00000000  r1 : ee6c9290  r0 : f0460000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 2e7e406a  DAC: 00000015
Process bash (pid: 1746, stack limit = 0xee794240)
Stack: (0xee795cb0 to 0xee796000)
5ca0:                                     ee73b000 ee6c9290 f0460000 ee73b068
5cc0: ee795cfc ee795cd0 c02512cc c02510d4 00000000 ee73b000 ee73b068 ee6c9290
5ce0: 00000000 00000000 ee776c88 00000005 ee795d64 ee795d00 c024e7c4 c02512b0
5d00: ee795d34 ee795d10 c00fa3ec ee4355a0 c043f20d ee795d1c 00000000 00060082
5d20: 00000000 0000001f 00000000 0000007f c04d3a04 00000000 ee795d64 ee73b068
5d40: ee73b000 c04d36f4 00000000 c04d36c0 ee776c88 ee776c80 ee795d8c ee795d68
5d60: c01dc224 c024e44c c01dc1c4 ee73b068 c04d36f4 00000000 c0218c0c 00000002
5d80: ee795db4 ee795d90 c0218968 c01dc1d0 ee73b068 c0218c0c ee795db4 c04d36f4
5da0: ee73b068 ee73b068 ee795dcc ee795db8 c0218c3c c0218844 00000000 ee795dd0
5dc0: ee795df4 ee795dd0 c0216d24 c0218c18 eec6c7b0 ee487538 ee73b068 ee73b09c
5de0: eee5e600 ee795f78 ee795e14 ee795df8 c02187c4 c0216cdc 00000001 ee73b000
5e00: eee5e614 eee5e600 ee795e2c ee795e18 c01d4804 c0218760 00000000 ee73b000
5e20: ee795e4c ee795e30 c01d4990 c01d47d4 00000004 eeec9400 eee5ea14 eee5ea00
5e40: ee795e6c ee795e50 c01d49e0 c01d4964 00000004 eeec9c00 eee5ec14 eee5ec00
5e60: ee795e8c ee795e70 c01d49e0 c01d4964 00000004 eedd3000 eee5ee14 eee5ee00
5e80: ee795eac ee795e90 c01d49e0 c01d4964 ee795e88 eee5ee00 00000005 ee776380
5ea0: ee795ec4 ee795eb0 c037ceb4 c01d4964 eee5ee00 00000002 ee795ee4 ee795ec8
5ec0: c01dd170 c037ce98 00000041 00000001 eec69a68 ee776380 ee795ef4 ee795ee8
5ee0: c0216af4 c01dd134 ee795f0c ee795ef8 c00f6a4c c0216ad8 00000000 00000000
5f00: ee795f44 ee795f10 c00f9cd0 c00f6a14 00000000 00000000 c00a1430 eee47e00
5f20: 00000002 b6f9e000 ee795f78 00000002 ee794000 b6f9e000 ee795f74 ee795f48
5f40: c00a3830 c00f9be8 ee795f74 ee795f58 00000000 00000000 eee47e00 eee47e00
5f60: 00000002 b6f9e000 ee795fa4 ee795f78 c00a3bc8 c00a376c 00000000 00000000
5f80: 00000002 b6f9e000 b6edda78 00000004 c000ed84 00000000 00000000 ee795fa8
5fa0: c000ec00 c00a3b90 00000002 b6f9e000 00000001 b6f9e000 00000002 00000000
5fc0: 00000002 b6f9e000 b6edda78 00000004 00000002 00000002 b6f9e000 00000000
5fe0: 00000000 beb9da1c b6e1d390 b6e6eaac 60070010 00000001 00000000 00000000
Backtrace:
[<c02510c8>] (ahci_enable_ahci) from [<c02512cc>]
(ahci_save_initial_config+0x28/0x24c)
 r7:ee73b068 r6:f0460000 r5:ee6c9290 r4:ee73b000
[<c02512a4>] (ahci_save_initial_config) from [<c024e7c4>]
(ahci_init_one+0x384/0x850)
 r10:00000005 r9:ee776c88 r8:00000000 r7:00000000 r6:ee6c9290 r5:ee73b068
 r4:ee73b000 r3:00000000
[<c024e440>] (ahci_init_one) from [<c01dc224>] (pci_device_probe+0x60/0xa4)
 r10:ee776c80 r9:ee776c88 r8:c04d36c0 r7:00000000 r6:c04d36f4 r5:ee73b000
 r4:ee73b068
[<c01dc1c4>] (pci_device_probe) from [<c0218968>]
(driver_probe_device+0x130/0x340)
 r8:00000002 r7:c0218c0c r6:00000000 r5:c04d36f4 r4:ee73b068 r3:c01dc1c4
[<c0218838>] (driver_probe_device) from [<c0218c3c>] (__device_attach+0x30/0x4c)
 r6:ee73b068 r5:ee73b068 r4:c04d36f4
[<c0218c0c>] (__device_attach) from [<c0216d24>] (bus_for_each_drv+0x54/0x9c)
 r5:ee795dd0 r4:00000000
[<c0216cd0>] (bus_for_each_drv) from [<c02187c4>] (device_attach+0x70/0x88)
 r7:ee795f78 r6:eee5e600 r5:ee73b09c r4:ee73b068
[<c0218754>] (device_attach) from [<c01d4804>] (pci_bus_add_device+0x3c/0x68)
 r6:eee5e600 r5:eee5e614 r4:ee73b000 r3:00000001
[<c01d47c8>] (pci_bus_add_device) from [<c01d4990>]
(pci_bus_add_devices+0x38/0x9c)
 r4:ee73b000 r3:00000000
[<c01d4958>] (pci_bus_add_devices) from [<c01d49e0>]
(pci_bus_add_devices+0x88/0x9c)
 r6:eee5ea00 r5:eee5ea14 r4:eeec9400 r3:00000004
[<c01d4958>] (pci_bus_add_devices) from [<c01d49e0>]
(pci_bus_add_devices+0x88/0x9c)
 r6:eee5ec00 r5:eee5ec14 r4:eeec9c00 r3:00000004
[<c01d4958>] (pci_bus_add_devices) from [<c01d49e0>]
(pci_bus_add_devices+0x88/0x9c)
 r6:eee5ee00 r5:eee5ee14 r4:eedd3000 r3:00000004
[<c01d4958>] (pci_bus_add_devices) from [<c037ceb4>] (pci_rescan_bus+0x28/0x30)
 r6:ee776380 r5:00000005 r4:eee5ee00 r3:ee795e88
[<c037ce8c>] (pci_rescan_bus) from [<c01dd170>] (bus_rescan_store+0x48/0x70)
 r5:00000002 r4:eee5ee00
[<c01dd128>] (bus_rescan_store) from [<c0216af4>] (bus_attr_store+0x28/0x34)
 r5:ee776380 r4:eec69a68
[<c0216acc>] (bus_attr_store) from [<c00f6a4c>] (sysfs_kf_write+0x44/0x50)
[<c00f6a08>] (sysfs_kf_write) from [<c00f9cd0>] (kernfs_fop_write+0xf4/0x148)
 r5:00000000 r4:00000000
[<c00f9bdc>] (kernfs_fop_write) from [<c00a3830>] (vfs_write+0xd0/0x17c)
 r10:b6f9e000 r9:ee794000 r8:00000002 r7:ee795f78 r6:b6f9e000 r5:00000002
 r4:eee47e00
[<c00a3760>] (vfs_write) from [<c00a3bc8>] (SyS_write+0x44/0x84)
 r10:b6f9e000 r8:00000002 r7:eee47e00 r6:eee47e00 r5:00000000 r4:00000000
[<c00a3b84>] (SyS_write) from [<c000ec00>] (ret_fast_syscall+0x0/0x30)
 r10:00000000 r8:c000ed84 r7:00000004 r6:b6edda78 r5:b6f9e000 r4:00000002
Code: e1a0c00d e92dd8f0 e24cb004 e2804004 (e5906004)
---[ end trace 87a520011e442d68 ]---

And here is the boot log from the same kernel:

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 3.14.0-rc7 (root at orangebox) (gcc version 4.7.3 (Gentoo
4.7.3-r1 p1.3, pie-0.5.5) ) #18 SMP PREEMPT Mon Mar 31 11:22:04 BST
2014
CPU: ARMv7 Processor [562f5842] revision 2 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine model: Xyratex Porter-v1
bootconsole [earlycon0] enabled
Truncating RAM at 00000000-3fffffff to -2f7fffff (vmalloc region overlap).
Memory policy: Data cache writealloc
PERCPU: Embedded 7 pages/cpu @ef1ee000 s7040 r8192 d13440 u32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 193040
Kernel command line: console=ttyS0,115200 earlyprintk=ttys0 rw
pm_disable mtdparts=armada-nand:8m(boot),8m(kernel),-(rootfs)
ubi.mtd=2 root=ubi0:rootfs rootfstype=ubifs pci=hpiosize=0
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 766128K/778240K available (3579K kernel code, 225K rwdata,
1052K rodata, 154K init, 74K bss, 12112K reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc048dfd4   (4632 kB)
      .init : 0xc048e000 - 0xc04b4b80   ( 155 kB)
      .data : 0xc04b6000 - 0xc04ee438   ( 226 kB)
       .bss : 0xc04ee444 - 0xc0500ca8   (  75 kB)
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
Setting up static identity map for 0x385020 - 0x385054
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
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
irq: Cannot allocate irq_descs @ IRQ32, assuming pre-allocated
irq: Cannot allocate irq_descs @ IRQ67, assuming pre-allocated
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switched to clocksource armada_370_xp_clocksource
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
futex hash table entries: 512 (order: 3, 32768 bytes)
msgmni has been set to 1496
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
pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe0cfffff]
pci 0000:01:00.0: BAR 8: assigned [mem 0xe0000000-0xe05fffff]
pci 0000:01:00.0: BAR 9: assigned [mem 0xe0600000-0xe0bfffff 64bit pref]
pci 0000:01:00.0: BAR 0: assigned [mem 0xe0c00000-0xe0c1ffff]
pci 0000:02:01.0: BAR 8: assigned [mem 0xe0000000-0xe01fffff]
pci 0000:02:01.0: BAR 9: assigned [mem 0xe0600000-0xe07fffff 64bit pref]
pci 0000:02:02.0: BAR 8: assigned [mem 0xe0200000-0xe03fffff]
pci 0000:02:02.0: BAR 9: assigned [mem 0xe0800000-0xe09fffff 64bit pref]
pci 0000:02:03.0: BAR 8: assigned [mem 0xe0400000-0xe05fffff]
pci 0000:02:03.0: BAR 9: assigned [mem 0xe0a00000-0xe0bfffff 64bit pref]
pci 0000:02:01.0: PCI bridge to [bus 03]
pci 0000:02:01.0:   bridge window [mem 0xe0000000-0xe01fffff]
pci 0000:02:01.0:   bridge window [mem 0xe0600000-0xe07fffff 64bit pref]
pci 0000:02:02.0: PCI bridge to [bus 04]
pci 0000:02:02.0:   bridge window [mem 0xe0200000-0xe03fffff]
pci 0000:02:02.0:   bridge window [mem 0xe0800000-0xe09fffff 64bit pref]
pci 0000:02:03.0: PCI bridge to [bus 05]
pci 0000:02:03.0:   bridge window [mem 0xe0400000-0xe05fffff]
pci 0000:02:03.0:   bridge window [mem 0xe0a00000-0xe0bfffff 64bit pref]
pci 0000:01:00.0: PCI bridge to [bus 02-05]
pci 0000:01:00.0:   bridge window [mem 0xe0000000-0xe05fffff]
pci 0000:01:00.0:   bridge window [mem 0xe0600000-0xe0bfffff 64bit pref]
pci 0000:00:01.0: PCI bridge to [bus 01-05]
pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe0cfffff]
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
libphy: orion_mdio_bus: probed
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
TCP: cubic registered
NET: Registered protocol family 17
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
number: 1257185697
UBI: available PEBs: 0, total reserved PEBs: 2008, PEBs reserved for
bad PEB handling: 32
UBI: background thread "ubi_bgt0d" started, PID 920
rtc-mv f1010300.rtc: setting system clock to 2017-07-24 12:40:46 UTC
(1500900046)
UBIFS: background thread "ubifs_bgt0_0" started, PID 922
UBIFS: recovery needed
UBIFS: recovery completed
UBIFS: mounted UBI device 0, volume 0, name "rootfs"
UBIFS: LEB size: 516096 bytes (504 KiB), min./max. I/O unit sizes:
4096 bytes/4096 bytes
UBIFS: FS size: 1012064256 bytes (965 MiB, 1961 LEBs), journal size
33546240 bytes (31 MiB, 65 LEBs)
UBIFS: reserved for root: 4952683 bytes (4836 KiB)
UBIFS: media format: w4/r0 (latest is w4/r0), UUID
4EA889AC-C944-413F-A363-33F57F5CAE9A, small LPT model
VFS: Mounted root (ubifs filesystem) on device 0:12.
devtmpfs: mounted
Freeing unused kernel memory: 152K (c048e000 - c04b4000)

On 26 March 2014 17:18, Jason Gunthorpe <jgunthorpe@obsidianresearch.com> wrote:
> On Wed, Mar 26, 2014 at 06:06:34PM +0100, Thomas Petazzoni wrote:
>
>> Thanks for your report. I'm adding Jason Gunthorpe in Cc, as his
>> insights are always very helpful when investigating PCIe issues on
>> Marvell platforms.
>
> To me, this looks like standard problems with hot plug - unrelated to
> Marvell.
>
> Actually supporting the full generality of hot plug requires someone
> pre-allocate and reserve bridge window address space. On x86 the BIOS
> knows which slots are hot plug capable and ensures that address space
> is set aside for that slot when doing window assignment. Linux will
> just keep the BIOS assignment and when the hot plug happens the extra
> space is used.
>
> What you seem to be seeing is that Linux does an optimal allocation at
> boot, and the PCI-E switch port that connects to your hot plug slot is
> not allocated any spare address space for a future device.
>
> During rescan there is no free address space to assign to the new
> device so everything blows up.
>
> I know there are some provisions in the PCI core to solve this issue,
> I know on x86 the BIOS plays a role, but I'm not familiar enough with
> the details to give you an exact path to solve your problem, other
> than to say, at first boot you need to arrange for there to be extra
> address space available.
>
> A really simple dumb hack that might work is to change the order of
> the PCI-E ports on the Armada (I think you can do this through the
> DT). What you want is to place the port connected to the PLX last.
> The goal here is to have it do address assignment last, so it will get
> the last chunk of address space, and will have room to grow into
> unused space, instead of being blocked by another port.
>
> Regards,
> Jason

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------
