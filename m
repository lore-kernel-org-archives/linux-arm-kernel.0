From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 3 Oct 2014 16:15:59 +0200
Subject: [PATCH v6 3/6] sched: add utilization_avg_contrib
In-Reply-To: <1411488485-10025-4-git-send-email-vincent.guittot@linaro.org>
References: <1411488485-10025-1-git-send-email-vincent.guittot@linaro.org>
 <1411488485-10025-4-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20141003141559.GK2849@worktop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 06:08:02PM +0200, Vincent Guittot wrote:
>  struct sched_avg {
> +	u64 last_runnable_update;
> +	s64 decay_count;
> +	/*
> +	 * utilization_avg_contrib describes the amount of time that a
> +	 * sched_entity is running on a CPU. It is based on running_avg_sum
> +	 * and is scaled in the range [0..SCHED_LOAD_SCALE].
> +	 * load_avg_contrib described the the amount of time that a
> +	 * sched_entity is runnable on a rq. It is based on both
> +	 * runnable_avg_sum and the weight of the task.
> +	 */
> +	unsigned long load_avg_contrib, utilization_avg_contrib;
>  	/*
>  	 * These sums represent an infinite geometric series and so are bound
>  	 * above by 1024/(1-y).  Thus we only need a u32 to store them for all
>  	 * choices of y < 1-2^(-32)*1024.
> +	 * runnable_avg_sum represents the amount of time a sched_entity is on
> +	 * the runqueue whereas running_avg_sum reflects the time the
> +	 * sched_entity is effectively running on the runqueue.

I would say: 'running on the cpu'. I would further clarify that runnable
also includes running, the above could be read such that runnable is
only the time spend waiting on the queue, excluding the time spend on
the cpu.

>  	 */
> +	u32 runnable_avg_sum, avg_period, running_avg_sum;
>  };
