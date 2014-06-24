From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 24 Jun 2014 10:49:36 +0200
Subject: [PATCHv5 2/2] arm: Get rid of meminfo
In-Reply-To: <53A8927B.3020409@codeaurora.org>
References: <1396544698-15596-1-git-send-email-lauraa@codeaurora.org>
 <1396544698-15596-3-git-send-email-lauraa@codeaurora.org>
 <20140623091754.GD14781@pengutronix.de>
 <53A8927B.3020409@codeaurora.org>
Message-ID: <20140624084936.GJ14781@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Mon, Jun 23, 2014 at 01:47:55PM -0700, Laura Abbott wrote:
> Thanks for the report.
Thanks for your reply to address it :-)
Are you already aware of the mail with Message-Id:
CAGa+x85H510fNGTXJHGYfQybRa2FGgg2NyCgJ8rmjJ6TE7GNbA at mail.gmail.com ?
Seems to be another fall-out but I think you were not on Cc.

> On 6/23/2014 2:17 AM, Uwe Kleine-K?nig wrote:
> > This patch is in 3.16-rc1 as 1c2f87c22566cd057bc8cde10c37ae9da1a1bb76
> > now.
> > 
> > Unfortunately it makes my efm32 machine unbootable.
> > 
> > With earlyprintk enabled I get the following output:
> > 
> > [    0.000000] Booting Linux on physical CPU 0x0
> > [    0.000000] Linux version 3.15.0-rc1-00028-g1c2f87c22566-dirty (ukleinek at perseus) (gcc version 4.7.2 (OSELAS.Toolchain-2012.12.1) ) #280 PREEMPT Mon Jun 23 11:05:34 CEST 2014
> > [    0.000000] CPU: ARMv7-M [412fc231] revision 1 (ARMv7M), cr=00000000
> > [    0.000000] CPU: unknown data cache, unknown instruction cache
> > [    0.000000] Machine model: Energy Micro Giant Gecko Development Kit
> > [    0.000000] debug: ignoring loglevel setting.
> > [    0.000000] bootconsole [earlycon0] enabled
> > [    0.000000] On node 0 totalpages: 1024
> > [    0.000000] free_area_init_node: node 0, pgdat 880208f4, node_mem_map 00000000
> > [    0.000000]   Normal zone: 3840 pages exceeds freesize 1024
> 
> This looks off. The number of pages for the memmap exceeds the available free
> size. Working backwards, I think the wrong bounds are being calculated in
> find_limits in arch/arm/mm/init.c . max_low is now calculated via the current
> limit but nommu never sets a limit unlike the mmu case. Can you try the
> following patch and see if it fixes the issue? If this doesn't work, can
> you share working bootup logs so I can do a bit more compare and contrast?
> 
> Thanks,
> Laura
> 
> ---8<----
> From 9b19241d577caf91928e26e55413047d1be90feb Mon Sep 17 00:00:00 2001
> From: Laura Abbott <lauraa@codeaurora.org>
> Date: Mon, 23 Jun 2014 13:26:56 -0700
> Subject: [PATCH] arm: Set memblock limit for nommu
> 
> Commit 1c2f87c (ARM: 8025/1: Get rid of meminfo) changed find_limits
> to use memblock_get_current_limit for calculating the max_low pfn.
> nommu targets never actually set a limit on memblock though which
> means memblock_get_current_limit will just return the default
> value. Set the memblock_limit to be the end of DDR to make sure
s/DDR/RAM/ ?

> bounds are calculated correctly.
This patch makes my machine boot. Full boot log appended below.
(Side note: I place my dtb in the SRAM at 0x10000000 but don't add this to
the available memory because it's only 128 KiB in size and so too small
to be worth to track. Not sure this is allowed?!)

