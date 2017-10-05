From: priyaranjan45678@gmail.com (priyaranjan)
Date: Thu, 5 Oct 2017 15:11:28 +0530
Subject: OOM while increasing RAM to 4GB on DRA7x TI platform.
Message-ID: <CAE_iR+i+q3ER-6yNkwWz9zkkrHb1W6q+f+_=jc8zBkKLW_fgoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello All,

I'm having issues on DRA7x based Android system where migrating from a
2GB RAM configuration to 4GB RAM has forced us to enable LPAE. In the
LPAE configuration, OOM killer causes issues as the system becomes
heavily loaded, but this issue does not occur on our more stable 2GB /
non-lpae baseline.

>From what I understand, this is happening because we run out of low
memory.  LPAE does place a marginally higher demand on lowmem in terms
of page tables, kernel size, etc. But still not sure of an exact root
cause.

Tuning/reducing vmalloc in the kernel command line seems to improve
the situation, but at the expense of introducing binder issues (since
binder uses vmalloc extensively).

Can anyone help me regarding this?  See below  example log.

Software details - 4.4 kernel + Android 6.0 / marshmallow based on
6AM1.3 Texas Instrument release.


[    0.000000] CPU: ARMv7 Processor [412fc0f2] revision 2 (ARMv7), cr=30c5387d

