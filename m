From: stsp@list.ru (Stas Sergeev)
Date: Wed, 11 Mar 2015 15:30:33 +0300
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <20150310173807.GU8656@n2100.arm.linux.org.uk>
References: <54FF21BE.2040506@list.ru>
 <20150310171751.GD13687@e104818-lin.cambridge.arm.com>
 <54FF2986.6020503@list.ru> <20150310173807.GU8656@n2100.arm.linux.org.uk>
Message-ID: <55003569.1010200@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> Let's see whether we can get some debug from vmalloc to work out what's
> going on - can you also apply the patch below.
>
> Also, if you could include details about how much memory your platform
> has, and where it's located, that would be useful - passing
> memblock=debug
> should allow us to see what's going on at the memblock level.
>
> Also, the full kernel boot log would be useful to see. 
OK, here we go.

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.0.0-rc2-00137-gb672c98-dirty
(root at host-010-117) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) )
#60 SMP5
[    0.000000] CPU: ARMv7 Processor [562f5842] revision 2 (ARMv7),
cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction
cache
[    0.000000] Machine model: Marvell Armada XP Development Board
DB-MV784MP-GP
[    0.000000] Ignoring memory block 0x100000000 - 0x200000000
[    0.000000] memblock_reserve: [0x00000000008280-0x00000000700203]
flags 0x0 arm_memblock_init+0x20/0x18c
[    0.000000] memblock_reserve: [0x00000001100040-0x0000000142fad3]
flags 0x0 arm_memblock_init+0x100/0x18c
[    0.000000] memblock_reserve: [0x00000000004000-0x00000000007fff]
flags 0x0 arm_memblock_init+0x124/0x18c
[    0.000000] memblock_reserve: [0x00000000000000-0x000000000027ff]
flags 0x0 mvebu_scan_mem+0xa4/0xec
[    0.000000] memblock_reserve: [0x00000000000000-0x000000000027ff]
flags 0x0 mvebu_scan_mem+0xa4/0xec
[    0.000000] memblock_reserve: [0x00000000a41970-0x00000000a45b99]
flags 0x0 early_init_fdt_scan_reserved_mem+0x30/0x88
[    0.000000] MEMBLOCK configuration:
[    0.000000]  memory size = 0xf0000000 reserved size = 0xa32442
[    0.000000]  memory.cnt  = 0x1
[    0.000000]  memory[0x0]     [0x00000000000000-0x000000efffffff],
0xf0000000 bytes flags: 0x0
[    0.000000]  reserved.cnt  = 0x5
[    0.000000]  reserved[0x0]   [0x00000000000000-0x000000000027ff],
0x2800 bytes flags: 0x0
[    0.000000]  reserved[0x1]   [0x00000000004000-0x00000000007fff],
0x4000 bytes flags: 0x0
[    0.000000]  reserved[0x2]   [0x00000000008280-0x00000000700203],
0x6f7f84 bytes flags: 0x0
[    0.000000]  reserved[0x3]   [0x00000000a41970-0x00000000a45b99],
0x422a bytes flags: 0x0
[    0.000000]  reserved[0x4]   [0x00000001100040-0x0000000142fad3],
0x32fa94 bytes flags: 0x0
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
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 31457280 bytes
align=0x0 nid=0 from=0x0 max_addr=0x0 alloc_node_mem_map.constprop.66+0x0
[    0.000000] memblock_reserve: [0x0000002d9f9000-0x0000002f7f8fff]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 96 bytes align=0x0
nid=0 from=0x0 max_addr=0x0 free_area_init_node+0x2fc/0x3cc
[    0.000000] memblock_reserve: [0x0000002f7fcf40-0x0000002f7fcf9f]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 12288 bytes
align=0x0 nid=0 from=0x0 max_addr=0x0 zone_wait_table_init+0x80/0xf0
[    0.000000] memblock_reserve: [0x0000002d9f6000-0x0000002d9f8fff]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 388 bytes align=0x0
nid=0 from=0x0 max_addr=0x0 free_area_init_node+0x2fc/0x3cc
[    0.000000] memblock_reserve: [0x0000002f7fcd80-0x0000002f7fcf03]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 49152 bytes
align=0x0 nid=0 from=0x0 max_addr=0x0 zone_wait_table_init+0x80/0xf0
[    0.000000] memblock_reserve: [0x0000002d9ea000-0x0000002d9f5fff]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid: 28 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 setup_arch+0x4d4/0x8b0
[    0.000000] memblock_reserve: [0x0000002f7fcd40-0x0000002f7fcd5b]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_reserve: [0x0000002d9defd8-0x0000002d9e9fff]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7fcfc0-0x0000002f7fcfd7]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7fcfa8-0x0000002f7fcfbf]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7fcf28-0x0000002f7fcf3f]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7fcf0c-0x0000002f7fcf24]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7fcd64-0x0000002f7fcd7c]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7fcd24-0x0000002f7fcd3c]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_reserve: [0x0000002f7fcd0c-0x0000002f7fcd23]
flags 0x0 memblock_alloc_range_nid+0x30/0x44
[    0.000000] memblock_virt_alloc_try_nid: 83 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 start_kernel+0xb4/0x3a8
[    0.000000] memblock_reserve: [0x0000002f7fcc80-0x0000002f7fccd2]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid: 83 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 start_kernel+0xd8/0x3a8
[    0.000000] memblock_reserve: [0x0000002f7fcc00-0x0000002f7fcc52]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid: 83 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 start_kernel+0xfc/0x3a8
[    0.000000] memblock_reserve: [0x0000002f7fcb80-0x0000002f7fcbd2]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 4096 bytes align=0x0
nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_alloc_info+0x4c/0x8c
[    0.000000] memblock_reserve: [0x0000002d9ddfc0-0x0000002d9defbf]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 4096 bytes align=0x0
nid=-1 from=0x0 max_addr=0x0 pcpu_embed_first_chunk+0x4f0/0x788
[    0.000000] memblock_reserve: [0x0000002d9dcfc0-0x0000002d9ddfbf]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 163840 bytes
align=0x1000 nid=-1 from=0x3fffffff max_addr=0x0 pcpu_dfl_fc_alloc+0x28/0x0
[    0.000000] memblock_reserve: [0x0000002d9b4000-0x0000002d9dbfff]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] __memblock_free_early:
[0x0000002d9be000-0x0000002d9bdfff] pcpu_embed_first_chunk+0x608/0x788
[    0.000000] __memblock_free_early:
[0x0000002d9c8000-0x0000002d9c7fff] pcpu_embed_first_chunk+0x608/0x788
[    0.000000] __memblock_free_early:
[0x0000002d9d2000-0x0000002d9d1fff] pcpu_embed_first_chunk+0x608/0x788
[    0.000000] __memblock_free_early:
[0x0000002d9dc000-0x0000002d9dbfff] pcpu_embed_first_chunk+0x608/0x788
[    0.000000] PERCPU: Embedded 10 pages/cpu @ed9b4000 s11584 r8192
d21184 u40960
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1
from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0xec/0x740
[    0.000000] memblock_reserve: [0x0000002f7fcd00-0x0000002f7fcd03]
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
[0x0000002d9ddfc0-0x0000002d9defbf] pcpu_embed_first_chunk+0x734/0x788
[    0.000000] __memblock_free_early:
[0x0000002d9dcfc0-0x0000002d9ddfbf] pcpu_embed_first_chunk+0x74c/0x788
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
Total pages: 981520
[    0.000000] Kernel command line: console=ttyS0,115200
earlyprintk=ttyS0 root=/dev/sda2 rw pm_disable memblock=debug
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 12288 bytes
[    0.000000] log_buf_len min size: 16384 bytes
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 32768 bytes
align=0x4 nid=-1 from=0x0 max_addr=0x0 setup_log_buf+0xf8/0x1d4
[    0.000000] memblock_reserve: [0x0000002d9ac000-0x0000002d9b3fff]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] log_buf_len: 32768 bytes
[    0.000000] early log buf free: 6140(37%)
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 16384 bytes
align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x158/0x250
[    0.000000] memblock_reserve: [0x0000002d9a8000-0x0000002d9abfff]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 524288 bytes
align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x158/0x250
[    0.000000] memblock_reserve: [0x0000002d928000-0x0000002d9a7fff]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288
bytes)
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 262144 bytes
align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x158/0x250
[    0.000000] memblock_reserve: [0x0000002d8e8000-0x0000002d927fff]
flags 0x0 memblock_virt_alloc_internal+0x104/0x154
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes)
[    0.000000] Memory: 3889876K/3932160K available (5068K kernel code,
241K rwdata, 1380K rodata, 252K init, 190K bss, 42284K reserved, 0K )
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
[    0.000244] Console: colour dummy device 80x30
[    0.000260] Calibrating delay loop... 1594.16 BogoMIPS (lpj=7970816)
[    0.090071] pid_max: default: 32768 minimum: 301
[    0.090140] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.090147] Mountpoint-cache hash table entries: 2048 (order: 1, 8192
bytes)
[    0.090396] CPU: Testing write buffer coherency: vmalloc: mapping
page edfa13e0 (0x0002d41f000) at 0xf001e000
[    0.090411] vmalloc: mapping page edfa13e0 (0x0002d41f000) at 0xf0020000
[    0.090419] ok
[    0.090520] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.090869] Setting up static identity map for 0x4cecd8 - 0x4ced30
[    0.091058] mvebu-soc-id: MVEBU SoC ID=0x7846, Rev=0x2
[    0.091143] mvebu-pmsu: Initializing Power Management Service Unit
[    0.091803] Booting CPU 1
[    0.180066] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.180268] Booting CPU 2
[    0.220065] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.220261] Booting CPU 3
[    0.260065] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.260106] Brought up 4 CPUs
[    0.260114] SMP: Total of 4 processors activated (6376.65 BogoMIPS).
[    0.260118] CPU: All CPU(s) started in SVC mode.
[    0.260383] devtmpfs: initialized
[    0.260709] VFP support v0.3: implementor 56 architecture 2 part 20
variant 9 rev 6
[    0.260882] pinctrl core: initialized pinctrl subsystem
[    0.262831] NET: Registered protocol family 16
[    0.263004] vmalloc: mapping page edfa3800 (0x0002d540000) at 0xf002c000
[    0.263009] vmalloc: mapping page edfa3820 (0x0002d541000) at 0xf002d000
[    0.263014] vmalloc: mapping page edfa3840 (0x0002d542000) at 0xf002e000
[    0.263018] vmalloc: mapping page edfa3860 (0x0002d543000) at 0xf002f000
[    0.263022] vmalloc: mapping page edfa3880 (0x0002d544000) at 0xf0030000
[    0.263026] vmalloc: mapping page edfa38a0 (0x0002d545000) at 0xf0031000
[    0.263030] vmalloc: mapping page edfa38c0 (0x0002d546000) at 0xf0032000
[    0.263035] vmalloc: mapping page edfa38e0 (0x0002d547000) at 0xf0033000
[    0.263039] vmalloc: mapping page edfa3900 (0x0002d548000) at 0xf0034000
[    0.263043] vmalloc: mapping page edfa3920 (0x0002d549000) at 0xf0035000
[    0.263047] vmalloc: mapping page edfa3940 (0x0002d54a000) at 0xf0036000
[    0.263051] vmalloc: mapping page edfa3960 (0x0002d54b000) at 0xf0037000
[    0.263055] vmalloc: mapping page edfa3980 (0x0002d54c000) at 0xf0038000
[    0.263060] vmalloc: mapping page edfa39a0 (0x0002d54d000) at 0xf0039000
[    0.263064] vmalloc: mapping page edfa39c0 (0x0002d54e000) at 0xf003a000
[    0.263068] vmalloc: mapping page edfa39e0 (0x0002d54f000) at 0xf003b000
[    0.263072] vmalloc: mapping page edfa3a00 (0x0002d550000) at 0xf003c000
[    0.263076] vmalloc: mapping page edfa3a20 (0x0002d551000) at 0xf003d000
[    0.263080] vmalloc: mapping page edfa3a40 (0x0002d552000) at 0xf003e000
[    0.263084] vmalloc: mapping page edfa3a60 (0x0002d553000) at 0xf003f000
[    0.263088] vmalloc: mapping page edfa3a80 (0x0002d554000) at 0xf0040000
[    0.263093] vmalloc: mapping page edfa3aa0 (0x0002d555000) at 0xf0041000
[    0.263097] vmalloc: mapping page edfa3ac0 (0x0002d556000) at 0xf0042000
[    0.263101] vmalloc: mapping page edfa3ae0 (0x0002d557000) at 0xf0043000
[    0.263105] vmalloc: mapping page edfa3b00 (0x0002d558000) at 0xf0044000
[    0.263109] vmalloc: mapping page edfa3b20 (0x0002d559000) at 0xf0045000
[    0.263113] vmalloc: mapping page edfa3b40 (0x0002d55a000) at 0xf0046000
[    0.263117] vmalloc: mapping page edfa3b60 (0x0002d55b000) at 0xf0047000
[    0.263122] vmalloc: mapping page edfa3b80 (0x0002d55c000) at 0xf0048000
[    0.263126] vmalloc: mapping page edfa3ba0 (0x0002d55d000) at 0xf0049000
[    0.263130] vmalloc: mapping page edfa3bc0 (0x0002d55e000) at 0xf004a000
[    0.263134] vmalloc: mapping page edfa3be0 (0x0002d55f000) at 0xf004b000
[    0.263138] vmalloc: mapping page edfa3c00 (0x0002d560000) at 0xf004c000
[    0.263142] vmalloc: mapping page edfa3c20 (0x0002d561000) at 0xf004d000
[    0.263146] vmalloc: mapping page edfa3c40 (0x0002d562000) at 0xf004e000
[    0.263151] vmalloc: mapping page edfa3c60 (0x0002d563000) at 0xf004f000
[    0.263155] vmalloc: mapping page edfa3c80 (0x0002d564000) at 0xf0050000
[    0.263159] vmalloc: mapping page edfa3ca0 (0x0002d565000) at 0xf0051000
[    0.263163] vmalloc: mapping page edfa3cc0 (0x0002d566000) at 0xf0052000
[    0.263167] vmalloc: mapping page edfa3ce0 (0x0002d567000) at 0xf0053000
[    0.263171] vmalloc: mapping page edfa3d00 (0x0002d568000) at 0xf0054000
[    0.263175] vmalloc: mapping page edfa3d20 (0x0002d569000) at 0xf0055000
[    0.263179] vmalloc: mapping page edfa3d40 (0x0002d56a000) at 0xf0056000
[    0.263184] vmalloc: mapping page edfa3d60 (0x0002d56b000) at 0xf0057000
[    0.263188] vmalloc: mapping page edfa3d80 (0x0002d56c000) at 0xf0058000
[    0.263192] vmalloc: mapping page edfa3da0 (0x0002d56d000) at 0xf0059000
[    0.263196] vmalloc: mapping page edfa3dc0 (0x0002d56e000) at 0xf005a000
[    0.263200] vmalloc: mapping page edfa3de0 (0x0002d56f000) at 0xf005b000
[    0.263204] vmalloc: mapping page edfa3e00 (0x0002d570000) at 0xf005c000
[    0.263208] vmalloc: mapping page edfa3e20 (0x0002d571000) at 0xf005d000
[    0.263212] vmalloc: mapping page edfa3e40 (0x0002d572000) at 0xf005e000
[    0.263217] vmalloc: mapping page edfa3e60 (0x0002d573000) at 0xf005f000
[    0.263221] vmalloc: mapping page edfa3e80 (0x0002d574000) at 0xf0060000
[    0.263225] vmalloc: mapping page edfa3ea0 (0x0002d575000) at 0xf0061000
[    0.263229] vmalloc: mapping page edfa3ec0 (0x0002d576000) at 0xf0062000
[    0.263233] vmalloc: mapping page edfa3ee0 (0x0002d577000) at 0xf0063000
[    0.263237] vmalloc: mapping page edfa3f00 (0x0002d578000) at 0xf0064000
[    0.263241] vmalloc: mapping page edfa3f20 (0x0002d579000) at 0xf0065000
[    0.263245] vmalloc: mapping page edfa3f40 (0x0002d57a000) at 0xf0066000
[    0.263250] vmalloc: mapping page edfa3f60 (0x0002d57b000) at 0xf0067000
[    0.263254] vmalloc: mapping page edfa3f80 (0x0002d57c000) at 0xf0068000
[    0.263258] vmalloc: mapping page edfa3fa0 (0x0002d57d000) at 0xf0069000
[    0.263262] vmalloc: mapping page edfa3fc0 (0x0002d57e000) at 0xf006a000
[    0.263266] vmalloc: mapping page edfa3fe0 (0x0002d57f000) at 0xf006b000
[    0.263272] DMA: preallocated 256 KiB pool for atomic coherent
allocations
[    0.290043] cpuidle: using governor ladder
[    0.330040] cpuidle: using governor menu
[    0.370317] vmalloc: mapping page ef7f1000 (0x000efc00000) at 0xfedd8000
[    0.370324] vmalloc: mapping page ef7f1020 (0x000efc01000) at 0xfedd9000
[    0.370328] vmalloc: mapping page ef7f1040 (0x000efc02000) at 0xfedda000
[    0.370333] vmalloc: mapping page ef7f1060 (0x000efc03000) at 0xfede2000
[    0.370337] vmalloc: mapping page ef7f1080 (0x000efc04000) at 0xfede3000
[    0.370341] vmalloc: mapping page ef7f10a0 (0x000efc05000) at 0xfede4000
[    0.370345] vmalloc: mapping page ef7f10c0 (0x000efc06000) at 0xfedec000
[    0.370350] vmalloc: mapping page ef7f10e0 (0x000efc07000) at 0xfeded000
[    0.370354] vmalloc: mapping page ef7f1100 (0x000efc08000) at 0xfedee000
[    0.370358] vmalloc: mapping page ef7f1120 (0x000efc09000) at 0xfedf6000
[    0.370362] vmalloc: mapping page ef7f1140 (0x000efc0a000) at 0xfedf7000
[    0.370366] vmalloc: mapping page ef7f1160 (0x000efc0b000) at 0xfedf8000
[    0.370641] vgaarb: loaded
[    0.370787] SCSI subsystem initialized
[    0.371078] usbcore: registered new interface driver usbfs
[    0.371119] usbcore: registered new interface driver hub
[    0.371159] usbcore: registered new device driver usb
[    0.371403] Advanced Linux Sound Architecture Driver Initialized.
[    0.371725] Bluetooth: Core ver 2.20
[    0.371751] NET: Registered protocol family 31
[    0.371756] Bluetooth: HCI device and connection manager initialized
[    0.371764] Bluetooth: HCI socket layer initialized
[    0.371771] Bluetooth: L2CAP socket layer initialized
[    0.371787] Bluetooth: SCO socket layer initialized
[    0.371951] cfg80211: Calling CRDA to update world regulatory domain
[    0.372086] Switched to clocksource armada_370_xp_clocksource
[    0.377949] NET: Registered protocol family 2
[    0.378270] TCP established hash table entries: 8192 (order: 3, 32768
bytes)
[    0.378310] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.378362] TCP: Hash tables configured (established 8192 bind 8192)
[    0.378392] TCP: reno registered
[    0.378401] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.378420] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.378528] NET: Registered protocol family 1
[    0.378654] RPC: Registered named UNIX socket transport module.
[    0.378660] RPC: Registered udp transport module.
[    0.378664] RPC: Registered tcp transport module.
[    0.378667] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.378784] Unpacking initramfs...
[    0.484944] Freeing initrd memory: 3264K (c1100000 - c1430000)
[    0.485846] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.486446] vmalloc: mapping page ef7f0400 (0x000efba0000) at 0xfeddb000
[    0.486457] vmalloc: mapping page ef7f03e0 (0x000efb9f000) at 0xfeddc000
[    0.486462] vmalloc: mapping page ef7f03c0 (0x000efb9e000) at 0xfeddd000
[    0.486467] vmalloc: mapping page ef7f03a0 (0x000efb9d000) at 0xfede5000
[    0.486471] vmalloc: mapping page ef7f0380 (0x000efb9c000) at 0xfede6000
[    0.486475] vmalloc: mapping page ef7f0360 (0x000efb9b000) at 0xfede7000
[    0.486480] vmalloc: mapping page ef7f0340 (0x000efb9a000) at 0xfedef000
[    0.486484] vmalloc: mapping page ef7f0320 (0x000efb99000) at 0xfedf0000
[    0.486488] vmalloc: mapping page ef7f0300 (0x000efb98000) at 0xfedf1000
[    0.486492] vmalloc: mapping page ef7f02e0 (0x000efb97000) at 0xfedf9000
[    0.486497] vmalloc: mapping page ef7f02c0 (0x000efb96000) at 0xfedfa000
[    0.486501] vmalloc: mapping page ef7f02a0 (0x000efb95000) at 0xfedfb000
[    0.486914] bounce: pool size: 64 pages
[    0.486956] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 252)
[    0.486969] io scheduler noop registered
[    0.486977] io scheduler deadline registered
[    0.487007] io scheduler cfq registered (default)
[    0.487722] armada-xp-pinctrl f1018000.pin-ctrl: registered pinctrl
driver
[    0.488073] irq: Cannot allocate irq_descs @ IRQ45, assuming
pre-allocated
[    0.488287] irq: Cannot allocate irq_descs @ IRQ77, assuming
pre-allocated
[    0.488423] irq: Cannot allocate irq_descs @ IRQ109, assuming
pre-allocated
[    0.488770] mvebu-pcie soc:pcie-controller: PCI host bridge to bus
0000:00
[    0.488780] pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
[    0.488788] pci_bus 0000:00: root bus resource [mem
0xf8000000-0xffdfffff]
[    0.488795] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.489167] PCI: bus0: Fast back to back transfers disabled
[    0.489176] pci 0000:00:01.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.489185] pci 0000:00:09.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.489192] pci 0000:00:0a.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.489276] PCI: bus1: Fast back to back transfers enabled
[    0.489674] PCI: bus2: Fast back to back transfers disabled
[    0.489762] PCI: bus3: Fast back to back transfers enabled
[    0.489824] pci 0000:00:09.0: BAR 8: assigned [mem 0xf8000000-0xf80fffff]
[    0.489832] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.489845] pci 0000:02:00.0: BAR 2: assigned [mem
0xf8000000-0xf803ffff 64bit]
[    0.489862] pci 0000:02:00.0: BAR 0: assigned [mem
0xf8040000-0xf805ffff 64bit]
[    0.489878] pci 0000:02:00.0: BAR 6: assigned [mem
0xf8060000-0xf806ffff pref]
[    0.489884] pci 0000:00:09.0: PCI bridge to [bus 02]
[    0.489891] pci 0000:00:09.0:   bridge window [mem 0xf8000000-0xf80fffff]
[    0.489899] pci 0000:00:0a.0: PCI bridge to [bus 03]
[    0.490006] mv_xor f1060900.xor: Marvell shared XOR driver
[    0.522135] mv_xor f1060900.xor: Marvell XOR: ( xor cpy )
[    0.562133] mv_xor f1060900.xor: Marvell XOR: ( xor cpy )
[    0.562220] mv_xor f10f0900.xor: Marvell shared XOR driver
[    0.602129] mv_xor f10f0900.xor: Marvell XOR: ( xor cpy )
[    0.642128] mv_xor f10f0900.xor: Marvell XOR: ( xor cpy )
[    0.676997] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.678103] console [ttyS0] disabled
[    0.698337] f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 19,
base_baud = 15625000) is a 16550A
[    2.865983] console [ttyS0] enabled
[    2.890448] f1012100.serial: ttyS1 at MMIO 0xf1012100 (irq = 20,
base_baud = 15625000) is a 16550A
[    2.920444] f1012200.serial: ttyS2 at MMIO 0xf1012200 (irq = 32,
base_baud = 15625000) is a 16550A
[    2.950404] f1012300.serial: ttyS3 at MMIO 0xf1012300 (irq = 33,
base_baud = 15625000) is a 16550A
[    2.959987] mvsas 0000:02:00.0: mvsas: driver version 0.8.16
[    2.965684] pci 0000:00:09.0: enabling device (0140 -> 0142)
[    2.972201] mvsas 0000:02:00.0: mvsas: PCI-E x4, Bandwidth Usage: 2.5
Gbps
[    6.262097] scsi host0: mvsas
[    6.449022] ata1.00: ATA-8: ST320LT007-9ZV142, 0002SDM1, max UDMA/133
[    6.455491] ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    6.465577] ata1.00: configured for UDMA/133
[    6.470316] scsi 0:0:0:0: Direct-Access     ATA      ST320LT007-9ZV14
SDM1 PQ: 0 ANSI: 5
[    6.479105] sd 0:0:0:0: [sda] 625142448 512-byte logical blocks: (320
GB/298 GiB)
[    6.479374] sata_mv f10a0000.sata: slots 32 ports 2
[    6.480354] scsi host1: sata_mv
[    6.480597] scsi host2: sata_mv
[    6.480730] ata2: SATA max UDMA/133 irq 30
[    6.480733] ata3: SATA max UDMA/133 irq 30
[    6.481074] pxa3xx-nand f10d0000.nand: This platform can't do DMA on
this device
[    6.481227] nand: No NAND device found
[    6.481233] pxa3xx-nand f10d0000.nand: failed to scan nand at cs 0
[    6.486935] request_module: runaway loop modprobe binfmt-0000
[    6.488830] m25p80 spi0.0: n25q128a13 (16384 Kbytes)
[    6.493917] request_module: runaway loop modprobe binfmt-0000
[    6.503166] libphy: orion_mdio_bus: probed
[    6.504741] mvneta f1070000.ethernet eth0: Using device tree mac
address 00:50:43:00:05:1e
[    6.505519] mvneta f1074000.ethernet eth1: Using device tree mac
address 00:50:43:00:05:1f
[    6.506271] mvneta f1030000.ethernet eth2: Using device tree mac
address 00:50:43:00:05:20
[    6.507018] mvneta f1034000.ethernet eth3: Using device tree mac
address 00:50:43:00:05:21
[    6.507338] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    6.507343] ehci-pci: EHCI PCI platform driver
[    6.507379] ehci-orion: EHCI orion driver
[    6.507458] orion-ehci f1050000.usb: EHCI Host Controller
[    6.507473] orion-ehci f1050000.usb: new USB bus registered, assigned
bus number 1
[    6.507540] orion-ehci f1050000.usb: irq 26, io mem 0xf1050000
[    6.522095] orion-ehci f1050000.usb: USB 2.0 started, EHCI 1.00
[    6.522526] hub 1-0:1.0: USB hub found
[    6.522552] hub 1-0:1.0: 1 port detected
[    6.522787] orion-ehci f1051000.usb: EHCI Host Controller
[    6.522800] orion-ehci f1051000.usb: new USB bus registered, assigned
bus number 2
[    6.522856] orion-ehci f1051000.usb: irq 27, io mem 0xf1051000
[    6.542095] orion-ehci f1051000.usb: USB 2.0 started, EHCI 1.00
[    6.542489] hub 2-0:1.0: USB hub found
[    6.542510] hub 2-0:1.0: 1 port detected
[    6.542813] usbcore: registered new interface driver usb-storage
[    6.542994] mousedev: PS/2 mouse device common for all mice
[    6.543438] rtc-mv f1010300.rtc: rtc core: registered f1010300.rtc as
rtc0
[    6.543538] i2c /dev entries driver
[    6.544360] orion_wdt: Initial timeout 171 sec
[    6.545205] Driver 'mmcblk' needs updating - please use bus_type methods
[    6.545230] sdhci: Secure Digital Host Controller Interface driver
[    6.545231] sdhci: Copyright(c) Pierre Ossman
[    6.545303] sdhci-pltfm: SDHCI platform and OF driver helper
[    6.545445] ledtrig-cpu: registered to indicate activity on CPUs
[    6.545568] usbcore: registered new interface driver usbhid
[    6.545570] usbhid: USB HID core driver
[    6.545967] of-flash f0000000.nor: do_map_probe() failed for type
cfi_probe
[    6.551325] request_module: runaway loop modprobe binfmt-0000
[    6.553078] of-flash f0000000.nor: do_map_probe() failed
[    6.553940] TCP: cubic registered
[    6.553947] NET: Registered protocol family 17
[    6.554100] ThumbEE CPU extension supported.
[    6.554109] Registering SWP/SWPB emulation handler
[    6.560581] rtc-mv f1010300.rtc: setting system clock to 2015-03-11
15:26:35 UTC (1426087595)
[    6.561531] ALSA device list:
[    6.561533]   No soundcards found.
[    6.771767] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    6.771932] sd 0:0:0:0: [sda] Write Protect is off
[    6.771992] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    6.772534] vmalloc: mapping page ef7f13c0 (0x000efc1e000) at 0xf00ca000
[    6.772537] vmalloc: mapping page ef7f13a0 (0x000efc1d000) at 0xf00cb000
[    6.772540] vmalloc: mapping page ef7f1380 (0x000efc1c000) at 0xf00cc000
[    6.772542] vmalloc: mapping page ef7f1360 (0x000efc1b000) at 0xf00cd000
[    6.772544] vmalloc: mapping page ef7f1340 (0x000efc1a000) at 0xf00ce000
[    6.772546] vmalloc: mapping page ef7f1320 (0x000efc19000) at 0xf00cf000
[    6.772548] vmalloc: mapping page ef7f1300 (0x000efc18000) at 0xf00d0000
[    6.772551] vmalloc: mapping page ef7f12e0 (0x000efc17000) at 0xf00d1000
[    6.822102] ata2: SATA link down (SStatus 0 SControl F300)
[    6.850381] vmalloc: mapping page ef7f0420 (0x000efba1000) at 0xf00d3000
[    6.857113] vmalloc: mapping page ef7f12c0 (0x000efc16000) at 0xf00d4000
[    6.863845] vmalloc: mapping page ef7f12a0 (0x000efc15000) at 0xf00d5000
[    6.870567] Unhandled fault: external abort on non-linefetch (0x808)
at 0xf00d3018
[    6.878153] pgd = c0004000
[    6.880866] [f00d3018] *pgd=2d404811, *pte=efba165f, *ppte=efba145f
[    6.887183] Internal error: : 808 [#1] SMP ARM
[    6.891636] Modules linked in:
[    6.894708] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.0.0-rc2-00137-gb672c98-dirty #60
[    6.902816] Hardware name: Marvell Armada 370/XP (Device Tree)
[    6.908663] task: ed41e800 ti: ed43e000 task.ti: ed43e000
[    6.914076] PC is at _set_bit+0x28/0x50
[    6.917914] LR is at n_tty_set_termios+0x328/0x358
[    6.922717] pc : [<c01bc938>]    lr : [<c02073b4>]    psr: 40000113
[    6.922717] sp : ed43fd00  ip : 00000000  fp : 00000000
[    6.934221] r10: 00000002  r9 : 00000000  r8 : ec932480
[    6.939457] r7 : 00000000  r6 : f00d3018  r5 : f00d3000  r4 : ec982200
[    6.945999] r3 : 00002000  r2 : 00002000  r1 : f00d3018  r0 : 00000000
[    6.952543] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment kernel
[    6.959868] Control: 10c5387d  Table: 0000406a  DAC: 00000015
[    6.965627] Process swapper/0 (pid: 1, stack limit = 0xed43e220)
[    6.971647] Stack: (0xed43fd00 to 0xed440000)
