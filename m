From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 7 Apr 2017 11:13:15 +0200
Subject: [PATCH v9 04/12] soc: samsung: add exynos chipid driver support
In-Reply-To: <1490879826-16754-5-git-send-email-pankaj.dubey@samsung.com>
References: <CGME20170330131427epcas5p4c3d238022dc75694ad3baa8a1018ea04@epcas5p4.samsung.com>
 <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <1490879826-16754-5-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <CAJKOXPeCD+U_2U4yj7LiKkWZjvXr9joY4bRqL+-MHdka=9viWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 3:16 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> Exynos SoCs have Chipid, for identification of product IDs and SoC
> revisions. This patch intends to provide initialization code for all
> these functionalities, at the same time it provides some sysfs entries
> for accessing these information to user-space.
>
> This driver uses existing binding for exynos-chipid.
>
> CC: Grant Likely <grant.likely@linaro.org>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> [m.szyprowski: for suggestion and code snippet of product_id_to_soc_id]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/soc/samsung/Kconfig         |   5 ++
>  drivers/soc/samsung/Makefile        |   1 +
>  drivers/soc/samsung/exynos-chipid.c | 109 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 115 insertions(+)
>  create mode 100644 drivers/soc/samsung/exynos-chipid.c
>
> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> index 8b25bd5..a90a4ad 100644
> --- a/drivers/soc/samsung/Kconfig
> +++ b/drivers/soc/samsung/Kconfig
> @@ -6,6 +6,11 @@ menuconfig SOC_SAMSUNG
>
>  if SOC_SAMSUNG
>
> +config EXYNOS_CHIPID
> +       bool "Exynos Chipid controller driver" if COMPILE_TEST
> +       depends on ARCH_EXYNOS || COMPILE_TEST
> +       select SOC_BUS
> +
>  config EXYNOS_PMU
>         bool "Exynos PMU controller driver" if COMPILE_TEST
>         depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> index 4d7694a..be3b6bb 100644
> --- a/drivers/soc/samsung/Makefile
> +++ b/drivers/soc/samsung/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_EXYNOS_CHIPID)    += exynos-chipid.o
>  obj-$(CONFIG_EXYNOS_PMU)       += exynos-pmu.o
>
>  obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)   += exynos3250-pmu.o exynos4-pmu.o \
> diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
> new file mode 100644
> index 0000000..1e9fb6b
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos-chipid.c
> @@ -0,0 +1,109 @@
> +/*
> + * Copyright (c) 2017 Samsung Electronics Co., Ltd.
> + *           http://www.samsung.com/
> + *
> + * EXYNOS - CHIP ID support
> + * Author: Pankaj Dubey <pankaj.dubey@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/sys_soc.h>
> +
> +#define EXYNOS_SUBREV_MASK     (0xF << 4)
> +#define EXYNOS_MAINREV_MASK    (0xF << 0)
> +#define EXYNOS_REV_MASK                (EXYNOS_SUBREV_MASK | EXYNOS_MAINREV_MASK)
> +
> +static const struct exynos_soc_id {
> +       const char *name;
> +       unsigned int id;
> +       unsigned int mask;
> +} soc_ids[] = {
> +       { "EXYNOS3250", 0xE3472000, 0xFFFFF000 },
> +       { "EXYNOS4210", 0x43210000, 0xFFFFF000 },
> +       { "EXYNOS4212", 0x43220000, 0xFFFFF000 },
> +       { "EXYNOS4412", 0xE4412000, 0xFFFFF000 },
> +       { "EXYNOS5250", 0x43520000, 0xFFFFF000 },
> +       { "EXYNOS5260", 0xE5260000, 0xFFFFF000 },
> +       { "EXYNOS5410", 0xE5410000, 0xFFFFF000 },
> +       { "EXYNOS5420", 0xE5420000, 0xFFFFF000 },
> +       { "EXYNOS5440", 0xE5440000, 0xFFFFF000 },
> +       { "EXYNOS5800", 0xE5422000, 0xFFFFF000 },
> +       { "EXYNOS7420", 0xE7420000, 0xFFFFF000 },
> +       { "EXYNOS5433", 0xE5433000, 0xFFFFF000 },
> +};
> +
> +static const char * __init product_id_to_soc_id(unsigned int product_id)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(soc_ids); i++)
> +               if ((product_id & soc_ids[i].mask) == soc_ids[i].id)
> +                       return soc_ids[i].name;
> +       return "UNKNOWN";
> +}
> +
> +int __init exynos_chipid_early_init(void)
> +{
> +       struct soc_device_attribute *soc_dev_attr;
> +       void __iomem *exynos_chipid_base;
> +       struct soc_device *soc_dev;
> +       struct device_node *root;
> +       struct device_node *np;
> +       struct device *dev;
> +       u32 product_id;
> +       u32 revision;
> +
> +       /* look up for chipid node */
> +       np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-chipid");
> +       if (!np)
> +               return -ENODEV;
> +
> +       exynos_chipid_base = of_iomap(np, 0);
> +       of_node_put(np);
> +
> +       if (!exynos_chipid_base) {
> +               pr_err("%s: failed to map chipid\n", np->name);
> +               return -ENOMEM;
> +       }
> +
> +       product_id = readl_relaxed(exynos_chipid_base);
> +       revision = product_id & EXYNOS_REV_MASK;
> +       iounmap(exynos_chipid_base);
> +
> +       soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +       if (!soc_dev_attr)
> +               return -ENODEV;

This should be -ENOMEM

> +
> +       soc_dev_attr->family = "Samsung Exynos";
> +
> +       root = of_find_node_by_path("/");
> +       of_property_read_string(root, "model", &soc_dev_attr->machine);
> +       of_node_put(root);
> +
> +       soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x", revision);
> +       soc_dev_attr->soc_id = product_id_to_soc_id(product_id);
> +
> +       soc_dev = soc_device_register(soc_dev_attr);
> +       if (IS_ERR(soc_dev)) {
> +               kfree(soc_dev_attr->revision);
> +               kfree_const(soc_dev_attr->soc_id);

This was not allocated with kstrdup_const() so it should not be freed.

Best regards,
Krzysztof
