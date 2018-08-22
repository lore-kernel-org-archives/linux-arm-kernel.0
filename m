From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Aug 2018 22:41:11 +0200
Subject: [PATCH 11/11] gpio: ep93xx: Switch A and B to use GPIOLIB_IRQCHIP
In-Reply-To: <20180822204111.9581-1-linus.walleij@linaro.org>
References: <20180822204111.9581-1-linus.walleij@linaro.org>
Message-ID: <20180822204111.9581-12-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can quite easily switch banks/ports A and B to use
GPIOLIB_IRQCHIP which is code that will be more careful
about handling interrupt descriptors and use a proper
irqdomain for translating the IRQs. This cuts down some
code in favor of using the implementation inside
gpiolib.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/Kconfig       |  1 +
 drivers/gpio/gpio-ep93xx.c | 95 ++++++++++++++++++++------------------
 2 files changed, 51 insertions(+), 45 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 71c0ab46f216..afcd94613017 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -200,6 +200,7 @@ config GPIO_EP93XX
 	def_bool y
 	depends on ARCH_EP93XX
 	select GPIO_GENERIC
+	select GPIOLIB_IRQCHIP
 
 config GPIO_EXAR
 	tristate "Support for GPIO pins on XR17V352/354/358"
diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index d45d8ac3b525..68a416fc3141 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -29,13 +29,10 @@
 #define EP93XX_GPIO_LINE_MAX_IRQ 23
 
 /*
- * IRQ numbers used by this driver is 64 ..87
- *
- * Map GPIO A0..A7  (0..7)  to irq 64..71,
- *          B0..B7  (7..15) to irq 72..79, and
- *          F0..F7 (16..24) to irq 80..87.
+ * Static mapping of GPIO bank F IRQS:
+ * F0..F7 (16..24) to irq 80..87.
  */
-static unsigned int ep93xx_gpio_irq_base[3] = { 64, 72, 80 };
+#define EP93XX_GPIO_F_IRQ_BASE 80
 
 struct ep93xx_gpio {
 	void __iomem		*base;
@@ -117,17 +114,21 @@ static void ep93xx_gpio_ab_irq_handler(struct irq_desc *desc)
 
 	chained_irq_enter(irqchip, desc);
 
+	/*
+	 * Dispatch the IRQs to the irqdomain of each A and B
+	 * gpiochip irqdomains depending on what has fired.
+	 * The tricky part is that the IRQ line is shared
+	 * between bank A and B and each has their own gpiochip.
+	 */
 	stat = readb(epg->base + EP93XX_GPIO_A_INT_STATUS);
-	for_each_set_bit(offset, &stat, 8) {
-		int gpio_irq = ep93xx_gpio_irq_base[0] + offset;
-		generic_handle_irq(gpio_irq);
-	}
+	for_each_set_bit(offset, &stat, 8)
+		generic_handle_irq(irq_find_mapping(epg->gc[0].irq.domain,
+						    offset));
 
 	stat = readb(epg->base + EP93XX_GPIO_B_INT_STATUS);
-	for_each_set_bit(offset, &stat, 8) {
-		int gpio_irq = ep93xx_gpio_irq_base[1] + offset;
-		generic_handle_irq(gpio_irq);
-	}
+	for_each_set_bit(offset, &stat, 8)
+		generic_handle_irq(irq_find_mapping(epg->gc[1].irq.domain,
+						    offset));
 
 	chained_irq_exit(irqchip, desc);
 }
@@ -142,7 +143,7 @@ static void ep93xx_gpio_f_irq_handler(struct irq_desc *desc)
 	struct irq_chip *irqchip = irq_desc_get_chip(desc);
 	unsigned int irq = irq_desc_get_irq(desc);
 	int port_f_idx = ((irq + 1) & 7) ^ 4; /* {19..22,47..50} -> {0..7} */
-	int gpio_irq = ep93xx_gpio_irq_base[2] + port_f_idx;
+	int gpio_irq = EP93XX_GPIO_F_IRQ_BASE + port_f_idx;
 
 	chained_irq_enter(irqchip, desc);
 	generic_handle_irq(gpio_irq);
@@ -268,44 +269,53 @@ static struct irq_chip ep93xx_gpio_irq_chip = {
 	.irq_set_type	= ep93xx_gpio_irq_type,
 };
 
