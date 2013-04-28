From: francescolavra.fl@gmail.com (Francesco Lavra)
Date: Sun, 28 Apr 2013 10:20:43 +0200
Subject: [PATCH 10/14] sched: update the buddy CPU
In-Reply-To: <1366910611-20048-11-git-send-email-vincent.guittot@linaro.org>
References: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
 <1366910611-20048-11-git-send-email-vincent.guittot@linaro.org>
Message-ID: <517CDBDB.1020608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/25/2013 07:23 PM, Vincent Guittot wrote:
> Periodically updates the buddy of a CPU according to the current activity of
> the system. A CPU is its own buddy if it participates to the packing effort.
> Otherwise, it points to a CPU that participates to the packing effort.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c |   91 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 86 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 234ecdd..28f8ea7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -174,11 +174,17 @@ void sched_init_granularity(void)
>  
>  
>  #ifdef CONFIG_SMP
> +static unsigned long power_of(int cpu)
> +{
> +	return cpu_rq(cpu)->cpu_power;
> +}
> +
>  /*
>   * Save the id of the optimal CPU that should be used to pack small tasks
>   * The value -1 is used when no buddy has been found
>   */
>  DEFINE_PER_CPU(int, sd_pack_buddy);
> +DEFINE_PER_CPU(struct sched_domain *, sd_pack_domain);
>  
>  /*
>   * Look for the best buddy CPU that can be used to pack small tasks
> @@ -237,6 +243,68 @@ void update_packing_domain(int cpu)
>  	}
>  
>  	pr_debug("CPU%d packing on CPU%d\n", cpu, id);
> +	per_cpu(sd_pack_domain, cpu) = sd;
> +	per_cpu(sd_pack_buddy, cpu) = id;
> +}
> +
> +void update_packing_buddy(int cpu, int activity)
> +{
> +	struct sched_domain *sd = per_cpu(sd_pack_domain, cpu);
> +	struct sched_group *sg, *pack, *tmp;
> +	int id = cpu;
> +
> +	if (!sd)
> +		return;
> +
> +	/*
> +	 * The sched_domain of a CPU points on the local sched_group
> +	 * and this CPU of this local group is a good candidate
> +	 */
> +	pack = sg = sd->groups;
> +
> +	/* loop the sched groups to find the best one */
> +	for (tmp = sg->next; tmp != sg; tmp = tmp->next) {
> +		if ((tmp->sgp->power * pack->group_weight) >
> +			(pack->sgp->power_available * tmp->group_weight))

The power_available struct member is defined in a subsequent patch
(12/14), so this patch series would break git bisect.

--
Francesco
