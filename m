From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 3 Nov 2014 16:29:00 +0100
Subject: [PATCH v8 07/10] sched: replace capacity_factor by usage
In-Reply-To: <1414745252-4895-8-git-send-email-vincent.guittot@linaro.org>
References: <1414745252-4895-1-git-send-email-vincent.guittot@linaro.org>
 <1414745252-4895-8-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20141103152900.GJ12706@worktop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 09:47:29AM +0100, Vincent Guittot wrote:
> @@ -6414,11 +6399,12 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  	 */
>  	if (busiest->group_type == group_overloaded &&
>  	    local->group_type   == group_overloaded) {
> -		load_above_capacity =
> -			(busiest->sum_nr_running - busiest->group_capacity_factor);
> -
> -		load_above_capacity *= (SCHED_LOAD_SCALE * SCHED_CAPACITY_SCALE);
> -		load_above_capacity /= busiest->group_capacity;
> +		load_above_capacity = busiest->sum_nr_running *
> +					SCHED_LOAD_SCALE;
> +		if (load_above_capacity > busiest->group_capacity)
> +			load_above_capacity -= busiest->group_capacity;
> +		else
> +			load_above_capacity = ~0UL;
>  	}
>  
>  	/*

It seems to me we no longer have need to assume each task contributes
SCHED_LOAD_SCALE, do we?

But as it stands I tihnk this patch already does too much -- it could do
with a splitting, but let me stare at is a wee bit more.
