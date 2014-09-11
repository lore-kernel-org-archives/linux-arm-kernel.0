From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 11 Sep 2014 15:02:27 -0400 (EDT)
Subject: [PATCH v5 06/12] sched: add per rq cpu_capacity_orig
In-Reply-To: <1409051215-16788-7-git-send-email-vincent.guittot@linaro.org>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-7-git-send-email-vincent.guittot@linaro.org>
Message-ID: <alpine.LFD.2.11.1409111455320.16533@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Aug 2014, Vincent Guittot wrote:

> This new field cpu_capacity_orig reflects the available capacity of a CPUs

s/a CPUs/a CPU/

> unlike the cpu_capacity which reflects the current capacity that can be altered
> by frequency and rt tasks.

Shouldn't this be described as the "highest possible capacity" instead 
of only "available capacity" to make it clearer?  In which case, 
shouldn't it be called capacity_max instead of capacity_orig?  With 
"orig" we may think "origin" as the capacity that was available at boot 
time or the like.  If for example the CPU was booted with a low P-state 
then its max capacity is different from the original one.


> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/core.c  | 2 +-
>  kernel/sched/fair.c  | 1 +
>  kernel/sched/sched.h | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a394f99..7c3b237 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7003,7 +7003,7 @@ void __init sched_init(void)
>  #ifdef CONFIG_SMP
>  		rq->sd = NULL;
>  		rq->rd = NULL;
> -		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
> +		rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
>  		rq->post_schedule = 0;
>  		rq->active_balance = 0;
>  		rq->next_balance = jiffies;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8176bda..17c16cc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5756,6 +5756,7 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
>  
>  	capacity >>= SCHED_CAPACITY_SHIFT;
>  
> +	cpu_rq(cpu)->cpu_capacity_orig = capacity;
>  	sdg->sgc->capacity_orig = capacity;
>  
>  	if (sched_feat(ARCH_CAPACITY))
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index aa0f73b..7c0a74e 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -575,6 +575,7 @@ struct rq {
>  	struct sched_domain *sd;
>  
>  	unsigned long cpu_capacity;
> +	unsigned long cpu_capacity_orig;
>  
>  	unsigned char idle_balance;
>  	/* For active balancing */
> -- 
> 1.9.1
> 
> 
