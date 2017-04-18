From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 18 Apr 2017 09:32:31 +0100
Subject: kvm/arm64: use-after-free in
 kvm_unmap_hva_handler/unmap_stage2_pmds
In-Reply-To: <20170413155045.GA8387@e107814-lin.cambridge.arm.com>
References: <CAAeHK+yjKm3mO2h9M30t-V_PnMhXEM887_zESCSg6gkbzivPsQ@mail.gmail.com>
 <20f6c994-d83e-7a6f-9f13-f10287211a6c@arm.com>
 <9f473bb9-d0eb-6803-1263-75ffef0301fe@redhat.com>
 <CAAeHK+x8udHKq9xa1zkTO6ax5E8Dk32HYWfaT05FMchL2cr48g@mail.gmail.com>
 <1050c9d8-5813-5df9-29e5-3ab6e61b5de6@arm.com>
 <88715300-ef58-e7bd-81f5-95e0b9c9c533@arm.com>
 <20170413155045.GA8387@e107814-lin.cambridge.arm.com>
Message-ID: <20170418083230.GA17866@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On Thu, Apr 13, 2017 at 04:50:46PM +0100, Suzuki K. Poulose wrote:
> kvm: Hold reference to the user address space
> 
> The core KVM code, uses mmgrab/mmdrop to pin the mm struct of the user
> application. mmgrab only guarantees that the mm struct is available,
> while the "real address space" (see Documentation/vm/active_mm.txt) may
> be destroyed. Since the KVM depends on the user space page tables for
> the Guest pages, we should instead do an mmget/mmput. Even though
> mmget/mmput is not encouraged for uses with unbounded time, the KVM
> is fine to do so, as we are doing it from the context of the same process.
> 
> This also prevents the race condition where mmu_notifier_release() could
> be called in parallel and one instance could end up using a free'd kvm
> instance.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Paolo Bonzin <pbonzini@redhat.com>
> Cc: Radim Kr?m?? <rkrcmar@redhat.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: andreyknvl at google.com
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  virt/kvm/kvm_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 88257b3..555712e 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -613,7 +613,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
>  		return ERR_PTR(-ENOMEM);
>  
>  	spin_lock_init(&kvm->mmu_lock);
> -	mmgrab(current->mm);
> +	mmget(current->mm);
>  	kvm->mm = current->mm;
>  	kvm_eventfd_init(kvm);
>  	mutex_init(&kvm->lock);
> @@ -685,7 +685,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
>  	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++)
>  		kvm_free_memslots(kvm, kvm->memslots[i]);
>  	kvm_arch_free_vm(kvm);
> -	mmdrop(current->mm);
> +	mmput(current->mm);
>  	return ERR_PTR(r);
>  }
>  
> @@ -747,7 +747,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
>  	kvm_arch_free_vm(kvm);
>  	preempt_notifier_dec();
>  	hardware_disable_all();
> -	mmdrop(mm);
> +	mmput(mm);
>  }


As a heads-up, I'm seeing what looks to be a KVM memory leak with this
patch applied atop of next-20170411.

I don't yet know if this is a problem with next-20170411 or this patch
in particular -- I will try to track that down. In the mean time, info
dump below.

I left syzkaller running over the weekend using this kernel on the host,
and OOM kicked in after it had been running for a short while. Almost
all of my memory is in use, but judging by top, almost none of this is
associated with processes.

It looks like this is almost all AnonPages allocations:

nanook at medister:~$ cat /proc/meminfo 
MemTotal:       14258176 kB
MemFree:          106192 kB
MemAvailable:      38196 kB
Buffers:           27160 kB
Cached:            42508 kB
SwapCached:            0 kB
Active:         13442912 kB
Inactive:           7388 kB
Active(anon):   13380876 kB
Inactive(anon):      400 kB
Active(file):      62036 kB
Inactive(file):     6988 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:      13380688 kB
Mapped:             7352 kB
Shmem:               620 kB
Slab:             568196 kB
SReclaimable:      21756 kB
SUnreclaim:       546440 kB
KernelStack:        2832 kB
PageTables:        49168 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     7129088 kB
Committed_AS:   41554652 kB
VmallocTotal:   100930551744 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
AnonHugePages:  12728320 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
CmaTotal:          16384 kB
CmaFree:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB

