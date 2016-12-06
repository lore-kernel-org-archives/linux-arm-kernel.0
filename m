From: jun.nie@linaro.org (Jun Nie)
Date: Tue, 6 Dec 2016 19:10:38 +0800
Subject: [PATCH v2 1/2] soc: zte: pm_domains: Prepare for supporting ARMv8
 2967 family
In-Reply-To: <1480987828-20549-1-git-send-email-baoyou.xie@linaro.org>
References: <1480987828-20549-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <CABymUCNvzUyiXh3J92L3wkB_a=OrSbA3nUXRcDPoeaBiKM2buw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-12-06 9:30 GMT+08:00 Baoyou Xie <baoyou.xie@linaro.org>:
> The ARMv8 2967 family (296718, 296716 etc) uses different value
> for controlling the power domain on/off registers, Choose the
> value depending on the compatible.
>
> Multiple domains are prepared for the family, they'are privated
> by the drivers of boards.

Domains are SoC specific, not board, right?

>
> This patch prepares the common functions.
>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  drivers/soc/Kconfig          |   1 +
>  drivers/soc/Makefile         |   1 +
>  drivers/soc/zte/Kconfig      |  13 ++++
>  drivers/soc/zte/Makefile     |   4 ++
>  drivers/soc/zte/pm_domains.c | 140 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/soc/zte/pm_domains.h |  41 +++++++++++++
>  6 files changed, 200 insertions(+)
>  create mode 100644 drivers/soc/zte/Kconfig
>  create mode 100644 drivers/soc/zte/Makefile
>  create mode 100644 drivers/soc/zte/pm_domains.c
>  create mode 100644 drivers/soc/zte/pm_domains.h
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
> @@ -16,3 +16,4 @@ obj-$(CONFIG_ARCH_TEGRA)      += tegra/
>  obj-$(CONFIG_SOC_TI)           += ti/
>  obj-$(CONFIG_ARCH_U8500)       += ux500/
>  obj-$(CONFIG_PLAT_VERSATILE)   += versatile/
> +obj-$(CONFIG_ARCH_ZX)          += zte/
> diff --git a/drivers/soc/zte/Kconfig b/drivers/soc/zte/Kconfig
> new file mode 100644
> index 0000000..4953c3fa
> --- /dev/null
> +++ b/drivers/soc/zte/Kconfig
> @@ -0,0 +1,13 @@
> +#
> +# zx SoC drivers
> +#
> +menuconfig SOC_ZX
> +        bool "zx SoC driver support"
> +
> +if SOC_ZX
> +
> +config ZX_PM_DOMAINS
> +        bool "zx PM domains"
> +        depends on PM_GENERIC_DOMAINS
> +
> +endif
> diff --git a/drivers/soc/zte/Makefile b/drivers/soc/zte/Makefile
> new file mode 100644
> index 0000000..97ac8ea
> --- /dev/null
> +++ b/drivers/soc/zte/Makefile
> @@ -0,0 +1,4 @@
> +#
> +# zx SOC drivers
> +#
> +obj-$(CONFIG_ZX_PM_DOMAINS) += pm_domains.o
> diff --git a/drivers/soc/zte/pm_domains.c b/drivers/soc/zte/pm_domains.c
> new file mode 100644
> index 0000000..956c963
> --- /dev/null
> +++ b/drivers/soc/zte/pm_domains.c
> @@ -0,0 +1,140 @@
> +/*
> + * Copyright (C) 2015 ZTE Ltd.
> + *
> + * Author: Baoyou Xie <baoyou.xie@linaro.org>
> + * License terms: GNU General Public License (GPL) version 2
> + */
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include "pm_domains.h"
> +
> +#define PCU_DM_CLKEN(zpd)      ((zpd)->reg_offset[REG_CLKEN])
> +#define PCU_DM_ISOEN(zpd)      ((zpd)->reg_offset[REG_ISOEN])
> +#define PCU_DM_RSTEN(zpd)      ((zpd)->reg_offset[REG_RSTEN])
> +#define PCU_DM_PWREN(zpd)      ((zpd)->reg_offset[REG_PWREN])
> +#define PCU_DM_ACK_SYNC(zpd)   ((zpd)->reg_offset[REG_ACK_SYNC])
> +
> +static void __iomem *pcubase;
> +
> +int zx_normal_power_on(struct generic_pm_domain *domain)
> +{
> +       struct zx_pm_domain *zpd = (struct zx_pm_domain *)domain;
> +       unsigned long loop = 20000;
> +       u32 val;
> +
> +       loop = 1000;

Why change loop value here? You can initialize it to 1000 above.

> +       do {
> +               val = readl_relaxed(pcubase + PCU_DM_PWREN(zpd));
> +               val |= BIT(zpd->bit);
> +               writel_relaxed(val, pcubase + PCU_DM_PWREN(zpd));

Can we put this bit set out of loop?

Suggest to support 6702 with this driver via supporting PWREN
polarity, because all other logic are shared among these ZX SoCs.

> +
> +               udelay(1);
> +               val = readl_relaxed(pcubase
> +                                  + PCU_DM_ACK_SYNC(zpd)) & BIT(zpd->bit);
> +       } while (--loop && !val);
> +
> +       if (!loop) {
> +               pr_err("Error: %s %s fail\n", __func__, domain->name);
> +               return -EIO;
> +       }
> +
> +       val = readl_relaxed(pcubase + PCU_DM_RSTEN(zpd));
> +       val &= ~BIT(zpd->bit);
> +       writel_relaxed(val | BIT(zpd->bit), pcubase + PCU_DM_RSTEN(zpd));
> +       udelay(5);
> +
> +       val = readl_relaxed(pcubase + PCU_DM_ISOEN(zpd));
> +       val &= ~BIT(zpd->bit);
> +       writel_relaxed(val, pcubase + PCU_DM_ISOEN(zpd));
> +       udelay(5);
> +
> +       val = readl_relaxed(pcubase + PCU_DM_CLKEN(zpd));
> +       val &= ~BIT(zpd->bit);
> +       writel_relaxed(val | BIT(zpd->bit), pcubase + PCU_DM_CLKEN(zpd));
> +       udelay(5);
> +
> +       pr_info("normal poweron %s\n", domain->name);
> +
> +       return 0;
> +}
> +
> +int zx_normal_power_off(struct generic_pm_domain *domain)
> +{
> +       struct zx_pm_domain *zpd = (struct zx_pm_domain *)domain;
> +       unsigned long loop = 1000;
> +       u32 val;
> +
> +       val = readl_relaxed(pcubase + PCU_DM_CLKEN(zpd));
> +       val &= ~BIT(zpd->bit);
> +       writel_relaxed(val, pcubase + PCU_DM_CLKEN(zpd));
> +       udelay(5);
> +
> +       val = readl_relaxed(pcubase + PCU_DM_ISOEN(zpd));
> +       val &= ~BIT(zpd->bit);
> +       writel_relaxed(val | BIT(zpd->bit), pcubase + PCU_DM_ISOEN(zpd));
> +       udelay(5);
> +
> +       val = readl_relaxed(pcubase + PCU_DM_RSTEN(zpd));
> +       val &= ~BIT(zpd->bit);
> +       writel_relaxed(val, pcubase + PCU_DM_RSTEN(zpd));
> +       udelay(5);
> +
> +       loop = 1000;
> +       do {
> +               val = readl_relaxed(pcubase + PCU_DM_PWREN(zpd));
> +               val &= ~BIT(zpd->bit);
> +               writel_relaxed(val, pcubase + PCU_DM_PWREN(zpd));

Ditto.

> +
> +               udelay(1);
> +
> +               val = readl_relaxed(pcubase
> +                                  + PCU_DM_ACK_SYNC(zpd)) & BIT(zpd->bit);
> +       } while (--loop && val);
> +
> +       if (!loop) {
> +               pr_err("Error: %s %s fail\n", __func__, domain->name);
> +               return -EIO;
> +       }
> +
> +       pr_info("normal poweroff %s\n", domain->name);
> +
> +       return 0;
> +}
> +
> +int
> +zx_pd_probe(struct platform_device *pdev,
> +          struct generic_pm_domain **zx_pm_domains,
> +          int domain_num)
> +{
> +       struct genpd_onecell_data *genpd_data;
> +       struct resource *res;
> +       int i;
> +
> +       genpd_data = devm_kzalloc(&pdev->dev, sizeof(*genpd_data), GFP_KERNEL);
> +       if (!genpd_data)
> +               return -ENOMEM;
> +
> +       genpd_data->domains = zx_pm_domains;
> +       genpd_data->num_domains = domain_num;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res) {
> +               dev_err(&pdev->dev, "no memory resource defined\n");
> +               return -ENODEV;
> +       }
> +
> +       pcubase = devm_ioremap_resource(&pdev->dev, res);
> +       if (!pcubase) {

Check error with:
if (IS_ERR(pcubase) {

> +               dev_err(&pdev->dev, "ioremap fail.\n");
> +               return -EIO;
> +       }
> +
> +       for (i = 0; i < domain_num; ++i)
> +               pm_genpd_init(zx_pm_domains[i], NULL, false);
> +
> +       of_genpd_add_provider_onecell(pdev->dev.of_node, genpd_data);
> +       dev_info(&pdev->dev, "powerdomain init ok\n");
> +       return 0;
> +}
> diff --git a/drivers/soc/zte/pm_domains.h b/drivers/soc/zte/pm_domains.h
> new file mode 100644
> index 0000000..e02518e
> --- /dev/null
> +++ b/drivers/soc/zte/pm_domains.h
> @@ -0,0 +1,41 @@
> +/*
> + * Copyright (c) 2015 ZTE Co., Ltd.
> + *           http://www.zte.com.cn
> + *
> + * Header for ZTE's Power Domain Driver support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ZTE_PM_DOMAIN_H
> +#define __ZTE_PM_DOMAIN_H
> +
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +
> +enum {
> +       REG_CLKEN,
> +       REG_ISOEN,
> +       REG_RSTEN,
> +       REG_PWREN,
> +       REG_ACK_SYNC,
> +
> +       /* The size of the array - must be last */
> +       REG_ARRAY_SIZE,
> +};
> +
> +struct zx_pm_domain {
> +       struct          generic_pm_domain dm;
> +       const u16       bit;
> +       const u16       *reg_offset;
> +};
> +
> +extern int zx_normal_power_on(struct generic_pm_domain *domain);
> +extern int zx_normal_power_off(struct generic_pm_domain *domain);
> +extern int
> +zx_pd_probe(struct platform_device *pdev,
> +          struct generic_pm_domain **zx_pm_domains,
> +          int domain_num);
> +#endif /* __ZTE_PM_DOMAIN_H */
> --
> 2.7.4
>
