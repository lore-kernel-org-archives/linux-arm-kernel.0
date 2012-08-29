From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 Aug 2012 22:34:05 +0100
Subject: [PATCH v3 3/4] ARM: EXYNOS: Enable PMUs for exynos4
In-Reply-To: <1346202897-27306-4-git-send-email-chanho61.park@samsung.com>
References: <1346202897-27306-1-git-send-email-chanho61.park@samsung.com>
 <1346202897-27306-4-git-send-email-chanho61.park@samsung.com>
Message-ID: <20120829213405.GC13868@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 02:14:56AM +0100, Chanho Park wrote:
> This patch define irq numbers of ARM performance monitoring unit for exynos4.
> The number of CPU cores and PMU irq numbers are vary according to soc types.
> So we need to identify each soc type using soc_is_xxx function and define the
> pmu irqs dynamically. In case of exynos4412, there are 4 cpu cores and pmus.
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/common.c            |   45 ++++++++++++++++++++++++++++++
>  arch/arm/mach-exynos/include/mach/irqs.h |    8 ++++--
>  arch/arm/plat-samsung/devs.c             |    2 +-
>  3 files changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index be61564..24b78bd 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -30,11 +30,13 @@
>  #include <asm/mach/map.h>
>  #include <asm/mach/irq.h>
>  #include <asm/cacheflush.h>
> +#include <asm/pmu.h>

Why do you need this header file?

>  #include <mach/regs-irq.h>
>  #include <mach/regs-pmu.h>
>  #include <mach/regs-gpio.h>
>  #include <mach/pmu.h>
> +#include <mach/irqs.h>
>  
>  #include <plat/cpu.h>
>  #include <plat/clock.h>
> @@ -1056,3 +1058,46 @@ static int __init exynos_init_irq_eint(void)
>  	return 0;
>  }
>  arch_initcall(exynos_init_irq_eint);
> +
> +#if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212)
> +static struct resource exynos42xx_pmu_resource[] = {
> +	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU),
> +	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU_CPU1),
> +};
> +
> +static struct platform_device exynos42xx_device_pmu = {
> +	.name		= "arm-pmu",
> +	.num_resources	= ARRAY_SIZE(exynos42xx_pmu_resource),
> +	.resource	= exynos42xx_pmu_resource,
> +};
> +#endif

Given that you don't pass an id and your device-tree binding is that for
Cortex A15, I assume this patch series is based on my perf/updates branch?

That's good because it reduces the potential for conflicts, but you should
make sure that whoever you send this to is aware of the dependency.

Cheers,

Will
