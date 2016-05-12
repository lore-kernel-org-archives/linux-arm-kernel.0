From: gnurou@gmail.com (Alexandre Courbot)
Date: Thu, 12 May 2016 19:30:05 +0900
Subject: [PATCH v9 2/2] gpio: move clps711x, moxart,
 ts4800 and gpio-ge =?iso-8859-1?Q?into_gpio-mmio?=
In-Reply-To: <85c74586dbd0023306f012764b85d6aa168b4ae7.1462911225.git.chunkeey@googlemail.com>
References: <cover.1462911225.git.chunkeey@googlemail.com>
 <cover.1462911225.git.chunkeey@googlemail.com>
 <85c74586dbd0023306f012764b85d6aa168b4ae7.1462911225.git.chunkeey@googlemail.com>
Message-ID: <3c67e0ca-43eb-4a77-90ef-f8e2757c8edd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, May 11, 2016 6:34:35 PM JST, Christian Lamparter wrote:
> This patch integrates the GPIO drivers for the following
> boards, SoCs, etc. into gpio-mmio:
>  - CLPS711X SoCs
>  - MOXA ART SoC
>  - TS-4800 FPGA DIO blocks and compatibles
>  - GPIO controllers found on some GE Single Board Computers
>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Julien Grossholtz <julien.grossholtz@savoirfairelinux.com>
> Cc: Martyn Welch <martyn.welch@ge.com>
> Cc: Jonas Jensen <jonas.jensen@gmail.com>
> Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
> ---
>  drivers/gpio/Kconfig         |  16 +++-
>  drivers/gpio/Makefile        |   4 -
>  drivers/gpio/gpio-clps711x.c |  91 -------------------
>  drivers/gpio/gpio-ge.c       | 114 -----------------------
>  drivers/gpio/gpio-mmio.c     | 212 
> +++++++++++++++++++++++++++++++++++++++++++
>  drivers/gpio/gpio-moxart.c   |  84 -----------------
>  drivers/gpio/gpio-ts4800.c   |  81 -----------------
>  7 files changed, 224 insertions(+), 378 deletions(-)
>  delete mode 100644 drivers/gpio/gpio-clps711x.c
>  delete mode 100644 drivers/gpio/gpio-ge.c
>  delete mode 100644 drivers/gpio/gpio-moxart.c
>  delete mode 100644 drivers/gpio/gpio-ts4800.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index a68d838..e4d1065 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -154,7 +154,7 @@ config GPIO_BRCMSTB
>  config GPIO_CLPS711X
>  	tristate "CLPS711X GPIO support"
>  	depends on ARCH_CLPS711X || COMPILE_TEST
> -	select GPIO_GENERIC
> +	select GPIO_GENERIC_PLATFORM
>  	help
>  	  Say yes here to support GPIO on CLPS711X SoCs.
>  
> @@ -196,7 +196,7 @@ config GPIO_ETRAXFS
>  config GPIO_GE_FPGA
>  	bool "GE FPGA based GPIO"
>  	depends on GE_FPGA
> -	select GPIO_GENERIC
> +	select GPIO_GENERIC_PLATFORM
>  	help
>  	  Support for common GPIO functionality provided on some GE Single Board
>  	  Computers.
> @@ -209,6 +209,14 @@ config GPIO_GENERIC_PLATFORM
>  	tristate "Generic memory-mapped GPIO controller support (MMIO 
> platform device)"
>  	select GPIO_GENERIC
>  	help
> +	  Select this to support many generic memory-mapped GPIO controllers.
> +
> +	  This driver also includes support for the following GPIOs:
> +	    CLPS711X SoCs
> +	    MOXA ART SoC
> +	    TS-4800 FPGA DIO blocks and compatibles.
> +	    GPIOs found on some GE Single Board Computers.
> +
>  	  Say yes here to support basic platform_device memory-mapped 
> GPIO controllers.
>  
>  config GPIO_GRGPIO
> @@ -288,7 +296,7 @@ config GPIO_MM_LANTIQ
>  config GPIO_MOXART
>  	bool "MOXART GPIO support"
>  	depends on ARCH_MOXART || COMPILE_TEST
> -	select GPIO_GENERIC
> +	select GPIO_GENERIC_PLATFORM
>  	help
>  	  Select this option to enable GPIO driver for
>  	  MOXA ART SoC devices.
> @@ -408,7 +416,7 @@ config GPIO_TS4800
>  	tristate "TS-4800 DIO blocks and compatibles"
>  	depends on OF_GPIO
>  	depends on SOC_IMX51 || COMPILE_TEST
> -	select GPIO_GENERIC
> +	select GPIO_GENERIC_PLATFORM
>  	help
>  	  This driver support TS-4800 FPGA GPIO controllers.
>  
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 991598e..d8d63ae 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -31,7 +31,6 @@ obj-$(CONFIG_GPIO_ATH79)	+= gpio-ath79.o
>  obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
>  obj-$(CONFIG_GPIO_BRCMSTB)	+= gpio-brcmstb.o
>  obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
> -obj-$(CONFIG_GPIO_CLPS711X)	+= gpio-clps711x.o
>  obj-$(CONFIG_GPIO_CS5535)	+= gpio-cs5535.o
>  obj-$(CONFIG_GPIO_CRYSTAL_COVE)	+= gpio-crystalcove.o
>  obj-$(CONFIG_GPIO_DA9052)	+= gpio-da9052.o
> @@ -43,7 +42,6 @@ obj-$(CONFIG_GPIO_EM)		+= gpio-em.o
>  obj-$(CONFIG_GPIO_EP93XX)	+= gpio-ep93xx.o
>  obj-$(CONFIG_GPIO_ETRAXFS)	+= gpio-etraxfs.o
>  obj-$(CONFIG_GPIO_F7188X)	+= gpio-f7188x.o
> -obj-$(CONFIG_GPIO_GE_FPGA)	+= gpio-ge.o
>  obj-$(CONFIG_GPIO_GRGPIO)	+= gpio-grgpio.o
>  obj-$(CONFIG_GPIO_ICH)		+= gpio-ich.o
>  obj-$(CONFIG_GPIO_IOP)		+= gpio-iop.o
> @@ -68,7 +66,6 @@ obj-$(CONFIG_GPIO_MC9S08DZ60)	+= gpio-mc9s08dz60.o
>  obj-$(CONFIG_GPIO_MCP23S08)	+= gpio-mcp23s08.o
>  obj-$(CONFIG_GPIO_ML_IOH)	+= gpio-ml-ioh.o
>  obj-$(CONFIG_GPIO_MM_LANTIQ)	+= gpio-mm-lantiq.o
> -obj-$(CONFIG_GPIO_MOXART)	+= gpio-moxart.o
>  obj-$(CONFIG_GPIO_MPC5200)	+= gpio-mpc5200.o
>  obj-$(CONFIG_GPIO_MPC8XXX)	+= gpio-mpc8xxx.o
>  obj-$(CONFIG_GPIO_MSIC)		+= gpio-msic.o
> @@ -107,7 +104,6 @@ obj-$(CONFIG_GPIO_TPS65218)	+= gpio-tps65218.o
>  obj-$(CONFIG_GPIO_TPS6586X)	+= gpio-tps6586x.o
>  obj-$(CONFIG_GPIO_TPS65910)	+= gpio-tps65910.o
>  obj-$(CONFIG_GPIO_TPS65912)	+= gpio-tps65912.o
> -obj-$(CONFIG_GPIO_TS4800)	+= gpio-ts4800.o
>  obj-$(CONFIG_GPIO_TS5500)	+= gpio-ts5500.o
>  obj-$(CONFIG_GPIO_TWL4030)	+= gpio-twl4030.o
>  obj-$(CONFIG_GPIO_TWL6040)	+= gpio-twl6040.o
> diff --git a/drivers/gpio/gpio-clps711x.c b/drivers/gpio/gpio-clps711x.c
> deleted file mode 100644
> index 5a69025..0000000
> --- a/drivers/gpio/gpio-clps711x.c
> +++ /dev/null
> @@ -1,91 +0,0 @@
> -/*
> - *  CLPS711X GPIO driver
> - *
> - *  Copyright (C) 2012,2013 Alexander Shiyan <shc_work@mail.ru>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - */
> -
> -#include <linux/err.h>
> -#include <linux/module.h>
> -#include <linux/gpio/driver.h>
> -#include <linux/platform_device.h>
> -
> -static int clps711x_gpio_probe(struct platform_device *pdev)
> -{
> -	struct device_node *np = pdev->dev.of_node;
> -	void __iomem *dat, *dir;
> -	struct gpio_chip *gc;
> -	struct resource *res;
> -	int err, id = np ? of_alias_get_id(np, "gpio") : pdev->id;
> -
> -	if ((id < 0) || (id > 4))
> -		return -ENODEV;
> -
> -	gc = devm_kzalloc(&pdev->dev, sizeof(*gc), GFP_KERNEL);
> -	if (!gc)
> -		return -ENOMEM;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	dat = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(dat))
> -		return PTR_ERR(dat);
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	dir = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(dir))
> -		return PTR_ERR(dir);
> -
> -	switch (id) {
> -	case 3:
> -		/* PORTD is inverted logic for direction register */
> -		err = bgpio_init(gc, &pdev->dev, 1, dat, NULL, NULL,
> -				 NULL, dir, 0);
> -		break;
> -	default:
> -		err = bgpio_init(gc, &pdev->dev, 1, dat, NULL, NULL,
> -				 dir, NULL, 0);
> -		break;
> -	}
> -
> -	if (err)
> -		return err;
> -
> -	switch (id) {
> -	case 4:
> -		/* PORTE is 3 lines only */
> -		gc->ngpio = 3;
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	gc->base = id * 8;
> -	gc->owner = THIS_MODULE;
> -	platform_set_drvdata(pdev, gc);
> -
> -	return devm_gpiochip_add_data(&pdev->dev, gc, NULL);
> -}
> -
> -static const struct of_device_id __maybe_unused clps711x_gpio_ids[] = {
> -	{ .compatible = "cirrus,clps711x-gpio" },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, clps711x_gpio_ids);
> -
> -static struct platform_driver clps711x_gpio_driver = {
> -	.driver	= {
> -		.name		= "clps711x-gpio",
> -		.of_match_table	= of_match_ptr(clps711x_gpio_ids),
> -	},
> -	.probe	= clps711x_gpio_probe,
> -};
> -module_platform_driver(clps711x_gpio_driver);
> -
> -MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
> -MODULE_DESCRIPTION("CLPS711X GPIO driver");
> -MODULE_ALIAS("platform:clps711x-gpio");
> diff --git a/drivers/gpio/gpio-ge.c b/drivers/gpio/gpio-ge.c
> deleted file mode 100644
> index 8650b29..0000000
> --- a/drivers/gpio/gpio-ge.c
> +++ /dev/null
> @@ -1,114 +0,0 @@
> -/*
> - * Driver for GE FPGA based GPIO
> - *
> - * Author: Martyn Welch <martyn.welch@ge.com>
> - *
> - * 2008 (c) GE Intelligent Platforms Embedded Systems, Inc.
> - *
> - * This file is licensed under the terms of the GNU General Public License
> - * version 2.  This program is licensed "as is" without any warranty of any
> - * kind, whether express or implied.
> - */
> -
> -/* TODO
> - *
> - * Configuration of output modes (totem-pole/open-drain)
> - * Interrupt configuration - interrupts are always generated 
> the FPGA relies on
> - * the I/O interrupt controllers mask to stop them propergating
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/io.h>
> -#include <linux/slab.h>
> -#include <linux/of_device.h>
> -#include <linux/of_gpio.h>
> -#include <linux/of_address.h>
> -#include <linux/module.h>
> -#include <linux/gpio/driver.h>
> -
> -#define GEF_GPIO_DIRECT		0x00
> -#define GEF_GPIO_IN		0x04
> -#define GEF_GPIO_OUT		0x08
> -#define GEF_GPIO_TRIG		0x0C
> -#define GEF_GPIO_POLAR_A	0x10
> -#define GEF_GPIO_POLAR_B	0x14
> -#define GEF_GPIO_INT_STAT	0x18
> -#define GEF_GPIO_OVERRUN	0x1C
> -#define GEF_GPIO_MODE		0x20
> -
> -static const struct of_device_id gef_gpio_ids[] = {
> -	{
> -		.compatible	= "gef,sbc610-gpio",
> -		.data		= (void *)19,
> -	}, {
> -		.compatible	= "gef,sbc310-gpio",
> -		.data		= (void *)6,
> -	}, {
> -		.compatible	= "ge,imp3a-gpio",
> -		.data		= (void *)16,
> -	},
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, gef_gpio_ids);
> -
> -static int __init gef_gpio_probe(struct platform_device *pdev)
> -{
> -	const struct of_device_id *of_id =
> -		of_match_device(gef_gpio_ids, &pdev->dev);
> -	struct gpio_chip *gc;
> -	void __iomem *regs;
> -	int ret;
> -
> -	gc = devm_kzalloc(&pdev->dev, sizeof(*gc), GFP_KERNEL);
> -	if (!gc)
> -		return -ENOMEM;
> -
> -	regs = of_iomap(pdev->dev.of_node, 0);
> -	if (!regs)
> -		return -ENOMEM;
> -
> -	ret = bgpio_init(gc, &pdev->dev, 4, regs + GEF_GPIO_IN,
> -			 regs + GEF_GPIO_OUT, NULL, NULL,
> -			 regs + GEF_GPIO_DIRECT, BGPIOF_BIG_ENDIAN_BYTE_ORDER);
> -	if (ret) {
> -		dev_err(&pdev->dev, "bgpio_init failed\n");
> -		goto err0;
> -	}
> -
> -	/* Setup pointers to chip functions */
> -	gc->label = devm_kstrdup(&pdev->dev, pdev->dev.of_node->full_name,
> -				     GFP_KERNEL);
> -	if (!gc->label) {
> -		ret = -ENOMEM;
> -		goto err0;
> -	}
> -
> -	gc->base = -1;
> -	gc->ngpio = (u16)(uintptr_t)of_id->data;
> -	gc->of_gpio_n_cells = 2;
> -	gc->of_node = pdev->dev.of_node;
> -
> -	/* This function adds a memory mapped GPIO chip */
> -	ret = devm_gpiochip_add_data(&pdev->dev, gc, NULL);
> -	if (ret)
> -		goto err0;
> -
> -	return 0;
> -err0:
> -	iounmap(regs);
> -	pr_err("%s: GPIO chip registration failed\n",
> -			pdev->dev.of_node->full_name);
> -	return ret;
> -};
> -
> -static struct platform_driver gef_gpio_driver = {
> -	.driver = {
> -		.name		= "gef-gpio",
> -		.of_match_table	= gef_gpio_ids,
> -	},
> -};
> -module_platform_driver_probe(gef_gpio_driver, gef_gpio_probe);
> -
> -MODULE_DESCRIPTION("GE I/O FPGA GPIO driver");
> -MODULE_AUTHOR("Martyn Welch <martyn.welch@ge.com");
> -MODULE_LICENSE("GPL");
> diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
> index f72e40e..1de9172 100644
> --- a/drivers/gpio/gpio-mmio.c
> +++ b/drivers/gpio/gpio-mmio.c
> @@ -586,8 +586,220 @@ static int 
> bgpio_basic_mmio_parse_dt(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static int clps711x_parse_dt(struct platform_device *pdev,
> +			     struct bgpio_pdata *pdata,
> +			     unsigned long *flags)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct resource *res;
> +	const char *dir_reg_name;
> +	int id = np ? of_alias_get_id(np, "gpio") : pdev->id;
> +
> +	switch (id) {
> +	case 0:
> +	case 1:
> +	case 2:
> +		pdata->ngpio = 0; /* determined by register width */
> +		dir_reg_name = "dirout";
> +		break;
> +	case 3:
> +		pdata->ngpio = 0; /* determined by register width */
> +		/* PORTD is inverted logic for direction register */
> +		dir_reg_name = "dirin";
> +		break;
> +	case 4:
> +		pdata->ngpio = 3; /* PORTE is 3 lines only */
> +		dir_reg_name = "dirout";
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	pdata->base = id * 8;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +	if (!res->name || strcmp("dat", res->name))
> +		res->name = devm_kstrdup(&pdev->dev, "dat", GFP_KERNEL);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res)
> +		return -EINVAL;
> +	if (!res->name || strcmp(dir_reg_name, res->name))
> +		res->name = devm_kstrdup(&pdev->dev, dir_reg_name, GFP_KERNEL);

Ouch, I don't like this. Also the probability that the "if (!res->name || 
...)" condition is not met is so small that I would not bother with it and 
do the kstrdup unconditionally. But maybe we can remove this altogether - 
see below...

