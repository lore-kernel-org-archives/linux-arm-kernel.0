From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 23 Dec 2017 14:42:20 +0100
Subject: [PATCH 00/12] Marvell NAND controller rework with ->exec_op()
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
 <20171214070930.0b885f6d@bbrezillon> <877etkecig.fsf@belgarion.home>
 <20171218092535.2ca1fe13@xps13> <87y3lxccr7.fsf@belgarion.home>
 <20171220224121.2cb6f690@bbrezillon> <87lghucykr.fsf@belgarion.home>
 <20171222222441.0fd77df9@bbrezillon> <20171222233730.68d9cb9d@xps13>
Message-ID: <87k1xdblxf.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Miquel RAYNAL <miquel.raynal@free-electrons.com> writes:

I removed a lot of people from the recipients, as this is a debug session.

>> > Now I get a lot of these message which I didn't have before :
>> > [   26.897372] ubi0 warning: ubi_io_read: error -74 (ECC error)
>> > while reading 126976 bytes from PEB 242:4096, read only 126976
>> Looks like a mismatch in the ECC config. Can you check the ecc
>> strength/step_size in both situation (old driver vs new driver)?
>
> For that, you might want to add traces in marvell_nand_ecc_init() and
> marvell_nand_hw_ecc_ctrl_init().
>
>> Could you also dump the NDCR register in both cases?
>
> NDCR register (as well as NDCBx registers) will appear if you let
>
>     #define DEBUG
>
> at the beginning of the driver.
>
> Also, can you please give us the entire dmesg (I mean the boot, not the
> flow of UBIFS errors of course).
Here it comes in [3]. I suspect the BBT parser here, here is the extract that
_might_ be relevant:
[    3.372907] nand: ->exec_op() parser: pattern not found!
[    3.378445] marvell-nfc pxa3xx-nand: 
... repeats many times ...
[    3.666571] Bad block table not found for chip 0
[    3.671368] Scanning device for bad blocks
[    3.675540] nand: nand_do_read_oob: from = 0x00000000, len = 64
[    3.681688] marvell-nfc pxa3xx-nand: 
[    3.681688] NDCR:  0x9d079fff
[    3.681688] NDCB0: 0x000d3000
[    3.681688] NDCB1: 0x00000000
[    3.681688] NDCB2: 0x00000000
[    3.681688] NDCB3: 0x00000000
[    3.700570] Bad eraseblock 0 at 0x000000000000

My configuration is :
 - make zylonite_defconfig
 - apply patch in [1] for arch/arm/mach-pxa
 - apply patch in [2] for drivers/mtd
 - run the test (make zylonite_defconfig; make; do_the_test_with_jenkins)
That should give you all my setup information, ie. platform_data, ECC and BBT
settings (ie. the "MBBbt0" pattern).

Cheers.

-- 
Robert

