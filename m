From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 10 Oct 2017 17:03:44 +0100
Subject: ARM64: Regression with commit e3067861ba66 ("arm64: add basic
 VMAP_STACK support")
In-Reply-To: <20171010154558.GJ27659@leverpostej>
References: <20171010142725.GA24797@leoy-linaro>
 <20171010154558.GJ27659@leverpostej>
Message-ID: <da09fd83-f3f0-f800-fea4-988cfa56bac7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/17 16:45, Mark Rutland wrote:
> On Tue, Oct 10, 2017 at 10:27:25PM +0800, Leo Yan wrote:
>> Hi Mark,
> 
> Hi Leo,
>  
>> I work mainline kernel on Hikey620 board, I find it's easily to
>> introduce the panic and report the log as below. So I bisect the kernel
>> and finally narrow down the commit e3067861ba66 ("arm64: add basic
>> VMAP_STACK support") which introduce this issue.
>>
>> I tried to remove 'select HAVE_ARCH_VMAP_STACK' from
>> arch/arm64/Kconfig, then I can see the panic issue will dismiss. So
>> could you check this and have insight for this issue?
> 
> Given the stuff in the backtrace, my suspicion is something is trying to
> perform DMA to/from the stack, getting junk addresses form the attempted
> virt<->phys conversions.
> 
> Could you try enabling both VMAP_STACK and CONFIG_DEBUG_VIRTUAL?

CONFIG_DMA_API_DEBUG should scream about drivers trying to use stack
addresses either way, too.

Robin.

> 
> Thanks,
> Mark.
> 
>> [   42.384103] INFO: rcu_preempt detected stalls on CPUs/tasks:
>> [   42.389799]  5-...: (1 GPs behind) idle=252/140000000000000/0 softirq=1208/1236 fqs=2615 
>> [   42.397982]  (detected by 0, t=5255 jiffies, g=238, c=237, q=10)
>> [   42.403999] Task dump for CPU 5:
>> [   42.407225] bash            R  running task        0  2202   2176 0x00000002
>> [   42.414281] Call trace:
>> [   42.416738] [<ffff0000080842a0>] ret_from_fork+0x0/0x18
>> [   43.308258] Unable to handle kernel paging request at virtual address 80083517baba
>> [   43.315864] user pgtable: 4k pages, 48-bit VAs, pgd = ffff80003a629000
>> [   43.322429] [000080083517baba] *pgd=0000000000000000
>> [   43.327419] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>> [   43.332994] Modules linked in:
>> [   43.336053] CPU: 1 PID: 54 Comm: kworker/u16:2 Not tainted 4.13.0-rc3-00019-ge306786 #199
>> [   43.344235] Hardware name: HiKey Development Board (DT)
>> [   43.349472] Workqueue: writeback wb_workfn (flush-179:0)
>> [   43.354789] task: ffff80003be71e80 task.stack: ffff0000093a0000
>> [   43.360723] PC is at __kmalloc+0x64/0x250
>> [   43.364739] LR is at __kmalloc+0x30/0x250
>> [   43.368754] pc : [<ffff0000081dccc4>] lr : [<ffff0000081dcc90>] pstate: 40000145
>> [   43.376165] sp : ffff0000093a34f0
>> [   43.379484] x29: ffff0000093a34f0 x28: ffff80003aaaa228 
>> [   43.384806] x27: 0000000000000000 x26: ffff80003be71e80 
>> [   43.390128] x25: ffff80003be71e80 x24: 0000000000400000 
>> [   43.395450] x23: ffff80003be71e80 x22: ffff0000087c6458 
>> [   43.400772] x21: 0000000001011200 x20: ffff80003aff0080 
>> [   43.406093] x19: ffff800005f04a80 x18: 000000000000000e 
>> [   43.411415] x17: 0000ffffa714438c x16: ffff000008244400 
>> [   43.416737] x15: 000011bb63554e12 x14: 0000000a155ddaef 
>> [   43.422059] x13: 00000000000fffff x12: 0000000000000040 
>> [   43.427381] x11: ffff7e0000f1bbc0 x10: 0000000000000001 
>> [   43.432707] x9 : 0000000000000000 x8 : 0000000000000019 
>> [   43.438035] x7 : ffff7e0000ec8020 x6 : 0000000000000040 
>> [   43.443363] x5 : 0000000000000000 x4 : 0000000000000001 
>> [   43.448691] x3 : 07ffffffffffffff x2 : ffff800005f04a80 
>> [   43.454020] x1 : 000080003504f000 x0 : 000000080012caba 
>> [   43.459350] Process kworker/u16:2 (pid: 54, stack limit = 0xffff0000093a0000)
>> [   43.466501] Call trace:
>> [   43.468958] Exception stack(0xffff0000093a33b0 to 0xffff0000093a34f0)
>> [   43.475415] 33a0:                                   000000080012caba 000080003504f000
>> [   43.483273] 33c0: ffff800005f04a80 07ffffffffffffff 0000000000000001 0000000000000000
>> [   43.491131] 33e0: 0000000000000040 ffff7e0000ec8020 0000000000000019 0000000000000000
>> [   43.498989] 3400: 0000000000000001 ffff7e0000f1bbc0 0000000000000040 00000000000fffff
>> [   43.506847] 3420: 0000000a155ddaef 000011bb63554e12 ffff000008244400 0000ffffa714438c
>> [   43.514705] 3440: 000000000000000e ffff800005f04a80 ffff80003aff0080 0000000001011200
>> [   43.522563] 3460: ffff0000087c6458 ffff80003be71e80 0000000000400000 ffff80003be71e80
>> [   43.530421] 3480: ffff80003be71e80 0000000000000000 ffff80003aaaa228 ffff0000093a34f0
>> [   43.538279] 34a0: ffff0000081dcc90 ffff0000093a34f0 ffff0000081dccc4 0000000040000145
>> [   43.546129] 34c0: 00000000ffffffff 0000000000000001 ffffffffffffffff 0000000000000000
>> [   43.553976] 34e0: ffff0000093a34f0 ffff0000081dccc4
>> [   43.558862] [<ffff0000081dccc4>] __kmalloc+0x64/0x250
>> [   43.563926] [<ffff0000087c6458>] mmc_alloc_sg+0x28/0x60
>> [   43.569162] [<ffff0000087c653c>] mmc_init_request+0xac/0xc0
>> [   43.574747] [<ffff000008378af4>] alloc_request_size+0x4c/0x90
>> [   43.580506] [<ffff00000817c734>] mempool_alloc+0x54/0x140
>> [   43.585915] [<ffff000008379d7c>] get_request+0x264/0x6d0
>> [   43.591238] [<ffff00000837ce50>] blk_queue_bio+0xe0/0x2e0
>> [   43.596647] [<ffff00000837acc8>] generic_make_request+0xe8/0x260
>> [   43.602663] [<ffff00000837aef0>] submit_bio+0xb0/0x188
>> [   43.607812] [<ffff0000082330f0>] submit_bh_wbc+0x130/0x188
>> [   43.613308] [<ffff0000082332e0>] __block_write_full_page+0x198/0x3a0
>> [   43.619673] [<ffff00000823374c>] block_write_full_page+0x134/0x148
>> [   43.625866] [<ffff000008236b20>] blkdev_writepage+0x18/0x20
>> [   43.631448] [<ffff00000818596c>] __writepage+0x1c/0x70
>> [   43.636595] [<ffff0000081861d8>] write_cache_pages+0x160/0x360
>> [   43.642438] [<ffff000008186418>] generic_writepages+0x40/0x78
>> [   43.648194] [<ffff000008236adc>] blkdev_writepages+0xc/0x18
>> [   43.653783] [<ffff00000818853c>] do_writepages+0x2c/0xa8
>> [   43.659113] [<ffff00000822986c>] __writeback_single_inode+0x34/0x1a8
>> [   43.665486] [<ffff000008229f34>] writeback_sb_inodes+0x1ec/0x398
>> [   43.671510] [<ffff00000822a17c>] __writeback_inodes_wb+0x9c/0xe0
>> [   43.677534] [<ffff00000822a418>] wb_writeback+0x1a8/0x1b0
>> [   43.682950] [<ffff00000822a9d8>] wb_workfn+0x148/0x240
>> [   43.688105] [<ffff0000080d93f4>] process_one_work+0x1ac/0x318
>> [   43.693867] [<ffff0000080d95a8>] worker_thread+0x48/0x420
>> [   43.699283] [<ffff0000080df664>] kthread+0xfc/0x128
>> [   43.704178] [<ffff0000080842b0>] ret_from_fork+0x10/0x18
>> [   43.709506] Code: b90012e0 f9400260 d538d081 91002000 (f8616818) 
>> [   43.715617] ---[ end trace 9381b75685031f84 ]---
>> [   43.720290] note: kworker/u16:2[54] exited with preempt_count 1
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
