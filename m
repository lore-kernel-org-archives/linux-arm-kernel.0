From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 26 Apr 2013 15:15:32 +0200
Subject: [PATCH 08/14] sched: trig ILB on an idle buddy
In-Reply-To: <1366910611-20048-9-git-send-email-vincent.guittot@linaro.org>
References: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
 <1366910611-20048-9-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20130426131532.GB13964@dyad.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 07:23:24PM +0200, Vincent Guittot wrote:
> If the buddy CPU is not full and currently idle, we trigger an Idle Load
> Balance to give it the opportunity to pull more tasks.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 874f330..954adfd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5776,6 +5776,26 @@ end:
>  	clear_bit(NOHZ_BALANCE_KICK, nohz_flags(this_cpu));
>  }
>  
> +static int check_nohz_buddy(int cpu)
> +{
> +	int buddy = per_cpu(sd_pack_buddy, cpu);
> +
> +	if (sysctl_sched_packing_mode != SCHED_PACKING_FULL)
> +		return false;
> +
> +	/* No pack buddy for this CPU */
> +	if (buddy == -1)
> +		return false;
> +
> +	if (is_buddy_full(buddy))
> +		return false;
> +
> +	if (cpumask_test_cpu(buddy, nohz.idle_cpus_mask))
> +		return true;
> +
> +	return false;

return cpumask_test_cpu(..); ?

> +}
> +
>  /*
>   * Current heuristic for kicking the idle load balancer in the presence
>   * of an idle cpu is the system.
> @@ -5813,6 +5833,10 @@ static inline int nohz_kick_needed(struct rq *rq, int cpu)
>  	if (rq->nr_running >= 2)
>  		goto need_kick;
>  
> +	/* the buddy is idle and not busy so we can pack */
> +	if (check_nohz_buddy(cpu))
> +		goto need_kick;
> +
>  	rcu_read_lock();
>  	for_each_domain(cpu, sd) {
>  		struct sched_group *sg = sd->groups;

Bah.. this code is so confusing.. nohz_balance_kick(cpu) won't actually kick
@cpu.

Again.. suppose we're a big cpu (2) and our little buddy cpu (0) is busy, we
miss an opportunity to kick the other little cpu into gear (1) and maybe take
the big core out.
