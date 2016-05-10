From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 May 2016 12:26:22 +0100
Subject: [RFC PATCH 01/21] mfd: uniphier: add UniPhier MFD driver
In-Reply-To: <1462873862-30940-2-git-send-email-yamada.masahiro@socionext.com>
References: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
 <1462873862-30940-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160510112622.GL19473@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 May 2016, Masahiro Yamada wrote:

> This MFD driver populates child devices such clock, reset, and other
> system controlling blocks.
> 
> On UniPhier SoCs, one system control block contains various registers
> for clock, reset, and others in it.  So, it is not reasonable to have
> separate DT nodes for different sub-systems.
> 
> This MFD approach modifies Device Tree source just once for adding
> an MFD node.
> 
> This series is just for review.
> Please do not apply this patch.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  MAINTAINERS                |   1 +
>  drivers/mfd/Kconfig        |   9 ++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/uniphier-mfd.c | 214 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 225 insertions(+)
>  create mode 100644 drivers/mfd/uniphier-mfd.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 87b2ddd..8c987ca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1728,6 +1728,7 @@ F:	arch/arm/mm/cache-uniphier.c
>  F:	arch/arm64/boot/dts/socionext/
>  F:	drivers/bus/uniphier-system-bus.c
>  F:	drivers/i2c/busses/i2c-uniphier*
> +F:	drivers/mfd/uniphier-mfd.c
>  F:	drivers/mmc/host/uniphier-sd.c
>  F:	drivers/pinctrl/uniphier/
>  F:	drivers/tty/serial/8250/8250_uniphier.c
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index eea61e3..ea85862 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -892,6 +892,15 @@ config MFD_SKY81452
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called sky81452.
>  
> +config MFD_UNIPHIER
> +	tristate "Socionext UniPhier MFD"
> +	depends on ARCH_UNIPHIER || COMPILE_TEST
> +	default ARCH_UNIPHIER
> +	select MFD_CORE
> +	help
> +	  Support for the System Control Block, Media I/O Control Block,
> +	  Peripheral Control Block available on UniPhier SoCs.
> +
>  config MFD_SMSC
>         bool "SMSC ECE1099 series chips"
>         depends on I2C=y
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 5eaa6465d..5e8c20c 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -198,6 +198,7 @@ obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
>  obj-$(CONFIG_MFD_DLN2)		+= dln2.o
>  obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
>  obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
> +obj-$(CONFIG_MFD_UNIPHIER)	+= uniphier-mfd.o
>  
>  intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
>  intel-soc-pmic-$(CONFIG_INTEL_PMC_IPC)	+= intel_soc_pmic_bxtwc.o
> diff --git a/drivers/mfd/uniphier-mfd.c b/drivers/mfd/uniphier-mfd.c
> new file mode 100644
> index 0000000..7f01d64
> --- /dev/null
> +++ b/drivers/mfd/uniphier-mfd.c
> @@ -0,0 +1,214 @@
> +/*
> + * Copyright (C) 2016 Socionext Inc.
> + *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +static const struct mfd_cell uniphier_ld4_sysctrl_cells[] = {
> +	{ .name = "uniphier-ld4-clk" },
> +	{ .name = "uniphier-ld4-reset" },
> +	{ /* sentinel */ }
> +};
> +
> +static const struct mfd_cell uniphier_pro4_sysctrl_cells[] = {
> +	{ .name = "uniphier-pro4-clk" },
> +	{ .name = "uniphier-pro4-reset" },
> +	{ /* sentinel */ }
> +};
> +
> +static const struct mfd_cell uniphier_sld8_sysctrl_cells[] = {
> +	{ .name = "uniphier-sld8-clk" },
> +	{ .name = "uniphier-sld8-reset" },
> +	{ /* sentinel */ }
> +};
> +
> +static const struct mfd_cell uniphier_pro5_sysctrl_cells[] = {
> +	{ .name = "uniphier-pro5-clk" },
> +	{ .name = "uniphier-pro5-reset" },
> +	{ /* sentinel */ }
> +};
> +
> +static const struct mfd_cell uniphier_pxs2_sysctrl_cells[] = {
> +	{ .name = "uniphier-pxs2-clk" },
> +	{ .name = "uniphier-pxs2-reset" },
> +	{ /* sentinel */ }
> +};
> +
> +static const struct mfd_cell uniphier_ld11_sysctrl_cells[] = {
> +	{ .name = "uniphier-ld11-clk" },
> +	{ .name = "uniphier-ld11-reset" },
> +	{ /* sentinel */ }
> +};
> +
> +static const struct mfd_cell uniphier_ld20_sysctrl_cells[] = {
> +	{ .name = "uniphier-ld20-clk" },
> +	{ .name = "uniphier-ld20-reset" },
> +	{ /* sentinel */ }
> +};
> +
> +static const struct mfd_cell uniphier_ld4_mioctrl_cells[] = {
> +	{ .name = "uniphier-ld4-mio-clk" },
> +	{ .name = "uniphier-ld4-mio-reset" },
> +	{ /* sentinel */ }
> +};
> +
> +static const struct mfd_cell uniphier_pro5_mioctrl_cells[] = {
> +	{ .name = "uniphier-pro5-mio-clk" },
> +	{ .name = "uniphier-pro5-mio-reset" },
> +	{ /* sentinel */ }
> +};
> +
> +static const struct mfd_cell uniphier_ld4_perictrl_cells[] = {
> +	{ .name = "uniphier-ld4-peri-clk" },
> +	{ .name = "uniphier-ld4-peri-reset" },
> +	{ /* sentinel */ }
> +};
> +
> +static const struct mfd_cell uniphier_pro4_perictrl_cells[] = {
> +	{ .name = "uniphier-pro4-peri-clk" },
> +	{ .name = "uniphier-pro4-peri-reset" },
> +	{ /* sentinel */ }
> +};
> +
> +static const struct of_device_id uniphier_mfd_match[] = {
> +	/* System Control */
> +	{
> +		.compatible = "socionext,uniphier-ld4-sysctrl",
> +		.data = uniphier_ld4_sysctrl_cells,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-pro4-sysctrl",
> +		.data = uniphier_pro4_sysctrl_cells,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-sld8-sysctrl",
> +		.data = uniphier_sld8_sysctrl_cells,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-pro5-sysctrl",
> +		.data = uniphier_pro5_sysctrl_cells,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-pxs2-sysctrl",
> +		.data = uniphier_pxs2_sysctrl_cells,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-ld11-sysctrl",
> +		.data = uniphier_ld11_sysctrl_cells,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-ld20-sysctrl",
> +		.data = uniphier_ld20_sysctrl_cells,
> +	},
> +	/* Media I/O */
> +	{
> +		.compatible = "socionext,uniphier-ld4-mioctrl",
> +		.data = uniphier_ld4_mioctrl_cells,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-pro4-mioctrl",
> +		.data = uniphier_ld4_mioctrl_cells,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-sld8-mioctrl",
> +		.data = uniphier_ld4_mioctrl_cells,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-pro5-mioctrl",
> +		.data = uniphier_pro5_mioctrl_cells,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-pxs2-mioctrl",
> +		.data = uniphier_pro5_mioctrl_cells,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-ld11-mioctrl",
> +		.data = uniphier_ld4_mioctrl_cells,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-ld20-mioctrl",
> +		.data = uniphier_pro5_mioctrl_cells,
> +	},
> +	/* Peripheral Control */
> +	{
> +		.compatible = "socionext,uniphier-ld4-perictrl",
> +		.data = uniphier_ld4_perictrl_cells,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-sld8-perictrl",
> +		.data = uniphier_ld4_perictrl_cells,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-pro4-perictrl",
> +		.data = uniphier_pro4_perictrl_cells,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-pro5-perictrl",
> +		.data = uniphier_pro4_perictrl_cells,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-pxs2-perictrl",
> +		.data = uniphier_pro4_perictrl_cells,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-ld11-perictrl",
> +		.data = uniphier_pro4_perictrl_cells,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-ld20-perictrl",
> +		.data = uniphier_pro4_perictrl_cells,
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, uniphier_mfd_match);

NACK.  Please do not mix MFD and DT registration.

> +static int uniphier_mfd_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +	const struct mfd_cell *cell;
> +	int ret;
> +	int n_cells = 0;
> +
> +	match = of_match_node(uniphier_mfd_match, pdev->dev.of_node);
> +	if (!match)
> +		return -ENODEV;
> +
> +	cell = match->data;
> +
> +	for (; cell->name; cell++)
> +		n_cells++;
> +
> +	ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, match->data,
> +			      n_cells, NULL, 0, NULL);
> +	if (ret)
> +		dev_err(&pdev->dev, "failed to add MFD devices\n");
> +
> +	return ret;
> +}

This driver is not required.

I think you just need to use "simple-mfd".

> +static struct platform_driver uniphier_mfd_driver = {
> +	.probe = uniphier_mfd_probe,
> +	.driver = {
> +		.name = "uniphier-mfd",
> +		.of_match_table = uniphier_mfd_match,
> +	},
> +};
> +module_platform_driver(uniphier_mfd_driver);
> +
> +MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
> +MODULE_DESCRIPTION("UniPhier SoC MFD Driver");
> +MODULE_LICENSE("GPL");

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