> +
> +	return 0;
> +}
> +
> +static int ge_dt_cb(struct platform_device *pdev,
> +		    struct bgpio_pdata *pdata,
> +		    unsigned long *flags)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	pdata->label = devm_kstrdup(&pdev->dev, np->full_name, GFP_KERNEL);
> +	if (!pdata->label)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static int moxart_dt_cb(struct platform_device *pdev,
> +			struct bgpio_pdata *pdata,
> +			unsigned long *flags)
> +{
> +	pdata->base = 0;
> +	pdata->label = "moxart-gpio";
> +	return 0;
> +}
> +
> +
> +static int ts4800_dt_cb(struct platform_device *pdev,
> +			struct bgpio_pdata *pdata,
> +			unsigned long *flags)
> +{
> +	int err;
> +
> +	err = of_property_read_u32(pdev->dev.of_node, "ngpios", &pdata->ngpio);
> +	if (err == -EINVAL) {
> +		pdata->ngpio = 16;
> +		return 0;
> +	}
> +
> +	return err;
> +}
> +
> +/*
> + * bgpio_init() needs up to five named mmio register resources.
> + * These currently are dat, set, clr, [dirout | dirin]. There
> + * is no particular order or predefined place for the entries.
> + * However, dirout and dirin are mutually exclusive.
> + */
> +#define __NUM_COMPAT_OVERRIDE_MMIO_RESOURCES 4
> +
> +struct compat_gpio_device_data {
> +	unsigned int expected_resource_size;
> +	unsigned int ngpio;
> +	resource_size_t register_width;
> +	unsigned long flags;
> +	int (*call_back)(struct platform_device *pdev,
> +			 struct bgpio_pdata *pdata,
> +			 unsigned long *flags);
> +	struct resource_replacement {
> +		resource_size_t start_offset;
> +		const char *name;
> +	} resources[__NUM_COMPAT_OVERRIDE_MMIO_RESOURCES];
> +};
> +#undef __NUM_COMPAT_OVERRIDE_MMIO_RESOURCES
> +
> +#define ADD_COMPAT_REGISTER(_name, _offset)	\
> +	{ .name = (_name), .start_offset = (_offset) }
> +
> +#define ADD_COMPAT_GPIO(_comp, _sz, _ngpio, _width, _cb, _f, _res...)	\
> +	{								\
> +	  .compatible = (_comp),					\
> +	  .data = &(struct compat_gpio_device_data) {			\
> +		.expected_resource_size = (_sz),			\
> +		.ngpio = (_ngpio),					\
> +		.register_width = (_width),				\
> +		.flags = (_f),						\
> +		.call_back = (_cb),					\
> +		.resources = { _res },					\
> +	}								\
> +}
> +
> +#define ADD_COMPAT_GE_GPIO(_name, _ngpio)				\
> +	ADD_COMPAT_GPIO(_name, 0x24, _ngpio, 0x4, ge_dt_cb,		\
> +		 BGPIOF_BIG_ENDIAN_BYTE_ORDER,				\
> +		 ADD_COMPAT_REGISTER("dat", 0x04),			\
> +		 ADD_COMPAT_REGISTER("set", 0x08),			\
> +		 ADD_COMPAT_REGISTER("dirin", 0x00))			\
> +
> +static const struct of_device_id compat_gpio_devices[] = {
> +	ADD_COMPAT_GE_GPIO("ge,imp3a-gpio", 16),
> +	ADD_COMPAT_GE_GPIO("gef,sbc310-gpio", 6),
> +	ADD_COMPAT_GE_GPIO("gef,sbc610-gpio", 19),
> +	ADD_COMPAT_GPIO("moxa,moxart-gpio", 0xc, 0, 0x4, moxart_dt_cb,
> +		 BGPIOF_READ_OUTPUT_REG_SET,
> +		 ADD_COMPAT_REGISTER("dat", 0x04),
> +		 ADD_COMPAT_REGISTER("set", 0x00),
> +		 ADD_COMPAT_REGISTER("dirout", 0x08)),
> +	ADD_COMPAT_GPIO("technologic,ts4800-gpio", 0x6, 16, 0x2, ts4800_dt_cb,
> +		 0, ADD_COMPAT_REGISTER("dat", 0x00),
> +		 ADD_COMPAT_REGISTER("set", 0x02),
> +		 ADD_COMPAT_REGISTER("dirout", 0x04)),
> +};
> +
> +#undef ADD_COMPAT_GE_GPIO
> +#undef ADD_COMPAT_GPIO
> +#undef ADD_COMPAT_REGISTER
> +
> +static int compat_parse_dt(struct platform_device *pdev,
> +			   struct bgpio_pdata *pdata,
> +			   unsigned long *flags)
> +{
> +	const struct device_node *node = pdev->dev.of_node;
> +	const struct compat_gpio_device_data *entry;
> +	const struct of_device_id *of_id;
> +	struct resource *res;
> +	int err;
> +
> +	of_id = of_match_node(compat_gpio_devices, node);
> +	if (!of_id)
> +		return -ENODEV;
> +
> +	entry = of_id->data;
> +	if (!entry || !entry->resources[0].name)
> +		return -EINVAL;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	if (!res->name || strcmp(entry->resources[0].name, res->name)) {
> +		struct resource nres[ARRAY_SIZE(entry->resources)];
> +		size_t i;
> +
> +		if (resource_size(res) != entry->expected_resource_size)
> +			return -EINVAL;
> +
> +		for (i = 0; i < ARRAY_SIZE(entry->resources); i++) {
> +			if (!entry->resources[i].name)
> +				continue;
> +
> +			nres[i].name = devm_kstrdup(&pdev->dev,
> +				entry->resources[i].name, GFP_KERNEL);
> +			nres[i].start = res->start +
> +				entry->resources[i].start_offset;
> +			nres[i].end = nres[i].start +
> +				entry->register_width - 1;
> +			nres[i].flags = IORESOURCE_MEM;
> +		}
> +
> +		err = platform_device_add_resources(pdev, nres, i);
> +		if (err)
> +			return err;
> +	}
> +
> +	pdata->base = -1;
> +	pdata->ngpio = entry->ngpio;
> +	*flags = entry->flags;
> +
> +	if (entry->call_back)
> +		err = entry->call_back(pdev, pdata, flags);
> +
> +	return err;
> +}

