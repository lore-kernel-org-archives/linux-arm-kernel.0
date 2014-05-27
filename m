From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 27 May 2014 19:32:29 +0200
Subject: [PATCH v2 08/11] sched: get CPU's activity statistic
In-Reply-To: <1400860385-14555-9-git-send-email-vincent.guittot@linaro.org>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-9-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140527173229.GF19143@laptop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 05:53:02PM +0200, Vincent Guittot wrote:
> Monitor the activity level of each group of each sched_domain level. The
> activity is the amount of cpu_power that is currently used on a CPU or group
> of CPUs. We use the runnable_avg_sum and _period to evaluate this activity
> level. In the special use case where the CPU is fully loaded by more than 1
> task, the activity level is set above the cpu_power in order to reflect the
> overload of the CPU
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

While I appreciate the need to signify the overload situation, I don't
think adding nr_running makes sense. The amount of tasks has no bearing
on the amount of overload.

Also, and note I've not yet seen the use, it strikes me as odd to use
the orig power here. I would've thought the current capacity (not the
max capacity) is relevant to balancing.
