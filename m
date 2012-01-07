From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Sat, 07 Jan 2012 15:44:30 +0100
Subject: [PATCH v2 2/2] ARM: Exynos: Hook up power domains to generic
 power domain infrastructure
In-Reply-To: <1325931055-14486-3-git-send-email-thomas.abraham@linaro.org>
References: <1325931055-14486-1-git-send-email-thomas.abraham@linaro.org>
 <1325931055-14486-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4F085A4E.3010200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

thank you for working on this. I have a few comments below..

On 01/07/2012 11:10 AM, Thomas Abraham wrote:
> Add support for generic power domain for Exynos4 platforms and remove the
> Samsung specific power domain control for Exynos4.
> 
> The generic power domain infrastructure is used to control the power domains
> available on Exynos4. For non-dt platforms, the power domains are statically
> instantiated. For dt platforms, the power domain nodes found in the device
> tree are instantiated.
> 
> Cc: Rafael J. Wysocki<rjw@sisk.pl>
> Cc: Kukjin Kim<kgene.kim@samsung.com>
> Cc: Kyungmin Park<kyungmin.park@samsung.com>
> Cc: Rob Herring<rob.herring@calxeda.com>
> Cc: Grant Likely<grant.likely@secretlab.ca>
> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
> ---
> This patch is mainly derived from Mark Brown's work on generic power domain
> support for s3c64xx platforms.
> 
>   arch/arm/mach-exynos/Kconfig               |   10 +--
>   arch/arm/mach-exynos/Makefile              |    2 +-
>   arch/arm/mach-exynos/dev-pd.c              |  139 ---------------------
>   arch/arm/mach-exynos/mach-nuri.c           |   11 --
>   arch/arm/mach-exynos/mach-origen.c         |   14 --
>   arch/arm/mach-exynos/mach-smdkv310.c       |   12 --
>   arch/arm/mach-exynos/mach-universal_c210.c |   17 ---
>   arch/arm/mach-exynos/pm_domains.c          |  183 ++++++++++++++++++++++++++++
>   8 files changed, 185 insertions(+), 203 deletions(-)
>   delete mode 100644 arch/arm/mach-exynos/dev-pd.c
>   create mode 100644 arch/arm/mach-exynos/pm_domains.c
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index e931924..5dec134 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -32,6 +32,7 @@ config CPU_EXYNOS4210
>   	select ARM_CPU_SUSPEND if PM
>   	select S5P_PM if PM
>   	select S5P_SLEEP if PM
> +	select PM_GENERIC_DOMAINS
>   	help
>   	  Enable EXYNOS4210 CPU support
> 
...
> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
> new file mode 100644
> index 0000000..95a7c55
> --- /dev/null
> +++ b/arch/arm/mach-exynos/pm_domains.c
> @@ -0,0 +1,183 @@
> +/*
> + * Exynos4 Generic power domain support.
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.

2012 ?

> + *		http://www.samsung.com
> + *
> + * Implementation of Exynos4 specific power domain control which is used in
> + * conjunction with runtime-pm. Support for both device-tree and non-device-tree
> + * based power domain support is included.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include<linux/io.h>
> +#include<linux/err.h>
> +#include<linux/slab.h>
> +#include<linux/pm_domain.h>
> +#include<linux/delay.h>
> +#include<linux/of_address.h>
> +
> +#include<mach/regs-pmu.h>
> +#include<plat/devs.h>
> +
> +/*
> + * Exynos4 specific wrapper around the generic power domain
> + */
> +struct exynos4_pm_domain {
> +	void __iomem *base;
> +	char const *name;
> +	bool is_off;
> +	struct generic_pm_domain pd;
> +};
> +
> +static int exynos4_pd_power(struct generic_pm_domain *domain, bool power_on)
> +{
> +	struct exynos4_pm_domain *pd;
> +	void __iomem *base;
> +	u32 timeout, pwr;
> +	char *op;
> +
> +	pd = container_of(domain, struct exynos4_pm_domain, pd);
> +	base = pd->base;
> +
> +	pwr = (power_on) ? S5P_INT_LOCAL_PWR_EN : 0;

Is there any value in parentheses around 'power_on' ? 

> +	__raw_writel(pwr, base);
> +
> +	/* Wait max 1ms */
> +	timeout = 10;
> +
> +	while ((__raw_readl(base + 0x4)&  S5P_INT_LOCAL_PWR_EN)	!= pwr) {
> +		if (!timeout) {
> +			op = (power_on) ? "enable" : "disable";
> +			pr_err("Power domain %s %s failed\n", op, domain->name);

How about just:
       pr_err("%s power domain state change (%d) failed\n",
              domain->name, power_on);
?
> +			return -ETIMEDOUT;
> +		}
> +		timeout--;
> +		cpu_relax();

Does cpu_relax() make any difference here ?

> +		usleep_range(80, 100);
> +	}
> +	return 0;
> +}
> +
> +static int exynos4_pd_power_on(struct generic_pm_domain *domain)
> +{
> +	return exynos4_pd_power(domain, true);
> +}
> +
> +static int exynos4_pd_power_off(struct generic_pm_domain *domain)
> +{
> +	return exynos4_pd_power(domain, false);
> +}
> +
> +
> +#define EXYNOS4_GPD(PD, BASE, NAME)			\
> +static struct exynos4_pm_domain PD = {			\
> +	.base = (void __iomem *)BASE,			\
> +	.name = NAME,					\
> +	.pd = {						\
> +		.power_off = exynos4_pd_power_off,	\
> +		.power_on = exynos4_pd_power_on,	\
> +	},						\
> +}
> +
> +EXYNOS4_GPD(exynos4_pd_mfc, S5P_PMU_MFC_CONF, "pd-mfc");
> +EXYNOS4_GPD(exynos4_pd_g3d, S5P_PMU_G3D_CONF, "pd-g3d");
> +EXYNOS4_GPD(exynos4_pd_lcd0, S5P_PMU_LCD0_CONF, "pd-lcd0");
> +EXYNOS4_GPD(exynos4_pd_lcd1, S5P_PMU_LCD1_CONF, "pd-lcd1");
> +EXYNOS4_GPD(exynos4_pd_tv, S5P_PMU_TV_CONF, "pd-tv");
> +EXYNOS4_GPD(exynos4_pd_cam, S5P_PMU_CAM_CONF, "pd-cam");
> +EXYNOS4_GPD(exynos4_pd_gps, S5P_PMU_GPS_CONF, "pd-gps");
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
> +static __init int exynos4_pm_init_power_domain(void)
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
> +			pr_err("exynos4_pm_init_power_domain: failed to "
> +					"allocate memory for domain\n");

