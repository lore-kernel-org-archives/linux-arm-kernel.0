From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Mar 2017 00:28:17 +0100
Subject: [PATCH 5/6] gpio: moxart: Switch to using the FTGPIO010 driver
In-Reply-To: <20170312232818.26304-1-linus.walleij@linaro.org>
References: <20170312232818.26304-1-linus.walleij@linaro.org>
Message-ID: <20170312232818.26304-5-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This just deletes the Moxa ART driver and replaces it with the
more versatile Faraday FTGPIO010 driver.

Make this default on for ARCH_GEMINI and ARCH_MOXART so we do
not get Kconfig glitches.

Cc: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/Kconfig       | 10 +-----
 drivers/gpio/Makefile      |  1 -
 drivers/gpio/gpio-moxart.c | 84 ----------------------------------------------
 3 files changed, 1 insertion(+), 94 deletions(-)
 delete mode 100644 drivers/gpio/gpio-moxart.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 82ba825c224a..36298ddca3d6 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -206,10 +206,10 @@ config GPIO_GE_FPGA
 
 config GPIO_FTGPIO010
 	bool "Faraday FTGPIO010 GPIO"
-	depends on ARCH_GEMINI
 	depends on OF_GPIO
 	select GPIO_GENERIC
 	select GPIOLIB_IRQCHIP
+	default (ARCH_GEMINI || ARCH_MOXART)
 	help
 	  Support for common GPIOs from the Faraday FTGPIO010 IP core, found in
 	  Cortina systems Gemini platforms, Moxa ART and others.
@@ -309,14 +309,6 @@ config GPIO_MOCKUP
 	  tools/testing/selftests/gpio/gpio-mockup.sh. Reference the usage in
 	  it.
 
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
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 4b904fec8273..bd995dc2a84a 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -80,7 +80,6 @@ obj-$(CONFIG_GPIO_MCP23S08)	+= gpio-mcp23s08.o
 obj-$(CONFIG_GPIO_ML_IOH)	+= gpio-ml-ioh.o
 obj-$(CONFIG_GPIO_MM_LANTIQ)	+= gpio-mm-lantiq.o
 obj-$(CONFIG_GPIO_MOCKUP)      += gpio-mockup.o
-obj-$(CONFIG_GPIO_MOXART)	+= gpio-moxart.o
 obj-$(CONFIG_GPIO_MPC5200)	+= gpio-mpc5200.o
 obj-$(CONFIG_GPIO_MPC8XXX)	+= gpio-mpc8xxx.o
 obj-$(CONFIG_GPIO_MSIC)		+= gpio-msic.o
diff --git a/drivers/gpio/gpio-moxart.c b/drivers/gpio/gpio-moxart.c
deleted file mode 100644
index d58d38906ba6..000000000000
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
-- 
2.9.3