-static void ep93xx_gpio_init_irq(struct platform_device *pdev,
-				 struct ep93xx_gpio *epg)
+static int ep93xx_gpio_init_irq(struct platform_device *pdev,
+				struct ep93xx_gpio *epg)
 {
+	int ab_parent_irq = platform_get_irq(pdev, 0);
+	struct device *dev = &pdev->dev;
 	int gpio_irq;
+	int ret;
 	int i;
 
 	/* The A bank */
-	for (i = 0; i < 8; i++) {
-		gpio_irq = ep93xx_gpio_irq_base[0] + i;
-		irq_set_chip_data(gpio_irq, &epg->gc[0]);
-		irq_set_chip_and_handler(gpio_irq, &ep93xx_gpio_irq_chip,
-					 handle_level_irq);
-		irq_clear_status_flags(gpio_irq, IRQ_NOREQUEST);
+	ret = gpiochip_irqchip_add(&epg->gc[0], &ep93xx_gpio_irq_chip,
+                                   64, handle_level_irq,
+                                   IRQ_TYPE_NONE);
+	if (ret) {
+		dev_err(dev, "Could not add irqchip 0\n");
+		return ret;
 	}
+	gpiochip_set_chained_irqchip(&epg->gc[0], &ep93xx_gpio_irq_chip,
+				     ab_parent_irq,
+				     ep93xx_gpio_ab_irq_handler);
+
 	/* The B bank */
-	for (i = 0; i < 8; i++) {
-		gpio_irq = ep93xx_gpio_irq_base[1] + i;
-		irq_set_chip_data(gpio_irq, &epg->gc[1]);
-		irq_set_chip_and_handler(gpio_irq, &ep93xx_gpio_irq_chip,
-					 handle_level_irq);
-		irq_clear_status_flags(gpio_irq, IRQ_NOREQUEST);
+	ret = gpiochip_irqchip_add(&epg->gc[1], &ep93xx_gpio_irq_chip,
+                                   72, handle_level_irq,
+                                   IRQ_TYPE_NONE);
+	if (ret) {
+		dev_err(dev, "Could not add irqchip 1\n");
+		return ret;
 	}
+	gpiochip_set_chained_irqchip(&epg->gc[1], &ep93xx_gpio_irq_chip,
+				     ab_parent_irq,
+				     ep93xx_gpio_ab_irq_handler);
+
 	/* The F bank */
 	for (i = 0; i < 8; i++) {
-		gpio_irq = ep93xx_gpio_irq_base[2] + i;
+		gpio_irq = EP93XX_GPIO_F_IRQ_BASE + i;
 		irq_set_chip_data(gpio_irq, &epg->gc[5]);
 		irq_set_chip_and_handler(gpio_irq, &ep93xx_gpio_irq_chip,
 					 handle_level_irq);
 		irq_clear_status_flags(gpio_irq, IRQ_NOREQUEST);
 	}
 
-	irq_set_chained_handler_and_data(platform_get_irq(pdev, 0),
-					 ep93xx_gpio_ab_irq_handler,
-					 &epg->gc[0]);
 	for (i = 1; i <= 8; i++)
 		irq_set_chained_handler_and_data(platform_get_irq(pdev, i),
 						 ep93xx_gpio_f_irq_handler,
 						 &epg->gc[i]);
+	return 0;
 }
 
 
@@ -354,15 +364,9 @@ static int ep93xx_gpio_set_config(struct gpio_chip *gc, unsigned offset,
 	return 0;
 }
 
-static int ep93xx_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
+static int ep93xx_gpio_f_to_irq(struct gpio_chip *gc, unsigned offset)
 {
-	int port = ep93xx_gpio_port(gc);
-
-	/* Those are the ports supporting IRQ */
-	if (port != 0 && port != 1 && port != 5)
-		return -EINVAL;
-
-	return ep93xx_gpio_irq_base[port] + offset;
+	return EP93XX_GPIO_F_IRQ_BASE + offset;
 }
 
 static int ep93xx_gpio_add_bank(struct gpio_chip *gc, struct device *dev,
@@ -380,10 +384,8 @@ static int ep93xx_gpio_add_bank(struct gpio_chip *gc, struct device *dev,
 	gc->label = bank->label;
 	gc->base = bank->base;
 
-	if (bank->has_irq) {
+	if (bank->has_irq)
 		gc->set_config = ep93xx_gpio_set_config;
-		gc->to_irq = ep93xx_gpio_to_irq;
-	}
 
 	return devm_gpiochip_add_data(dev, gc, epg);
 }
@@ -410,7 +412,10 @@ static int ep93xx_gpio_probe(struct platform_device *pdev)
 
 		if (ep93xx_gpio_add_bank(gc, &pdev->dev, epg, bank))
 			dev_warn(&pdev->dev, "Unable to add gpio bank %s\n",
-				bank->label);
+				 bank->label);
+		/* Only bank F has especially funky IRQ handling */
+		if (i == 5)
+			gc->to_irq = ep93xx_gpio_f_to_irq;
 	}
 
 	ep93xx_gpio_init_irq(pdev, epg);
-- 
2.17.1
