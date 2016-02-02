From: labbott@redhat.com (Laura Abbott)
Date: Tue, 2 Feb 2016 08:08:04 -0800
Subject: [PATCHv2 2/3] arm64: Add support for ARCH_SUPPORTS_DEBUG_PAGEALLOC
In-Reply-To: <20160202123155.GB32305@leverpostej>
References: <1454111218-3461-1-git-send-email-labbott@fedoraproject.org>
 <1454111218-3461-3-git-send-email-labbott@fedoraproject.org>
 <20160201122911.GF674@leverpostej> <56AFCD09.8000807@redhat.com>
 <20160202122317.GA32305@leverpostej> <20160202123155.GB32305@leverpostej>
Message-ID: <56B0D464.9050102@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/2016 04:31 AM, Mark Rutland wrote:
> On Tue, Feb 02, 2016 at 12:23:18PM +0000, Mark Rutland wrote:
>   Is there anything else in mm/ that I've potentially missed?
>> I'm seeing a hang on Juno just after reaching userspace (splat below)
>> with debug_pagealloc=on.
>>
>> It looks like something's gone wrong around find_vmap_area -- at least
>> one CPU is forever awaiting vmap_area_lock, and presumably some other
>> CPU has held it and gone into the weeds, leading to the RCU stalls and
>> NMI lockup warnings.
>
> [...]
>
>> I'll have a go with lock debugging.
>
> FWIW, with lock debugging I get the below splat before reaching userspace.
>
> [    0.145869] =================================
> [    0.145901] [ INFO: inconsistent lock state ]
> [    0.145935] 4.5.0-rc1+ #8 Not tainted
> [    0.145964] ---------------------------------
> [    0.145996] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> [    0.146036] swapper/5/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
> [    0.146070]  (vmap_area_lock){+.?...}, at: [<ffffffc0001a749c>] find_vmap_area+0x1c/0x98
> [    0.146151] {SOFTIRQ-ON-W} state was registered at:
> [    0.146184]   [<ffffffc0000fc2ac>] mark_lock+0x1bc/0x708
> [    0.146229]   [<ffffffc0000feb18>] __lock_acquire+0x928/0x1d90
> [    0.146274]   [<ffffffc00010032c>] lock_acquire+0x9c/0xe0
> [    0.146318]   [<ffffffc0006c8cd8>] _raw_spin_lock+0x40/0x58
> [    0.146362]   [<ffffffc0001a749c>] find_vmap_area+0x1c/0x98
> [    0.146406]   [<ffffffc0001a9c6c>] find_vm_area+0xc/0x38
> [    0.146447]   [<ffffffc000096420>] change_memory_common+0x38/0x120
> [    0.146495]   [<ffffffc0000965dc>] __kernel_map_pages+0x54/0x60
> [    0.146537]   [<ffffffc000176744>] get_page_from_freelist+0x86c/0x9a0
> [    0.146584]   [<ffffffc000176b98>] __alloc_pages_nodemask+0xf0/0x8a0
> [    0.146629]   [<ffffffc0009dd46c>] alloc_pages_exact_nid+0x48/0x90
> [    0.146675]   [<ffffffc0009b8004>] page_ext_init+0x94/0x124
> [    0.146718]   [<ffffffc0009a390c>] start_kernel+0x350/0x3d4
> [    0.146761]   [<ffffffc0000811b4>] 0xffffffc0000811b4
> [    0.146802] irq event stamp: 402
> [    0.146830] hardirqs last  enabled at (402): [<ffffffc000172c58>] free_pages_prepare+0x270/0x330
> [    0.146894] hardirqs last disabled at (401): [<ffffffc000172c58>] free_pages_prepare+0x270/0x330
> [    0.146956] softirqs last  enabled at (368): [<ffffffc0000bc070>] _local_bh_enable+0x20/0x48
> [    0.147022] softirqs last disabled at (369): [<ffffffc0000bca10>] irq_exit+0xa0/0xd8
> [    0.147081]
> [    0.147081] other info that might help us debug this:
> [    0.147130]  Possible unsafe locking scenario:
> [    0.147130]
> [    0.147177]        CPU0
> [    0.147201]        ----
> [    0.147225]   lock(vmap_area_lock);
> [    0.147260]   <Interrupt>
> [    0.147285]     lock(vmap_area_lock);
> [    0.147321]
> [    0.147321]  *** DEADLOCK ***
> [    0.147321]
> [    0.147381] 1 lock held by swapper/5/0:
> [    0.147410]  #0:  (rcu_callback){......}, at: [<ffffffc0001193f0>] rcu_process_callbacks+0x2b8/0x5f8
> [    0.147492]
> [    0.147492] stack backtrace:
> [    0.147538] CPU: 5 PID: 0 Comm: swapper/5 Not tainted 4.5.0-rc1+ #8
> [    0.147577] Hardware name: ARM Juno development board (r0) (DT)
> [    0.147613] Call trace:
> [    0.147644] [<ffffffc000089a38>] dump_backtrace+0x0/0x180
> [    0.147684] [<ffffffc000089bcc>] show_stack+0x14/0x20
> [    0.147724] [<ffffffc000373bb8>] dump_stack+0x90/0xc8
> [    0.147764] [<ffffffc00016bb3c>] print_usage_bug.part.21+0x260/0x278
> [    0.147807] [<ffffffc0000fc238>] mark_lock+0x148/0x708
> [    0.147846] [<ffffffc0000feadc>] __lock_acquire+0x8ec/0x1d90
> [    0.147887] [<ffffffc00010032c>] lock_acquire+0x9c/0xe0
> [    0.147925] [<ffffffc0006c8cd8>] _raw_spin_lock+0x40/0x58
> [    0.147965] [<ffffffc0001a749c>] find_vmap_area+0x1c/0x98
> [    0.148003] [<ffffffc0001a9c6c>] find_vm_area+0xc/0x38
> [    0.148044] [<ffffffc000096420>] change_memory_common+0x38/0x120
> [    0.148084] [<ffffffc0000965c8>] __kernel_map_pages+0x40/0x60
> [    0.148123] [<ffffffc000172cb8>] free_pages_prepare+0x2d0/0x330
> [    0.148164] [<ffffffc000174660>] __free_pages_ok+0x20/0x108
> [    0.148203] [<ffffffc0001750e0>] __free_pages+0x30/0x50
> [    0.148241] [<ffffffc0001753ac>] __free_kmem_pages+0x24/0x50
> [    0.148280] [<ffffffc000175410>] free_kmem_pages+0x38/0x40
> [    0.148320] [<ffffffc0000b5908>] free_task+0x30/0x60
> [    0.148359] [<ffffffc0000b59f8>] __put_task_struct+0xc0/0x110
> [    0.148400] [<ffffffc0000b91bc>] delayed_put_task_struct+0x44/0x50
> [    0.148442] [<ffffffc000119430>] rcu_process_callbacks+0x2f8/0x5f8
> [    0.148482] [<ffffffc0000bc594>] __do_softirq+0x13c/0x278
> [    0.148520] [<ffffffc0000bca10>] irq_exit+0xa0/0xd8
> [    0.148559] [<ffffffc00010ad90>] __handle_domain_irq+0x60/0xb8
> [    0.148599] [<ffffffc0000824f0>] gic_handle_irq+0x58/0xa8
> [    0.148636] Exception stack(0xffffffc97594be30 to 0xffffffc97594bf50)
> [    0.148678] be20:                                   ffffffc975933f00 0000000000000243
> [    0.148734] be40: 000000097e4a7000 0000000000000000 0000000000000000 0000000000000008
> [    0.148791] be60: 00000007de290000 00000000000270f0 0000000000000001 ffffffc975948000
> [    0.148848] be80: ffffffc00179e000 0000000000000000 ffffffc001507000 ffffffc001507f00
> [    0.148903] bea0: 000000000000000e 0000000000000007 0000000000000001 0000000000000007
> [    0.148960] bec0: 000000000000000e ffffffc000a5a000 ffffffc975948000 ffffffc000a5a000
> [    0.149017] bee0: ffffffc000a38c40 ffffffc000a3c460 ffffffc975948000 ffffffc000a5a000
> [    0.149073] bf00: ffffffc000af6000 0000000000000000 0000000000000000 ffffffc97594bf50
> [    0.149130] bf20: ffffffc0000867e0 ffffffc97594bf50 ffffffc0000867e4 0000000060000045
> [    0.149185] bf40: ffffffc97594bf50 ffffffc0000867e0
> [    0.149222] [<ffffffc0000855e4>] el1_irq+0xa4/0x114
> [    0.149260] [<ffffffc0000867e4>] arch_cpu_idle+0x14/0x20
> [    0.149299] [<ffffffc0000f7878>] default_idle_call+0x18/0x30
> [    0.149339] [<ffffffc0000f7a78>] cpu_startup_entry+0x1e8/0x240
> [    0.149380] [<ffffffc00008f064>] secondary_start_kernel+0x16c/0x198
> [    0.149419] [<00000000800827fc>] 0x800827fc
>
> The kernel then happily ran userspace for a while, but running hackbench
> was sufficient to lock it up:
>
> [  132.624028] BUG: spinlock lockup suspected on CPU#4, hackbench/5589
> [  132.624600] BUG: spinlock lockup suspected on CPU#5, hackbench/5270
> [  132.624619]  lock: vmap_area_lock+0x0/0x38, .magic: dead4ead, .owner: hackbench/7089, .owner_cpu: 1
> [  132.626651] BUG: spinlock lockup suspected on CPU#3, hackbench/5280
> [  132.626663]  lock: vmap_area_lock+0x0/0x38, .magic: dead4ead, .owner: hackbench/7089, .owner_cpu: 1
> [  132.628358] BUG: spinlock lockup suspected on CPU#0, init/1
> [  132.628370]  lock: vmap_area_lock+0x0/0x38, .magic: dead4ead, .owner: hackbench/7089, .owner_cpu: 1
> [  132.675602]  lock: vmap_area_lock+0x0/0x38, .magic: dead4ead, .owner: hackbench/7089, .owner_cpu: 1
> [  136.619403] BUG: spinlock lockup suspected on CPU#2, hackbench/6768
> [  136.625640]  lock: vmap_area_lock+0x0/0x38, .magic: dead4ead, .owner: hackbench/7089, .owner_cpu: 1
> [  136.675626] BUG: spinlock lockup suspected on CPU#1, hackbench/7089
> [  136.681860]  lock: vmap_area_lock+0x0/0x38, .magic: dead4ead, .owner: hackbench/7089, .owner_cpu: 1
> [  152.689601] NMI watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [hackbench:7089]
> [  155.149604] INFO: rcu_preempt self-detected stall on CPU
> [  155.149609] INFO: rcu_preempt self-detected stall on CPU
> [  155.149611] INFO: rcu_preempt self-detected stall on CPU
> [  155.149625]  1-...: (6496 ticks this GP) idle=fef/140000000000002/0 softirq=1935/1935 fqs=1
> [  155.149639]
> [  155.149640]  4-...: (6493 ticks this GP) idle=305/140000000000002/0 softirq=1961/1961 fqs=1
> [  155.149650]
> [  155.149651] rcu_preempt kthread starved for 6499 jiffies! g1204 c1203 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x0
> [  155.149665] rcu_preempt kthread starved for 6499 jiffies! g1204 c1203 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x0
> [  155.205127]  0-...: (6498 ticks this GP) idle=a2d/140000000000002/0 softirq=2595/2595 fqs=1
> [  155.213526]   (t=6516 jiffies g=1204 c=1203 q=422)
> [  155.218307] rcu_preempt kthread starved for 6516 jiffies! g1204 c1203 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x0
> [  156.677602] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [init:1]
> [  156.701602] NMI watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [hackbench:6768]
> [  156.713603] NMI watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [hackbench:5280]
> [  156.725602] NMI watchdog: BUG: soft lockup - CPU#4 stuck for 22s! [hackbench:5589]
> [  156.737603] NMI watchdog: BUG: soft lockup - CPU#5 stuck for 22s! [hackbench:5270]
>
> Thanks,
> Mark.
>

Yes, this is absolutely a deadlock with the vmap_lock. Your suggestion to pull it out so
we don't have the extra check should fix it I suspect.

Thanks,
Laura
