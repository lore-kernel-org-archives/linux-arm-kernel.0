From: alex.shi@linaro.org (Alex Shi)
Date: Mon, 28 Apr 2014 13:01:56 +0800
Subject: do_undefinstr call sem down_read?
In-Reply-To: <20140425085731.GG26756@n2100.arm.linux.org.uk>
References: <5358D051.5050306@linaro.org>
 <20140425085731.GG26756@n2100.arm.linux.org.uk>
Message-ID: <535DE0C4.2020404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2014 04:57 PM, Russell King - ARM Linux wrote:
> On Thu, Apr 24, 2014 at 04:50:25PM +0800, Alex Shi wrote:
>> I caught the following issue few times on my panda board on lsk. but I
>> track the code path, looks like the upstream kernel has the same problem
>> too.
> ...
>> [   30.733612] [<c0008417>] (do_undefinstr+0x10b/0x13c) from [<c050cbe3>] (__und_svc_finish+0x1/0x3e)
>> [   30.743103] Exception stack(0xedd5fc50 to 0xedd5fc98)
>> [   30.748443] fc40:                                     c13c14e0 80000000 00000080 00000000
>> [   30.757141] fc60: c13c14e0 0000000c eac67284 c13c14e0 edc11518 c0df95c0 c0824410 eac67240
>> [   30.765808] fc80: 00000000 edd5fcd8 c00171f9 c00cf998 80000133 ffffffff
>> [   30.772827] [<c050cbe3>] (__und_svc_finish+0x1/0x3e) from [<c00cf998>] (page_mapping+0x20/0x38)
>> [   30.782073] [<c00cf998>] (page_mapping+0x20/0x38) from [<c00171f9>] (flush_dcache_page+0x1d/0x60)
> 
> The real question is why is page_mapping triggering an undefined
> instruction exception.  That I have no answer for.
> 
> This function is a hot path, so I doubt that it really is an undefined
> instruction.  I suspect either your CPU has an erratum, or you have
> hardware problems.
> 

Thanks for your response, Russell!

Maybe hardware is not stable.
but even so, do you think using down_read rwsem is appropriate in interrupt handler?

Another panic:
[   30.390350] ------------[ cut here ]------------
[   30.390350] WARNING: at kernel/exit.c:714 do_exit+0x43/0x870()
[   30.400390] Modules linked in:
[   30.405853] CPU: 0 PID: 809 Comm: jbd2/mmcblk0p2- Tainted: G      D      3.10.37+ #109
[   30.414276] [<c001292d>] (unwind_backtrace+0x1/0xcc) from [<c0010279>] (show_stack+0x11/0x14)
[   30.422729] [<c0010279>] (show_stack+0x11/0x14) from [<c0030819>] (warn_slowpath_common+0x45/0x5c)
[   30.432739] [<c0030819>] (warn_slowpath_common+0x45/0x5c) from [<c003089f>] (warn_slowpath_null+0x17/0x1c)
[   30.443084] [<c003089f>] (warn_slowpath_null+0x17/0x1c) from [<c003441b>] (do_exit+0x43/0x870)
[   30.443084] [<c003441b>] (do_exit+0x43/0x870) from [<c00105af>] (die+0x333/0x350)
[   30.458557] [<c00105af>] (die+0x333/0x350) from [<c0008417>] (do_undefinstr+0x10b/0x13c)
[   30.468749] [<c0008417>] (do_undefinstr+0x10b/0x13c) from [<c050cbe3>] (__und_svc_finish+0x1/0x3e)
[   30.476806] Exception stack(0xedd5fc50 to 0xedd5fc98)
[   30.483612] fc40:                                     c13c14e0 80000000 00000080 00000000
[   30.488555] fc60: c13c14e0 0000000c eac67284 c13c14e0 edc11518 c0df95c0 c0824410 eac67240
[   30.498504] fc80: 00000000 edd5fcd8 c00171f9 c00cf998 80000133 ffffffff
[   30.504699] [<c050cbe3>] (__und_svc_finish+0x1/0x3e) from [<c00cf998>] (page_mapping+0x20/0x38)
[   30.508514] [<c00cf998>] (page_mapping+0x20/0x38) from [<c00171f9>] (flush_dcache_page+0x1d/0x60)
[   30.518493] [<c00171f9>] (flush_dcache_page+0x1d/0x60) from [<c00e26c3>] (blk_queue_bounce+0x1a3/0x2a0)
[   30.528533] [<c00e26c3>] (blk_queue_bounce+0x1a3/0x2a0) from [<c02ca5bb>] (blk_queue_bio+0x1f/0x364)
[   30.538513] [<c02ca5bb>] (blk_queue_bio+0x1f/0x364) from [<c02c9661>] (generic_make_request+0x65/0x88)
[   30.548522] [<c02c9661>] (generic_make_request+0x65/0x88) from [<c02c96e5>] (submit_bio+0x61/0x104)
[   30.565826] [<c02c96e5>] (submit_bio+0x61/0x104) from [<c010f017>] (_submit_bh+0x127/0x19c)
[   30.572967] [<c010f017>] (_submit_bh+0x127/0x19c) from [<c0194def>] (jbd2_journal_commit_transaction+0x70b/0x161c)

-- 
Thanks
    Alex
