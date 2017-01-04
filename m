From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 4 Jan 2017 13:44:21 +0800
Subject: [PATCH v5 2/4] soc: zte: pm_domains: Prepare for supporting
 ARMv8 zx2967 family
In-Reply-To: <1483489157-10782-2-git-send-email-baoyou.xie@linaro.org>
References: <1483489157-10782-1-git-send-email-baoyou.xie@linaro.org>
 <1483489157-10782-2-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170104054420.GF20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 08:19:15AM +0800, Baoyou Xie wrote:
> The ARMv8 zx2967 family (296718, 296716 etc) uses different value
> for controlling the power domain on/off registers, Choose the
> value depending on the compatible.
> 
> Multiple domains are prepared for the family, this patch prepares
> the common functions.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> Reviewed-by: Shawn Guo <shawnguo@kernel.org>
> Reviewed-by: Jun Nie <jun.nie@linaro.org>

Same here.  Neither myself nor Jun gave Reviewed-by tag on this patch.

> ---
>  drivers/soc/Kconfig                 |   1 +
>  drivers/soc/Makefile                |   1 +
>  drivers/soc/zte/Kconfig             |  13 ++++
>  drivers/soc/zte/Makefile            |   4 ++
>  drivers/soc/zte/zx2967_pm_domains.c | 139 ++++++++++++++++++++++++++++++++++++
>  drivers/soc/zte/zx2967_pm_domains.h |  46 ++++++++++++
>  6 files changed, 204 insertions(+)
>  create mode 100644 drivers/soc/zte/Kconfig
>  create mode 100644 drivers/soc/zte/Makefile
>  create mode 100644 drivers/soc/zte/zx2967_pm_domains.c
>  create mode 100644 drivers/soc/zte/zx2967_pm_domains.h
> 
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index f31bceb..f09023f 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -11,5 +11,6 @@ source "drivers/soc/tegra/Kconfig"
>  source "drivers/soc/ti/Kconfig"
>  source "drivers/soc/ux500/Kconfig"
>  source "drivers/soc/versatile/Kconfig"
> +source "drivers/soc/zte/Kconfig"
>  
>  endmenu
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 50c23d0..05eae52 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -16,3 +16,4 @@ obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
>  obj-$(CONFIG_SOC_TI)		+= ti/
>  obj-$(CONFIG_ARCH_U8500)	+= ux500/
>  obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
> +obj-$(CONFIG_ARCH_ZX)		+= zte/
> diff --git a/drivers/soc/zte/Kconfig b/drivers/soc/zte/Kconfig
> new file mode 100644
> index 0000000..20bde38
> --- /dev/null
> +++ b/drivers/soc/zte/Kconfig
> @@ -0,0 +1,13 @@
> +#
> +# ZTE SoC drivers
> +#
> +menuconfig SOC_ZTE
> +	bool "ZTE SoC driver support"
> +
> +if SOC_ZTE
> +
> +config ZX2967_PM_DOMAINS
> +	bool "ZX2967 PM domains"
> +	depends on PM_GENERIC_DOMAINS
> +
> +endif
> diff --git a/drivers/soc/zte/Makefile b/drivers/soc/zte/Makefile
> new file mode 100644
> index 0000000..8a37f2f
> --- /dev/null
> +++ b/drivers/soc/zte/Makefile
> @@ -0,0 +1,4 @@
> +#
> +# ZTE SOC drivers
> +#
> +obj-$(CONFIG_ZX2967_PM_DOMAINS) += zx2967_pm_domains.o
> diff --git a/drivers/soc/zte/zx2967_pm_domains.c b/drivers/soc/zte/zx2967_pm_domains.c
> new file mode 100644
> index 0000000..a215875
> --- /dev/null
> +++ b/drivers/soc/zte/zx2967_pm_domains.c
> @@ -0,0 +1,139 @@
> +/*
> + * Copyright (C) 2017 ZTE Ltd.
> + *
> + * Author: Baoyou Xie <baoyou.xie@linaro.org>
> + * License terms: GNU General Public License (GPL) version 2
> + */
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +
> +#include "zx2967_pm_domains.h"
> +
> +#define PCU_DM_CLKEN(zpd)	((zpd)->reg_offset[REG_CLKEN])
> +#define PCU_DM_ISOEN(zpd)	((zpd)->reg_offset[REG_ISOEN])
> +#define PCU_DM_RSTEN(zpd)	((zpd)->reg_offset[REG_RSTEN])
> +#define PCU_DM_PWREN(zpd)	((zpd)->reg_offset[REG_PWREN])
> +#define PCU_DM_PWRDN(zpd)	((zpd)->reg_offset[REG_PWRDN])

