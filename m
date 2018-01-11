From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 11 Jan 2018 18:42:56 +0100
Subject: [PATCH v3 0/7] Marvell NAND controller rework with ->exec_op()
In-Reply-To: <20180111122751.4bd74366@bbrezillon> (Boris Brezillon's message
 of "Thu, 11 Jan 2018 12:27:51 +0100")
References: <20180109103637.23798-1-miquel.raynal@free-electrons.com>
 <20180111122751.4bd74366@bbrezillon>
Message-ID: <87efmwb8bj.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boris Brezillon <boris.brezillon@free-electrons.com> writes:

Hi Boris and Miquel,

> So, here is the plan: since the driver has been tested on various mvebu
> platforms and is known to work fine on these platforms, I'd like to
> queue the driver and the patch modifying mvebu defconfigs (patches 1 to
> 4) for 4.16.
That's all right.

> I'll leave other patches for 4.17, which means I'd like remaining bugs
> to be fixed during the 4.16 release cycle so that we can eventually get
> rid of the old driver. That's really important to me that we don't keep
> both drivers around for too long, because my previous experience showed
> that, when you have 2 drivers for the same HW, people don't switch to
> the new one until they're forced to do it.
>
> Robert, are you fine with this approach? What about the tests you were
> doing? Did you make any progress? Did you find other issues?
So far, with the latest branch from Miquel of tip commit 12b9e62c851c ("ARM64:
dts: marvell: use reworked NAND controller driver on Armada 8K"), the bad blocks
issue is still there, ie :
 - the old pxa3xx driver doesn't see any bad block and mounts the ext2/ubifs
   correctly
 - barebox doesn't see any bad block
 - marvell_nand sees all (or most all) blocks as bad with "flash_bbt=0" in
   platform data, which is very surprising

I'm really surprised that in your tests on the cm_x300, in a platform_data setup
(ie. not device-tree setup), you're not seeing these errors ...

As if I'm fine with this approach, I agree with step 1 (patches 1-4). As for
step 2, I'll agree if the current situation is solved and my boards recognize
correctly my ext2 over ubifs on the NAND.

Cheers.

--
Robert

[1] The dmesg extract (here with flash_bbt = 0)
Loading ARM Linux zImage '/mnt/tftp/zImage_jenkins'
commandline: ram=64M console=ttyS0,115200 ip=dhcp root=/dev/nfs nfsroot=/home/none/nfsroot/zylonite,v3,tcp earlycon mtdparts=pxa3xx_nand-0:128k at 0(TIMH)ro,128k at 128k(OBMI)ro,768k at 256k(barebox),256k at 1024k(barebox-env),12M at 1280k(kernel),38016k at 13568k(root)
arch_number: 1233
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.15.0-rc1-00044-g11cc68b (jenkins at belgarath) (gcc version 4.8.3 20140320 (prerelease) (Sourcery CodeBench Lite 2014.05-29)) #879 PREEMPT Thu Jan 11 09:16:09 CET 2018
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
[    0.002139] Console: colour dummy device 80x30
[    0.002298] Calibrating delay loop... 103.83 BogoMIPS (lpj=519168)
[    0.081019] pid_max: default: 32768 minimum: 301
[    0.081858] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.081958] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.085170] CPU: Testing write buffer coherency: ok
[    0.088980] Setting up static identity map for 0x80008200 - 0x80008260
[    0.089936] Hierarchical SRCU implementation.
[    0.102958] devtmpfs: initialized
[    0.113835] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.113974] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.116311] NET: Registered protocol family 16
[    0.119126] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.385492] Advanced Linux Sound Architecture Driver Initialized.
[    0.398200] clocksource: Switched to clocksource oscr0
[    0.551166] NET: Registered protocol family 2
[    0.556911] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.557135] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.557316] TCP: Hash tables configured (established 1024 bind 1024)
[    0.557858] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.558038] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.559740] NET: Registered protocol family 1
[    0.561795] RPC: Registered named UNIX socket transport module.
[    0.561891] RPC: Registered udp transport module.
[    0.561946] RPC: Registered tcp transport module.
[    0.562003] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.497308] Initialise system trusted keyrings
[    2.499900] workingset: timestamp_bits=30 max_order=14 bucket_order=0
[    2.503798] NFS: Registering the id_resolver key type
[    2.504004] Key type id_resolver registered
[    2.504066] Key type id_legacy registered
[    2.510210] Key type asymmetric registered
[    2.510311] Asymmetric key parser 'x509' registered
[    2.510469] io scheduler noop registered
[    2.510534] io scheduler deadline registered
[    2.510928] io scheduler cfq registered (default)
[    2.510999] io scheduler mq-deadline registered
[    2.511060] io scheduler kyber registered
[    2.571677] pxa-dma pxa-dma.0: initialized 32 channels on 100 requestors
[    2.575099] pxa2xx-uart.0: ttyS0 at MMIO 0x40100000 (irq = 38, base_baud = 928571) is a UART1
[    3.050644] console [ttyS0] enabled
[    3.056987] pxa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq = 37, base_baud = 928571) is a UART2
[    3.069918] pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (irq = 36, base_baud = 928571) is a UART3
[    3.085482] nand: executing subop:
[    3.091647] nand:     ->CMD      [0xff]
[    3.095546] nand:     ->WAITRDY  [max 250 ms]
[    3.100705] marvell-nfc pxa3xx-nand: 
[    3.100705] NDCR:  0x90079fff
[    3.100705] NDCB0: 0x00a000ff
[    3.100705] NDCB1: 0x00000000
[    3.100705] NDCB2: 0x00000000
[    3.100705] NDCB3: 0x00000000
[    3.119968] nand: executing subop:
[    3.123439] nand:     ->CMD      [0x90]
[    3.127315] nand:     ->ADDR     [1 cyc: 00]
[    3.131983] nand:     ->DATA_IN  [2 B, force 8-bit]
[    3.136985] marvell-nfc pxa3xx-nand: 
[    3.136985] NDCR:  0x90079fff
[    3.136985] NDCB0: 0x00610090
[    3.136985] NDCB1: 0x00000000
[    3.136985] NDCB2: 0x00000000
[    3.136985] NDCB3: 0x00000000
[    3.155819] nand: executing subop:
[    3.159462] nand:     ->CMD      [0x90]
[    3.163343] nand:     ->ADDR     [1 cyc: 00]
[    3.167635] nand:     ->DATA_IN  [8 B, force 8-bit]
[    3.172747] marvell-nfc pxa3xx-nand: 
[    3.172747] NDCR:  0x90079fff
[    3.172747] NDCB0: 0x00610090
[    3.172747] NDCB1: 0x00000000
[    3.172747] NDCB2: 0x00000000
[    3.172747] NDCB3: 0x00000000
[    3.191422] nand: executing subop:
[    3.194876] nand:     ->CMD      [0x90]
[    3.198897] nand:     ->ADDR     [1 cyc: 20]
[    3.203210] nand:     ->DATA_IN  [4 B, force 8-bit]
[    3.208314] marvell-nfc pxa3xx-nand: 
[    3.208314] NDCR:  0x90079fff
[    3.208314] NDCB0: 0x00610090
[    3.208314] NDCB1: 0x00000020
[    3.208314] NDCB2: 0x00000000
[    3.208314] NDCB3: 0x00000000
[    3.226920] nand: executing subop:
[    3.230511] nand:     ->CMD      [0x90]
[    3.234394] nand:     ->ADDR     [1 cyc: 40]
[    3.238830] nand:     ->DATA_IN  [5 B, force 8-bit]
[    3.243808] marvell-nfc pxa3xx-nand: 
[    3.243808] NDCR:  0x90079fff
[    3.243808] NDCB0: 0x00610090
[    3.243808] NDCB1: 0x00000040
[    3.243808] NDCB2: 0x00000000
[    3.243808] NDCB3: 0x00000000
[    3.262444] nand: device found, Manufacturer ID: 0x20, Chip ID: 0xba
[    3.268947] nand: ST Micro NAND 256MiB 1,8V 16-bit
[    3.273791] nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    3.281519] marvell-nfc pxa3xx-nand: No minimum ECC strength, using 1b/512B
[    3.288669] Scanning device for bad blocks
[    3.292845] nand: nand_do_read_oob: from = 0x00000000, len = 64
[    3.299007] marvell-nfc pxa3xx-nand: 
[    3.299007] NDCR:  0x9d079fff
[    3.299007] NDCB0: 0x000d3000
[    3.299007] NDCB1: 0x00000000
[    3.299007] NDCB2: 0x00000000
[    3.299007] NDCB3: 0x00000000
[    3.318075] Bad eraseblock 0 at 0x000000000000
[    3.322773] nand: nand_do_read_oob: from = 0x00020000, len = 64
[    3.328941] marvell-nfc pxa3xx-nand: 
[    3.328941] NDCR:  0x9d079fff
[    3.328941] NDCB0: 0x000d3000
[    3.328941] NDCB1: 0x00400000
[    3.328941] NDCB2: 0x00000000
[    3.328941] NDCB3: 0x00000000
[    3.347848] nand: nand_do_read_oob: from = 0x00040000, len = 64
[    3.354049] marvell-nfc pxa3xx-nand: 
[    3.354049] NDCR:  0x9d079fff
[    3.354049] NDCB0: 0x000d3000
[    3.354049] NDCB1: 0x00800000
[    3.354049] NDCB2: 0x00000000
[    3.354049] NDCB3: 0x00000000
[    3.372925] Bad eraseblock 2 at 0x000000040000
[    3.377451] nand: nand_do_read_oob: from = 0x00060000, len = 64
[    3.383633] marvell-nfc pxa3xx-nand: 
[    3.383633] NDCR:  0x9d079fff
[    3.383633] NDCB0: 0x000d3000
[    3.383633] NDCB1: 0x00c00000
[    3.383633] NDCB2: 0x00000000
[    3.383633] NDCB3: 0x00000000
[    3.402509] Bad eraseblock 3 at 0x000000060000
... and so on ...
[   60.154031] marvell-nfc pxa3xx-nand: 
[   60.154031] NDCR:  0x9d079fff
[   60.154031] NDCB0: 0x000d3000
[   60.154031] NDCB1: 0x58410000
[   60.154031] NDCB2: 0x00000000
[   60.154031] NDCB3: 0x00000000
[   60.173335] ubi0: scanning is finished
[   60.177297] ubi0 error: ubi_read_volume_table: the layout volume was not found
[   60.184878] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd5, error -22
[   60.192397] UBI error: cannot attach mtd5
[   60.197652] pxa-rtc pxa-rtc: setting system clock to 2000-01-01 00:01:25 UTC (946684885)
[   60.282788] smc91x smc91x.0 eth0: link down
[   62.152546] smc91x smc91x.0 eth0: link up, 100Mbps, full-duplex, lpa 0xCDE1
[   62.198419] IP-Config: Complete:
[   62.201766]      device=eth0, hwaddr=00:0e:0c:a7:26:f7, ipaddr=192.168.1.232, mask=255.255.255.0, gw=255.255.255.255
[   62.212438]      host=192.168.1.232, domain=, nis-domain=(none)
[   62.218511]      bootserver=192.168.1.5, rootserver=192.168.1.5, rootpath=
[   62.226759] ALSA device list:
[   62.230209]   #0: Zylonite
[   62.255735] Freeing unused kernel memory: 2396K
[   62.260675] This architecture does not have kernel memory protection.
Starting logging: OK
