From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 20 Dec 2017 22:26:04 +0100
Subject: [PATCH 00/12] Marvell NAND controller rework with ->exec_op()
In-Reply-To: <20171218092535.2ca1fe13@xps13> (Miquel RAYNAL's message of "Mon,
 18 Dec 2017 09:25:35 +0100")
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
 <20171214070930.0b885f6d@bbrezillon> <877etkecig.fsf@belgarion.home>
 <20171218092535.2ca1fe13@xps13>
Message-ID: <87y3lxccr7.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Miquel RAYNAL <miquel.raynal@free-electrons.com> writes:

> Hello Robert,
>
> On Mon, 18 Dec 2017 08:11:35 +0100
> Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
>> Boris Brezillon <boris.brezillon@free-electrons.com> writes:
>> 
>> >> Robert, it would be great if you could also do more testing on PXA
>> >> and validate this driver. If needed, a branch ready to be tested is
>> >> available at [3]. It is based on nand/next and has all the changes
>> >> brought by the previously mentionned series as well as this one.  
>> >
>> > Robert, do you think you'll have some time to test Miquel's branch
>> > on your PXA boards? Miquel already tested on one of these boards
>> > (CM-X300), but we'd like to have other testers. Also feel free to
>> > review the driver if have the time.
>> >
>> > Thanks,
>> >
>> > Boris  
>> 
>> Hi Boris and Miquel,
>> 
>> I have applied the whole serie to linux-next yesterday.
>> 
>> A boot attempt on my zylonite with my old defconfig (with the new
>> Marvell NAND config activated) yields to :
>>  - this message
>> [    3.136818] marvell-nfc pxa3xx-nand: could not identify the nand
>> chip [    3.143874] marvell-nfc: probe of pxa3xx-nand failed with
>> error -22
>>  - then my board hangs
>> 
>> Is there something to be done to improve the trace level so that you
>> can guess what's happening ?
>
> Thank you very much for testing this.
>
> Could you please try this branch [1] instead of linux-next + the
> patches?
>
> Also, can you please add #define DEBUG in marvell_nand.c + nand_base.c,
> it should help us figuring out what is wrong.

Done, same result, the dmesg is in [1].

Cheers.

-- 
Robert

[1] Kernel output
Loading ARM Linux zImage '/mnt/tftp/zImage_jenkins'
commandline: ram=64M console=ttyS0,115200 ip=dhcp root=/dev/nfs nfsroot=/home/none/nfsroot/zylonite,v3,tcp earlycon mtdparts=pxa3xx_nand-0:128k at 0(TIMH)ro,128k at 128k(OBMI)ro,768k at 256k(barebox),256k at 1024k(barebox-env),12M at 1280k(kernel),38016k at 13568k(root)
arch_number: 1233
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.15.0-rc1-00041-g4dc0195 (jenkins at belgarath) (gcc version 4.8.3 20140320 (prerelease) (Sourcery CodeBench Lite 2014.05-29)) #721 PREEMPT Wed Dec 20 22:15:08 CET 2017
[    0.000000] CPU: XScale-V3 based processor [69056891] revision 1 (ARMv5TE), cr=0000397f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: PXA3xx Platform Development Kit (aka Zylonite)
[    0.000000] Ignoring tag cmdline (using the default kernel command line)
[    0.000000] Memory policy: Data cache writeback
[    0.000000] RO Mode clock: 0.00MHz
[    0.000000] Run Mode clock: 0.00MHz
[    0.000000] Turbo Mode clock: 0.00MHz
[    0.000000] System bus clock: 0.00MHz
[    0.000000] On node 0 totalpages: 16384
[    0.000000]   Normal zone: 128 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 16384 pages, LIFO batch:3
[    0.000000] random: fast init done
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 16256
[    0.000000] Kernel command line: root=/dev/ram0 ip=192.168.1.232:192.168.1.5::255.255.255.0::eth0:on console=ttyS0,115200 mem=64M mtdparts=pxa3xx_nand-0:128k at 0(TIMH)ro,128k at 128k(OBMI)ro,768k at 256k(barebox),256k at 1024k(barebox-env),12M at 1280k(kernel),38016k at 13568k(root) ubi.mtd=5 earlycon=pxa,io,0xf6200000,115200n8 debug no_console_suspend
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Memory: 56856K/65536K available (4225K kernel code, 202K rwdata, 972K rodata, 2396K init, 102K bss, 8680K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc4800000 - 0xff800000   ( 944 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc04289e8   (4227 kB)
[    0.000000]       .init : 0xc053f000 - 0xc0796000   (2396 kB)
[    0.000000]       .data : 0xc0796000 - 0xc07c8bec   ( 203 kB)
[    0.000000]        .bss : 0xc07c8bec - 0xc07e25fc   ( 103 kB)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] NR_IRQS: 16, nr_irqs: 336, preallocated irqs: 336
[    0.000000] RJK: parent_rate=13000000, xl=8, xn=1
[    0.000069] sched_clock: 32 bits at 3250kHz, resolution 307ns, wraps every 660764198758ns
[    0.000267] clocksource: oscr0: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 588080137591 ns
[    0.002142] Console: colour dummy device 80x30
[    0.002302] Calibrating delay loop... 103.83 BogoMIPS (lpj=519168)
[    0.081019] pid_max: default: 32768 minimum: 301
[    0.081860] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.081960] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.085178] CPU: Testing write buffer coherency: ok
[    0.089002] Setting up static identity map for 0x80008200 - 0x80008260
[    0.089962] Hierarchical SRCU implementation.
[    0.102994] devtmpfs: initialized
[    0.113882] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.114023] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.116361] NET: Registered protocol family 16
[    0.119175] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.389891] Advanced Linux Sound Architecture Driver Initialized.
[    0.394261] clocksource: Switched to clocksource oscr0
[    0.552465] NET: Registered protocol family 2
[    0.559531] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.559757] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.559938] TCP: Hash tables configured (established 1024 bind 1024)
[    0.560478] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.560660] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.561794] NET: Registered protocol family 1
[    0.563834] RPC: Registered named UNIX socket transport module.
[    0.563934] RPC: Registered udp transport module.
[    0.563988] RPC: Registered tcp transport module.
[    0.564046] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.503938] Initialise system trusted keyrings
[    2.506180] workingset: timestamp_bits=30 max_order=14 bucket_order=0
[    2.510083] NFS: Registering the id_resolver key type
[    2.510312] Key type id_resolver registered
[    2.510374] Key type id_legacy registered
[    2.516887] Key type asymmetric registered
[    2.516991] Asymmetric key parser 'x509' registered
[    2.517149] io scheduler noop registered
[    2.517213] io scheduler deadline registered
[    2.517601] io scheduler cfq registered (default)
[    2.517671] io scheduler mq-deadline registered
[    2.517732] io scheduler kyber registered
[    2.577937] pxa-dma pxa-dma.0: initialized 32 channels on 100 requestors
[    2.581363] pxa2xx-uart.0: ttyS0 at MMIO 0x40100000 (irq = 38, base_baud = 928571) is a UART1
[    3.056921] console [ttyS0] enabled
[    3.063284] pxa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq = 37, base_baud = 928571) is a UART2
[    3.076187] pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (irq = 36, base_baud = 928571) is a UART3
[    3.091759] nand: executing subop:
[    3.097924] nand:     ->CMD      [0xff]
[    3.101830] nand:     ->WAITRDY  [max 250 ms]
[    3.106998] marvell-nfc pxa3xx-nand: 
[    3.106998] NDCR:  0x90079fff
[    3.106998] NDCB0: 0x00a000ff
[    3.106998] NDCB1: 0x00000000
[    3.106998] NDCB2: 0x00000000
[    3.106998] NDCB3: 0x00000000
[    3.126261] nand: executing subop:
[    3.129732] nand:     ->CMD      [0x90]
[    3.133605] nand:     ->ADDR     [1 cyc: 00]
[    3.138275] nand:     ->DATA_IN  [2 B, force 8-bit]
[    3.143276] marvell-nfc pxa3xx-nand: 
[    3.143276] NDCR:  0x90079fff
[    3.143276] NDCB0: 0x00610090
[    3.143276] NDCB1: 0x00000000
[    3.143276] NDCB2: 0x00000000
[    3.143276] NDCB3: 0x00000000
[    3.162111] nand: executing subop:
[    3.165754] nand:     ->CMD      [0x90]
[    3.169644] nand:     ->ADDR     [1 cyc: 00]
[    3.173945] nand:     ->DATA_IN  [8 B, force 8-bit]
[    3.179056] marvell-nfc pxa3xx-nand: 
[    3.179056] NDCR:  0x90079fff
[    3.179056] NDCB0: 0x00610090
[    3.179056] NDCB1: 0x00000000
[    3.179056] NDCB2: 0x00000000
[    3.179056] NDCB3: 0x00000000
[    3.197729] nand: executing subop:
[    3.201185] nand:     ->CMD      [0x90]
[    3.205207] nand:     ->ADDR     [1 cyc: 20]
[    3.209519] nand:     ->DATA_IN  [4 B, force 8-bit]
[    3.214626] marvell-nfc pxa3xx-nand: 
[    3.214626] NDCR:  0x90079fff
[    3.214626] NDCB0: 0x00610090
[    3.214626] NDCB1: 0x00000020
[    3.214626] NDCB2: 0x00000000
[    3.214626] NDCB3: 0x00000000
[    3.233249] nand: executing subop:
[    3.236837] nand:     ->CMD      [0x90]
[    3.240719] nand:     ->ADDR     [1 cyc: 40]
[    3.245158] nand:     ->DATA_IN  [5 B, force 8-bit]
[    3.250133] marvell-nfc pxa3xx-nand: 
[    3.250133] NDCR:  0x90079fff
[    3.250133] NDCB0: 0x00610090
[    3.250133] NDCB1: 0x00000040
[    3.250133] NDCB2: 0x00000000
[    3.250133] NDCB3: 0x00000000
[    3.268756] nand: device found, Manufacturer ID: 0x20, Chip ID: 0xba
[    3.275239] nand: ST Micro pxa3xx-nand
[    3.279028] nand: bus width 8 instead of 16 bits
[    3.283651] nand: No NAND device found
[    3.287582] marvell-nfc pxa3xx-nand: could not identify the nand chip
[    3.294466] marvell-nfc: probe of pxa3xx-nand failed with error -22
