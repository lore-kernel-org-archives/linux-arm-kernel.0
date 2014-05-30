From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Fri, 30 May 2014 14:26:49 +0100
Subject: [PATCH v2 10/11] sched: move cfs task on a CPU with higher
 capacity
In-Reply-To: <1400860385-14555-11-git-send-email-vincent.guittot@linaro.org>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-11-git-send-email-vincent.guittot@linaro.org>
Message-ID: <53888719.70604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/14 16:53, Vincent Guittot wrote:
> If the CPU is used for handling lot of IRQs, trig a load balance to check if
> it's worth moving its tasks on another CPU that has more capacity
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e8a30f9..2501e49 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5948,6 +5948,13 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  	if (sgs->sum_nr_running > sgs->group_capacity)
>  		return true;
>  
> +	/*
> +	 * The group capacity is reduced probably because of activity from other

Here 'group capacity' refers to sgs->group_power and not to
sgs->group_capacity, right?

> +	 * sched class or interrupts which use part of the available capacity
> +	 */

... 'interrupts' only w/ CONFIG_IRQ_TIME_ACCOUNTING=y, right ?

> +	if ((sg->sgp->power_orig * 100) > (sgs->group_power * env->sd->imbalance_pct))
> +		return true;
> +
[...]
