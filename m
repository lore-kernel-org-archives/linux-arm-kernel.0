From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 18 Oct 2016 23:49:53 +0300
Subject: [PATCH 2/3] ARM: bus: da8xx-syscfg: new driver
In-Reply-To: <1476721850-454-3-git-send-email-bgolaszewski@baylibre.com>
References: <1476721850-454-1-git-send-email-bgolaszewski@baylibre.com>
 <1476721850-454-3-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <4369153.vCOQzI7OET@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

Thank you for the patch.

On Monday 17 Oct 2016 18:30:49 Bartosz Golaszewski wrote:
> Create the driver for the da8xx System Configuration and implement
> support for writing to the three Master Priority registers.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../devicetree/bindings/bus/ti,da850-syscfg.txt    |  63 +++++++
>  drivers/bus/Kconfig                                |   8 +
>  drivers/bus/Makefile                               |   2 +
>  drivers/bus/da8xx-syscfg.c                         | 206 ++++++++++++++++++
>  4 files changed, 279 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/bus/ti,da850-syscfg.txt create mode
> 100644 drivers/bus/da8xx-syscfg.c
> 
> diff --git a/Documentation/devicetree/bindings/bus/ti,da850-syscfg.txt
> b/Documentation/devicetree/bindings/bus/ti,da850-syscfg.txt new file mode
> 100644
> index 0000000..07e5c38
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/ti,da850-syscfg.txt
> @@ -0,0 +1,63 @@
> +* Device tree bindings for Texas Instruments da8xx system configuration
> driver
> +
> +The system configuration (SYSCFG) module is a system-level module
> containing
> +status and top level control logic required by the device. The system
> +configuration module consists of a set of memory-mapped status and control
> +registers, accessible by the CPU, supporting all of the following system
> +features, and miscellaneous functions and operations.
> +
> +Documentation:
> +OMAP-L138 (DA850) - http://www.ti.com/lit/ug/spruh82c/spruh82c.pdf
> +
> +Required properties:
> +
> +- compatible:		"ti,da850-syscfg"

Don't you need a reg property ?

> +Optional properties:
> +
> +The below properties are used to specify the priority of master
> peripherals.
> +They must be between 0-7 where 0 is the highest priority and 7 is the
> lowest.
> +
> +- ti,pri-arm-i:		ARM_I port priority.
> +
> +- ti,pri-arm-d:		ARM_D port priority.
> +
> +- ti,pri-upp:		uPP port priority.
> +
> +- ti,pri-sata:		SATA port priority.
> +
> +- ti,pri-pru0:		PRU0 port priority.
> +
> +- ti,pri-pru1:		PRU1 port priority.
> +
> +- ti,pri-edma30tc0:	EDMA3_0_TC0 port priority.
> +
> +- ti,pri-edma30tc1:	EDMA3_0_TC1 port priority.
> +
> +- ti,pri-edma31tc0:	EDMA3_1_TC0 port priority.
> +
> +- ti,pri-vpif-dma-0:	VPIF DMA0 port priority.
> +
> +- ti,pri-vpif-dma-1:	VPIF DMA1 port priority.
> +
> +- ti,pri-emac:		EMAC port priority.
> +
> +- ti,pri-usb0cfg:	USB0 CFG port priority.
> +
> +- ti,pri-usb0cdma:	USB0 CDMA port priority.
> +
> +- ti,pri-uhpi:		HPI port priority.
> +
> +- ti,pri-usb1:		USB1 port priority.
> +
> +- ti,pri-lcdc:		LCDC port priority.

I'm afraid this looks more like system configuration than hardware description 
to me.

There was a BoF session about how to support this kind of performance knobs at 
ELCE last week: https://openiotelceurope2016.sched.org/event/7rss/bof-linux-device-performance-framework-michael-turquette-baylibre :-)

