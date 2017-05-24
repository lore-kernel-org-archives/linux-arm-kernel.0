From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 24 May 2017 22:58:53 +0000
Subject: pxa3xx-nand failing to find device on linux-next
References: <b36366e358904310aee4970b77f57dba@svr-chch-ex1.atlnz.lc>
 <2a79405e219b4c37ba00defbe4a0dfe4@svr-chch-ex1.atlnz.lc>
 <20170524132301.12ad33d8@bbrezillon> <20170524132508.420614c7@bbrezillon>
 <ebe9d9bca4754d1ba920295f2fdd1359@svr-chch-ex1.atlnz.lc>
 <20170525003646.276516d0@bbrezillon>
Message-ID: <69dfc0d5ca774efb8c92e9ec635f68ec@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/05/17 10:36, Boris Brezillon wrote:
> Le Wed, 24 May 2017 22:03:52 +0000,
> Chris Packham <Chris.Packham@alliedtelesis.co.nz> a ?crit :
> 
>> On 24/05/17 23:25, Boris Brezillon wrote:
>>> On Wed, 24 May 2017 13:23:01 +0200
>>> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
>>>    
>>>> Hi Chris,
>>>>
>>>> On Wed, 24 May 2017 09:36:56 +0000
>>>> Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:
>>>>   
>>>>> On 23/05/17 17:27, Chris Packham wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I'm doing some testing on linux-next and I'm finding that my nand flash
>>>>>> has disappeared.
>>>>>>
>>>>>> pxa3xx-nand f10d0000.flash: This platform can't do DMA on this device
>>>>>> pxa3xx-nand f10d0000.flash: non-supported command ef
>>>>>> pxa3xx-nand f10d0000.flash: non-supported command ee
>>>>>> pxa3xx-nand f10d0000.flash: non-supported command ef
>>>>>> pxa3xx-nand f10d0000.flash: non-supported command ee
>>>>>> On-die ECC forcefully enabled, not supported
>>>>>> nand: No NAND device found
>>>>>> pxa3xx-nand f10d0000.flash: failed to scan nand at cs 0
>>>>>>
>>>>>> This was working around 4.11. I'll try to do some more digging tomorrow
>>>>>> to narrow down a failure point but I thought I'd send this out now just
>>>>>> in case it rings any bells.
>>>>>>
>>>>>> The board I'm using (DB-88F6820-AMC) is unfortunately out-of tree but it
>>>>>> should be pretty close to the armada-388-db. I can make my dts available
>>>>>> if it's helpful.
>>>>>
>>>>> Still works on 4.12-rc2. Fails on next-20170524.
>>>>>
>>>>> This appears to be due to commit b566d9c055de ("mtd: nand: add support
>>>>> for Micron on-die ECC"). Which based on the description seems intentional.
>>>>>
>>>>> Since I have access to a hardware platform that has a micron flash with
>>>>> ECC forcefully enabled how can I help to get this implemented.
>>>>
>>>> Can you try with this patch applied [1]?
>>>
>>> Sorry, wrong patch. Can you try this one [1] instead?
>>>
>>> [1]http://code.bulix.org/pkfhmi-135875
>>>    
>>
>> With the patch above the chip is detected but ubifs is unhappy
> 
> Hm, weird. And if you revert my both Thomas patch and mine, what do you
> get?

Seems to work just fine.

> BTW, can you paste the full boot logs, not only the failing part?

Sure. Full log from next-20170524 + http://code.bulix.org/pkfhmi-135875 
below.

[root at linuxbox /]# dmesg
pcpu-alloc: [0] 0 [0] 1
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 455168
Kernel command line: console=ttyS0,115200 root=/dev/ram0 loglevel=8
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Memory: 1798628K/1835008K available (5120K kernel code, 173K rwdata, 
1364K rodata, 1024K init, 123K bss, 36380K reserved, 0K cma-rese
rved)
Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
     lowmem  : 0x80000000 - 0xf0000000   (1792 MB)
     modules : 0x7f000000 - 0x80000000   (  16 MB)
       .text : 0x80008000 - 0x80600000   (6112 kB)
       .init : 0x80800000 - 0x80900000   (1024 kB)
       .data : 0x80900000 - 0x8092b600   ( 174 kB)
        .bss : 0x80930688 - 0x8094f440   ( 124 kB)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Preemptible hierarchical RCU implementation.
         RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS:16 nr_irqs:16 16
L2C-310 enabling early BRESP for Cortex-A9
L2C-310 full line of zeros enabled for Cortex-A9
L2C-310 D prefetch enabled, offset 1 lines
L2C-310 dynamic clock gating enabled, standby mode enabled
L2C-310 Coherent cache controller enabled, 16 ways, 1024 kB
L2C-310 Coherent: CACHE_ID 0x410054c9, AUX_CTRL 0x56070001
Switching to timer-based delay loop, resolution 50ns
sched_clock: 32 bits at 20MHz, resolution 50ns, wraps every 107374182375ns
clocksource: armada_370_xp_clocksource: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 95563022313 ns
Calibrating delay loop (skipped), value calculated using timer 
frequency.. 40.00 BogoMIPS (lpj=200000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 4096 (order: 2, 16384 bytes)
Mountpoint-cache hash table entries: 4096 (order: 2, 16384 bytes)
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x100000 - 0x100060
mvebu-soc-id: MVEBU SoC ID=0x6820, Rev=0x4
mvebu-pmsu: Initializing Power Management Service Unit
Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
Booting CPU 1
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
smp: Brought up 1 node, 2 CPUs
SMP: Total of 2 processors activated (80.00 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, 
max_idle_ns: 19112604462750000 ns
futex hash table entries: 512 (order: 3, 32768 bytes)
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
mvebu-pmsu: CPU hotplug support is currently broken on Armada 38x: disabling
mvebu-pmsu: CPU idle is currently broken on Armada 38x: disabling
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
clocksource: Switched to clocksource armada_370_xp_clocksource
NET: Registered protocol family 2
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
UDP hash table entries: 1024 (order: 3, 32768 bytes)
UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
NET: Registered protocol family 1
PCI: CLS 0 bytes, default 64
Trying to unpack rootfs image as initramfs...
rootfs image is not initramfs (junk in compressed archive); looks like 
an initrd
Freeing initrd memory: 11756K
workingset: timestamp_bits=30 max_order=19 bucket_order=0
squashfs: version 4.0 (2009/01/31) Phillip Lougher
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
io scheduler mq-deadline registered
io scheduler kyber registered
armada-38x-pinctrl f1018000.pinctrl: registered pinctrl driver
mvebu-pcie soc:pcie-controller: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:01.0: [11ab:6820] type 01 class 0x060400
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus1: Fast back to back transfers enabled
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci 0000:00:01.0: PCI bridge to [bus 01]
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
console [ttyS0] disabled
f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 21, base_baud = 
12500000) is a 16550A
console [ttyS0] enabled
brd: module loaded
loop: module loaded
mtdoops: mtd device (mtddev=name/number) must be supplied
pxa3xx-nand f10d0000.flash: This platform can't do DMA on this device
pxa3xx-nand f10d0000.flash: Wait time out!!!
nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xd3
nand: Micron MT29F8G08ABACAWP
nand: 1024 MiB, SLC, erase size: 256 KiB, page size: 4096, OOB size: 224
pxa3xx-nand f10d0000.flash: ECC strength 16, ECC step size 1024
Bad block table found at page 262080, version 0x01
Bad block table found at page 262016, version 0x01
m25p80 spi1.0: n25q256a (32768 Kbytes)
2 ofpart partitions found on MTD device spi1.0
Creating 2 MTD partitions on "spi1.0":
0x000000000000-0x000000100000 : "u-boot"
0x000000100000-0x000000140000 : "u-boot-env"
libphy: Fixed MDIO Bus: probed
libphy: orion_mdio_bus: probed
mvneta f1070000.ethernet eth0: Using device tree mac address 
00:50:43:00:08:fd
mvneta f1034000.ethernet eth1: Using hardware mac address 00:50:43:00:08:fd
usbcore: registered new interface driver asix
usbcore: registered new interface driver cdc_ether
usbcore: registered new interface driver smsc75xx
usbcore: registered new interface driver usb-storage
i2c /dev entries driver
(NULL device *): hwmon_device_register() is deprecated. Please convert 
the driver to use hwmon_device_register_with_info().
orion_wdt: Initial timeout 214 sec
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
ipip: IPv4 and MPLS over IPv4 tunneling driver
ip_tables: (C) 2000-2006 Netfilter Core Team
Initializing XFRM netlink socket
NET: Registered protocol family 10
Segment Routing with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
Registering SWP/SWPB emulation handler
registered taskstats version 1
RAMDISK: squashfs filesystem found at block 0
RAMDISK: Loading 11753KiB [1 disk] into ram disk... -
-
done.
VFS: Mounted root (squashfs filesystem) readonly on device 1:0.
devtmpfs: mounted
Freeing unused kernel memory: 1024K
 >systemd[1]: System time before build time, advancing clock.
random: systemd: uninitialized urandom read (16 bytes read)
 >systemd[1]: systemd 231 running in system mode. (-PAM -AUDIT -SELINUX 
-IMA -APPARMOR -SMACK +SYSVINIT -UTMP -LIBCRYPTSETUP -GCRYPT -
GNUTLS -ACL -XZ -LZ4 -SECCOMP +BLKID -ELFUTILS -KMOD -IDN)
 >systemd[1]: Detected architecture arm.
 >systemd[1]: Set hostname to <awplus>.
random: systemd: uninitialized urandom read (16 bytes read)
 >systemd[1]: Initializing machine ID from random generator.
 >systemd[1]: Installed transient /etc/machine-id file.
random: systemd: uninitialized urandom read (16 bytes read)
random: systemd: uninitialized urandom read (16 bytes read)
random: systemd: uninitialized urandom read (16 bytes read)
random: systemd: uninitialized urandom read (16 bytes read)
random: systemd: uninitialized urandom read (16 bytes read)
 >udevd[581]: starting version 174
ubi0: attaching mtd0
random: fast init done
random: crng init done
ubi0: scanning is finished
ubi0: attached mtd0 (name "pxa3xx_nand-0", size 1024 MiB)
ubi0: PEB size: 262144 bytes (256 KiB), LEB size: 253952 bytes
ubi0: min./max. I/O unit sizes: 4096/4096, sub-page size 4096
ubi0: VID header offset: 4096 (aligned 4096), data offset: 8192
ubi0: good PEBs: 4088, bad PEBs: 8, corrupted PEBs: 0
ubi0: user volume: 1, internal volumes: 1, max. volumes count: 128
ubi0: max/mean erase counter: 1/0, WL threshold: 4096, image sequence 
number: 2130122366
ubi0: available PEBs: 0, total reserved PEBs: 4088, PEBs reserved for 
bad PEB handling: 72
ubi0: background thread "ubi_bgt0d" started, PID 597
UBIFS (ubi0:0): background thread "ubifs_bgt0_0" started, PID 601
UBIFS (ubi0:0): recovery needed
UBIFS (ubi0:0): recovery completed
UBIFS (ubi0:0): UBIFS: mounted UBI device 0, volume 0, name "user"
UBIFS (ubi0:0): LEB size: 253952 bytes (248 KiB), min./max. I/O unit 
sizes: 4096 bytes/4096 bytes
UBIFS (ubi0:0): FS size: 1016315904 bytes (969 MiB, 4002 LEBs), journal 
size 9404416 bytes (8 MiB, 38 LEBs)
UBIFS (ubi0:0): reserved for root: 0 bytes (0 KiB)
UBIFS (ubi0:0): media format: w4/r0 (latest is w5/r0), UUID 
2C1F4CD3-FDB1-4A52-8BE8-79AAD15CF6EC, small LPT model
UBIFS error (ubi0:0 pid 599): ubifs_read_node: bad node type (160 but 
expected 0)
UBIFS error (ubi0:0 pid 599): ubifs_read_node: bad node at LEB 10:90344, 
LEB mapping status 1
Not a node, first 24 bytes:
00000000: 00 00 00 00 31 18 10 06 e5 43 e1 9f 3b 00 00 00 00 00 00 00 a0 
00 00 00                          ....1....C..;...........
CPU: 1 PID: 599 Comm: mount Not tainted 4.12.0-rc2-next-20170524-at1+ #58
Hardware name: Marvell Armada 380/385 (Device Tree)
[<801102dc>] (unwind_backtrace) from [<8010b658>] (show_stack+0x10/0x14)
[<8010b658>] (show_stack) from [<8031aa0c>] (dump_stack+0x88/0x9c)
[<8031aa0c>] (dump_stack) from [<802aebb8>] (ubifs_read_node+0x130/0x284)
[<802aebb8>] (ubifs_read_node) from [<802ca2a4>] 
(ubifs_tnc_read_node+0x4c/0xd4)
[<802ca2a4>] (ubifs_tnc_read_node) from [<802b1e60>] 
(ubifs_tnc_locate+0x1c0/0x1c8)
[<802b1e60>] (ubifs_tnc_locate) from [<802aa15c>] (ubifs_iget+0x78/0x554)
[<802aa15c>] (ubifs_iget) from [<802aa90c>] (ubifs_mount+0x2d4/0x1524)
[<802aa90c>] (ubifs_mount) from [<801dfab4>] (mount_fs+0x14/0xa4)
[<801dfab4>] (mount_fs) from [<801fa6b4>] (vfs_kern_mount+0x4c/0xf4)
[<801fa6b4>] (vfs_kern_mount) from [<801fd738>] (do_mount+0x154/0xb50)
[<801fd738>] (do_mount) from [<801fe49c>] (SyS_mount+0x74/0x9c)
[<801fe49c>] (SyS_mount) from [<801077a0>] (ret_fast_syscall+0x0/0x3c)
UBIFS error (ubi0:0 pid 599): ubifs_iget: failed to read inode 1, error -22
UBIFS (ubi0:0): background thread "ubifs_bgt0_0" stops
ubi0: detaching mtd0
ubi0: mtd0 is detached
ubi0: attaching mtd0
ubi0: scanning is finished
ubi0 error: ubi_read_volume_table: the layout volume was not found
ubi0 error: ubi_attach_mtd_dev: failed to attach mtd0, error -22
