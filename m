From: stsp@list.ru (Stas Sergeev)
Date: Wed, 11 Mar 2015 17:33:11 +0300
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <20150311131433.GC8656@n2100.arm.linux.org.uk>
References: <54FF21BE.2040506@list.ru> <550038C9.7010807@free-electrons.com>
 <20150311131433.GC8656@n2100.arm.linux.org.uk>
Message-ID: <55005227.8090408@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

11.03.2015 16:14, Russell King - ARM Linux ?????:
> On Wed, Mar 11, 2015 at 01:44:57PM +0100, Gregory CLEMENT wrote:
>> Hi Stas,
>>
>> On 10/03/2015 17:54, Stas Sergeev wrote:
>>> Hello, the patch below is needed for a successful boot on armada-xp.
>>>
>> I am really surprised by this patch because I used the Armada XP based
>> board in a daily base and I never saw this issue.
> Can you provide some details about your board - does it have 8GB of
> memory, ranging from 0-0xf0000000, and 4G-8G ?
Yes, there should be 8G, here's the boot log from marvell kernel
that boots fine and works fine:

[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.2.58-1-armadaxp (root at host-010-100) (gcc
version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #0 SMP Thu Dec 18 124
[    0.000000] CPU: Marvell - PJ4Bv7 Processor [562f5842] revision 2
(ARMv7), cr=30c73c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction
cache
[    0.000000] Machine: Marvell Armada XP GP Board
[    0.000000] Using UBoot passing parameters structure
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Reserving training memory: base=0x  (null) size=0x2800
[    0.000000] Reserving training memory: base=0x80000000 size=0x2800
[    0.000000] Reserving training memory: base=0xc0000000 size=0x2800
[    0.000000] Reserving training memory: base=0xe0000000 size=0x2800
[    0.000000] MEMBLOCK configuration:
[    0.000000]  memory size = 0x1f0000000
[    0.000000]  memory.cnt  = 0x2
[    0.000000]  memory[0x0]     [0x00000000000000-0x000000efffffff],
0xf0000000 bytes
[    0.000000]  memory[0x1]     [0x00000100000000-0x000001ffffffff],
0x100000000 bytes
[    0.000000]  reserved.cnt  = 0x7
[    0.000000]  reserved[0x0]   [0x00000000000000-0x000000000027ff],
0x2800 bytes
[    0.000000]  reserved[0x1]   [0x00000000003000-0x00000000007fff],
0x5000 bytes
[    0.000000]  reserved[0x2]   [0x000000000081e0-0x000000009ef02f],
0x9e6e50 bytes
[    0.000000]  reserved[0x3]   [0x00000001100040-0x0000000142fad3],
0x32fa94 bytes
[    0.000000]  reserved[0x4]   [0x00000080000000-0x000000800027ff],
0x2800 bytes
[    0.000000]  reserved[0x5]   [0x000000c0000000-0x000000c00027ff],
0x2800 bytes
[    0.000000]  reserved[0x6]   [0x000000e0000000-0x000000e00027ff],
0x2800 bytes
[    0.000000] Memory policy: ECC disabled, Data cache writealloc
[    0.000000] SMP: init cpus
[    0.000000] PERCPU: Embedded 7 pages/cpu @c5442000 s7104 r8192 d13376
u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
Total pages: 2015232
[    0.000000] Kernel command line: console=ttyS0,115200
earlyprintk=ttyS0 root=/dev/sda2 rw pm_disable memblock=debug
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288
bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes)
[    0.000000] allocated 33554432 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't
want memory cgroups
[    0.000000] Memory: 3840MB 4096MB = 7936MB total
[    0.000000] Memory: 8015704k/8015704k available, 110760k reserved,
7299036K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xf3000000 - 0xfa800000   ( 120 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf2800000   ( 808 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc08b4000   (8880 kB)
[    0.000000]       .init : 0xc08b4000 - 0xc08fabc0   ( 283 kB)
[    0.000000]       .data : 0xc08fc000 - 0xc0948a20   ( 307 kB)
[    0.000000]        .bss : 0xc0948a44 - 0xc09ef030   ( 666 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:211
[    0.000000] Initializing ArmadaXP SOC Timer 0
[    0.000000] sched_clock: 32 bits at 25MHz, resolution 40ns, wraps
every 171798ms
[  117.562527] Calibrating delay loop... 1594.16 BogoMIPS (lpj=7970816)
[  117.655298] pid_max: default: 32768 minimum: 301
[  117.660091] Security Framework initialized
[  117.664285] AppArmor: AppArmor initialized
[  117.668578] Mount-cache hash table entries: 512
[  117.673594] Initializing cgroup subsys cpuacct
[  117.678123] Initializing cgroup subsys memory
[  117.682584] Initializing cgroup subsys devices
[  117.687093] Initializing cgroup subsys freezer
[  117.691601] Initializing cgroup subsys net_cls
[  117.696117] Initializing cgroup subsys blkio
[  117.700528] CPU: Testing write buffer coherency: ok
[  117.705627] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[  117.711350] SMP: prepare CPUs (4 cores)
[  117.715539] Setting Clocks for secondary CPUs
[  117.720891] SMP: CPU 0 Waking up CPU 1
[  117.732639] CPU1: Booted secondary processor
[  117.772428] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[  117.772858] SMP: CPU 0 Waking up CPU 2
[  117.794638] CPU2: Booted secondary processor
[  117.832429] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[  117.832864] SMP: CPU 0 Waking up CPU 3
[  117.857151] CPU3: Booted secondary processor
[  117.892429] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[  117.892493] Brought up 4 CPUs
[  117.905580] SMP: Total of 4 processors activated (6376.65 BogoMIPS).
[  117.912745] devtmpfs: initialized
[  117.921130] xor: measuring software checksum speed
[  117.972401]    arm4regs  :  1544.800 MB/sec
[  118.022399]    8regs     :  1147.600 MB/sec
[  118.072399]    32regs    :  1472.000 MB/sec
[  118.076648] xor: using function: arm4regs (1544.800 MB/sec)
[  118.083158] print_constraints: dummy:
[  118.087341] NET: Registered protocol family 16
[  118.092028] ARMADA XP error handling module was loaded
[  118.098986] Aurora: Working in ARMv7 mode
[  118.103086] L0 cache Enabled
[  118.106038] Speculative Prefetch Disabled
[  118.110127] Aurora L2 Cache Enabled
[  118.113963] Support IO coherency.
[  118.220261]
[  118.221830]   Marvell Armada-XP RD-AXP-GP rev 1.0 Board -  Soc:
MV78460 B0 LE
[  118.229060]   Detected Tclk 250000000, SysClk 800000000, FabricClk
800000000, PClk 1600000000
[  118.237634]   LSP version: linux-3.2.58-2014_T2.0
[  118.242407]   Marvell Armada-XP Unique Device ID: 00196621A784C374
(UniqeID_val0: A784C374, UniqeID_val1: 00196621)
[  118.252880]
[  118.255972] Register platform device: mv_neta_port_0
[  118.261098] Register platform device: mv_neta_port_2
[  118.266868] registered dev#0 asa ehci_marvell
[  118.271569] Marvell USB EHCI Host controller #0: f20f4000
[  118.277140] registered dev#1 asa ehci_marvell
[  118.281838] Marvell USB EHCI Host controller #1: f2144e00
[  118.287402] registered dev#2 asa ehci_marvell
[  118.292100] Marvell USB EHCI Host controller #2: f2144c00
[  118.310312] bio: create slab <bio-0> at 0
[  118.482530] raid6: int32x1    182 MB/s
[  118.652535] raid6: int32x2    281 MB/s
[  118.822632] raid6: int32x4    265 MB/s
[  118.992396] raid6: int32x8    309 MB/s
[  118.996216] raid6: using algorithm int32x8 (309 MB/s)
[  119.002219] vgaarb: loaded
[  119.006888] SCSI subsystem initialized
[  119.011362] usbcore: registered new interface driver usbfs
[  119.017071] usbcore: registered new interface driver hub
[  119.022564] usbcore: registered new device driver usb
[  119.029036] NetLabel: Initializing
[  119.032565] NetLabel:  domain hash size = 128
[  119.036985] NetLabel:  protocols = UNLABELED CIPSOv4
[  119.042032] NetLabel:  unlabeled traffic allowed by default
[  119.047954] Switching to clocksource axp_clocksource
[  119.053160] FS-Cache: Loaded
[  119.056149] AppArmor: AppArmor Filesystem Enabled
[  119.062592] NET: Registered protocol family 2
[  119.067119] IP route cache hash table entries: 32768 (order: 5,
131072 bytes)
[  119.074573] TCP established hash table entries: 131072 (order: 8,
1048576 bytes)
[  119.082855] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[  119.089918] TCP: Hash tables configured (established 131072 bind 65536)
[  119.096594] TCP reno registered
[  119.099808] UDP hash table entries: 512 (order: 2, 16384 bytes)
[  119.105806] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[  119.112374] NET: Registered protocol family 1
[  119.116974] RPC: Registered named UNIX socket transport module.
[  119.122951] RPC: Registered udp transport module.
[  119.127726] RPC: Registered tcp transport module.
[  119.132492] RPC: Registered tcp NFSv4.1 backchannel transport module.
[  119.139102] Trying to unpack rootfs image as initramfs...
[  119.257367] Freeing initrd memory: 3260K
[  119.261366] PCI-E: Checking physical bus #0 (controller #8): Enabled
- Link UP
[  119.268817] PCI-E: Checking physical bus #1 (controller #9): Enabled
- No Link
[  119.276801] PCI: bus0: Fast back to back transfers disabled
[  119.282644] pci 0000:00:00.0: BAR 2: assigned [mem
0xf3000000-0xf303ffff 64bit]
[  119.290027] pci 0000:00:00.0: BAR 2: set to [mem
0xf3000000-0xf303ffff 64bit] (PCI address [0xf3000000-0xf303ffff])
[  119.300509] pci 0000:00:00.0: BAR 0: assigned [mem
0xf3040000-0xf305ffff 64bit]
[  119.307883] pci 0000:00:00.0: BAR 0: set to [mem
0xf3040000-0xf305ffff 64bit] (PCI address [0xf3040000-0xf305ffff])
[  119.318367] pci 0000:00:00.0: BAR 6: assigned [mem
0xf3060000-0xf306ffff pref]
