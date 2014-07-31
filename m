From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 01 Aug 2014 03:32:25 +0900
Subject: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos4210/5250/5420
In-Reply-To: <1406707663-16656-5-git-send-email-thomas.ab@samsung.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
 <1406707663-16656-5-git-send-email-thomas.ab@samsung.com>
Message-ID: <53DA8BB9.6020702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/14 17:07, Thomas Abraham wrote:
> The new CPU clock type allows the use of generic CPUfreq drivers. So for
> Exynos4210/5250, switch to using generic cpufreq driver. For Exynos5420,
> which did not have CPUfreq driver support, enable the use of generic
> CPUfreq driver.
>
> Suggested-by: Tomasz Figa<t.figa@samsung.com>
> Cc: Kukjin Kim<kgene.kim@samsung.com>

Looks good to me,

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

BTW, who will handle this series? I hope see this series in 3.17.

- Kukjin

> Signed-off-by: Thomas Abraham<thomas.ab@samsung.com>
> Reviewed-by: Tomasz Figa<t.figa@samsung.com>
> ---
>   arch/arm/mach-exynos/exynos.c |   24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 493dbc2..e61bb36 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -281,6 +281,28 @@ static void __init exynos_init_irq(void)
>   	exynos_map_pmu();
>   }
>
> +static const struct of_device_id exynos_cpufreq_matches[] = {
> +	{ .compatible = "samsung,exynos5420", .data = "arm-bL-cpufreq-dt" },
> +	{ .compatible = "samsung,exynos5250", .data = "cpufreq-cpu0" },
> +	{ .compatible = "samsung,exynos4210", .data = "cpufreq-cpu0" },
> +	{ .compatible = "samsung,exynos5440", .data = "exynos5440-cpufreq" },
> +	{ /* sentinel */ }
> +};
> +
> +static void __init exynos_cpufreq_init(void)
> +{
> +	struct device_node *root = of_find_node_by_path("/");
> +	const struct of_device_id *match;
> +
> +	match = of_match_node(exynos_cpufreq_matches, root);
> +	if (!match) {
> +		platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
> +		return;
> +	}
> +
> +	platform_device_register_simple(match->data, -1, NULL, 0);
> +}
> +
>   static void __init exynos_dt_machine_init(void)
>   {
>   	struct device_node *i2c_np;
> @@ -320,7 +342,7 @@ static void __init exynos_dt_machine_init(void)
>   			of_machine_is_compatible("samsung,exynos5250"))
>   		platform_device_register(&exynos_cpuidle);
>
> -	platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
> +	exynos_cpufreq_init();
>
>   	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>   }

-- 
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
