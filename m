From: jun.nie@linaro.org (Jun Nie)
Date: Mon, 5 Dec 2016 11:15:55 +0800
Subject: [PATCH 1/2] soc: zte: pm_domains: Prepare for supporting ARMv8
 2967 family
In-Reply-To: <1480774291-6211-1-git-send-email-baoyou.xie@linaro.org>
References: <1480774291-6211-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <CABymUCNSn0rKYoWkWwO+UbV37M42apCCh67EUsxKbW2tPtxPSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-12-03 22:11 GMT+08:00 Baoyou Xie <baoyou.xie@linaro.org>:
> The ARMv8 2967 family (296718, 296716 etc) uses different value
> for controlling the power domain on/off registers, Choose the
> value depending on the compatible.
>
> Multiple domains are prepared for the family, it's privated by
> the drivers of boards.
>
> This patch prepares the common functions.
>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  MAINTAINERS                  |   1 +
>  drivers/soc/Kconfig          |   1 +
>  drivers/soc/Makefile         |   1 +
>  drivers/soc/zte/Kconfig      |  13 ++++
>  drivers/soc/zte/Makefile     |   4 ++
>  drivers/soc/zte/pm_domains.c | 138 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/soc/zte/pm_domains.h |  29 +++++++++
>  7 files changed, 187 insertions(+)
>  create mode 100644 drivers/soc/zte/Kconfig
>  create mode 100644 drivers/soc/zte/Makefile
>  create mode 100644 drivers/soc/zte/pm_domains.c
>  create mode 100644 drivers/soc/zte/pm_domains.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ad199da..8198389 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1979,6 +1979,7 @@ L:        linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     arch/arm/mach-zx/
>  F:     drivers/clk/zte/
> +F:     drivers/soc/zte/
>  F:     Documentation/devicetree/bindings/arm/zte.txt
>  F:     Documentation/devicetree/bindings/clock/zx296702-clk.txt
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

Why not reuse ARCH_ZX ?

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
> index 0000000..5792f21
> --- /dev/null
> +++ b/drivers/soc/zte/pm_domains.c
> @@ -0,0 +1,138 @@
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
> +#define PCU_DM_CLKEN        0x18
> +#define PCU_DM_RSTEN        0x20
> +#define PCU_DM_ISOEN        0x1c

List registers with ascending sequence.

I find these registers offset is different with existing 296702
register offset. So I suggest to use offset table to resolve the
conflict so that this driver is extendable for more SoC with different
register offset if you want. You can reference
drivers/tty/serial/amba-pl011.c for register offset handling.

> +#define PCU_DM_PWREN        0x24
> +#define PCU_DM_ACK_SYNC     0x28
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
> +       do {
> +               val = readl_relaxed(pcubase + PCU_DM_PWREN);
> +               val |= BIT(zpd->bit);

bit polarity can also be configurable if you want support more SoCs
with different polarity setting.

> +               writel_relaxed(val, pcubase + PCU_DM_PWREN);
> +
> +               udelay(1);
> +               val = readl_relaxed(pcubase + PCU_DM_ACK_SYNC) & BIT(zpd->bit);
> +       } while (--loop && !val);
> +
> +       if (!loop) {
> +               pr_err("Error: %s %s fail\n", __func__, domain->name);
> +               return -EIO;
> +       }
> +
> +       val = readl_relaxed(pcubase + PCU_DM_RSTEN);
> +       val &= ~BIT(zpd->bit);
> +       writel_relaxed(val | BIT(zpd->bit), pcubase + PCU_DM_RSTEN);
> +       udelay(5);
> +
> +       val = readl_relaxed(pcubase + PCU_DM_ISOEN);
> +       val &= ~BIT(zpd->bit);
> +       writel_relaxed(val, pcubase + PCU_DM_ISOEN);
> +       udelay(5);
> +
> +       val = readl_relaxed(pcubase + PCU_DM_CLKEN);
> +       val &= ~BIT(zpd->bit);
> +       writel_relaxed(val | BIT(zpd->bit), pcubase + PCU_DM_CLKEN);
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
> +       val = readl_relaxed(pcubase + PCU_DM_CLKEN);
> +       val &= ~BIT(zpd->bit);
> +       writel_relaxed(val, pcubase + PCU_DM_CLKEN);
> +       udelay(5);
> +
> +       val = readl_relaxed(pcubase + PCU_DM_ISOEN);
> +       val &= ~BIT(zpd->bit);
> +       writel_relaxed(val | BIT(zpd->bit), pcubase + PCU_DM_ISOEN);
> +       udelay(5);
> +
> +       val = readl_relaxed(pcubase + PCU_DM_RSTEN);
> +       val &= ~BIT(zpd->bit);
> +       writel_relaxed(val, pcubase + PCU_DM_RSTEN);
> +       udelay(5);
> +
> +       loop = 1000;
> +       do {
> +               val = readl_relaxed(pcubase + PCU_DM_PWREN);
> +               val &= ~BIT(zpd->bit);
> +               writel_relaxed(val, pcubase + PCU_DM_PWREN);
> +
> +               udelay(1);
> +
> +               val = readl_relaxed(pcubase + PCU_DM_ACK_SYNC) & BIT(zpd->bit);
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
> index 0000000..613e0be
> --- /dev/null
> +++ b/drivers/soc/zte/pm_domains.h
> @@ -0,0 +1,29 @@
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
> +struct zx_pm_domain {
> +       struct generic_pm_domain dm;
> +       unsigned int bit;
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