PCU_DM_PWRDN doesn't seem to be used anywhere in this driver.

> +#define PCU_DM_ACK_SYNC(zpd)	((zpd)->reg_offset[REG_ACK_SYNC])
> +
> +static void __iomem *pcubase;
> +
> +int zx2967_power_on(struct generic_pm_domain *domain)
> +{
> +	struct zx2967_pm_domain *zpd = (struct zx2967_pm_domain *)domain;
> +	unsigned long loop = 1000;
> +	u32 val;
> +
> +	val = readl_relaxed(pcubase + PCU_DM_PWREN(zpd));
> +	if (zpd->polarity == PWREN)
> +		val |= BIT(zpd->bit);
> +	else
> +		val &= ~BIT(zpd->bit);
> +	writel_relaxed(val, pcubase + PCU_DM_PWREN(zpd));
> +
> +	do {
> +		udelay(1);
> +		val = readl_relaxed(pcubase + PCU_DM_ACK_SYNC(zpd))
> +				   & BIT(zpd->bit);
> +	} while (--loop && !val);
> +
> +	if (!loop) {
> +		pr_err("Error: %s %s fail\n", __func__, domain->name);
> +		return -EIO;
> +	}
> +
> +	val = readl_relaxed(pcubase + PCU_DM_RSTEN(zpd));
> +	val |= BIT(zpd->bit);
> +	writel_relaxed(val, pcubase + PCU_DM_RSTEN(zpd));
> +	udelay(5);
> +
> +	val = readl_relaxed(pcubase + PCU_DM_ISOEN(zpd));
> +	val &= ~BIT(zpd->bit);
> +	writel_relaxed(val, pcubase + PCU_DM_ISOEN(zpd));
> +	udelay(5);
> +
> +	val = readl_relaxed(pcubase + PCU_DM_CLKEN(zpd));
> +	val |= BIT(zpd->bit);
> +	writel_relaxed(val, pcubase + PCU_DM_CLKEN(zpd));
> +	udelay(5);
> +
> +	pr_debug("normal poweron %s\n", domain->name);

Does "normal" in the debug message mean anything here?

> +
> +	return 0;
> +}
> +
> +int zx2967_power_off(struct generic_pm_domain *domain)
> +{
> +	struct zx2967_pm_domain *zpd = (struct zx2967_pm_domain *)domain;
> +	unsigned long loop = 1000;
> +	u32 val;
> +
> +	val = readl_relaxed(pcubase + PCU_DM_CLKEN(zpd));
> +	val &= ~BIT(zpd->bit);
> +	writel_relaxed(val, pcubase + PCU_DM_CLKEN(zpd));
> +	udelay(5);
> +
> +	val = readl_relaxed(pcubase + PCU_DM_ISOEN(zpd));
> +	val |= BIT(zpd->bit);
> +	writel_relaxed(val, pcubase + PCU_DM_ISOEN(zpd));
> +	udelay(5);
> +
> +	val = readl_relaxed(pcubase + PCU_DM_RSTEN(zpd));
> +	val &= ~BIT(zpd->bit);
> +	writel_relaxed(val, pcubase + PCU_DM_RSTEN(zpd));
> +	udelay(5);
> +
> +	val = readl_relaxed(pcubase + PCU_DM_PWREN(zpd));
> +	if (zpd->polarity == PWREN)
> +		val &= ~BIT(zpd->bit);
> +	else
> +		val |= BIT(zpd->bit);
> +	writel_relaxed(val, pcubase + PCU_DM_PWREN(zpd));
> +
> +	do {
> +		udelay(1);
> +		val = readl_relaxed(pcubase + PCU_DM_ACK_SYNC(zpd))
> +				   & BIT(zpd->bit);
> +	} while (--loop && val);
> +
> +	if (!loop) {
> +		pr_err("Error: %s %s fail\n", __func__, domain->name);
> +		return -EIO;
> +	}
> +
> +	pr_debug("normal poweroff %s\n", domain->name);

Ditto

> +
> +	return 0;
> +}
> +
> +int zx2967_pd_probe(struct platform_device *pdev,
> +		    struct generic_pm_domain **zx_pm_domains,
> +		    int domain_num)
> +{
> +	struct genpd_onecell_data *genpd_data;
> +	struct resource *res;
> +	int i;
> +
> +	genpd_data = devm_kzalloc(&pdev->dev, sizeof(*genpd_data), GFP_KERNEL);
> +	if (!genpd_data)
> +		return -ENOMEM;
> +
> +	genpd_data->domains = zx_pm_domains;
> +	genpd_data->num_domains = domain_num;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pcubase = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(pcubase)) {
> +		dev_err(&pdev->dev, "ioremap fail.\n");
> +		return PTR_ERR(pcubase);
> +	}
> +
> +	for (i = 0; i < domain_num; ++i)
> +		pm_genpd_init(zx_pm_domains[i], NULL, false);
> +
> +	of_genpd_add_provider_onecell(pdev->dev.of_node, genpd_data);
> +	dev_info(&pdev->dev, "powerdomain init ok\n");
> +	return 0;
> +}
> diff --git a/drivers/soc/zte/zx2967_pm_domains.h b/drivers/soc/zte/zx2967_pm_domains.h
> new file mode 100644
> index 0000000..81ad4d6
> --- /dev/null
> +++ b/drivers/soc/zte/zx2967_pm_domains.h
> @@ -0,0 +1,46 @@
> +/*
> + * Header for ZTE's Power Domain Driver support
> + *
> + * Copyright (C) 2017 ZTE Ltd.
> + *
> + * Author: Baoyou Xie <baoyou.xie@linaro.org>
> + * License terms: GNU General Public License (GPL) version 2
> + */
> +
> +#ifndef __ZTE_ZX2967_PM_DOMAIN_H
> +#define __ZTE_ZX2967_PM_DOMAIN_H
> +
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +
> +enum {
> +	REG_CLKEN,
> +	REG_ISOEN,
> +	REG_RSTEN,
> +	REG_PWREN,
> +	REG_PWRDN,
> +	REG_ACK_SYNC,
> +
> +	/* The size of the array - must be last */
> +	REG_ARRAY_SIZE,
> +};
> +
> +enum zx2967_power_polarity {
> +	PWREN,
> +	PWRDN,
> +};
> +
> +struct zx2967_pm_domain {
> +	struct generic_pm_domain dm;
> +	const u16 bit;
> +	const enum zx2967_power_polarity polarity;
> +	const u16 *reg_offset;
> +};
> +
> +extern int zx2967_power_on(struct generic_pm_domain *domain);
> +extern int zx2967_power_off(struct generic_pm_domain *domain);
> +extern int zx2967_pd_probe(struct platform_device *pdev,
> +			   struct generic_pm_domain **zx_pm_domains,
> +			   int domain_num);

The 'extern' is not really necessary here.

Shawn

> +
> +#endif /* __ZTE_ZX2967_PM_DOMAIN_H */
> -- 
> 2.7.4
> 
