From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Wed, 28 Dec 2011 19:58:11 +0100
Subject: [PATCH 2/2] ARM: Exynos: Hook up power domains to generic power
 domain infrastructure
In-Reply-To: <1323704789-23923-3-git-send-email-thomas.abraham@linaro.org>
References: <1323704789-23923-1-git-send-email-thomas.abraham@linaro.org>
 <1323704789-23923-2-git-send-email-thomas.abraham@linaro.org>
 <1323704789-23923-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4EFB66C3.4040504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 12/12/2011 04:46 PM, Thomas Abraham wrote:
> The generic power domain infrastructure is used to control the power domains
> available on Exynos4. For non-dt platforms, the power domains are statically
> instantiated. For dt platforms, the power domain nodes found in the device
> tree are instantiated.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> This patch is mainly derived from Mark Brown's work on generic power domain
> support for s3c64xx platforms. The existing exynos4 power domain implementation
> is not removed in this patch. The devices are not yet registered with the power
> domains for non-dt platforms.
> 
>  arch/arm/mach-exynos/Kconfig |    1 +
>  arch/arm/mach-exynos/pm.c    |  179 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 180 insertions(+), 0 deletions(-)
> 
[...]
> +
> +static struct exynos4_pm_domain exynos4_pd_gps = {
> +	.base = (void __iomem *)S5P_PMU_GPS_CONF,
> +	.name = "pd-gps",
> +	.pd = {
> +		.power_off = exynos4_pd_power_off,
> +		.power_on = exynos4_pd_power_on,
> +	},
> +};
> +
> +static struct exynos4_pm_domain *exynos4_pm_domains[] = {
> +	&exynos4_pd_mfc,
> +	&exynos4_pd_g3d,
> +	&exynos4_pd_lcd0,
> +	&exynos4_pd_lcd1,
> +	&exynos4_pd_tv,
> +	&exynos4_pd_cam,
> +	&exynos4_pd_gps,
> +};
> +
> +static __init void exynos4_pm_init_power_domain(void)
> +{
> +	int idx;
> +	struct device_node *np;
> +
> +#ifdef CONFIG_OF
> +	if (!of_have_populated_dt())
> +		goto no_dt;
> +
> +	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
> +		struct exynos4_pm_domain *pd;
> +
> +		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> +		if (!pd) {
> +			pr_err("exynos4_pm_init_power_domain: memalloc "
> +					"failed\n");
> +			return;
> +		}
> +
> +		if (of_get_property(np, "samsung,exynos4210-pd-off", NULL))
> +			pd->is_off = true;
> +		pd->name = np->name;
> +		pd->base = of_iomap(np, 0);

Sorry, I haven't reviewed your patch carefully enough. So for dt platforms
pd->base is initialized from "reg" property, directly from each power domain's
DT node. Only the static power domain instantiation for non-dt platforms would
possibly need some code modifications when new SoCs are added.

Would be nice to have a relevant patch for *.dts files in this series too. :)

> +		pd->pd.power_off = exynos4_pd_power_off;
> +		pd->pd.power_on = exynos4_pd_power_on;
> +		pd->pd.of_node = np;
> +		pm_genpd_init(&pd->pd, NULL, false);
> +	}
> +	return;
> +#endif /* CONFIG_OF */
> +
> +no_dt:
> +	for (idx = 0; idx < ARRAY_SIZE(exynos4_pm_domains); idx++)
> +		pm_genpd_init(&exynos4_pm_domains[idx]->pd, NULL,
> +				exynos4_pm_domains[idx]->is_off);
> +}

--
Thanks,
Sylwester
