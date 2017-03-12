From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Mar 2017 00:28:16 +0100
Subject: [PATCH 4/6] gpio: gemini: rename to match Faraday IP
In-Reply-To: <20170312232818.26304-1-linus.walleij@linaro.org>
References: <20170312232818.26304-1-linus.walleij@linaro.org>
Message-ID: <20170312232818.26304-4-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Gemini driver is actually a driver for the Faraday Technology
FTGPIO010 IP block. We rename the driver and the Kconfig symbol and
put in a a new compatible string for the Moxa ART SoC that is also
using this IP block.

Cc: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/Kconfig                             |  7 ++-
 drivers/gpio/Makefile                            |  2 +-
 drivers/gpio/{gpio-gemini.c => gpio-ftgpio010.c} | 72 +++++++++++++-----------
 3 files changed, 44 insertions(+), 37 deletions(-)
 rename drivers/gpio/{gpio-gemini.c => gpio-ftgpio010.c} (73%)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 05043071fc98..82ba825c224a 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -204,14 +204,15 @@ config GPIO_GE_FPGA
 	  and write pin state) for GPIO implemented in a number of GE single
 	  board computers.
 
-config GPIO_GEMINI
-	bool "Gemini GPIO"
+config GPIO_FTGPIO010
+	bool "Faraday FTGPIO010 GPIO"
 	depends on ARCH_GEMINI
 	depends on OF_GPIO
 	select GPIO_GENERIC
 	select GPIOLIB_IRQCHIP
 	help
-	  Support for common GPIOs found in Cortina systems Gemini platforms.
+	  Support for common GPIOs from the Faraday FTGPIO010 IP core, found in
+	  Cortina systems Gemini platforms, Moxa ART and others.
 
 config GPIO_GENERIC_PLATFORM
 	tristate "Generic memory-mapped GPIO controller support (MMIO platform device)"
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index becb96c724fe..4b904fec8273 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -48,8 +48,8 @@ obj-$(CONFIG_GPIO_EP93XX)	+= gpio-ep93xx.o
 obj-$(CONFIG_GPIO_ETRAXFS)	+= gpio-etraxfs.o
 obj-$(CONFIG_GPIO_EXAR)		+= gpio-exar.o
 obj-$(CONFIG_GPIO_F7188X)	+= gpio-f7188x.o
+obj-$(CONFIG_GPIO_FTGPIO010)	+= gpio-ftgpio010.o
 obj-$(CONFIG_GPIO_GE_FPGA)	+= gpio-ge.o
-obj-$(CONFIG_GPIO_GEMINI)	+= gpio-gemini.o
 obj-$(CONFIG_GPIO_GPIO_MM)	+= gpio-gpio-mm.o
 obj-$(CONFIG_GPIO_GRGPIO)	+= gpio-grgpio.o
 obj-$(CONFIG_HTC_EGPIO)		+= gpio-htc-egpio.o
diff --git a/drivers/gpio/gpio-gemini.c b/drivers/gpio/gpio-ftgpio010.c
similarity index 73%
rename from drivers/gpio/gpio-gemini.c
rename to drivers/gpio/gpio-ftgpio010.c
index 962485163b7f..e9386f8b67f5 100644
--- a/drivers/gpio/gpio-gemini.c
+++ b/drivers/gpio/gpio-ftgpio010.c
@@ -1,5 +1,5 @@
 /*
- * Gemini gpiochip and interrupt routines
+ * Faraday Technolog FTGPIO010 gpiochip and interrupt routines
  * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
  *
  * Based on arch/arm/mach-gemini/gpio.c:
@@ -35,28 +35,28 @@
 #define GPIO_DEBOUNCE_PRESCALE	0x44
 
 /**
- * struct gemini_gpio - Gemini GPIO state container
+ * struct ftgpio_gpio - Gemini GPIO state container
  * @dev: containing device for this instance
  * @gc: gpiochip for this instance
  */
-struct gemini_gpio {
+struct ftgpio_gpio {
 	struct device *dev;
 	struct gpio_chip gc;
 	void __iomem *base;
 };
 
-static void gemini_gpio_ack_irq(struct irq_data *d)
+static void ftgpio_gpio_ack_irq(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct gemini_gpio *g = gpiochip_get_data(gc);
+	struct ftgpio_gpio *g = gpiochip_get_data(gc);
 
 	writel(BIT(irqd_to_hwirq(d)), g->base + GPIO_INT_CLR);
 }
 
-static void gemini_gpio_mask_irq(struct irq_data *d)
+static void ftgpio_gpio_mask_irq(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct gemini_gpio *g = gpiochip_get_data(gc);
+	struct ftgpio_gpio *g = gpiochip_get_data(gc);
 	u32 val;
 
 	val = readl(g->base + GPIO_INT_EN);
@@ -64,10 +64,10 @@ static void gemini_gpio_mask_irq(struct irq_data *d)
 	writel(val, g->base + GPIO_INT_EN);
 }
 
-static void gemini_gpio_unmask_irq(struct irq_data *d)
+static void ftgpio_gpio_unmask_irq(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct gemini_gpio *g = gpiochip_get_data(gc);
+	struct ftgpio_gpio *g = gpiochip_get_data(gc);
 	u32 val;
 
 	val = readl(g->base + GPIO_INT_EN);
@@ -75,10 +75,10 @@ static void gemini_gpio_unmask_irq(struct irq_data *d)
 	writel(val, g->base + GPIO_INT_EN);
 }
 
-static int gemini_gpio_set_irq_type(struct irq_data *d, unsigned int type)
+static int ftgpio_gpio_set_irq_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct gemini_gpio *g = gpiochip_get_data(gc);
+	struct ftgpio_gpio *g = gpiochip_get_data(gc);
 	u32 mask = BIT(irqd_to_hwirq(d));
 	u32 reg_both, reg_level, reg_type;
 
@@ -123,23 +123,23 @@ static int gemini_gpio_set_irq_type(struct irq_data *d, unsigned int type)
 	writel(reg_level, g->base + GPIO_INT_LEVEL);
 	writel(reg_both, g->base + GPIO_INT_BOTH_EDGE);
 
-	gemini_gpio_ack_irq(d);
+	ftgpio_gpio_ack_irq(d);
 
 	return 0;
 }
 
