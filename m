From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Dec 2017 17:36:47 +0000
Subject: [PATCH 5/5] arm_pmu: acpi: request IRQs up-front
In-Reply-To: <20171101141239.45340-6-mark.rutland@arm.com>
References: <20171101141239.45340-1-mark.rutland@arm.com>
 <20171101141239.45340-6-mark.rutland@arm.com>
Message-ID: <20171211173647.GA3275@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 02:12:39PM +0000, Mark Rutland wrote:
> We can't request IRQs in atomic context, so for ACPI systems we'll have
> to request them up-front, and later associate them with CPUs.
> 
> This patch reorganises the arm_pmu code to do so. As we no longer have
> the arm_pmu strucutre at probe time, a number of prototypes need to be
> adjusted, requiring changes to the common arm_pmu code and arm_pmu
> platform code.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/perf/arm_pmu.c          | 37 +++----------------------------------
>  drivers/perf/arm_pmu_acpi.c     | 20 +++++++-------------
>  drivers/perf/arm_pmu_platform.c | 25 ++++++++++++++++++++++---
>  include/linux/perf/arm_pmu.h    | 13 +++++++++++--
>  4 files changed, 43 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 287b3edfb4cc..534b4b3fb440 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -323,13 +323,6 @@ validate_group(struct perf_event *event)
>  	return 0;
>  }
>  
> -static struct arm_pmu_platdata *armpmu_get_platdata(struct arm_pmu *armpmu)
> -{
> -	struct platform_device *pdev = armpmu->plat_device;
> -
> -	return pdev ? dev_get_platdata(&pdev->dev) : NULL;
> -}
> -
>  static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
>  {
>  	struct arm_pmu *armpmu;
> @@ -542,7 +535,7 @@ int armpmu_count_irq_users(const int irq)
>  	return count;
>  }
>  
> -void __armpmu_free_irq(int irq, int cpu)
> +void armpmu_free_irq(int irq, int cpu)
>  {
>  	if (per_cpu(cpu_irq, cpu) == 0)
>  		return;
> @@ -559,16 +552,7 @@ void __armpmu_free_irq(int irq, int cpu)
>  	per_cpu(cpu_irq, cpu) = 0;
>  }
>  
> -void armpmu_free_irq(struct arm_pmu *armpmu, int cpu)
> -{
> -	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
> -	int irq = per_cpu(hw_events->irq, cpu);
> -
> -	__armpmu_free_irq(irq, cpu);
> -	per_cpu(cpu_armpmu, cpu) = NULL;
> -}
> -
> -int armpmu_request_irq_flags(int irq, unsigned long irq_flags, int cpu)
> +int armpmu_request_irq(int irq, unsigned long irq_flags, int cpu)
>  {
>  	int err = 0;
>  	const irq_handler_t handler = armpmu_dispatch_irq;
> @@ -603,24 +587,9 @@ int armpmu_request_irq_flags(int irq, unsigned long irq_flags, int cpu)
>  	return err;
>  }
>  
> -int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
> +void armpmu_bind_cpu(struct arm_pmu *armpmu, int cpu)
>  {
> -	struct arm_pmu_platdata *platdata = armpmu_get_platdata(armpmu);
> -	unsigned long irq_flags;
> -	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
> -	int irq = per_cpu(hw_events->irq, cpu);
> -	if (!irq)
> -		return 0;
> -
> -	if (platdata && platdata->irq_flags) {
> -		irq_flags = platdata->irq_flags;
> -	} else {
> -		irq_flags = ARM_PMU_IRQ_FLAGS;
> -	}
> -
>  	per_cpu(cpu_armpmu, cpu) = armpmu;

Can we not make the binding implicit in armpmu_{request,free}_irq?

Will
