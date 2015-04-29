From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 29 Apr 2015 10:23:48 +0100
Subject: [PATCH V7 5/9] mfd: Add driver for NVIDIA Tegra XUSB
In-Reply-To: <1430174242-29465-6-git-send-email-abrestic@chromium.org>
References: <1430174242-29465-1-git-send-email-abrestic@chromium.org>
 <1430174242-29465-6-git-send-email-abrestic@chromium.org>
Message-ID: <20150429092348.GQ9169@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Apr 2015, Andrew Bresticker wrote:

> Add an MFD driver for the XUSB host complex found on NVIDIA Tegra124
> and later SoCs.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
> New for v7.
> ---
>  drivers/mfd/Kconfig      |   7 ++
>  drivers/mfd/Makefile     |   1 +
>  drivers/mfd/tegra-xusb.c | 167 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/soc/tegra/xusb.h |  19 ++++++
>  4 files changed, 194 insertions(+)
>  create mode 100644 drivers/mfd/tegra-xusb.c
>  create mode 100644 include/soc/tegra/xusb.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index d5ad04d..61872b4 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1430,6 +1430,13 @@ config MFD_STW481X
>  	  in various ST Microelectronics and ST-Ericsson embedded
>  	  Nomadik series.
>  
> +config MFD_TEGRA_XUSB
> +	tristate "NVIDIA Tegra XUSB"
> +	depends on ARCH_TEGRA
> +	select MFD_CORE
> +	help
> +	  Support for the XUSB complex found on NVIDIA Tegra124 and later SoCs.
> +
>  menu "Multimedia Capabilities Port drivers"
>  	depends on ARCH_SA1100
>  
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 0e5cfeb..7588caf 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -181,6 +181,7 @@ obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
>  obj-$(CONFIG_MFD_DLN2)		+= dln2.o
>  obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
>  obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
> +obj-$(CONFIG_MFD_TEGRA_XUSB)	+= tegra-xusb.o
>  
>  intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
> diff --git a/drivers/mfd/tegra-xusb.c b/drivers/mfd/tegra-xusb.c
> new file mode 100644
> index 0000000..d30d259
> --- /dev/null
> +++ b/drivers/mfd/tegra-xusb.c
> @@ -0,0 +1,167 @@
> +/*
> + * NVIDIA Tegra XUSB MFD driver
> + *
> + * Copyright (C) 2015 Google, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mfd/core.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include <soc/tegra/xusb.h>
> +
> +struct tegra_xusb_soc_data {
> +	struct mfd_cell *devs;
> +	unsigned int num_devs;
> +};
> +
> +static struct resource tegra_xhci_resources[] = {
> +	{
> +		.name = "host",
> +		.flags = IORESOURCE_IRQ,
> +	},
> +	{
> +		.name = "xhci",
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
> +		.name = "ipfs",
> +		.flags = IORESOURCE_MEM,
> +	},
> +};
> +
> +static struct resource tegra_xusb_mbox_resources[] = {
> +	{
> +		.name = "smi",
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};

DEFINE_RES_IRQ_NAMED()

> +static struct mfd_cell tegra124_xusb_devs[] = {
> +	{
> +		.name = "tegra-xhci",
> +		.of_compatible = "nvidia,tegra124-xhci",
> +	},
> +	{
> +		.name = "tegra-xusb-mbox",
> +		.of_compatible = "nvidia,tegra124-xusb-mbox",
> +	},
> +};
> +
> +static const struct tegra_xusb_soc_data tegra124_xusb_data = {
> +	.devs = tegra124_xusb_devs,
> +	.num_devs = ARRAY_SIZE(tegra124_xusb_devs),
> +};
> +
> +static const struct of_device_id tegra_xusb_of_match[] = {
> +	{ .compatible = "nvidia,tegra124-xusb", .data = &tegra124_xusb_data },

Yuk!  Why are you mixing platform data and DT in this way?

Why can't you just stick all of this in DT?

> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, tegra_xusb_of_match);
> +static struct regmap_config tegra_fpci_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +static int tegra_xusb_probe(struct platform_device *pdev)
> +{
> +	const struct tegra_xusb_soc_data *soc;
> +	const struct of_device_id *match;
> +	struct tegra_xusb *xusb;
> +	struct resource *res;
> +	void __iomem *fpci_base;
> +	int irq, ret;
> +
> +	xusb = devm_kzalloc(&pdev->dev, sizeof(*xusb), GFP_KERNEL);
> +	if (!xusb)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, xusb);
> +
> +	match = of_match_node(tegra_xusb_of_match, pdev->dev.of_node);
> +	soc = match->data;
> +
> +	irq = platform_get_irq_byname(pdev, "host");
> +	if (irq < 0)
> +		return irq;
> +	tegra_xhci_resources[0].start = irq;
> +	tegra_xhci_resources[0].end = irq;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "xhci");
> +	if (!res)
> +		return -ENODEV;
> +	tegra_xhci_resources[1].start = res->start;
> +	tegra_xhci_resources[1].end = res->end;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ipfs");
> +	if (!res)
> +		return -ENODEV;
> +	tegra_xhci_resources[2].start = res->start;
> +	tegra_xhci_resources[2].end = res->end;
> +
> +	soc->devs[0].resources = tegra_xhci_resources;
> +	soc->devs[0].num_resources = ARRAY_SIZE(tegra_xhci_resources);
> +
> +	irq = platform_get_irq_byname(pdev, "smi");
> +	if (irq < 0)
> +		return irq;
> +	tegra_xusb_mbox_resources[0].start = irq;
> +	tegra_xusb_mbox_resources[0].end = irq;
> +
> +	soc->devs[1].resources = tegra_xusb_mbox_resources;
> +	soc->devs[1].num_resources = ARRAY_SIZE(tegra_xusb_mbox_resources);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fpci");
> +	fpci_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(fpci_base))
> +		return PTR_ERR(fpci_base);

This stuff is not good.

Either let MFD handle it with mfd_cells or stick all of this stuff in
DT and parse it from the child devices.

> +	tegra_fpci_regmap_config.max_register = res->end - res->start - 3;
> +	xusb->fpci_regs = devm_regmap_init_mmio(&pdev->dev, fpci_base,
> +						&tegra_fpci_regmap_config);
> +	if (IS_ERR(xusb->fpci_regs)) {
> +		ret = PTR_ERR(xusb->fpci_regs);
> +		dev_err(&pdev->dev, "Failed to init regmap: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = mfd_add_devices(&pdev->dev, -1, soc->devs, soc->num_devs,
> +			      NULL, 0, NULL);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to add MFD devices: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tegra_xusb_remove(struct platform_device *pdev)
> +{
> +	mfd_remove_devices(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver tegra_xusb_driver = {
> +	.probe = tegra_xusb_probe,
> +	.remove = tegra_xusb_remove,
> +	.driver = {
> +		.name = "tegra-xusb",
> +		.of_match_table = tegra_xusb_of_match,
> +	},
> +};
> +module_platform_driver(tegra_xusb_driver);
> +
> +MODULE_DESCRIPTION("NVIDIA Tegra XUSB MFD");
> +MODULE_AUTHOR("Andrew Bresticker <abrestic@chromium.org>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/soc/tegra/xusb.h b/include/soc/tegra/xusb.h
> new file mode 100644
> index 0000000..9d28d90
> --- /dev/null
> +++ b/include/soc/tegra/xusb.h
> @@ -0,0 +1,19 @@
> +/*
> + * Copyright (C) 2014 NVIDIA Corporation
> + * Copyright (C) 2014 Google, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + */
> +
> +#ifndef __SOC_TEGRA_XUSB_H__
> +#define __SOC_TEGRA_XUSB_H__
> +
> +struct regmap;
> +
> +struct tegra_xusb {
> +	struct regmap *fpci_regs;

Are you going to add to this?

> +};
> +
> +#endif /* __SOC_TEGRA_XUSB_H__ */

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
