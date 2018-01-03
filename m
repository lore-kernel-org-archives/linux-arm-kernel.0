From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 03 Jan 2018 20:58:29 +0100
Subject: [PATCH 00/12] Marvell NAND controller rework with ->exec_op()
In-Reply-To: <20180103084037.422b239a@xps13> (Miquel RAYNAL's message of "Wed,
 3 Jan 2018 08:40:37 +0100")
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
 <20171214070930.0b885f6d@bbrezillon> <877etkecig.fsf@belgarion.home>
 <20171218092535.2ca1fe13@xps13> <87y3lxccr7.fsf@belgarion.home>
 <20171220224121.2cb6f690@bbrezillon> <87lghucykr.fsf@belgarion.home>
 <20171222222441.0fd77df9@bbrezillon> <20171222233730.68d9cb9d@xps13>
 <87k1xdblxf.fsf@belgarion.home> <20171223155709.2ba16e95@xps13>
 <87fu81bc45.fsf@belgarion.home> <20180102120326.7a2cf1d1@xps13>
 <87d12scbiy.fsf@belgarion.home> <20180103084037.422b239a@xps13>
Message-ID: <878tded89m.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Miquel RAYNAL <miquel.raynal@free-electrons.com> writes:

> On Tue, 02 Jan 2018 20:21:09 +0100
> Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
>> Miquel RAYNAL <miquel.raynal@free-electrons.com> writes:
>> 
>> > I think the ECC issue you faced was related to pages being written
>> > *and* empty. If this guess is right, the board should boot fine with
>> > these changes.
>> >
>> > Otherwise, please add the DEBUG define as before in both the core
>> > and the driver and do not hesitate to add another dump_stack()
>> > where it crashes (if applicable).  
>> 
>> The problem looks still the same :
>> [    3.560163] Bad block table not found for chip 0
>
> Mmmmh ok.
>
> Can you please add this patch:
> http://code.bulix.org/61at9p-254626

Well, it looks a bit better, see attached log in [1].
Now the BBT is detected ...
[    3.310841] Bad block table found at page 131008, version 0x01
...
[    3.354944] Bad block table found at page 130944, version 0x01

But all blocks are considered bad ... as if the bit logic was inverted for the
meaning of "bad" or "good" block, see :
[    3.379825] nand_read_bbt: bad block at 0x000000000000

Cheers.

--
Robert

[1] Dmesg
---8>---
netconsole: port not set
netconsole: registered as netconsole-1
smc91c111 smc91c1110: chip is revision= 9, version= 2
mdio_bus: miibus0: probed
eth0: got preset MAC address: 00:0e:0c:a7:26:f7
nand: NAND device: Manufacturer ID: 0x20, Chip ID: 0xba (ST Micro NAND 256MiB 1,8V 16-bit), 256MiB, page size: 2048, OOB size: 64
mrvl_nand mrvl_nand0: ECC strength 1, ECC step size 512
Bad block table found at page 131008, version 0x01
Bad block table found at page 130944, version 0x01
malloc space: 0x83700000 -> 0x83efffff (size 8 MiB)
running /env/bin/init...
magicvar: No such file or directory
magicvar: No such file or directory
magicvar: No such file or directory

Hit any key to stop autoboot:  3 2 1 0
booting net
netconsole: netconsole initialized with 255.255.255.255:6662
eth0: 100Mbps full duplex link detected
DHCP client bound to address 192.168.1.232
netconsole: netconsole initialized with 255.255.255.255:6662
could not open /mnt/tftp/none-linux-zylonite: No such file or directory
Booting net failed: No such file or directory
booting net failed: No such file or directory
boot: No such file or directory
.[1;32mbarebox at .[1;36mZylonite:/.[0m global linux.bootargs.debug=earlycon
.[1;32mbarebox at .[1;36mZylonite:/.[0m bootm /mnt/tftp/zImage_jenkins

Loading ARM Linux zImage '/mnt/tftp/zImage_jenkins'
commandline: ram=64M console=ttyS0,115200 ip=dhcp root=/dev/nfs nfsroot=/home/none/nfsroot/zylonite,v3,tcp earlycon mtdparts=pxa3xx_nand-0:128k at 0(TIMH)ro,128k at 128k(OBMI)ro,768k at 256k(barebox),256k at 1024k(barebox-env),12M at 1280k(kernel),38016k at 13568k(root)
arch_number: 1233
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.15.0-rc1-00044-gb6124ba (jenkins at belgarath) (gcc version 4.8.3 20140320 (prerelease) (Sourcery CodeBench Lite 2014.05-29)) #825 PREEMPT Wed Jan 3 20:06:17 CET 2018
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
[    0.000068] sched_clock: 32 bits at 3250kHz, resolution 307ns, wraps every 660764198758ns
[    0.000267] clocksource: oscr0: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 588080137591 ns
[    0.002138] Console: colour dummy device 80x30
[    0.002297] Calibrating delay loop... 103.83 BogoMIPS (lpj=519168)
[    0.081017] pid_max: default: 32768 minimum: 301
[    0.081857] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.081957] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.085169] CPU: Testing write buffer coherency: ok
[    0.088982] Setting up static identity map for 0x80008200 - 0x80008260
[    0.089941] Hierarchical SRCU implementation.
[    0.102960] devtmpfs: initialized
[    0.113840] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.113980] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.116305] NET: Registered protocol family 16
[    0.119116] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.388612] Advanced Linux Sound Architecture Driver Initialized.
[    0.392974] clocksource: Switched to clocksource oscr0
[    0.551626] NET: Registered protocol family 2
[    0.557926] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.558151] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.558332] TCP: Hash tables configured (established 1024 bind 1024)
[    0.558869] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.559048] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.560201] NET: Registered protocol family 1
[    0.562229] RPC: Registered named UNIX socket transport module.
[    0.562327] RPC: Registered udp transport module.
[    0.562381] RPC: Registered tcp transport module.
[    0.562439] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.500715] Initialise system trusted keyrings
[    2.502868] workingset: timestamp_bits=30 max_order=14 bucket_order=0
[    2.507406] NFS: Registering the id_resolver key type
[    2.507634] Key type id_resolver registered
[    2.507695] Key type id_legacy registered
[    2.514199] Key type asymmetric registered
[    2.514303] Asymmetric key parser 'x509' registered
[    2.514462] io scheduler noop registered
[    2.514527] io scheduler deadline registered
[    2.514921] io scheduler cfq registered (default)
[    2.514992] io scheduler mq-deadline registered
[    2.515054] io scheduler kyber registered
[    2.572587] pxa-dma pxa-dma.0: initialized 32 channels on 100 requestors
[    2.578330] pxa2xx-uart.0: ttyS0 at MMIO 0x40100000 (irq = 38, base_baud = 928571) is a UART1
[    3.053207] console [ttyS0] enabled
[    3.059557] pxa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq = 37, base_baud = 928571) is a UART2
[    3.072069] pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (irq = 36, base_baud = 928571) is a UART3
[    3.088037] nand: executing subop:
[    3.091533] nand:     ->CMD      [0xff]
[    3.098135] nand:     ->WAITRDY  [max 250 ms]
[    3.102636] marvell-nfc pxa3xx-nand: 
[    3.102636] NDCR:  0x90079fff
[    3.102636] NDCB0: 0x00a000ff
[    3.102636] NDCB1: 0x00000000
[    3.102636] NDCB2: 0x00000000
[    3.102636] NDCB3: 0x00000000
[    3.121629] nand: executing subop:
[    3.125459] nand:     ->CMD      [0x90]
[    3.129362] nand:     ->ADDR     [1 cyc: 00]
[    3.134355] nand:     ->DATA_IN  [2 B, force 8-bit]
[    3.139366] marvell-nfc pxa3xx-nand: 
[    3.139366] NDCR:  0x90079fff
[    3.139366] NDCB0: 0x00610090
[    3.139366] NDCB1: 0x00000000
[    3.139366] NDCB2: 0x00000000
[    3.139366] NDCB3: 0x00000000
[    3.158242] nand: executing subop:
[    3.161713] nand:     ->CMD      [0x90]
[    3.165930] nand:     ->ADDR     [1 cyc: 00]
[    3.170250] nand:     ->DATA_IN  [8 B, force 8-bit]
[    3.175405] marvell-nfc pxa3xx-nand: 
[    3.175405] NDCR:  0x90079fff
[    3.175405] NDCB0: 0x00610090
[    3.175405] NDCB1: 0x00000000
[    3.175405] NDCB2: 0x00000000
[    3.175405] NDCB3: 0x00000000
[    3.194083] nand: executing subop:
[    3.197532] nand:     ->CMD      [0x90]
[    3.201406] nand:     ->ADDR     [1 cyc: 20]
[    3.205851] nand:     ->DATA_IN  [4 B, force 8-bit]
[    3.210832] marvell-nfc pxa3xx-nand: 
[    3.210832] NDCR:  0x90079fff
[    3.210832] NDCB0: 0x00610090
[    3.210832] NDCB1: 0x00000020
[    3.210832] NDCB2: 0x00000000
[    3.210832] NDCB3: 0x00000000
[    3.229453] nand: executing subop:
[    3.232899] nand:     ->CMD      [0x90]
[    3.236930] nand:     ->ADDR     [1 cyc: 40]
[    3.241232] nand:     ->DATA_IN  [5 B, force 8-bit]
[    3.246335] marvell-nfc pxa3xx-nand: 
[    3.246335] NDCR:  0x90079fff
[    3.246335] NDCB0: 0x00610090
[    3.246335] NDCB1: 0x00000040
[    3.246335] NDCB2: 0x00000000
[    3.246335] NDCB3: 0x00000000
[    3.264978] nand: device found, Manufacturer ID: 0x20, Chip ID: 0xba
[    3.271354] nand: ST Micro NAND 256MiB 1,8V 16-bit
[    3.276316] nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    3.284055] marvell-nfc pxa3xx-nand: No minimum ECC strength, using 1b/512B
[    3.291595] marvell-nfc pxa3xx-nand: 
[    3.291595] NDCR:  0xdd079fff
[    3.291595] NDCB0: 0x000d3000
[    3.291595] NDCB1: 0xffc00000
[    3.291595] NDCB2: 0x00000001
[    3.291595] NDCB3: 0x00000000
[    3.310841] Bad block table found at page 131008, version 0x01
[    3.316993] marvell-nfc pxa3xx-nand: 
[    3.316993] NDCR:  0xdd079fff
[    3.316993] NDCB0: 0x000d3000
[    3.316993] NDCB1: 0xffc00000
[    3.316993] NDCB2: 0x00000001
[    3.316993] NDCB3: 0x00000000
[    3.336013] marvell-nfc pxa3xx-nand: 
[    3.336013] NDCR:  0xdd079fff
[    3.336013] NDCB0: 0x000d3000
[    3.336013] NDCB1: 0xff800000
[    3.336013] NDCB2: 0x00000001
[    3.336013] NDCB3: 0x00000000
[    3.354944] Bad block table found at page 130944, version 0x01
[    3.360915] marvell-nfc pxa3xx-nand: 
[    3.360915] NDCR:  0xdd079fff
[    3.360915] NDCB0: 0x000d3000
[    3.360915] NDCB1: 0xffc00000
[    3.360915] NDCB2: 0x00000001
[    3.360915] NDCB3: 0x00000000
[    3.379825] nand_read_bbt: bad block at 0x000000000000
[    3.385158] nand_read_bbt: bad block at 0x000000040000
[    3.390320] nand_read_bbt: bad block at 0x000000060000
[    3.395587] nand_read_bbt: bad block at 0x000000080000
[    3.400743] nand_read_bbt: bad block at 0x0000000a0000
[    3.406009] nand_read_bbt: bad block at 0x0000000c0000
[    3.411169] nand_read_bbt: bad block at 0x0000000e0000
[    3.416434] nand_read_bbt: bad block at 0x000000100000
[    3.421593] nand_read_bbt: bad block at 0x000000140000
[    3.426859] nand_read_bbt: bad block at 0x000000160000
[    3.432018] nand_read_bbt: bad block at 0x000000180000
[    3.437283] nand_read_bbt: bad block at 0x0000001a0000
[    3.442442] nand_read_bbt: bad block at 0x0000001c0000
[    3.447707] nand_read_bbt: bad block at 0x0000001e0000
[    3.452867] nand_read_bbt: bad block at 0x000000200000
[    3.458133] nand_read_bbt: bad block at 0x000000220000
[    3.463404] nand_read_bbt: bad block at 0x000000240000
[    3.468564] nand_read_bbt: bad block at 0x000000260000
[    3.473830] nand_read_bbt: bad block at 0x000000280000
[    3.478990] nand_read_bbt: bad block at 0x0000002a0000
[    3.484253] nand_read_bbt: bad block at 0x0000002c0000
[    3.489414] nand_read_bbt: bad block at 0x0000002e0000
[    3.494680] nand_read_bbt: bad block at 0x000000300000
[    3.499838] nand_read_bbt: bad block at 0x000000320000
[    3.505104] nand_read_bbt: bad block at 0x000000340000
[    3.510262] nand_read_bbt: bad block at 0x000000360000
[    3.515529] nand_read_bbt: bad block at 0x000000380000
[    3.520687] nand_read_bbt: bad block at 0x0000003a0000
[    3.525955] nand_read_bbt: bad block at 0x0000003c0000
[    3.531121] nand_read_bbt: bad block at 0x0000003e0000
[    3.536386] nand_read_bbt: bad block at 0x000000400000
[    3.541544] nand_read_bbt: bad block at 0x000000420000
[    3.546811] nand_read_bbt: bad block at 0x000000440000
[    3.551970] nand_read_bbt: bad block at 0x000000460000
[    3.557234] nand_read_bbt: bad block at 0x000000480000
[    3.562394] nand_read_bbt: bad block at 0x0000004a0000
[    3.567659] nand_read_bbt: bad block at 0x0000004c0000
[    3.572819] nand_read_bbt: bad block at 0x0000004e0000
[    3.578087] nand_read_bbt: bad block at 0x000000500000
[    3.583367] nand_read_bbt: bad block at 0x000000520000
[    3.588524] nand_read_bbt: bad block at 0x000000540000
[    3.593788] nand_read_bbt: bad block at 0x000000560000
[    3.598951] nand_read_bbt: bad block at 0x000000580000
[    3.604213] nand_read_bbt: bad block at 0x0000005a0000
[    3.609373] nand_read_bbt: bad block at 0x0000005c0000
[    3.614639] nand_read_bbt: bad block at 0x0000005e0000
[    3.619799] nand_read_bbt: bad block at 0x000000600000
[    3.625064] nand_read_bbt: bad block at 0x000000620000
[    3.630224] nand_read_bbt: bad block at 0x000000640000
[    3.635488] nand_read_bbt: bad block at 0x000000660000
[    3.640648] nand_read_bbt: bad block at 0x000000680000
[    3.645914] nand_read_bbt: bad block at 0x0000006a0000
[    3.651071] nand_read_bbt: bad block at 0x0000006c0000
[    3.656337] nand_read_bbt: bad block at 0x0000006e0000
[    3.661497] nand_read_bbt: bad block at 0x000000700000
[    3.666774] nand_read_bbt: bad block at 0x000000d40000
[    3.671939] nand_read_bbt: bad block at 0x000000d60000
[    3.677206] nand_read_bbt: bad block at 0x000000d80000
[    3.682373] nand_read_bbt: bad block at 0x000000da0000
[    3.687638] nand_read_bbt: bad block at 0x000000dc0000
[    3.692796] nand_read_bbt: bad block at 0x000000de0000
[    3.698063] nand_read_bbt: bad block at 0x000000e00000
[    3.703334] nand_read_bbt: bad block at 0x000000e20000
[    3.708494] nand_read_bbt: bad block at 0x000000e40000
[    3.713759] nand_read_bbt: bad block at 0x000000e60000
[    3.718919] nand_read_bbt: bad block at 0x000000e80000
[    3.724183] nand_read_bbt: bad block at 0x000000ea0000
[    3.729343] nand_read_bbt: bad block at 0x000000ec0000
[    3.734608] nand_read_bbt: bad block at 0x000000ee0000
[    3.739769] nand_read_bbt: bad block at 0x000000f00000
[    3.745033] nand_read_bbt: bad block at 0x000000f20000
[    3.750192] nand_read_bbt: bad block at 0x000000f40000
[    3.755459] nand_read_bbt: bad block at 0x000000f60000
[    3.760617] nand_read_bbt: bad block at 0x000000f80000
[    3.765882] nand_read_bbt: bad block at 0x000000fa0000
[    3.771041] nand_read_bbt: bad block at 0x000000fc0000
[    3.776306] nand_read_bbt: bad block at 0x000000fe0000
[    3.781467] nand_read_bbt: bad block at 0x000001000000
[    3.786731] nand_read_bbt: bad block at 0x000001020000
[    3.791891] nand_read_bbt: bad block at 0x000001040000
[    3.797156] nand_read_bbt: bad block at 0x000001060000
[    3.802317] nand_read_bbt: bad block at 0x000001080000
[    3.807582] nand_read_bbt: bad block at 0x0000010a0000
[    3.812741] nand_read_bbt: bad block at 0x0000010c0000
[    3.818005] nand_read_bbt: bad block at 0x0000010e0000
[    3.823280] nand_read_bbt: bad block at 0x000001100000
[    3.828438] nand_read_bbt: bad block at 0x000001120000
[    3.833702] nand_read_bbt: bad block at 0x000001140000
[    3.838862] nand_read_bbt: bad block at 0x000001160000
[    3.844129] nand_read_bbt: bad block at 0x000001180000
[    3.849294] nand_read_bbt: bad block at 0x000001660000
[    3.854562] nand_read_bbt: bad block at 0x000001680000
[    3.859719] nand_read_bbt: bad block at 0x0000016a0000
[    3.864986] nand_read_bbt: bad block at 0x0000016c0000
[    3.870143] nand_read_bbt: bad block at 0x0000016e0000
[    3.875409] nand_read_bbt: bad block at 0x000001700000
[    3.880569] nand_read_bbt: bad block at 0x000001720000
[    3.885836] nand_read_bbt: bad block at 0x000001740000
[    3.890994] nand_read_bbt: bad block at 0x000001760000
[    3.896260] nand_read_bbt: bad block at 0x000001780000
[    3.901417] nand_read_bbt: bad block at 0x0000017a0000
[    3.906683] nand_read_bbt: bad block at 0x0000017c0000
[    3.911843] nand_read_bbt: bad block at 0x0000017e0000
[    3.917108] nand_read_bbt: bad block at 0x000001800000
[    3.922267] nand_read_bbt: bad block at 0x000001820000
[    3.927534] nand_read_bbt: bad block at 0x000001840000
[    3.932691] nand_read_bbt: bad block at 0x000001860000
[    3.937957] nand_read_bbt: bad block at 0x000001880000
[    3.943230] nand_read_bbt: bad block at 0x0000018a0000
[    3.948390] nand_read_bbt: bad block at 0x0000018c0000
[    3.953654] nand_read_bbt: bad block at 0x0000018e0000
[    3.958815] nand_read_bbt: bad block at 0x000001900000
[    3.964101] nand_read_bbt: bad block at 0x000001920000
[    3.969264] nand_read_bbt: bad block at 0x000001940000
[    3.974531] nand_read_bbt: bad block at 0x000001960000
[    3.979690] nand_read_bbt: bad block at 0x000001980000
[    3.984952] nand_read_bbt: bad block at 0x0000019a0000
[    3.990114] nand_read_bbt: bad block at 0x0000019c0000
[    3.995381] nand_read_bbt: bad block at 0x0000019e0000
[    4.000539] nand_read_bbt: bad block at 0x000001a00000
[    4.005804] nand_read_bbt: bad block at 0x000001a20000
[    4.010964] nand_read_bbt: bad block at 0x000001a40000
[    4.016236] nand_read_bbt: bad block at 0x000001a60000
[    4.021398] nand_read_bbt: bad block at 0x000001a80000
[    4.026664] nand_read_bbt: bad block at 0x000001aa0000
[    4.031822] nand_read_bbt: bad block at 0x000001ac0000
[    4.037086] nand_read_bbt: bad block at 0x000001ae0000
[    4.042247] nand_read_bbt: bad block at 0x000001b00000
[    4.047512] nand_read_bbt: bad block at 0x000001b20000
[    4.052672] nand_read_bbt: bad block at 0x000001b40000
[    4.057935] nand_read_bbt: bad block at 0x000001b60000
[    4.063211] nand_read_bbt: bad block at 0x000001b80000
[    4.068377] nand_read_bbt: bad block at 0x000001ba0000
[    4.073643] nand_read_bbt: bad block at 0x000001bc0000
[    4.078801] nand_read_bbt: bad block at 0x000001be0000
[    4.084068] nand_read_bbt: bad block at 0x000001c00000
[    4.089235] nand_read_bbt: bad block at 0x000001c20000
[    4.094836] nand_read_bbt: bad block at 0x000001c40000
[    4.100012] nand_read_bbt: bad block at 0x000001c60000
[    4.105327] nand_read_bbt: bad block at 0x000001c80000
[    4.110488] nand_read_bbt: bad block at 0x000001ca0000
[    4.115755] nand_read_bbt: bad block at 0x000001cc0000
[    4.120923] nand_read_bbt: bad block at 0x000001ce0000
[    4.126186] nand_read_bbt: bad block at 0x000001d00000
[    4.131347] nand_read_bbt: bad block at 0x000001d20000
[    4.136610] nand_read_bbt: bad block at 0x000001d40000
[    4.141770] nand_read_bbt: bad block at 0x000001d60000
[    4.147038] nand_read_bbt: bad block at 0x000001d80000
[    4.152204] nand_read_bbt: bad block at 0x000001da0000
[    4.157470] nand_read_bbt: bad block at 0x000001dc0000
[    4.162627] nand_read_bbt: bad block at 0x000001de0000
[    4.167894] nand_read_bbt: bad block at 0x000001e00000
[    4.173167] nand_read_bbt: bad block at 0x000001e20000
[    4.178325] nand_read_bbt: bad block at 0x000001e40000
[    4.183591] nand_read_bbt: bad block at 0x000001e60000
[    4.188752] nand_read_bbt: bad block at 0x000001e80000
[    4.194015] nand_read_bbt: bad block at 0x000001ea0000
[    4.199175] nand_read_bbt: bad block at 0x000001ec0000
[    4.204441] nand_read_bbt: bad block at 0x000001ee0000
[    4.209601] nand_read_bbt: bad block at 0x000001f00000
[    4.214865] nand_read_bbt: bad block at 0x000001f20000
[    4.220024] nand_read_bbt: bad block at 0x000001f40000
[    4.225290] nand_read_bbt: bad block at 0x000001f60000
[    4.230450] nand_read_bbt: bad block at 0x000001f80000
[    4.235713] nand_read_bbt: bad block at 0x000001fa0000
[    4.240874] nand_read_bbt: bad block at 0x000001fc0000
[    4.246138] nand_read_bbt: bad block at 0x000001fe0000
[    4.251299] nand_read_bbt: bad block at 0x000002000000
[    4.256564] nand_read_bbt: bad block at 0x000002020000
[    4.261723] nand_read_bbt: bad block at 0x000002040000
[    4.266988] nand_read_bbt: bad block at 0x000002060000
[    4.272148] nand_read_bbt: bad block at 0x000002080000
[    4.277412] nand_read_bbt: bad block at 0x0000020a0000
[    4.282572] nand_read_bbt: bad block at 0x0000020c0000
[    4.287837] nand_read_bbt: bad block at 0x0000020e0000
[    4.293111] nand_read_bbt: bad block at 0x000002100000
[    4.298278] nand_read_bbt: bad block at 0x000002120000
[    4.303545] nand_read_bbt: bad block at 0x000002140000
[    4.308703] nand_read_bbt: bad block at 0x000002160000
[    4.313967] nand_read_bbt: bad block at 0x000002180000
[    4.319128] nand_read_bbt: bad block at 0x0000021a0000
[    4.324391] nand_read_bbt: bad block at 0x0000021c0000
[    4.329552] nand_read_bbt: bad block at 0x0000021e0000
[    4.334818] nand_read_bbt: bad block at 0x000002200000
[    4.339977] nand_read_bbt: bad block at 0x000002220000
[    4.345242] nand_read_bbt: bad block at 0x000002240000
[    4.350402] nand_read_bbt: bad block at 0x000002260000
[    4.355667] nand_read_bbt: bad block at 0x000002280000
[    4.360826] nand_read_bbt: bad block at 0x0000022a0000
[    4.366091] nand_read_bbt: bad block at 0x0000022c0000
[    4.371251] nand_read_bbt: bad block at 0x0000022e0000
[    4.376515] nand_read_bbt: bad block at 0x000002300000
[    4.381674] nand_read_bbt: bad block at 0x000002320000
[    4.386941] nand_read_bbt: bad block at 0x000002340000
[    4.392101] nand_read_bbt: bad block at 0x000002360000
[    4.397365] nand_read_bbt: bad block at 0x000002380000
[    4.402523] nand_read_bbt: bad block at 0x0000023a0000
[    4.407789] nand_read_bbt: bad block at 0x0000023c0000
[    4.413062] nand_read_bbt: bad block at 0x0000023e0000
[    4.418223] nand_read_bbt: bad block at 0x000002400000
[    4.423485] nand_read_bbt: bad block at 0x000002420000
[    4.428646] nand_read_bbt: bad block at 0x000002440000
[    4.433907] nand_read_bbt: bad block at 0x000002460000
[    4.439071] nand_read_bbt: bad block at 0x000002480000
[    4.444336] nand_read_bbt: bad block at 0x0000024a0000
[    4.449496] nand_read_bbt: bad block at 0x0000024c0000
[    4.454759] nand_read_bbt: bad block at 0x0000024e0000
[    4.459922] nand_read_bbt: bad block at 0x000002500000
[    4.465187] nand_read_bbt: bad block at 0x000002520000
[    4.470344] nand_read_bbt: bad block at 0x000002540000
[    4.475609] nand_read_bbt: bad block at 0x000002560000
[    4.480771] nand_read_bbt: bad block at 0x000002580000
[    4.486033] nand_read_bbt: bad block at 0x0000025a0000
[    4.491194] nand_read_bbt: bad block at 0x0000025c0000
[    4.496458] nand_read_bbt: bad block at 0x0000025e0000
[    4.501619] nand_read_bbt: bad block at 0x000002600000
[    4.506882] nand_read_bbt: bad block at 0x000002620000
[    4.512042] nand_read_bbt: bad block at 0x000002640000
[    4.517307] nand_read_bbt: bad block at 0x000002660000
[    4.522468] nand_read_bbt: bad block at 0x000002680000
[    4.527732] nand_read_bbt: bad block at 0x0000026a0000
[    4.532891] nand_read_bbt: bad block at 0x0000026c0000
[    4.538162] nand_read_bbt: bad block at 0x0000026e0000
[    4.543428] nand_read_bbt: bad block at 0x000002700000
[    4.548590] nand_read_bbt: bad block at 0x000002720000
[    4.553857] nand_read_bbt: bad block at 0x000002740000
[    4.559014] nand_read_bbt: bad block at 0x000002760000
[    4.564280] nand_read_bbt: bad block at 0x000002780000
[    4.569438] nand_read_bbt: bad block at 0x0000027a0000
[    4.574705] nand_read_bbt: bad block at 0x0000027c0000
[    4.579863] nand_read_bbt: bad block at 0x0000027e0000
[    4.585129] nand_read_bbt: bad block at 0x000002800000
[    4.590288] nand_read_bbt: bad block at 0x000002820000
[    4.595558] nand_read_bbt: bad block at 0x000002a40000
[    4.600720] nand_read_bbt: bad block at 0x000002a60000
[    4.606012] nand_read_bbt: bad block at 0x000002bc0000
[    4.611182] nand_read_bbt: bad block at 0x000002c40000
[    4.616449] nand_read_bbt: bad block at 0x000002c60000
[    4.621614] nand_read_bbt: bad block at 0x000002c80000
[    4.626878] nand_read_bbt: bad block at 0x000002ca0000
[    4.632036] nand_read_bbt: bad block at 0x000002cc0000
[    4.637301] nand_read_bbt: bad block at 0x000002ce0000
[    4.642463] nand_read_bbt: bad block at 0x000002d00000
[    4.647726] nand_read_bbt: bad block at 0x000002d20000
[    4.652888] nand_read_bbt: bad block at 0x000002d40000
[    4.658167] nand_read_bbt: bad block at 0x000002d60000
[    4.663433] nand_read_bbt: bad block at 0x000002d80000
[    4.668593] nand_read_bbt: bad block at 0x000002da0000
[    4.673859] nand_read_bbt: bad block at 0x000002dc0000
[    4.679017] nand_read_bbt: bad block at 0x000002de0000
[    4.684282] nand_read_bbt: bad block at 0x000002e00000
[    4.689442] nand_read_bbt: bad block at 0x000002e20000
[    4.694707] nand_read_bbt: bad block at 0x000002e40000
[    4.699867] nand_read_bbt: bad block at 0x000002e60000
[    4.705133] nand_read_bbt: bad block at 0x000002e80000
[    4.710292] nand_read_bbt: bad block at 0x000002ea0000
[    4.715558] nand_read_bbt: bad block at 0x000002ec0000
[    4.720716] nand_read_bbt: bad block at 0x000002ee0000
[    4.725983] nand_read_bbt: bad block at 0x000002f00000
[    4.731141] nand_read_bbt: bad block at 0x000002f20000
[    4.736406] nand_read_bbt: bad block at 0x000002f40000
[    4.741566] nand_read_bbt: bad block at 0x000002f60000
[    4.746830] nand_read_bbt: bad block at 0x000002f80000
[    4.751991] nand_read_bbt: bad block at 0x000002fa0000
[    4.757255] nand_read_bbt: bad block at 0x000002fc0000
[    4.762415] nand_read_bbt: bad block at 0x000002fe0000
[    4.767681] nand_read_bbt: bad block at 0x000003000000
[    4.772839] nand_read_bbt: bad block at 0x000003020000
[    4.778104] nand_read_bbt: bad block at 0x000003040000
[    4.783378] nand_read_bbt: bad block at 0x000003060000
[    4.788536] nand_read_bbt: bad block at 0x000003080000
[    4.793802] nand_read_bbt: bad block at 0x0000030a0000
[    4.798962] nand_read_bbt: bad block at 0x0000030c0000
[    4.804224] nand_read_bbt: bad block at 0x0000030e0000
[    4.809387] nand_read_bbt: bad block at 0x000003100000
[    4.814650] nand_read_bbt: bad block at 0x000003120000
[    4.819809] nand_read_bbt: bad block at 0x000003140000
[    4.825075] nand_read_bbt: bad block at 0x000003160000
[    4.830235] nand_read_bbt: bad block at 0x000003180000
[    4.835499] nand_read_bbt: bad block at 0x0000031a0000
[    4.840661] nand_read_bbt: bad block at 0x0000031c0000
[    4.845924] nand_read_bbt: bad block at 0x0000031e0000
[    4.851085] nand_read_bbt: bad block at 0x000003200000
[    4.856350] nand_read_bbt: bad block at 0x000003220000
[    4.861510] nand_read_bbt: bad block at 0x000003240000
[    4.867593] 6 cmdlinepart partitions found on MTD device pxa3xx_nand-0
[    4.874441] Creating 6 MTD partitions on "pxa3xx_nand-0":
[    4.879899] 0x000000000000-0x000000020000 : "TIMH"
[    4.888233] 0x000000020000-0x000000040000 : "OBMI"
[    4.897663] 0x000000040000-0x000000100000 : "barebox"
[    4.907444] 0x000000100000-0x000000140000 : "barebox-env"
[    4.917447] 0x000000140000-0x000000d40000 : "kernel"
[    4.927958] 0x000000d40000-0x000003260000 : "root"
[    4.941349] smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@fluxnic.net>
[    4.994377] smc91x smc91x.0 eth0: SMC91C11xFD (rev 2) at c4867300 IRQ 214
[    5.001216]  DMA c386d710 [nowait]
[    5.005891] smc91x smc91x.0 eth0: Ethernet addr: 00:0e:0c:a7:26:f7
[    5.018621] input: pxa27x-keypad as /devices/platform/pxa27x-keypad/input/input0
[    5.028503] pxa-rtc pxa-rtc: failed to find rtc clock source
[    5.036108] rtc rtc0: invalid alarm value: 0-1-1 0:0:0
[    5.043390] pxa-rtc pxa-rtc: rtc core: registered pxa-rtc as rtc0
[    5.054574] sa1100_wdt: SA1100/PXA2xx Watchdog Timer: timer margin 60 sec
[    5.106260] soc-audio soc-audio: ASoC: machine Zylonite should use snd_soc_register_card()
[    5.130166] wm9713-codec wm9713-codec: Control not supported for path Mic B Source -> [MPB] -> Mic B Pre Amp
[    5.141137] wm9713-codec wm9713-codec: ASoC: no dapm match for Mic B Source --> MPB --> Mic B Pre Amp
[    5.150835] wm9713-codec wm9713-codec: ASoC: Failed to add route Mic B Source -> MPB -> Mic B Pre Amp
[    5.164361] soc-audio soc-audio: wm9713-hifi <-> pxa2xx-ac97 mapping ok
[    5.172711] soc-audio soc-audio: wm9713-aux <-> pxa2xx-ac97-aux mapping ok
[    5.183377] soc-audio soc-audio: wm9713-voice <-> pxa-ssp-dai.2 mapping ok
[    5.191817] wm9713-codec wm9713-codec: ASoC: mux Sidetone Mux has no paths
[    5.232193] NET: Registered protocol family 17
[    5.238583] Key type dns_resolver registered
[    5.244879] XScale iWMMXt coprocessor detected.
[    5.257208] Loading compiled-in X.509 certificates
[    5.277841] ubi0: attaching mtd5
[    5.282062] marvell-nfc pxa3xx-nand: 
[    5.282062] NDCR:  0xdd079fff
[    5.282062] NDCB0: 0x000d3000
[    5.282062] NDCB1: 0x23400000
[    5.282062] NDCB2: 0x00000000
[    5.282062] NDCB3: 0x00000000
[    5.302767] marvell-nfc pxa3xx-nand: 
[    5.302767] NDCR:  0xdd079fff
[    5.302767] NDCB0: 0x000d3000
[    5.302767] NDCB1: 0x23410000
[    5.302767] NDCB2: 0x00000000
[    5.302767] NDCB3: 0x00000000
[    5.322069] marvell-nfc pxa3xx-nand: 
[    5.322069] NDCR:  0x9d079fff
[    5.322069] NDCB0: 0x000d3000
[    5.322069] NDCB1: 0x23410000
[    5.322069] NDCB2: 0x00000000
[    5.322069] NDCB3: 0x00000000
[    5.341520] marvell-nfc pxa3xx-nand: 
[    5.341520] NDCR:  0xdd079fff
[    5.341520] NDCB0: 0x000d3000
[    5.341520] NDCB1: 0x23800000
[    5.341520] NDCB2: 0x00000000
[    5.341520] NDCB3: 0x00000000
[    5.361115] marvell-nfc pxa3xx-nand: 
[    5.361115] NDCR:  0xdd079fff
[    5.361115] NDCB0: 0x000d3000
[    5.361115] NDCB1: 0x23810000
[    5.361115] NDCB2: 0x00000000
[    5.361115] NDCB3: 0x00000000
[    5.380361] marvell-nfc pxa3xx-nand: 
[    5.380361] NDCR:  0x9d079fff
[    5.380361] NDCB0: 0x000d3000
[    5.380361] NDCB1: 0x23810000
[    5.380361] NDCB2: 0x00000000
[    5.380361] NDCB3: 0x00000000
[    5.399699] marvell-nfc pxa3xx-nand: 
[    5.399699] NDCR:  0xdd079fff
[    5.399699] NDCB0: 0x000d3000
[    5.399699] NDCB1: 0x23c00000
[    5.399699] NDCB2: 0x00000000
[    5.399699] NDCB3: 0x00000000
[    5.418790] marvell-nfc pxa3xx-nand: 
[    5.418790] NDCR:  0xdd079fff
[    5.418790] NDCB0: 0x000d3000
[    5.418790] NDCB1: 0x23c10000
[    5.418790] NDCB2: 0x00000000
[    5.418790] NDCB3: 0x00000000
[    5.437771] marvell-nfc pxa3xx-nand: 
[    5.437771] NDCR:  0x9d079fff
[    5.437771] NDCB0: 0x000d3000
[    5.437771] NDCB1: 0x23c10000
[    5.437771] NDCB2: 0x00000000
[    5.437771] NDCB3: 0x00000000
[    5.456876] marvell-nfc pxa3xx-nand: 
[    5.456876] NDCR:  0xdd079fff
[    5.456876] NDCB0: 0x000d3000
[    5.456876] NDCB1: 0x24000000
[    5.456876] NDCB2: 0x00000000
[    5.456876] NDCB3: 0x00000000
[    5.475940] marvell-nfc pxa3xx-nand: 
[    5.475940] NDCR:  0xdd079fff
[    5.475940] NDCB0: 0x000d3000
[    5.475940] NDCB1: 0x24010000
[    5.475940] NDCB2: 0x00000000
[    5.475940] NDCB3: 0x00000000
[    5.494922] marvell-nfc pxa3xx-nand: 
[    5.494922] NDCR:  0x9d079fff
[    5.494922] NDCB0: 0x000d3000
[    5.494922] NDCB1: 0x24010000
[    5.494922] NDCB2: 0x00000000
[    5.494922] NDCB3: 0x00000000
[    5.514028] marvell-nfc pxa3xx-nand: 
[    5.514028] NDCR:  0xdd079fff
[    5.514028] NDCB0: 0x000d3000
[    5.514028] NDCB1: 0x24400000
[    5.514028] NDCB2: 0x00000000
[    5.514028] NDCB3: 0x00000000
[    5.533183] marvell-nfc pxa3xx-nand: 
[    5.533183] NDCR:  0xdd079fff
[    5.533183] NDCB0: 0x000d3000
[    5.533183] NDCB1: 0x24410000
[    5.533183] NDCB2: 0x00000000
[    5.533183] NDCB3: 0x00000000
[    5.552166] marvell-nfc pxa3xx-nand: 
[    5.552166] NDCR:  0x9d079fff
[    5.552166] NDCB0: 0x000d3000
[    5.552166] NDCB1: 0x24410000
[    5.552166] NDCB2: 0x00000000
[    5.552166] NDCB3: 0x00000000
[    5.571273] marvell-nfc pxa3xx-nand: 
[    5.571273] NDCR:  0xdd079fff
[    5.571273] NDCB0: 0x000d3000
[    5.571273] NDCB1: 0x24800000
[    5.571273] NDCB2: 0x00000000
[    5.571273] NDCB3: 0x00000000
[    5.590337] marvell-nfc pxa3xx-nand: 
[    5.590337] NDCR:  0xdd079fff
[    5.590337] NDCB0: 0x000d3000
[    5.590337] NDCB1: 0x24810000
[    5.590337] NDCB2: 0x00000000
[    5.590337] NDCB3: 0x00000000
[    5.609318] marvell-nfc pxa3xx-nand: 
[    5.609318] NDCR:  0x9d079fff
[    5.609318] NDCB0: 0x000d3000
[    5.609318] NDCB1: 0x24810000
[    5.609318] NDCB2: 0x00000000
[    5.609318] NDCB3: 0x00000000
[    5.628426] marvell-nfc pxa3xx-nand: 
[    5.628426] NDCR:  0xdd079fff
[    5.628426] NDCB0: 0x000d3000
[    5.628426] NDCB1: 0x24c00000
[    5.628426] NDCB2: 0x00000000
[    5.628426] NDCB3: 0x00000000
[    5.647489] marvell-nfc pxa3xx-nand: 
[    5.647489] NDCR:  0xdd079fff
[    5.647489] NDCB0: 0x000d3000
[    5.647489] NDCB1: 0x24c10000
[    5.647489] NDCB2: 0x00000000
[    5.647489] NDCB3: 0x00000000
[    5.666475] marvell-nfc pxa3xx-nand: 
[    5.666475] NDCR:  0x9d079fff
[    5.666475] NDCB0: 0x000d3000
[    5.666475] NDCB1: 0x24c10000
[    5.666475] NDCB2: 0x00000000
[    5.666475] NDCB3: 0x00000000
[    5.685575] marvell-nfc pxa3xx-nand: 
[    5.685575] NDCR:  0xdd079fff
[    5.685575] NDCB0: 0x000d3000
[    5.685575] NDCB1: 0x25000000
[    5.685575] NDCB2: 0x00000000
[    5.685575] NDCB3: 0x00000000
[    5.704632] marvell-nfc pxa3xx-nand: 
[    5.704632] NDCR:  0xdd079fff
[    5.704632] NDCB0: 0x000d3000
[    5.704632] NDCB1: 0x25010000
[    5.704632] NDCB2: 0x00000000
[    5.704632] NDCB3: 0x00000000
[    5.723609] marvell-nfc pxa3xx-nand: 
[    5.723609] NDCR:  0x9d079fff
[    5.723609] NDCB0: 0x000d3000
[    5.723609] NDCB1: 0x25010000
[    5.723609] NDCB2: 0x00000000
[    5.723609] NDCB3: 0x00000000
[    5.742713] marvell-nfc pxa3xx-nand: 
[    5.742713] NDCR:  0xdd079fff
[    5.742713] NDCB0: 0x000d3000
[    5.742713] NDCB1: 0x25400000
[    5.742713] NDCB2: 0x00000000
[    5.742713] NDCB3: 0x00000000
[    5.761769] marvell-nfc pxa3xx-nand: 
[    5.761769] NDCR:  0xdd079fff
[    5.761769] NDCB0: 0x000d3000
[    5.761769] NDCB1: 0x25410000
[    5.761769] NDCB2: 0x00000000
[    5.761769] NDCB3: 0x00000000
[    5.780750] marvell-nfc pxa3xx-nand: 
[    5.780750] NDCR:  0x9d079fff
[    5.780750] NDCB0: 0x000d3000
[    5.780750] NDCB1: 0x25410000
[    5.780750] NDCB2: 0x00000000
[    5.780750] NDCB3: 0x00000000
[    5.799855] marvell-nfc pxa3xx-nand: 
[    5.799855] NDCR:  0xdd079fff
[    5.799855] NDCB0: 0x000d3000
[    5.799855] NDCB1: 0x25800000
[    5.799855] NDCB2: 0x00000000
[    5.799855] NDCB3: 0x00000000
[    5.818918] marvell-nfc pxa3xx-nand: 
[    5.818918] NDCR:  0xdd079fff
[    5.818918] NDCB0: 0x000d3000
[    5.818918] NDCB1: 0x25810000
[    5.818918] NDCB2: 0x00000000
[    5.818918] NDCB3: 0x00000000
[    5.837903] marvell-nfc pxa3xx-nand: 
[    5.837903] NDCR:  0x9d079fff
[    5.837903] NDCB0: 0x000d3000
[    5.837903] NDCB1: 0x25810000
[    5.837903] NDCB2: 0x00000000
[    5.837903] NDCB3: 0x00000000
[    5.857009] marvell-nfc pxa3xx-nand: 
[    5.857009] NDCR:  0xdd079fff
[    5.857009] NDCB0: 0x000d3000
[    5.857009] NDCB1: 0x25c00000
[    5.857009] NDCB2: 0x00000000
[    5.857009] NDCB3: 0x00000000
[    5.876071] marvell-nfc pxa3xx-nand: 
[    5.876071] NDCR:  0xdd079fff
[    5.876071] NDCB0: 0x000d3000
[    5.876071] NDCB1: 0x25c10000
[    5.876071] NDCB2: 0x00000000
[    5.876071] NDCB3: 0x00000000
[    5.895047] marvell-nfc pxa3xx-nand: 
[    5.895047] NDCR:  0x9d079fff
[    5.895047] NDCB0: 0x000d3000
[    5.895047] NDCB1: 0x25c10000
[    5.895047] NDCB2: 0x00000000
[    5.895047] NDCB3: 0x00000000
[    5.914152] marvell-nfc pxa3xx-nand: 
[    5.914152] NDCR:  0xdd079fff
[    5.914152] NDCB0: 0x000d3000
[    5.914152] NDCB1: 0x26000000
[    5.914152] NDCB2: 0x00000000
[    5.914152] NDCB3: 0x00000000
[    5.933285] marvell-nfc pxa3xx-nand: 
[    5.933285] NDCR:  0xdd079fff
[    5.933285] NDCB0: 0x000d3000
[    5.933285] NDCB1: 0x26010000
[    5.933285] NDCB2: 0x00000000
[    5.933285] NDCB3: 0x00000000
[    5.952247] marvell-nfc pxa3xx-nand: 
[    5.952247] NDCR:  0x9d079fff
[    5.952247] NDCB0: 0x000d3000
[    5.952247] NDCB1: 0x26010000
[    5.952247] NDCB2: 0x00000000
[    5.952247] NDCB3: 0x00000000
[    5.971354] marvell-nfc pxa3xx-nand: 
[    5.971354] NDCR:  0xdd079fff
[    5.971354] NDCB0: 0x000d3000
[    5.971354] NDCB1: 0x26400000
[    5.971354] NDCB2: 0x00000000
[    5.971354] NDCB3: 0x00000000
[    5.990415] marvell-nfc pxa3xx-nand: 
[    5.990415] NDCR:  0xdd079fff
[    5.990415] NDCB0: 0x000d3000
[    5.990415] NDCB1: 0x26410000
[    5.990415] NDCB2: 0x00000000
[    5.990415] NDCB3: 0x00000000
[    6.009391] marvell-nfc pxa3xx-nand: 
[    6.009391] NDCR:  0x9d079fff
[    6.009391] NDCB0: 0x000d3000
[    6.009391] NDCB1: 0x26410000
[    6.009391] NDCB2: 0x00000000
[    6.009391] NDCB3: 0x00000000
[    6.028510] marvell-nfc pxa3xx-nand: 
[    6.028510] NDCR:  0xdd079fff
[    6.028510] NDCB0: 0x000d3000
[    6.028510] NDCB1: 0x26800000
[    6.028510] NDCB2: 0x00000000
[    6.028510] NDCB3: 0x00000000
[    6.047572] marvell-nfc pxa3xx-nand: 
[    6.047572] NDCR:  0xdd079fff
[    6.047572] NDCB0: 0x000d3000
[    6.047572] NDCB1: 0x26810000
[    6.047572] NDCB2: 0x00000000
[    6.047572] NDCB3: 0x00000000
[    6.066553] marvell-nfc pxa3xx-nand: 
[    6.066553] NDCR:  0x9d079fff
[    6.066553] NDCB0: 0x000d3000
[    6.066553] NDCB1: 0x26810000
[    6.066553] NDCB2: 0x00000000
[    6.066553] NDCB3: 0x00000000
[    6.085662] marvell-nfc pxa3xx-nand: 
[    6.085662] NDCR:  0xdd079fff
[    6.085662] NDCB0: 0x000d3000
[    6.085662] NDCB1: 0x26c00000
[    6.085662] NDCB2: 0x00000000
[    6.085662] NDCB3: 0x00000000
[    6.105275] marvell-nfc pxa3xx-nand: 
[    6.105275] NDCR:  0xdd079fff
[    6.105275] NDCB0: 0x000d3000
[    6.105275] NDCB1: 0x26c10000
[    6.105275] NDCB2: 0x00000000
[    6.105275] NDCB3: 0x00000000
[    6.124291] marvell-nfc pxa3xx-nand: 
[    6.124291] NDCR:  0x9d079fff
[    6.124291] NDCB0: 0x000d3000
[    6.124291] NDCB1: 0x26c10000
[    6.124291] NDCB2: 0x00000000
[    6.124291] NDCB3: 0x00000000
[    6.143431] marvell-nfc pxa3xx-nand: 
[    6.143431] NDCR:  0xdd079fff
[    6.143431] NDCB0: 0x000d3000
[    6.143431] NDCB1: 0x27000000
[    6.143431] NDCB2: 0x00000000
[    6.143431] NDCB3: 0x00000000
[    6.162492] marvell-nfc pxa3xx-nand: 
[    6.162492] NDCR:  0xdd079fff
[    6.162492] NDCB0: 0x000d3000
[    6.162492] NDCB1: 0x27010000
[    6.162492] NDCB2: 0x00000000
[    6.162492] NDCB3: 0x00000000
[    6.181482] marvell-nfc pxa3xx-nand: 
[    6.181482] NDCR:  0x9d079fff
[    6.181482] NDCB0: 0x000d3000
[    6.181482] NDCB1: 0x27010000
[    6.181482] NDCB2: 0x00000000
[    6.181482] NDCB3: 0x00000000
[    6.200594] marvell-nfc pxa3xx-nand: 
[    6.200594] NDCR:  0xdd079fff
[    6.200594] NDCB0: 0x000d3000
[    6.200594] NDCB1: 0x27400000
[    6.200594] NDCB2: 0x00000000
[    6.200594] NDCB3: 0x00000000
[    6.219651] marvell-nfc pxa3xx-nand: 
[    6.219651] NDCR:  0xdd079fff
[    6.219651] NDCB0: 0x000d3000
[    6.219651] NDCB1: 0x27410000
[    6.219651] NDCB2: 0x00000000
[    6.219651] NDCB3: 0x00000000
[    6.238628] marvell-nfc pxa3xx-nand: 
[    6.238628] NDCR:  0x9d079fff
[    6.238628] NDCB0: 0x000d3000
[    6.238628] NDCB1: 0x27410000
[    6.238628] NDCB2: 0x00000000
[    6.238628] NDCB3: 0x00000000
[    6.257763] marvell-nfc pxa3xx-nand: 
[    6.257763] NDCR:  0xdd079fff
[    6.257763] NDCB0: 0x000d3000
[    6.257763] NDCB1: 0x27800000
[    6.257763] NDCB2: 0x00000000
[    6.257763] NDCB3: 0x00000000
[    6.276826] marvell-nfc pxa3xx-nand: 
[    6.276826] NDCR:  0xdd079fff
[    6.276826] NDCB0: 0x000d3000
[    6.276826] NDCB1: 0x27810000
[    6.276826] NDCB2: 0x00000000
[    6.276826] NDCB3: 0x00000000
[    6.295914] marvell-nfc pxa3xx-nand: 
[    6.295914] NDCR:  0xdd079fff
[    6.295914] NDCB0: 0x000d3000
[    6.295914] NDCB1: 0x27c00000
[    6.295914] NDCB2: 0x00000000
[    6.295914] NDCB3: 0x00000000
[    6.314978] marvell-nfc pxa3xx-nand: 
[    6.314978] NDCR:  0xdd079fff
[    6.314978] NDCB0: 0x000d3000
[    6.314978] NDCB1: 0x27c10000
[    6.314978] NDCB2: 0x00000000
[    6.314978] NDCB3: 0x00000000
[    6.333957] marvell-nfc pxa3xx-nand: 
[    6.333957] NDCR:  0x9d079fff
[    6.333957] NDCB0: 0x000d3000
[    6.333957] NDCB1: 0x27c10000
[    6.333957] NDCB2: 0x00000000
[    6.333957] NDCB3: 0x00000000
[    6.353164] marvell-nfc pxa3xx-nand: 
[    6.353164] NDCR:  0xdd079fff
[    6.353164] NDCB0: 0x000d3000
[    6.353164] NDCB1: 0x28000000
[    6.353164] NDCB2: 0x00000000
[    6.353164] NDCB3: 0x00000000
[    6.372184] marvell-nfc pxa3xx-nand: 
[    6.372184] NDCR:  0xdd079fff
[    6.372184] NDCB0: 0x000d3000
[    6.372184] NDCB1: 0x28010000
[    6.372184] NDCB2: 0x00000000
[    6.372184] NDCB3: 0x00000000
[    6.391168] marvell-nfc pxa3xx-nand: 
[    6.391168] NDCR:  0x9d079fff
[    6.391168] NDCB0: 0x000d3000
[    6.391168] NDCB1: 0x28010000
[    6.391168] NDCB2: 0x00000000
[    6.391168] NDCB3: 0x00000000
[    6.410268] marvell-nfc pxa3xx-nand: 
[    6.410268] NDCR:  0xdd079fff
[    6.410268] NDCB0: 0x000d3000
[    6.410268] NDCB1: 0x28400000
[    6.410268] NDCB2: 0x00000000
[    6.410268] NDCB3: 0x00000000
[    6.429335] marvell-nfc pxa3xx-nand: 
[    6.429335] NDCR:  0xdd079fff
[    6.429335] NDCB0: 0x000d3000
[    6.429335] NDCB1: 0x28410000
[    6.429335] NDCB2: 0x00000000
[    6.429335] NDCB3: 0x00000000
[    6.448408] marvell-nfc pxa3xx-nand: 
[    6.448408] NDCR:  0xdd079fff
[    6.448408] NDCB0: 0x000d3000
[    6.448408] NDCB1: 0x28800000
[    6.448408] NDCB2: 0x00000000
[    6.448408] NDCB3: 0x00000000
[    6.467471] marvell-nfc pxa3xx-nand: 
[    6.467471] NDCR:  0xdd079fff
[    6.467471] NDCB0: 0x000d3000
[    6.467471] NDCB1: 0x28810000
[    6.467471] NDCB2: 0x00000000
[    6.467471] NDCB3: 0x00000000
[    6.486456] marvell-nfc pxa3xx-nand: 
[    6.486456] NDCR:  0x9d079fff
[    6.486456] NDCB0: 0x000d3000
[    6.486456] NDCB1: 0x28810000
[    6.486456] NDCB2: 0x00000000
[    6.486456] NDCB3: 0x00000000
[    6.505554] marvell-nfc pxa3xx-nand: 
[    6.505554] NDCR:  0xdd079fff
[    6.505554] NDCB0: 0x000d3000
[    6.505554] NDCB1: 0x28c00000
[    6.505554] NDCB2: 0x00000000
[    6.505554] NDCB3: 0x00000000
[    6.524610] marvell-nfc pxa3xx-nand: 
[    6.524610] NDCR:  0xdd079fff
[    6.524610] NDCB0: 0x000d3000
[    6.524610] NDCB1: 0x28c10000
[    6.524610] NDCB2: 0x00000000
[    6.524610] NDCB3: 0x00000000
[    6.543589] marvell-nfc pxa3xx-nand: 
[    6.543589] NDCR:  0x9d079fff
[    6.543589] NDCB0: 0x000d3000
[    6.543589] NDCB1: 0x28c10000
[    6.543589] NDCB2: 0x00000000
[    6.543589] NDCB3: 0x00000000
[    6.562688] marvell-nfc pxa3xx-nand: 
[    6.562688] NDCR:  0xdd079fff
[    6.562688] NDCB0: 0x000d3000
[    6.562688] NDCB1: 0x29000000
[    6.562688] NDCB2: 0x00000000
[    6.562688] NDCB3: 0x00000000
[    6.581750] marvell-nfc pxa3xx-nand: 
[    6.581750] NDCR:  0xdd079fff
[    6.581750] NDCB0: 0x000d3000
[    6.581750] NDCB1: 0x29010000
[    6.581750] NDCB2: 0x00000000
[    6.581750] NDCB3: 0x00000000
[    6.600735] marvell-nfc pxa3xx-nand: 
[    6.600735] NDCR:  0x9d079fff
[    6.600735] NDCB0: 0x000d3000
[    6.600735] NDCB1: 0x29010000
[    6.600735] NDCB2: 0x00000000
[    6.600735] NDCB3: 0x00000000
[    6.619839] marvell-nfc pxa3xx-nand: 
[    6.619839] NDCR:  0xdd079fff
[    6.619839] NDCB0: 0x000d3000
[    6.619839] NDCB1: 0x29400000
[    6.619839] NDCB2: 0x00000000
[    6.619839] NDCB3: 0x00000000
[    6.638902] marvell-nfc pxa3xx-nand: 
[    6.638902] NDCR:  0xdd079fff
[    6.638902] NDCB0: 0x000d3000
[    6.638902] NDCB1: 0x29410000
[    6.638902] NDCB2: 0x00000000
[    6.638902] NDCB3: 0x00000000
[    6.657879] marvell-nfc pxa3xx-nand: 
[    6.657879] NDCR:  0x9d079fff
[    6.657879] NDCB0: 0x000d3000
[    6.657879] NDCB1: 0x29410000
[    6.657879] NDCB2: 0x00000000
[    6.657879] NDCB3: 0x00000000
[    6.676983] marvell-nfc pxa3xx-nand: 
[    6.676983] NDCR:  0xdd079fff
[    6.676983] NDCB0: 0x000d3000
[    6.676983] NDCB1: 0x29800000
[    6.676983] NDCB2: 0x00000000
[    6.676983] NDCB3: 0x00000000
[    6.696050] marvell-nfc pxa3xx-nand: 
[    6.696050] NDCR:  0xdd079fff
[    6.696050] NDCB0: 0x000d3000
[    6.696050] NDCB1: 0x29810000
[    6.696050] NDCB2: 0x00000000
[    6.696050] NDCB3: 0x00000000
[    6.715033] marvell-nfc pxa3xx-nand: 
[    6.715033] NDCR:  0x9d079fff
[    6.715033] NDCB0: 0x000d3000
[    6.715033] NDCB1: 0x29810000
[    6.715033] NDCB2: 0x00000000
[    6.715033] NDCB3: 0x00000000
[    6.734141] marvell-nfc pxa3xx-nand: 
[    6.734141] NDCR:  0xdd079fff
[    6.734141] NDCB0: 0x000d3000
[    6.734141] NDCB1: 0x29c00000
[    6.734141] NDCB2: 0x00000000
[    6.734141] NDCB3: 0x00000000
[    6.753291] marvell-nfc pxa3xx-nand: 
[    6.753291] NDCR:  0xdd079fff
[    6.753291] NDCB0: 0x000d3000
[    6.753291] NDCB1: 0x29c10000
[    6.753291] NDCB2: 0x00000000
[    6.753291] NDCB3: 0x00000000
[    6.772264] marvell-nfc pxa3xx-nand: 
[    6.772264] NDCR:  0x9d079fff
[    6.772264] NDCB0: 0x000d3000
[    6.772264] NDCB1: 0x29c10000
[    6.772264] NDCB2: 0x00000000
[    6.772264] NDCB3: 0x00000000
[    6.791367] marvell-nfc pxa3xx-nand: 
[    6.791367] NDCR:  0xdd079fff
[    6.791367] NDCB0: 0x000d3000
[    6.791367] NDCB1: 0x2a000000
[    6.791367] NDCB2: 0x00000000
[    6.791367] NDCB3: 0x00000000
[    6.810425] marvell-nfc pxa3xx-nand: 
[    6.810425] NDCR:  0xdd079fff
[    6.810425] NDCB0: 0x000d3000
[    6.810425] NDCB1: 0x2a010000
[    6.810425] NDCB2: 0x00000000
[    6.810425] NDCB3: 0x00000000
[    6.829403] marvell-nfc pxa3xx-nand: 
[    6.829403] NDCR:  0x9d079fff
[    6.829403] NDCB0: 0x000d3000
[    6.829403] NDCB1: 0x2a010000
[    6.829403] NDCB2: 0x00000000
[    6.829403] NDCB3: 0x00000000
[    6.848512] marvell-nfc pxa3xx-nand: 
[    6.848512] NDCR:  0xdd079fff
[    6.848512] NDCB0: 0x000d3000
[    6.848512] NDCB1: 0x2a400000
[    6.848512] NDCB2: 0x00000000
[    6.848512] NDCB3: 0x00000000
[    6.867573] marvell-nfc pxa3xx-nand: 
[    6.867573] NDCR:  0xdd079fff
[    6.867573] NDCB0: 0x000d3000
[    6.867573] NDCB1: 0x2a410000
[    6.867573] NDCB2: 0x00000000
[    6.867573] NDCB3: 0x00000000
[    6.886550] marvell-nfc pxa3xx-nand: 
[    6.886550] NDCR:  0x9d079fff
[    6.886550] NDCB0: 0x000d3000
[    6.886550] NDCB1: 0x2a410000
[    6.886550] NDCB2: 0x00000000
[    6.886550] NDCB3: 0x00000000
[    6.905653] marvell-nfc pxa3xx-nand: 
[    6.905653] NDCR:  0xdd079fff
[    6.905653] NDCB0: 0x000d3000
[    6.905653] NDCB1: 0x2a800000
[    6.905653] NDCB2: 0x00000000
[    6.905653] NDCB3: 0x00000000
[    6.924720] marvell-nfc pxa3xx-nand: 
[    6.924720] NDCR:  0xdd079fff
[    6.924720] NDCB0: 0x000d3000
[    6.924720] NDCB1: 0x2a810000
[    6.924720] NDCB2: 0x00000000
[    6.924720] NDCB3: 0x00000000
[    6.943704] marvell-nfc pxa3xx-nand: 
[    6.943704] NDCR:  0x9d079fff
[    6.943704] NDCB0: 0x000d3000
[    6.943704] NDCB1: 0x2a810000
[    6.943704] NDCB2: 0x00000000
[    6.943704] NDCB3: 0x00000000
[    6.962806] marvell-nfc pxa3xx-nand: 
[    6.962806] NDCR:  0xdd079fff
[    6.962806] NDCB0: 0x000d3000
[    6.962806] NDCB1: 0x2ac00000
[    6.962806] NDCB2: 0x00000000
[    6.962806] NDCB3: 0x00000000
[    6.981868] marvell-nfc pxa3xx-nand: 
[    6.981868] NDCR:  0xdd079fff
[    6.981868] NDCB0: 0x000d3000
[    6.981868] NDCB1: 0x2ac10000
[    6.981868] NDCB2: 0x00000000
[    6.981868] NDCB3: 0x00000000
[    7.000848] marvell-nfc pxa3xx-nand: 
[    7.000848] NDCR:  0x9d079fff
[    7.000848] NDCB0: 0x000d3000
[    7.000848] NDCB1: 0x2ac10000
[    7.000848] NDCB2: 0x00000000
[    7.000848] NDCB3: 0x00000000
[    7.019966] marvell-nfc pxa3xx-nand: 
[    7.019966] NDCR:  0xdd079fff
[    7.019966] NDCB0: 0x000d3000
[    7.019966] NDCB1: 0x2b000000
[    7.019966] NDCB2: 0x00000000
[    7.019966] NDCB3: 0x00000000
[    7.039028] marvell-nfc pxa3xx-nand: 
[    7.039028] NDCR:  0xdd079fff
[    7.039028] NDCB0: 0x000d3000
[    7.039028] NDCB1: 0x2b010000
[    7.039028] NDCB2: 0x00000000
[    7.039028] NDCB3: 0x00000000
[    7.058002] marvell-nfc pxa3xx-nand: 
[    7.058002] NDCR:  0x9d079fff
[    7.058002] NDCB0: 0x000d3000
[    7.058002] NDCB1: 0x2b010000
[    7.058002] NDCB2: 0x00000000
[    7.058002] NDCB3: 0x00000000
[    7.077109] marvell-nfc pxa3xx-nand: 
[    7.077109] NDCR:  0xdd079fff
[    7.077109] NDCB0: 0x000d3000
[    7.077109] NDCB1: 0x2b400000
[    7.077109] NDCB2: 0x00000000
[    7.077109] NDCB3: 0x00000000
[    7.096173] marvell-nfc pxa3xx-nand: 
[    7.096173] NDCR:  0xdd079fff
[    7.096173] NDCB0: 0x000d3000
[    7.096173] NDCB1: 0x2b410000
[    7.096173] NDCB2: 0x00000000
[    7.096173] NDCB3: 0x00000000
[    7.115153] marvell-nfc pxa3xx-nand: 
[    7.115153] NDCR:  0x9d079fff
[    7.115153] NDCB0: 0x000d3000
[    7.115153] NDCB1: 0x2b410000
[    7.115153] NDCB2: 0x00000000
[    7.115153] NDCB3: 0x00000000
[    7.134255] marvell-nfc pxa3xx-nand: 
[    7.134255] NDCR:  0xdd079fff
[    7.134255] NDCB0: 0x000d3000
[    7.134255] NDCB1: 0x2b800000
[    7.134255] NDCB2: 0x00000000
[    7.134255] NDCB3: 0x00000000
[    7.153307] marvell-nfc pxa3xx-nand: 
[    7.153307] NDCR:  0xdd079fff
[    7.153307] NDCB0: 0x000d3000
[    7.153307] NDCB1: 0x2b810000
[    7.153307] NDCB2: 0x00000000
[    7.153307] NDCB3: 0x00000000
[    7.172279] marvell-nfc pxa3xx-nand: 
[    7.172279] NDCR:  0x9d079fff
[    7.172279] NDCB0: 0x000d3000
[    7.172279] NDCB1: 0x2b810000
[    7.172279] NDCB2: 0x00000000
[    7.172279] NDCB3: 0x00000000
[    7.191385] marvell-nfc pxa3xx-nand: 
[    7.191385] NDCR:  0xdd079fff
[    7.191385] NDCB0: 0x000d3000
[    7.191385] NDCB1: 0x2bc00000
[    7.191385] NDCB2: 0x00000000
[    7.191385] NDCB3: 0x00000000
[    7.210447] marvell-nfc pxa3xx-nand: 
[    7.210447] NDCR:  0xdd079fff
[    7.210447] NDCB0: 0x000d3000
[    7.210447] NDCB1: 0x2bc10000
[    7.210447] NDCB2: 0x00000000
[    7.210447] NDCB3: 0x00000000
[    7.229426] marvell-nfc pxa3xx-nand: 
[    7.229426] NDCR:  0x9d079fff
[    7.229426] NDCB0: 0x000d3000
[    7.229426] NDCB1: 0x2bc10000
[    7.229426] NDCB2: 0x00000000
[    7.229426] NDCB3: 0x00000000
[    7.248529] marvell-nfc pxa3xx-nand: 
[    7.248529] NDCR:  0xdd079fff
[    7.248529] NDCB0: 0x000d3000
[    7.248529] NDCB1: 0x2c000000
[    7.248529] NDCB2: 0x00000000
[    7.248529] NDCB3: 0x00000000
[    7.267597] marvell-nfc pxa3xx-nand: 
[    7.267597] NDCR:  0xdd079fff
[    7.267597] NDCB0: 0x000d3000
[    7.267597] NDCB1: 0x2c010000
[    7.267597] NDCB2: 0x00000000
[    7.267597] NDCB3: 0x00000000
[    7.286579] marvell-nfc pxa3xx-nand: 
[    7.286579] NDCR:  0x9d079fff
[    7.286579] NDCB0: 0x000d3000
[    7.286579] NDCB1: 0x2c010000
[    7.286579] NDCB2: 0x00000000
[    7.286579] NDCB3: 0x00000000
[    7.305683] marvell-nfc pxa3xx-nand: 
[    7.305683] NDCR:  0xdd079fff
[    7.305683] NDCB0: 0x000d3000
[    7.305683] NDCB1: 0x2c400000
[    7.305683] NDCB2: 0x00000000
[    7.305683] NDCB3: 0x00000000
[    7.324747] marvell-nfc pxa3xx-nand: 
[    7.324747] NDCR:  0xdd079fff
[    7.324747] NDCB0: 0x000d3000
[    7.324747] NDCB1: 0x2c410000
[    7.324747] NDCB2: 0x00000000
[    7.324747] NDCB3: 0x00000000
[    7.343743] marvell-nfc pxa3xx-nand: 
[    7.343743] NDCR:  0x9d079fff
[    7.343743] NDCB0: 0x000d3000
[    7.343743] NDCB1: 0x2c410000
[    7.343743] NDCB2: 0x00000000
[    7.343743] NDCB3: 0x00000000
[    7.362843] marvell-nfc pxa3xx-nand: 
[    7.362843] NDCR:  0xdd079fff
[    7.362843] NDCB0: 0x000d3000
[    7.362843] NDCB1: 0x2c800000
[    7.362843] NDCB2: 0x00000000
[    7.362843] NDCB3: 0x00000000
[    7.381905] marvell-nfc pxa3xx-nand: 
[    7.381905] NDCR:  0xdd079fff
[    7.381905] NDCB0: 0x000d3000
[    7.381905] NDCB1: 0x2c810000
[    7.381905] NDCB2: 0x00000000
[    7.381905] NDCB3: 0x00000000
[    7.400887] marvell-nfc pxa3xx-nand: 
[    7.400887] NDCR:  0x9d079fff
[    7.400887] NDCB0: 0x000d3000
[    7.400887] NDCB1: 0x2c810000
[    7.400887] NDCB2: 0x00000000
[    7.400887] NDCB3: 0x00000000
[    7.420884] marvell-nfc pxa3xx-nand: 
[    7.420884] NDCR:  0xdd079fff
[    7.420884] NDCB0: 0x000d3000
[    7.420884] NDCB1: 0x50800000
[    7.420884] NDCB2: 0x00000000
[    7.420884] NDCB3: 0x00000000
[    7.439944] marvell-nfc pxa3xx-nand: 
[    7.439944] NDCR:  0xdd079fff
[    7.439944] NDCB0: 0x000d3000
[    7.439944] NDCB1: 0x50810000
[    7.439944] NDCB2: 0x00000000
[    7.439944] NDCB3: 0x00000000
[    7.458920] marvell-nfc pxa3xx-nand: 
[    7.458920] NDCR:  0x9d079fff
[    7.458920] NDCB0: 0x000d3000
[    7.458920] NDCB1: 0x50810000
[    7.458920] NDCB2: 0x00000000
[    7.458920] NDCB3: 0x00000000
[    7.478025] marvell-nfc pxa3xx-nand: 
[    7.478025] NDCR:  0xdd079fff
[    7.478025] NDCB0: 0x000d3000
[    7.478025] NDCB1: 0x50c00000
[    7.478025] NDCB2: 0x00000000
[    7.478025] NDCB3: 0x00000000
[    7.497089] marvell-nfc pxa3xx-nand: 
[    7.497089] NDCR:  0xdd079fff
[    7.497089] NDCB0: 0x000d3000
[    7.497089] NDCB1: 0x50c10000
[    7.497089] NDCB2: 0x00000000
[    7.497089] NDCB3: 0x00000000
[    7.516067] marvell-nfc pxa3xx-nand: 
[    7.516067] NDCR:  0x9d079fff
[    7.516067] NDCB0: 0x000d3000
[    7.516067] NDCB1: 0x50c10000
[    7.516067] NDCB2: 0x00000000
[    7.516067] NDCB3: 0x00000000
[    7.535172] marvell-nfc pxa3xx-nand: 
[    7.535172] NDCR:  0xdd079fff
[    7.535172] NDCB0: 0x000d3000
[    7.535172] NDCB1: 0x51000000
[    7.535172] NDCB2: 0x00000000
[    7.535172] NDCB3: 0x00000000
[    7.554233] marvell-nfc pxa3xx-nand: 
[    7.554233] NDCR:  0xdd079fff
[    7.554233] NDCB0: 0x000d3000
[    7.554233] NDCB1: 0x51010000
[    7.554233] NDCB2: 0x00000000
[    7.554233] NDCB3: 0x00000000
[    7.573238] marvell-nfc pxa3xx-nand: 
[    7.573238] NDCR:  0x9d079fff
[    7.573238] NDCB0: 0x000d3000
[    7.573238] NDCB1: 0x51010000
[    7.573238] NDCB2: 0x00000000
[    7.573238] NDCB3: 0x00000000
[    7.592334] marvell-nfc pxa3xx-nand: 
[    7.592334] NDCR:  0xdd079fff
[    7.592334] NDCB0: 0x000d3000
[    7.592334] NDCB1: 0x51400000
[    7.592334] NDCB2: 0x00000000
[    7.592334] NDCB3: 0x00000000
[    7.611401] marvell-nfc pxa3xx-nand: 
[    7.611401] NDCR:  0xdd079fff
[    7.611401] NDCB0: 0x000d3000
[    7.611401] NDCB1: 0x51410000
[    7.611401] NDCB2: 0x00000000
[    7.611401] NDCB3: 0x00000000
[    7.630384] marvell-nfc pxa3xx-nand: 
[    7.630384] NDCR:  0x9d079fff
[    7.630384] NDCB0: 0x000d3000
[    7.630384] NDCB1: 0x51410000
[    7.630384] NDCB2: 0x00000000
[    7.630384] NDCB3: 0x00000000
[    7.649492] marvell-nfc pxa3xx-nand: 
[    7.649492] NDCR:  0xdd079fff
[    7.649492] NDCB0: 0x000d3000
[    7.649492] NDCB1: 0x51800000
[    7.649492] NDCB2: 0x00000000
[    7.649492] NDCB3: 0x00000000
[    7.668554] marvell-nfc pxa3xx-nand: 
[    7.668554] NDCR:  0xdd079fff
[    7.668554] NDCB0: 0x000d3000
[    7.668554] NDCB1: 0x51810000
[    7.668554] NDCB2: 0x00000000
[    7.668554] NDCB3: 0x00000000
[    7.687527] marvell-nfc pxa3xx-nand: 
[    7.687527] NDCR:  0x9d079fff
[    7.687527] NDCB0: 0x000d3000
[    7.687527] NDCB1: 0x51810000
[    7.687527] NDCB2: 0x00000000
[    7.687527] NDCB3: 0x00000000
[    7.706637] marvell-nfc pxa3xx-nand: 
[    7.706637] NDCR:  0xdd079fff
[    7.706637] NDCB0: 0x000d3000
[    7.706637] NDCB1: 0x51c00000
[    7.706637] NDCB2: 0x00000000
[    7.706637] NDCB3: 0x00000000
[    7.725697] marvell-nfc pxa3xx-nand: 
[    7.725697] NDCR:  0xdd079fff
[    7.725697] NDCB0: 0x000d3000
[    7.725697] NDCB1: 0x51c10000
[    7.725697] NDCB2: 0x00000000
[    7.725697] NDCB3: 0x00000000
[    7.744674] marvell-nfc pxa3xx-nand: 
[    7.744674] NDCR:  0x9d079fff
[    7.744674] NDCB0: 0x000d3000
[    7.744674] NDCB1: 0x51c10000
[    7.744674] NDCB2: 0x00000000
[    7.744674] NDCB3: 0x00000000
[    7.763781] marvell-nfc pxa3xx-nand: 
[    7.763781] NDCR:  0xdd079fff
[    7.763781] NDCB0: 0x000d3000
[    7.763781] NDCB1: 0x52000000
[    7.763781] NDCB2: 0x00000000
[    7.763781] NDCB3: 0x00000000
[    7.782838] marvell-nfc pxa3xx-nand: 
[    7.782838] NDCR:  0xdd079fff
[    7.782838] NDCB0: 0x000d3000
[    7.782838] NDCB1: 0x52010000
[    7.782838] NDCB2: 0x00000000
[    7.782838] NDCB3: 0x00000000
[    7.801814] marvell-nfc pxa3xx-nand: 
[    7.801814] NDCR:  0x9d079fff
[    7.801814] NDCB0: 0x000d3000
[    7.801814] NDCB1: 0x52010000
[    7.801814] NDCB2: 0x00000000
[    7.801814] NDCB3: 0x00000000
[    7.820919] marvell-nfc pxa3xx-nand: 
[    7.820919] NDCR:  0xdd079fff
[    7.820919] NDCB0: 0x000d3000
[    7.820919] NDCB1: 0x52400000
[    7.820919] NDCB2: 0x00000000
[    7.820919] NDCB3: 0x00000000
[    7.839984] marvell-nfc pxa3xx-nand: 
[    7.839984] NDCR:  0xdd079fff
[    7.839984] NDCB0: 0x000d3000
[    7.839984] NDCB1: 0x52410000
[    7.839984] NDCB2: 0x00000000
[    7.839984] NDCB3: 0x00000000
[    7.858968] marvell-nfc pxa3xx-nand: 
[    7.858968] NDCR:  0x9d079fff
[    7.858968] NDCB0: 0x000d3000
[    7.858968] NDCB1: 0x52410000
[    7.858968] NDCB2: 0x00000000
[    7.858968] NDCB3: 0x00000000
[    7.878070] marvell-nfc pxa3xx-nand: 
[    7.878070] NDCR:  0xdd079fff
[    7.878070] NDCB0: 0x000d3000
[    7.878070] NDCB1: 0x52800000
[    7.878070] NDCB2: 0x00000000
[    7.878070] NDCB3: 0x00000000
[    7.897127] marvell-nfc pxa3xx-nand: 
[    7.897127] NDCR:  0xdd079fff
[    7.897127] NDCB0: 0x000d3000
[    7.897127] NDCB1: 0x52810000
[    7.897127] NDCB2: 0x00000000
[    7.897127] NDCB3: 0x00000000
[    7.916104] marvell-nfc pxa3xx-nand: 
[    7.916104] NDCR:  0x9d079fff
[    7.916104] NDCB0: 0x000d3000
[    7.916104] NDCB1: 0x52810000
[    7.916104] NDCB2: 0x00000000
[    7.916104] NDCB3: 0x00000000
[    7.935231] marvell-nfc pxa3xx-nand: 
[    7.935231] NDCR:  0xdd079fff
[    7.935231] NDCB0: 0x000d3000
[    7.935231] NDCB1: 0x52c00000
[    7.935231] NDCB2: 0x00000000
[    7.935231] NDCB3: 0x00000000
[    7.954292] marvell-nfc pxa3xx-nand: 
[    7.954292] NDCR:  0xdd079fff
[    7.954292] NDCB0: 0x000d3000
[    7.954292] NDCB1: 0x52c10000
[    7.954292] NDCB2: 0x00000000
[    7.954292] NDCB3: 0x00000000
[    7.973328] marvell-nfc pxa3xx-nand: 
[    7.973328] NDCR:  0x9d079fff
[    7.973328] NDCB0: 0x000d3000
[    7.973328] NDCB1: 0x52c10000
[    7.973328] NDCB2: 0x00000000
[    7.973328] NDCB3: 0x00000000
[    7.992424] marvell-nfc pxa3xx-nand: 
[    7.992424] NDCR:  0xdd079fff
[    7.992424] NDCB0: 0x000d3000
[    7.992424] NDCB1: 0x53000000
[    7.992424] NDCB2: 0x00000000
[    7.992424] NDCB3: 0x00000000
[    8.011485] marvell-nfc pxa3xx-nand: 
[    8.011485] NDCR:  0xdd079fff
[    8.011485] NDCB0: 0x000d3000
[    8.011485] NDCB1: 0x53010000
[    8.011485] NDCB2: 0x00000000
[    8.011485] NDCB3: 0x00000000
[    8.030479] marvell-nfc pxa3xx-nand: 
[    8.030479] NDCR:  0x9d079fff
[    8.030479] NDCB0: 0x000d3000
[    8.030479] NDCB1: 0x53010000
[    8.030479] NDCB2: 0x00000000
[    8.030479] NDCB3: 0x00000000
[    8.049579] marvell-nfc pxa3xx-nand: 
[    8.049579] NDCR:  0xdd079fff
[    8.049579] NDCB0: 0x000d3000
[    8.049579] NDCB1: 0x53400000
[    8.049579] NDCB2: 0x00000000
[    8.049579] NDCB3: 0x00000000
[    8.068643] marvell-nfc pxa3xx-nand: 
[    8.068643] NDCR:  0xdd079fff
[    8.068643] NDCB0: 0x000d3000
[    8.068643] NDCB1: 0x53410000
[    8.068643] NDCB2: 0x00000000
[    8.068643] NDCB3: 0x00000000
[    8.087618] marvell-nfc pxa3xx-nand: 
[    8.087618] NDCR:  0x9d079fff
[    8.087618] NDCB0: 0x000d3000
[    8.087618] NDCB1: 0x53410000
[    8.087618] NDCB2: 0x00000000
[    8.087618] NDCB3: 0x00000000
[    8.107355] marvell-nfc pxa3xx-nand: 
[    8.107355] NDCR:  0xdd079fff
[    8.107355] NDCB0: 0x000d3000
[    8.107355] NDCB1: 0x53800000
[    8.107355] NDCB2: 0x00000000
[    8.107355] NDCB3: 0x00000000
[    8.126458] marvell-nfc pxa3xx-nand: 
[    8.126458] NDCR:  0xdd079fff
[    8.126458] NDCB0: 0x000d3000
[    8.126458] NDCB1: 0x53810000
[    8.126458] NDCB2: 0x00000000
[    8.126458] NDCB3: 0x00000000
[    8.145438] marvell-nfc pxa3xx-nand: 
[    8.145438] NDCR:  0x9d079fff
[    8.145438] NDCB0: 0x000d3000
[    8.145438] NDCB1: 0x53810000
[    8.145438] NDCB2: 0x00000000
[    8.145438] NDCB3: 0x00000000
[    8.164543] marvell-nfc pxa3xx-nand: 
[    8.164543] NDCR:  0xdd079fff
[    8.164543] NDCB0: 0x000d3000
[    8.164543] NDCB1: 0x53c00000
[    8.164543] NDCB2: 0x00000000
[    8.164543] NDCB3: 0x00000000
[    8.183607] marvell-nfc pxa3xx-nand: 
[    8.183607] NDCR:  0xdd079fff
[    8.183607] NDCB0: 0x000d3000
[    8.183607] NDCB1: 0x53c10000
[    8.183607] NDCB2: 0x00000000
[    8.183607] NDCB3: 0x00000000
[    8.202574] marvell-nfc pxa3xx-nand: 
[    8.202574] NDCR:  0x9d079fff
[    8.202574] NDCB0: 0x000d3000
[    8.202574] NDCB1: 0x53c10000
[    8.202574] NDCB2: 0x00000000
[    8.202574] NDCB3: 0x00000000
[    8.221680] marvell-nfc pxa3xx-nand: 
[    8.221680] NDCR:  0xdd079fff
[    8.221680] NDCB0: 0x000d3000
[    8.221680] NDCB1: 0x54000000
[    8.221680] NDCB2: 0x00000000
[    8.221680] NDCB3: 0x00000000
[    8.240741] marvell-nfc pxa3xx-nand: 
[    8.240741] NDCR:  0xdd079fff
[    8.240741] NDCB0: 0x000d3000
[    8.240741] NDCB1: 0x54010000
[    8.240741] NDCB2: 0x00000000
[    8.240741] NDCB3: 0x00000000
[    8.259723] marvell-nfc pxa3xx-nand: 
[    8.259723] NDCR:  0x9d079fff
[    8.259723] NDCB0: 0x000d3000
[    8.259723] NDCB1: 0x54010000
[    8.259723] NDCB2: 0x00000000
[    8.259723] NDCB3: 0x00000000
[    8.278825] marvell-nfc pxa3xx-nand: 
[    8.278825] NDCR:  0xdd079fff
[    8.278825] NDCB0: 0x000d3000
[    8.278825] NDCB1: 0x54400000
[    8.278825] NDCB2: 0x00000000
[    8.278825] NDCB3: 0x00000000
[    8.297889] marvell-nfc pxa3xx-nand: 
[    8.297889] NDCR:  0xdd079fff
[    8.297889] NDCB0: 0x000d3000
[    8.297889] NDCB1: 0x54410000
[    8.297889] NDCB2: 0x00000000
[    8.297889] NDCB3: 0x00000000
[    8.316863] marvell-nfc pxa3xx-nand: 
[    8.316863] NDCR:  0x9d079fff
[    8.316863] NDCB0: 0x000d3000
[    8.316863] NDCB1: 0x54410000
[    8.316863] NDCB2: 0x00000000
[    8.316863] NDCB3: 0x00000000
[    8.335976] marvell-nfc pxa3xx-nand: 
[    8.335976] NDCR:  0xdd079fff
[    8.335976] NDCB0: 0x000d3000
[    8.335976] NDCB1: 0x55000000
[    8.335976] NDCB2: 0x00000000
[    8.335976] NDCB3: 0x00000000
[    8.355035] marvell-nfc pxa3xx-nand: 
[    8.355035] NDCR:  0xdd079fff
[    8.355035] NDCB0: 0x000d3000
[    8.355035] NDCB1: 0x55010000
[    8.355035] NDCB2: 0x00000000
[    8.355035] NDCB3: 0x00000000
[    8.374007] marvell-nfc pxa3xx-nand: 
[    8.374007] NDCR:  0x9d079fff
[    8.374007] NDCB0: 0x000d3000
[    8.374007] NDCB1: 0x55010000
[    8.374007] NDCB2: 0x00000000
[    8.374007] NDCB3: 0x00000000
[    8.393202] marvell-nfc pxa3xx-nand: 
[    8.393202] NDCR:  0xdd079fff
[    8.393202] NDCB0: 0x000d3000
[    8.393202] NDCB1: 0x55400000
[    8.393202] NDCB2: 0x00000000
[    8.393202] NDCB3: 0x00000000
[    8.412235] marvell-nfc pxa3xx-nand: 
[    8.412235] NDCR:  0xdd079fff
[    8.412235] NDCB0: 0x000d3000
[    8.412235] NDCB1: 0x55410000
[    8.412235] NDCB2: 0x00000000
[    8.412235] NDCB3: 0x00000000
[    8.431217] marvell-nfc pxa3xx-nand: 
[    8.431217] NDCR:  0x9d079fff
[    8.431217] NDCB0: 0x000d3000
[    8.431217] NDCB1: 0x55410000
[    8.431217] NDCB2: 0x00000000
[    8.431217] NDCB3: 0x00000000
[    8.450325] marvell-nfc pxa3xx-nand: 
[    8.450325] NDCR:  0xdd079fff
[    8.450325] NDCB0: 0x000d3000
[    8.450325] NDCB1: 0x55800000
[    8.450325] NDCB2: 0x00000000
[    8.450325] NDCB3: 0x00000000
[    8.469388] marvell-nfc pxa3xx-nand: 
[    8.469388] NDCR:  0xdd079fff
[    8.469388] NDCB0: 0x000d3000
[    8.469388] NDCB1: 0x55810000
[    8.469388] NDCB2: 0x00000000
[    8.469388] NDCB3: 0x00000000
[    8.488366] marvell-nfc pxa3xx-nand: 
[    8.488366] NDCR:  0x9d079fff
[    8.488366] NDCB0: 0x000d3000
[    8.488366] NDCB1: 0x55810000
[    8.488366] NDCB2: 0x00000000
[    8.488366] NDCB3: 0x00000000
[    8.507471] marvell-nfc pxa3xx-nand: 
[    8.507471] NDCR:  0xdd079fff
[    8.507471] NDCB0: 0x000d3000
[    8.507471] NDCB1: 0x55c00000
[    8.507471] NDCB2: 0x00000000
[    8.507471] NDCB3: 0x00000000
[    8.526556] marvell-nfc pxa3xx-nand: 
[    8.526556] NDCR:  0xdd079fff
[    8.526556] NDCB0: 0x000d3000
[    8.526556] NDCB1: 0x55c10000
[    8.526556] NDCB2: 0x00000000
[    8.526556] NDCB3: 0x00000000
[    8.545537] marvell-nfc pxa3xx-nand: 
[    8.545537] NDCR:  0x9d079fff
[    8.545537] NDCB0: 0x000d3000
[    8.545537] NDCB1: 0x55c10000
[    8.545537] NDCB2: 0x00000000
[    8.545537] NDCB3: 0x00000000
[    8.564641] marvell-nfc pxa3xx-nand: 
[    8.564641] NDCR:  0xdd079fff
[    8.564641] NDCB0: 0x000d3000
[    8.564641] NDCB1: 0x56000000
[    8.564641] NDCB2: 0x00000000
[    8.564641] NDCB3: 0x00000000
[    8.583703] marvell-nfc pxa3xx-nand: 
[    8.583703] NDCR:  0xdd079fff
[    8.583703] NDCB0: 0x000d3000
[    8.583703] NDCB1: 0x56010000
[    8.583703] NDCB2: 0x00000000
[    8.583703] NDCB3: 0x00000000
[    8.602671] marvell-nfc pxa3xx-nand: 
[    8.602671] NDCR:  0x9d079fff
[    8.602671] NDCB0: 0x000d3000
[    8.602671] NDCB1: 0x56010000
[    8.602671] NDCB2: 0x00000000
[    8.602671] NDCB3: 0x00000000
[    8.621771] marvell-nfc pxa3xx-nand: 
[    8.621771] NDCR:  0xdd079fff
[    8.621771] NDCB0: 0x000d3000
[    8.621771] NDCB1: 0x56400000
[    8.621771] NDCB2: 0x00000000
[    8.621771] NDCB3: 0x00000000
[    8.640836] marvell-nfc pxa3xx-nand: 
[    8.640836] NDCR:  0xdd079fff
[    8.640836] NDCB0: 0x000d3000
[    8.640836] NDCB1: 0x56410000
[    8.640836] NDCB2: 0x00000000
[    8.640836] NDCB3: 0x00000000
[    8.659821] marvell-nfc pxa3xx-nand: 
[    8.659821] NDCR:  0x9d079fff
[    8.659821] NDCB0: 0x000d3000
[    8.659821] NDCB1: 0x56410000
[    8.659821] NDCB2: 0x00000000
[    8.659821] NDCB3: 0x00000000
[    8.678923] marvell-nfc pxa3xx-nand: 
[    8.678923] NDCR:  0xdd079fff
[    8.678923] NDCB0: 0x000d3000
[    8.678923] NDCB1: 0x56800000
[    8.678923] NDCB2: 0x00000000
[    8.678923] NDCB3: 0x00000000
[    8.697987] marvell-nfc pxa3xx-nand: 
[    8.697987] NDCR:  0xdd079fff
[    8.697987] NDCB0: 0x000d3000
[    8.697987] NDCB1: 0x56810000
[    8.697987] NDCB2: 0x00000000
[    8.697987] NDCB3: 0x00000000
[    8.716967] marvell-nfc pxa3xx-nand: 
[    8.716967] NDCR:  0x9d079fff
[    8.716967] NDCB0: 0x000d3000
[    8.716967] NDCB1: 0x56810000
[    8.716967] NDCB2: 0x00000000
[    8.716967] NDCB3: 0x00000000
[    8.736068] marvell-nfc pxa3xx-nand: 
[    8.736068] NDCR:  0xdd079fff
[    8.736068] NDCB0: 0x000d3000
[    8.736068] NDCB1: 0x56c00000
[    8.736068] NDCB2: 0x00000000
[    8.736068] NDCB3: 0x00000000
[    8.755122] marvell-nfc pxa3xx-nand: 
[    8.755122] NDCR:  0xdd079fff
[    8.755122] NDCB0: 0x000d3000
[    8.755122] NDCB1: 0x56c10000
[    8.755122] NDCB2: 0x00000000
[    8.755122] NDCB3: 0x00000000
[    8.774101] marvell-nfc pxa3xx-nand: 
[    8.774101] NDCR:  0x9d079fff
[    8.774101] NDCB0: 0x000d3000
[    8.774101] NDCB1: 0x56c10000
[    8.774101] NDCB2: 0x00000000
[    8.774101] NDCB3: 0x00000000
[    8.793417] marvell-nfc pxa3xx-nand: 
[    8.793417] NDCR:  0xdd079fff
[    8.793417] NDCB0: 0x000d3000
[    8.793417] NDCB1: 0x57000000
[    8.793417] NDCB2: 0x00000000
[    8.793417] NDCB3: 0x00000000
[    8.812493] marvell-nfc pxa3xx-nand: 
[    8.812493] NDCR:  0xdd079fff
[    8.812493] NDCB0: 0x000d3000
[    8.812493] NDCB1: 0x57010000
[    8.812493] NDCB2: 0x00000000
[    8.812493] NDCB3: 0x00000000
[    8.831475] marvell-nfc pxa3xx-nand: 
[    8.831475] NDCR:  0x9d079fff
[    8.831475] NDCB0: 0x000d3000
[    8.831475] NDCB1: 0x57010000
[    8.831475] NDCB2: 0x00000000
[    8.831475] NDCB3: 0x00000000
[    8.850578] marvell-nfc pxa3xx-nand: 
[    8.850578] NDCR:  0xdd079fff
[    8.850578] NDCB0: 0x000d3000
[    8.850578] NDCB1: 0x57400000
[    8.850578] NDCB2: 0x00000000
[    8.850578] NDCB3: 0x00000000
[    8.869639] marvell-nfc pxa3xx-nand: 
[    8.869639] NDCR:  0xdd079fff
[    8.869639] NDCB0: 0x000d3000
[    8.869639] NDCB1: 0x57410000
[    8.869639] NDCB2: 0x00000000
[    8.869639] NDCB3: 0x00000000
[    8.888614] marvell-nfc pxa3xx-nand: 
[    8.888614] NDCR:  0x9d079fff
[    8.888614] NDCB0: 0x000d3000
[    8.888614] NDCB1: 0x57410000
[    8.888614] NDCB2: 0x00000000
[    8.888614] NDCB3: 0x00000000
[    8.907721] marvell-nfc pxa3xx-nand: 
[    8.907721] NDCR:  0xdd079fff
[    8.907721] NDCB0: 0x000d3000
[    8.907721] NDCB1: 0x57c00000
[    8.907721] NDCB2: 0x00000000
[    8.907721] NDCB3: 0x00000000
[    8.926778] marvell-nfc pxa3xx-nand: 
[    8.926778] NDCR:  0xdd079fff
[    8.926778] NDCB0: 0x000d3000
[    8.926778] NDCB1: 0x57c10000
[    8.926778] NDCB2: 0x00000000
[    8.926778] NDCB3: 0x00000000
[    8.945755] marvell-nfc pxa3xx-nand: 
[    8.945755] NDCR:  0x9d079fff
[    8.945755] NDCB0: 0x000d3000
[    8.945755] NDCB1: 0x57c10000
[    8.945755] NDCB2: 0x00000000
[    8.945755] NDCB3: 0x00000000
[    8.964856] marvell-nfc pxa3xx-nand: 
[    8.964856] NDCR:  0xdd079fff
[    8.964856] NDCB0: 0x000d3000
[    8.964856] NDCB1: 0x58000000
[    8.964856] NDCB2: 0x00000000
[    8.964856] NDCB3: 0x00000000
[    8.983915] marvell-nfc pxa3xx-nand: 
[    8.983915] NDCR:  0xdd079fff
[    8.983915] NDCB0: 0x000d3000
[    8.983915] NDCB1: 0x58010000
[    8.983915] NDCB2: 0x00000000
[    8.983915] NDCB3: 0x00000000
[    9.002886] marvell-nfc pxa3xx-nand: 
[    9.002886] NDCR:  0x9d079fff
[    9.002886] NDCB0: 0x000d3000
[    9.002886] NDCB1: 0x58010000
[    9.002886] NDCB2: 0x00000000
[    9.002886] NDCB3: 0x00000000
[    9.022075] marvell-nfc pxa3xx-nand: 
[    9.022075] NDCR:  0xdd079fff
[    9.022075] NDCB0: 0x000d3000
[    9.022075] NDCB1: 0x58400000
[    9.022075] NDCB2: 0x00000000
[    9.022075] NDCB3: 0x00000000
[    9.041141] marvell-nfc pxa3xx-nand: 
[    9.041141] NDCR:  0xdd079fff
[    9.041141] NDCB0: 0x000d3000
[    9.041141] NDCB1: 0x58410000
[    9.041141] NDCB2: 0x00000000
[    9.041141] NDCB3: 0x00000000
[    9.060123] marvell-nfc pxa3xx-nand: 
[    9.060123] NDCR:  0x9d079fff
[    9.060123] NDCB0: 0x000d3000
[    9.060123] NDCB1: 0x58410000
[    9.060123] NDCB2: 0x00000000
[    9.060123] NDCB3: 0x00000000
[    9.079435] ubi0: scanning is finished
[    9.083567] ubi0 error: ubi_read_volume_table: the layout volume was not found
[    9.090953] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd5, error -22
[    9.098457] UBI error: cannot attach mtd5
[    9.103950] pxa-rtc pxa-rtc: setting system clock to 2000-01-01 00:00:34 UTC (946684834)
[    9.187568] smc91x smc91x.0 eth0: link down
[   11.136140] smc91x smc91x.0 eth0: link up, 100Mbps, full-duplex, lpa 0xCDE1
[   11.193199] IP-Config: Complete:
[   11.196554]      device=eth0, hwaddr=00:0e:0c:a7:26:f7, ipaddr=192.168.1.232, mask=255.255.255.0, gw=255.255.255.255
[   11.207229]      host=192.168.1.232, domain=, nis-domain=(none)
[   11.213278]      bootserver=192.168.1.5, rootserver=192.168.1.5, rootpath=
[   11.221532] ALSA device list:
[   11.224983]   #0: Zylonite
[   11.250472] Freeing unused kernel memory: 2396K
[   11.255419] This architecture does not have kernel memory protection.
Starting logging: OK
Loading all the available modules: modprobe: module smc91x not found in modules.dep
modprobe: module soundcore not found in modules.dep
modprobe: module snd not found in modules.dep
modprobe: module snd-pcm not found in modules.dep
modprobe: module fat not found in modules.dep
modprobe: module vfat not found in modules.dep
modprobe: module nfs not found in modules.dep
modprobe: module nls_cp437 not found in modules.dep
modprobe: module nls_cp850 not found in modules.dep
modprobe: module nls_ascii not found in modules.dep
modprobe: module nls_utf8 not found in modules.dep
modprobe: module fixed not found in modules.dep
modprobe: module pwm-pxa not found in modules.dep
modprobe: module cpufreq_conservative not found in modules.dep
modprobe: module cpufreq_powersave not found in modules.dep
modprobe: module cpufreq-dt not found in modules.dep
modprobe: module btusb not found in modules.dep
modprobe: module i2c-dev not found in modules.dep
modprobe: module ubi not found in modules.dep
modprobe: module mt_blkdevs not found in modules.dep
modprobe: module pxa3xx_nand not found in modules.dep
modprobe: module mtdblock not found in modules.dep
modprobe: module ofpart not found in modules.dep
modprobe: module map_rom not found in modules.dep
modprobe: module jedec_probe not found in modules.dep
modprobe: module cmdlinepart not found in modules.dep
modprobe: module redboot not found in modules.dep
modprobe: module loop not found in modules.dep
modprobe: module leds-gpio not found in modules.dep
modprobe: module jedec-class not found in modules.dep
modprobe: module pxa not found in modules.dep
modprobe: module evdev not found in modules.dep
modprobe: module soc_common not found in modules.dep
modprobe: module pwm_bl not found in modules.dep
modprobe: module fbcon not found in modules.dep
modprobe: module rtc-pxa not found in modules.dep
modprobe: module rtc-sa1100 not found in modules.dep
modprobe: module smc91x not found in modules.dep
modprobe: module pda_power not found in modules.dep
modprobe: module fixed not found in modules.dep
KO
OK
Changing smcs91x MAC address to 08:00:3e:26:0a:5b: ifconfig: SIOCSIFHWADDR: Device or resource busy
KO
OK
Initializing random number generator... done.
Starting network...
ip: RTNETLINK answers: File exists
udhcpc (v1.24.1) started
Sending discover...
Sending select for 192.168.1.232...
Lease of 192.168.1.232 obtained, lease time 86400
deleting routers
adding dns 192.168.1.1
Starting dropbear sshd: OK

Welcome to Buildroot
zylonite login: 
