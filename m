From: balbi@ti.com (Felipe Balbi)
Date: Tue, 29 Jul 2014 15:17:50 -0500
Subject: Bad Page dump (help)
In-Reply-To: <20140729195547.GE30282@n2100.arm.linux.org.uk>
References: <20140729190700.GN17808@saruman.home>
 <20140729195547.GE30282@n2100.arm.linux.org.uk>
Message-ID: <20140729201750.GO17808@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 29, 2014 at 08:55:47PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jul 29, 2014 at 02:07:01PM -0500, Felipe Balbi wrote:
> > I'm bringing up a new board on today's linux-next but I'm having a bunch
> > of bad_page() calls due to _mapcount not being zero (full logs
> > attached). What could cause that ? Any hints on how to debug ? It's as
> > if page_mapcount_reset() wasn't called for the pages which are causing
> > issues.
> 
> Hmm... are you using sparsemem?  I suspect sparsemem hasn't been tested
> for a while now.

hmmm, CONFIG_ARCH_SPARSEMEM_DEFAULT is disabled. So is CONFIG_SPARSEMEM.

> > [    0.000000] BUG: Bad page state in process swapper  pfn:8136d
> > [    0.000000] page:ee017da0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
> 
> So the page pointer was 0xee017da0 for pfn 0x8136d.  The mem map array
> starts at 0xedff1000, which makes this index 0x136d, or 4973, which
> looks fine.
> 
> 1520 pages are used for the mem_map, so that covers 0xedff1000 to
> 0xee5e100.  So, the struct page is well within the allocation for the
> mem map array.
> 
> The mapcount equates to 0xfff00000, which looks to be a suggestive value,
> but it doesn't really help much.
> 
> Looking at free_pages_check(), we can say that all the other checks
> that the function did succeeded (if any of them had failed, we would
> have seen a different reason.)
> 
> Hmm.
> 
> Can you enable memblock debugging by passing memblock=debug on the kernel
> command line please, and re-send the kernel output?

sure thing, it's below (kinda large). You'll see there is "-dirty" on
the kernel version now, and that's because I took the time to change a
few things on my DTS. I'm mostly renaming pinctrl nodes to give them a
"standard" naming scheme across the file and also added pinctrl data for
MMC0, where I'm trying to mount rootfs. Other than that, the kernel
itself is the same.

8<--------------------- cut here ---------------------------------------



