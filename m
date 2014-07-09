From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 9 Jul 2014 12:43:32 +0200
Subject: [PATCH v3 01/12] sched: fix imbalance flag reset
In-Reply-To: <53BCBD0E.2070609@linux.vnet.ibm.com>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-2-git-send-email-vincent.guittot@linaro.org>
 <53BB61E9.80200@linux.vnet.ibm.com>
 <CAKfTPtA8BVPtRRLzomqnGp7_uaSbFYmFTrrt4fpQTOb7qyjddg@mail.gmail.com>
 <53BCBD0E.2070609@linux.vnet.ibm.com>
Message-ID: <20140709104332.GS19379@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 09:24:54AM +0530, Preeti U Murthy wrote:
> In the example that I mention above, t1 and t2 are on the rq of cpu0;
> while t1 is running on cpu0, t2 is on the rq but does not have cpu1 in
> its cpus allowed mask. So during load balance, cpu1 tries to pull t2,
> cannot do so, and hence LBF_ALL_PINNED flag is set and it jumps to
> out_balanced. Note that there are only two sched groups at this level of
> sched domain.one with cpu0 and the other with cpu1. In this scenario we
> do not try to do active load balancing, atleast thats what the code does
> now if LBF_ALL_PINNED flag is set.

I think Vince is right in saying that in this scenario ALL_PINNED won't
be set. move_tasks() will iterate cfs_rq::cfs_tasks, that list will also
include the current running task.

And can_migrate_task() only checks for current after the pinning bits.

> Continuing with the above explanation; when LBF_ALL_PINNED flag is
> set,and we jump to out_balanced, we clear the imbalance flag for the
> sched_group comprising of cpu0 and cpu1,although there is actually an
> imbalance. t2 could still be migrated to say cpu2/cpu3 (t2 has them in
> its cpus allowed mask) in another sched group when load balancing is
> done at the next sched domain level.

And this is where Vince is wrong; note how
update_sg_lb_stats()/sg_imbalance() uses group->sgc->imbalance, but
load_balance() sets: sd_parent->groups->sgc->imbalance, so explicitly
one level up.

So what we can do I suppose is clear 'group->sgc->imbalance' at
out_balanced.

In any case, the entirely of this group imbalance crap is just that,
crap. Its a terribly difficult situation and the current bits more or
less fudge around some of the common cases. Also see the comment near
sg_imbalanced(). Its not a solid and 'correct' anything. Its a bunch of
hacks trying to deal with hard cases.

A 'good' solution would be prohibitively expensive I fear.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140709/28a56c08/attachment.sig>