[1] Patch for zylonite
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 0534949d63f6..d247ef01dc62 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -378,6 +378,8 @@ static struct mtd_partition zylonite_nand_partitions[] = {
 static struct pxa3xx_nand_platform_data zylonite_nand_info = {
 	.parts		= zylonite_nand_partitions,
 	.nr_parts	= ARRAY_SIZE(zylonite_nand_partitions),
+	.flash_bbt	= 1,
+	.keep_config	= 1,
 };
 
 static void __init zylonite_init_nand(void)

[2] Patch for mtd
diff --git a/drivers/mtd/nand/marvell_nand.c b/drivers/mtd/nand/marvell_nand.c
index c618ccb22a61..957219e7c23d 100644
--- a/drivers/mtd/nand/marvell_nand.c
+++ b/drivers/mtd/nand/marvell_nand.c
@@ -7,6 +7,8 @@
  * SPDX-License-Identifier: GPL-2.0
  */
 
+#define DEBUG 1
+
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/mtd/rawnand.h>
@@ -2480,6 +2482,7 @@ static int marvell_nand_chip_init(struct device *dev, struct marvell_nfc *nfc,
 	 * in the DT node, this entry will be overwritten in nand_scan_ident().
 	 */
 	chip->ecc.mode = NAND_ECC_HW;
+	chip->options |= NAND_BUSWIDTH_AUTO;
 
 	ret = nand_scan_ident(mtd, marvell_nand->nsels, NULL);
 	if (ret) {
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 469220065b8b..0beed1cd58b3 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -27,6 +27,8 @@
  *
  */
 
+#define DEBUG 1
+
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>

[3] Dmesg of my failing zylonite
Loading ARM Linux zImage '/mnt/tftp/zImage_jenkins'
commandline: ram=64M console=ttyS0,115200 ip=dhcp root=/dev/nfs nfsroot=/home/none/nfsroot/zylonite,v3,tcp earlycon mtdparts=pxa3xx_nand-0:128k at 0(TIMH)ro,128k at 128k(OBMI)ro,768k at 256k(barebox),256k at 1024k(barebox-env),12M at 1280k(kernel),38016k at 13568k(root)
arch_number: 1233
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.15.0-rc1-00041-g8ba5ca3 (jenkins at belgarath) (gcc version 4.8.3 20140320 (prerelease) (Sourcery CodeBench Lite 2014.05-29)) #747 PREEMPT Sat Dec 23 11:55:09 CET 2017
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
[    0.000000]       .text : 0xc0008000 - 0xc0428a08   (4227 kB)
[    0.000000]       .init : 0xc053f000 - 0xc0796000   (2396 kB)
[    0.000000]       .data : 0xc0796000 - 0xc07c8bec   ( 203 kB)
[    0.000000]        .bss : 0xc07c8bec - 0xc07e25fc   ( 103 kB)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] NR_IRQS: 16, nr_irqs: 336, preallocated irqs: 336
[    0.000000] RJK: parent_rate=13000000, xl=8, xn=1
[    0.000069] sched_clock: 32 bits at 3250kHz, resolution 307ns, wraps every 660764198758ns
[    0.000266] clocksource: oscr0: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 588080137591 ns
[    0.002138] Console: colour dummy device 80x30
[    0.002299] Calibrating delay loop... 103.83 BogoMIPS (lpj=519168)
[    0.081018] pid_max: default: 32768 minimum: 301
[    0.081861] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.081960] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.085170] CPU: Testing write buffer coherency: ok
[    0.088970] Setting up static identity map for 0x80008200 - 0x80008260
[    0.089927] Hierarchical SRCU implementation.
[    0.103027] devtmpfs: initialized
[    0.113870] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.114009] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.116340] NET: Registered protocol family 16
[    0.119151] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.388383] Advanced Linux Sound Architecture Driver Initialized.
[    0.399046] clocksource: Switched to clocksource oscr0
[    0.551948] NET: Registered protocol family 2
[    0.557703] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.557940] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.558123] TCP: Hash tables configured (established 1024 bind 1024)
[    0.558662] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.558853] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.560546] NET: Registered protocol family 1
[    0.562593] RPC: Registered named UNIX socket transport module.
[    0.562693] RPC: Registered udp transport module.
[    0.562747] RPC: Registered tcp transport module.
[    0.562806] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.499969] Initialise system trusted keyrings
[    2.501747] workingset: timestamp_bits=30 max_order=14 bucket_order=0
[    2.505617] NFS: Registering the id_resolver key type
[    2.505846] Key type id_resolver registered
[    2.505907] Key type id_legacy registered
[    2.512358] Key type asymmetric registered
[    2.512460] Asymmetric key parser 'x509' registered
[    2.512619] io scheduler noop registered
[    2.512685] io scheduler deadline registered
[    2.513081] io scheduler cfq registered (default)
[    2.513152] io scheduler mq-deadline registered
[    2.513215] io scheduler kyber registered
[    2.573653] pxa-dma pxa-dma.0: initialized 32 channels on 100 requestors
[    2.577078] pxa2xx-uart.0: ttyS0 at MMIO 0x40100000 (irq = 38, base_baud = 928571) is a UART1
[    3.052691] console [ttyS0] enabled
[    3.059293] pxa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq = 37, base_baud = 928571) is a UART2
[    3.071727] pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (irq = 36, base_baud = 928571) is a UART3
[    3.087282] nand: executing subop:
[    3.093208] nand:     ->CMD      [0xff]
[    3.097110] nand:     ->WAITRDY  [max 250 ms]
[    3.102330] marvell-nfc pxa3xx-nand: 
[    3.102330] NDCR:  0x90079fff
[    3.102330] NDCB0: 0x00a000ff
[    3.102330] NDCB1: 0x00000000
[    3.102330] NDCB2: 0x00000000
[    3.102330] NDCB3: 0x00000000
[    3.121601] nand: executing subop:
[    3.125071] nand:     ->CMD      [0x90]
[    3.128946] nand:     ->ADDR     [1 cyc: 00]
[    3.133608] nand:     ->DATA_IN  [2 B, force 8-bit]
[    3.138617] marvell-nfc pxa3xx-nand: 
[    3.138617] NDCR:  0x90079fff
[    3.138617] NDCB0: 0x00610090
[    3.138617] NDCB1: 0x00000000
[    3.138617] NDCB2: 0x00000000
[    3.138617] NDCB3: 0x00000000
[    3.157454] nand: executing subop:
[    3.161098] nand:     ->CMD      [0x90]
[    3.164983] nand:     ->ADDR     [1 cyc: 00]
[    3.169424] nand:     ->DATA_IN  [8 B, force 8-bit]
[    3.174412] marvell-nfc pxa3xx-nand: 
[    3.174412] NDCR:  0x90079fff
[    3.174412] NDCB0: 0x00610090
[    3.174412] NDCB1: 0x00000000
[    3.174412] NDCB2: 0x00000000
[    3.174412] NDCB3: 0x00000000
[    3.193079] nand: executing subop:
[    3.196531] nand:     ->CMD      [0x90]
[    3.200553] nand:     ->ADDR     [1 cyc: 20]
[    3.204867] nand:     ->DATA_IN  [4 B, force 8-bit]
[    3.209975] marvell-nfc pxa3xx-nand: 
[    3.209975] NDCR:  0x90079fff
[    3.209975] NDCB0: 0x00610090
[    3.209975] NDCB1: 0x00000020
[    3.209975] NDCB2: 0x00000000
[    3.209975] NDCB3: 0x00000000
[    3.228598] nand: executing subop:
[    3.232187] nand:     ->CMD      [0x90]
[    3.236077] nand:     ->ADDR     [1 cyc: 40]
[    3.240517] nand:     ->DATA_IN  [5 B, force 8-bit]
[    3.245499] marvell-nfc pxa3xx-nand: 
[    3.245499] NDCR:  0x90079fff
[    3.245499] NDCB0: 0x00610090
[    3.245499] NDCB1: 0x00000040
[    3.245499] NDCB2: 0x00000000
[    3.245499] NDCB3: 0x00000000
[    3.264138] nand: device found, Manufacturer ID: 0x20, Chip ID: 0xba
[    3.270650] nand: ST Micro NAND 256MiB 1,8V 16-bit
[    3.275491] nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    3.283219] marvell-nfc pxa3xx-nand: No minimum ECC strength, using 1b/512B
[    3.290880] marvell-nfc pxa3xx-nand: 
[    3.290880] NDCR:  0xdd079fff
[    3.290880] NDCB0: 0x000d3000
[    3.290880] NDCB1: 0xffc00000
[    3.290880] NDCB2: 0x00000001
[    3.290880] NDCB3: 0x00000000
[    3.310230] marvell-nfc pxa3xx-nand: 
[    3.310230] NDCR:  0xdd079fff
[    3.310230] NDCB0: 0x000d3000
[    3.310230] NDCB1: 0xff800000
[    3.310230] NDCB2: 0x00000001
[    3.310230] NDCB3: 0x00000000
[    3.329329] marvell-nfc pxa3xx-nand: 
[    3.329329] NDCR:  0xdd079fff
[    3.329329] NDCB0: 0x000d3000
[    3.329329] NDCB1: 0xff400000
[    3.329329] NDCB2: 0x00000001
[    3.329329] NDCB3: 0x00000000
[    3.348256] nand: ->exec_op() parser: pattern not found!
[    3.353989] marvell-nfc pxa3xx-nand: 
[    3.353989] NDCR:  0xdd079fff
[    3.353989] NDCB0: 0x000d3000
[    3.353989] NDCB1: 0xff000000
[    3.353989] NDCB2: 0x00000001
[    3.353989] NDCB3: 0x00000000
[    3.372907] nand: ->exec_op() parser: pattern not found!
[    3.378445] marvell-nfc pxa3xx-nand: 
... repeats many times ...
[    3.666571] Bad block table not found for chip 0
[    3.671368] Scanning device for bad blocks
[    3.675540] nand: nand_do_read_oob: from = 0x00000000, len = 64
[    3.681688] marvell-nfc pxa3xx-nand: 
[    3.681688] NDCR:  0x9d079fff
[    3.681688] NDCB0: 0x000d3000
[    3.681688] NDCB1: 0x00000000
[    3.681688] NDCB2: 0x00000000
[    3.681688] NDCB3: 0x00000000
[    3.700570] Bad eraseblock 0 at 0x000000000000
[    3.705096] nand: nand_do_read_oob: from = 0x00020000, len = 64
[    3.711275] marvell-nfc pxa3xx-nand: 
[    3.711275] NDCR:  0x9d079fff
[    3.711275] NDCB0: 0x000d3000
[    3.711275] NDCB1: 0x00400000
[    3.711275] NDCB2: 0x00000000
[    3.711275] NDCB3: 0x00000000
[    3.730190] nand: nand_do_read_oob: from = 0x00040000, len = 64
[    3.736221] marvell-nfc pxa3xx-nand: 
[    3.736221] NDCR:  0x9d079fff
[    3.736221] NDCB0: 0x000d3000
[    3.736221] NDCB1: 0x00800000
[    3.736221] NDCB2: 0x00000000
[    3.736221] NDCB3: 0x00000000
[    3.755106] Bad eraseblock 2 at 0x000000040000
[    3.759786] nand: nand_do_read_oob: from = 0x00060000, len = 64
[    3.765804] marvell-nfc pxa3xx-nand: 
[    3.765804] NDCR:  0x9d079fff
[    3.765804] NDCB0: 0x000d3000
[    3.765804] NDCB1: 0x00c00000
[    3.765804] NDCB2: 0x00000000
[    3.765804] NDCB3: 0x00000000
[    3.784670] Bad eraseblock 3 at 0x000000060000
[    3.789346] nand: nand_do_read_oob: from = 0x00080000, len = 64
[    3.795363] marvell-nfc pxa3xx-nand: 
[    3.795363] NDCR:  0x9d079fff
[    3.795363] NDCB0: 0x000d3000
[    3.795363] NDCB1: 0x01000000
[    3.795363] NDCB2: 0x00000000
[    3.795363] NDCB3: 0x00000000
[    3.814234] Bad eraseblock 4 at 0x000000080000
... repeats many times ...