[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache

[    0.000000] Machine model: TI DRA742

[    0.000000] Reserved memory: created CMA memory pool at
0x0000000095800000, size 56 MiB

[    0.000000] Reserved memory: initialized node ipu2_cma at 95800000,
compatible id shared-dma-pool

[    0.000000] Reserved memory: created CMA memory pool at
0x0000000099000000, size 64 MiB

[    0.000000] Reserved memory: initialized node dsp1_cma at 99000000,
compatible id shared-dma-pool

[    0.000000] Reserved memory: created CMA memory pool at
0x000000009d000000, size 32 MiB

[    0.000000] Reserved memory: initialized node ipu1_cma at 9d000000,
compatible id shared-dma-pool

[    0.000000] Reserved memory: created CMA memory pool at
0x000000009f000000, size 16 MiB

[    0.000000] Reserved memory: initialized node dsp2_cma at 9f000000,
compatible id shared-dma-pool

[    0.000000] cma: Reserved 24 MiB at 0x00000000fd800000

[    0.000000] Forcing write-allocate cache policy for SMP

[    0.000000] Memory policy: Data cache writealloc

[    0.000000] OMAP4: Map 0x000000027fd00000 to fe600000 for dram barrier

[    0.000000] On node 0 totalpages: 1042176

[    0.000000] free_area_init_node: node 0, pgdat c0e855c0,
node_mem_map ee39e000

[    0.000000]   DMA zone: 1608 pages used for memmap

[    0.000000]   DMA zone: 0 pages reserved

[    0.000000]   DMA zone: 204800 pages, LIFO batch:31

[    0.000000]   HighMem zone: 837376 pages, LIFO batch:31

[    0.000000] DRA752 ES2.0

[    0.000000] PERCPU: Embedded 13 pages/cpu @ee320000 s22592 r8192
d22464 u53248

[    0.000000] pcpu-alloc: s22592 r8192 d22464 u53248 alloc=13*4096

[    0.000000] pcpu-alloc: [0] 0 [0] 1

[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 1040568

...


[    0.000000] Memory: 3818136K/4168704K available (6701K kernel code,
577K rwdata, 1724K rodata, 2048K init, 381K bss, 153960K reserved,
196608K cma-reserved, 3324928K highmem)

[    0.000000] Virtual kernel memory layout:

[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)

[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)

[    0.000000]     vmalloc : 0xf2800000 - 0xff800000   ( 208 MB)

[    0.000000]     lowmem  : 0xc0000000 - 0xf2400000   ( 804 MB)

[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)

[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)

[    0.000000]       .text : 0xc0008000 - 0xc088b4e0   (8718 kB)

[    0.000000]       .init : 0xc0c00000 - 0xc0e00000   (2048 kB)

[    0.000000]       .data : 0xc0e00000 - 0xc0e90624   ( 578 kB)

[    0.000000]        .bss : 0xc0e92000 - 0xc0ef160c   ( 382 kB)

[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1


....

[   66.801410] logd.writer invoked oom-killer: gfp_mask=0x24000d0,
order=0, oom_score_adj=-1000

[   66.805748] CPU: 0 PID: 113 Comm: logd.writer Tainted: G        W
O    4.4.45+ #12

[   66.809599] Hardware name: Generic DRA74X (Flattened Device Tree)

[   66.812681] [<c020fe8c>] (unwind_backtrace) from [<c020bd34>]
(show_stack+0x20/0x24)

[   66.816580] [<c020bd34>] (show_stack) from [<c04bb334>]
(dump_stack+0xb8/0xe4)

[   66.820217] [<c04bb334>] (dump_stack) from [<c03395a4>]
(dump_header+0x5c/0x16c)

[   66.823940] [<c03395a4>] (dump_header) from [<c02f00d0>]
(oom_kill_process+0x318/0x460)

[   66.827967] [<c02f00d0>] (oom_kill_process) from [<c02f0594>]
(out_of_memory+0x304/0x350)

[   66.832082] [<c02f0594>] (out_of_memory) from [<c02f55f0>]
(__alloc_pages_nodemask+0x874/0x998)

[   66.836459] [<c02f55f0>] (__alloc_pages_nodemask) from [<c02f5734>]
(__get_free_pages+0x20/0x3c)

[   66.840878] [<c02f5734>] (__get_free_pages) from [<c0392170>]
(proc_pid_cmdline_read+0xa4/0x5a8)

[   66.845296] [<c0392170>] (proc_pid_cmdline_read) from [<c033be54>]
(__vfs_read+0x34/0xe0)

[   66.849408] [<c033be54>] (__vfs_read) from [<c033c69c>] (vfs_read+0x8c/0x118)

[   66.852997] [<c033c69c>] (vfs_read) from [<c033cfa0>] (SyS_read+0x4c/0xa0)

[   66.856456] [<c033cfa0>] (SyS_read) from [<c0207e00>]
(ret_fast_syscall+0x0/0x1c)

[   66.860655] Mem-Info:

[   66.861896] active_anon:233918 inactive_anon:25216 isolated_anon:0

[   66.861896]  active_file:20206 inactive_file:111218 isolated_file:0

[   66.861896]  unevictable:0 dirty:0 writeback:0 unstable:0

[   66.861896]  slab_reclaimable:3063 slab_unreclaimable:6164

[   66.861896]  mapped:157484 shmem:25476 pagetables:7490 bounce:23

[   66.861896]  free:496396 free_pcp:435 free_cma:15302

[   66.880653] DMA free:42104kB min:2808kB low:7408kB high:8112kB
active_anon:86236kB inactive_anon:99528kB active_file:144kB
inactive_file:0kB unevictable:0kB isolated(anon):0kB
isolated(file):68kB present:819200kB managed:668108kB mlocked:0kB
dirty:0kB writeback:0kB mapped:252512kB shmem:99576kB
slab_reclaimable:12252kB slab_unreclaimable:24656kB
kernel_stack:10856kB pagetables:3404kB unstable:0kB bounce:92kB
free_pcp:1284kB local_pcp:628kB free_cma:38780kB writeback_tmp:0kB
pages_scanned:0 all_unreclaimable? no

[   66.904623] lowmem_reserve[]: 0 0 6494 6494

[   66.907897] HighMem free:1943088kB min:512kB low:23580kB
high:27100kB active_anon:849436kB inactive_anon:1440kB
active_file:80784kB inactive_file:444956kB unevictable:0kB
isolated(anon):0kB isolated(file):0kB present:3349504kB
managed:3349504kB mlocked:0kB dirty:0kB writeback:0kB mapped:377572kB
shmem:2480kB slab_reclaimable:0kB slab_unreclaimable:0kB
kernel_stack:0kB pagetables:26556kB unstable:0kB bounce:0kB
free_pcp:352kB local_pcp:224kB free_cma:22428kB writeback_tmp:0kB
pages_scanned:0 all_unreclaimable? no

[   66.933683] lowmem_reserve[]: 0 0 0 0

[   66.936089] DMA: 679*4kB (UMEC) 234*8kB (UMEC) 100*16kB (UMC)
27*32kB (MC) 12*64kB (C) 4*128kB (C) 4*256kB (C) 0*512kB 0*1024kB
0*2048kB 8*4096kB (C) = 42124kB

[   66.944113] HighMem: 8685*4kB (MC) 4196*8kB (MC) 2162*16kB (UMC)
1244*32kB (UMC) 679*64kB (MC) 187*128kB (MC) 63*256kB (UMC) 25*512kB
(M) 20*1024kB (UMC) 6*2048kB (M) 408*4096kB (MC) = 1942964kB

[   66.954296] 157051 total pagecache pages

[   66.956536] 0 pages in swap cache

[   66.958342] Swap cache stats: add 0, delete 0, find 0/0

[   66.961208] Free swap  = 0kB

[   66.962769] Total swap = 0kB

[   66.965069] 1042176 pages RAM

[   66.967429] 837376 pages HighMem/MovableOnly

[   66.969836] 37773 pages reserved

[   66.971648] 49152 pages cma reserved

Regards,
Priyaranjan
