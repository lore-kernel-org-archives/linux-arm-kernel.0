From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 3 Jun 2014 17:40:58 +0200
Subject: [PATCH v2 08/11] sched: get CPU's activity statistic
In-Reply-To: <20140528121001.GI19967@e103034-lin>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-9-git-send-email-vincent.guittot@linaro.org>
 <20140528121001.GI19967@e103034-lin>
Message-ID: <20140603154058.GY30445@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 01:10:01PM +0100, Morten Rasmussen wrote:
> The rq runnable_avg_{sum, period} give a very long term view of the cpu
> utilization (I will use the term utilization instead of activity as I
> think that is what we are talking about here). IMHO, it is too slow to
> be used as basis for load balancing decisions. I think that was also
> agreed upon in the last discussion related to this topic [1].
> 
> The basic problem is that worst case: sum starting from 0 and period
> already at LOAD_AVG_MAX = 47742, it takes LOAD_AVG_MAX_N = 345 periods
> (ms) for sum to reach 47742. In other words, the cpu might have been
> fully utilized for 345 ms before it is considered fully utilized.
> Periodic load-balancing happens much more frequently than that.

Like said earlier the 94% mark is actually hit much sooner, but yes,
likely still too slow.

50% at 32 ms, 75% at 64 ms, 87.5% at 96 ms, etc..

> Also, if load-balancing actually moves tasks around it may take quite a
> while before runnable_avg_sum actually reflects this change. The next
> periodic load-balance is likely to happen before runnable_avg_sum has
> reflected the result of the previous periodic load-balance.
> 
> To avoid these problems, we need to base utilization on a metric which
> is updated instantaneously when we add/remove tasks to a cpu (or a least
> fast enough that we don't see the above problems).

So the per-task-load-tracking stuff already does that. It updates the
per-cpu load metrics on migration. See {de,en}queue_entity_load_avg().

And keeping an unweighted per-cpu variant isn't that much more work.

> In the previous
> discussion [1] it was suggested that a sum of unweighted task
> runnable_avg_{sum,period} ratio instead. That is, an unweighted
> equivalent to weighted_cpuload(). That isn't a perfect solution either.
> It is fine as long as the cpus are not fully utilized, but when they are
> we need to use weighted_cpuload() to preserve smp_nice. What to do
> around the tipping point needs more thought, but I think that is
> currently the best proposal for a solution for task and cpu utilization.

I'm not too worried about the tipping point, per task runnable figures
of an overloaded cpu are higher, so migration between an overloaded cpu
and an underloaded cpu are going to be tricky no matter what we do.

> rq runnable_avg_sum is useful for decisions where we need a longer term
> view of the cpu utilization, but I don't see how we can use as cpu
> utilization metric for load-balancing decisions at wakeup or
> periodically.

So keeping one with a faster decay would add extra per-task storage. But
would be possible..

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140603/ed0ab26d/attachment.sig>
