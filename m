From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 25 Aug 2015 10:26:50 +0900
Subject: [PATCH v2 3/7] drivers: soc: add support for exynos SROM driver
In-Reply-To: <1440403348-8974-4-git-send-email-pankaj.dubey@samsung.com>
References: <1440403348-8974-1-git-send-email-pankaj.dubey@samsung.com>
 <1440403348-8974-4-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <55DBC45A.9030706@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.08.2015 17:02, Pankaj Dubey wrote:
> This patch adds Exynos SROM controller driver which will handle
> save restore of SROM registers during S2R.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Hi,

Thanks for the fixes. I got some more questions. Sorry that I did not
bring up them before.


> ---
>  drivers/soc/Kconfig               |   1 +
>  drivers/soc/Makefile              |   1 +
>  drivers/soc/samsung/Kconfig       |  13 ++++
>  drivers/soc/samsung/Makefile      |   1 +
>  drivers/soc/samsung/exynos-srom.c | 143 ++++++++++++++++++++++++++++++++++++++
>  drivers/soc/samsung/exynos-srom.h |  51 ++++++++++++++
>  6 files changed, 210 insertions(+)
>  create mode 100644 drivers/soc/samsung/Kconfig
>  create mode 100644 drivers/soc/samsung/Makefile
>  create mode 100644 drivers/soc/samsung/exynos-srom.c
>  create mode 100644 drivers/soc/samsung/exynos-srom.h
> 
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 96ddecb..69107c9 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -2,6 +2,7 @@ menu "SOC (System On Chip) specific Drivers"
>  
>  source "drivers/soc/mediatek/Kconfig"
>  source "drivers/soc/qcom/Kconfig"
> +source "drivers/soc/samsung/Kconfig"
>  source "drivers/soc/sunxi/Kconfig"
>  source "drivers/soc/ti/Kconfig"
>  source "drivers/soc/versatile/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 7dc7c0d..34c4398 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -4,6 +4,7 @@
>  
>  obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
>  obj-$(CONFIG_ARCH_QCOM)		+= qcom/
> +obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
>  obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
>  obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
>  obj-$(CONFIG_SOC_TI)		+= ti/
> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> new file mode 100644
> index 0000000..ea4bc2a
> --- /dev/null
> +++ b/drivers/soc/samsung/Kconfig
> @@ -0,0 +1,13 @@
> +#
> +# SAMSUNG SoC drivers
> +#
> +menu "Samsung SOC driver support"
> +
> +config SOC_SAMSUNG
> +	bool
> +
> +config EXYNOS_SROM
> +	bool
> +	depends on ARM && ARCH_EXYNOS
> +
> +endmenu
> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> new file mode 100644
> index 0000000..9c554d5
> --- /dev/null
> +++ b/drivers/soc/samsung/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_EXYNOS_SROM)	+= exynos-srom.o
> diff --git a/drivers/soc/samsung/exynos-srom.c b/drivers/soc/samsung/exynos-srom.c
> new file mode 100644
> index 0000000..d7c4aa7
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos-srom.c
> @@ -0,0 +1,143 @@
> +/*
> + * Copyright (c) 2015 Samsung Electronics Co., Ltd.
> + *	      http://www.samsung.com/
> + *
> + * EXYNOS - SROM Controller support
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
> +#include "exynos-srom.h"
> +
> +static void __iomem *exynos_srom_base;
> +
> +static const unsigned long exynos_srom_offsets[] = {
> +	/* SROM side */
> +	EXYNOS_SROM_BW,
> +	EXYNOS_SROM_BC0,
> +	EXYNOS_SROM_BC1,
> +	EXYNOS_SROM_BC2,
> +	EXYNOS_SROM_BC3,
> +};
> +
> +/**
> + * struct exynos_srom_reg_dump: register dump of SROM Controller registers.
> + * @offset: srom register offset from the controller base address.
> + * @value: the value of register under the offset.
> + */
> +struct exynos_srom_reg_dump {
> +	u32     offset;
> +	u32     value;
> +};
> +
> +static struct exynos_srom_reg_dump *exynos_srom_regs;
> +
> +static struct exynos_srom_reg_dump *exynos_srom_alloc_reg_dump(
> +		const unsigned long *rdump,
> +		unsigned long nr_rdump)
> +{
> +	struct exynos_srom_reg_dump *rd;
> +	unsigned int i;
> +
> +	rd = kcalloc(nr_rdump, sizeof(*rd), GFP_KERNEL);
> +	if (!rd)
> +		return NULL;
> +
> +	for (i = 0; i < nr_rdump; ++i)
> +		rd[i].offset = rdump[i];
> +
> +	return rd;
> +}
> +
> +static const struct of_device_id of_exynos_srom_ids[] = {
> +	{
> +		.compatible	= "samsung,exynos-srom",
> +	},
> +	{},
> +};
> +
> +static int exynos_srom_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np;
> +	struct device *dev = &pdev->dev;
> +
> +	np = dev->of_node;
> +	exynos_srom_base = of_iomap(np, 0);

