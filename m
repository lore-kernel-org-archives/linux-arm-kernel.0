From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 26 Apr 2013 14:38:27 +0200
Subject: [PATCH 03/14] sched: pack small tasks
In-Reply-To: <1366910611-20048-4-git-send-email-vincent.guittot@linaro.org>
References: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
 <1366910611-20048-4-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20130426123827.GB13464@dyad.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 07:23:19PM +0200, Vincent Guittot wrote:

> +static bool is_buddy_busy(int cpu)
> +{
> +	struct rq *rq = cpu_rq(cpu);
> +	u32 sum = rq->avg.runnable_avg_sum;
> +	u32 period = rq->avg.runnable_avg_period;
> +
> +	/*
> +	 * If a CPU accesses the runnable_avg_sum and runnable_avg_period
> +	 * fields of its buddy CPU while the latter updates it, it can get the
> +	 * new version of a field and the old version of the other one. This
> +	 * can generate erroneous decisions. We don't want to use a lock
> +	 * mechanism for ensuring the coherency because of the overhead in
> +	 * this critical path.
> +	 * The runnable_avg_period of a runqueue tends to the max value in
> +	 * less than 345ms after plugging a CPU, which implies that we could
> +	 * use the max value instead of reading runnable_avg_period after
> +	 * 345ms. During the starting phase, we must ensure a minimum of
> +	 * coherency between the fields. A simple rule is runnable_avg_sum <=
> +	 * runnable_avg_period.
> +	 */
> +	sum = min(sum, period);
> +
> +	/*
> +	 * A busy buddy is a CPU with a high load or a small load with a lot of
> +	 * running tasks.
> +	 */
> +	return (sum > (period / (rq->nr_running + 2)));
> +}


I'm still not sold on the entire nr_running thing and the comment doesn't say
why you're doing it.

I'm fairly sure there's software out there that wakes a gazillion threads at a
time only for a gazillion-1 to go back to sleep immediately. Patterns like that
completely defeat your heuristic.

Does that matter... I don't know.

What happens if you keep this thing simple and only put a cap on utilization
(say 80%) and drop the entire nr_running magic? Have you seen it make an actual
difference or did it just seem like a good (TM) thing to do?

> +static bool is_light_task(struct task_struct *p)
> +{
> +	/* A light task runs less than 20% in average */
> +	return ((p->se.avg.runnable_avg_sum  * 5) <
> +			(p->se.avg.runnable_avg_period));
> +}

There superfluous () and ' ' in there. Also why 20%.. seemed like a good
number? Do we want a SCHED_DEBUG sysctl for that?
