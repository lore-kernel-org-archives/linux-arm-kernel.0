From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 3 Oct 2014 16:36:34 +0200
Subject: [PATCH v6 3/6] sched: add utilization_avg_contrib
In-Reply-To: <1411488485-10025-4-git-send-email-vincent.guittot@linaro.org>
References: <1411488485-10025-1-git-send-email-vincent.guittot@linaro.org>
 <1411488485-10025-4-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20141003143634.GL2849@worktop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 06:08:02PM +0200, Vincent Guittot wrote:
> +++ b/kernel/sched/sched.h
> @@ -339,8 +339,14 @@ struct cfs_rq {
>  	 * Under CFS, load is tracked on a per-entity basis and aggregated up.
>  	 * This allows for the description of both thread and group usage (in
>  	 * the FAIR_GROUP_SCHED case).
> +	 * runnable_load_avg is the sum of the load_avg_contrib of the
> +	 * sched_entities on the rq.

> +	 * blocked_load_avg is similar to runnable_load_avg except that its
> +	 * the blocked sched_entities on the rq.

Strictly speaking blocked entities aren't on a rq as such, but yeah, no
idea how to better put it. Just being a pedantic, which isn't helpful I
guess :-)

> +	 * utilization_load_avg is the sum of the average running time of the
> +	 * sched_entities on the rq.
>  	 */

So I think there was some talk about a blocked_utilization thingy, which
would track the avg running time of the tasks currently asleep, right?

> +	unsigned long runnable_load_avg, blocked_load_avg, utilization_load_avg;
>  	atomic64_t decay_counter;
>  	u64 last_decay;
>  	atomic_long_t removed_load;
