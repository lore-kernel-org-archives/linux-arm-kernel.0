From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Wed, 28 Dec 2011 00:14:28 +0100
Subject: [PATCH 2/2] ARM: Exynos: Hook up power domains to generic power
 domain infrastructure
In-Reply-To: <1323704789-23923-3-git-send-email-thomas.abraham@linaro.org>
References: <1323704789-23923-1-git-send-email-thomas.abraham@linaro.org>
 <1323704789-23923-2-git-send-email-thomas.abraham@linaro.org>
 <1323704789-23923-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4EFA5154.9060606@gmail.com>
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
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 0afcc3b..c1f77c7 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -29,6 +29,7 @@ config CPU_EXYNOS4210
>  	default y
>  	depends on ARCH_EXYNOS4
>  	select SAMSUNG_DMADEV
> +	select PM_GENERIC_DOMAINS
>  	select ARM_CPU_SUSPEND if PM
>  	select S5P_PM if PM
>  	select S5P_SLEEP if PM
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index 4093fea..a471ea6 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -20,6 +20,10 @@
>  #include <linux/io.h>
>  #include <linux/err.h>
>  #include <linux/clk.h>
> +#include <linux/slab.h>
> +#include <linux/pm_domain.h>
> +#include <linux/delay.h>
> +#include <linux/of_address.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/hardware/cache-l2x0.h>
> @@ -37,6 +41,13 @@
>  #include <mach/pm-core.h>
>  #include <mach/pmu.h>
>  
> +struct exynos4_pm_domain {
> +	void __iomem *base;
> +	char const *name;
> +	bool is_off;
> +	struct generic_pm_domain pd;
> +};
> +
>  static struct sleep_save exynos4_set_clksrc[] = {
>  	{ .reg = S5P_CLKSRC_MASK_TOP			, .val = 0x00000001, },
>  	{ .reg = S5P_CLKSRC_MASK_CAM			, .val = 0x11111111, },
> @@ -285,12 +296,172 @@ static struct sysdev_driver exynos4_pm_driver = {
>  	.add		= exynos4_pm_add,
>  };
>  
> +static int exynos4_pd_power_on(struct generic_pm_domain *domain)
> +{
> +	struct exynos4_pm_domain *pd;
> +	void __iomem *base;
> +	u32 timeout;
> +
> +	pd = container_of(domain, struct exynos4_pm_domain, pd);
> +	base = pd->base;
> +
> +	__raw_writel(S5P_INT_LOCAL_PWR_EN, base);
> +
> +	/* Wait max 1ms */
> +	timeout = 10;
> +	while ((__raw_readl(base + 0x4) & S5P_INT_LOCAL_PWR_EN)
> +					!= S5P_INT_LOCAL_PWR_EN) {
> +		if (!timeout) {
> +			pr_err("Power domain %s enable failed\n", domain->name);
> +			return -ETIMEDOUT;
> +		}
> +		timeout--;
> +		udelay(100);
> +	}
> +	return 0;
> +}
> +
> +static int exynos4_pd_power_off(struct generic_pm_domain *domain)
> +{
> +	struct exynos4_pm_domain *pd;
> +	void __iomem *base;
> +	u32 timeout;
> +
> +	pd = container_of(domain, struct exynos4_pm_domain, pd);
> +	base = pd->base;
> +
> +	__raw_writel(0, base);
> +
> +	/* Wait max 1ms */
> +	timeout = 10;
> +	while (__raw_readl(base + 0x4) & S5P_INT_LOCAL_PWR_EN) {
> +		if (!timeout) {
> +			pr_err("Power domain %s disable failed\n", domain->name);
> +			return -ETIMEDOUT;
> +		}
> +		timeout--;
> +		udelay(100);
> +	}
> +	return 0;
> +}
> +
> +static struct exynos4_pm_domain exynos4_pd_mfc = {
> +	.base = (void __iomem *)S5P_PMU_MFC_CONF,
> +	.name = "pd-mfc",
> +	.pd = {
> +		.power_off = exynos4_pd_power_off,
> +		.power_on = exynos4_pd_power_on,
> +	},
> +};
> +
> +static struct exynos4_pm_domain exynos4_pd_g3d = {
> +	.base = (void __iomem *)S5P_PMU_G3D_CONF,
> +	.name = "pd-g3d",
> +	.pd = {
> +		.power_off = exynos4_pd_power_off,
> +		.power_on = exynos4_pd_power_on,
> +	},
> +};
> +
> +static struct exynos4_pm_domain exynos4_pd_lcd0 = {
> +	.base = (void __iomem *)S5P_PMU_LCD0_CONF,
> +	.name = "pd-lcd0",
> +	.pd = {
> +		.power_off = exynos4_pd_power_off,
> +		.power_on = exynos4_pd_power_on,
> +	},
> +};
> +
> +static struct exynos4_pm_domain exynos4_pd_lcd1 = {
> +	.base = (void __iomem *)S5P_PMU_LCD1_CONF,
> +	.name = "pd-lcd1",
> +	.pd = {
> +		.power_off = exynos4_pd_power_off,
> +		.power_on = exynos4_pd_power_on,
> +	},
> +};
> +
> +static struct exynos4_pm_domain exynos4_pd_tv = {
> +	.base = (void __iomem *)S5P_PMU_TV_CONF,
> +	.name = "pd-tv",
> +	.pd = {
> +		.power_off = exynos4_pd_power_off,
> +		.power_on = exynos4_pd_power_on,
> +	},
> +};
> +
> +static struct exynos4_pm_domain exynos4_pd_cam = {
> +	.base = (void __iomem *)S5P_PMU_CAM_CONF,
> +	.name = "pd-cam",
> +	.pd = {
> +		.power_off = exynos4_pd_power_off,
> +		.power_on = exynos4_pd_power_on,
> +	},
> +};
> +
> +static struct exynos4_pm_domain exynos4_pd_gps = {
> +	.base = (void __iomem *)S5P_PMU_GPS_CONF,
> +	.name = "pd-gps",
> +	.pd = {
> +		.power_off = exynos4_pd_power_off,
> +		.power_on = exynos4_pd_power_on,
> +	},
> +};

I'm not sure if arch/arm/mach-exynos/pm.c is the right place to add this.
IMHO it would be much better to put PD in separate file, pm-runtime.c
or something like this.

Can we assume various exynos versions will have same S5P_PMU_*_CONF
addresses? For old s3c64xx SoCs such assumption could be valid but I'm
a bit uncertain about Exynos series.

IMHO the proper way to proceed would be to convert Samsung power domains
to generic power domains and then add device tree support. Rather than
doing a sort of work around. Much of the conversion to genpd work have
been already done [1]. We would perhaps just need to drop the clock gating
as there seem to be no agreement about this.

[1]. http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg07431.html

--

Thanks,
Sylwester
