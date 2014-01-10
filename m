From: klightspeed@killerwolves.net (Ben Peddell)
Date: Sat, 11 Jan 2014 00:09:11 +1000
Subject: [PATCH RFC RFT 0/2] ARM: Kirkwood: Synology DT files
In-Reply-To: <20140110112846.GG27432@n2100.arm.linux.org.uk>
References: <1389052027-16819-1-git-send-email-andrew@lunn.ch>
 <52CE312B.3060108@killerwolves.net> <20140109165557.GB9681@lunn.ch>
 <52CF4652.3030207@killerwolves.net>
 <20140110112846.GG27432@n2100.arm.linux.org.uk>
Message-ID: <52CFFF07.5080806@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/14 21:28, Russell King - ARM Linux wrote:
> On Fri, Jan 10, 2014 at 11:01:06AM +1000, Ben Peddell wrote:
>> It appears the initrd address in the devicetree structure (which is 
>> filled in from what is passed by the bootloader when 
>> CONFIG_ARM_ATAG_DTB_COMPAT is set) is processed _after_ the address in 
>> the initrd= kernel parameter is processed.
> 
> That's wrong.  Kernel parameters should always override what's passed by
> boot loaders etc.

In that case, what I saw was a bug - note that this only occurs when
DeviceTree is enabled:


         __  __                      _ _
        |  \/  | __ _ _ ____   _____| | |
        | |\/| |/ _` | '__\ \ / / _ \ | |
        | |  | | (_| | |   \ V /  __/ | |
        |_|  |_|\__,_|_|    \_/ \___|_|_|
 _   _     ____              _
| | | |   | __ )  ___   ___ | |_
| | | |___|  _ \ / _ \ / _ \| __|
| |_| |___| |_) | (_) | (_) | |_
 \___/    |____/ \___/ \___/ \__|  ** LOADER **
 ** MARVELL BOARD: Synology Disk Station LE

U-Boot 1.1.4 (Jul  6 2010 - 19:26:08) Marvell version: 3.4.4

U-Boot code: 00600000 -> 0067FFF0  BSS: -> 0068B43C

Soc: 88F6281 A1 (DDR2)
CPU running @ 1200Mhz L2 running @ 480Mhz
SysClock = 400Mhz , TClock = 200Mhz

DRAM CAS Latency = 6 tRP = 6 tRAS = 18 tRCD=6
DRAM CS[0] base 0x00000000   size 128MB
DRAM Total size 128MB  16bit width
[4096kB at f8000000] Flash:  4 MB
Addresses 8M - 0M are saved for the U-Boot usage.
Mem malloc Initialization (8M - 7M): Done
Using default environment


CPU : Marvell Feroceon (Rev 1)

Streaming disabled
Write allocate disabled

Module 1 is AUDIO

USB 0: host mode

Synology Model: DS211j
Fan Status: Good

Net:   egiga0 [PRIME]
Hit any key to stop autoboot:  0
Marvell>> setenv ipaddr 192.168.200.62
Marvell>> setenv serverip 192.168.200.16
Marvell>> tftp 0x01000000 uImage-3.13-rc7-ds211j-git-fdt
Using egiga0 device
TFTP from server 192.168.200.16; our IP address is 192.168.200.62
Filename 'uImage-3.13-rc7-ds211j-git-fdt'.
Load address: 0x1000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #########################################################
done
Bytes transferred = 1954736 (1dd3b0 hex)
Marvell>> setenv bootargs console=ttyS0,115200 ip=off initrd=0x00800040,0x0013FFC0 root=/dev/md0 rw syno_hw_version=DS211j ihd_num=2 netif_num=1 earlyprintk
Marvell>> bootm 0x01000000 0xf8280000
## Booting image at 01000000 ...
Bad Magic Number
Marvell>> tftp 0x01000000 uImage-3.13-rc7-ds211j-git-fdt
Using egiga0 device
TFTP from server 192.168.200.16; our IP address is 192.168.200.62
Filename 'uImage-3.13-rc7-ds211j-git-fdt'.
Load address: 0x1000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #########################################################
done
Bytes transferred = 1954800 (1dd3f0 hex)
Marvell>> bootm 0x01000000 0xf8280000
## Booting image at 01000000 ...
   Image Name:   linux-3.13-rc7-ds211j+
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1954736 Bytes =  1.9 MB
   Load Address: 00008000
   Entry Point:  00008000
   Verifying Checksum ... OK
OK
## Loading Ramdisk Image at f8280000 ...
   Image Name:   altair-boot
   Image Type:   ARM Linux RAMDisk Image (unknown compression)
   Data Size:    1022268 Bytes = 998.3 kB
   Load Address: 00800000
   Entry Point:  00800000
   Verifying Checksum ... OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.13.0-rc7-ds211j+ (root at lurch) (gcc version 4.8.2 (Gentoo 4.8.2 p1.3, pie-0.5.8) ) #2 Thu Jan 9 08:52:24 EST 2014
[    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine model: Synology DS210 v10, v20, v30, DS211j
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] INITRD: 0xf8280040+0x000f993c is not a memory region - disabling initrd
[    0.000000] Memory policy: Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: console=ttyS0,115200 ip=off initrd=0x00800040,0x0013FFC0 root=/dev/md0 rw syno_hw_version=DS211j ihd_num=2 netif_num=1 earlyprintk
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 124716K/131072K available (3466K kernel code, 191K rwdata, 1084K rodata, 166K init, 215K bss, 6356K reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0479d6c   (4552 kB)
[    0.000000]       .init : 0xc047a000 - 0xc04a380c   ( 167 kB)
[    0.000000]       .data : 0xc04a4000 - 0xc04d3e80   ( 192 kB)
[    0.000000]        .bss : 0xc04d3e80 - 0xc0509b30   ( 216 kB)
[    0.000000] NR_IRQS:114
[    0.000000] sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 21474836475ns
[    0.000000] Console: colour dummy device 80x30
[    0.004804] Calibrating delay loop... 1191.11 BogoMIPS (lpj=5955584)
[    0.092919] pid_max: default: 32768 minimum: 301
[    0.097708] Mount-cache hash table entries: 512
[    0.104591] CPU: Testing write buffer coherency: ok
[    0.109822] Setting up static identity map for 0x348060 - 0x3480b8
[    0.117170] devtmpfs: initialized
[    0.121538] xor: measuring software checksum speed
[    0.220035]    arm4regs  :  1084.400 MB/sec
[    0.320030]    8regs     :   651.200 MB/sec
[    0.420029]    32regs    :   901.200 MB/sec
[    0.424280] xor: using function: arm4regs (1084.400 MB/sec)
[    0.429916] pinctrl core: initialized pinctrl subsystem
[    0.436009] regulator-dummy: no parameters
[    0.440606] NET: Registered protocol family 16
[    0.445560] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.455243] cpuidle: using governor ladder
[    0.459410] cpuidle: using governor menu
[    0.463559] Kirkwood: MV88F6281-A1, TCLK=0.
[    0.467921] Feroceon L2: Enabling L2
[    0.471615] Feroceon L2: Cache support initialised, in WT override mode.
[    0.478793] [Firmware Info]: /ocp at f1000000/ethernet-controller at 72000/ethernet0-port at 0: local-mac-address is not set
[    0.494565] No ATAGs?
[    0.507801] bio: create slab <bio-0> at 0
[    0.680061] raid6: int32x1    100 MB/s
[    0.850266] raid6: int32x2    131 MB/s
[    1.020409] raid6: int32x4    123 MB/s
[    1.190124] raid6: int32x8    130 MB/s
[    1.193936] raid6: using algorithm int32x2 (131 MB/s)
[    1.199042] raid6: using intx1 recovery algorithm
[    1.204120] hdd2power: Failed to request enable GPIO31: -517
[    1.209988] reg-fixed-voltage 1.regulator: Failed to register regulator: -517
[    1.217197] platform 1.regulator: Driver reg-fixed-voltage requests probe deferral
[    1.225708] SCSI subsystem initialized
[    1.231520] Switched to clocksource orion_clocksource
[    1.249315] NET: Registered protocol family 2
[    1.254161] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    1.261187] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    1.267625] TCP: Hash tables configured (established 1024 bind 1024)
[    1.274087] TCP: reno registered
[    1.277385] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    1.283303] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    1.289768] NET: Registered protocol family 1
[    1.294402] RPC: Registered named UNIX socket transport module.
[    1.300373] RPC: Registered udp transport module.
[    1.305150] RPC: Registered tcp transport module.
[    1.309911] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.316588] Trying to unpack rootfs image as initramfs...
[    1.322063] Unable to handle kernel paging request at virtual address b8280040
[    1.329334] pgd = c0004000
[    1.332118] [b8280040] *pgd=00000000
[    1.335766] Internal error: Oops: 5 [#1] ARM
[    1.340098] Modules linked in:
[    1.343232] CPU: 0 PID: 1 Comm: swapper Not tainted 3.13.0-rc7-ds211j+ #2
[    1.350072] task: c7839bc0 ti: c783a000 task.ti: c783a000
[    1.355529] PC is at unpack_to_rootfs+0xa8/0x2b0
[    1.360206] LR is at unpack_to_rootfs+0x44/0x2b0
[    1.364883] pc : [<c047c998>]    lr : [<c047c934>]    psr: 20000053
[    1.364883] sp : c783be40  ip : 000008d8  fp : 00000000
[    1.376474] r10: 00000000  r9 : 00000068  r8 : c047d020
[    1.381755] r7 : c049d068  r6 : b8280040  r5 : 000f993c  r4 : c049d068
[    1.388329] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : c7924000
[    1.394905] Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    1.402343] Control: 0005397f  Table: 00004000  DAC: 00000017
[    1.408140] Process swapper (pid: 1, stack limit = 0xc783a1c0)
[    1.414024] Stack: (0xc783be40 to 0xc783c000)
[    1.418446] be40: 00000000 c04a34fc c04d3f00 c047d020 00000000 00000000 c04d3f4c c0343368
[    1.426671] be60: c03f85f6 c04d3f50 00000000 c04a34fc c04d3f00 c047d020 00000068 c04d3f50
[    1.434897] be80: c04d3f4c c047d074 ffffffff 00000000 c04c1b5c c04fffc4 c04c1b5c c049023c
[    1.443121] bea0: 00000068 00000000 c783a038 c0343368 c041909f c783becc 00000020 c783becc
[    1.451346] bec0: 00000000 c049031c c041909f 00000000 00000020 00000005 c049bbc8 c04a34fc
[    1.459572] bee0: c04d3f00 c047d020 00000068 00000000 c783a038 c000869c c782b6a0 c00d89c0
[    1.467797] bf00: c782b700 c782b6a0 00000000 c782b6a0 c034c50c c04f7914 00000000 c00d8c5c
[    1.476023] bf20: 00000068 c060edf7 00000000 c0031dc8 60000053 c0457d84 c0457704 00000068
[    1.484247] bf40: 00000005 00000005 00000001 00000005 c049bbc8 c04a34fc c04d3f00 c04d3f00
[    1.492473] bf60: 00000068 c049bbd8 00000000 c047ab14 00000005 00000005 c047a478 c002f124
[    1.500697] bf80: 00000000 00000000 00000000 c0340fb4 00000000 00000000 00000000 00000000
[    1.508923] bfa0: 00000000 c0340fbc 00000000 c000e050 00000000 00000000 00000000 00000000
[    1.517147] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.525373] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    1.533606] [<c047c998>] (unpack_to_rootfs+0xa8/0x2b0) from [<c047d074>] (populate_rootfs+0x54/0x224)
[    1.542873] [<c047d074>] (populate_rootfs+0x54/0x224) from [<c000869c>] (do_one_initcall+0x94/0x13c)
[    1.552055] [<c000869c>] (do_one_initcall+0x94/0x13c) from [<c047ab14>] (kernel_init_freeable+0xf8/0x1b8)
[    1.561671] [<c047ab14>] (kernel_init_freeable+0xf8/0x1b8) from [<c0340fbc>] (kernel_init+0x8/0x100)
[    1.570852] [<c0340fbc>] (kernel_init+0x8/0x100) from [<c000e050>] (ret_from_fork+0x14/0x24)
[    1.579339] Code: 1a000056 e3550000 0a000054 e1c7a1d0 (e5d63000)
[    1.585525] ---[ end trace 4e31448959d8cde7 ]---
[    1.590212] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    1.590212]
