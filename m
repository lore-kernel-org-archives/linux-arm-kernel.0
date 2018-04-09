From: lambertarthur22@gmail.com (Arthur LAMBERT)
Date: Mon, 9 Apr 2018 15:58:52 +0200
Subject: issue with kexec/kdump on imx6ull
In-Reply-To: <20180329205413.GG16141@n2100.armlinux.org.uk>
References: <20180320100427.GA21933@arthur-bzh>
 <20180320104302.GG2743@n2100.armlinux.org.uk>
 <20180320150723.GH2743@n2100.armlinux.org.uk>
 <20180320171608.GB32282@arthur-bzh>
 <20180320191259.GI2743@n2100.armlinux.org.uk>
 <20180321132548.GA32618@arthur-bzh>
 <20180329205413.GG16141@n2100.armlinux.org.uk>
Message-ID: <20180409135852.GA22168@arthur-bzh>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

I was finally able to make it work by using mainline kernel (v4.16-rc7) :

# uname -a
Linux buildroot-imx6ull-evk 4.16.0-rc7 #2 SMP Mon Apr 9 10:00:16 CEST 2018 armv7l GNU/Linux
# sh kx.sh
Try gzip decompression.
kernel: 0xb6836008 kernel_size: 0x661cb8
MEMORY RANGES
0000000080000000-000000009fffffff (0)
zImage header: 0x016f2818 0x00000000 0x00661cb8
zImage size 0x661cb8, file size 0x661cb8
zImage requires 0x00672cb8 bytes
  offset 0x00003ae0 tag 0x5a534c4b size 8
  Decompressed kernel sizes:
   text+data 0x01073700 bss 0x0078805c total 0x017fb75c
   Resulting kernel space: 0x017fb75c
   Reserved memory ranges
   0000000098000000-000000009b1fffff (0)
   Coredump memory ranges
   0000000080000000-0000000097ffffff (0)
   000000009b200000-000000009fffffff (0)
   phys offset = 0x80000000, page offset = c0000000
   Using 32-bit ELF core format
   get_crash_notes_per_cpu: crash_notes addr = 9bbc3300, size = 180
   Elf header: p_type = 4, p_offset = 0x9bbc3300 p_paddr = 0x9bbc3300 p_vaddr = 0x0 p_filesz = 0xb4 p_memsz = 0xb4
   vmcoreinfo header: p_type = 4, p_offset = 0x9614e000 p_paddr = 0x9614e000 p_vaddr = 0x0 p_filesz = 0x1024 p_memsz = 0x1024
   Elf header: p_type = 1, p_offset = 0x80000000 p_paddr = 0x80000000 p_vaddr = 0xc0000000 p_filesz = 0x18000000 p_memsz = 0x18000000
   Elf header: p_type = 1, p_offset = 0x9b200000 p_paddr = 0x9b200000 p_vaddr = 0xdb200000 p_filesz = 0x4e00000 p_memsz = 0x4e00000
   elfcorehdr: 0x9b100000
   crashkernel: [0x98000000 - 0x9b1fffff] (50M)
   memory range: [0x80000000 - 0x97ffffff] (384M)
   memory range: [0x9b200000 - 0x9fffffff] (78M)
   kernel command line: "console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw earlyprintk maxcpus=1 reset_devices elfcorehdr=0x9b100000 mem=50176K"
   Kernel: address=0x98008000 size=0x017fb75c
   DT    : address=0x99805000 size=0x00007048
   kexec_load: entry = 0x98008000 flags = 0x280001
   nr_segments = 3
   segment[0].buf   = 0xb6836008
   segment[0].bufsz = 0x661cbc
   segment[0].mem   = 0x98008000
   segment[0].memsz = 0x662000
   segment[1].buf   = 0x2dd578
   segment[1].bufsz = 0x7048
   segment[1].mem   = 0x99805000
   segment[1].memsz = 0x8000
   segment[2].buf   = 0x2dd100
   segment[2].bufsz = 0x400
   segment[2].mem   = 0x9b100000
   segment[2].memsz = 0x1000
   result2 : 0
   do_shutdown : 0
   do_exec2 : 0
   kx.sh: kexec: success, dump kernel loaded.

