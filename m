From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 9 Oct 2014 13:36:14 +0200
Subject: [PATCH v7 5/7] sched: get CPU's usage statistic
In-Reply-To: <1412684017-16595-6-git-send-email-vincent.guittot@linaro.org>
References: <1412684017-16595-1-git-send-email-vincent.guittot@linaro.org>
 <1412684017-16595-6-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20141009113614.GP4750@worktop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 02:13:35PM +0200, Vincent Guittot wrote:
> Monitor the usage level of each group of each sched_domain level. The usage is
> the amount of cpu_capacity that is currently used on a CPU or group of CPUs.
> We use the utilization_load_avg to evaluate the usage level of each group.
> 
> The utilization_avg_contrib only takes into account the running time but not
> the uArch so the utilization_load_avg is in the range [0..SCHED_LOAD_SCALE]
> to reflect the running load on the CPU. We have to scale the utilization with
> the capacity of the CPU to get the usage of the latter. The usage can then be
> compared with the available capacity.

You say cpu_capacity, but in actual fact you use capacity_orig and fail
to justify/clarify this.

> The frequency scaling invariance is not taken into account in this patchset,
> it will be solved in another patchset

Maybe explain what the specific invariance issue is that is skipped over
for now.

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d3e9067..7364ed4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4551,6 +4551,17 @@ static int select_idle_sibling(struct task_struct *p, int target)
>  	return target;
>  }
>  
> +static int get_cpu_usage(int cpu)
> +{
> +	unsigned long usage = cpu_rq(cpu)->cfs.utilization_load_avg;
> +	unsigned long capacity = capacity_orig_of(cpu);
> +
> +	if (usage >= SCHED_LOAD_SCALE)
> +		return capacity + 1;

Like Morten I'm confused by that +1 thing.

> +
> +	return (usage * capacity) >> SCHED_LOAD_SHIFT;
> +}

A comment with that function that it returns capacity units might
clarify shift confusion Morten raised the other day.