> +If any of the above properties is absent, the default value will be used as
> +defined in the documentation.
> +
> +Example for da850-lcdk is shown below.
> +
> +mstpri {
> +	compatible = "ti,da850-mstpri";
> +	ti,pri-lcdc = 0;
> +};
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 5a2d47c..6276132 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -165,4 +165,12 @@ config VEXPRESS_CONFIG
>  	help
>  	  Platform configuration infrastructure for the ARM Ltd.
>  	  Versatile Express.
> +
> +config DA8XX_SYSCFG
> +	bool "TI da8xx system configuration driver"
> +	depends on ARCH_DAVINCI_DA8XX
> +	help
> +	  Driver for Texas Instruments da8xx system configuration. Allows to
> +	  adjust various SoC configuration options.
> +
>  endmenu
> diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
> index c6cfa6b..3cba66a 100644
> --- a/drivers/bus/Makefile
> +++ b/drivers/bus/Makefile
> @@ -21,3 +21,5 @@ obj-$(CONFIG_SIMPLE_PM_BUS)	+= simple-pm-bus.o
>  obj-$(CONFIG_TEGRA_ACONNECT)	+= tegra-aconnect.o
>  obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
>  obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
> +
> +obj-$(CONFIG_DA8XX_SYSCFG)	+= da8xx-syscfg.o
> diff --git a/drivers/bus/da8xx-syscfg.c b/drivers/bus/da8xx-syscfg.c
> new file mode 100644
> index 0000000..8a2cb4f
> --- /dev/null
> +++ b/drivers/bus/da8xx-syscfg.c
> @@ -0,0 +1,206 @@
> +/*
> + * TI da8xx System Configuration driver
> + *
> + * Copyright (C) 2016 BayLibre SAS
> + *
> + * Author:
> + *   Bartosz Golaszewski <bgolaszewski@baylibre.com.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +
> +#define DA8XX_IO_PHYS			0x01c00000ul
> +#define DA8XX_SYSCFG0_BASE		(DA8XX_IO_PHYS + 0x14000)
> +
> +#define DA8XX_MSTPRI0_REG		0x110
> +#define DA8XX_MSTPRI1_REG		0x114
> +#define DA8XX_MSTPRI2_REG		0x118
> +
> +#define DA8XX_MSTPRI_MAX		7
> +
> +struct da8xx_mstpri_descr {
> +	const char *property;
> +	int reg;
> +	int shift;
> +	int mask;
> +};
> +
> +static const struct da8xx_mstpri_descr priorities[] = {
> +	{
> +		.property = "ti,pri-arm-i",
> +		.reg = DA8XX_MSTPRI0_REG,
> +		.shift = 0,
> +		.mask = 0xfffffff0,
> +	},
> +	{
> +		.property = "ti,pri-arm-d",
> +		.reg = DA8XX_MSTPRI0_REG,
> +		.shift = 4,
> +		.mask = 0xffffff0f,
> +	},
> +	{
> +		.property = "ti,pri-upp",
> +		.reg = DA8XX_MSTPRI0_REG,
> +		.shift = 16,
> +		.mask = 0xfff0ffff,
> +	},
> +	{
> +		.property = "ti,pri-sata",
> +		.reg = DA8XX_MSTPRI0_REG,
> +		.shift = 20,
> +		.mask = 0xff0fffff,
> +	},
> +	{
> +		.property = "ti,pri-pru0",
> +		.reg = DA8XX_MSTPRI1_REG,
> +		.shift = 0,
> +		.mask = 0xfffffff0,
> +	},
> +	{
> +		.property = "ti,pri-pru1",
> +		.reg = DA8XX_MSTPRI1_REG,
> +		.shift = 4,
> +		.mask = 0xffffff0f,
> +	},
> +	{
> +		.property = "ti,pri-edma30tc0",
> +		.reg = DA8XX_MSTPRI1_REG,
> +		.shift = 8,
> +		.mask = 0xfffff0ff,
> +	},
> +	{
> +		.property = "ti,pri-edma30tc1",
> +		.reg = DA8XX_MSTPRI1_REG,
> +		.shift = 12,
> +		.mask = 0xffff0fff,
> +	},
> +	{
> +		.property = "ti,pri-edma31tc0",
> +		.reg = DA8XX_MSTPRI1_REG,
> +		.shift = 16,
> +		.mask = 0xfff0ffff,
> +	},
> +	{
> +		.property = "ti,pri-vpif-dma-0",
> +		.reg = DA8XX_MSTPRI1_REG,
> +		.shift = 24,
> +		.mask = 0xf0ffffff,
> +	},
> +	{
> +		.property = "ti,pri-vpif-dma-1",
> +		.reg = DA8XX_MSTPRI1_REG,
> +		.shift = 28,
> +		.mask = 0x0fffffff,
> +	},
> +	{
> +		.property = "ti,pri-emac",
> +		.reg = DA8XX_MSTPRI2_REG,
> +		.shift = 0,
> +		.mask = 0xfffffff0,
> +	},
> +	{
> +		.property = "ti,pri-usb0cfg",
> +		.reg = DA8XX_MSTPRI2_REG,
> +		.shift = 8,
> +		.mask = 0xfffff0ff,
> +	},
> +	{
> +		.property = "ti,pri-usb0cdma",
> +		.reg = DA8XX_MSTPRI2_REG,
> +		.shift = 12,
> +		.mask = 0xffff0fff,
> +	},
> +	{
> +		.property = "ti,pri-uhpi",
> +		.reg = DA8XX_MSTPRI2_REG,
> +		.shift = 20,
> +		.mask = 0xff0fffff,
> +	},
> +	{
> +		.property = "ti,pri-usb1",
> +		.reg = DA8XX_MSTPRI2_REG,
> +		.shift = 24,
> +		.mask = 0xf0ffffff,
> +	},
> +	{
> +		.property = "ti,pri-lcdc",
> +		.reg = DA8XX_MSTPRI2_REG,
> +		.shift = 28,
> +		.mask = 0x0fffffff,
> +	},
> +};
> +
> +static void da8xx_syscfg_set_mstpri(void __iomem *syscfg0, struct device
> *dev) +{
> +	const struct da8xx_mstpri_descr *pri_descr;
> +	struct device_node *node = dev->of_node;
> +	void __iomem *mstpri;
> +	u32 old_pri, new_pri;
> +	int ret, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(priorities); i++) {
> +		pri_descr = &priorities[i];
> +
> +		ret = of_property_read_u32(node, pri_descr->property, 
&new_pri);
> +		if (ret)
> +			continue;
> +
> +		if (new_pri > DA8XX_MSTPRI_MAX) {
> +			dev_warn(dev,
> +				 "omitting property '%s' - value too high\n",
> +				 pri_descr->property);
> +			continue;
> +		}
> +
> +		mstpri = syscfg0 + pri_descr->reg;
> +		old_pri = __raw_readl(mstpri);
> +		old_pri &= pri_descr->mask;
> +		new_pri <<= pri_descr->shift;
> +		new_pri |= old_pri;
> +
> +		__raw_writel(new_pri, mstpri);
> +	}
> +}
> +
> +static int da8xx_syscfg_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	void __iomem *syscfg0;
> +
> +	syscfg0 = ioremap(DA8XX_SYSCFG0_BASE, SZ_4K);
> +	if (!syscfg0) {
> +		dev_err(dev, "unable to map syscfg0\n");
> +		return -EIO;
> +	}
> +
> +	da8xx_syscfg_set_mstpri(syscfg0, dev);
> +
> +	iounmap(syscfg0);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id da8xx_syscfg_of_match[] = {
> +	{ .compatible = "ti,da850-syscfg", },
> +	{ },
> +};
> +
> +static struct platform_driver da8xx_syscfg_driver = {
> +	.probe = da8xx_syscfg_probe,
> +	.driver = {
> +		.name = "da8xx-syscfg",
> +		.of_match_table = da8xx_syscfg_of_match,
> +	},
> +};
> +module_platform_driver(da8xx_syscfg_driver);
> +
> +MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
> +MODULE_DESCRIPTION("TI da8xx System Configuration driver");
> +MODULE_LICENSE("GPL v2");

-- 
Regards,

Laurent Pinchart
