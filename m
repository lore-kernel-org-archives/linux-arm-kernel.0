From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 9 Oct 2014 14:16:43 +0200
Subject: [PATCH v7 6/7] sched: replace capacity_factor by usage
In-Reply-To: <1412684017-16595-7-git-send-email-vincent.guittot@linaro.org>
References: <1412684017-16595-1-git-send-email-vincent.guittot@linaro.org>
 <1412684017-16595-7-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20141009121643.GQ4750@worktop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 02:13:36PM +0200, Vincent Guittot wrote:
> +static inline bool
> +group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
>  {
> +	if ((sgs->group_capacity * 100) >
> +			(sgs->group_usage * env->sd->imbalance_pct))
> +		return true;

Why the imb_pct there? We're looking for 100% utilization, not 130 or
whatnot, right?

> +	if (sgs->sum_nr_running < sgs->group_weight)
> +		return true;

With the code as it stands, this is the cheaper test (no mults) so why
is it second?

> +	return false;
> +}
>  
> +static inline bool
> +group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
> +{
> +	if (sgs->sum_nr_running <= sgs->group_weight)
> +		return false;
> +
> +	if ((sgs->group_capacity * 100) <
> +			(sgs->group_usage * env->sd->imbalance_pct))
> +		return true;
>  
> +	return false;
>  }

Same thing here wrt imb_pct
