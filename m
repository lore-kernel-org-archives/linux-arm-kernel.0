From: yuyang.du@intel.com (Yuyang Du)
Date: Wed, 4 Jun 2014 07:11:29 +0800
Subject: [PATCH v2 08/11] sched: get CPU's activity statistic
In-Reply-To: <20140603154058.GY30445@twins.programming.kicks-ass.net>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-9-git-send-email-vincent.guittot@linaro.org>
 <20140528121001.GI19967@e103034-lin>
 <20140603154058.GY30445@twins.programming.kicks-ass.net>
Message-ID: <20140603231129.GA662@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > The basic problem is that worst case: sum starting from 0 and period
> > already at LOAD_AVG_MAX = 47742, it takes LOAD_AVG_MAX_N = 345 periods
> > (ms) for sum to reach 47742. In other words, the cpu might have been
> > fully utilized for 345 ms before it is considered fully utilized.
> > Periodic load-balancing happens much more frequently than that.
> 
> Like said earlier the 94% mark is actually hit much sooner, but yes,
> likely still too slow.
> 
> 50% at 32 ms, 75% at 64 ms, 87.5% at 96 ms, etc..
> 
> > In the previous
> > discussion [1] it was suggested that a sum of unweighted task
> > runnable_avg_{sum,period} ratio instead. That is, an unweighted
> > equivalent to weighted_cpuload(). That isn't a perfect solution either.
> > It is fine as long as the cpus are not fully utilized, but when they are
> > we need to use weighted_cpuload() to preserve smp_nice. What to do
> > around the tipping point needs more thought, but I think that is
> > currently the best proposal for a solution for task and cpu utilization.
> 
> I'm not too worried about the tipping point, per task runnable figures
> of an overloaded cpu are higher, so migration between an overloaded cpu
> and an underloaded cpu are going to be tricky no matter what we do.
> 
Hi,

Can I join this dicussion late?

As I understand, you are talking about a metric for cpu activity. And the
issues about runnable_avg_sum is its sluggishness to latest change, and also
need unweighted load averages.

You might be aware of my recent proposal to CPU ConCurrency (CC). It is 1) an
average of nr_running, or 2) nr_running weighted CPU utilization. So it is a
combination of CPU utlization and run queue (both factored  natually). It
meets the needs you talked, I think. You can take it as a candidate, or at
least we can talk about it?

Thanks,
Yuyang
