From: stsp@list.ru (Stas Sergeev)
Date: Wed, 11 Mar 2015 19:39:54 +0300
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <55006DAD.3070205@hurleysoftware.com>
References: <54FF21BE.2040506@list.ru>
 <20150310171751.GD13687@e104818-lin.cambridge.arm.com>
 <54FF2986.6020503@list.ru> <20150310173807.GU8656@n2100.arm.linux.org.uk>
 <55003569.1010200@list.ru> <20150311124730.GZ8656@n2100.arm.linux.org.uk>
 <5500502A.5060905@list.ru> <55006DAD.3070205@hurleysoftware.com>
Message-ID: <55006FDA.8000802@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

11.03.2015 19:30, Peter Hurley ?????:
> On 03/11/2015 10:24 AM, Stas Sergeev wrote:
>> However, while testing, I've suddenly got another crash happened
>> a bit earlier than the previous one used to happen: (OOM? How??)
>> ---
> Probably related to these runaway modprobes.
Thanks, I'll dig into that.
Anyway, the log was obscured by linewraps, so re-posting full version
just in case.

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
[    0.000000] memblock_reserve: [0x00000001100040-0x0000000142fad3]
flags 0x0 arm_memblock_init+0x100/0x18c
[    0.000000] memblock_reserve: [0x00000000004000-0x00000000007fff]
flags 0x0 arm_memblock_init+0x124/0x18c
[    0.000000] memblock_reserve: [0x00000000000000-0x000000000027ff]
flags 0x0 mvebu_scan_mem+0xa4/0xec
[    0.000000] memblock_reserve: [0x00000000000000-0x000000000027ff]
flags 0x0 mvebu_scan_mem+0xa4/0xec
[    0.000000] memblock_reserve: [0x00000000a41168-0x00000000a45391]
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
[    0.000000]  reserved[0x3]   [0x00000000a41168-0x00000000a45391],
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
align=0x0 nid=0 from=0x0 max_addr=0x0 alloc_node_mem_map.constprop.66+0x6
0/0x90
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
align=0x1000 nid=-1 from=0x3fffffff max_addr=0x0 pcpu_dfl_fc_alloc+0x28/0x3
0
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
[    0.000000] early log buf free: 6144(37%)
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
241K rwdata, 1380K rodata, 252K init, 190K bss, 42284K reserved, 0K c
ma-reserved, 3153920K highmem)
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
[    0.000258] Calibrating delay loop... 1594.16 BogoMIPS (lpj=7970816)
[    0.090072] pid_max: default: 32768 minimum: 301
[    0.090141] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.090148] Mountpoint-cache hash table entries: 2048 (order: 1, 8192
bytes)
[    0.090396] CPU: Testing write buffer coherency: vmalloc: mapping
page edfa13e0 (0x0002d41f000) at 0xf001e000
[    0.090411] vmalloc: mapping page edfa13e0 (0x0002d41f000) at 0xf0020000
[    0.090418] ok
[    0.090520] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.090869] Setting up static identity map for 0x4cece8 - 0x4ced40
[    0.091059] mvebu-soc-id: MVEBU SoC ID=0x7846, Rev=0x2
[    0.091143] mvebu-pmsu: Initializing Power Management Service Unit
[    0.091797] Booting CPU 1
[    0.180067] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.180268] Booting CPU 2
[    0.220066] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.220261] Booting CPU 3
[    0.260066] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.260108] Brought up 4 CPUs
[    0.260116] SMP: Total of 4 processors activated (6376.65 BogoMIPS).
[    0.260120] CPU: All CPU(s) started in SVC mode.
[    0.260387] devtmpfs: initialized
[    0.260713] VFP support v0.3: implementor 56 architecture 2 part 20
variant 9 rev 6
[    0.260885] pinctrl core: initialized pinctrl subsystem
[    0.262835] NET: Registered protocol family 16
[    0.263007] vmalloc: mapping page edfa3800 (0x0002d540000) at 0xf002c000
[    0.263012] vmalloc: mapping page edfa3820 (0x0002d541000) at 0xf002d000
[    0.263017] vmalloc: mapping page edfa3840 (0x0002d542000) at 0xf002e000
[    0.263021] vmalloc: mapping page edfa3860 (0x0002d543000) at 0xf002f000
[    0.263025] vmalloc: mapping page edfa3880 (0x0002d544000) at 0xf0030000
[    0.263029] vmalloc: mapping page edfa38a0 (0x0002d545000) at 0xf0031000
[    0.263033] vmalloc: mapping page edfa38c0 (0x0002d546000) at 0xf0032000
[    0.263037] vmalloc: mapping page edfa38e0 (0x0002d547000) at 0xf0033000
[    0.263042] vmalloc: mapping page edfa3900 (0x0002d548000) at 0xf0034000
[    0.263046] vmalloc: mapping page edfa3920 (0x0002d549000) at 0xf0035000
[    0.263050] vmalloc: mapping page edfa3940 (0x0002d54a000) at 0xf0036000
[    0.263054] vmalloc: mapping page edfa3960 (0x0002d54b000) at 0xf0037000
[    0.263058] vmalloc: mapping page edfa3980 (0x0002d54c000) at 0xf0038000
[    0.263062] vmalloc: mapping page edfa39a0 (0x0002d54d000) at 0xf0039000
[    0.263066] vmalloc: mapping page edfa39c0 (0x0002d54e000) at 0xf003a000
[    0.263071] vmalloc: mapping page edfa39e0 (0x0002d54f000) at 0xf003b000
[    0.263075] vmalloc: mapping page edfa3a00 (0x0002d550000) at 0xf003c000
[    0.263079] vmalloc: mapping page edfa3a20 (0x0002d551000) at 0xf003d000
[    0.263083] vmalloc: mapping page edfa3a40 (0x0002d552000) at 0xf003e000
[    0.263087] vmalloc: mapping page edfa3a60 (0x0002d553000) at 0xf003f000
[    0.263091] vmalloc: mapping page edfa3a80 (0x0002d554000) at 0xf0040000
[    0.263095] vmalloc: mapping page edfa3aa0 (0x0002d555000) at 0xf0041000
[    0.263099] vmalloc: mapping page edfa3ac0 (0x0002d556000) at 0xf0042000
[    0.263104] vmalloc: mapping page edfa3ae0 (0x0002d557000) at 0xf0043000
[    0.263108] vmalloc: mapping page edfa3b00 (0x0002d558000) at 0xf0044000
[    0.263112] vmalloc: mapping page edfa3b20 (0x0002d559000) at 0xf0045000
[    0.263116] vmalloc: mapping page edfa3b40 (0x0002d55a000) at 0xf0046000
[    0.263120] vmalloc: mapping page edfa3b60 (0x0002d55b000) at 0xf0047000
[    0.263124] vmalloc: mapping page edfa3b80 (0x0002d55c000) at 0xf0048000
[    0.263128] vmalloc: mapping page edfa3ba0 (0x0002d55d000) at 0xf0049000
[    0.263132] vmalloc: mapping page edfa3bc0 (0x0002d55e000) at 0xf004a000
[    0.263137] vmalloc: mapping page edfa3be0 (0x0002d55f000) at 0xf004b000
[    0.263141] vmalloc: mapping page edfa3c00 (0x0002d560000) at 0xf004c000
[    0.263145] vmalloc: mapping page edfa3c20 (0x0002d561000) at 0xf004d000
[    0.263149] vmalloc: mapping page edfa3c40 (0x0002d562000) at 0xf004e000
[    0.263153] vmalloc: mapping page edfa3c60 (0x0002d563000) at 0xf004f000
[    0.263157] vmalloc: mapping page edfa3c80 (0x0002d564000) at 0xf0050000
[    0.263161] vmalloc: mapping page edfa3ca0 (0x0002d565000) at 0xf0051000
[    0.263166] vmalloc: mapping page edfa3cc0 (0x0002d566000) at 0xf0052000
[    0.263170] vmalloc: mapping page edfa3ce0 (0x0002d567000) at 0xf0053000
[    0.263174] vmalloc: mapping page edfa3d00 (0x0002d568000) at 0xf0054000
[    0.263178] vmalloc: mapping page edfa3d20 (0x0002d569000) at 0xf0055000
[    0.263182] vmalloc: mapping page edfa3d40 (0x0002d56a000) at 0xf0056000
[    0.263186] vmalloc: mapping page edfa3d60 (0x0002d56b000) at 0xf0057000
[    0.263190] vmalloc: mapping page edfa3d80 (0x0002d56c000) at 0xf0058000
[    0.263194] vmalloc: mapping page edfa3da0 (0x0002d56d000) at 0xf0059000
[    0.263198] vmalloc: mapping page edfa3dc0 (0x0002d56e000) at 0xf005a000
[    0.263203] vmalloc: mapping page edfa3de0 (0x0002d56f000) at 0xf005b000
[    0.263207] vmalloc: mapping page edfa3e00 (0x0002d570000) at 0xf005c000
[    0.263211] vmalloc: mapping page edfa3e20 (0x0002d571000) at 0xf005d000
[    0.263215] vmalloc: mapping page edfa3e40 (0x0002d572000) at 0xf005e000
[    0.263219] vmalloc: mapping page edfa3e60 (0x0002d573000) at 0xf005f000
[    0.263223] vmalloc: mapping page edfa3e80 (0x0002d574000) at 0xf0060000
[    0.263227] vmalloc: mapping page edfa3ea0 (0x0002d575000) at 0xf0061000
[    0.263231] vmalloc: mapping page edfa3ec0 (0x0002d576000) at 0xf0062000
[    0.263236] vmalloc: mapping page edfa3ee0 (0x0002d577000) at 0xf0063000
[    0.263240] vmalloc: mapping page edfa3f00 (0x0002d578000) at 0xf0064000
[    0.263244] vmalloc: mapping page edfa3f20 (0x0002d579000) at 0xf0065000
[    0.263248] vmalloc: mapping page edfa3f40 (0x0002d57a000) at 0xf0066000
[    0.263252] vmalloc: mapping page edfa3f60 (0x0002d57b000) at 0xf0067000
[    0.263256] vmalloc: mapping page edfa3f80 (0x0002d57c000) at 0xf0068000
[    0.263260] vmalloc: mapping page edfa3fa0 (0x0002d57d000) at 0xf0069000
[    0.263264] vmalloc: mapping page edfa3fc0 (0x0002d57e000) at 0xf006a000
[    0.263269] vmalloc: mapping page edfa3fe0 (0x0002d57f000) at 0xf006b000
[    0.263274] DMA: preallocated 256 KiB pool for atomic coherent
allocations
[    0.290044] cpuidle: using governor ladder
[    0.330042] cpuidle: using governor menu
[    0.370266] vmalloc: mapping page ef7f1000 (0x000efc00000) at 0xfedd8000
[    0.370274] vmalloc: mapping page ef7f1020 (0x000efc01000) at 0xfedd9000
[    0.370278] vmalloc: mapping page ef7f1040 (0x000efc02000) at 0xfedda000
[    0.370283] vmalloc: mapping page ef7f1060 (0x000efc03000) at 0xfede2000
[    0.370287] vmalloc: mapping page ef7f1080 (0x000efc04000) at 0xfede3000
[    0.370291] vmalloc: mapping page ef7f10a0 (0x000efc05000) at 0xfede4000
[    0.370296] vmalloc: mapping page ef7f10c0 (0x000efc06000) at 0xfedec000
[    0.370300] vmalloc: mapping page ef7f10e0 (0x000efc07000) at 0xfeded000
[    0.370304] vmalloc: mapping page ef7f1100 (0x000efc08000) at 0xfedee000
[    0.370308] vmalloc: mapping page ef7f1120 (0x000efc09000) at 0xfedf6000
[    0.370313] vmalloc: mapping page ef7f1140 (0x000efc0a000) at 0xfedf7000
[    0.370317] vmalloc: mapping page ef7f1160 (0x000efc0b000) at 0xfedf8000
[    0.370683] vgaarb: loaded
[    0.370820] SCSI subsystem initialized
[    0.371152] usbcore: registered new interface driver usbfs
[    0.371193] usbcore: registered new interface driver hub
[    0.371232] usbcore: registered new device driver usb
[    0.371450] Advanced Linux Sound Architecture Driver Initialized.
[    0.371755] Bluetooth: Core ver 2.20
[    0.371780] NET: Registered protocol family 31
[    0.371785] Bluetooth: HCI device and connection manager initialized
[    0.371792] Bluetooth: HCI socket layer initialized
[    0.371799] Bluetooth: L2CAP socket layer initialized
[    0.371814] Bluetooth: SCO socket layer initialized
[    0.371971] cfg80211: Calling CRDA to update world regulatory domain
[    0.372138] Switched to clocksource armada_370_xp_clocksource
[    0.378079] NET: Registered protocol family 2
[    0.378397] TCP established hash table entries: 8192 (order: 3, 32768
bytes)
[    0.378436] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.378488] TCP: Hash tables configured (established 8192 bind 8192)
[    0.378520] TCP: reno registered
[    0.378528] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.378554] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.378662] NET: Registered protocol family 1
[    0.378798] RPC: Registered named UNIX socket transport module.
[    0.378804] RPC: Registered udp transport module.
[    0.378808] RPC: Registered tcp transport module.
[    0.378812] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.378927] Unpacking initramfs...
[    0.484965] Freeing initrd memory: 3264K (c1100000 - c1430000)
[    0.485868] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.486463] vmalloc: mapping page ef7f0400 (0x000efba0000) at 0xfeddb000
[    0.486474] vmalloc: mapping page ef7f03e0 (0x000efb9f000) at 0xfeddc000
[    0.486479] vmalloc: mapping page ef7f03c0 (0x000efb9e000) at 0xfeddd000
[    0.486484] vmalloc: mapping page ef7f03a0 (0x000efb9d000) at 0xfede5000
[    0.486488] vmalloc: mapping page ef7f0380 (0x000efb9c000) at 0xfede6000
[    0.486492] vmalloc: mapping page ef7f0360 (0x000efb9b000) at 0xfede7000
[    0.486496] vmalloc: mapping page ef7f0340 (0x000efb9a000) at 0xfedef000
[    0.486501] vmalloc: mapping page ef7f0320 (0x000efb99000) at 0xfedf0000
[    0.486505] vmalloc: mapping page ef7f0300 (0x000efb98000) at 0xfedf1000
[    0.486509] vmalloc: mapping page ef7f02e0 (0x000efb97000) at 0xfedf9000
[    0.486514] vmalloc: mapping page ef7f02c0 (0x000efb96000) at 0xfedfa000
[    0.486518] vmalloc: mapping page ef7f02a0 (0x000efb95000) at 0xfedfb000
[    0.486930] bounce: pool size: 64 pages
[    0.486972] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 252)
[    0.486985] io scheduler noop registered
[    0.486993] io scheduler deadline registered
[    0.487022] io scheduler cfq registered (default)
[    0.487736] armada-xp-pinctrl f1018000.pin-ctrl: registered pinctrl
driver
[    0.488086] irq: Cannot allocate irq_descs @ IRQ45, assuming
pre-allocated
[    0.488304] irq: Cannot allocate irq_descs @ IRQ77, assuming
pre-allocated
[    0.488441] irq: Cannot allocate irq_descs @ IRQ109, assuming
pre-allocated
[    0.488785] mvebu-pcie soc:pcie-controller: PCI host bridge to bus
0000:00
[    0.488796] pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
[    0.488803] pci_bus 0000:00: root bus resource [mem
0xf8000000-0xffdfffff]
[    0.488811] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.489186] PCI: bus0: Fast back to back transfers disabled
[    0.489194] pci 0000:00:01.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.489203] pci 0000:00:09.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.489210] pci 0000:00:0a.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.489292] PCI: bus1: Fast back to back transfers enabled
[    0.489689] PCI: bus2: Fast back to back transfers disabled
[    0.489779] PCI: bus3: Fast back to back transfers enabled
[    0.489841] pci 0000:00:09.0: BAR 8: assigned [mem 0xf8000000-0xf80fffff]
[    0.489849] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.489861] pci 0000:02:00.0: BAR 2: assigned [mem
0xf8000000-0xf803ffff 64bit]
[    0.489879] pci 0000:02:00.0: BAR 0: assigned [mem
0xf8040000-0xf805ffff 64bit]
[    0.489895] pci 0000:02:00.0: BAR 6: assigned [mem
0xf8060000-0xf806ffff pref]
[    0.489901] pci 0000:00:09.0: PCI bridge to [bus 02]
[    0.489908] pci 0000:00:09.0:   bridge window [mem 0xf8000000-0xf80fffff]
[    0.489915] pci 0000:00:0a.0: PCI bridge to [bus 03]
[    0.490022] mv_xor f1060900.xor: Marvell shared XOR driver
[    0.522191] mv_xor f1060900.xor: Marvell XOR: ( xor cpy )
[    0.562180] mv_xor f1060900.xor: Marvell XOR: ( xor cpy )
[    0.562267] mv_xor f10f0900.xor: Marvell shared XOR driver
[    0.602185] mv_xor f10f0900.xor: Marvell XOR: ( xor cpy )
[    0.642179] mv_xor f10f0900.xor: Marvell XOR: ( xor cpy )
[    0.676386] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.677474] console [ttyS0] disabled
[    0.697700] f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 19,
base_baud = 15625000) is a 16550A
[    2.865238] console [ttyS0] enabled
[    2.889704] f1012100.serial: ttyS1 at MMIO 0xf1012100 (irq = 20,
base_baud = 15625000) is a 16550A
[    2.919707] f1012200.serial: ttyS2 at MMIO 0xf1012200 (irq = 32,
base_baud = 15625000) is a 16550A
[    2.949663] f1012300.serial: ttyS3 at MMIO 0xf1012300 (irq = 33,
base_baud = 15625000) is a 16550A
[    2.959257] mvsas 0000:02:00.0: mvsas: driver version 0.8.16
[    2.964956] pci 0000:00:09.0: enabling device (0140 -> 0142)
[    2.971478] mvsas 0000:02:00.0: mvsas: PCI-E x4, Bandwidth Usage: 2.5
Gbps
[    6.262148] scsi host0: mvsas
[    6.447391] ata1.00: ATA-8: ST320LT007-9ZV142, 0002SDM1, max UDMA/133
[    6.453858] ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    6.463951] ata1.00: configured for UDMA/133
[    6.482574] scsi 0:0:0:0: Direct-Access     ATA      ST320LT007-9ZV14
SDM1 PQ: 0 ANSI: 5
[    6.491644] sata_mv f10a0000.sata: slots 32 ports 2
[    6.492241] sd 0:0:0:0: [sda] 625142448 512-byte logical blocks: (320
GB/298 GiB)
[    6.492246] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    6.492363] sd 0:0:0:0: [sda] Write Protect is off
[    6.492421] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    6.502484] vmalloc: mapping page ef7f0260 (0x000efb93000) at 0xf009e000
[    6.502487] vmalloc: mapping page ef7f0280 (0x000efb94000) at 0xf009f000
[    6.502489] vmalloc: mapping page ef7f0420 (0x000efba1000) at 0xf00a0000
[    6.502491] vmalloc: mapping page ef7f0440 (0x000efba2000) at 0xf00a1000
[    6.502494] vmalloc: mapping page ef7f0460 (0x000efba3000) at 0xf00a2000
[    6.502496] vmalloc: mapping page ef7f0480 (0x000efba4000) at 0xf00a3000
[    6.502498] vmalloc: mapping page ef7f04a0 (0x000efba5000) at 0xf00a4000
[    6.502500] vmalloc: mapping page ef7f04c0 (0x000efba6000) at 0xf00a5000
[    6.521846]  sda: sda1 sda2 sda3
[    6.581135] scsi host1: sata_mv
[    6.584535] scsi host2: sata_mv
[    6.587822] ata2: SATA max UDMA/133 irq 30
[    6.591931] ata3: SATA max UDMA/133 irq 30
[    6.596478] pxa3xx-nand f10d0000.nand: This platform can't do DMA on
this device
[    6.604052] nand: second ID read did not match 00,28 against 00,20
[    6.610249] nand: No NAND device found
[    6.614027] pxa3xx-nand f10d0000.nand: failed to scan nand at cs 0
[    6.626202] request_module: runaway loop modprobe binfmt-0000
[    6.633770] m25p80 spi0.0: n25q128a13 (16384 Kbytes)
[    6.644198] request_module: runaway loop modprobe binfmt-0000
[    6.652842] libphy: orion_mdio_bus: probed
[    6.658600] mvneta f1070000.ethernet eth0: Using device tree mac
address 00:50:43:00:05:1e
[    6.667650] mvneta f1074000.ethernet eth1: Using device tree mac
address 00:50:43:00:05:1f
[    6.676727] mvneta f1030000.ethernet eth2: Using device tree mac
address 00:50:43:00:05:20
[    6.685800] mvneta f1034000.ethernet eth3: Using device tree mac
address 00:50:43:00:05:21
[    6.694466] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    6.701014] ehci-pci: EHCI PCI platform driver
[    6.705523] ehci-orion: EHCI orion driver
[    6.709641] orion-ehci f1050000.usb: EHCI Host Controller
[    6.715081] orion-ehci f1050000.usb: new USB bus registered, assigned
bus number 1
[    6.722751] orion-ehci f1050000.usb: irq 26, io mem 0xf1050000
[    6.742150] orion-ehci f1050000.usb: USB 2.0 started, EHCI 1.00
[    6.748568] hub 1-0:1.0: USB hub found
[    6.752370] hub 1-0:1.0: 1 port detected
[    6.756583] orion-ehci f1051000.usb: EHCI Host Controller
[    6.762009] orion-ehci f1051000.usb: new USB bus registered, assigned
bus number 2
[    6.769681] orion-ehci f1051000.usb: irq 27, io mem 0xf1051000
[    6.792148] orion-ehci f1051000.usb: USB 2.0 started, EHCI 1.00
[    6.798287] swapper/0 invoked oom-killer: gfp_mask=0x2040d0, order=0,
oom_score_adj=0
[    6.806152] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.0.0-rc2-00137-gb672c98-dirty #2
[    6.814231] Hardware name: Marvell Armada 370/XP (Device Tree)
[    6.820097] [<c0014ca4>] (unwind_backtrace) from [<c0010e34>]
(show_stack+0x10/0x14)
[    6.827877] [<c0010e34>] (show_stack) from [<c04c9d64>]
(dump_stack+0x6c/0x88)
[    6.835136] [<c04c9d64>] (dump_stack) from [<c04c8e18>]
(dump_header.isra.12+0x90/0x1b0)
[    6.843264] [<c04c8e18>] (dump_header.isra.12) from [<c007f3ec>]
(__out_of_memory.isra.15+0x318/0x340)
[    6.852606] [<c007f3ec>] (__out_of_memory.isra.15) from [<c007f5c4>]
(out_of_memory+0x40/0x5c)
[    6.861244] [<c007f5c4>] (out_of_memory) from [<c0082efc>]
(__alloc_pages_nodemask+0x604/0x644)
[    6.869976] [<c0082efc>] (__alloc_pages_nodemask) from [<c00b150c>]
(cache_alloc_refill+0x350/0x580)
[    6.879143] [<c00b150c>] (cache_alloc_refill) from [<c00b19a4>]
(kmem_cache_alloc+0x98/0xd4)
[    6.887614] [<c00b19a4>] (kmem_cache_alloc) from [<c01091b0>]
(__kernfs_new_node+0x38/0xa8)
[    6.895997] [<c01091b0>] (__kernfs_new_node) from [<c0109e00>]
(kernfs_new_node+0x1c/0x38)
[    6.904292] [<c0109e00>] (kernfs_new_node) from [<c010b420>]
(__kernfs_create_file+0x1c/0x90)
[    6.912848] [<c010b420>] (__kernfs_create_file) from [<c010bbfc>]
(sysfs_add_file_mode_ns+0xa4/0x198)
[    6.922094] [<c010bbfc>] (sysfs_add_file_mode_ns) from [<c010c6e0>]
(internal_create_group+0xdc/0x230)
[    6.931435] [<c010c6e0>] (internal_create_group) from [<c010c960>]
(sysfs_create_groups+0x48/0x7c)
[    6.940427] [<c010c960>] (sysfs_create_groups) from [<c022d9ac>]
(device_add+0x25c/0x4dc)
[    6.948637] [<c022d9ac>] (device_add) from [<c02fb730>]
(usb_new_device+0x1d0/0x34c)
[    6.952157] ata2: SATA link down (SStatus 0 SControl F300)
[    6.961906] [<c02fb730>] (usb_new_device) from [<c02ff514>]
(usb_add_hcd+0x498/0x788)
[    6.969765] [<c02ff514>] (usb_add_hcd) from [<c031a074>]
(ehci_orion_drv_probe+0x2f4/0x480)
[    6.978148] [<c031a074>] (ehci_orion_drv_probe) from [<c0231308>]
(platform_drv_probe+0x48/0x98)
[    6.986966] [<c0231308>] (platform_drv_probe) from [<c022fecc>]
(driver_probe_device+0x114/0x234)
[    6.995870] [<c022fecc>] (driver_probe_device) from [<c0230078>]
(__driver_attach+0x8c/0x90)
[    7.004339] [<c0230078>] (__driver_attach) from [<c022e880>]
(bus_for_each_dev+0x54/0x88)
[    7.012545] [<c022e880>] (bus_for_each_dev) from [<c022f6d0>]
(bus_add_driver+0xd8/0x1cc)
[    7.020746] [<c022f6d0>] (bus_add_driver) from [<c02306b8>]
(driver_register+0x78/0xf4)
[    7.028779] [<c02306b8>] (driver_register) from [<c0008a64>]
(do_one_initcall+0x80/0x1d0)
[    7.036992] [<c0008a64>] (do_one_initcall) from [<c0655d3c>]
(kernel_init_freeable+0x108/0x1d4)
[    7.045723] [<c0655d3c>] (kernel_init_freeable) from [<c04c68a8>]
(kernel_init+0x8/0xe4)
[    7.053849] [<c04c68a8>] (kernel_init) from [<c000e540>]
(ret_from_fork+0x14/0x34)
[    7.061436] Mem-info:
[    7.063720] Normal per-cpu:
[    7.066520] CPU    0: hi:  186, btch:  31 usd:  66
[    7.071321] CPU    1: hi:  186, btch:  31 usd:  85
[    7.076131] CPU    2: hi:  186, btch:  31 usd:  58
[    7.080932] CPU    3: hi:  186, btch:  31 usd: 173
[    7.085739] HighMem per-cpu:
[    7.088626] CPU    0: hi:  186, btch:  31 usd:  19
[    7.093434] CPU    1: hi:  186, btch:  31 usd:  62
[    7.098236] CPU    2: hi:  186, btch:  31 usd:   0
[    7.103044] CPU    3: hi:  186, btch:  31 usd:  33
[    7.107852] active_anon:0 inactive_anon:0 isolated_anon:0
[    7.107852]  active_file:221 inactive_file:1683 isolated_file:0
[    7.107852]  unevictable:0 dirty:0 writeback:0 unstable:0
[    7.107852]  free:787295 slab_reclaimable:101 slab_unreclaimable:182388
[    7.107852]  mapped:0 shmem:0 pagetables:0 bounce:0
[    7.107852]  free_cma:0
[    7.138530] Normal free:3320kB min:3436kB low:4292kB high:5152kB
active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unev
ictable:0kB isolated(anon):0kB isolated(file):0kB present:778240kB
managed:739220kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB shmem:0kB
 slab_reclaimable:404kB slab_unreclaimable:729552kB kernel_stack:2544kB