nit: what about:
			pr_err("%s: failed to allocate memory for domain\n",
				__func__);
?
> +			return -ENOMEM;
> +		}
> +
> +		if (of_get_property(np, "samsung,exynos4210-pd-off", NULL))
> +			pd->is_off = true;
> +		pd->name = np->name;
> +		pd->base = of_iomap(np, 0);
> +		pd->pd.power_off = exynos4_pd_power_off;
> +		pd->pd.power_on = exynos4_pd_power_on;
> +		pd->pd.of_node = np;
> +		pm_genpd_init(&pd->pd, NULL, false);
> +	}
> +	return 0;
> +#endif /* CONFIG_OF */
> +
> + no_dt:
> +	for (idx = 0; idx<  ARRAY_SIZE(exynos4_pm_domains); idx++)
> +		pm_genpd_init(&exynos4_pm_domains[idx]->pd, NULL,
> +				exynos4_pm_domains[idx]->is_off);
> +
> +#ifdef CONFIG_S5P_DEV_FIMD0
> +	if (pm_genpd_add_device(&exynos4_pd_lcd0.pd,&s5p_device_fimd0.dev))
> +		pr_info("error in adding fimd0 to lcd0 power domain\n");
> +#endif
> +#ifdef CONFIG_S5P_DEV_TV
> +	if (pm_genpd_add_device(&exynos4_pd_tv.pd,&s5p_device_hdmi.dev))
> +		pr_info("error in adding hdmi to tv power domain\n");
> +	if (pm_genpd_add_device(&exynos4_pd_tv.pd,&s5p_device_mixer.dev))
> +		pr_info("error in adding mixer to tv power domain\n");
> +#endif
> +#ifdef CONFIG_S5P_DEV_MFC
> +	if (pm_genpd_add_device(&exynos4_pd_mfc.pd,&s5p_device_mfc.dev))
> +		pr_info("error in adding mfc to mfc power domain\n");
> +#endif
> +#ifdef CONFIG_S5P_DEV_FIMC0
> +	if (pm_genpd_add_device(&exynos4_pd_cam.pd,&s5p_device_fimc0.dev))
> +		pr_info("error in adding fimc0 to cam power domain\n");
> +#endif
> +#ifdef CONFIG_S5P_DEV_FIMC1
> +	if (pm_genpd_add_device(&exynos4_pd_cam.pd,&s5p_device_fimc1.dev))
> +		pr_info("error in adding fimc1 to cam power domain\n");
> +#endif
> +#ifdef CONFIG_S5P_DEV_FIMC2
> +	if (pm_genpd_add_device(&exynos4_pd_cam.pd,&s5p_device_fimc2.dev))
> +		pr_info("error in adding fimc2 to cam power domain\n");
> +#endif
> +#ifdef CONFIG_S5P_DEV_FIMC3
> +	if (pm_genpd_add_device(&exynos4_pd_cam.pd,&s5p_device_fimc3.dev))
> +		pr_info("error in adding fimc3 to cam power domain\n");
> +#endif
> +#ifdef CONFIG_S5P_DEV_CSIS0
> +	if (pm_genpd_add_device(&exynos4_pd_cam.pd,&s5p_device_mipi_csis0.dev))
> +		pr_info("error in adding csis0 to cam power domain\n");
> +#endif

Could you add CSIS1 as well ? Some boards will be using both MIPI-CSI receivers.

> +	return 0;
> +}
> +arch_initcall(exynos4_pm_init_power_domain);
> +
> +static __init int exynos4_pm_late_initcall(void)
> +{
> +	pm_genpd_poweroff_unused();
> +	return 0;
> +}
> +late_initcall(exynos4_pm_late_initcall);

--

Regards,
Sylwester