Ok, so this is getting quite complex, with two of_device_id tables and two 
levels of hooks, mainly because you want to use the bgpio_pdev_probe() 
function which relies on named memory resources.

This function is here for basic platform devices, and you are not obliged 
to rely on it for DT. Feel free to write your own function (or rather split 
bgpio_pdev_probe() in two code paths) if it can reduce the amount of black 
magic you need to do (especially the renaming of resources on-the-fly).

At the end of the day what you want is a function that calls bgpio_init() 
with the right parameters. These parameters should be inferred from the 
compatible property whenever possible (which is most of the time, and why I 
am suspiscious of using "reg" properties for these devices since I don't 
think it can change much?), and passed as-is to bgpio_init(). Your 
compat_gpio_device_data struct basically encodes this, so this will take 
care of all the "compat" devices.

For the other devices, you should be able to fill in such a structure from 
the DT properties. Then you just use it for the parameters of bgpio_init(). 
It will be more elegant that adding resources, and probably shorter as 
well.

> +
>  static const struct of_device_id bgpio_of_match[] = {
>  	{ .compatible = "wd,mbl-gpio", .data = bgpio_basic_mmio_parse_dt },
> +	{ .compatible = "cirrus,clps711x-gpio", .data = clps711x_parse_dt },
> +	{ .compatible = "ge,imp3a-gpio", .data = compat_parse_dt },
> +	{ .compatible = "gef,sbc310-gpio", .data = compat_parse_dt },
> +	{ .compatible = "gef,sbc610-gpio", .data = compat_parse_dt },
> +	{ .compatible = "moxa,moxart-gpio", .data = compat_parse_dt },
> +	{ .compatible = "technologic,ts4800-gpio", .data = compat_parse_dt },

If you implement my idea, the function referred to by .data should return 
that structure I was talking about, and bgpio_init() can be called directly 
on it after that. The current path of bgpio_pdev_probe() should only be 
taken if bgpio_parse_dt() returned NULL.

I believe this will reduce the number of lines in your patch some more, and 
it will also make the code easier to read.

Also this should be split into several patches, like the previous one: the 
first one adds the required infrastructure to gpio-mmio, and the subsequent 
patches each move one device into gpio-mmio.
