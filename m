From: harninder.rai@nxp.com (Harninder Rai)
Date: Fri, 27 May 2016 12:03:38 +0000
Subject: kexec: Not able to copy the vmcore file to external device
Message-ID: <DB5PR04MB1688C4D8931ED1F0AB51851BE6420@DB5PR04MB1688.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Takahiro Akashi/Geoff,

When I try a smaller RAM based rootfs to boot the crash kernel, the vmcore file gets generated correctly (it is of 2GB size) 
But I am not able to copy that file completely on my mounted SD card. I get some out of memory errors
Following is the state of my booted crash dump kernel

root at freescale /$ df -h
Filesystem                Size      Used Available Use% Mounted on
shm                      18.2M         0     18.2M   0% /dev/shm
rwfs                    512.0K         0    512.0K   0% /mnt/rwfs
root at freescale /$ ls -ltrh /proc/vmcore
-r--------    1 root     root        1.9G Jan  1 00:00 /proc/vmcore

root at freescale /$ mount /dev/mmcblk0p1 /mnt/
[   64.624900] EXT4-fs (mmcblk0p1): couldn't mount as ext3 due to feature incompatibilities
[   64.641148] EXT4-fs (mmcblk0p1): warning: mounting unchecked fs, running e2fsck is recommended
[   64.655126] EXT4-fs (mmcblk0p1): mounted filesystem without journal. Opts: (null)
root at freescale /$ cp /proc/vmcore /mnt/
[   77.068317] random: nonblocking pool is initialized
[   95.787102] cp invoked oom-killer: gfp_mask=0x26040c0, order=0, oom_score_adj=0
[   95.794531] CPU: 0 PID: 886 Comm: cp Not tainted 4.5.0-rc6-00038-gae2804a-dirty #5
[   95.802125] Hardware name: Freescale Layerscape 2085a RDB Board (DT)
[   95.808499] Call trace:
[   95.810957] [<ffff800000089760>] dump_backtrace+0x0/0x1ac
[   95.816374] [<ffff800000089920>] show_stack+0x14/0x1c
[   95.821442] [<ffff80000032c1d4>] dump_stack+0x8c/0xb0
[   95.826510] [<ffff8000001aebdc>] dump_header.isra.7+0x4c/0x18c
[   95.832362] [<ffff800000152130>] oom_kill_process+0x26c/0x45c
[   95.838126] [<ffff800000152688>] out_of_memory+0x2e0/0x32c
[   95.843628] [<ffff800000156c68>] __alloc_pages_nodemask+0x83c/0x848
[   95.849915] [<ffff80000019a9b8>] cache_alloc_refill+0x38c/0x5fc
[   95.855852] [<ffff80000019acec>] kmem_cache_alloc+0xc4/0x138
[   95.861529] [<ffff800000185118>] alloc_vmap_area.isra.38+0x64/0x2f4
[   95.867815] [<ffff800000185a88>] __get_vm_area_node.isra.39+0xa0/0x15c
[   95.874365] [<ffff800000186084>] get_vm_area_caller+0x34/0x3c
[   95.880129] [<ffff800000097814>] __ioremap_caller+0x6c/0xdc
[   95.885717] [<ffff80000009792c>] ioremap_cache+0x5c/0x68
[   95.891044] [<ffff800000095430>] copy_oldmem_page+0x48/0xe8
[   95.896635] [<ffff80000021c044>] read_from_oldmem.part.3+0xbc/0xfc
[   95.902834] [<ffff80000021c180>] read_vmcore+0xfc/0x228
[   95.908076] [<ffff80000020f654>] proc_reg_read+0x64/0x94
[   95.913403] [<ffff8000001b17b0>] __vfs_read+0x2c/0xd8
[   95.918469] [<ffff8000001b25a0>] vfs_read+0x7c/0x144
[   95.923448] [<ffff8000001b33d0>] SyS_read+0x44/0xa0
[   95.928341] [<ffff800000085d30>] el0_svc_naked+0x24/0x28
[   95.933705] Mem-Info:
[   95.936072] active_anon:46 inactive_anon:0 isolated_anon:0
[   95.936072]  active_file:91 inactive_file:543 isolated_file:0
[   95.936072]  unevictable:2102 dirty:5 writeback:549 unstable:0
[   95.936072]  slab_reclaimable:312 slab_unreclaimable:1301
[   95.936072]  mapped:366 shmem:0 pagetables:12 bounce:0
[   95.936072]  free:3700 free_pcp:0 free_cma:3511
[   95.968438] DMA free:14796kB min:764kB low:952kB high:1144kB active_anon:184kB inactive_anon:0kB active_file:368kB inactive_file:2176kB unevictable:8408kB isolated(anon):0kB isolated(file):0kB present:65536kB managed:37372kB mlocked:0kB dirty:16kB writeback:2188kB mapped:1464kB shmem:0kB slab_reclaimable:1248kB slab_unreclaimable:5204kB kernel_stack:1088kB pagetables:48kB unstable:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:14040kB writeback_tmp:0kB pages_scanned:15584 all_unreclaimable? yes
[   96.012892] lowmem_reserve[]: 0 0 0
[   96.016412] DMA: 1*4kB (E) 21*8kB (UEC) 12*16kB (UC) 15*32kB (UC) 16*64kB (UC) 9*128kB (C) 12*256kB (C) 5*512kB (C) 4*1024kB (C) 1*2048kB (C) 0*4096kB = 14796kB
[   96.030922] Node 0 hugepages_total=1 hugepages_free=1 hugepages_surp=0 hugepages_size=2048kB
[   96.039390] 2737 total pagecache pages
[   96.043151] 0 pages in swap cache
[   96.046474] Swap cache stats: add 0, delete 0, find 0/0
[   96.051717] Free swap  = 0kB
[   96.054601] Total swap = 0kB
[   96.057491] 16384 pages RAM
[   96.060434] 0 pages HighMem/MovableOnly
[   96.064283] 7041 pages reserved
[   96.067428] 4096 pages cma reserved
[   96.070926] [ pid ]   uid  tgid total_vm      rss nr_ptes nr_pmds swapents oom_score_adj name
[   96.079487] [  877]     0   877      555      353       4       3        0             0 sh
[   96.087870] [  886]     0   886      539        1       4       3        0             0 cp
[   96.096253] Out of memory: Kill process 877 (sh) score 37 or sacrifice child
[   96.103334] Killed process 886 (cp) total-vm:2156kB, anon-rss:4kB, file-rss:0kB, shmem-rss:0kB
Killed
root at freescale /$ ls -ltr /mnt/vmcore
-r--------    1 root     root      65593344 Jan  1 00:01 /mnt/vmcore
root at freescale /$ ls -ltr /mnt/vmcore -h
-r--------    1 root     root       62.6M Jan  1 00:01 /mnt/vmcore

Thanks and Regards
Harry++
