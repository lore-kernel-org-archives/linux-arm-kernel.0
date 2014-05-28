From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Wed, 28 May 2014 13:10:01 +0100
Subject: [PATCH v2 08/11] sched: get CPU's activity statistic
In-Reply-To: <1400860385-14555-9-git-send-email-vincent.guittot@linaro.org>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-9-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140528121001.GI19967@e103034-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 04:53:02PM +0100, Vincent Guittot wrote:
> Monitor the activity level of each group of each sched_domain level. The
> activity is the amount of cpu_power that is currently used on a CPU or group
> of CPUs. We use the runnable_avg_sum and _period to evaluate this activity
> level. In the special use case where the CPU is fully loaded by more than 1
> task, the activity level is set above the cpu_power in order to reflect the
> overload of the CPU
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b7c51be..c01d8b6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4044,6 +4044,11 @@ static unsigned long power_of(int cpu)
>  	return cpu_rq(cpu)->cpu_power;
>  }
>  
> +static unsigned long power_orig_of(int cpu)
> +{
> +	return cpu_rq(cpu)->cpu_power_orig;
> +}
> +
>  static unsigned long cpu_avg_load_per_task(int cpu)
>  {
>  	struct rq *rq = cpu_rq(cpu);
> @@ -4438,6 +4443,18 @@ done:
>  	return target;
>  }
>  
> +static int get_cpu_activity(int cpu)
> +{
> +	struct rq *rq = cpu_rq(cpu);
> +	u32 sum = rq->avg.runnable_avg_sum;
> +	u32 period = rq->avg.runnable_avg_period;
> +
> +	if (sum >= period)
> +		return power_orig_of(cpu) + rq->nr_running - 1;
> +
> +	return (sum * power_orig_of(cpu)) / period;
> +}

The rq runnable_avg_{sum, period} give a very long term view of the cpu
utilization (I will use the term utilization instead of activity as I
think that is what we are talking about here). IMHO, it is too slow to
be used as basis for load balancing decisions. I think that was also
agreed upon in the last discussion related to this topic [1].

The basic problem is that worst case: sum starting from 0 and period
already at LOAD_AVG_MAX = 47742, it takes LOAD_AVG_MAX_N = 345 periods
(ms) for sum to reach 47742. In other words, the cpu might have been
fully utilized for 345 ms before it is considered fully utilized.
Periodic load-balancing happens much more frequently than that.

Also, if load-balancing actually moves tasks around it may take quite a
while before runnable_avg_sum actually reflects this change. The next
periodic load-balance is likely to happen before runnable_avg_sum has
reflected the result of the previous periodic load-balance.

To avoid these problems, we need to base utilization on a metric which
is updated instantaneously when we add/remove tasks to a cpu (or a least
fast enough that we don't see the above problems). In the previous
discussion [1] it was suggested that a sum of unweighted task
runnable_avg_{sum,period} ratio instead. That is, an unweighted
equivalent to weighted_cpuload(). That isn't a perfect solution either.
It is fine as long as the cpus are not fully utilized, but when they are
we need to use weighted_cpuload() to preserve smp_nice. What to do
around the tipping point needs more thought, but I think that is
currently the best proposal for a solution for task and cpu utilization.

rq runnable_avg_sum is useful for decisions where we need a longer term
view of the cpu utilization, but I don't see how we can use as cpu
utilization metric for load-balancing decisions at wakeup or
periodically.

Morten

[1] https://lkml.org/lkml/2014/1/8/251
