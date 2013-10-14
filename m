From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Oct 2013 13:34:36 +0100
Subject: [PATCH] arm64: perf: add support for percpu pmu interrupt
In-Reply-To: <1381733189-2745-1-git-send-email-vkale@apm.com>
References: <1381733189-2745-1-git-send-email-vkale@apm.com>
Message-ID: <20131014123436.GA10491@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinayak,

On Mon, Oct 14, 2013 at 07:46:29AM +0100, Vinayak Kale wrote:
> This patch adds support for irq registration when pmu interrupt type is PPI.
> The patch also fixes ARMV8_EVTYPE_* macros since evtCount field width is
> 10bits.
> 
> Signed-off-by: Vinayak Kale <vkale@apm.com>
> Signed-off-by: Tuan Phan <tphan@apm.com>
> ---
>  arch/arm64/kernel/perf_event.c |  108 +++++++++++++++++++++++++++++-----------
>  1 file changed, 78 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index cea1594..ba3706d 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -363,22 +363,53 @@ validate_group(struct perf_event *event)
>  }

[...]

>  static int
>  armpmu_reserve_hardware(struct arm_pmu *armpmu)
>  {
> @@ -396,36 +427,53 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
>  		return -ENODEV;
>  	}
>  
> -	for (i = 0; i < irqs; ++i) {
> -		err = 0;
> -		irq = platform_get_irq(pmu_device, i);
> -		if (irq < 0)
> -			continue;
> +	irq = platform_get_irq(pmu_device, 0);
>  
> +	if (irq >= 16 && irq <= 31) {

This is horribly GIC specific and will break in the face of IRQ domains
(since this is a virtual interrupt number).

>  		/*
> -		 * If we have a single PMU interrupt that we can't shift,
> -		 * assume that we're running on a uniprocessor machine and
> -		 * continue. Otherwise, continue without this interrupt.
> +		 * percpu PMU interrupt.
>  		 */
> -		if (irq_set_affinity(irq, cpumask_of(i)) && irqs > 1) {
> -			pr_warning("unable to set irq affinity (irq=%d, cpu=%u)\n",
> -				    irq, i);
> -			continue;
> -		}
> -
> -		err = request_irq(irq, armpmu->handle_irq,
> -				  IRQF_NOBALANCING,
> -				  "arm-pmu", armpmu);
> +		err = request_percpu_irq(irq, armpmu->handle_irq,
> +						"arm-pmu", armpmu);

This is broken -- the dev_id *must* be a __percpu variable for percpu irqs.

>  		if (err) {
>  			pr_err("unable to request IRQ%d for ARM PMU counters\n",
> -				irq);
> +					irq);
>  			armpmu_release_hardware(armpmu);
>  			return err;
>  		}
>  
> -		cpumask_set_cpu(i, &armpmu->active_irqs);
> +		on_each_cpu(armpmu_enable_percpu_irq, (void *)armpmu, 1);
> +	} else {
> +		for (i = 0; i < irqs; ++i) {
> +			err = 0;
> +			irq = platform_get_irq(pmu_device, i);
> +			if (irq < 0)
> +				continue;
> +
> +			/*
> +			 * If we have a single PMU interrupt that we can't shift,
> +			 * assume that we're running on a uniprocessor machine and
> +			 * continue. Otherwise, continue without this interrupt.
> +			 */
> +			if (irq_set_affinity(irq, cpumask_of(i)) && irqs > 1) {
> +				pr_warning("unable to set irq affinity (irq=%d, cpu=%u)\n",
> +						irq, i);
> +				continue;
> +			}
> +
> +			err = request_irq(irq, armpmu->handle_irq,
> +					IRQF_NOBALANCING,
> +					"arm-pmu", armpmu);

A better way to do this is to try request_percpu_irq first. If that fails,
then try request_irq. However, the error reporting out of request_percpu_irq
could do with some cleanup (rather than just return -EINVAL) so we can
detect the difference between `this interrupt isn't per-cpu' and `this
per-cpu interrupt is invalid'. This can help us avoid the WARN_ON in
request_irq when it is passed a per-cpu interrupt.

> @@ -784,8 +832,8 @@ static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
>  /*
>   * PMXEVTYPER: Event selection reg
>   */
> -#define	ARMV8_EVTYPE_MASK	0xc80000ff	/* Mask for writable bits */
> -#define	ARMV8_EVTYPE_EVENT	0xff		/* Mask for EVENT bits */
> +#define	ARMV8_EVTYPE_MASK	0xc80003ff	/* Mask for writable bits */
> +#define	ARMV8_EVTYPE_EVENT	0x3ff		/* Mask for EVENT bits */
>  
>  /*
>   * Event filters for PMUv3
> @@ -1175,7 +1223,7 @@ static void armv8pmu_reset(void *info)
>  static int armv8_pmuv3_map_event(struct perf_event *event)
>  {
>  	return map_cpu_event(event, &armv8_pmuv3_perf_map,
> -				&armv8_pmuv3_perf_cache_map, 0xFF);
> +				&armv8_pmuv3_perf_cache_map, 0x3FF);
>  }

What's all this?

Will
