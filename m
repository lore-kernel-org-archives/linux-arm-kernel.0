From: chunkeey@googlemail.com (Christian Lamparter)
Date: Fri, 29 Apr 2016 02:53:16 +0200
Subject: [RFC v5 3/4] gpio: move clps711x, moxart,
 ts4800 and gpio-ge into gpio-generic
In-Reply-To: <cover.1461888822.git.chunkeey@googlemail.com>
References: <cover.1461888822.git.chunkeey@googlemail.com>
Message-ID: <9e5cc9e957144bd5d4081573ef959f931281eaaa.1461888822.git.chunkeey@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch integrates these GPIO drivers into gpio-generic.

Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
 drivers/gpio/Kconfig         |  43 +++-----------
 drivers/gpio/Makefile        |   4 --
 drivers/gpio/gpio-clps711x.c |  91 -----------------------------
 drivers/gpio/gpio-ge.c       | 114 ------------------------------------
 drivers/gpio/gpio-generic.c  | 134 +++++++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-moxart.c   |  84 ---------------------------
 drivers/gpio/gpio-ts4800.c   |  81 --------------------------
 7 files changed, 142 insertions(+), 409 deletions(-)
 delete mode 100644 drivers/gpio/gpio-clps711x.c
 delete mode 100644 drivers/gpio/gpio-ge.c
 delete mode 100644 drivers/gpio/gpio-moxart.c
 delete mode 100644 drivers/gpio/gpio-ts4800.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index f73f26b..df6ca48 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -152,13 +152,6 @@ config GPIO_BRCMSTB
 	help
 	  Say yes here to enable GPIO support for Broadcom STB (BCM7XXX) SoCs.
 
-config GPIO_CLPS711X
-	tristate "CLPS711X GPIO support"
-	depends on ARCH_CLPS711X || COMPILE_TEST
-	select GPIO_GENERIC
-	help
-	  Say yes here to support GPIO on CLPS711X SoCs.
-
 config GPIO_DAVINCI
 	bool "TI Davinci/Keystone GPIO support"
 	default y if ARCH_DAVINCI
@@ -194,22 +187,18 @@ config GPIO_ETRAXFS
 	help
 	  Say yes here to support the GPIO controller on Axis ETRAX FS SoCs.
 
-config GPIO_GE_FPGA
-	bool "GE FPGA based GPIO"
-	depends on GE_FPGA
-	select GPIO_GENERIC
-	help
-	  Support for common GPIO functionality provided on some GE Single Board
-	  Computers.
-
-	  This driver provides basic support (configure as input or output, read
-	  and write pin state) for GPIO implemented in a number of GE single
-	  board computers.
-
 config GPIO_GENERIC_PLATFORM
 	tristate "Generic memory-mapped GPIO controller support (MMIO platform device)"
 	select GPIO_GENERIC
 	help
+	  Select this to support many generic memory-mapped GPIO controllers.
+
+	  This driver also includes support for the following GPIOs:
+	    CLPS711X SoCs
+	    MOXA ART SoC
+	    TS-4800 FPGA DIO blocks and compatibles.
+	    GPIOs found on some GE Single Board Computers.
+
 	  Say yes here to support basic platform_device memory-mapped GPIO controllers.
 
 config GPIO_GRGPIO
@@ -286,14 +275,6 @@ config GPIO_MM_LANTIQ
 	  (EBU) found on Lantiq SoCs. The gpios are output only as they are
 	  created by attaching a 16bit latch to the bus.
 
-config GPIO_MOXART
-	bool "MOXART GPIO support"
-	depends on ARCH_MOXART || COMPILE_TEST
-	select GPIO_GENERIC
-	help
-	  Select this option to enable GPIO driver for
-	  MOXA ART SoC devices.
-
 config GPIO_MPC5200
 	def_bool y
 	depends on PPC_MPC52xx
@@ -405,14 +386,6 @@ config GPIO_TEGRA
 	default y
 	depends on ARCH_TEGRA || COMPILE_TEST
 
