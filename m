From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 10 Jul 2014 13:31:20 +0200
Subject: [PATCH v3 08/12] sched: move cfs task on a CPU with higher
 capacity
In-Reply-To: <1404144343-18720-9-git-send-email-vincent.guittot@linaro.org>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-9-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140710113120.GA3935@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 06:05:39PM +0200, Vincent Guittot wrote:

You 'forgot' to update the comment that goes with nohz_kick_needed().

> @@ -7233,9 +7253,10 @@ static inline int nohz_kick_needed(struct rq *rq)
>  	struct sched_domain *sd;
>  	struct sched_group_capacity *sgc;
>  	int nr_busy, cpu = rq->cpu;
> +	bool kick = false;
>  
>  	if (unlikely(rq->idle_balance))
> +		return false;
>  
>         /*
>  	* We may be recently in ticked or tickless idle mode. At the first
> @@ -7249,38 +7270,41 @@ static inline int nohz_kick_needed(struct rq *rq)
>  	 * balancing.
>  	 */
>  	if (likely(!atomic_read(&nohz.nr_cpus)))
> +		return false;
>  
>  	if (time_before(now, nohz.next_balance))
> +		return false;
>  
>  	if (rq->nr_running >= 2)
> +		return true;
>  
>  	rcu_read_lock();
>  	sd = rcu_dereference(per_cpu(sd_busy, cpu));
>  	if (sd) {
>  		sgc = sd->groups->sgc;
>  		nr_busy = atomic_read(&sgc->nr_busy_cpus);
>  
> +		if (nr_busy > 1) {
> +			kick = true;
> +			goto unlock;
> +		}
> +
> +		if ((rq->cfs.h_nr_running >= 1)
> +		 && ((rq->cpu_capacity * sd->imbalance_pct) <
> +					(rq->cpu_capacity_orig * 100))) {
> +			kick = true;
> +			goto unlock;
> +		}

Again, why only for shared caches?

>  	}
>  
>  	sd = rcu_dereference(per_cpu(sd_asym, cpu));
>  	if (sd && (cpumask_first_and(nohz.idle_cpus_mask,
>  				  sched_domain_span(sd)) < cpu))
> +		kick = true;
>  
> +unlock:
>  	rcu_read_unlock();
> +	return kick;
>  }
