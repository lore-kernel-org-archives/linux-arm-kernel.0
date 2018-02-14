From: will.deacon@arm.com (Will Deacon)
Date: Wed, 14 Feb 2018 13:11:41 +0000
Subject: [PATCHv2 7/8] arm_pmu: note IRQs and PMUs per-cpu
In-Reply-To: <20180205164202.26502-8-mark.rutland@arm.com>
References: <20180205164202.26502-1-mark.rutland@arm.com>
 <20180205164202.26502-8-mark.rutland@arm.com>
Message-ID: <20180214131141.GF2992@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 05, 2018 at 04:42:01PM +0000, Mark Rutland wrote:
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 72118e6f9122..023a8ebdace6 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -25,6 +25,9 @@
>  
>  #include <asm/irq_regs.h>
>  
> +static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
> +static DEFINE_PER_CPU(int, cpu_irq);
> +
>  static int
>  armpmu_map_cache_event(const unsigned (*cache_map)
>  				      [PERF_COUNT_HW_CACHE_MAX]
> @@ -325,13 +328,9 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
>  	int ret;
>  	u64 start_clock, finish_clock;
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
>  	start_clock = sched_clock();
>  	ret = armpmu->handle_irq(irq, armpmu);
> @@ -517,29 +516,47 @@ int perf_num_counters(void)
>  }
>  EXPORT_SYMBOL_GPL(perf_num_counters);
>  
> -void armpmu_free_irq(struct arm_pmu *armpmu, int cpu)
> +int armpmu_count_irq_users(const int irq)

This can be static.

>  {
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
>  		return;
>  
>  	if (irq_is_percpu_devid(irq)) {
> -		free_percpu_irq(irq, &hw_events->percpu_pmu);
> -		cpumask_clear(&armpmu->active_irqs);
> -		return;
> +		if (armpmu_count_irq_users(irq) == 1)
> +			free_percpu_irq(irq, &cpu_armpmu);
> +	} else {
> +		free_irq(irq, NULL);
>  	}
>  
> -	free_irq(irq, per_cpu_ptr(&hw_events->percpu_pmu, cpu));
> +	per_cpu(cpu_irq, cpu) = 0;
>  }
>  
> -int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
> +void armpmu_free_irq(struct arm_pmu *armpmu, int cpu)
>  {
> -	int err = 0;
>  	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
> -	const irq_handler_t handler = armpmu_dispatch_irq;
>  	int irq = per_cpu(hw_events->irq, cpu);
> +
> +	armpmu_free_cpu_irq(irq, cpu);
> +}
> +
> +int armpmu_request_cpu_irq(int irq, int cpu)
> +{
> +	int err = 0;
> +	const irq_handler_t handler = armpmu_dispatch_irq;
>  	if (!irq)
>  		return 0;
>  
> @@ -560,16 +577,16 @@ int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
>  
>  		irq_set_status_flags(irq, IRQ_NOAUTOEN);
>  		err = request_irq(irq, handler, irq_flags, "arm-pmu",
> -				  per_cpu_ptr(&hw_events->percpu_pmu, cpu));
> -	} else if (cpumask_empty(&armpmu->active_irqs)) {
> +				  NULL);
> +	} else if (armpmu_count_irq_users(irq) == 0) {
>  		err = request_percpu_irq(irq, handler, "arm-pmu",
> -					 &hw_events->percpu_pmu);
> +					 cpu_armpmu);

This should be &cpu_armpmu.

Would it be possible to pass &cpu_armpmu as the devid even in the normal
request_irq case and have the dispatcher just pass it through to the
underlying handler, rather than access cpu_armpmu directly?

Will