Thanks
Uwe

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.15.0-rc1-00028-g1c2f87c22566-dirty (ukleinek at perseus) (gcc version 4.7.2 (OSELAS.Toolchain-2012.12.1) ) #285 PREEMPT Tue Jun 24 10:30:01 CEST 2014
[    0.000000] CPU: ARMv7-M [412fc231] revision 1 (ARMv7M), cr=00000000
[    0.000000] CPU: unknown data cache, unknown instruction cache
[    0.000000] Machine model: Energy Micro Giant Gecko Development Kit
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] set currentlimit to 88400000 (old: ffffffff)
[    0.000000] memblock_reserve: [0x00000088008000-0x0000008802bf3b] flags 0x0 arm_memblock_init+0xf/0x48
[    0.000000] memblock_reserve: [0x00000010000000-0x000000100010fd] flags 0x0 arm_dt_memblock_reserve+0x11/0x40
[    0.000000] MEMBLOCK configuration:
[    0.000000]  memory size = 0x400000 reserved size = 0x2503a
[    0.000000]  memory.cnt  = 0x1
[    0.000000]  memory[0x0]	[0x00000088000000-0x000000883fffff], 0x400000 bytes flags: 0x0
[    0.000000]  reserved.cnt  = 0x2
[    0.000000]  reserved[0x0]	[0x00000010000000-0x000000100010fd], 0x10fe bytes flags: 0x0
[    0.000000]  reserved[0x1]	[0x00000088008000-0x0000008802bf3b], 0x23f3c bytes flags: 0x0
[    0.000000] On node 0 totalpages: 1024
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 32768 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 alloc_node_mem_map.constprop.78+0x33/0x54
[    0.000000] memblock_reserve: [0x000000883f8000-0x000000883fffff] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] free_area_init_node: node 0, pgdat 880208f4, node_mem_map 883f8000
[    0.000000]   Normal zone: 8 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 1024 pages, LIFO batch:0
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 4 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 free_area_init_node+0x1b9/0x23a
[    0.000000] memblock_reserve: [0x000000883f7fe0-0x000000883f7fe3] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 32 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 zone_wait_table_init+0x53/0x94
[    0.000000] memblock_reserve: [0x000000883f7fc0-0x000000883f7fdf] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 28 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 setup_arch+0x295/0x3a6
[    0.000000] memblock_reserve: [0x000000883f7fa0-0x000000883f7fbb] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 12832 bytes align=0x4 nid=-1 from=0x0 max_addr=0x0 early_init_dt_alloc_memory_arch+0x13/0x14
[    0.000000] memblock_reserve: [0x000000883f4d80-0x000000883f7f9f] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 24 bytes align=0x4 nid=-1 from=0x0 max_addr=0x0 early_init_dt_alloc_memory_arch+0x13/0x14
[    0.000000] memblock_reserve: [0x000000883f7fe8-0x000000883f7fff] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 24 bytes align=0x4 nid=-1 from=0x0 max_addr=0x0 early_init_dt_alloc_memory_arch+0x13/0x14
[    0.000000] memblock_reserve: [0x000000883f4d68-0x000000883f4d7f] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 27 bytes align=0x4 nid=-1 from=0x0 max_addr=0x0 early_init_dt_alloc_memory_arch+0x13/0x14
[    0.000000] memblock_reserve: [0x000000883f4d4c-0x000000883f4d66] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 27 bytes align=0x4 nid=-1 from=0x0 max_addr=0x0 early_init_dt_alloc_memory_arch+0x13/0x14
[    0.000000] memblock_reserve: [0x000000883f4d30-0x000000883f4d4a] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 27 bytes align=0x4 nid=-1 from=0x0 max_addr=0x0 early_init_dt_alloc_memory_arch+0x13/0x14
[    0.000000] memblock_reserve: [0x000000883f4d14-0x000000883f4d2e] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 27 bytes align=0x4 nid=-1 from=0x0 max_addr=0x0 early_init_dt_alloc_memory_arch+0x13/0x14
[    0.000000] memblock_reserve: [0x000000883f4cf8-0x000000883f4d12] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 27 bytes align=0x4 nid=-1 from=0x0 max_addr=0x0 early_init_dt_alloc_memory_arch+0x13/0x14
[    0.000000] memblock_reserve: [0x000000883f4cdc-0x000000883f4cf6] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 24 bytes align=0x4 nid=-1 from=0x0 max_addr=0x0 early_init_dt_alloc_memory_arch+0x13/0x14
[    0.000000] memblock_reserve: [0x000000883f4cc4-0x000000883f4cdb] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 24 bytes align=0x4 nid=-1 from=0x0 max_addr=0x0 early_init_dt_alloc_memory_arch+0x13/0x14
[    0.000000] memblock_reserve: [0x000000883f4cac-0x000000883f4cc3] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 24 bytes align=0x4 nid=-1 from=0x0 max_addr=0x0 early_init_dt_alloc_memory_arch+0x13/0x14
[    0.000000] memblock_reserve: [0x000000883f4c94-0x000000883f4cab] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 147 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 start_kernel+0x63/0x210
[    0.000000] memblock_reserve: [0x000000883f4c00-0x000000883f4c92] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 147 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 start_kernel+0x7b/0x210
[    0.000000] memblock_reserve: [0x000000883f4b60-0x000000883f4bf2] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 147 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 start_kernel+0x91/0x210
[    0.000000] memblock_reserve: [0x000000883f4ac0-0x000000883f4b52] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 4096 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_alloc_info+0x2f/0x4c
[    0.000000] memblock_reserve: [0x000000883f3ac0-0x000000883f4abf] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 32768 bytes align=0x1000 nid=-1 from=0xffffffff max_addr=0x0 setup_per_cpu_areas+0x21/0x5c
[    0.000000] memblock_reserve: [0x000000883eb000-0x000000883f2fff] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x3b7/0x42a
[    0.000000] memblock_reserve: [0x000000883f3aa0-0x000000883f3aa3] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x3c9/0x42a
[    0.000000] memblock_reserve: [0x000000883f3a80-0x000000883f3a83] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x3d9/0x42a
[    0.000000] memblock_reserve: [0x000000883f3a60-0x000000883f3a63] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x3e9/0x42a
[    0.000000] memblock_reserve: [0x000000883f3a40-0x000000883f3a43] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] memblock_virt_alloc_try_nid: 120 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x1c5/0x42a
[    0.000000] memblock_reserve: [0x000000883f39c0-0x000000883f3a37] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] memblock_virt_alloc_try_nid: 48 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x1f5/0x42a
[    0.000000] memblock_reserve: [0x000000883f3980-0x000000883f39af] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 1016
[    0.000000] Kernel command line: console=ttyefm4,115200 init=/linuxrc ignore_loglevel ihash_entries=64 dhash_entries=64 earlyprintk uclinux.physaddr=0x8c400000 root=/dev/mtdblock0
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 64 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0xe9/0x180
[    0.000000] memblock_reserve: [0x000000883f3940-0x000000883f397f] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] PID hash table entries: 16 (order: -6, 64 bytes)
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 256 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0xe9/0x180
[    0.000000] memblock_reserve: [0x000000883f3840-0x000000883f393f] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] Dentry cache hash table entries: 64 (order: -4, 256 bytes)
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 256 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0xe9/0x180
[    0.000000] memblock_reserve: [0x000000883f3740-0x000000883f383f] flags 0x0 memblock_virt_alloc_internal+0x8d/0xe0
[    0.000000] Inode-cache hash table entries: 64 (order: -4, 256 bytes)
[    0.000000] Memory: 3868K/4096K available (1156K kernel code, 83K rwdata, 316K rodata, 56K init, 43K bss, 228K reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0x00000000 - 0x00001000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
[    0.000000]     vmalloc : 0x00000000 - 0xffffffff   (4095 MB)
[    0.000000]     lowmem  : 0x88000000 - 0x88400000   (   4 MB)
[    0.000000]       .text : 0x8c000000 - 0x8c170368   (1473 kB)
[    0.000000]       .init : 0x8800a000 - 0x8800e000   (  16 kB)
[    0.000000]       .data : 0x88008000 - 0x88020f80   ( 100 kB)
[    0.000000]        .bss : 0x88020f8c - 0x8802bf3c   (  44 kB)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836480000000ns
[    0.010000] Calibrating delay loop... 1.38 BogoMIPS (lpj=6912)
[    0.160000] pid_max: default: 4096 minimum: 301
[    0.180000] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.190000] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.470000] devtmpfs: initialized
[    0.850000] NET: Registered protocol family 16
[    1.820000] Switched to clocksource efm32 timer
[    2.050000] NET: Registered protocol family 2
[    2.180000] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    2.200000] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    2.220000] TCP: Hash tables configured (established 1024 bind 1024)
[    2.240000] TCP: reno registered
[    2.240000] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    2.260000] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    2.300000] NET: Registered protocol family 1
[    4.210000] ROMFS MTD (C) 2007 Red Hat, Inc.
[    4.270000] io scheduler noop registered (default)
[    4.300000] 4000e400.uart: ttyefm4 at MMIO 0x4000e400 (irq = 25, base_baud = 0) is a efm32-uart
[    4.320000] console [ttyefm4] enabled
[    4.320000] console [ttyefm4] enabled
[    4.330000] bootconsole [earlycon0] disabled
[    4.330000] bootconsole [earlycon0] disabled
[    4.430000] EFM32 UART/USART driver
[    4.530000] uclinux[mtd]: probe address=0x8c400000 size=0x60000
[    4.540000] Creating 1 MTD partitions on "rom":
[    4.550000] 0x000000000000-0x000000060000 : "ROMfs"
[    4.790000] efm32-spi 4000c000.spi: failed to get csgpio#0 (-517)
[    4.810000] platform 4000c000.spi: Driver efm32-spi requests probe deferral
[    4.830000] efm32-spi 4000c400.spi: failed to get csgpio#0 (-517)
[    4.840000] platform 4000c400.spi: Driver efm32-spi requests probe deferral
[    4.950000] TCP: cubic registered
[    4.960000] NET: Registered protocol family 17
[    5.120000] efm32-spi 4000c000.spi: failed to get csgpio#0 (-517)
[    5.130000] platform 4000c000.spi: Driver efm32-spi requests probe deferral
[    5.150000] efm32-spi 4000c400.spi: failed to get csgpio#0 (-517)
[    5.170000] platform 4000c400.spi: Driver efm32-spi requests probe deferral
[    5.280000] VFS: Mounted root (romfs filesystem) readonly on device 31:0.
[    5.300000] devtmpfs: mounted
[    5.330000] Freeing unused kernel memory: 16K (8800a000 - 8800e000)

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