-config GPIO_TS4800
-	tristate "TS-4800 DIO blocks and compatibles"
-	depends on OF_GPIO
-	depends on SOC_IMX51 || COMPILE_TEST
-	select GPIO_GENERIC
-	help
-	  This driver support TS-4800 FPGA GPIO controllers.
-
 config GPIO_TZ1090
 	bool "Toumaz Xenif TZ1090 GPIO support"
 	depends on SOC_TZ1090
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 74eb1a7..f3856df 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -28,7 +28,6 @@ obj-$(CONFIG_GPIO_ATH79)	+= gpio-ath79.o
 obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
 obj-$(CONFIG_GPIO_BRCMSTB)	+= gpio-brcmstb.o
 obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
-obj-$(CONFIG_GPIO_CLPS711X)	+= gpio-clps711x.o
 obj-$(CONFIG_GPIO_CS5535)	+= gpio-cs5535.o
 obj-$(CONFIG_GPIO_CRYSTAL_COVE)	+= gpio-crystalcove.o
 obj-$(CONFIG_GPIO_DA9052)	+= gpio-da9052.o
@@ -40,7 +39,6 @@ obj-$(CONFIG_GPIO_EM)		+= gpio-em.o
 obj-$(CONFIG_GPIO_EP93XX)	+= gpio-ep93xx.o
 obj-$(CONFIG_GPIO_ETRAXFS)	+= gpio-etraxfs.o
 obj-$(CONFIG_GPIO_F7188X)	+= gpio-f7188x.o
-obj-$(CONFIG_GPIO_GE_FPGA)	+= gpio-ge.o
 obj-$(CONFIG_GPIO_GRGPIO)	+= gpio-grgpio.o
 obj-$(CONFIG_GPIO_ICH)		+= gpio-ich.o
 obj-$(CONFIG_GPIO_IOP)		+= gpio-iop.o
@@ -65,7 +63,6 @@ obj-$(CONFIG_GPIO_MC9S08DZ60)	+= gpio-mc9s08dz60.o
 obj-$(CONFIG_GPIO_MCP23S08)	+= gpio-mcp23s08.o
 obj-$(CONFIG_GPIO_ML_IOH)	+= gpio-ml-ioh.o
 obj-$(CONFIG_GPIO_MM_LANTIQ)	+= gpio-mm-lantiq.o
-obj-$(CONFIG_GPIO_MOXART)	+= gpio-moxart.o
 obj-$(CONFIG_GPIO_MPC5200)	+= gpio-mpc5200.o
 obj-$(CONFIG_GPIO_MPC8XXX)	+= gpio-mpc8xxx.o
 obj-$(CONFIG_GPIO_MSIC)		+= gpio-msic.o
@@ -104,7 +101,6 @@ obj-$(CONFIG_GPIO_TPS65218)	+= gpio-tps65218.o
 obj-$(CONFIG_GPIO_TPS6586X)	+= gpio-tps6586x.o
 obj-$(CONFIG_GPIO_TPS65910)	+= gpio-tps65910.o
 obj-$(CONFIG_GPIO_TPS65912)	+= gpio-tps65912.o
-obj-$(CONFIG_GPIO_TS4800)	+= gpio-ts4800.o
 obj-$(CONFIG_GPIO_TS5500)	+= gpio-ts5500.o
 obj-$(CONFIG_GPIO_TWL4030)	+= gpio-twl4030.o
 obj-$(CONFIG_GPIO_TWL6040)	+= gpio-twl6040.o