switch to partitions #0, OK
mmc0 is current device
SD/MMC found on device 0
reading uEnv.txt
** Unable to read file uEnv.txt **
4436384 bytes read in 406 ms (10.4 MiB/s)
31588 bytes read in 460 ms (66.4 KiB/s)
Booting from mmc0 ...
Kernel image @ 0x82000000 [ 0x000000 - 0x43b1a0 ]
## Flattened Device Tree blob at 88000000
   Booting using the fdt blob at 0x88000000
   Loading Device Tree to 8fff5000, end 8ffffb63 ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.16.0-rc7-next-20140729-00002-g4169dc8-dirty (balbi at saruman) (gcc version 4.8.2 20130902 (prerelease) (crosstool-NG linaro-1.13.1-4.8-2013.09 - Linaro GCC 2013.09) ) #590 SMP Tue Jul 29 15:13:32 CDT 2014
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: TI AM437x Industrial Development Kit
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] memblock_reserve: [0x00000080008340-0x0000008118240f] flags 0x0 arm_memblock_init+0x20/0x1a0
[    0.000000] memblock_reserve: [0x00000080004000-0x00000080007fff] flags 0x0 arm_memblock_init+0x11c/0x1a0
[    0.000000] memblock_reserve: [0x0000008fff5000-0x0000008fffcfff] flags 0x0 early_init_fdt_scan_reserved_mem+0x30/0x8c
[    0.000000] memblock_reserve: [0x000000ae800000-0x000000af7fffff] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] cma: Reserved 16 MiB@ae800000
[    0.000000] MEMBLOCK configuration:
[    0.000000]  memory size = 0x40000000 reserved size = 0x21860d0
[    0.000000]  memory.cnt  = 0x1
[    0.000000]  memory[0x0]	[0x00000080000000-0x000000bfffffff], 0x40000000 bytes flags: 0x0
[    0.000000]  reserved.cnt  = 0x4
[    0.000000]  reserved[0x0]	[0x00000080004000-0x00000080007fff], 0x4000 bytes flags: 0x0
[    0.000000]  reserved[0x1]	[0x00000080008340-0x0000008118240f], 0x117a0d0 bytes flags: 0x0
[    0.000000]  reserved[0x2]	[0x0000008fff5000-0x0000008fffcfff], 0x8000 bytes flags: 0x0
[    0.000000]  reserved[0x3]	[0x000000ae800000-0x000000af7fffff], 0x1000000 bytes flags: 0x0
[    0.000000] Memory policy: Data cache writeback
[    0.000000] memblock_reserve: [0x000000ae7fffd8-0x000000ae7fffff] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7fe000-0x000000ae7fefff] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7fd000-0x000000ae7fdfff] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7fc000-0x000000ae7fcfff] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7fb000-0x000000ae7fbfff] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7fa000-0x000000ae7fafff] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7f9000-0x000000ae7f9fff] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7f8000-0x000000ae7f8fff] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7f7000-0x000000ae7f7fff] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7f4000-0x000000ae7f5fff] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7f6000-0x000000ae7f6fff] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7fff88-0x000000ae7fffd7] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7f3000-0x000000ae7f3fff] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7f2000-0x000000ae7f2fff] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7f1000-0x000000ae7f1fff] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] On node 0 totalpages: 262144
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 9437184 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 alloc_node_mem_map.constprop.68+0x68/0x94
[    0.000000] memblock_reserve: [0x000000adef1000-0x000000ae7f0fff] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] free_area_init_node: node 0, pgdat c08e7e40, node_mem_map edef1000
[    0.000000]   Normal zone: 1710 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 194560 pages, LIFO batch:31
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 48 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 free_area_init_node+0x2c0/0x3b4
[    0.000000] memblock_reserve: [0x000000ae7fff40-0x000000ae7fff6f] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 40960 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 zone_wait_table_init+0x7c/0xe8
[    0.000000] memblock_reserve: [0x000000adee7000-0x000000adef0fff] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000]   HighMem zone: 594 pages used for memmap
[    0.000000]   HighMem zone: 67584 pages, LIFO batch:15
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 20 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 free_area_init_node+0x2c0/0x3b4
[    0.000000] memblock_reserve: [0x000000ae7fff00-0x000000ae7fff13] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 20480 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 zone_wait_table_init+0x7c/0xe8
[    0.000000] memblock_reserve: [0x000000adee2000-0x000000adee6fff] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] memblock_virt_alloc_try_nid: 28 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 setup_arch+0x514/0x9f4
[    0.000000] memblock_reserve: [0x000000ae7ffec0-0x000000ae7ffedb] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] memblock_reserve: [0x000000adec4dd0-0x000000adee1fff] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7fff70-0x000000ae7fff87] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7fff28-0x000000ae7fff3f] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7ffee8-0x000000ae7ffeff] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7ffea4-0x000000ae7ffebe] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7ffe84-0x000000ae7ffea0] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] memblock_reserve: [0x000000ae7ffe64-0x000000ae7ffe80] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] AM437x ES1.0 (sgx neon )
[    0.000000] memblock_virt_alloc_try_nid: 2328 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 omap_hwmod_register_links+0x6c/0x254
[    0.000000] memblock_reserve: [0x000000ae7ff540-0x000000ae7ffe57] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] L2C: platform modifies aux control register: 0x0e030000 -> 0x3e430000
[    0.000000] L2C: DT/platform modifies aux control register: 0x0e030000 -> 0x3e430000
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 1 lines
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at arch/arm/mach-omap2/omap4-common.c:172 omap4_l2c310_write_sec+0x74/0xa8()
[    0.000000] OMAP L2C310: ignoring write to reg 0xf80
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c0042cd8>] (warn_slowpath_common+0x6c/0x90)
[    0.000000] [<c0042cd8>] (warn_slowpath_common) from [<c0042d2c>] (warn_slowpath_fmt+0x30/0x40)
[    0.000000] [<c0042d2c>] (warn_slowpath_fmt) from [<c002bf78>] (omap4_l2c310_write_sec+0x74/0xa8)
[    0.000000] [<c002bf78>] (omap4_l2c310_write_sec) from [<c07de0b0>] (l2c310_enable+0x12c/0x1f8)
[    0.000000] [<c07de0b0>] (l2c310_enable) from [<c07ddefc>] (__l2c_init+0x160/0x1e8)
[    0.000000] [<c07ddefc>] (__l2c_init) from [<c07de5fc>] (l2x0_of_init+0x170/0x1a0)
[    0.000000] [<c07de5fc>] (l2x0_of_init) from [<c07e49b0>] (omap_l2_cache_init+0x60/0x98)
[    0.000000] [<c07e49b0>] (omap_l2_cache_init) from [<c07df820>] (am43xx_init_early+0x58/0x80)
[    0.000000] [<c07df820>] (am43xx_init_early) from [<c07da2e4>] (setup_arch+0x910/0x9f4)
[    0.000000] [<c07da2e4>] (setup_arch) from [<c07d689c>] (start_kernel+0x80/0x3cc)
[    0.000000] [<c07d689c>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] ---[ end trace cb88537fdc8fa200 ]---
[    0.000000] L2C-310 dynamic clock gating disabled, standby mode disabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 256 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c9, AUX_CTRL 0x7e430000
[    0.000000] memblock_virt_alloc_try_nid: 104 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 start_kernel+0xbc/0x3cc
[    0.000000] memblock_reserve: [0x000000ae7ff4c0-0x000000ae7ff527] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] memblock_virt_alloc_try_nid: 104 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 start_kernel+0xe0/0x3cc
[    0.000000] memblock_reserve: [0x000000ae7ff440-0x000000ae7ff4a7] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] memblock_virt_alloc_try_nid: 104 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 start_kernel+0x104/0x3cc
[    0.000000] memblock_reserve: [0x000000ae7ff3c0-0x000000ae7ff427] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 4096 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_alloc_info+0x4c/0x88
[    0.000000] memblock_reserve: [0x000000adec3dc0-0x000000adec4dbf] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 4096 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_embed_first_chunk+0x544/0x7d0
[    0.000000] memblock_reserve: [0x000000adec2dc0-0x000000adec3dbf] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 36864 bytes align=0x1000 nid=-1 from=0xbfffffff max_addr=0x0 pcpu_dfl_fc_alloc+0x24/0x2c
[    0.000000] memblock_reserve: [0x000000adeb9000-0x000000adec1fff] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] __memblock_free_early: [0x000000adec2000-0x000000adec1fff] pcpu_embed_first_chunk+0x670/0x7d0
[    0.000000] PERCPU: Embedded 9 pages/cpu @edeb9000 s14336 r8192 d14336 u36864
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x124/0x718
[    0.000000] memblock_reserve: [0x000000ae7ff380-0x000000ae7ff383] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x148/0x718
[    0.000000] memblock_reserve: [0x000000ae7ff340-0x000000ae7ff343] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x168/0x718
[    0.000000] memblock_reserve: [0x000000ae7ff300-0x000000ae7ff303] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x188/0x718
[    0.000000] memblock_reserve: [0x000000ae7ff2c0-0x000000ae7ff2c3] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] pcpu-alloc: s14336 r8192 d14336 u36864 alloc=9*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] memblock_virt_alloc_try_nid: 120 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x458/0x718
[    0.000000] memblock_reserve: [0x000000ae7ff240-0x000000ae7ff2b7] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] memblock_virt_alloc_try_nid: 48 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x4a4/0x718
[    0.000000] memblock_reserve: [0x000000ae7ff200-0x000000ae7ff22f] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] memblock_virt_alloc_try_nid: 48 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x5c8/0x718
[    0.000000] memblock_reserve: [0x000000ae7ff1c0-0x000000ae7ff1ef] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] __memblock_free_early: [0x000000adec3dc0-0x000000adec4dbf] pcpu_embed_first_chunk+0x774/0x7d0
[    0.000000] __memblock_free_early: [0x000000adec2dc0-0x000000adec3dbf] pcpu_embed_first_chunk+0x78c/0x7d0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260434
[    0.000000] Kernel command line: console=ttyO0,115200n8 root=/dev/mmcblk0p2 rw rootfstype=ext4 rootwait earlyprintk debug memblock=debug
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 16384 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x168/0x274
[    0.000000] memblock_reserve: [0x000000adeb5000-0x000000adeb8fff] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 524288 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x168/0x274
[    0.000000] memblock_reserve: [0x000000ade35000-0x000000adeb4fff] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 262144 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x168/0x274
[    0.000000] memblock_reserve: [0x000000addf5000-0x000000ade34fff] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] BUG: Bad page state in process swapper  pfn:811db
[    0.000000] page:edf192cc count:0 mapcount:-3407872 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] Disabling lock debugging due to kernel taint
[    0.000000] BUG: Bad page state in process swapper  pfn:8125b
[    0.000000] page:edf1a4cc count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8127b
[    0.000000] page:edf1a94c count:0 mapcount:-3407872 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81289
[    0.000000] page:edf1ab44 count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8128b
[    0.000000] page:edf1ab8c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8129b
[    0.000000] page:edf1adcc count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8139b
[    0.000000] page:edf1d1cc count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:813bb
[    0.000000] page:edf1d64c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8148b
[    0.000000] page:edf1f38c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81491
[    0.000000] page:edf1f464 count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81493
[    0.000000] page:edf1f4ac count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8162b
[    0.000000] page:edf22e0c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81c6b
[    0.000000] page:edf30f0c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81f0b
[    0.000000] page:edf36d8c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8220f
[    0.000000] page:edf3da1c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:82233
[    0.000000] page:edf3df2c count:0 mapcount:-3407872 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:823e7
[    0.000000] page:edf41c7c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:824ff
[    0.000000] page:edf443dc count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8251b
[    0.000000] page:edf447cc count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:825db
[    0.000000] page:edf462cc count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8262f
[    0.000000] page:edf46e9c count:0 mapcount:-1310720 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8264f
[    0.000000] page:edf4731c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8269f
[    0.000000] page:edf47e5c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:82857
[    0.000000] page:edf4bc3c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8286f
[    0.000000] page:edf4bf9c count:0 mapcount:-11862016 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:82ae7
[    0.000000] page:edf5187c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:82aef
[    0.000000] page:edf5199c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:82b07
[    0.000000] page:edf51cfc count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:82b0f
[    0.000000] page:edf51e1c count:0 mapcount:-3407872 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:82b13
[    0.000000] page:edf51eac count:0 mapcount:-3407872 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:82b17
[    0.000000] page:edf51f3c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:82b37
[    0.000000] page:edf523bc count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:82c0f
[    0.000000] page:edf5421c count:0 mapcount:-1310720 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:82c57
[    0.000000] page:edf54c3c count:0 mapcount:-3407872 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:82db7
[    0.000000] page:edf57dbc count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:82dbf
[    0.000000] page:edf57edc count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:82de3
[    0.000000] page:edf583ec count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:82f57
[    0.000000] page:edf5b83c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:83037
[    0.000000] page:edf5d7bc count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8303f
[    0.000000] page:edf5d8dc count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:83043
[    0.000000] page:edf5d96c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:83063
[    0.000000] page:edf5ddec count:0 mapcount:-1310720 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8309f
[    0.000000] page:edf5e65c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:83463
[    0.000000] page:edf66dec count:0 mapcount:-1310720 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8358f
[    0.000000] page:edf6981c count:0 mapcount:-11796480 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:83599
[    0.000000] page:edf69984 count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:836af
[    0.000000] page:edf6c09c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:836b7
[    0.000000] page:edf6c1bc count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:836bf
[    0.000000] page:edf6c2dc count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:837cf
[    0.000000] page:edf6e91c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:83837
[    0.000000] page:edf6f7bc count:0 mapcount:-3407872 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8383f
[    0.000000] page:edf6f8dc count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:83877
[    0.000000] page:edf700bc count:0 mapcount:-12386304 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8388f
[    0.000000] page:edf7041c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:83b97
[    0.000000] page:edf7713c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:83d1b
[    0.000000] page:edf7a7cc count:0 mapcount:-12386304 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:83d2b
[    0.000000] page:edf7aa0c count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:83dff
[    0.000000] page:edf7c7dc count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:840e3
[    0.000000] page:edf82fec count:0 mapcount:-1310720 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:84113
[    0.000000] page:edf836ac count:0 mapcount:-262144 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] [<c00155e8>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00120f4>] (show_stack) from [<c057294c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c057294c>] (dump_stack) from [<c00f0730>] (bad_page+0xc0/0x124)
[    0.000000] [<c00f0730>] (bad_page) from [<c00f08fc>] (free_pages_prepare+0x168/0x1bc)
[    0.000000] [<c00f08fc>] (free_pages_prepare) from [<c00f0dd8>] (__free_pages_ok+0x24/0x10c)
[    0.000000] [<c00f0dd8>] (__free_pages_ok) from [<c07f8db8>] (free_all_bootmem+0xf8/0x178)
[    0.000000] [<c07f8db8>] (free_all_bootmem) from [<c07dc044>] (mem_init+0x100/0x420)
[    0.000000] [<c07dc044>] (mem_init) from [<c07d69e4>] (start_kernel+0x1c8/0x3cc)
[    0.000000] [<c07d69e4>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] Memory: 274804K/1048576K available (5769K kernel code, 654K rwdata, 2220K rodata, 458K init, 8786K bss, 44608K reserved, 270336K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc07d58e4   (7991 kB)
[    0.000000]       .init : 0xc07d6000 - 0xc0848800   ( 458 kB)
[    0.000000]       .data : 0xc084a000 - 0xc08ed8f0   ( 655 kB)
[    0.000000]        .bss : 0xc08ed8f0 - 0xc1182410   (8787 kB)
[    0.000000] page:ee128024 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: VM_BUG_ON_PAGE((*(volatile int *)&(&page->_mapcount)->counter) != -1)
[    0.000000] ------------[ cut here ]------------
[    0.000000] Kernel BUG at c00f2a78 [verbose debug info unavailable]
[    0.000000] Internal error: Oops - BUG: 0 [#1] SMP ARM
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
[    0.000000] task: c0855dc0 ti: c084a000 task.ti: c084a000
[    0.000000] PC is at __rmqueue+0x618/0x644
[    0.000000] LR is at dump_page_badflags+0x6c/0x98
[    0.000000] pc : [<c00f2a78>]    lr : [<c00f0644>]    psr: 600001d3
[    0.000000] sp : c084bd78  ip : c084a000  fp : 00000009
[    0.000000] r10: 00000000  r9 : c08e7e40  r8 : 00000000
[    0.000000] r7 : 00000002  r6 : c08e7f24  r5 : c08e7f10  r4 : ee128024
[    0.000000] r3 : 00000000  r2 : 00000000  r1 : c084bcd0  r0 : 0000005a
[    0.000000] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    0.000000] Control: 10c5387d  Table: 80004059  DAC: 00000015
[    0.000000] Process swapper (pid: 0, stack limit = 0xc084a248)
[    0.000000] Stack: (0xc084bd78 to 0xc084c000)
[    0.000000] bd60:                                                       00000000 c00f2eb0
[    0.000000] bd80: 00000000 c109c8b7 c084a030 ee128000 00000000 00000001 c08e7ee0 c08e7f14
[    0.000000] bda0: 00000002 ee128014 c08e7e40 00000000 00000000 00000000 c0713a8c edebac9c
[    0.000000] bdc0: c08e7e40 00000001 c0713a78 c00f2ef8 00000141 00000530 2d674000 00000001
[    0.000000] bde0: 600001d3 c084a010 edebac9c 00000000 00224000 c0853834 ffffffff 00000000
[    0.000000] be00: c08e7ec0 00000000 00000100 00000000 c08e8bcc 00000001 c0846c90 2d674000
[    0.000000] be20: edebac98 00000000 00000000 c08e8bc4 000008c8 c08e7e40 00000000 00204000
[    0.000000] be40: 00000000 00000000 00000000 c0853508 00000000 c08e8bc0 00000000 c00f3514
[    0.000000] be60: 00000000 00000141 c08e7e40 00000000 00000000 c089f498 c109c178 00000001
[    0.000000] be80: 00000006 600001d3 00000000 c008a8d4 00000000 00000000 c082de98 00000000
[    0.000000] bea0: 00000000 00000000 00000001 00000000 c0128214 c0082fbc 00000001 00000080
[    0.000000] bec0: 00000000 c0128214 00000000 0000000e c084a038 600001d3 c1182410 c082de88
[    0.000000] bee0: c08e7e40 00000001 00000000 c1172d00 c082de88 c08a6830 c082de88 00000000
[    0.000000] bf00: 00004000 c1172d00 00000000 c082dea8 00200200 c012827c ffc00000 ffe00000
[    0.000000] bf20: c08a6840 c082deb8 00000000 00008000 00000000 c08a6830 c08a681c 00008000
[    0.000000] bf40: c07f82a8 600001d3 00008000 c084a018 00000000 c01289d8 00000060 00000000
[    0.000000] bf60: 55555556 c08a42b0 c07180cc 00000040 00002000 c10c5330 c08a67e8 c08ed900
[    0.000000] bf80: 00000000 c07f82a8 c08a42b0 c08a42b0 c08a67e8 c0853264 00000000 c07f9c8c
[    0.000000] bfa0: 00000000 ffffffff c08ed900 c08528c0 c0823d98 ee7ff3c0 c08ed900 c07d69e8
[    0.000000] bfc0: ffffffff ffffffff c07d65e8 00000000 00000000 c0823d98 c08edb14 c0852968
[    0.000000] bfe0: c0823d94 c085764c 80004059 412fc09a 00000000 80008074 00000000 00000000
[    0.000000] [<c00f2a78>] (__rmqueue) from [<c00f2ef8>] (get_page_from_freelist+0x454/0x770)
[    0.000000] [<c00f2ef8>] (get_page_from_freelist) from [<c00f3514>] (__alloc_pages_nodemask+0x114/0x96c)
[    0.000000] [<c00f3514>] (__alloc_pages_nodemask) from [<c012827c>] (cache_alloc_refill+0x39c/0x77c)
[    0.000000] [<c012827c>] (cache_alloc_refill) from [<c01289d8>] (kmem_cache_alloc+0x158/0x21c)
[    0.000000] [<c01289d8>] (kmem_cache_alloc) from [<c07f82a8>] (create_kmalloc_cache+0x20/0x7c)
[    0.000000] [<c07f82a8>] (create_kmalloc_cache) from [<c07f9c8c>] (kmem_cache_init+0xd0/0x244)
[    0.000000] [<c07f9c8c>] (kmem_cache_init) from [<c07d69e8>] (start_kernel+0x1cc/0x3cc)
[    0.000000] [<c07d69e8>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] Code: eaffff27 e1a00004 e59f1018 ebfff7b5 (e7f001f2) 
[    0.000000] ---[ end trace cb88537fdc8fa201 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/a53de65e/attachment-0001.sig>
