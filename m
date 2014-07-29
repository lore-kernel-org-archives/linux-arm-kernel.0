From: balbi@ti.com (Felipe Balbi)
Date: Tue, 29 Jul 2014 14:07:01 -0500
Subject: Bad Page dump (help)
Message-ID: <20140729190700.GN17808@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I'm bringing up a new board on today's linux-next but I'm having a bunch
of bad_page() calls due to _mapcount not being zero (full logs
attached). What could cause that ? Any hints on how to debug ? It's as
if page_mapcount_reset() wasn't called for the pages which are causing
issues.

Here's the first few such dumps:


[    0.000000] BUG: Bad page state in process swapper  pfn:8136d
[    0.000000] page:ee017da0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] Disabling lock debugging due to kernel taint
[    0.000000] BUG: Bad page state in process swapper  pfn:81375
[    0.000000] page:ee017ea0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81376
[    0.000000] page:ee017ec0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)

cheers

-- 
balbi
-------------- next part --------------
Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.16.0-rc7-next-20140729-00002-g4169dc8 (balbi at saruman) (gcc version 4.8.2 20130902 (prerelease) (crosstool-NG linaro-1.13.1-4.8-2013.09 - Linaro GCC 2013.09) ) #586 SMP Tue Jul 29 13:23:53 CDT 2014
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: TI AM437x Industrial Development Kit
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] cma: Reserved 16 MiB at ae800000
[    0.000000] Memory policy: Data cache writeback
[    0.000000] On node 0 totalpages: 262144
[    0.000000] free_area_init_node: node 0, pgdat c08c3c40, node_mem_map edff1000
[    0.000000]   Normal zone: 1520 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 194560 pages, LIFO batch:31
[    0.000000]   HighMem zone: 528 pages used for memmap
[    0.000000]   HighMem zone: 67584 pages, LIFO batch:15
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] AM437x ES1.1 (sgx neon )
[    0.000000] L2C: platform modifies aux control register: 0x0e030000 -> 0x3e430000
[    0.000000] L2C: DT/platform modifies aux control register: 0x0e030000 -> 0x3e430000
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 1 lines
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at arch/arm/mach-omap2/omap4-common.c:172 omap4_l2c310_write_sec+0x74/0xa8()
[    0.000000] OMAP L2C310: ignoring write to reg 0xf80
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c0042370>] (warn_slowpath_common+0x6c/0x90)
[    0.000000] [<c0042370>] (warn_slowpath_common) from [<c00423c4>] (warn_slowpath_fmt+0x30/0x40)
[    0.000000] [<c00423c4>] (warn_slowpath_fmt) from [<c002b658>] (omap4_l2c310_write_sec+0x74/0xa8)
[    0.000000] [<c002b658>] (omap4_l2c310_write_sec) from [<c07c7f44>] (l2c310_enable+0x12c/0x1f8)
[    0.000000] [<c07c7f44>] (l2c310_enable) from [<c07c7d90>] (__l2c_init+0x160/0x1e8)
[    0.000000] [<c07c7d90>] (__l2c_init) from [<c07c8490>] (l2x0_of_init+0x170/0x1a0)
[    0.000000] [<c07c8490>] (l2x0_of_init) from [<c07ce844>] (omap_l2_cache_init+0x60/0x98)
[    0.000000] [<c07ce844>] (omap_l2_cache_init) from [<c07c96b4>] (am43xx_init_early+0x58/0x80)
[    0.000000] [<c07c96b4>] (am43xx_init_early) from [<c07c4234>] (setup_arch+0x8c4/0x9a0)
[    0.000000] [<c07c4234>] (setup_arch) from [<c07c0898>] (start_kernel+0x7c/0x3a8)
[    0.000000] [<c07c0898>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] ---[ end trace cb88537fdc8fa200 ]---
[    0.000000] L2C-310 dynamic clock gating disabled, standby mode disabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 256 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c9, AUX_CTRL 0x7e430000
[    0.000000] PERCPU: Embedded 9 pages/cpu @edfb9000 s14336 r8192 d14336 u36864
[    0.000000] pcpu-alloc: s14336 r8192 d14336 u36864 alloc=9*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624
[    0.000000] Kernel command line: console=ttyO0,115200n8 root=/dev/mmcblk0p2 rw rootfstype=ext4 rootwait earlyprintk debug
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] BUG: Bad page state in process swapper  pfn:8136d
[    0.000000] page:ee017da0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] Disabling lock debugging due to kernel taint
[    0.000000] BUG: Bad page state in process swapper  pfn:81375
[    0.000000] page:ee017ea0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81376
[    0.000000] page:ee017ec0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81379
[    0.000000] page:ee017f20 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8137c
[    0.000000] page:ee017f80 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8137f
[    0.000000] page:ee017fe0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81382
[    0.000000] page:ee018040 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81385
[    0.000000] page:ee0180a0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81389
[    0.000000] page:ee018120 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8138a
[    0.000000] page:ee018140 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:816bb
[    0.000000] page:ee01e760 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:816c1
[    0.000000] page:ee01e820 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:816c4
[    0.000000] page:ee01e880 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:816c7
[    0.000000] page:ee01e8e0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:816ca
[    0.000000] page:ee01e940 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81843
[    0.000000] page:ee021860 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81858
[    0.000000] page:ee021b00 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8185b
[    0.000000] page:ee021b60 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8185e
[    0.000000] page:ee021bc0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81861
[    0.000000] page:ee021c20 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81867
[    0.000000] page:ee021ce0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8186a
[    0.000000] page:ee021d40 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8186d
[    0.000000] page:ee021da0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81870
[    0.000000] page:ee021e00 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81873
[    0.000000] page:ee021e60 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81876
[    0.000000] page:ee021ec0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81879
[    0.000000] page:ee021f20 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8187c
[    0.000000] page:ee021f80 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8187f
[    0.000000] page:ee021fe0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:8188f
[    0.000000] page:ee0221e0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81892
[    0.000000] page:ee022240 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81895
[    0.000000] page:ee0222a0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:81898
[    0.000000] page:ee022300 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:818a7
[    0.000000] page:ee0224e0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:818a8
[    0.000000] page:ee022500 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:818aa
[    0.000000] page:ee022540 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:818ab
[    0.000000] page:ee022560 count:0 mapcount:-11534336 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:818ad
[    0.000000] page:ee0225a0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:818ae
[    0.000000] page:ee0225c0 count:0 mapcount:-9699328 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:818b1
[    0.000000] page:ee022620 count:0 mapcount:-9437184 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:818c3
[    0.000000] page:ee022860 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:818c6
[    0.000000] page:ee0228c0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:818c9
[    0.000000] page:ee022920 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:818cc
[    0.000000] page:ee022980 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:819be
[    0.000000] page:ee0247c0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:819c3
[    0.000000] page:ee024860 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:819c7
[    0.000000] page:ee0248e0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:819cb
[    0.000000] page:ee024960 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:819cf
[    0.000000] page:ee0249e0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:819d3
[    0.000000] page:ee024a60 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:819d5
[    0.000000] page:ee024aa0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:819d7
[    0.000000] page:ee024ae0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:819d8
[    0.000000] page:ee024b00 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:819da
[    0.000000] page:ee024b40 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:819db
[    0.000000] page:ee024b60 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:819dd
[    0.000000] page:ee024ba0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:819de
[    0.000000] page:ee024bc0 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:819e0
[    0.000000] page:ee024c00 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:819e1
[    0.000000] page:ee024c20 count:0 mapcount:-3145728 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] BUG: Bad page state in process swapper  pfn:819e3
[    0.000000] page:ee024c60 count:0 mapcount:-1048576 mapping:  (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] page dumped because: nonzero mapcount
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8 #586
[    0.000000] [<c0015480>] (unwind_backtrace) from [<c0012078>] (show_stack+0x10/0x14)
[    0.000000] [<c0012078>] (show_stack) from [<c056063c>] (dump_stack+0x84/0x9c)
[    0.000000] [<c056063c>] (dump_stack) from [<c00ea7c8>] (bad_page+0xb8/0x118)
[    0.000000] [<c00ea7c8>] (bad_page) from [<c00ea974>] (free_pages_prepare+0x14c/0x1a0)
[    0.000000] [<c00ea974>] (free_pages_prepare) from [<c00eb390>] (__free_pages_ok+0x24/0xf4)
[    0.000000] [<c00eb390>] (__free_pages_ok) from [<c07e233c>] (free_all_bootmem+0xe8/0x168)
[    0.000000] [<c07e233c>] (free_all_bootmem) from [<c07c5f00>] (mem_init+0xf0/0x3ec)
[    0.000000] [<c07c5f00>] (mem_init) from [<c07c09e0>] (start_kernel+0x1c4/0x3a8)
[    0.000000] [<c07c09e0>] (start_kernel) from [<80008074>] (0x80008074)
[    0.000000] Memory: 248196K/1048576K available (5696K kernel code, 653K rwdata, 2204K rodata, 402K init, 8210K bss, 42864K reserved, 270336K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc07bf500   (7902 kB)
[    0.000000]       .init : 0xc07c0000 - 0xc0824800   ( 402 kB)
[    0.000000]       .data : 0xc0826000 - 0xc08c9670   ( 654 kB)
[    0.000000]        .bss : 0xc08c9670 - 0xc10ce110   (8211 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=2 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] GIC CPU mask not found - kernel will fail to boot.
[    0.000000] GIC CPU mask not found - kernel will fail to boot.
[    0.000000] OMAP clockevent source: timer2 at 24000000 Hz
[    0.000012] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956969942ns
[    0.008283] OMAP clocksource: timer1 at 24000000 Hz
[    0.013791] Console: colour dummy device 80x30
[    0.018477] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.026581] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.030893] ... MAX_LOCK_DEPTH:          48
[    0.035304] ... MAX_LOCKDEP_KEYS:        8191
[    0.039888] ... CLASSHASH_SIZE:          4096
[    0.044475] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.049145] ... MAX_LOCKDEP_CHAINS:      65536
[    0.053824] ... CHAINHASH_SIZE:          32768
[    0.058493]  memory used by lock dependency info: 5167 kB
[    0.064161]  per task-struct memory footprint: 1152 bytes
[    0.069829] Calibrating delay loop... 1993.93 BogoMIPS (lpj=9969664)
[    0.126701] pid_max: default: 32768 minimum: 301
[    0.131679] Security Framework initialized
[    0.136072] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.142985] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.151065] CPU: Testing write buffer coherency: ok
[    0.156629] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.162668] Setting up static identity map for 0x80569548 - 0x805695b8
[    0.171445] Brought up 1 CPUs
[    0.174656] SMP: Total of 1 processors activated.
[    0.179601] CPU: All CPU(s) started in SVC mode.
[    0.185296] devtmpfs: initialized
[    0.195897] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.047705] omap_hwmod: tptc0 using broken dt data from edma
[    0.053856] omap_hwmod: tptc1 using broken dt data from edma
[    0.016279] omap_hwmod: tptc2 using broken dt data from edma
[    0.040485] omap_hwmod: dss_dispc: cannot be enabled for reset (3)
[    0.050232] omap_hwmod: dss_rfbi: cannot be enabled for reset (3)
[    0.320899] pinctrl core: initialized pinctrl subsystem
[    0.327078] regulator-dummy: no parameters
[    0.341111] NET: Registered protocol family 16
[    0.352567] DMA: failed to allocate 256 KiB pool for atomic coherent allocation
[    0.361407] cpuidle: using governor ladder
[    0.365820] cpuidle: using governor menu
[    0.382712] platform 49000000.edma: alias fck already exists
[    0.388733] platform 49000000.edma: alias fck already exists
[    0.394686] platform 49000000.edma: alias fck already exists
[    0.401798] platform 44e3e000.rtc: Cannot lookup hwmod 'rtc'
[    0.408569] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.415345] OMAP GPIO hardware version 0.1
[    0.420232] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.427623] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.392798] platform 53701000.des: Cannot lookup hwmod 'des'
[    0.444388] No ATAGs?
[    0.446583] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/fc1be87c/attachment-0001.sig>