The existing file-scope "exynos_srom_base" would be overwritten for any
consecutive device bind. There shouldn't be more binds than one (there
is only one SROM on board) but still someone may create such DTB. By
mistake or by booting with some newer DTB (where for example two SROMs
would be allowed) with older kernel.

The question is should we handle such case?
E.g.
	if (exynos_srom_base)
		return -EINVAL; /* Doubled bind */
	exynos_srom_base = of_iomap(np, 0);

I see that other drivers don't do that... so I am not convinced. It may
be an useless protection. What do you think?


> +
> +	if (!exynos_srom_base) {
> +		pr_err("iomap of exynos srom controller failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	exynos_srom_regs = exynos_srom_alloc_reg_dump(exynos_srom_offsets,
> +			sizeof(exynos_srom_offsets));
> +
> +	if (!exynos_srom_regs) {
> +		iounmap(exynos_srom_regs);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static void exynos_srom_save(void __iomem *base,
> +				    struct exynos_srom_reg_dump *rd,
> +				    unsigned int num_regs)
> +{
> +	for (; num_regs > 0; --num_regs, ++rd)
> +		rd->value = readl(base + rd->offset);
> +
> +}
> +
> +static void exynos_srom_restore(void __iomem *base,
> +				      const struct exynos_srom_reg_dump *rd,
> +				      unsigned int num_regs)
> +{
> +	for (; num_regs > 0; --num_regs, ++rd)
> +		writel(rd->value, base + rd->offset);
> +
> +}
> +
> +static int exynos_srom_suspend(struct device *dev)
> +{
> +	exynos_srom_save(exynos_srom_base, exynos_srom_regs,
> +				ARRAY_SIZE(exynos_srom_offsets));
> +
> +	return 0;
> +}
> +
> +static int exynos_srom_resume(struct device *dev)
> +{
> +	exynos_srom_restore(exynos_srom_base, exynos_srom_regs,
> +				ARRAY_SIZE(exynos_srom_offsets));
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(exynos_srom_pm_ops, exynos_srom_suspend, exynos_srom_resume);
> +
> +static struct platform_driver exynos_srom_driver = {
> +	.probe = exynos_srom_probe,
> +	.driver = {
> +		.name = "exynos-srom",
> +		.of_match_table = of_exynos_srom_ids,
> +		.pm = &exynos_srom_pm_ops,
> +	},
> +};
> +
> +static int __init exynos_srom_init(void)
> +{
> +	return platform_driver_register(&exynos_srom_driver);
> +}
> +device_initcall(exynos_srom_init);

1. Any reason for using device_initcall() instead of
builtin/module_platform_driver()?

2. There is no device removal callback which would clean up
(kfree+iounmap). Device is not crucial for the system so I suspect it
could be removed (unbind).

Best regards,
Krzysztof