pagetables:0kB unstable:0kB bounce:0kB free_cma:0kB writeback_tmp:0k
B pages_scanned:0 all_unreclaimable? yes
[    7.178764] lowmem_reserve[]: 0 24640 24640
[    7.183016] HighMem free:3145860kB min:512kB low:4176kB high:7840kB
active_anon:0kB inactive_anon:0kB active_file:884kB inactive_file:673
2kB unevictable:0kB isolated(anon):0kB isolated(file):0kB
present:3153920kB managed:3153920kB mlocked:0kB dirty:0kB writeback:0kB
mapped:0kB
 shmem:0kB slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB
pagetables:0kB unstable:0kB bounce:0kB free_cma:0kB writeback_tmp:0k
B pages_scanned:0 all_unreclaimable? no
[    7.223161] lowmem_reserve[]: 0 0 0
[    7.226698] Normal: 0*4kB 12*8kB (U) 2*16kB (U) 0*32kB 0*64kB 1*128kB
(R) 0*256kB 0*512kB 1*1024kB (R) 1*2048kB (R) 0*4096kB = 3328kB
[    7.238909] HighMem: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB
2*256kB (UM) 1*512kB (M) 1*1024kB (M) 1*2048kB (M) 767*4096kB (MR) = 31
45736kB
[    7.252093] 1908 total pagecache pages
[    7.255857] 0 pages in swap cache
[    7.259179] Swap cache stats: add 0, delete 0, find 0/0
[    7.264421] Free swap  = 0kB
[    7.267306] Total swap = 0kB
[    7.292175] ata3: SATA link down (SStatus 0 SControl F300)
[    7.319855] 983040 pages of RAM
[    7.323024] 788100 free pages
[    7.325998] 9755 reserved pages
[    7.329144] 182410 slab pages
[    7.332117] 0 pages shared
[    7.334835] 0 pages swap cached
[    7.337982] [ pid ]   uid  tgid total_vm      rss nr_ptes nr_pmds
swapents oom_score_adj name
[    7.346546] Kernel panic - not syncing: Out of memory and no killable
processes...
