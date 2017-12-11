From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Dec 2017 17:36:58 +0000
Subject: [PATCH 4/5] arm_pmu: note IRQs/PMUs per-cpu
In-Reply-To: <20171101141239.45340-5-mark.rutland@arm.com>
References: <20171101141239.45340-1-mark.rutland@arm.com>
 <20171101141239.45340-5-mark.rutland@arm.com>
Message-ID: <20171211173657.GB3275@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 02:12:38PM +0000, Mark Rutland wrote:
> The current way we manage IRQs forces the ACPI PMU driver to request
> IRQs in the cpu bringup path, which isn't safe due to implicit memory
> allocations in the request_irq() path.
> 
> To solve that, we need to decouple requesting IRQs from PMU management,
> requesting IRQs up-front, before we know the associated PMU. We will
> separately (and perhaps later) associate each IRQ with its PMU.
> 
> This patch allows the IRQ handlers to be registered without a PMU dev
> argument, using a percpu pointer instead.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/perf/arm_pmu.c       | 93 ++++++++++++++++++++++++++++----------------
>  include/linux/perf/arm_pmu.h |  3 +-
>  2 files changed, 62 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index e0242103d904..287b3edfb4cc 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -26,6 +26,9 @@
>  
>  #include <asm/irq_regs.h>
>  
> +static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
> +static DEFINE_PER_CPU(int, cpu_irq);
> +
>  static int
>  armpmu_map_cache_event(const unsigned (*cache_map)
>  				      [PERF_COUNT_HW_CACHE_MAX]
> @@ -334,13 +337,9 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
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
>  	plat = armpmu_get_platdata(armpmu);
>  
> @@ -531,40 +530,56 @@ int perf_num_counters(void)
>  }
>  EXPORT_SYMBOL_GPL(perf_num_counters);
>  
> -void armpmu_free_irq(struct arm_pmu *armpmu, int cpu)
> +int armpmu_count_irq_users(const int irq)
>  {
> -	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
> -	int irq = per_cpu(hw_events->irq, cpu);
> +	int cpu, count = 0;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (per_cpu(cpu_irq, cpu) == irq)
> +			count++;
> +	}
> +
> +	return count;
> +}
>  
> -	if (!cpumask_test_and_clear_cpu(cpu, &armpmu->active_irqs))
> +void __armpmu_free_irq(int irq, int cpu)
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

Do you actually need the count, or could you just free the irq the first
time this is called and set all of the cpu_irqs to 0?

Will
