From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 12 Jan 2018 09:09:17 +0100
Subject: [PATCH v3 0/7] Marvell NAND controller rework with ->exec_op()
In-Reply-To: <20180111232417.4aa86075@xps13> (Miquel RAYNAL's message of "Thu,
 11 Jan 2018 23:24:17 +0100")
References: <20180109103637.23798-1-miquel.raynal@free-electrons.com>
 <20180111122751.4bd74366@bbrezillon> <87efmwb8bj.fsf@belgarion.home>
 <20180111232417.4aa86075@xps13>
Message-ID: <87a7xjbis2.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Miquel RAYNAL <miquel.raynal@free-electrons.com> writes:

I begun all your test procedure (on my zylonite board).
The timing registers are the same in both pxa3xx_nand and marvell_nand, ie :
[    3.085539] Timing registers from Bootloader:
[    3.089971] -  NDTR0: 0x00161c1c
[    3.095979] -  NDTR1: 0x0f3c00a2

I can attach the dmesg of the first run (dump of OOB). Yet I think you're
missing the point as to where the bug lies.

In the zylonite setup, the BBT is _not_ in the OOB of each block. Instead, it
lies at the end of the NAND, in the last blocks (see struct
nand_bbt_descr). Reading each block and declaring it as bad as is done in
marvell_nand (at least that is my understanding of your traces), but it is not
what should be done if a match is found for the bbt_pattern. Instead, the BBT
should be loaded from the last 8 blocks of the NAND, ie. page 130944 and page
131008 in my setup.

Therefore, I would rather think that marvell-nand is not using the BBT at the
end of the nand rather than misconfiguring the timing registers.

Cheers.

--
Robert

PS: You really should expunge the mailing recipients a bit ...

[1] DMesg extract
netconsole: port not set
netconsole: registered as netconsole-1
smc91c111 smc91c1110: chip is revision= 9, version= 2
mdio_bus: miibus0: probed
eth0: got preset MAC address: 00:0e:0c:a7:26:f7
nand: NAND device: Manufacturer ID: 0x20, Chip ID: 0xba (ST Micro NAND 256MiB 1,8V 16-bit), 256MiB, page size: 2048, OOB size: 64
mrvl_nand mrvl_nand0: ECC strength 1, ECC step size 512
Bad block table found at page 131008, version 0x04
Bad block table found at page 130944, version 0x04
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
[    0.000000] Linux version 4.15.0-rc1-00047-g3085f79 (jenkins at belgarath) (gcc version 4.8.3 20140320 (prerelease) (Sourcery CodeBench Lite 2014.05-29)) #889 PREEMPT Fri Jan 12 08:26:17 CET 2018
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
[    0.000000] Memory: 56856K/65536K available (4226K kernel code, 202K rwdata, 972K rodata, 2396K init, 102K bss, 8680K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc4800000 - 0xff800000   ( 944 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0428a48   (4227 kB)
[    0.000000]       .init : 0xc053f000 - 0xc0796000   (2396 kB)
[    0.000000]       .data : 0xc0796000 - 0xc07c8bec   ( 203 kB)
[    0.000000]        .bss : 0xc07c8bec - 0xc07e25fc   ( 103 kB)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] NR_IRQS: 16, nr_irqs: 336, preallocated irqs: 336
[    0.000000] RJK: parent_rate=13000000, xl=8, xn=1
[    0.000070] sched_clock: 32 bits at 3250kHz, resolution 307ns, wraps every 660764198758ns
[    0.000266] clocksource: oscr0: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 588080137591 ns
[    0.002134] Console: colour dummy device 80x30
[    0.002294] Calibrating delay loop... 103.83 BogoMIPS (lpj=519168)
[    0.081019] pid_max: default: 32768 minimum: 301
[    0.081862] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.081960] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.085156] CPU: Testing write buffer coherency: ok
[    0.088957] Setting up static identity map for 0x80008200 - 0x80008260
[    0.089916] Hierarchical SRCU implementation.
[    0.102924] devtmpfs: initialized
[    0.113807] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.113948] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.116278] NET: Registered protocol family 16
[    0.119090] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.389530] Advanced Linux Sound Architecture Driver Initialized.
[    0.400350] clocksource: Switched to clocksource oscr0
[    0.553012] NET: Registered protocol family 2
[    0.558410] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.558634] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.558815] TCP: Hash tables configured (established 1024 bind 1024)
[    0.559367] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.559547] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.561234] NET: Registered protocol family 1
[    0.563263] RPC: Registered named UNIX socket transport module.
[    0.563363] RPC: Registered udp transport module.
[    0.563418] RPC: Registered tcp transport module.
[    0.563475] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.498791] Initialise system trusted keyrings
[    2.501003] workingset: timestamp_bits=30 max_order=14 bucket_order=0
[    2.504911] NFS: Registering the id_resolver key type
[    2.505141] Key type id_resolver registered
[    2.505204] Key type id_legacy registered
[    2.511301] Key type asymmetric registered
[    2.511404] Asymmetric key parser 'x509' registered
[    2.511567] io scheduler noop registered
[    2.511632] io scheduler deadline registered
[    2.512023] io scheduler cfq registered (default)
[    2.512092] io scheduler mq-deadline registered
[    2.512155] io scheduler kyber registered
[    2.569944] pxa-dma pxa-dma.0: initialized 32 channels on 100 requestors
[    2.575695] pxa2xx-uart.0: ttyS0 at MMIO 0x40100000 (irq = 38, base_baud = 928571) is a UART1
[    3.050762] console [ttyS0] enabled
[    3.057118] pxa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq = 37, base_baud = 928571) is a UART2
[    3.069632] pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (irq = 36, base_baud = 928571) is a UART3
[    3.085539] Timing registers from Bootloader:
[    3.089971] -  NDTR0: 0x00161c1c
[    3.095979] -  NDTR1: 0x0f3c00a2
[    3.099319] nand: executing subop:
[    3.103209] nand:     ->CMD      [0xff]
[    3.107105] nand:     ->WAITRDY  [max 250 ms]
[    3.111915] marvell-nfc pxa3xx-nand: 
[    3.111915] NDCR:  0x90071fff
[    3.111915] NDCB0: 0x00a000ff
[    3.111915] NDCB1: 0x00000000
[    3.111915] NDCB2: 0x00000000
[    3.111915] NDCB3: 0x00000000
[    3.131170] nand: executing subop:
[    3.134638] nand:     ->CMD      [0x90]
[    3.138513] nand:     ->ADDR     [1 cyc: 00]
[    3.143174] nand:     ->DATA_IN  [2 B, force 8-bit]
[    3.148182] marvell-nfc pxa3xx-nand: 
[    3.148182] NDCR:  0x90071fff
[    3.148182] NDCB0: 0x00610090
[    3.148182] NDCB1: 0x00000000
[    3.148182] NDCB2: 0x00000000
[    3.148182] NDCB3: 0x00000000
[    3.167016] nand: executing subop:
[    3.170656] nand:     ->CMD      [0x90]
[    3.174543] nand:     ->ADDR     [1 cyc: 00]
[    3.178842] nand:     ->DATA_IN  [8 B, force 8-bit]
[    3.183955] marvell-nfc pxa3xx-nand: 
[    3.183955] NDCR:  0x90071fff
[    3.183955] NDCB0: 0x00610090
[    3.183955] NDCB1: 0x00000000
[    3.183955] NDCB2: 0x00000000
[    3.183955] NDCB3: 0x00000000
[    3.202627] nand: executing subop:
[    3.206083] nand:     ->CMD      [0x90]
[    3.209958] nand:     ->ADDR     [1 cyc: 20]
[    3.214403] nand:     ->DATA_IN  [4 B, force 8-bit]
[    3.219383] marvell-nfc pxa3xx-nand: 
[    3.219383] NDCR:  0x90071fff
[    3.219383] NDCB0: 0x00610090
[    3.219383] NDCB1: 0x00000020
[    3.219383] NDCB2: 0x00000000
[    3.219383] NDCB3: 0x00000000
[    3.238001] nand: executing subop:
[    3.241598] nand:     ->CMD      [0x90]
[    3.245491] nand:     ->ADDR     [1 cyc: 40]
[    3.249790] nand:     ->DATA_IN  [5 B, force 8-bit]
[    3.254897] marvell-nfc pxa3xx-nand: 
[    3.254897] NDCR:  0x90071fff
[    3.254897] NDCB0: 0x00610090
[    3.254897] NDCB1: 0x00000040
[    3.254897] NDCB2: 0x00000000
[    3.254897] NDCB3: 0x00000000
[    3.273547] nand: device found, Manufacturer ID: 0x20, Chip ID: 0xba
[    3.279923] nand: ST Micro NAND 256MiB 1,8V 16-bit
[    3.284893] nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    3.292633] marvell-nfc pxa3xx-nand: No minimum ECC strength, using 1b/512B
[    3.299666] Scanning device for bad blocks
[    3.303978] nand: nand_do_read_oob: from = 0x00000000, len = 64
[    3.310000] marvell-nfc pxa3xx-nand: 
[    3.310000] NDCR:  0x9d079fff
[    3.310000] NDCB0: 0x000d3000
[    3.310000] NDCB1: 0x00000000
[    3.310000] NDCB2: 0x00000000
[    3.310000] NDCB3: 0x00000000
[    3.329036] OOB from page 0:
[    3.332122] 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
[    3.342950] 01: 00 00 00 00 00 00 00 00 d4 eb 0b f5 fa 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
[    3.353817] Bad eraseblock 0 at 0x000000000000
[    3.358338] nand: nand_do_read_oob: from = 0x00020000, len = 64
[    3.364494] marvell-nfc pxa3xx-nand: 
[    3.364494] NDCR:  0x9d079fff
[    3.364494] NDCB0: 0x000d3000
[    3.364494] NDCB1: 0x00400000
[    3.364494] NDCB2: 0x00000000
[    3.364494] NDCB3: 0x00000000
[    3.383344] OOB from page 64:
[    3.386353] 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
[    3.397213] 01: ff ff ff ff ff ff ff ff dc 1e ef 48 38 04 e6 95 40 86 da 0f b6 fd 95 6d 7f 05 2d cf fd 61 d9 05 
[    3.408131] nand: nand_do_read_oob: from = 0x00040000, len = 64
[    3.414298] marvell-nfc pxa3xx-nand: 
[    3.414298] NDCR:  0x9d079fff
[    3.414298] NDCB0: 0x000d3000
[    3.414298] NDCB1: 0x00800000
[    3.414298] NDCB2: 0x00000000
[    3.414298] NDCB3: 0x00000000
[    3.433140] OOB from page 128:
[    3.436237] 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
[    3.447080] 01: 00 00 00 00 00 00 00 00 48 5b 01 d2 56 00 a2 ec 23 82 51 02 ef af 9d ae 3e 02 34 82 6c d8 75 0e 
[    3.457961] Bad eraseblock 2 at 0x000000040000
[    3.462604] nand: nand_do_read_oob: from = 0x00060000, len = 64
[    3.468627] marvell-nfc pxa3xx-nand: 
[    3.468627] NDCR:  0x9d079fff
[    3.468627] NDCB0: 0x000d3000
[    3.468627] NDCB1: 0x00c00000
[    3.468627] NDCB2: 0x00000000
[    3.468627] NDCB3: 0x00000000
[    3.487466] OOB from page 192:
[    3.490706] 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
[    3.501537] 01: 00 00 00 00 00 00 00 00 a7 23 9c bc 5d 02 5e 55 3b fd 7f 04 ed 35 c0 d1 a7 0a c3 94 09 cf 9a 0d 
[    3.512409] Bad eraseblock 3 at 0x000000060000
