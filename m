From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 20 Oct 2015 09:10:43 +0900
Subject: [PATCH v4 6/8] drivers: soc: add support for exynos SROM driver
In-Reply-To: <1445255206-11148-7-git-send-email-pankaj.dubey@samsung.com>
References: <1445255206-11148-1-git-send-email-pankaj.dubey@samsung.com>
 <1445255206-11148-7-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <56258683.7070204@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.10.2015 20:46, Pankaj Dubey wrote:
> This patch adds Exynos SROM controller driver which will handle
> save restore of SROM registers during S2R.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  drivers/soc/Kconfig               |   1 +
>  drivers/soc/Makefile              |   1 +
>  drivers/soc/samsung/Kconfig       |  13 +++
>  drivers/soc/samsung/Makefile      |   1 +
>  drivers/soc/samsung/exynos-srom.c | 179 ++++++++++++++++++++++++++++++++++++++
>  drivers/soc/samsung/exynos-srom.h |  51 +++++++++++
>  6 files changed, 246 insertions(+)
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
> index 0b12d77..a623616 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -5,6 +5,7 @@
>  obj-$(CONFIG_MACH_DOVE)		+= dove/
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

When !PM then the driver will... do nothing, right? So maybe make it
depending on PM so tiny configs would benefit?


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
> index 0000000..e89d455
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos-srom.c
> @@ -0,0 +1,179 @@
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
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "exynos-srom.h"
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
> +/**
> + * struct exynos_srom: platform data for exynos srom controller driver.
> + * @dev: platform device pointer
> + * @reg_base: srom base address
> + * @reg_offset: exynos_srom_reg_dump pointer to hold offset and its value.
> + */
> +struct exynos_srom {
> +	struct device *dev;
> +	void __iomem *reg_base;
> +	struct exynos_srom_reg_dump *reg_offset;
> +};
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
> +static int exynos_srom_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np;
> +	struct exynos_srom *srom;
> +	struct device *dev = &pdev->dev;
> +
> +	np = dev->of_node;
> +	if (!np) {
> +		dev_err(&pdev->dev, "could not find device info\n");
> +		return -EINVAL;
> +	}
> +
> +	srom = devm_kzalloc(&pdev->dev,
> +			sizeof(struct exynos_srom), GFP_KERNEL);
> +	if (!srom)
> +		return -ENOMEM;
> +
> +	srom->dev = dev;
> +	srom->reg_base = of_iomap(np, 0);
> +	if (!srom->reg_base) {
> +		dev_err(&pdev->dev, "iomap of exynos srom controller failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	platform_set_drvdata(pdev, srom);
> +
> +	srom->reg_offset = exynos_srom_alloc_reg_dump(exynos_srom_offsets,
> +			sizeof(exynos_srom_offsets));
> +	if (!srom->reg_offset) {
> +		iounmap(srom->reg_base);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int exynos_srom_remove(struct platform_device *pdev)
> +{
> +	struct exynos_srom *srom = platform_get_drvdata(pdev);
> +
> +	kfree(srom->reg_offset);
> +	iounmap(srom->reg_base);
> +	srom->reg_base = NULL;
> +	srom->reg_offset = NULL;

There is no need anymore for these two NULL-s. It made sense only in
previous code when these were global variables. At this point the device
callbacks cannot be accessed so NULL-ifying does not change anything.

Rest from my point of view looks good.

Best regards,
Krzysztof
