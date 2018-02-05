From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 5 Feb 2018 17:07:23 +0000
Subject: [PATCHv2 7/8] arm_pmu: note IRQs and PMUs per-cpu
In-Reply-To: <20180205164202.26502-8-mark.rutland@arm.com>
References: <20180205164202.26502-1-mark.rutland@arm.com>
 <20180205164202.26502-8-mark.rutland@arm.com>
Message-ID: <768a893a-121e-3768-ce71-36ace311c498@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Just a couple of nits spotted in passing...

On 05/02/18 16:42, Mark Rutland wrote:
> To support ACPI systems, we need to request IRQs before we know the
> associated PMU, and thus we need some percpu variable that the IRQ
> handler can find the PMU from.
> 
> As we're going to request IRQs without the PMU, we can't rely on the
> arm_pmu::active_irqs mask, and similarly need to track requested IRQs
> with a percpu variable.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>   drivers/perf/arm_pmu.c       | 76 +++++++++++++++++++++++++++++++-------------
>   include/linux/perf/arm_pmu.h |  1 -
>   2 files changed, 54 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 72118e6f9122..023a8ebdace6 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -25,6 +25,9 @@
>   
>   #include <asm/irq_regs.h>
>   
> +static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
> +static DEFINE_PER_CPU(int, cpu_irq);
> +
>   static int
>   armpmu_map_cache_event(const unsigned (*cache_map)
>   				      [PERF_COUNT_HW_CACHE_MAX]
> @@ -325,13 +328,9 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
>   	int ret;
>   	u64 start_clock, finish_clock;
>   
> -	/*
> -	 * we request the IRQ with a (possibly percpu) struct arm_pmu**, but
> -	 * the handlers expect a struct arm_pmu*. The percpu_irq framework will
> -	 * do any necessary shifting, we just need to perform the first
> -	 * dereference.
> -	 */
> -	armpmu = *(void **)dev;
> +	armpmu = this_cpu_read(cpu_armpmu);
> +	if (WARN_ON_ONCE(!armpmu))
> +		return IRQ_NONE;
>   
>   	start_clock = sched_clock();
>   	ret = armpmu->handle_irq(irq, armpmu);
> @@ -517,29 +516,47 @@ int perf_num_counters(void)
>   }
>   EXPORT_SYMBOL_GPL(perf_num_counters);
>   
> -void armpmu_free_irq(struct arm_pmu *armpmu, int cpu)
> +int armpmu_count_irq_users(const int irq)
>   {
> -	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
> -	int irq = per_cpu(hw_events->irq, cpu);
> +	int cpu, count = 0;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (per_cpu(cpu_irq, cpu) == irq)
> +			count++;
> +	}
>   
> -	if (!cpumask_test_and_clear_cpu(cpu, &armpmu->active_irqs))
> +	return count;
> +}
> +
> +void armpmu_free_cpu_irq(int irq, int cpu)
> +{
> +	if (per_cpu(cpu_irq, cpu) == 0)
> +		return;
> +	if (WARN_ON(irq != per_cpu(cpu_irq, cpu)))
>   		return;
>   
>   	if (irq_is_percpu_devid(irq)) {
> -		free_percpu_irq(irq, &hw_events->percpu_pmu);
> -		cpumask_clear(&armpmu->active_irqs);
> -		return;
> +		if (armpmu_count_irq_users(irq) == 1)
> +			free_percpu_irq(irq, &cpu_armpmu);
> +	} else {
> +		free_irq(irq, NULL);
>   	}

Following the same pattern as the request would make this marginally 
simpler (and nicely symmetric), i.e.

	if (!irq_is_percpu_devid(irq))
		free_irq(irq, NULL);
	else if (armpmu_count_irq_users(irq) == 1)
		free_percpu_irq(irq, &cpu_armpmu);

> -	free_irq(irq, per_cpu_ptr(&hw_events->percpu_pmu, cpu));
> +	per_cpu(cpu_irq, cpu) = 0;
>   }
>   
> -int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
> +void armpmu_free_irq(struct arm_pmu *armpmu, int cpu)
>   {
> -	int err = 0;
>   	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
> -	const irq_handler_t handler = armpmu_dispatch_irq;
>   	int irq = per_cpu(hw_events->irq, cpu);
> +
> +	armpmu_free_cpu_irq(irq, cpu);
> +}
> +
> +int armpmu_request_cpu_irq(int irq, int cpu)
> +{
> +	int err = 0;
> +	const irq_handler_t handler = armpmu_dispatch_irq;
>   	if (!irq)
>   		return 0;
>   
> @@ -560,16 +577,16 @@ int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
>   
>   		irq_set_status_flags(irq, IRQ_NOAUTOEN);
>   		err = request_irq(irq, handler, irq_flags, "arm-pmu",
> -				  per_cpu_ptr(&hw_events->percpu_pmu, cpu));
> -	} else if (cpumask_empty(&armpmu->active_irqs)) {
> +				  NULL);
> +	} else if (armpmu_count_irq_users(irq) == 0) {
>   		err = request_percpu_irq(irq, handler, "arm-pmu",
> -					 &hw_events->percpu_pmu);
> +					 cpu_armpmu);
>   	}
>   
>   	if (err)
>   		goto err_out;
>   
> -	cpumask_set_cpu(cpu, &armpmu->active_irqs);
> +	per_cpu(cpu_irq, cpu) = irq;
>   	return 0;
>   
>   err_out:
> @@ -577,6 +594,17 @@ int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
>   	return err;
>   }
>   
> +int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
> +{
> +	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
> +	int irq = per_cpu(hw_events->irq, cpu);
> +	if (!irq)
> +		return 0;
> +
> +

Double blank line here.

Robin.

> +	return armpmu_request_cpu_irq(irq, cpu);
> +}
> +
>   static int armpmu_get_cpu_irq(struct arm_pmu *pmu, int cpu)
>   {
>   	struct pmu_hw_events __percpu *hw_events = pmu->hw_events;
> @@ -599,6 +627,8 @@ static int arm_perf_starting_cpu(unsigned int cpu, struct hlist_node *node)
>   	if (pmu->reset)
>   		pmu->reset(pmu);
>   
> +	per_cpu(cpu_armpmu, cpu) = pmu;
> +
>   	irq = armpmu_get_cpu_irq(pmu, cpu);
>   	if (irq) {
>   		if (irq_is_percpu_devid(irq))
> @@ -626,6 +656,8 @@ static int arm_perf_teardown_cpu(unsigned int cpu, struct hlist_node *node)
>   			disable_irq(irq);
>   	}
>   
> +	per_cpu(cpu_armpmu, cpu) = NULL;
> +
>   	return 0;
>   }
>   
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 1f8bb83ef42f..feec9e7e85db 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -75,7 +75,6 @@ enum armpmu_attr_groups {
>   
>   struct arm_pmu {
>   	struct pmu	pmu;
> -	cpumask_t	active_irqs;
>   	cpumask_t	supported_cpus;
>   	char		*name;
>   	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
> 
