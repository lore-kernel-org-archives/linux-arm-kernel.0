From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Wed, 22 May 2013 17:50:35 +0100
Subject: [PATCH 09/14] sched: evaluate the activity level of the system
In-Reply-To: <1366910611-20048-10-git-send-email-vincent.guittot@linaro.org>
References: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
 <1366910611-20048-10-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20130522165035.GC4935@e103034-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 06:23:25PM +0100, Vincent Guittot wrote:
> We evaluate the activity level of CPUs, groups and domains in order to define
> how many CPUs are required to handle the current activity.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 954adfd..234ecdd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3465,7 +3465,22 @@ static int check_pack_buddy(int cpu, struct task_struct *p)
>  		return true;
>  
>  	return false;
> +}
> +
> +static int get_cpu_activity(int cpu)
> +{
> +	struct rq *rq = cpu_rq(cpu);
> +	u32 sum = rq->avg.runnable_avg_sum;
> +	u32 period = rq->avg.runnable_avg_period;
> +
> +	sum = min(sum, period);
> +
> +	if (sum == period) {
> +		u32 overload = rq->nr_running > 1 ? 1 : 0;
> +		return power_of(cpu) + overload;
> +	}

Adding one to indicate cpu overload seems to work well in the cases that
I can think of. It may take some time to have effect if the overloaded
cpu is in a group with nearly overloaded cpus. Adding one won't enable
more cpus in another group until they have all reached overload.

Reaching sum == period takes quite a long time. Would it be an idea to
use sum*1024 >= period*1000 like you do in is_buddy_full()?

I think that would be more consistent since overloaded is essential the
same as full.

Cheers,
Morten

>  
> +	return (sum * power_of(cpu)) / period;
>  }
>  
>  /*
> @@ -4355,6 +4370,7 @@ struct sd_lb_stats {
>  	struct sched_group *busiest; /* Busiest group in this sd */
>  	struct sched_group *this;  /* Local group in this sd */
>  	unsigned long total_load;  /* Total load of all groups in sd */
> +	unsigned long total_activity;  /* Total activity of all groups in sd */
>  	unsigned long total_pwr;   /*	Total power of all groups in sd */
>  	unsigned long avg_load;	   /* Average load across all groups in sd */
>  
> @@ -4383,6 +4399,7 @@ struct sd_lb_stats {
>  struct sg_lb_stats {
>  	unsigned long avg_load; /*Avg load across the CPUs of the group */
>  	unsigned long group_load; /* Total load over the CPUs of the group */
> +	unsigned long group_activity; /* Total activity of the group */
>  	unsigned long sum_nr_running; /* Nr tasks running in the group */
>  	unsigned long sum_weighted_load; /* Weighted load of group's tasks */
>  	unsigned long group_capacity;
> @@ -4629,6 +4646,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		}
>  
>  		sgs->group_load += load;
> +		sgs->group_activity += get_cpu_activity(i);
>  		sgs->sum_nr_running += nr_running;
>  		sgs->sum_weighted_load += weighted_cpuload(i);
>  		if (idle_cpu(i))
> @@ -4752,6 +4770,7 @@ static inline void update_sd_lb_stats(struct lb_env *env,
>  			return;
>  
>  		sds->total_load += sgs.group_load;
> +		sds->total_activity += sgs.group_activity;
>  		sds->total_pwr += sg->sgp->power;
>  
>  		/*
> -- 
> 1.7.9.5
> 
> 