diff --git a/drivers/gpio/gpio-clps711x.c b/drivers/gpio/gpio-clps711x.c
deleted file mode 100644
index 5a69025..0000000
--- a/drivers/gpio/gpio-clps711x.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- *  CLPS711X GPIO driver
- *
- *  Copyright (C) 2012,2013 Alexander Shiyan <shc_work@mail.ru>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <linux/err.h>
-#include <linux/module.h>
-#include <linux/gpio/driver.h>
-#include <linux/platform_device.h>
-
-static int clps711x_gpio_probe(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	void __iomem *dat, *dir;
-	struct gpio_chip *gc;
-	struct resource *res;
-	int err, id = np ? of_alias_get_id(np, "gpio") : pdev->id;
-
-	if ((id < 0) || (id > 4))
-		return -ENODEV;
-
-	gc = devm_kzalloc(&pdev->dev, sizeof(*gc), GFP_KERNEL);
-	if (!gc)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dat = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(dat))
-		return PTR_ERR(dat);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	dir = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(dir))
-		return PTR_ERR(dir);
-
-	switch (id) {
-	case 3:
-		/* PORTD is inverted logic for direction register */
-		err = bgpio_init(gc, &pdev->dev, 1, dat, NULL, NULL,
-				 NULL, dir, 0);
-		break;
-	default:
-		err = bgpio_init(gc, &pdev->dev, 1, dat, NULL, NULL,
-				 dir, NULL, 0);
-		break;
-	}
-
-	if (err)
-		return err;
-
-	switch (id) {
-	case 4:
-		/* PORTE is 3 lines only */
-		gc->ngpio = 3;
-		break;
-	default:
-		break;
-	}
-
-	gc->base = id * 8;
-	gc->owner = THIS_MODULE;
-	platform_set_drvdata(pdev, gc);
-
-	return devm_gpiochip_add_data(&pdev->dev, gc, NULL);
-}
-
-static const struct of_device_id __maybe_unused clps711x_gpio_ids[] = {
-	{ .compatible = "cirrus,clps711x-gpio" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, clps711x_gpio_ids);
-
-static struct platform_driver clps711x_gpio_driver = {
-	.driver	= {
-		.name		= "clps711x-gpio",
-		.of_match_table	= of_match_ptr(clps711x_gpio_ids),
-	},
-	.probe	= clps711x_gpio_probe,
-};
-module_platform_driver(clps711x_gpio_driver);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
-MODULE_DESCRIPTION("CLPS711X GPIO driver");
-MODULE_ALIAS("platform:clps711x-gpio");
diff --git a/drivers/gpio/gpio-ge.c b/drivers/gpio/gpio-ge.c
deleted file mode 100644
index 8650b29..0000000
--- a/drivers/gpio/gpio-ge.c
+++ /dev/null
@@ -1,114 +0,0 @@
-/*
- * Driver for GE FPGA based GPIO
- *
- * Author: Martyn Welch <martyn.welch@ge.com>
- *
- * 2008 (c) GE Intelligent Platforms Embedded Systems, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-/* TODO
- *
- * Configuration of output modes (totem-pole/open-drain)
- * Interrupt configuration - interrupts are always generated the FPGA relies on
- * the I/O interrupt controllers mask to stop them propergating
- */
-
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/of_device.h>
-#include <linux/of_gpio.h>
-#include <linux/of_address.h>
-#include <linux/module.h>
-#include <linux/gpio/driver.h>
-
-#define GEF_GPIO_DIRECT		0x00
-#define GEF_GPIO_IN		0x04
-#define GEF_GPIO_OUT		0x08
-#define GEF_GPIO_TRIG		0x0C
-#define GEF_GPIO_POLAR_A	0x10
-#define GEF_GPIO_POLAR_B	0x14
-#define GEF_GPIO_INT_STAT	0x18
-#define GEF_GPIO_OVERRUN	0x1C
-#define GEF_GPIO_MODE		0x20
-
-static const struct of_device_id gef_gpio_ids[] = {
-	{
-		.compatible	= "gef,sbc610-gpio",
-		.data		= (void *)19,
-	}, {
-		.compatible	= "gef,sbc310-gpio",
-		.data		= (void *)6,
-	}, {
-		.compatible	= "ge,imp3a-gpio",
-		.data		= (void *)16,
-	},
-	{ }
-};
-MODULE_DEVICE_TABLE(of, gef_gpio_ids);
-
-static int __init gef_gpio_probe(struct platform_device *pdev)
-{
-	const struct of_device_id *of_id =
-		of_match_device(gef_gpio_ids, &pdev->dev);
-	struct gpio_chip *gc;
-	void __iomem *regs;
-	int ret;
-
-	gc = devm_kzalloc(&pdev->dev, sizeof(*gc), GFP_KERNEL);
-	if (!gc)
-		return -ENOMEM;
-
-	regs = of_iomap(pdev->dev.of_node, 0);
-	if (!regs)
-		return -ENOMEM;
-
-	ret = bgpio_init(gc, &pdev->dev, 4, regs + GEF_GPIO_IN,
-			 regs + GEF_GPIO_OUT, NULL, NULL,
-			 regs + GEF_GPIO_DIRECT, BGPIOF_BIG_ENDIAN_BYTE_ORDER);
-	if (ret) {
-		dev_err(&pdev->dev, "bgpio_init failed\n");
-		goto err0;
-	}
-
-	/* Setup pointers to chip functions */
-	gc->label = devm_kstrdup(&pdev->dev, pdev->dev.of_node->full_name,
-				     GFP_KERNEL);
-	if (!gc->label) {
-		ret = -ENOMEM;
-		goto err0;
-	}
-
-	gc->base = -1;
-	gc->ngpio = (u16)(uintptr_t)of_id->data;
-	gc->of_gpio_n_cells = 2;
-	gc->of_node = pdev->dev.of_node;
-
-	/* This function adds a memory mapped GPIO chip */
-	ret = devm_gpiochip_add_data(&pdev->dev, gc, NULL);
-	if (ret)
-		goto err0;
-
-	return 0;
-err0:
-	iounmap(regs);
-	pr_err("%s: GPIO chip registration failed\n",
-			pdev->dev.of_node->full_name);
-	return ret;
-};
-
-static struct platform_driver gef_gpio_driver = {
-	.driver = {
-		.name		= "gef-gpio",
-		.of_match_table	= gef_gpio_ids,
-	},
-};
-module_platform_driver_probe(gef_gpio_driver, gef_gpio_probe);
-
-MODULE_DESCRIPTION("GE I/O FPGA GPIO driver");
-MODULE_AUTHOR("Martyn Welch <martyn.welch@ge.com");
-MODULE_LICENSE("GPL");
diff --git a/drivers/gpio/gpio-generic.c b/drivers/gpio/gpio-generic.c
index 129c3ba..54afd44 100644
--- a/drivers/gpio/gpio-generic.c
+++ b/drivers/gpio/gpio-generic.c
@@ -609,10 +609,144 @@ static int bgpio_basic_mmio_parse_dt(struct platform_device *pdev,
 	return 0;
 }
 
+static int clps711x_parse_dt(struct platform_device *pdev,
+			     struct bgpio_pdata *pdata,
+			     unsigned long *flags)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int id = np ? of_alias_get_id(np, "gpio") : pdev->id;
+	struct resource *res;
+
+	if ((id < 0) || (id > 4))
+		return -ENODEV;
+
+	/* PORTE is 3 lines only */
+	if (id == 4)
+		pdata->ngpio = 3;
+
+	pdata->base = id * 8;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	res->name = "dat";
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res)
+		return -EINVAL;
+
+	/* PORTD is inverted logic for direction register */
+	res->name = (id == 3) ? "dirin" : "dirout";
+	return 0;
+}
+
+static int ge_parse_dt(struct platform_device *pdev,
+		       struct bgpio_pdata *pdata,
+		       unsigned long *flags)
+{
+	struct device_node *np = pdev->dev.of_node;
+
+	struct resource *res;
+	struct resource nres[] = {
+		DEFINE_RES_MEM_NAMED(0, 1, "dat"),
+		DEFINE_RES_MEM_NAMED(0, 1, "set"),
+		DEFINE_RES_MEM_NAMED(0, 1, "dirin"),
+	};
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res || resource_size(res) != 0x24)
+		return -EINVAL;
+
+	nres[0].start = res->start + 0x04;
+	nres[0].end = nres[0].start + 3;
+	nres[1].start = res->start + 0x08;
+	nres[1].end = nres[1].start + 3;
+	nres[2].start = res->start + 0x00;
+	nres[2].end = nres[2].start + 3;
+	*flags |= BGPIOF_BIG_ENDIAN_BYTE_ORDER;
+	pdata->label = devm_kstrdup(&pdev->dev, np->full_name, GFP_KERNEL);
+	if (!pdata->label)
+		return -ENOMEM;
+
+	if (of_device_is_compatible(np, "ge,imp3a-gpio"))
+		pdata->ngpio = 16;
+	else if (of_device_is_compatible(np, "gef,sbc310-gpio"))
+		pdata->ngpio = 6;
+	else if (of_device_is_compatible(np, "gef,sbc610-gpio"))
+		pdata->ngpio = 19;
+
+	return platform_device_add_resources(pdev, nres, ARRAY_SIZE(nres));
+}
+
+static int moxart_parse_dt(struct platform_device *pdev,
+			   struct bgpio_pdata *pdata,
+			   unsigned long *flags)
+{
+	struct resource *res;
+	struct resource nres[] = {
+		DEFINE_RES_MEM_NAMED(0, 1, "dat"),
+		DEFINE_RES_MEM_NAMED(0, 1, "set"),
+		DEFINE_RES_MEM_NAMED(0, 1, "dirout"),
+	};
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res || resource_size(res) != 0xc)
+		return -EINVAL;
+
+	pdata->label = "moxart-gpio";
+	*flags |= BGPIOF_READ_OUTPUT_REG_SET;
+	nres[0].start = res->start + 0x04;
+	nres[0].end = nres[0].start + 3;
+	nres[1].start = res->start + 0x00;
+	nres[1].end = nres[1].start + 3;
+	nres[2].start = res->start + 0x08;
+	nres[2].end = nres[2].start + 3;
+	return platform_device_add_resources(pdev, nres, ARRAY_SIZE(nres));
+}
+
+static int ts4800_parse_dt(struct platform_device *pdev,
+			   struct bgpio_pdata *pdata,
+			   unsigned long *flags)
+{
+	int err;
+	struct resource *res;
+	struct resource nres[] = {
+		DEFINE_RES_MEM_NAMED(0, 1, "dat"),
+		DEFINE_RES_MEM_NAMED(0, 1, "set"),
+		DEFINE_RES_MEM_NAMED(0, 1, "dirout"),
+	};
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res || resource_size(res) != 0x6)
+		return -EINVAL;
+
+	nres[0].start = res->start;
+	nres[0].end = nres[0].start + 1;
+	nres[1].start = res->start + 0x02;
+	nres[1].end = nres[1].start + 1;
+	nres[2].start = res->start + 0x04;
+	nres[2].end = nres[2].start + 1;
+
+	err = of_property_read_u32(pdev->dev.of_node, "ngpios", &pdata->ngpio);
+	if (err == -EINVAL)
+		pdata->ngpio = 16;
+	else if (err)
+		return err;
+
+	return platform_device_add_resources(pdev, nres, ARRAY_SIZE(nres));
+}
+
 #define ADD(_name, _func) { .compatible = _name, .data = _func }
 
 static const struct of_device_id bgpio_of_match[] = {
 	ADD("linux,gpio-mmio", bgpio_basic_mmio_parse_dt),
+	ADD("cirrus,clps711x-gpio", clps711x_parse_dt),
+	ADD("ge,imp3a-gpio", ge_parse_dt),
+	ADD("gef,sbc310-gpio", ge_parse_dt),
+	ADD("gef,sbc610-gpio", ge_parse_dt),
+	ADD("moxa,moxart-gpio", moxart_parse_dt),
+	ADD("technologic,ts4800-gpio", ts4800_parse_dt),
 	{ }
 };
 #undef ADD
