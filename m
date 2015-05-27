From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 27 May 2015 20:52:06 +0900
Subject: [PATCH 1/5] drivers: soc: add support for exynos SROM driver
In-Reply-To: <1430296712-10287-2-git-send-email-pankaj.dubey@samsung.com>
References: <1430296712-10287-1-git-send-email-pankaj.dubey@samsung.com>
 <1430296712-10287-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <5565AFE6.5030106@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 29.04.2015 o 17:38, Pankaj Dubey pisze:
> This patch adds Exynos SROM controller driver which will handle
> save restore of SROM registers during S2R.
> 
> Change-Id: Iaddaaebc1d7090c9889e948e68e886519562c43c

Please remove it.

> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  drivers/soc/Kconfig               |   1 +
>  drivers/soc/Makefile              |   1 +
>  drivers/soc/samsung/Kconfig       |  14 ++++
>  drivers/soc/samsung/Makefile      |   1 +
>  drivers/soc/samsung/exynos-srom.c | 142 ++++++++++++++++++++++++++++++++++++++
>  drivers/soc/samsung/exynos-srom.h |  51 ++++++++++++++
>  6 files changed, 210 insertions(+)
>  create mode 100644 drivers/soc/samsung/Kconfig
>  create mode 100644 drivers/soc/samsung/Makefile
>  create mode 100644 drivers/soc/samsung/exynos-srom.c
>  create mode 100644 drivers/soc/samsung/exynos-srom.h
> 
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 76d6bd4..c3abfbe 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -1,6 +1,7 @@
>  menu "SOC (System On Chip) specific Drivers"
>  
>  source "drivers/soc/qcom/Kconfig"
> +source "drivers/soc/samsung/Kconfig"
>  source "drivers/soc/ti/Kconfig"
>  source "drivers/soc/versatile/Kconfig"
>  
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 063113d..620366f 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -3,6 +3,7 @@
>  #
>  
>  obj-$(CONFIG_ARCH_QCOM)		+= qcom/
> +obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
>  obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
>  obj-$(CONFIG_SOC_TI)		+= ti/
>  obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> new file mode 100644
> index 0000000..b6fa4e6
> --- /dev/null
> +++ b/drivers/soc/samsung/Kconfig
> @@ -0,0 +1,14 @@
> +#
> +# SAMSUNG SoC drivers
> +#
> +menu "Samsung SOC driver support"
> +
> +config SOC_SAMSUNG
> +	bool

Any reason for not using menuconfig?

> +
> +config EXYNOS_SROM
> +	bool
> +	depends on ARM && ARCH_EXYNOS
> +	select SOC_BUS

Why we need to select SOC_BUS?

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
> index 0000000..8aae762
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos-srom.c
> @@ -0,0 +1,142 @@
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
> +static unsigned long exynos_srom_offsets[] = {

static const

> +	/* SROM side */
> +	S5P_SROM_BW,
> +	S5P_SROM_BC0,
> +	S5P_SROM_BC1,
> +	S5P_SROM_BC2,
> +	S5P_SROM_BC3,
> +};
> +
> +/**
> + * struct exynos_srom_reg_dump: register dump of SROM Controller registers.
> + * @offset: srom register offset from the controller base address.
> + * @value: the value to be register at offset.

Maybe:
@value: the value of register under the offset

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
> +
> +	if (!exynos_srom_base)
> +		return PTR_ERR(exynos_srom_base);

This looks wrong. If this is NULL, do not convert it to ERR. What will
be the value of PTR_ERR(NULL)?

> +
> +	exynos_srom_regs = exynos_srom_alloc_reg_dump(exynos_srom_offsets,
> +			sizeof(exynos_srom_offsets));

if (NULL) then what? Have you tested the error paths in the probe?

> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
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
> +
> +static const struct dev_pm_ops exynos_srom_dev_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(exynos_srom_suspend, exynos_srom_resume)
> +};
> +
> +#define DEV_PM_OPS	(&exynos_srom_dev_pm_ops)
> +#else
> +#define DEV_PM_OPS	NULL
> +#endif /* CONFIG_PM_SLEEP */

That look like an old code. Please use SIMPLE_DEV_PM_OPS unless there is
a reason not to.

> +
> +static struct platform_driver exynos_srom_driver = {
> +	.probe = exynos_srom_probe,
> +	.driver = {
> +		.name = "exynos-srom",
> +		.of_match_table = of_exynos_srom_ids,
> +		.pm = DEV_PM_OPS,
> +	},
> +};
> +
> +static int __init exynos_srom_init(void)
> +{
> +	return platform_driver_register(&exynos_srom_driver);
> +}
> +device_initcall(exynos_srom_init);
> diff --git a/drivers/soc/samsung/exynos-srom.h b/drivers/soc/samsung/exynos-srom.h
> new file mode 100644
> index 0000000..e6ee438
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos-srom.h
> @@ -0,0 +1,51 @@
> +/*
> + * Copyright (c) 2015 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Exynos SROMC register definitions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __SAMSUNG_REGS_SROM_H
> +#define __SAMSUNG_REGS_SROM_H __FILE__

The double-inclusion protection looks different than file path and name.
Please make it similar.

> +#define S5P_SROMREG(x)		(x)
> +
> +#define S5P_SROM_BW		S5P_SROMREG(0x0)
> +#define S5P_SROM_BC0		S5P_SROMREG(0x4)
> +#define S5P_SROM_BC1		S5P_SROMREG(0x8)
> +#define S5P_SROM_BC2		S5P_SROMREG(0xc)
> +#define S5P_SROM_BC3		S5P_SROMREG(0x10)
> +#define S5P_SROM_BC4		S5P_SROMREG(0x14)
> +#define S5P_SROM_BC5		S5P_SROMREG(0x18)
> +
> +/* one register BW holds 4 x 4-bit packed settings for NCS0 - NCS3 */
> +
> +#define S5P_SROM_BW__DATAWIDTH__SHIFT		0
> +#define S5P_SROM_BW__ADDRMODE__SHIFT		1
> +#define S5P_SROM_BW__WAITENABLE__SHIFT		2
> +#define S5P_SROM_BW__BYTEENABLE__SHIFT		3
> +
> +#define S5P_SROM_BW__CS_MASK			0xf
> +
> +#define S5P_SROM_BW__NCS0__SHIFT		0
> +#define S5P_SROM_BW__NCS1__SHIFT		4
> +#define S5P_SROM_BW__NCS2__SHIFT		8
> +#define S5P_SROM_BW__NCS3__SHIFT		12
> +#define S5P_SROM_BW__NCS4__SHIFT		16
> +#define S5P_SROM_BW__NCS5__SHIFT		20
> +
> +/* applies to same to BCS0 - BCS3 */
> +
> +#define S5P_SROM_BCX__PMC__SHIFT		0
> +#define S5P_SROM_BCX__TACP__SHIFT		4
> +#define S5P_SROM_BCX__TCAH__SHIFT		8
> +#define S5P_SROM_BCX__TCOH__SHIFT		12
> +#define S5P_SROM_BCX__TACC__SHIFT		16
> +#define S5P_SROM_BCX__TCOS__SHIFT		24
> +#define S5P_SROM_BCX__TACS__SHIFT		28

s/S5P/EXYNOS/

> +
> +#endif /* __SAMSUNG_REGS_SROM_H */
> 
