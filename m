From: alex.shi@linaro.org (Alex Shi)
Date: Fri, 25 Apr 2014 15:07:09 +0800
Subject: do_undefinstr call sem down_read?
In-Reply-To: <5358D051.5050306@linaro.org>
References: <5358D051.5050306@linaro.org>
Message-ID: <535A099D.50001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2014 04:50 PM, Alex Shi wrote:
> Hi, Russell,
> 
> I caught the following issue few times on my panda board on lsk. but I track the code
> path, looks like the upstream kernel has the same problem too.
> 
> the interrupt handler do_undefinstr --> arm_notify_die --> die --> ...
> 			exit_signals --> threadgroup_change_begin --> down_read
> and then down_read maybe get into sleep.
> Is it a issue which needs to be fixed? or I over concern on this?


Any comments for this Oops?

> 
> [   30.618469] BUG: sleeping function called from invalid context at kernel/rwsem.c:20
> [   30.618469] in_atomic(): 0, irqs_disabled(): 128, pid: 809, name: jbd2/mmcblk0p2-
> [   30.628540] INFO: lockdep is turned off.
> [   30.638671] irq event stamp: 1372
> [   30.638671] hardirqs last  enabled at (1371): [<c00c1fa1>] get_page_from_freelist+0x279/0x434
> [   30.648529] hardirqs last disabled at (1372): [<c050cbb3>] __und_svc+0x33/0x5c
> [   30.658905] softirqs last  enabled at (0): [<c002f22a>] copy_process.part.52+0x31a/0xdf4
> [   30.658905] softirqs last disabled at (0): [<  (null)>]   (null)
> [   30.669433] CPU: 0 PID: 809 Comm: jbd2/mmcblk0p2- Tainted: G      D W    3.10.37+ #109
> [   30.682281] [<c001292d>] (unwind_backtrace+0x1/0xcc) from [<c0010279>] (show_stack+0x11/0x14)
> [   30.691314] [<c0010279>] (show_stack+0x11/0x14) from [<c050aae7>] (down_read+0x1f/0x44)
> [   30.699829] [<c050aae7>] (down_read+0x1f/0x44) from [<c00415c5>] (exit_signals+0x19/0xe4)
> [   30.708496] [<c00415c5>] (exit_signals+0x19/0xe4) from [<c0034459>] (do_exit+0x81/0x870)
> [   30.717071] [<c0034459>] (do_exit+0x81/0x870) from [<c00105af>] (die+0x333/0x350)
> [   30.725036] [<c00105af>] (die+0x333/0x350) from [<c0008417>] (do_undefinstr+0x10b/0x13c)
> [   30.733612] [<c0008417>] (do_undefinstr+0x10b/0x13c) from [<c050cbe3>] (__und_svc_finish+0x1/0x3e)
> [   30.743103] Exception stack(0xedd5fc50 to 0xedd5fc98)
> [   30.748443] fc40:                                     c13c14e0 80000000 00000080 00000000
> [   30.757141] fc60: c13c14e0 0000000c eac67284 c13c14e0 edc11518 c0df95c0 c0824410 eac67240
> [   30.765808] fc80: 00000000 edd5fcd8 c00171f9 c00cf998 80000133 ffffffff
> [   30.772827] [<c050cbe3>] (__und_svc_finish+0x1/0x3e) from [<c00cf998>] (page_mapping+0x20/0x38)
> [   30.782073] [<c00cf998>] (page_mapping+0x20/0x38) from [<c00171f9>] (flush_dcache_page+0x1d/0x60)
> [   30.791473] [<c00171f9>] (flush_dcache_page+0x1d/0x60) from [<c00e26c3>] (blk_queue_bounce+0x1a3/0x2a0)
> [   30.801452] [<c00e26c3>] (blk_queue_bounce+0x1a3/0x2a0) from [<c02ca5bb>] (blk_queue_bio+0x1f/0x364)
> [   30.811157] [<c02ca5bb>] (blk_queue_bio+0x1f/0x364) from [<c02c9661>] (generic_make_request+0x65/0x88)
> [   30.821014] [<c02c9661>] (generic_make_request+0x65/0x88) from [<c02c96e5>] (submit_bio+0x61/0x104)
> [   30.830627] [<c02c96e5>] (submit_bio+0x61/0x104) from [<c010f017>] (_submit_bh+0x127/0x19c)
> [   30.839477] [<c010f017>] (_submit_bh+0x127/0x19c) from [<c0194def>] (jbd2_journal_commit_transaction+0x70b/0x161c)
> [   30.850463] [<c0194def>] (jbd2_journal_commit_transaction+0-- 
> 
> 
> Thanks
>     Alex
> 


-- 
Thanks
    Alex