Looking at slabtop, there are large number of vm_area_structs around:

 Active / Total Objects (% used)    : 531511 / 587214 (90.5%)
 Active / Total Slabs (% used)      : 29443 / 29443 (100.0%)
 Active / Total Caches (% used)     : 108 / 156 (69.2%)
 Active / Total Size (% used)       : 514052.23K / 536839.57K (95.8%)
 Minimum / Average / Maximum Object : 0.03K / 0.91K / 8.28K

  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME                   
 94924  89757  94%    0.24K   2877       33     23016K vm_area_struct
 72400  60687  83%    0.31K   2896       25     23168K filp
 70553  70484  99%    4.25K  10079        7    322528K names_cache
 70112  64605  92%    0.25K   2191       32     17528K kmalloc-128
 52458  50837  96%    0.09K   1249       42      4996K anon_vma_chain
 23492  22949  97%    4.25K   3356        7    107392K kmalloc-4096
 20631  20631 100%    0.10K    529       39      2116K anon_vma

... so it looks like we could be leaking the mm and associated mappings.

Full OOM splat:

[395953.231838] htop invoked oom-killer: gfp_mask=0x16040d0(GFP_TEMPORARY|__GFP_COMP|__GFP_NOTRACK), nodemask=(null),  order=0, oom_score_adj=0
[395953.244523] htop cpuset=/ mems_allowed=0
[395953.248556] CPU: 4 PID: 2301 Comm: htop Not tainted 4.11.0-rc6-next-20170411-dirty #7044
[395953.256727] Hardware name: AMD Seattle (Rev.B0) Development Board (Overdrive) (DT)
[395953.264374] Call trace:
[395953.266911] [<ffff20000808c358>] dump_backtrace+0x0/0x3a8
[395953.272394] [<ffff20000808c860>] show_stack+0x20/0x30
[395953.277530] [<ffff2000085a86f0>] dump_stack+0xbc/0xec
[395953.282666] [<ffff2000082d66f8>] dump_header+0xd8/0x328
[395953.287977] [<ffff200008215078>] oom_kill_process+0x400/0x6b0
[395953.293807] [<ffff200008215864>] out_of_memory+0x1ec/0x7c0
[395953.299377] [<ffff20000821d918>] __alloc_pages_nodemask+0xd88/0xe68
[395953.305728] [<ffff20000829bd8c>] alloc_pages_current+0xcc/0x218
[395953.311732] [<ffff2000082a9028>] new_slab+0x420/0x658
[395953.316868] [<ffff2000082ab360>] ___slab_alloc+0x370/0x5d8
[395953.322436] [<ffff2000082ab5ec>] __slab_alloc.isra.22+0x24/0x38
[395953.328438] [<ffff2000082abe5c>] kmem_cache_alloc+0x1bc/0x1e8
[395953.334268] [<ffff200008387eec>] proc_alloc_inode+0x24/0xa8
[395953.339924] [<ffff20000830af14>] alloc_inode+0x3c/0xf0
[395953.345146] [<ffff20000830df90>] new_inode_pseudo+0x20/0x80
[395953.350800] [<ffff20000830e014>] new_inode+0x24/0x50
[395953.355850] [<ffff20000838e860>] proc_pid_make_inode+0x28/0x118
[395953.361853] [<ffff20000838ea78>] proc_pident_instantiate+0x48/0x140
[395953.368204] [<ffff20000838ec6c>] proc_pident_lookup+0xfc/0x168
[395953.374121] [<ffff20000838ed8c>] proc_tgid_base_lookup+0x34/0x40
[395953.380210] [<ffff2000082f77ec>] path_openat+0x194c/0x1b68
[395953.385779] [<ffff2000082f96e0>] do_filp_open+0xe0/0x178
[395953.391178] [<ffff2000082d9f70>] do_sys_open+0x1e8/0x300
[395953.396575] [<ffff2000082da108>] SyS_openat+0x38/0x48
[395953.401710] [<ffff200008083730>] el0_svc_naked+0x24/0x28
[395953.408051] Mem-Info:
[395953.410423] active_anon:3354643 inactive_anon:100 isolated_anon:0
[395953.410423]  active_file:16 inactive_file:0 isolated_file:0
[395953.410423]  unevictable:0 dirty:0 writeback:0 unstable:0
[395953.410423]  slab_reclaimable:15505 slab_unreclaimable:143437
[395953.410423]  mapped:0 shmem:155 pagetables:10329 bounce:0
[395953.410423]  free:21060 free_pcp:403 free_cma:0
[395953.443636] Node 0 active_anon:13418572kB inactive_anon:400kB active_file:540kB inactive_file:104kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:380kB dirty:0kB writeback:0kB shmem:620kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 12926976kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
[395953.471351] Node 0 DMA free:50620kB min:12828kB low:16884kB high:20940kB active_anon:3989600kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:4194304kB managed:4060788kB mlocked:0kB slab_reclaimable:2928kB slab_unreclaimable:10648kB kernel_stack:0kB pagetables:3600kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[395953.503543] lowmem_reserve[]: 0 9958 9958
[395953.507654] Node 0 Normal free:33004kB min:32224kB low:42420kB high:52616kB active_anon:9428972kB inactive_anon:400kB active_file:132kB inactive_file:80kB unevictable:0kB writepending:0kB present:12582912kB managed:10197388kB mlocked:0kB slab_reclaimable:59092kB slab_unreclaimable:563100kB kernel_stack:4032kB pagetables:37716kB bounce:0kB free_pcp:560kB local_pcp:0kB free_cma:0kB
[395953.541392] lowmem_reserve[]: 0 0 0
[395953.544979] Node 0 DMA: 531*4kB (UME) 210*8kB (UME) 114*16kB (UME) 34*32kB (ME) 18*64kB (UME) 34*128kB (UME) 46*256kB (UM) 14*512kB (UM) 7*1024kB (UM) 0*2048kB 3*4096kB (M) = 50620kB
[395953.561390] Node 0 Normal: 3041*4kB (UMEH) 1694*8kB (UMEH) 447*16kB (UMEH) 10*32kB (U) 2*64kB (H) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 33316kB
[395953.575702] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[395953.584229] 521 total pagecache pages
[395953.587984] 0 pages in swap cache
[395953.591392] Swap cache stats: add 0, delete 0, find 0/0
[395953.596706] Free swap  = 0kB
[395953.599677] Total swap = 0kB
[395953.602638] 4194304 pages RAM
[395953.605692] 0 pages HighMem/MovableOnly
[395953.609617] 629760 pages reserved
[395953.613021] 4096 pages cma reserved
[395953.616599] [ pid ]   uid  tgid total_vm      rss nr_ptes nr_pmds swapents oom_score_adj name
[395953.625244] [ 1447]     0  1447      714       74       5       3        0             0 upstart-udev-br
[395953.634818] [ 1450]     0  1450     2758      187       7       3        0         -1000 systemd-udevd
[395953.644218] [ 1833]     0  1833      632       46       5       3        0             0 upstart-socket-
[395953.653790] [ 1847]     0  1847      708       63       5       3        0             0 rpcbind
[395953.662668] [ 1879]   106  1879      737      114       5       3        0             0 rpc.statd
[395953.671734] [ 1984]     0  1984      636       54       5       4        0             0 upstart-file-br
[395953.681307] [ 2000]   103  2000     1152      120       6       3        0             0 dbus-daemon
[395953.690534] [ 2006]     0  2006      720       49       6       3        0             0 rpc.idmapd
[395953.699676] [ 2008]   101  2008    56308      201      12       3        0             0 rsyslogd
[395953.708641] [ 2014]     0  2014    58414      289      16       3        0             0 ModemManager
[395953.717952] [ 2032]     0  2032     1222       87       6       3        0             0 systemd-logind
[395953.727440] [ 2050]     0  2050    61456      371      18       3        0             0 NetworkManager
[395953.736927] [ 2068]     0  2068      587       39       5       3        0             0 getty
[395953.745632] [ 2071]     0  2071    57242      173      14       3        0             0 polkitd
[395953.754510] [ 2075]     0  2075      587       40       5       3        0             0 getty
[395953.763216] [ 2078]     0  2078      587       39       5       3        0             0 getty
[395953.771922] [ 2079]     0  2079      587       38       5       3        0             0 getty
[395953.780628] [ 2081]     0  2081      587       40       5       3        0             0 getty
[395953.789334] [ 2101]     0  2101     2061      163       8       4        0         -1000 sshd
[395953.797952] [ 2102]     0  2102      793       57       6       3        0             0 cron
[395953.806583] [ 2159]     0  2159      542       38       5       3        0             0 getty
[395953.815288] [ 2161]     0  2161      587       40       5       3        0             0 getty
[395953.823992] [ 2171]     0  2171     1356      575       6       4        0             0 dhclient
[395953.832956] [ 2175] 65534  2175      845       58       5       3        0             0 dnsmasq
[395953.841834] [ 2265]     0  2265     3249      261      10       3        0             0 sshd
[395953.850451] [ 2278]  1000  2278     3249      262       9       3        0             0 sshd
[395953.859067] [ 2279]  1000  2279      920      176       5       3        0             0 bash
[395953.867686] [ 2289]  1000  2289      862       63       5       3        0             0 screen
[395953.876479] [ 2290]  1000  2290     1063      286       5       3        0             0 screen
[395953.885272] [ 2291]  1000  2291      930      186       5       3        0             0 bash
[395953.893890] [ 2301]  1000  2301     1190      550       6       3        0             0 htop
[395953.902508] [ 2302]  1000  2302      940      197       5       3        0             0 bash
[395953.911126] [ 2358]  1000  2358   447461    46148     163       5        0             0 qemu-system-aar
[395953.920699] [ 2359]  1000  2359   449502    45509     166       4        0             0 qemu-system-aar
[395953.930271] [ 2360]  1000  2360   447461    43753     160       5        0             0 qemu-system-aar
[395953.939854] [ 2361]  1000  2361   447461    46144     161       4        0             0 qemu-system-aar
[395953.949429] [ 2362]  1000  2362   447461    44522     160       5        0             0 qemu-system-aar
[395953.959001] [ 2363]  1000  2363   447461    44311     161       4        0             0 qemu-system-aar
[395953.968574] [ 4600]  1000  4600    19468    12828      42       5        0             0 syz-manager
[395953.977820] [ 4915]  1000  4915    16364     1127      28       3        0             0 qemu-system-aar
[395953.987397] [ 4917]  1000  4917    16364     1127      27       3        0             0 qemu-system-aar
[395953.996972] [ 4918]  1000  4918    16364     1127      28       3        0             0 qemu-system-aar
[395954.006546] [ 4919]  1000  4919    16364     1128      28       3        0             0 qemu-system-aar
[395954.016119] [ 4920]  1000  4920    16364      617      30       3        0             0 qemu-system-aar
[395954.025692] [ 4922]  1000  4922    14028      344      21       3        0             0 qemu-system-aar
[395954.035273] Out of memory: Kill process 2358 (qemu-system-aar) score 12 or sacrifice child
[395954.043659] Killed process 2358 (qemu-system-aar) total-vm:1789844kB, anon-rss:184592kB, file-rss:0kB, shmem-rss:0kB
[395954.055211] qemu-system-aar: page allocation failure: order:0, mode:0x14201ca(GFP_HIGHUSER_MOVABLE|__GFP_COLD), nodemask=(null)
[395954.066817] qemu-system-aar cpuset=/ mems_allowed=0
[395954.067606] oom_reaper: reaped process 2358 (qemu-system-aar), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
[395954.081761] CPU: 5 PID: 2358 Comm: qemu-system-aar Not tainted 4.11.0-rc6-next-20170411-dirty #7044
[395954.090886] Hardware name: AMD Seattle (Rev.B0) Development Board (Overdrive) (DT)
[395954.098533] Call trace:
[395954.101072] [<ffff20000808c358>] dump_backtrace+0x0/0x3a8
[395954.106555] [<ffff20000808c860>] show_stack+0x20/0x30
[395954.111692] [<ffff2000085a86f0>] dump_stack+0xbc/0xec
[395954.116830] [<ffff20000821ca4c>] warn_alloc+0x144/0x1d8
[395954.122140] [<ffff20000821d9e8>] __alloc_pages_nodemask+0xe58/0xe68
[395954.128491] [<ffff20000829bd8c>] alloc_pages_current+0xcc/0x218
[395954.134494] [<ffff20000820e770>] __page_cache_alloc+0x128/0x150
[395954.140498] [<ffff200008212648>] filemap_fault+0x768/0x940
[395954.146069] [<ffff2000083caf8c>] ext4_filemap_fault+0x4c/0x68
[395954.151898] [<ffff20000825bac4>] __do_fault+0x44/0xd0
[395954.157033] [<ffff200008264c5c>] __handle_mm_fault+0x12c4/0x1978
[395954.163122] [<ffff200008265514>] handle_mm_fault+0x204/0x388
[395954.168865] [<ffff2000080a3994>] do_page_fault+0x3fc/0x4b0
[395954.174434] [<ffff200008081444>] do_mem_abort+0xa4/0x138
[395954.179827] Exception stack(0xffff80034db07dc0 to 0xffff80034db07ef0)
[395954.186352] 7dc0: 0000000000000000 00006003f67fc000 ffffffffffffffff 00000000004109b0
[395954.194266] 7de0: 0000000060000000 0000000000000020 0000000082000007 00000000004109b0
[395954.202179] 7e00: 0000000041b58ab3 ffff20000955d370 ffff2000080813a0 0000000000000124
[395954.210093] 7e20: 0000000000000049 ffff200008f44000 ffff80034db07e40 ffff200008085f60
[395954.218006] 7e40: ffff80034db07e80 ffff20000808b5a0 0000000000000008 ffff80035dde5e80
[395954.225920] 7e60: ffff80035dde5e80 ffff80035dde64f0 ffff80034db07e80 ffff20000808b580
[395954.233833] 7e80: 0000000000000000 ffff200008083618 0000000000000000 00006003f67fc000
[395954.241746] 7ea0: ffffffffffffffff 000000000078d790 0000000060000000 00006003f6813000
[395954.249659] 7ec0: 0000ffffa685f708 0000000000000001 0000000000000001 0000000000000000
[395954.257569] 7ee0: 0000000000000002 0000000000000000
[395954.262530] [<ffff200008083388>] el0_ia+0x18/0x1c
[395954.267433] Mem-Info:
[395954.269806] active_anon:3308476 inactive_anon:100 isolated_anon:0
[395954.269806]  active_file:98 inactive_file:570 isolated_file:0
[395954.269806]  unevictable:0 dirty:0 writeback:0 unstable:0
[395954.269806]  slab_reclaimable:15503 slab_unreclaimable:143557
[395954.269806]  mapped:264 shmem:155 pagetables:10329 bounce:0
[395954.269806]  free:66173 free_pcp:470 free_cma:0
[395954.303371] Node 0 active_anon:13233904kB inactive_anon:400kB active_file:392kB inactive_file:3320kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:1836kB dirty:0kB writeback:0kB shmem:620kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 12728320kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
[395954.331169] Node 0 DMA free:50620kB min:12828kB low:16884kB high:20940kB active_anon:3989600kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:4194304kB managed:4060788kB mlocked:0kB slab_reclaimable:2928kB slab_unreclaimable:10648kB kernel_stack:0kB pagetables:3600kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[395954.363335] lowmem_reserve[]: 0 9958 9958
[395954.367625] Node 0 Normal free:212516kB min:32224kB low:42420kB high:52616kB active_anon:9244644kB inactive_anon:400kB active_file:548kB inactive_file:3828kB unevictable:0kB writepending:0kB present:12582912kB managed:10197388kB mlocked:0kB slab_reclaimable:59084kB slab_unreclaimable:563912kB kernel_stack:4032kB pagetables:37716kB bounce:0kB free_pcp:1840kB local_pcp:0kB free_cma:0kB
[395954.401710] lowmem_reserve[]: 0 0 0
[395954.405298] Node 0 DMA: 531*4kB (UME) 210*8kB (UME) 114*16kB (UME) 34*32kB (ME) 18*64kB (UME) 34*128kB (UME) 46*256kB (UM) 14*512kB (UM) 7*1024kB (UM) 0*2048kB 3*4096kB (M) = 50620kB
[395954.421698] Node 0 Normal: 1840*4kB (UMEH) 1740*8kB (MEH) 496*16kB (ME) 47*32kB (UME) 25*64kB (MEH) 3*128kB (UME) 2*256kB (UE) 1*512kB (E) 2*1024kB (UE) 61*2048kB (UME) 12*4096kB (M) = 209856kB
[395954.439058] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[395954.447582] 2104 total pagecache pages
[395954.451421] 0 pages in swap cache
[395954.454817] Swap cache stats: add 0, delete 0, find 0/0
[395954.460130] Free swap  = 0kB
[395954.463090] Total swap = 0kB
[395954.466057] 4194304 pages RAM
[395954.469111] 0 pages HighMem/MovableOnly
[395954.473035] 629760 pages reserved
[395954.476436] 4096 pages cma reserved
[395954.480151] qemu-system-aar invoked oom-killer: gfp_mask=0x0(), nodemask=(null),  order=0, oom_score_adj=0
[395954.489898] qemu-system-aar cpuset=/ mems_allowed=0
[395954.494879] CPU: 5 PID: 2358 Comm: qemu-system-aar Not tainted 4.11.0-rc6-next-20170411-dirty #7044
[395954.504003] Hardware name: AMD Seattle (Rev.B0) Development Board (Overdrive) (DT)
[395954.511651] Call trace:
[395954.514184] [<ffff20000808c358>] dump_backtrace+0x0/0x3a8
[395954.519668] [<ffff20000808c860>] show_stack+0x20/0x30
[395954.524802] [<ffff2000085a86f0>] dump_stack+0xbc/0xec
[395954.529939] [<ffff2000082d66f8>] dump_header+0xd8/0x328
[395954.535248] [<ffff200008215078>] oom_kill_process+0x400/0x6b0
[395954.541078] [<ffff200008215864>] out_of_memory+0x1ec/0x7c0
[395954.546648] [<ffff200008215efc>] pagefault_out_of_memory+0xc4/0xd0
[395954.552911] [<ffff2000080a3a40>] do_page_fault+0x4a8/0x4b0
[395954.558478] [<ffff200008081444>] do_mem_abort+0xa4/0x138
[395954.563872] Exception stack(0xffff80034db07dc0 to 0xffff80034db07ef0)
[395954.570397] 7dc0: 0000000000000000 00006003f67fc000 ffffffffffffffff 00000000004109b0
[395954.578310] 7de0: 0000000060000000 0000000000000020 0000000082000007 00000000004109b0
[395954.586224] 7e00: 0000000041b58ab3 ffff20000955d370 ffff2000080813a0 0000000000000124
[395954.594137] 7e20: 0000000000000049 ffff200008f44000 ffff80034db07e40 ffff200008085f60
[395954.602051] 7e40: ffff80034db07e80 ffff20000808b5a0 0000000000000008 ffff80035dde5e80
[395954.609965] 7e60: ffff80035dde5e80 ffff80035dde64f0 ffff80034db07e80 ffff20000808b580
[395954.617878] 7e80: 0000000000000000 ffff200008083618 0000000000000000 00006003f67fc000
[395954.625791] 7ea0: ffffffffffffffff 000000000078d790 0000000060000000 00006003f6813000
[395954.633704] 7ec0: 0000ffffa685f708 0000000000000001 0000000000000001 0000000000000000
[395954.641614] 7ee0: 0000000000000002 0000000000000000
[395954.646575] [<ffff200008083388>] el0_ia+0x18/0x1c
[395954.651396] Mem-Info:
[395954.653772] active_anon:3308476 inactive_anon:100 isolated_anon:0
[395954.653772]  active_file:98 inactive_file:2390 isolated_file:0
[395954.653772]  unevictable:0 dirty:0 writeback:0 unstable:0
[395954.653772]  slab_reclaimable:15503 slab_unreclaimable:143634
[395954.653772]  mapped:1694 shmem:155 pagetables:10329 bounce:0
[395954.653772]  free:64244 free_pcp:379 free_cma:0
[395954.687511] Node 0 active_anon:13233904kB inactive_anon:400kB active_file:392kB inactive_file:9820kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:7036kB dirty:0kB writeback:0kB shmem:620kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 12728320kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
[395954.715375] Node 0 DMA free:50620kB min:12828kB low:16884kB high:20940kB active_anon:3989600kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:4194304kB managed:4060788kB mlocked:0kB slab_reclaimable:2928kB slab_unreclaimable:10648kB kernel_stack:0kB pagetables:3600kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[395954.747565] lowmem_reserve[]: 0 9958 9958
[395954.751679] Node 0 Normal free:204900kB min:32224kB low:42420kB high:52616kB active_anon:9244220kB inactive_anon:400kB active_file:548kB inactive_file:10328kB unevictable:0kB writepending:0kB present:12582912kB managed:10197388kB mlocked:0kB slab_reclaimable:59620kB slab_unreclaimable:564176kB kernel_stack:4032kB pagetables:37716kB bounce:0kB free_pcp:1548kB local_pcp:244kB free_cma:0kB
[395954.786024] lowmem_reserve[]: 0 0 0
[395954.789615] Node 0 DMA: 531*4kB (UME) 210*8kB (UME) 114*16kB (UME) 34*32kB (ME) 18*64kB (UME) 34*128kB (UME) 46*256kB (UM) 14*512kB (UM) 7*1024kB (UM) 0*2048kB 3*4096kB (M) = 50620kB
[395954.806097] Node 0 Normal: 600*4kB (UMEH) 1772*8kB (UMEH) 496*16kB (UME) 53*32kB (UME) 25*64kB (UMH) 3*128kB (UME) 1*256kB (U) 1*512kB (U) 1*1024kB (E) 61*2048kB (UME) 12*4096kB (M) = 204064kB
[395954.823477] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[395954.832055] 3171 total pagecache pages
[395954.835933] 0 pages in swap cache
[395954.839343] Swap cache stats: add 0, delete 0, find 0/0
[395954.844670] Free swap  = 0kB
[395954.847642] Total swap = 0kB
[395954.850614] 4194304 pages RAM
[395954.853671] 0 pages HighMem/MovableOnly
[395954.857603] 629760 pages reserved
[395954.861023] 4096 pages cma reserved
[395954.864611] [ pid ]   uid  tgid total_vm      rss nr_ptes nr_pmds swapents oom_score_adj name
[395954.873281] [ 1447]     0  1447      714       74       5       3        0             0 upstart-udev-br
[395954.882868] [ 1450]     0  1450     2758      187       7       3        0         -1000 systemd-udevd
[395954.892294] [ 1833]     0  1833      632       46       5       3        0             0 upstart-socket-
[395954.901882] [ 1847]     0  1847      708       63       5       3        0             0 rpcbind
[395954.910766] [ 1879]   106  1879      737      114       5       3        0             0 rpc.statd
[395954.919856] [ 1984]     0  1984      636       54       5       4        0             0 upstart-file-br
[395954.929462] [ 2000]   103  2000     1152      120       6       3        0             0 dbus-daemon
[395954.938701] [ 2006]     0  2006      720       49       6       3        0             0 rpc.idmapd
[395954.947858] [ 2008]   101  2008    56308      201      12       3        0             0 rsyslogd
[395954.957164] [ 2014]     0  2014    58414      289      16       3        0             0 ModemManager
[395954.966503] [ 2032]     0  2032     1222       87       6       3        0             0 systemd-logind
[395954.976004] [ 2050]     0  2050    61456      371      18       3        0             0 NetworkManager
[395954.985531] [ 2068]     0  2068      587       39       5       3        0             0 getty
[395954.994255] [ 2071]     0  2071    57242      173      14       3        0             0 polkitd
[395955.003154] [ 2075]     0  2075      587       40       5       3        0             0 getty
[395955.011878] [ 2078]     0  2078      587       39       5       3        0             0 getty
[395955.020595] [ 2079]     0  2079      587       38       5       3        0             0 getty
[395955.029322] [ 2081]     0  2081      587       40       5       3        0             0 getty
[395955.038135] [ 2101]     0  2101     2061      163       8       4        0         -1000 sshd
[395955.046800] [ 2102]     0  2102      793       57       6       3        0             0 cron
[395955.055432] [ 2159]     0  2159      542       38       5       3        0             0 getty
[395955.064149] [ 2161]     0  2161      587       40       5       3        0             0 getty
[395955.072884] [ 2171]     0  2171     1356      575       6       4        0             0 dhclient
[395955.081874] [ 2175] 65534  2175      845       58       5       3        0             0 dnsmasq
[395955.090981] [ 2265]     0  2265     3249      261      10       3        0             0 sshd
[395955.099760] [ 2278]  1000  2278     3249      262       9       3        0             0 sshd
[395955.108420] [ 2279]  1000  2279      920      176       5       3        0             0 bash
[395955.117050] [ 2289]  1000  2289      862       63       5       3        0             0 screen
[395955.125870] [ 2290]  1000  2290     1063      286       5       3        0             0 screen
[395955.134674] [ 2291]  1000  2291      930      186       5       3        0             0 bash
[395955.143321] [ 2301]  1000  2301     1190      864       6       3        0             0 htop
[395955.151951] [ 2302]  1000  2302      940      197       5       3        0             0 bash
[395955.160595] [ 2358]  1000  2358   447461        0      76       5        0             0 qemu-system-aar
[395955.170175] [ 2359]  1000  2359   449502    45509     166       4        0             0 qemu-system-aar
[395955.180310] [ 2360]  1000  2360   447461    43753     160       5        0             0 qemu-system-aar
[395955.190467] [ 2361]  1000  2361   447461    46180     161       4        0             0 qemu-system-aar
[395955.200204] [ 2362]  1000  2362   447461    44522     160       5        0             0 qemu-system-aar
[395955.209834] [ 2363]  1000  2363   447461    44311     161       4        0             0 qemu-system-aar
[395955.219818] [ 4600]  1000  4600    19468    13943      42       5        0             0 syz-manager
[395955.229412] [ 4915]  1000  4915    16364     1278      28       3        0             0 qemu-system-aar
[395955.239707] [ 4917]  1000  4917    16364     1196      27       3        0             0 qemu-system-aar
[395955.249837] [ 4918]  1000  4918    16364     1473      28       3        0             0 qemu-system-aar
[395955.260569] [ 4919]  1000  4919    16364     1692      28       3        0             0 qemu-system-aar
[395955.270871] [ 4920]  1000  4920    16364      942      30       3        0             0 qemu-system-aar
[395955.280762] [ 4922]  1000  4922    14028      751      21       3        0             0 qemu-system-aar
[395955.290372] Out of memory: Kill process 2361 (qemu-system-aar) score 13 or sacrifice child
[395955.298858] Killed process 2361 (qemu-system-aar) total-vm:1789844kB, anon-rss:184576kB, file-rss:144kB, shmem-rss:0kB
[395955.324751] oom_reaper: reaped process 2361 (qemu-system-aar), now anon-rss:0kB, file-rss:20kB, shmem-rss:0kB

Thanks,
Mark.