diff --git a/drivers/gpio/gpio-moxart.c b/drivers/gpio/gpio-moxart.c
deleted file mode 100644
index d58d389..0000000
--- a/drivers/gpio/gpio-moxart.c
+++ /dev/null
@@ -1,84 +0,0 @@
-/*
- * MOXA ART SoCs GPIO driver.
- *
- * Copyright (C) 2013 Jonas Jensen
- *
- * Jonas Jensen <jonas.jensen@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/err.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-#include <linux/of_address.h>
-#include <linux/of_gpio.h>
-#include <linux/pinctrl/consumer.h>
-#include <linux/delay.h>
-#include <linux/timer.h>
-#include <linux/bitops.h>
-#include <linux/gpio/driver.h>
-
-#define GPIO_DATA_OUT		0x00
-#define GPIO_DATA_IN		0x04
-#define GPIO_PIN_DIRECTION	0x08
-
-static int moxart_gpio_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct resource *res;
-	struct gpio_chip *gc;
-	void __iomem *base;
-	int ret;
-
-	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
-	if (!gc)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	ret = bgpio_init(gc, dev, 4, base + GPIO_DATA_IN,
-			 base + GPIO_DATA_OUT, NULL,
-			 base + GPIO_PIN_DIRECTION, NULL,
-			 BGPIOF_READ_OUTPUT_REG_SET);
-	if (ret) {
-		dev_err(&pdev->dev, "bgpio_init failed\n");
-		return ret;
-	}
-
-	gc->label = "moxart-gpio";
-	gc->request = gpiochip_generic_request;
-	gc->free = gpiochip_generic_free;
-	gc->base = 0;
-	gc->owner = THIS_MODULE;
-
-	ret = devm_gpiochip_add_data(dev, gc, NULL);
-	if (ret) {
-		dev_err(dev, "%s: gpiochip_add failed\n",
-			dev->of_node->full_name);
-		return ret;
-	}
-
-	return ret;
-}
-
-static const struct of_device_id moxart_gpio_match[] = {
-	{ .compatible = "moxa,moxart-gpio" },
-	{ }
-};
-
-static struct platform_driver moxart_gpio_driver = {
-	.driver	= {
-		.name		= "moxart-gpio",
-		.of_match_table	= moxart_gpio_match,
-	},
-	.probe	= moxart_gpio_probe,
-};
-builtin_platform_driver(moxart_gpio_driver);
diff --git a/drivers/gpio/gpio-ts4800.c b/drivers/gpio/gpio-ts4800.c
deleted file mode 100644
index 0c144a7..0000000
--- a/drivers/gpio/gpio-ts4800.c
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
- * GPIO driver for the TS-4800 board
- *
- * Copyright (c) 2016 - Savoir-faire Linux
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/gpio/driver.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/platform_device.h>
-
-#define DEFAULT_PIN_NUMBER      16
-#define INPUT_REG_OFFSET        0x00
-#define OUTPUT_REG_OFFSET       0x02
-#define DIRECTION_REG_OFFSET    0x04
-
-static int ts4800_gpio_probe(struct platform_device *pdev)
-{
-	struct device_node *node;
-	struct gpio_chip *chip;
-	struct resource *res;
-	void __iomem *base_addr;
-	int retval;
-	u32 ngpios;
-
-	chip = devm_kzalloc(&pdev->dev, sizeof(struct gpio_chip), GFP_KERNEL);
-	if (!chip)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base_addr = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base_addr))
-		return PTR_ERR(base_addr);
-
-	node = pdev->dev.of_node;
-	if (!node)
-		return -EINVAL;
-
-	retval = of_property_read_u32(node, "ngpios", &ngpios);
-	if (retval == -EINVAL)
-		ngpios = DEFAULT_PIN_NUMBER;
-	else if (retval)
-		return retval;
-
-	retval = bgpio_init(chip, &pdev->dev, 2, base_addr + INPUT_REG_OFFSET,
-			    base_addr + OUTPUT_REG_OFFSET, NULL,
-			    base_addr + DIRECTION_REG_OFFSET, NULL, 0);
-	if (retval) {
-		dev_err(&pdev->dev, "bgpio_init failed\n");
-		return retval;
-	}
-
-	chip->ngpio = ngpios;
-
-	platform_set_drvdata(pdev, chip);
-
-	return devm_gpiochip_add_data(&pdev->dev, chip, NULL);
-}
-
-static const struct of_device_id ts4800_gpio_of_match[] = {
-	{ .compatible = "technologic,ts4800-gpio", },
-	{},
-};
-
-static struct platform_driver ts4800_gpio_driver = {
-	.driver = {
-		   .name = "ts4800-gpio",
-		   .of_match_table = ts4800_gpio_of_match,
-		   },
-	.probe = ts4800_gpio_probe,
-};
-
-module_platform_driver_probe(ts4800_gpio_driver, ts4800_gpio_probe);
-
-MODULE_AUTHOR("Julien Grossholtz <julien.grossholtz@savoirfairelinux.com>");
-MODULE_DESCRIPTION("TS4800 FPGA GPIO driver");
-MODULE_LICENSE("GPL v2");
-- 
2.8.1
