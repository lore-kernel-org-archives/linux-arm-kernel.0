From: vitalya@ti.com (Vitaly Andrianov)
Date: Mon, 1 Feb 2016 12:01:08 -0500
Subject: [PATCH 1/2] ARM: make virt_to_idmap() return unsigned long
In-Reply-To: <20160201152015.GU10826@n2100.arm.linux.org.uk>
References: <E1aO8F2-00074N-E8@rmk-PC.arm.linux.org.uk>
 <56A84748.3040108@oracle.com> <20160201152015.GU10826@n2100.arm.linux.org.uk>
Message-ID: <56AF8F54.7030805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/01/2016 10:20 AM, Russell King - ARM Linux wrote:
> On Tue, Jan 26, 2016 at 08:27:52PM -0800, santosh.shilimkar at oracle.com wrote:
>> On 1/26/16 10:21 AM, Russell King wrote:
>>> Make virt_to_idmap() return an unsigned long rather than phys_addr_t.
>>>
>>> Returning phys_addr_t here makes no sense, because the definition of
>>> virt_to_idmap() is that it shall return a physical address which maps
>>> identically with the virtual address.  Since virtual addresses are
>>> limited to 32-bit, identity mapped physical addresses are as well.
>>>
>>> Almost all users already had an implicit narrowing cast to unsigned long
>>> so let's make this official and part of this interface.
>>>
>>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>> ---
>> Looks correct to me.
>>
>> Vitaly,
>> Could you please try out this patch and see everything continue to
>> work ?
>
> I haven't heard anything yet...  Vitaly?
>
Russel, Santosh,

I'm not working with the latest kernel, but with the stable v4.1.y. So I 
couldn't apply the patch to it. I checked out 4.5.0-rc1 and applied the 
patch to it. Tried to boot and it crashed. I'm not sure either because 
of the patch or because of the network driver.

