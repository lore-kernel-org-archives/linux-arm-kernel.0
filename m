From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Fri, 30 May 2014 10:50:38 +0100
Subject: [PATCH v2 08/11] sched: get CPU's activity statistic
In-Reply-To: <1400860385-14555-9-git-send-email-vincent.guittot@linaro.org>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-9-git-send-email-vincent.guittot@linaro.org>
Message-ID: <5388546E.5070007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/14 16:53, Vincent Guittot wrote:
> Monitor the activity level of each group of each sched_domain level. The
> activity is the amount of cpu_power that is currently used on a CPU or group
> of CPUs. We use the runnable_avg_sum and _period to evaluate this activity
> level. In the special use case where the CPU is fully loaded by more than 1
> task, the activity level is set above the cpu_power in order to reflect the
> overload of the CPU
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

[...]

>  /*
>   * select_task_rq_fair: Select target runqueue for the waking task in domains
>   * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
> @@ -5518,6 +5535,7 @@ struct sg_lb_stats {
>  	unsigned long sum_weighted_load; /* Weighted load of group's tasks */
>  	unsigned long load_per_task;
>  	unsigned long group_power;
> +	unsigned long group_activity; /* Total activity of the group */
>  	unsigned int sum_nr_running; /* Nr tasks running in the group */
>  	unsigned int group_capacity;
>  	unsigned int idle_cpus;
> @@ -5538,6 +5556,7 @@ struct sd_lb_stats {
>  	struct sched_group *busiest;	/* Busiest group in this sd */
>  	struct sched_group *local;	/* Local group in this sd */
>  	unsigned long total_load;	/* Total load of all groups in sd */
> +	unsigned long total_activity;  /* Total activity of all groups in sd */
>  	unsigned long total_pwr;	/* Total power of all groups in sd */
>  	unsigned long avg_load;	/* Average load across all groups in sd */
>  
> @@ -5557,6 +5576,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
>  		.busiest = NULL,
>  		.local = NULL,
>  		.total_load = 0UL,
> +		.total_activity = 0UL,

AFAICS, total_activity is not used right now. Do you intend to use it to
calculate something like avg_activity later (like total_load/avg_load)?

>  		.total_pwr = 0UL,
>  		.busiest_stat = {
>  			.avg_load = 0UL,

[...]
