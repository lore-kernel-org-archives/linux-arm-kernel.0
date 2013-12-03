From: will.deacon@arm.com (Will Deacon)
Date: Tue, 3 Dec 2013 11:30:52 +0000
Subject: [PATCH V6 2/2] arm64: perf: add support for percpu pmu interrupt
In-Reply-To: <1385976843-13280-3-git-send-email-vkale@apm.com>
References: <1385976843-13280-1-git-send-email-vkale@apm.com>
 <1385976843-13280-3-git-send-email-vkale@apm.com>
Message-ID: <20131203113052.GE1169@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 09:34:03AM +0000, Vinayak Kale wrote:
> Add support for irq registration when pmu interrupt is percpu.
> 
> Signed-off-by: Vinayak Kale <vkale@apm.com>
> Signed-off-by: Tuan Phan <tphan@apm.com>
> ---
>  arch/arm64/kernel/perf_event.c |  116 +++++++++++++++++++++++++++++-----------
>  1 file changed, 86 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index cea1594..d2d562f 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -22,6 +22,7 @@
>  
>  #include <linux/bitmap.h>
>  #include <linux/interrupt.h>
> +#include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/export.h>
>  #include <linux/perf_event.h>
> @@ -363,26 +364,61 @@ validate_group(struct perf_event *event)
>  }
>  
>  static void
> +armpmu_disable_percpu_irq(void *data)
> +{
> +	struct arm_pmu *armpmu = data;
> +	struct platform_device *pmu_device = armpmu->plat_device;
> +	int irq = platform_get_irq(pmu_device, 0);
> +
> +	cpumask_test_and_clear_cpu(smp_processor_id(), &armpmu->active_irqs);
> +	disable_percpu_irq(irq);
> +}
> +
> +static void
>  armpmu_release_hardware(struct arm_pmu *armpmu)
>  {
> -	int i, irq, irqs;
> +	int irq;

Why did you not make this unsigned, like I suggested?

> +	unsigned int i, irqs;
>  	struct platform_device *pmu_device = armpmu->plat_device;
>  
>  	irqs = min(pmu_device->num_resources, num_possible_cpus());
> +	if (!irqs)
> +		return;
>  
> -	for (i = 0; i < irqs; ++i) {
> -		if (!cpumask_test_and_clear_cpu(i, &armpmu->active_irqs))
> -			continue;
> -		irq = platform_get_irq(pmu_device, i);
> -		if (irq >= 0)
> -			free_irq(irq, armpmu);
> +	irq = platform_get_irq(pmu_device, 0);
> +	if (irq <= 0)
> +		return;

Then this is just an if (!irq), as I mentioned last time.

Will