Here is the log:

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.5.0-rc1-00001-g22a8511 
(a0794637 at uda0794637) (gcc version 4.9.3 20150413 (prerelease) (Linaro 
GCC 4.9-2015.05) ) #1 6
[    0.000000] CPU: ARMv7 Processor [412fc0f4] revision 4 (ARMv7), 
cr=30c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction 
cache
[    0.000000] Machine model: Texas Instruments Keystone 2 
Kepler/Hawking EVM
[    0.000000] Switching physical address space to 0x800000000
[    0.000000] cma: Reserved 16 MiB at 0x000000085f000000
[    0.000000] Forcing write-allocate cache policy for SMP
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] PERCPU: Embedded 13 pages/cpu @ebf9e000 s21248 r8192 
d23808 u53248
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
Total pages: 1964544
[    0.000000] Kernel command line: console=ttyS0,115200n8 rootwait=1 
rdinit=/sbin/init rw root=/dev/ram0 initrd=0x808080000,80M
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 12288 bytes
[    0.000000] log_buf_len min size: 16384 bytes
[    0.000000] log_buf_len: 32768 bytes
[    0.000000] early log buf free: 14624(89%)
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 
bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 
bytes)
[    0.000000] Memory: 7694704K/7864320K available (5725K kernel code, 
365K rwdata, 1944K rodata, 368K init, 202K bss, 153232K reserved, 16384K 
cma)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0785a14   (7671 kB)
[    0.000000]       .init : 0xc0786000 - 0xc07e2000   ( 368 kB)
[    0.000000]       .data : 0xc07e2000 - 0xc083d5e8   ( 366 kB)
[    0.000000]        .bss : 0xc0840000 - 0xc0872868   ( 203 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] Architected cp15 timer(s) running at 200.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff 
max_cycles: 0x2e2049d3e8, max_idle_ns: 440795210634 ns
[    0.000003] sched_clock: 56 bits at 200MHz, resolution 5ns, wraps 
every 4398046511102ns
[    0.000012] Switching to timer-based delay loop, resolution 5ns
[    0.000159] keystone timer clock @200000000 Hz
[    0.000273] Console: colour dummy device 80x30
[    0.000290] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 400.00 BogoMIPS (lpj=2000000)
[    0.000300] pid_max: default: 4096 minimum: 301
[    0.000359] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000367] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 
bytes)
[    0.000808] CPU: Testing write buffer coherency: ok
[    0.000974] /cpus/cpu at 0 missing clock-frequency property
[    0.000992] /cpus/cpu at 1 missing clock-frequency property
[    0.001010] /cpus/cpu at 2 missing clock-frequency property
[    0.001028] /cpus/cpu at 3 missing clock-frequency property
[    0.001037] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.001073] Setting up static identity map for 0x800082c0 - 0x800083cc
[    0.084949] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.114987] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.145023] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.145099] Brought up 4 CPUs
[    0.145115] SMP: Total of 4 processors activated (1600.00 BogoMIPS).
[    0.145120] CPU: All CPU(s) started in SVC mode.
[    0.145452] devtmpfs: initialized
[    0.151260] VFP support v0.3: implementor 41 architecture 4 part 30 
variant f rev 0
[    0.151575] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.152177] NET: Registered protocol family 16
[    0.152958] DMA: preallocated 256 KiB pool for atomic coherent 
allocations
[    0.160094] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 
watchpoint registers.
[    0.160102] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.200557] vgaarb: loaded
[    0.200755] SCSI subsystem initialized
[    0.200965] usbcore: registered new interface driver usbfs
[    0.201020] usbcore: registered new interface driver hub
[    0.201070] usbcore: registered new device driver usb
[    0.202436] clocksource: Switched to clocksource arch_sys_counter
[    0.229144] NET: Registered protocol family 2
[    0.229502] TCP established hash table entries: 8192 (order: 3, 32768 
bytes)
[    0.229555] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.229658] TCP: Hash tables configured (established 8192 bind 8192)
[    0.229700] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.229726] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.229857] NET: Registered protocol family 1
[    0.230062] RPC: Registered named UNIX socket transport module.
[    0.230069] RPC: Registered udp transport module.
[    0.230074] RPC: Registered tcp transport module.
[    0.230079] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.230232] Unpacking initramfs...
[    1.229078] Freeing initrd memory: 81920K (c8080000 - cd080000)
[    1.229275] hw perfevents: enabled with armv7_cortex_a15 PMU driver, 
7 counters available
[    1.229816] platform alarmtimer: set dma_pfn_offset00780000
[    1.230252] futex hash table entries: 16 (order: -2, 1024 bytes)
[    1.239974] Installing knfsd (copyright (C) 1996 okir at monad.swb.de).
[    1.240074] ntfs: driver 2.1.32 [Flags: R/O].
[    1.240339] jffs2: version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
[    1.242984] NET: Registered protocol family 38
[    1.243049] bounce: pool size: 64 pages
[    1.243206] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 253)
[    1.243220] io scheduler noop registered
[    1.243231] io scheduler deadline registered
[    1.243260] io scheduler cfq registered (default)
[    1.243398] keystone_irq soc:keystone_irq at 26202a0: irqchip 
registered, nr_irqs 28
[    1.244639] keystone-navigator-qmss soc:qmss at 2a40000: qmgr start 
queue 0, number of queues 8192
[    1.244759] keystone-navigator-qmss soc:qmss at 2a40000: added qmgr 
start queue 0, num of queues 8192, reg_peek f09c0000, reg_status 
f09e2000, reg_0
[    1.244770] keystone-navigator-qmss soc:qmss at 2a40000: qmgr start 
queue 8192, number of queues 8192
[    1.244869] keystone-navigator-qmss soc:qmss at 2a40000: added qmgr 
start queue 8192, num of queues 8192, reg_peek f0a80000, reg_status 
f09e8400, r0
[    1.244994] keystone-navigator-qmss soc:qmss at 2a40000: failed to get 
firmware for pdsp
[    1.245739] keystone-navigator-qmss soc:qmss at 2a40000: pdsp id 0 not 
started for range acc-low-0
[    1.246359] keystone-navigator-dma soc:knav_dmas at 0: DMA dma_gbe 
registered 41 logical channels, flows 32, tx chans: 9, rx chans: 24
[    1.294877] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.294954] platform serial8250: set dma_pfn_offset00780000
[    1.296268] console [ttyS0] disabled
[    1.296302] 2530c00.serial: ttyS0 at MMIO 0x2530c00 (irq = 26, 
base_baud = 12500000) is a 16550A
[    2.002189] console [ttyS0] enabled
[    2.006331] 2531000.serial: ttyS1 at MMIO 0x2531000 (irq = 27, 
base_baud = 12500000) is a 16550A
[    2.020027] loop: module loaded
[    2.023349] at24 0-0050: 131072 byte 24c1024 EEPROM, writable, 1 
bytes/write
[    2.031653] m25p80 spi32766.0: n25q128a11 (16384 Kbytes)
[    2.037071] 2 ofpart partitions found on MTD device spi32766.0
[    2.042954] Creating 2 MTD partitions on "spi32766.0":
[    2.048111] 0x000000000000-0x000000080000 : "u-boot-spl"
[    2.054252] 0x000000080000-0x000001000000 : "misc"
[    2.059809] spi_davinci 21000400.spi: Controller at 0xf0a2a400
[    2.066120] spi_davinci 21000600.spi: Controller at 0xf0a2c600
[    2.072392] spi_davinci 21000800.spi: Controller at 0xf0a2e800
[    2.122448] davinci_mdio 2090300.mdio: davinci mdio revision 1.5
[    2.128476] libphy: 2090300.mdio: probed
[    2.138918] davinci_mdio 2090300.mdio: phy[0]: device 
2090300.mdio:00, driver Marvell 88E1111
[    2.147513] davinci_mdio 2090300.mdio: phy[1]: device 
2090300.mdio:01, driver Marvell 88E1111
[    3.161406] netcp-1.0 2620110.netcp: module(netcp-xgbe) not used for 
device
[    3.369570] platform xhci-hcd.0.auto: set dma_pfn_offset00780000
[    3.376121] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    3.381764] xhci-hcd xhci-hcd.0.auto: new USB bus registered, 
assigned bus number 1
[    3.389696] xhci-hcd xhci-hcd.0.auto: hcc params 0x0298f06d hci 
version 0x100 quirks 0x00010010
[    3.398469] xhci-hcd xhci-hcd.0.auto: irq 34, io mem 0x02690000
[    3.404567] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.411381] usb usb1: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    3.418659] usb usb1: Product: xHCI Host Controller
[    3.423582] usb usb1: Manufacturer: Linux 4.5.0-rc1-00001-g22a8511 
xhci-hcd
[    3.430566] usb usb1: SerialNumber: xhci-hcd.0.auto
[    3.435888] hub 1-0:1.0: USB hub found
[    3.439670] hub 1-0:1.0: 1 port detected
[    3.443900] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    3.449540] xhci-hcd xhci-hcd.0.auto: new USB bus registered, 
assigned bus number 2
[    3.457310] usb usb2: We don't know the algorithms for LPM for this 
host, disabling LPM.
[    3.465555] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    3.472367] usb usb2: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    3.479642] usb usb2: Product: xHCI Host Controller
[    3.484560] usb usb2: Manufacturer: Linux 4.5.0-rc1-00001-g22a8511 
xhci-hcd
[    3.491544] usb usb2: SerialNumber: xhci-hcd.0.auto
[    3.496852] hub 2-0:1.0: USB hub found
[    3.500633] hub 2-0:1.0: 1 port detected
[    3.504979] usbcore: registered new interface driver usb-storage
[    3.511253] mousedev: PS/2 mouse device common for all mice
[    3.517058] i2c /dev entries driver
[    3.521106] davinci-wdt 22f0080.wdt: heartbeat 60 sec
[    3.527105] usbcore: registered new interface driver usbhid
[    3.532729] usbhid: USB HID core driver
[    3.537313] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xac
[    3.543798] nand: Micron MT29F4G08ABBDAHC
[    3.547821] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, 
OOB size: 64
[    3.555751] Bad block table found at page 262080, version 0x01
[    3.562130] Bad block table found at page 262016, version 0x01
[    3.568339] 3 ofpart partitions found on MTD device 30000000.nand
[    3.574482] Creating 3 MTD partitions on "30000000.nand":
[    3.579898] 0x000000000000-0x000000100000 : "u-boot"
[    3.585670] 0x000000100000-0x000000180000 : "params"
[    3.591394] 0x000000180000-0x000020000000 : "ubifs"
[    3.597258] davinci_nand 30000000.nand: controller rev. 2.5
[    3.603148] platform oprofile-perf.0: set dma_pfn_offset00780000
[    3.609305] oprofile: using timer interrupt.
[    3.613671] Netfilter messages via NETLINK v0.30.
[    3.618402] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[    3.625204] ctnetlink v0.93: registering with nfnetlink.
[    3.630769] ipip: IPv4 over IPv4 tunneling driver
[    3.635904] gre: GRE over IPv4 demultiplexor driver
[    3.640800] ip_gre: GRE over IPv4 tunneling driver
[    3.646523] ip_tables: (C) 2000-2006 Netfilter Core Team
[    3.651932] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
[    3.658400] arp_tables: arp_tables: (C) 2002 David S. Miller
[    3.664154] Initializing XFRM netlink socket
[    3.669212] NET: Registered protocol family 10
[    3.674461] NET: Registered protocol family 17
[    3.678934] NET: Registered protocol family 15
[    3.683431] 8021q: 802.1Q VLAN Support v1.8
[    3.688454] sctp: Hash tables configured (bind 65536)
[    3.693842] Registering SWP/SWPB emulation handler
[    3.714212] Freeing unused kernel memory: 368K (c0786000 - c07e2000)
INIT: version 2.88 booting
Starting udev
Starting Bootlog daemon: bootlogd.
Configuring network interfaces... [    4.743126] netcp-1.0 2620110.netcp 
eth0: Link is Down
[    4.750118] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    4.756002] 8021q: adding VLAN 0 to HW filter on device eth0
udhcpc (v1.20.2) started
Sending discover...
Sending discover...
[    8.742799] netcp-1.0 2620110.netcp eth0: Link is Up - 1Gbps/Full - 
flow control off
[    8.750578] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    8.972474] Unable to handle kernel NULL pointer dereference at 
virtual address 00000000
[    8.980593] pgd = c0003000
[    8.983317] [00000000] *pgd=80000800004003, *pmd=00000000
[    8.988744] Internal error: Oops: a07 [#1] PREEMPT SMP ARM
[    8.994246] Modules linked in:
[    8.997314] CPU: 0 PID: 330 Comm: kworker/0:1 Not tainted 
4.5.0-rc1-00001-g22a8511 #1
[    9.005171] Hardware name: Keystone
[    9.008677] Workqueue: ipv6_addrconf addrconf_dad_work
[    9.013836] task: eba89500 ti: eba96000 task.ti: eba96000
[    9.019253] PC is at tasklet_action+0xac/0x13c
[    9.023714] LR is at _raw_spin_unlock_irqrestore+0x28/0x54
[    9.029216] pc : [<c0026c48>]    lr : [<c0574634>]    psr: 40000133
[    9.029216] sp : eba97d30  ip : eb400258  fp : c083aecc
[    9.040737] r10: 0000000c  r9 : eba97dc8  r8 : 00000100
[    9.045976] r7 : 00000008  r6 : eba96000  r5 : 00000003  r4 : c07e408c
[    9.052524] r3 : eba97d00  r2 : eba97d00  r1 : 60000113  r0 : 00000000
[    9.059073] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb 
Segment kernel
[    9.066580] Control: 30c5387d  Table: 2b9ba700  DAC: fffffffd
[    9.072344] Process kworker/0:1 (pid: 330, stack limit = 0xeba96210)
[    9.078717] Stack: (0xeba97d30 to 0xeba98000)
[    9.083087] 7d20:                                     000086dd 
ebbb9900 00000004 eba97d30
[    9.091294] 7d40: c07e4080 c08409c0 0000000a ffff8e53 c07e4100 
04208060 ebbb9900 c07dce84
[    9.099502] 7d60: 00000000 0000004e 00000000 00000001 eba97dc8 
eb838000 c082ad40 c0026778
[    9.107708] 7d80: c07dce84 c006754c c080f430 c07e5e84 f080400c 
eba97dc8 f0804000 f0805000
[    9.115915] 7da0: 00000001 c0009438 c04fc29c 20000013 ffffffff 
eba97dfc cc8da400 eaf54d00
[    9.124121] 7dc0: 00000001 c0574e40 00000000 c06cab20 00000000 
00000087 cc8a7600 eb0e4100
[    9.132326] 7de0: c082ad40 00000187 cc8da400 eaf54d00 00000001 
c082ad40 f0a02880 eba97e18
[    9.140533] 7e00: c0026618 c04fc29c 20000013 ffffffff 00000018 
c04fc3c8 66cdb48e 00000002
[    9.148739] 7e20: c07e5cec 00000087 00000002 00000000 00000000 
003a0000 00000000 00000000
[    9.156944] 7e40: 00000000 00000000 000002ff 00000000 01000000 
67a532ff 00000000 00000000
[    9.165150] 7e60: 00000000 00000000 00000000 00000087 cc80be38 
c05c7568 cc80be38 eba97ed8
[    9.173356] 7e80: cc8a7e40 cc8a7600 eba97ea8 00000000 c083af58 
c04fd040 eba97ebc 00000000
[    9.181563] 7ea0: cc8a7e78 00000004 000080fe 00000000 ff28000a 
67a532fe cc8a7e78 cc8a7e5c
[    9.189770] 7ec0: cc8a7e60 cc8a7e40 cc8da484 00000000 00000000 
c04eebc8 000002ff 00000000
[    9.197975] 7ee0: 01000000 67a532ff eba97efc cc8a7e78 ebb42700 
00000008 ebfa2300 ebfa9b00
[    9.206182] 7f00: 00000000 c0038180 ebfa2300 00000008 00000001 
ebfa2300 ebb42718 00000008
[    9.214388] 7f20: ebfa2318 c07e4100 eba96000 ebfa2300 ebb42700 
c00384c4 ebb41340 ebb42700
[    9.222593] 7f40: c003848c 00000000 ebb41340 ebb42700 c003848c 
00000000 00000000 00000000
[    9.230799] 7f60: 00000000 c003d66c 00000000 00000000 eba97f70 
ebb42700 00000000 00000000
[    9.239004] 7f80: eba97f80 eba97f80 00000000 00000000 eba97f90 
eba97f90 eba97fac ebb41340
[    9.247210] 7fa0: c003d590 00000000 00000000 c000f548 00000000 
00000000 00000000 00000000
[    9.255415] 7fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    9.263621] 7fe0: 00000000 00000000 00000000 00000000 00000013 
00000000 00000000 00000000
[    9.271834] [<c0026c48>] (tasklet_action) from [<c08409c0>] 
(irq_stat+0x0/0x100)
[    9.279257] Code: 4000 e256 0020 0a00 (5004) e1a0
[    9.284077] ---[ end trace e5db23259be8804d ]---
[    9.288707] Kernel panic - not syncing: Fatal exception in interrupt
[    9.295083] CPU2: stopping
[    9.297799] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D 
4.5.0-rc1-00001-g22a8511 #1
[    9.306528] Hardware name: Keystone
[    9.310036] [<c0016490>] (unwind_backtrace) from [<c0012d44>] 
(show_stack+0x10/0x14)
[    9.317812] [<c0012d44>] (show_stack) from [<c02b3ce4>] 
(dump_stack+0x84/0xc4)
[    9.325061] [<c02b3ce4>] (dump_stack) from [<c00155a4>] 
(handle_IPI+0x2e0/0x2f0)
[    9.332484] [<c00155a4>] (handle_IPI) from [<c0009474>] 
(gic_handle_irq+0x84/0x88)
[    9.340084] [<c0009474>] (gic_handle_irq) from [<c0574e40>] 
(__irq_svc+0x40/0x74)
[    9.347591] Exception stack(0xeb8c3f88 to 0xeb8c3fd0)
[    9.352659] 3f80:                   00000002 00000000 000016aa 
c001ee80 00000001 eb8c2000
[    9.360866] 3fa0: c07e5950 c0840308 c083b480 c07e58f0 c07db3a4 
eb8c3fe0 c07e4244 eb8c3fd8
[    9.369072] 3fc0: c000fddc c000fde0 600f0013 ffffffff
[    9.374144] [<c0574e40>] (__irq_svc) from [<c000fde0>] 
(arch_cpu_idle+0x38/0x3c)
[    9.381573] [<c000fde0>] (arch_cpu_idle) from [<c005bf14>] 
(cpu_startup_entry+0x158/0x2b4)
[    9.389869] [<c005bf14>] (cpu_startup_entry) from [<8000950c>] 
(0x8000950c)
[    9.396855] CPU3: stopping
[    9.399570] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D 
4.5.0-rc1-00001-g22a8511 #1
[    9.408299] Hardware name: Keystone
[    9.411805] [<c0016490>] (unwind_backtrace) from [<c0012d44>] 
(show_stack+0x10/0x14)
[    9.419581] [<c0012d44>] (show_stack) from [<c02b3ce4>] 
(dump_stack+0x84/0xc4)
[    9.426829] [<c02b3ce4>] (dump_stack) from [<c00155a4>] 
(handle_IPI+0x2e0/0x2f0)
[    9.434252] [<c00155a4>] (handle_IPI) from [<c0009474>] 
(gic_handle_irq+0x84/0x88)
[    9.441851] [<c0009474>] (gic_handle_irq) from [<c0574e40>] 
(__irq_svc+0x40/0x74)
[    9.449359] Exception stack(0xeb8c5e68 to 0xeb8c5eb0)
[    9.454427] 5e60:                   ebfc5400 00000000 ffff8e72 
000003aa 00000031 00000001
[    9.462633] 5e80: ebfc5400 00000000 c03231fc c0866620 eb8c4000 
c07e4100 ffff8e71 eb8c5eb8
[    9.470839] 5ea0: c0077e9c c0574680 a0000113 ffffffff
[    9.475909] [<c0574e40>] (__irq_svc) from [<c0574680>] 
(_raw_spin_unlock_irq+0x20/0x54)
[    9.483944] [<c0574680>] (_raw_spin_unlock_irq) from [<c0077e9c>] 
(run_timer_softirq+0x18c/0x27c)
[    9.492850] [<c0077e9c>] (run_timer_softirq) from [<c00262a0>] 
(__do_softirq+0xb8/0x330)
[    9.500970] [<c00262a0>] (__do_softirq) from [<c0026778>] 
(irq_exit+0x80/0xb4)
[    9.508221] [<c0026778>] (irq_exit) from [<c006754c>] 
(__handle_domain_irq+0x80/0xec)
[    9.516080] [<c006754c>] (__handle_domain_irq) from [<c0009438>] 
(gic_handle_irq+0x48/0x88)
[    9.524462] [<c0009438>] (gic_handle_irq) from [<c0574e40>] 
(__irq_svc+0x40/0x74)
[    9.531969] Exception stack(0xeb8c5f88 to 0xeb8c5fd0)
[    9.537037] 5f80:                   00000003 00000000 00001b88 
c001ee80 00000001 eb8c4000
[    9.545243] 5fa0: c07e5950 c0840308 c083b480 c07e58f0 c07db3a4 
eb8c5fe0 c07e4244 eb8c5fd8
[    9.553448] 5fc0: c000fddc c000fde0 60000013 ffffffff
[    9.558519] [<c0574e40>] (__irq_svc) from [<c000fde0>] 
(arch_cpu_idle+0x38/0x3c)
[    9.565944] [<c000fde0>] (arch_cpu_idle) from [<c005bf14>] 
(cpu_startup_entry+0x158/0x2b4)
[    9.574239] [<c005bf14>] (cpu_startup_entry) from [<8000950c>] 
(0x8000950c)
[    9.581224] CPU1: stopping
[    9.583940] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D 
4.5.0-rc1-00001-g22a8511 #1
[    9.592668] Hardware name: Keystone
[    9.596172] [<c0016490>] (unwind_backtrace) from [<c0012d44>] 
(show_stack+0x10/0x14)
[    9.603947] [<c0012d44>] (show_stack) from [<c02b3ce4>] 
(dump_stack+0x84/0xc4)
[    9.611196] [<c02b3ce4>] (dump_stack) from [<c00155a4>] 
(handle_IPI+0x2e0/0x2f0)
[    9.618619] [<c00155a4>] (handle_IPI) from [<c0009474>] 
(gic_handle_irq+0x84/0x88)
[    9.626217] [<c0009474>] (gic_handle_irq) from [<c0574e40>] 
(__irq_svc+0x40/0x74)
[    9.633725] Exception stack(0xeb8c1f88 to 0xeb8c1fd0)
[    9.638793] 1f80:                   00000001 00000000 00001ad6 
c001ee80 00000001 eb8c0000
[    9.647000] 1fa0: c07e5950 c0840308 c083b480 c07e58f0 c07db3a4 
eb8c1fe0 c07e4244 eb8c1fd8
[    9.655205] 1fc0: c000fddc c000fde0 60000013 ffffffff
[    9.660276] [<c0574e40>] (__irq_svc) from [<c000fde0>] 
(arch_cpu_idle+0x38/0x3c)
[    9.667701] [<c000fde0>] (arch_cpu_idle) from [<c005bf14>] 
(cpu_startup_entry+0x158/0x2b4)
[    9.675997] [<c005bf14>] (cpu_startup_entry) from [<8000950c>] 
(0x8000950c)
[    9.682986] ---[ end Kernel panic - not syncing: Fatal exception in 
interrupt


Regards,
-Vitaly