# echo c > /proc/sysrq-trigger
[   97.644343] sysrq: SysRq : Trigger a crash
[   97.650383] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[   97.660345] pgd = 38b1f119
[   97.663206] [00000000] *pgd=96760835, *pte=00000000, *ppte=00000000
[   97.670050] Internal error: Oops: 817 [#1] SMP ARM
[   97.674924] Modules linked in:
[   97.678091] CPU: 0 PID: 139 Comm: sh Not tainted 4.16.0-rc7 #2
[   97.683986] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[   97.690262] PC is at sysrq_handle_crash+0x50/0x9c
[   97.695046] LR is at sysrq_handle_crash+0x50/0x9c
[   97.699817] pc : [<c04ed3e0>]    lr : [<c04ed3e0>]    psr: 60000013
[   97.706154] sp : d677fe30  ip : d677fe30  fp : d677fe44
[   97.711444] r10: 00000002  r9 : 00cbbfb8  r8 : 00000007
[   97.716736] r7 : 00000000  r6 : c1035ab8  r5 : 00000001  r4 : 00000000
[   97.723332] r3 : 00000000  r2 : b11156ce  r1 : 00000002  r0 : 00000000
[   97.729932] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   97.737137] Control: 10c5387d  Table: 9675006a  DAC: 00000051
[   97.742962] Process sh (pid: 139, stack limit = 0x6e0a260c)
[   97.748605] Stack: (0xd677fe30 to 0xd6780000)
[   97.753045] fe20:                                     c101aa30 00000063 d677fe7c d677fe48
[   97.761315] fe40: c04eda00 c04ed39c 00000000 00000000 c04ed928 b11156ce 00000000 00000002
[   97.769584] fe60: 00cbbfb8 00000000 00000000 c1008908 d677fe94 d677fe80 c04ee01c c04ed934
[   97.777854] fe80: d63166c0 c04edfa4 d677feb4 d677fe98 c02a23f0 c04edfb0 d676fdc0 c1008908
[   97.786125] fea0: c02a238c d677ff68 d677ff34 d677feb8 c0236464 c02a2398 d677fedc d677fec8
[   97.794395] fec0: c018c4ec c01706ac c107ab51 d604a1fc d677fef4 d677fee0 c018c8bc c018c478
[   97.802664] fee0: d604a1fc 00000000 d677ff34 d677fef8 c0238594 c018c888 00000001 00000000
[   97.810935] ff00: c023679c b11156ce 00000002 00000002 d676fdc0 00cbbfb8 d677ff68 c1008908
[   97.819204] ff20: 00cbbfb8 00000002 d677ff64 d677ff38 c02366f4 c0236434 00000000 d676fdc0
[   97.827474] ff40: d676fdc0 d676fdc0 00000000 00000000 c1008908 00cbbfb8 d677ffa4 d677ff68
[   97.835743] ff60: c02368fc c0236658 00000000 00000000 ffffffff b11156ce 00000001 000c3c3c
[   97.844011] ff80: 00000001 00cbbfb8 00000004 c01011c4 d677e000 00000000 00000000 d677ffa8
[   97.852280] ffa0: c0101000 c02368b8 000c3c3c 00000001 00000001 00cbbfb8 00000002 00000000
[   97.860548] ffc0: 000c3c3c 00000001 00cbbfb8 00000004 00000001 00000020 00000000 00092380
[   97.868819] ffe0: 000c32f4 be897750 00019c14 b6ecd888 60000010 00000001 9bfde861 9bfdec61
[   97.877051] Backtrace:
[   97.879621] [<c04ed390>] (sysrq_handle_crash) from [<c04eda00>] (__handle_sysrq+0xd8/0x250)
[   97.888048]  r5:00000063 r4:c101aa30
[   97.891719] [<c04ed928>] (__handle_sysrq) from [<c04ee01c>] (write_sysrq_trigger+0x78/0x90)
[   97.900162]  r8:c1008908 r7:00000000 r6:00000000 r5:00cbbfb8 r4:00000002
[   97.906964] [<c04edfa4>] (write_sysrq_trigger) from [<c02a23f0>] (proc_reg_write+0x64/0x8c)
[   97.915388]  r5:c04edfa4 r4:d63166c0
[   97.919069] [<c02a238c>] (proc_reg_write) from [<c0236464>] (__vfs_write+0x3c/0x14c)
[   97.926897]  r7:d677ff68 r6:c02a238c r5:c1008908 r4:d676fdc0
[   97.932654] [<c0236428>] (__vfs_write) from [<c02366f4>] (vfs_write+0xa8/0x170)
[   97.940059]  r10:00000002 r9:00cbbfb8 r8:c1008908 r7:d677ff68 r6:00cbbfb8 r5:d676fdc0
[   97.947952]  r4:00000002
[   97.950582] [<c023664c>] (vfs_write) from [<c02368fc>] (SyS_write+0x50/0xb4)
[   97.957724]  r9:00cbbfb8 r8:c1008908 r7:00000000 r6:00000000 r5:d676fdc0 r4:d676fdc0
[   97.965566] [<c02368ac>] (SyS_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
[   97.973209] Exception stack(0xd677ffa8 to 0xd677fff0)
[   97.978346] ffa0:                   000c3c3c 00000001 00000001 00cbbfb8 00000002 00000000
[   97.986612] ffc0: 000c3c3c 00000001 00cbbfb8 00000004 00000001 00000020 00000000 00092380
[   97.994866] ffe0: 000c32f4 be897750 00019c14 b6ecd888
[   98.000008]  r10:00000000 r9:d677e000 r8:c01011c4 r7:00000004 r6:00cbbfb8 r5:00000001
[   98.007901]  r4:000c3c3c
[   98.010520] Code: e3a04000 e5835000 ee074f9a ebf0ae76 (e5c45000)
[   98.017549] Loading crashdump kernel...
[   98.021956] Bye!
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.16.0-rc7 (arthur at arthur-bzh) (gcc version 5.4.0 (Buildroot 2017.05-git-38202-gb94bcd1-dirty)) #2 SMP Mon Apr 9 10:00:16 CEST 2018
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: Freescale i.MX6 UlltraLite 14x14 EVK Board
[    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x98000000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 64 MiB at 0x9c000000
[    0.000000] crashkernel reservation failed - No suitable area found.
[    0.000000] random: fast init done
[    0.000000] percpu: Embedded 16 pages/cpu @(ptrval) s36136 r8192 d21208 u65536
[    0.000000] Built 1 zonelists, mobility grouping off.  Total pages: 32512
[    0.000000] Kernel command line: console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw crashkernel=50M
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 40516K/131072K available (10240K kernel code, 493K rwdata, 3116K rodata, 1024K init, 7712K bss, 25020K reserved, 65536K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff800000   ( 880 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0x(ptrval) - 0x(ptrval)   (11232 kB)
[    0.000000]       .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
[    0.000000]       .data : 0x(ptrval) - 0x(ptrval)   ( 494 kB)
[    0.000000]        .bss : 0x(ptrval) - 0x(ptrval)   (7713 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU event tracing is enabled.
[    0.000000]  RCU lockdep checking is enabled.
[    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] Switching to timer-based delay loop, resolution 41ns
[    0.000039] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
[    0.000164] clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[    0.005752] Console: colour dummy device 80x30
[    0.005908] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.005994] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.006075] ... MAX_LOCK_DEPTH:          48
[    0.006152] ... MAX_LOCKDEP_KEYS:        8191
[    0.006229] ... CLASSHASH_SIZE:          4096
[    0.006305] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.006382] ... MAX_LOCKDEP_CHAINS:      65536
[    0.006458] ... CHAINHASH_SIZE:          32768
[    0.006535]  memory used by lock dependency info: 4655 kB
[    0.006613]  per task-struct memory footprint: 1536 bytes
[    0.006813] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[    0.006974] pid_max: default: 32768 minimum: 301
[    0.008341] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.008483] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.016759] CPU: Testing write buffer coherency: ok
[    0.020223] /cpus/cpu at 0 missing clock-frequency property
[    0.020368] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.025930] Setting up static identity map for 0x98100000 - 0x98100078
[    0.027909] Hierarchical SRCU implementation.
[    0.034865] smp: Bringing up secondary CPUs ...
[    0.034995] smp: Brought up 1 node, 1 CPU
[    0.035089] SMP: Total of 1 processors activated (48.00 BogoMIPS).
[    0.035172] CPU: All CPU(s) started in SVC mode.
[    0.043532] devtmpfs: initialized
[    0.113484] VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 5
[    0.116597] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.116806] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.129894] pinctrl core: initialized pinctrl subsystem
[    0.145757] NET: Registered protocol family 16
[    0.243835] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.255949] cpuidle: using governor menu
[    0.314869] vdd3p0: supplied by regulator-dummy
[    0.321357] cpu: supplied by regulator-dummy
[    0.327471] vddsoc: supplied by regulator-dummy
[    0.404580] No ATAGs?
[    0.405380] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.405700] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.422291] imx6ul-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
[    0.652747] mxs-dma 1804000.dma-apbh: initialized
[    0.667748] vgaarb: loaded
[    0.672304] SCSI subsystem initialized
[    0.677915] usbcore: registered new interface driver usbfs
[    0.678738] usbcore: registered new interface driver hub
[    0.679802] usbcore: registered new device driver usb
[    0.691773] i2c i2c-1: IMX I2C adapter registered
[    0.691971] i2c i2c-1: can't use DMA, using PIO instead.
[    0.693984] media: Linux media interface: v0.10
[    0.694835] Linux video capture interface: v2.00
[    0.696548] pps_core: LinuxPPS API ver. 1 registered
[    0.696662] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.696932] PTP clock support registered
[    0.700494] Advanced Linux Sound Architecture Driver Initialized.
[    0.711609] Bluetooth: Core ver 2.22
[    0.712158] NET: Registered protocol family 31
[    0.712264] Bluetooth: HCI device and connection manager initialized
[    0.712573] Bluetooth: HCI socket layer initialized
[    0.712739] Bluetooth: L2CAP socket layer initialized
[    0.713384] Bluetooth: SCO socket layer initialized
[    0.720297] clocksource: Switched to clocksource mxc_timer1
[    0.723029] VFS: Disk quotas dquot_6.6.0
[    0.723725] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.843933] NET: Registered protocol family 2
[    0.851780] tcp_listen_portaddr_hash hash table entries: 128 (order: 0, 5120 bytes)
[    0.852217] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.852463] TCP bind hash table entries: 1024 (order: 3, 36864 bytes)
[    0.854423] TCP: Hash tables configured (established 1024 bind 1024)
[    0.855634] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.856792] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.861713] NET: Registered protocol family 1
[    0.869198] RPC: Registered named UNIX socket transport module.
[    0.869451] RPC: Registered udp transport module.
[    0.869549] RPC: Registered tcp transport module.
[    0.869636] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.896606] Initialise system trusted keyrings
[    0.898871] workingset: timestamp_bits=30 max_order=15 bucket_order=0
[    0.978841] NFS: Registering the id_resolver key type
[    0.979272] Key type id_resolver registered
[    0.979518] Key type id_legacy registered
[    0.980453] jffs2: version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
[    0.987498] fuse init (API version 7.26)
[    1.049192] Key type asymmetric registered
[    1.049606] Asymmetric key parser 'x509' registered
[    1.051654] io scheduler noop registered
[    1.051780] io scheduler deadline registered
[    1.053248] io scheduler cfq registered (default)
[    1.053376] io scheduler mq-deadline registered
[    1.053477] io scheduler kyber registered
[    1.077432] pwm-backlight backlight-display: backlight-display supply power not found, using dummy regulator
[    1.088469] mxsfb 21c8000.lcdif: 21c8000.lcdif supply lcd not found, using dummy regulator
[    1.089401] mxsfb 21c8000.lcdif: failed to find display phandle
[    1.092942] mxsfb: probe of 21c8000.lcdif failed with error -2
[    1.106588] imx-sdma 20ec000.sdma: Direct firmware load for imx/sdma/sdma-imx6q.bin failed with error -2
[    1.107146] imx-sdma 20ec000.sdma: external firmware not found, using ROM firmware
[    1.153209] 2020000.serial: ttymxc0 at MMIO 0x2020000 (irq = 19, base_baud = 5000000) is a IMX
[    1.949747] console [ttymxc0] enabled
[    1.967204] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq = 58, base_baud = 5000000) is a IMX
[    2.008218] panel-simple panel: panel supply power not found, using dummy regulator
[    2.142200] brd: module loaded
[    2.251605] loop: module loaded
[    2.279647] fsl-quadspi 21e0000.qspi: n25q256a (32768 Kbytes)
[    2.313340] libphy: Fixed MDIO Bus: probed
[    2.323646] CAN device driver interface
[    2.337116] fec 20b4000.ethernet: 20b4000.ethernet supply phy not found, using dummy regulator
[    2.354010] pps pps0: new PPS source ptp0
[    2.362097] libphy: fec_enet_mii_bus: probed
[    2.390515] fec 20b4000.ethernet eth0: registered PHC device 0
[    2.402420] fec 2188000.ethernet: 2188000.ethernet supply phy not found, using dummy regulator
[    2.418083] pps pps1: new PPS source ptp1
[    2.567075] libphy: fec_enet_mii_bus: probed
[    2.577879] fec 2188000.ethernet eth1: registered PHC device 1
[    2.591196] usbcore: registered new interface driver asix
[    2.597247] usbcore: registered new interface driver ax88179_178a
[    2.604594] usbcore: registered new interface driver cdc_ether
[    2.611427] usbcore: registered new interface driver net1080
[    2.617697] usbcore: registered new interface driver cdc_subset
[    2.624478] usbcore: registered new interface driver zaurus
[    2.631127] usbcore: registered new interface driver cdc_ncm
[    2.636995] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.643945] ehci-pci: EHCI PCI platform driver
[    2.649005] ehci-mxc: Freescale On-Chip EHCI Host driver
[    2.657739] usbcore: registered new interface driver usb-storage
[    2.676820] imx_usb 2184000.usb: 2184000.usb supply vbus not found, using dummy regulator
[    2.707848] imx_usb 2184200.usb: 2184200.usb supply vbus not found, using dummy regulator
[    2.724690] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    2.731059] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 1
[    2.760484] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    2.781259] hub 1-0:1.0: USB hub found
[    2.786515] hub 1-0:1.0: 1 port detected
[    2.815182] input: 20cc000.snvs:snvs-powerkey as /devices/soc0/soc/2000000.aips-bus/20cc000.snvs/20cc000.snvs:snvs-powerkey/input/input0
[    2.843345] input: iMX6UL Touchscreen Controller as /devices/soc0/soc/2000000.aips-bus/2040000.tsc/input/input1
[    2.875631] snvs_rtc 20cc000.snvs:snvs-rtc-lp: rtc core: registered 20cc000.snvs:snvs-rtc-lp as rtc0
[    2.886817] i2c /dev entries driver
[    2.897589] IR NEC protocol handler initialized
[    2.908175] IR RC5(x/sz) protocol handler initialized
[    2.913784] IR RC6 protocol handler initialized
[    2.918522] IR JVC protocol handler initialized
[    2.923462] IR Sony protocol handler initialized
[    2.928271] IR SANYO protocol handler initialized
[    2.933365] IR Sharp protocol handler initialized
[    2.938253] IR MCE Keyboard/mouse protocol handler initialized
[    2.944450] IR XMP protocol handler initialized
[    2.972625] imx2-wdt 20bc000.wdog: timeout 60 sec (nowayout=0)
[    2.979962] Bluetooth: HCI UART driver ver 2.3
[    2.984950] Bluetooth: HCI UART protocol H4 registered
[    2.992033] Bluetooth: HCI UART protocol LL registered
[    3.002078] sdhci: Secure Digital Host Controller Interface driver
[    3.008468] sdhci: Copyright(c) Pierre Ossman
[    3.013257] sdhci-pltfm: SDHCI platform and OF driver helper
[    3.026204] sdhci-esdhc-imx 2190000.usdhc: Got CD GPIO
[    3.077076] mmc0: SDHCI controller on 2190000.usdhc [2190000.usdhc] using ADMA
[    3.129576] mmc1: SDHCI controller on 2194000.usdhc [2194000.usdhc] using ADMA
[    3.164547] usbcore: registered new interface driver usbhid
[    3.170652] usbhid: USB HID core driver
[    3.205588] mmc1: host does not support reading read-only switch, assuming write-enable
[    3.232482] mmc1: new high speed SDHC card at address 0001
[    3.271876] mmcblk1: mmc1:0001 SD8GB 7.24 GiB
[    3.325903]  mmcblk1: p1 p2
[    3.334319] NET: Registered protocol family 10
[    3.369117] Segment Routing with IPv6
[    3.378273] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    3.394259] NET: Registered protocol family 17
[    3.399069] can: controller area network core (rev 20170425 abi 9)
[    3.406554] NET: Registered protocol family 29
[    3.411512] can: raw protocol (rev 20170425)
[    3.416314] can: broadcast manager protocol (rev 20170425 t)
[    3.422547] can: netlink gateway (rev 20170425) max_hops=1
[    3.431564] Key type dns_resolver registered
[    3.455448] Registering SWP/SWPB emulation handler
[    3.473848] Loading compiled-in X.509 certificates
[    3.568479] imx_thermal tempmon: Commercial CPU temperature grade - max:95C critical:90C passive:85C
[    3.589004] asoc-simple-card sound: wm8960-hifi <-> 202c000.sai mapping ok
[    3.746667] snvs_rtc 20cc000.snvs:snvs-rtc-lp: setting system clock to 1970-01-01 00:01:41 UTC (101)
[    3.759849] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    3.775807] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.785144] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    3.794164] cfg80211: failed to load regulatory.db
[    3.799250] VSD_3V3: disabling
[    3.802783] ALSA device list:
[    3.805811]   #0: mx6ul-wm8960
[    3.826671] EXT4-fs (mmcblk1p2): couldn't mount as ext3 due to feature incompatibilities
[    4.042470] EXT4-fs (mmcblk1p2): recovery complete
[    4.054502] EXT4-fs (mmcblk1p2): mounted filesystem with ordered data mode. Opts: (null)
[    4.063081] VFS: Mounted root (ext4 filesystem) on device 179:2.
[    4.089493] devtmpfs: mounted
[    4.098531] Freeing unused kernel memory: 1024K
[    4.337187] EXT4-fs (mmcblk1p2): re-mounted. Opts: errors=remount-ro,data=ordered

I am not able to get dump in /proc/vmcore or /var/crash but this is probably something to configure I guess :

# ls /proc/vmcore /var/crash
ls: /proc/vmcore: No such file or directory
ls: /var/crash: No such file or directory
