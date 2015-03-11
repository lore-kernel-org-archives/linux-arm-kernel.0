From: stsp@list.ru (Stas Sergeev)
Date: Wed, 11 Mar 2015 20:56:50 +0300
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <20150311174618.GE8656@n2100.arm.linux.org.uk>
References: <54FF21BE.2040506@list.ru>
 <20150311175227.499612af@free-electrons.com> <55007ADD.6080505@list.ru>
 <20150311174618.GE8656@n2100.arm.linux.org.uk>
Message-ID: <550081E2.5030807@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

11.03.2015 20:46, Russell King - ARM Linux ?????:
> On Wed, Mar 11, 2015 at 08:26:53PM +0300, Stas Sergeev wrote:
>> Hello Thomas, thanks for that info!
>>
>> Is there a quick way to test that?
>> I used memmap=0x20000000$0xe0000000 but nothing changed...
> Use mem=0xe0000000 instead.  memmap= isn't supported on ARM.
>
It doesn't look like it works as intended.
Got the crash below.
Please note the mappings beyond 0xe0000000, so I wonder if
the option worked as expected?

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.0.0-rc2-00137-gb672c98-dirty
(root at host-010-117) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) )
#2 SMP W
ed Mar 11 17:03:41 MSK 2015
[    0.000000] CPU: ARMv7 Processor [562f5842] revision 2 (ARMv7),
cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction
cache
[    0.000000] Machine model: Marvell Armada XP Development Board
DB-MV784MP-GP
[    0.000000] Ignoring memory block 0x100000000 - 0x200000000
[    0.000000] memblock_reserve: [0x00000000008280-0x00000000700203]
flags 0x0 arm_memblock_init+0x20/0x18c
[    0.000000] memblock_reserve: [0x00000000004000-0x00000000007fff]
flags 0x0 arm_memblock_init+0x124/0x18c
[    0.000000] memblock_reserve: [0x00000000000000-0x000000000027ff]
flags 0x0 mvebu_scan_mem+0xa4/0xec
[    0.000000] memblock_reserve: [0x00000000000000-0x000000000027ff]
flags 0x0 mvebu_scan_mem+0xa4/0xec
[    0.000000] memblock_reserve: [0x00000000a41168-0x00000000a4535d]
flags 0x0 early_init_fdt_scan_reserved_mem+0x30/0x88
[    0.000000] MEMBLOCK configuration:
[    0.000000]  memory size = 0xe0000000 reserved size = 0x70297a
[    0.000000]  memory.cnt  = 0x1
[    0.000000]  memory[0x0]     [0x00000000000000-0x000000dfffffff],
0xe0000000 bytes flags: 0x0
[    0.000000]  reserved.cnt  = 0x4
[    0.000000]  reserved[0x0]   [0x00000000000000-0x000000000027ff],
0x2800 bytes flags: 0x0
[    0.000000]  reserved[0x1]   [0x00000000004000-0x00000000007fff],
0x4000 bytes flags: 0x0
[    0.000000]  reserved[0x2]   [0x00000000008280-0x00000000700203],
0x6f7f84 bytes flags: 0x0
[    0.000000]  reserved[0x3]   [0x00000000a41168-0x00000000a4535d],
0x41f6 bytes flags: 0x0
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] memblock_reserve: [0x0000002f7fe000-0x0000002f7fffff]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7fd000-0x0000002f7fdfff]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7fcfd8-0x0000002f7fcfff]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7fb000-0x0000002f7fbfff]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7fa000-0x0000002f7fafff]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7f9000-0x0000002f7f9fff]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 29360128 bytes
align=0x0 nid=0 from=0x0 max_addr=0x0 alloc_node_mem_map.constprop.66+0x6
0/0x90
[    0.000000] memblock_reserve: [0x0000002dbf9000-0x0000002f7f8fff]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 96 bytes align=0x0
nid=0 from=0x0 max_addr=0x0 free_area_init_node+0x2fc/0x3cc
[    0.000000] memblock_reserve: [0x0000002f7fcf40-0x0000002f7fcf9f]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 12288 bytes
align=0x0 nid=0 from=0x0 max_addr=0x0 zone_wait_table_init+0x80/0xf0
[    0.000000] memblock_reserve: [0x0000002dbf6000-0x0000002dbf8fff]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 356 bytes align=0x0
nid=0 from=0x0 max_addr=0x0 free_area_init_node+0x2fc/0x3cc
[    0.000000] memblock_reserve: [0x0000002f7fcdc0-0x0000002f7fcf23]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 49152 bytes
align=0x0 nid=0 from=0x0 max_addr=0x0 zone_wait_table_init+0x80/0xf0
[    0.000000] memblock_reserve: [0x0000002dbea000-0x0000002dbf5fff]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid: 28 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 setup_arch+0x4d4/0x8b0
[    0.000000] memblock_reserve: [0x0000002f7fcd80-0x0000002f7fcd9b]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_reserve: [0x0000002dbdf040-0x0000002dbe9fff]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7fcfc0-0x0000002f7fcfd7]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7fcfa8-0x0000002f7fcfbf]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7fcf28-0x0000002f7fcf3f]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7fcda4-0x0000002f7fcdbc]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7fcd64-0x0000002f7fcd7c]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7fcd48-0x0000002f7fcd60]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7fcd30-0x0000002f7fcd47]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_virt_alloc_try_nid: 98 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 start_kernel+0xb4/0x3a8
[    0.000000] memblock_reserve: [0x0000002f7fccc0-0x0000002f7fcd21]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid: 98 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 start_kernel+0xd8/0x3a8
[    0.000000] memblock_reserve: [0x0000002f7fcc40-0x0000002f7fcca1]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid: 98 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 start_kernel+0xfc/0x3a8
[    0.000000] memblock_reserve: [0x0000002f7fcbc0-0x0000002f7fcc21]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 4096 bytes align=0x0
nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_alloc_info+0x4c/0x8c
[    0.000000] memblock_reserve: [0x0000002dbde040-0x0000002dbdf03f]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 4096 bytes align=0x0
nid=-1 from=0x0 max_addr=0x0 pcpu_embed_first_chunk+0x4f0/0x788
[    0.000000] memblock_reserve: [0x0000002dbdd040-0x0000002dbde03f]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 163840 bytes
align=0x1000 nid=-1 from=0x3fffffff max_addr=0x0 pcpu_dfl_fc_alloc+0x28/0x3
0
[    0.000000] memblock_reserve: [0x0000002dbb5000-0x0000002dbdcfff]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] __memblock_free_early:
[0x0000002dbbf000-0x0000002dbbefff] pcpu_embed_first_chunk+0x608/0x788
[    0.000000] __memblock_free_early:
[0x0000002dbc9000-0x0000002dbc8fff] pcpu_embed_first_chunk+0x608/0x788
[    0.000000] __memblock_free_early:
[0x0000002dbd3000-0x0000002dbd2fff] pcpu_embed_first_chunk+0x608/0x788
[    0.000000] __memblock_free_early:
[0x0000002dbdd000-0x0000002dbdcfff] pcpu_embed_first_chunk+0x608/0x788
[    0.000000] PERCPU: Embedded 10 pages/cpu @edbb5000 s11584 r8192
d21184 u40960
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0xec/0x740
[    0.000000] memblock_reserve: [0x0000002f7fcb80-0x0000002f7fcb83]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x10c/0x740
[    0.000000] memblock_reserve: [0x0000002f7fcb40-0x0000002f7fcb43]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid: 16 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x12c/0x740
[    0.000000] memblock_reserve: [0x0000002f7fcb00-0x0000002f7fcb0f]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid: 16 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x14c/0x740
[    0.000000] memblock_reserve: [0x0000002f7fcac0-0x0000002f7fcacf]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid: 120 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x450/0x740
[    0.000000] memblock_reserve: [0x0000002f7fca40-0x0000002f7fcab7]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid: 68 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x498/0x740
[    0.000000] memblock_reserve: [0x0000002f7fc9c0-0x0000002f7fca03]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid: 68 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x5cc/0x740
[    0.000000] memblock_reserve: [0x0000002f7fc940-0x0000002f7fc983]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] __memblock_free_early:
[0x0000002dbde040-0x0000002dbdf03f] pcpu_embed_first_chunk+0x734/0x788
[    0.000000] __memblock_free_early:
[0x0000002dbdd040-0x0000002dbde03f] pcpu_embed_first_chunk+0x74c/0x788
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
Total pages: 915984
[    0.000000] Kernel command line: console=ttyS0,115200
earlyprintk=ttyS0 root=/dev/sda2 rw pm_disable memblock=debug mem=0xe0000000
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 12288 bytes
[    0.000000] log_buf_len min size: 16384 bytes
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 32768 bytes
align=0x4 nid=-1 from=0x0 max_addr=0x0 setup_log_buf+0xf8/0x1d4
[    0.000000] memblock_reserve: [0x0000002dbad000-0x0000002dbb4fff]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] log_buf_len: 32768 bytes
[    0.000000] early log buf free: 6336(38%)
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 16384 bytes
align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x158/0x250
[    0.000000] memblock_reserve: [0x0000002dba9000-0x0000002dbacfff]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 524288 bytes
align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x158/0x250
[    0.000000] memblock_reserve: [0x0000002db29000-0x0000002dba8fff]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288
bytes)
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 262144 bytes
align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x158/0x250
[    0.000000] memblock_reserve: [0x0000002dae9000-0x0000002db28fff]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes)
[    0.000000] Memory: 3633048K/3670016K available (5068K kernel code,
241K rwdata, 1380K rodata, 252K init, 190K bss, 36968K reserved, 0K c
ma-reserved, 2891776K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06543d0   (6449 kB)
[    0.000000]       .init : 0xc0655000 - 0xc0694000   ( 252 kB)
[    0.000000]       .data : 0xc0694000 - 0xc06d0740   ( 242 kB)
[    0.000000]        .bss : 0xc06d0740 - 0xc0700204   ( 191 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Additional per-CPU info printed with stalls.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] Aurora cache controller enabled, 32 ways, 2048 kB
[    0.000000] Aurora: CACHE_ID 0x00000100, AUX_CTRL 0x1a69ef12
[    0.000006] sched_clock: 32 bits at 25MHz, resolution 40ns, wraps
every 171798691800ns
[    0.000242] Console: colour dummy device 80x30
[    0.000258] Calibrating delay loop... 1594.16 BogoMIPS (lpj=7970816)
[    0.090072] pid_max: default: 32768 minimum: 301
[    0.090142] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.090148] Mountpoint-cache hash table entries: 2048 (order: 1, 8192
bytes)
[    0.090398] CPU: Testing write buffer coherency: vmalloc: mapping
page ee1a13e0 (0x0002d41f000) at 0xf001e000
[    0.090414] vmalloc: mapping page ee1a13e0 (0x0002d41f000) at 0xf0020000
[    0.090421] ok
[    0.090523] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.090872] Setting up static identity map for 0x4cece8 - 0x4ced40
[    0.091062] mvebu-soc-id: MVEBU SoC ID=0x7846, Rev=0x2
[    0.091146] mvebu-pmsu: Initializing Power Management Service Unit
[    0.091805] Booting CPU 1
[    0.180067] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.180270] Booting CPU 2
[    0.220067] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.220263] Booting CPU 3
[    0.260067] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.260108] Brought up 4 CPUs
[    0.260116] SMP: Total of 4 processors activated (6376.65 BogoMIPS).
[    0.260120] CPU: All CPU(s) started in SVC mode.
[    0.260387] devtmpfs: initialized
[    0.260725] VFP support v0.3: implementor 56 architecture 2 part 20
variant 9 rev 6
[    0.260899] pinctrl core: initialized pinctrl subsystem
[    0.262846] NET: Registered protocol family 16
[    0.263024] vmalloc: mapping page ee1a3800 (0x0002d540000) at 0xf002c000
[    0.263030] vmalloc: mapping page ee1a3820 (0x0002d541000) at 0xf002d000
[    0.263034] vmalloc: mapping page ee1a3840 (0x0002d542000) at 0xf002e000
[    0.263039] vmalloc: mapping page ee1a3860 (0x0002d543000) at 0xf002f000
[    0.263043] vmalloc: mapping page ee1a3880 (0x0002d544000) at 0xf0030000
[    0.263047] vmalloc: mapping page ee1a38a0 (0x0002d545000) at 0xf0031000
[    0.263051] vmalloc: mapping page ee1a38c0 (0x0002d546000) at 0xf0032000
[    0.263055] vmalloc: mapping page ee1a38e0 (0x0002d547000) at 0xf0033000
[    0.263059] vmalloc: mapping page ee1a3900 (0x0002d548000) at 0xf0034000
[    0.263063] vmalloc: mapping page ee1a3920 (0x0002d549000) at 0xf0035000
[    0.263068] vmalloc: mapping page ee1a3940 (0x0002d54a000) at 0xf0036000
[    0.263072] vmalloc: mapping page ee1a3960 (0x0002d54b000) at 0xf0037000
[    0.263076] vmalloc: mapping page ee1a3980 (0x0002d54c000) at 0xf0038000
[    0.263080] vmalloc: mapping page ee1a39a0 (0x0002d54d000) at 0xf0039000
[    0.263084] vmalloc: mapping page ee1a39c0 (0x0002d54e000) at 0xf003a000
[    0.263088] vmalloc: mapping page ee1a39e0 (0x0002d54f000) at 0xf003b000
[    0.263092] vmalloc: mapping page ee1a3a00 (0x0002d550000) at 0xf003c000
[    0.263096] vmalloc: mapping page ee1a3a20 (0x0002d551000) at 0xf003d000
[    0.263101] vmalloc: mapping page ee1a3a40 (0x0002d552000) at 0xf003e000
[    0.263105] vmalloc: mapping page ee1a3a60 (0x0002d553000) at 0xf003f000
[    0.263109] vmalloc: mapping page ee1a3a80 (0x0002d554000) at 0xf0040000
[    0.263113] vmalloc: mapping page ee1a3aa0 (0x0002d555000) at 0xf0041000
[    0.263117] vmalloc: mapping page ee1a3ac0 (0x0002d556000) at 0xf0042000
[    0.263121] vmalloc: mapping page ee1a3ae0 (0x0002d557000) at 0xf0043000
[    0.263125] vmalloc: mapping page ee1a3b00 (0x0002d558000) at 0xf0044000
[    0.263130] vmalloc: mapping page ee1a3b20 (0x0002d559000) at 0xf0045000
[    0.263134] vmalloc: mapping page ee1a3b40 (0x0002d55a000) at 0xf0046000
[    0.263138] vmalloc: mapping page ee1a3b60 (0x0002d55b000) at 0xf0047000
[    0.263142] vmalloc: mapping page ee1a3b80 (0x0002d55c000) at 0xf0048000
[    0.263146] vmalloc: mapping page ee1a3ba0 (0x0002d55d000) at 0xf0049000
[    0.263150] vmalloc: mapping page ee1a3bc0 (0x0002d55e000) at 0xf004a000
[    0.263154] vmalloc: mapping page ee1a3be0 (0x0002d55f000) at 0xf004b000
[    0.263158] vmalloc: mapping page ee1a3c00 (0x0002d560000) at 0xf004c000
[    0.263163] vmalloc: mapping page ee1a3c20 (0x0002d561000) at 0xf004d000
[    0.263167] vmalloc: mapping page ee1a3c40 (0x0002d562000) at 0xf004e000
[    0.263171] vmalloc: mapping page ee1a3c60 (0x0002d563000) at 0xf004f000
[    0.263175] vmalloc: mapping page ee1a3c80 (0x0002d564000) at 0xf0050000
[    0.263179] vmalloc: mapping page ee1a3ca0 (0x0002d565000) at 0xf0051000
[    0.263183] vmalloc: mapping page ee1a3cc0 (0x0002d566000) at 0xf0052000
[    0.263187] vmalloc: mapping page ee1a3ce0 (0x0002d567000) at 0xf0053000
[    0.263191] vmalloc: mapping page ee1a3d00 (0x0002d568000) at 0xf0054000
[    0.263196] vmalloc: mapping page ee1a3d20 (0x0002d569000) at 0xf0055000
[    0.263200] vmalloc: mapping page ee1a3d40 (0x0002d56a000) at 0xf0056000
[    0.263204] vmalloc: mapping page ee1a3d60 (0x0002d56b000) at 0xf0057000
[    0.263208] vmalloc: mapping page ee1a3d80 (0x0002d56c000) at 0xf0058000
[    0.263212] vmalloc: mapping page ee1a3da0 (0x0002d56d000) at 0xf0059000
[    0.263216] vmalloc: mapping page ee1a3dc0 (0x0002d56e000) at 0xf005a000
[    0.263220] vmalloc: mapping page ee1a3de0 (0x0002d56f000) at 0xf005b000
[    0.263224] vmalloc: mapping page ee1a3e00 (0x0002d570000) at 0xf005c000
[    0.263228] vmalloc: mapping page ee1a3e20 (0x0002d571000) at 0xf005d000
[    0.263233] vmalloc: mapping page ee1a3e40 (0x0002d572000) at 0xf005e000
[    0.263237] vmalloc: mapping page ee1a3e60 (0x0002d573000) at 0xf005f000
[    0.263241] vmalloc: mapping page ee1a3e80 (0x0002d574000) at 0xf0060000
[    0.263245] vmalloc: mapping page ee1a3ea0 (0x0002d575000) at 0xf0061000
[    0.263249] vmalloc: mapping page ee1a3ec0 (0x0002d576000) at 0xf0062000
[    0.263253] vmalloc: mapping page ee1a3ee0 (0x0002d577000) at 0xf0063000
[    0.263257] vmalloc: mapping page ee1a3f00 (0x0002d578000) at 0xf0064000
[    0.263261] vmalloc: mapping page ee1a3f20 (0x0002d579000) at 0xf0065000
[    0.263266] vmalloc: mapping page ee1a3f40 (0x0002d57a000) at 0xf0066000
[    0.263270] vmalloc: mapping page ee1a3f60 (0x0002d57b000) at 0xf0067000
[    0.263274] vmalloc: mapping page ee1a3f80 (0x0002d57c000) at 0xf0068000
[    0.263278] vmalloc: mapping page ee1a3fa0 (0x0002d57d000) at 0xf0069000
[    0.263282] vmalloc: mapping page ee1a3fc0 (0x0002d57e000) at 0xf006a000
[    0.263286] vmalloc: mapping page ee1a3fe0 (0x0002d57f000) at 0xf006b000
[    0.263292] DMA: preallocated 256 KiB pool for atomic coherent
allocations
[    0.290044] cpuidle: using governor ladder
[    0.330042] cpuidle: using governor menu
[    0.370314] vmalloc: mapping page ef7f1000 (0x000dfc00000) at 0xfedd8000
[    0.370321] vmalloc: mapping page ef7f1020 (0x000dfc01000) at 0xfedd9000
[    0.370326] vmalloc: mapping page ef7f1040 (0x000dfc02000) at 0xfedda000
[    0.370330] vmalloc: mapping page ef7f1060 (0x000dfc03000) at 0xfede2000
[    0.370335] vmalloc: mapping page ef7f1080 (0x000dfc04000) at 0xfede3000
[    0.370339] vmalloc: mapping page ef7f10a0 (0x000dfc05000) at 0xfede4000
[    0.370343] vmalloc: mapping page ef7f10c0 (0x000dfc06000) at 0xfedec000
[    0.370347] vmalloc: mapping page ef7f10e0 (0x000dfc07000) at 0xfeded000
[    0.370351] vmalloc: mapping page ef7f1100 (0x000dfc08000) at 0xfedee000
[    0.370356] vmalloc: mapping page ef7f1120 (0x000dfc09000) at 0xfedf6000
[    0.370360] vmalloc: mapping page ef7f1140 (0x000dfc0a000) at 0xfedf7000
[    0.370364] vmalloc: mapping page ef7f1160 (0x000dfc0b000) at 0xfedf8000
[    0.370637] vgaarb: loaded
[    0.370785] SCSI subsystem initialized
[    0.371076] usbcore: registered new interface driver usbfs
[    0.371117] usbcore: registered new interface driver hub
[    0.371157] usbcore: registered new device driver usb
[    0.371400] Advanced Linux Sound Architecture Driver Initialized.
[    0.371720] Bluetooth: Core ver 2.20
[    0.371746] NET: Registered protocol family 31
[    0.371751] Bluetooth: HCI device and connection manager initialized
[    0.371759] Bluetooth: HCI socket layer initialized
[    0.371766] Bluetooth: L2CAP socket layer initialized
[    0.371783] Bluetooth: SCO socket layer initialized
[    0.371949] cfg80211: Calling CRDA to update world regulatory domain
[    0.372091] Switched to clocksource armada_370_xp_clocksource
[    0.378642] NET: Registered protocol family 2
[    0.378962] TCP established hash table entries: 8192 (order: 3, 32768
bytes)
[    0.379000] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.379053] TCP: Hash tables configured (established 8192 bind 8192)
[    0.379086] TCP: reno registered
[    0.379094] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.379113] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.379221] NET: Registered protocol family 1
[    0.379382] RPC: Registered named UNIX socket transport module.
[    0.379387] RPC: Registered udp transport module.
[    0.379391] RPC: Registered tcp transport module.
[    0.379395] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.380297] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.380870] vmalloc: mapping page ef7f13e0 (0x000dfc1f000) at 0xfeddb000
[    0.380879] vmalloc: mapping page ef7f1400 (0x000dfc20000) at 0xfeddc000
[    0.380884] vmalloc: mapping page ef7f1420 (0x000dfc21000) at 0xfeddd000
[    0.380889] vmalloc: mapping page ef7f1440 (0x000dfc22000) at 0xfede5000
[    0.380893] vmalloc: mapping page ef7f1460 (0x000dfc23000) at 0xfede6000
[    0.380897] vmalloc: mapping page ef7f1480 (0x000dfc24000) at 0xfede7000
[    0.380902] vmalloc: mapping page ef7f14a0 (0x000dfc25000) at 0xfedef000
[    0.380906] vmalloc: mapping page ef7f14c0 (0x000dfc26000) at 0xfedf0000
[    0.380910] vmalloc: mapping page ef7f14e0 (0x000dfc27000) at 0xfedf1000
[    0.380915] vmalloc: mapping page ef7f1500 (0x000dfc28000) at 0xfedf9000
[    0.380919] vmalloc: mapping page ef7f1520 (0x000dfc29000) at 0xfedfa000
[    0.380923] vmalloc: mapping page ef7f1540 (0x000dfc2a000) at 0xfedfb000
[    0.381311] bounce: pool size: 64 pages
[    0.381351] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 252)
[    0.381363] io scheduler noop registered
[    0.381371] io scheduler deadline registered
[    0.381400] io scheduler cfq registered (default)
[    0.382125] armada-xp-pinctrl f1018000.pin-ctrl: registered pinctrl
driver
[    0.382467] irq: Cannot allocate irq_descs @ IRQ45, assuming
pre-allocated
[    0.382679] irq: Cannot allocate irq_descs @ IRQ77, assuming
pre-allocated
[    0.382811] irq: Cannot allocate irq_descs @ IRQ109, assuming
pre-allocated
[    0.383152] mvebu-pcie soc:pcie-controller: PCI host bridge to bus
0000:00
[    0.383163] pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
[    0.383171] pci_bus 0000:00: root bus resource [mem
0xf8000000-0xffdfffff]
[    0.383178] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.383549] PCI: bus0: Fast back to back transfers disabled
[    0.383557] pci 0000:00:01.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.383566] pci 0000:00:09.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.383573] pci 0000:00:0a.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.383655] PCI: bus1: Fast back to back transfers enabled
[    0.384050] PCI: bus2: Fast back to back transfers disabled
[    0.384138] PCI: bus3: Fast back to back transfers enabled
[    0.384200] pci 0000:00:09.0: BAR 8: assigned [mem 0xf8000000-0xf80fffff]
[    0.384207] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.384219] pci 0000:02:00.0: BAR 2: assigned [mem
0xf8000000-0xf803ffff 64bit]
[    0.384236] pci 0000:02:00.0: BAR 0: assigned [mem
0xf8040000-0xf805ffff 64bit]
[    0.384252] pci 0000:02:00.0: BAR 6: assigned [mem
0xf8060000-0xf806ffff pref]
[    0.384259] pci 0000:00:09.0: PCI bridge to [bus 02]
[    0.384265] pci 0000:00:09.0:   bridge window [mem 0xf8000000-0xf80fffff]
[    0.384272] pci 0000:00:0a.0: PCI bridge to [bus 03]
[    0.384379] mv_xor f1060900.xor: Marvell shared XOR driver
[    0.402098] mv_xor f1060900.xor: Self-test copy failed compare, disabling
[    0.402165] mv_xor f10f0900.xor: Marvell shared XOR driver
[    0.422111] mv_xor f10f0900.xor: Self-test copy failed compare, disabling
[    0.456847] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.457913] console [ttyS0] disabled
[    0.477982] f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 19,
base_baud = 15625000) is a 16550A
[    2.611752] console [ttyS0] enabled
[    2.635762] f1012100.serial: ttyS1 at MMIO 0xf1012100 (irq = 20,
base_baud = 15625000) is a 16550A
[    2.665671] f1012200.serial: ttyS2 at MMIO 0xf1012200 (irq = 32,
base_baud = 15625000) is a 16550A
[    2.695764] f1012300.serial: ttyS3 at MMIO 0xf1012300 (irq = 33,
base_baud = 15625000) is a 16550A
[    2.705352] mvsas 0000:02:00.0: mvsas: driver version 0.8.16
[    2.711036] pci 0000:00:09.0: enabling device (0140 -> 0142)
[    2.717199] mvsas 0000:02:00.0: mvsas: PCI-E x4, Bandwidth Usage: 2.5
Gbps
[    5.962103] scsi host0: mvsas
[    6.122188] Unable to handle kernel NULL pointer dereference at
virtual address 000002d4
[    6.130298] pgd = c0004000
[    6.133022] [000002d4] *pgd=00000000
[    6.136617] Internal error: Oops: 5 [#1] SMP ARM
[    6.141244] Modules linked in:
[    6.144317] CPU: 0 PID: 6 Comm: kworker/u8:0 Not tainted
4.0.0-rc2-00137-gb672c98-dirty #2
[    6.152600] Hardware name: Marvell Armada 370/XP (Device Tree)
[    6.158452] Workqueue: events_unbound async_run_entry_fn
[    6.163786] task: ed426c00 ti: ed452000 task.ti: ed452000
[    6.169196] PC is at 0x0
[    6.171734] LR is at 0xfafeff5c
[    6.174883] pc : [<00000000>]    lr : [<fafeff5c>]    psr: 00000000
[    6.174883] sp : ffd6d7ff  ip : 00000000  fp : 00000200
[    6.186388] r10: ed453d90  r9 : 00000001  r8 : 00000000
[    6.191624] r7 : ed5857c0  r6 : 00000000  r5 : ed80c60a  r4 : 00000000
[    6.198166] r3 : 76c06305  r2 : c200f010  r1 : 00000000  r0 : 00000000
[    6.204709] Flags: nzcv  IRQs on  FIQs on  Mode USER_26  ISA ARM 
Segment kernel
[    6.212121] Control: 10c5387d  Table: 0000406a  DAC: 00000015
[    6.217880] Process kworker/u8:0 (pid: 6, stack limit = 0xed452220)
[    6.224183] ---[ end trace 93bf56ab1670c925 ]---
[    6.228824] Unable to handle kernel NULL pointer dereference at
virtual address 000002d4
