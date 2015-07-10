From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jul 2015 17:55:01 +0900
Subject: [PATCH v2 6/7] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos4x12
In-Reply-To: <1436456621-29839-7-git-send-email-b.zolnierkie@samsung.com>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1436456621-29839-7-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <559F8865.1040608@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.07.2015 00:43, Bartlomiej Zolnierkiewicz wrote:
> The new CPU clock type allows the use of generic CPUfreq driver.
> Switch Exynos4x12 to using generic cpufreq driver.
> 
> This patch also takes care of making ARM_EXYNOS_CPU_FREQ_BOOST_SW
> config option depend on cpufreq-dt driver instead of exynos-cpufreq
> one and fixes the minor issue present with the old code (support
> for 'boost' mode in the exynos-cpufreq driver was enabled for all
> supported SoCs even though 'boost' frequency was provided only for
> Exynos4x12 ones).
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c    | 14 ++++++++++++++
>  drivers/cpufreq/Kconfig.arm      |  2 +-
>  drivers/cpufreq/exynos-cpufreq.c |  3 ---
>  3 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 4015ec3..0c74e90 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -20,6 +20,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/irqchip.h>
> +#include <linux/cpufreq-dt.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/hardware/cache-l2x0.h>
> @@ -224,6 +225,12 @@ static void __init exynos_init_irq(void)
>  	exynos_map_pmu();
>  }
>  
> +struct cpufreq_dt_platform_data cpufreq_dt_pd = {

Shouldn't this be static?

> +#ifdef CONFIG_ARM_EXYNOS_CPU_FREQ_BOOST_SW
> +	.boost_supported = true,
> +#endif
> +};
> +
>  static const struct of_device_id exynos_cpufreq_matches[] = {
>  	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
>  	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
> @@ -235,6 +242,13 @@ static void __init exynos_cpufreq_init(void)
>  	struct device_node *root = of_find_node_by_path("/");
>  	const struct of_device_id *match;
>  
> +	if (of_machine_is_compatible("samsung,exynos4212") ||
> +	    of_machine_is_compatible("samsung,exynos4412")) {
> +		platform_device_register_data(NULL, "cpufreq-dt", -1,
> +					&cpufreq_dt_pd, sizeof(cpufreq_dt_pd));
> +		return;
> +	}
> +
>  	match = of_match_node(exynos_cpufreq_matches, root);
>  	if (!match) {
>  		platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);

Now we have two places with compatibles for matching cpufreq-dt driver.
It is confusing especially when grepping for compatibles.

Instead why not use 'data' from exynos_cpufreq_matches? Currently it
stores the "cpufreq-dt" string which looks useless.

Best regards,
Krzysztof


> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 9ab6388c1..5f5a15a 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -49,7 +49,7 @@ config ARM_EXYNOS4X12_CPUFREQ
>  
>  config ARM_EXYNOS_CPU_FREQ_BOOST_SW
>  	bool "EXYNOS Frequency Overclocking - Software"
> -	depends on ARM_EXYNOS_CPUFREQ && THERMAL
> +	depends on CPUFREQ_DT && THERMAL
>  	select CPU_FREQ_BOOST_SW
>  	select EXYNOS_THERMAL
>  	help
> diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
> index 71d8891..89d252e 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -150,9 +150,6 @@ static struct cpufreq_driver exynos_driver = {
>  	.init		= exynos_cpufreq_cpu_init,
>  	.name		= "exynos_cpufreq",
>  	.attr		= cpufreq_generic_attr,
> -#ifdef CONFIG_ARM_EXYNOS_CPU_FREQ_BOOST_SW
> -	.boost_supported = true,
> -#endif
>  #ifdef CONFIG_PM
>  	.suspend	= cpufreq_generic_suspend,
>  #endif
> 