-static struct irq_chip gemini_gpio_irqchip = {
-	.name = "GPIO",
-	.irq_ack = gemini_gpio_ack_irq,
-	.irq_mask = gemini_gpio_mask_irq,
-	.irq_unmask = gemini_gpio_unmask_irq,
-	.irq_set_type = gemini_gpio_set_irq_type,
+static struct irq_chip ftgpio_gpio_irqchip = {
+	.name = "FTGPIO010",
+	.irq_ack = ftgpio_gpio_ack_irq,
+	.irq_mask = ftgpio_gpio_mask_irq,
+	.irq_unmask = ftgpio_gpio_unmask_irq,
+	.irq_set_type = ftgpio_gpio_set_irq_type,
 };
 
-static void gemini_gpio_irq_handler(struct irq_desc *desc)
+static void ftgpio_gpio_irq_handler(struct irq_desc *desc)
 {
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
-	struct gemini_gpio *g = gpiochip_get_data(gc);
+	struct ftgpio_gpio *g = gpiochip_get_data(gc);
 	struct irq_chip *irqchip = irq_desc_get_chip(desc);
 	int offset;
 	unsigned long stat;
@@ -155,11 +155,11 @@ static void gemini_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(irqchip, desc);
 }
 
-static int gemini_gpio_probe(struct platform_device *pdev)
+static int ftgpio_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	struct gemini_gpio *g;
+	struct ftgpio_gpio *g;
 	int irq;
 	int ret;
 
@@ -189,7 +189,7 @@ static int gemini_gpio_probe(struct platform_device *pdev)
 		dev_err(dev, "unable to init generic GPIO\n");
 		return ret;
 	}
-	g->gc.label = "Gemini";
+	g->gc.label = "FTGPIO010";
 	g->gc.base = -1;
 	g->gc.parent = dev;
 	g->gc.owner = THIS_MODULE;
@@ -204,33 +204,39 @@ static int gemini_gpio_probe(struct platform_device *pdev)
 	writel(0x0, g->base + GPIO_INT_MASK);
 	writel(~0x0, g->base + GPIO_INT_CLR);
 
-	ret = gpiochip_irqchip_add(&g->gc, &gemini_gpio_irqchip,
+	ret = gpiochip_irqchip_add(&g->gc, &ftgpio_gpio_irqchip,
 				   0, handle_bad_irq,
 				   IRQ_TYPE_NONE);
 	if (ret) {
 		dev_info(dev, "could not add irqchip\n");
 		return ret;
 	}
-	gpiochip_set_chained_irqchip(&g->gc, &gemini_gpio_irqchip,
-				     irq, gemini_gpio_irq_handler);
+	gpiochip_set_chained_irqchip(&g->gc, &ftgpio_gpio_irqchip,
+				     irq, ftgpio_gpio_irq_handler);
 
-	dev_info(dev, "Gemini GPIO @%p registered\n", g->base);
+	dev_info(dev, "FTGPIO010 @%p registered\n", g->base);
 
 	return 0;
 }
 
-static const struct of_device_id gemini_gpio_of_match[] = {
+static const struct of_device_id ftgpio_gpio_of_match[] = {
 	{
 		.compatible = "cortina,gemini-gpio",
 	},
+	{
+		.compatible = "moxa,moxart-gpio",
+	},
+	{
+		.compatible = "faraday,ftgpio010",
+	},
 	{},
 };
 
-static struct platform_driver gemini_gpio_driver = {
+static struct platform_driver ftgpio_gpio_driver = {
 	.driver = {
-		.name		= "gemini-gpio",
-		.of_match_table = of_match_ptr(gemini_gpio_of_match),
+		.name		= "ftgpio010-gpio",
+		.of_match_table = of_match_ptr(ftgpio_gpio_of_match),
 	},
-	.probe	= gemini_gpio_probe,
+	.probe	= ftgpio_gpio_probe,
 };
-builtin_platform_driver(gemini_gpio_driver);
+builtin_platform_driver(ftgpio_gpio_driver);
-- 
2.9.3
