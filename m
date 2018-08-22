From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Aug 2018 22:41:04 +0200
Subject: [PATCH 04/11] gpio: ep93xx: Pass around struct gpio_chip
In-Reply-To: <20180822204111.9581-1-linus.walleij@linaro.org>
References: <20180822204111.9581-1-linus.walleij@linaro.org>
Message-ID: <20180822204111.9581-5-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using a global variable, pass around the
struct gpio_chip * pointer and dereference to the state
container struct ep93xx_gpio as needed, like all other
drivers do.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-ep93xx.c | 111 ++++++++++++++++++++++++-------------
 1 file changed, 73 insertions(+), 38 deletions(-)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 3822d11e90ac..379f2573f794 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -21,11 +21,9 @@
 
 #define irq_to_gpio(irq)	((irq) - gpio_to_irq(0))
 
-void __iomem *ep93xx_gpio_base; /* FIXME: put this into irq_data */
-#define EP93XX_GPIO_REG(x) (ep93xx_gpio_base + (x))
-#define EP93XX_GPIO_F_INT_STATUS EP93XX_GPIO_REG(0x5c)
-#define EP93XX_GPIO_A_INT_STATUS EP93XX_GPIO_REG(0xa0)
-#define EP93XX_GPIO_B_INT_STATUS EP93XX_GPIO_REG(0xbc)
+#define EP93XX_GPIO_F_INT_STATUS 0x5c
+#define EP93XX_GPIO_A_INT_STATUS 0xa0
+#define EP93XX_GPIO_B_INT_STATUS 0xbc
 
 /* Maximum value for gpio line identifiers */
 #define EP93XX_GPIO_LINE_MAX 63
@@ -54,23 +52,24 @@ static const u8 eoi_register_offset[3]		= { 0x98, 0xb4, 0x54 };
 static const u8 int_en_register_offset[3]	= { 0x9c, 0xb8, 0x58 };
 static const u8 int_debounce_register_offset[3]	= { 0xa8, 0xc4, 0x64 };
 
-static void ep93xx_gpio_update_int_params(unsigned port)
+static void ep93xx_gpio_update_int_params(struct ep93xx_gpio *epg, unsigned port)
 {
 	BUG_ON(port > 2);
 
-	writeb_relaxed(0, EP93XX_GPIO_REG(int_en_register_offset[port]));
+	writeb_relaxed(0, epg->base + int_en_register_offset[port]);
 
 	writeb_relaxed(gpio_int_type2[port],
-		EP93XX_GPIO_REG(int_type2_register_offset[port]));
+		       epg->base + int_type2_register_offset[port]);
 
 	writeb_relaxed(gpio_int_type1[port],
-		EP93XX_GPIO_REG(int_type1_register_offset[port]));
+		       epg->base + int_type1_register_offset[port]);
 
 	writeb(gpio_int_unmasked[port] & gpio_int_enabled[port],
-		EP93XX_GPIO_REG(int_en_register_offset[port]));
+	       epg->base + int_en_register_offset[port]);
 }
 
-static void ep93xx_gpio_int_debounce(unsigned int irq, bool enable)
+static void ep93xx_gpio_int_debounce(struct ep93xx_gpio *epg,
+				     unsigned int irq, bool enable)
 {
 	int line = irq_to_gpio(irq);
 	int port = line >> 3;
@@ -82,15 +81,17 @@ static void ep93xx_gpio_int_debounce(unsigned int irq, bool enable)
 		gpio_int_debounce[port] &= ~port_mask;
 
 	writeb(gpio_int_debounce[port],
-		EP93XX_GPIO_REG(int_debounce_register_offset[port]));
+	       epg->base + int_debounce_register_offset[port]);
 }
 
 static void ep93xx_gpio_ab_irq_handler(struct irq_desc *desc)
 {
+	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
+	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
 	unsigned char status;
 	int i;
 
-	status = readb(EP93XX_GPIO_A_INT_STATUS);
+	status = readb(epg->base + EP93XX_GPIO_A_INT_STATUS);
 	for (i = 0; i < 8; i++) {
 		if (status & (1 << i)) {
 			int gpio_irq = gpio_to_irq(0) + i;
@@ -98,7 +99,7 @@ static void ep93xx_gpio_ab_irq_handler(struct irq_desc *desc)
 		}
 	}
 
-	status = readb(EP93XX_GPIO_B_INT_STATUS);
+	status = readb(epg->base + EP93XX_GPIO_B_INT_STATUS);
 	for (i = 0; i < 8; i++) {
 		if (status & (1 << i)) {
 			int gpio_irq = gpio_to_irq(8) + i;
@@ -123,20 +124,24 @@ static void ep93xx_gpio_f_irq_handler(struct irq_desc *desc)
 
 static void ep93xx_gpio_irq_ack(struct irq_data *d)
 {
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
 	int line = irq_to_gpio(d->irq);
 	int port = line >> 3;
 	int port_mask = 1 << (line & 7);
 
 	if (irqd_get_trigger_type(d) == IRQ_TYPE_EDGE_BOTH) {
 		gpio_int_type2[port] ^= port_mask; /* switch edge direction */
-		ep93xx_gpio_update_int_params(port);
+		ep93xx_gpio_update_int_params(epg, port);
 	}
 
-	writeb(port_mask, EP93XX_GPIO_REG(eoi_register_offset[port]));
+	writeb(port_mask, epg->base + eoi_register_offset[port]);
 }
 
 static void ep93xx_gpio_irq_mask_ack(struct irq_data *d)
 {
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
 	int line = irq_to_gpio(d->irq);
 	int port = line >> 3;
 	int port_mask = 1 << (line & 7);
@@ -145,27 +150,31 @@ static void ep93xx_gpio_irq_mask_ack(struct irq_data *d)
 		gpio_int_type2[port] ^= port_mask; /* switch edge direction */
 
 	gpio_int_unmasked[port] &= ~port_mask;
-	ep93xx_gpio_update_int_params(port);
+	ep93xx_gpio_update_int_params(epg, port);
 
-	writeb(port_mask, EP93XX_GPIO_REG(eoi_register_offset[port]));
+	writeb(port_mask, epg->base + eoi_register_offset[port]);
 }
 
 static void ep93xx_gpio_irq_mask(struct irq_data *d)
 {
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
 	int line = irq_to_gpio(d->irq);
 	int port = line >> 3;
 
 	gpio_int_unmasked[port] &= ~(1 << (line & 7));
-	ep93xx_gpio_update_int_params(port);
+	ep93xx_gpio_update_int_params(epg, port);
 }
 
 static void ep93xx_gpio_irq_unmask(struct irq_data *d)
 {
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
 	int line = irq_to_gpio(d->irq);
 	int port = line >> 3;
 
 	gpio_int_unmasked[port] |= 1 << (line & 7);
-	ep93xx_gpio_update_int_params(port);
+	ep93xx_gpio_update_int_params(epg, port);
 }
 
 /*
@@ -175,6 +184,8 @@ static void ep93xx_gpio_irq_unmask(struct irq_data *d)
  */
 static int ep93xx_gpio_irq_type(struct irq_data *d, unsigned int type)
 {
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
 	const int gpio = irq_to_gpio(d->irq);
 	const int port = gpio >> 3;
 	const int port_mask = 1 << (gpio & 7);
@@ -220,7 +231,7 @@ static int ep93xx_gpio_irq_type(struct irq_data *d, unsigned int type)
 
 	gpio_int_enabled[port] |= port_mask;
 
-	ep93xx_gpio_update_int_params(port);
+	ep93xx_gpio_update_int_params(epg, port);
 
 	return 0;
 }
@@ -234,23 +245,47 @@ static struct irq_chip ep93xx_gpio_irq_chip = {
 	.irq_set_type	= ep93xx_gpio_irq_type,
 };
 
-static void ep93xx_gpio_init_irq(struct platform_device *pdev)
+static void ep93xx_gpio_init_irq(struct platform_device *pdev,
+				 struct ep93xx_gpio *epg)
 {
 	int gpio_irq;
 	int i;
 
+	/* The A bank */
 	for (gpio_irq = gpio_to_irq(0);
-	     gpio_irq <= gpio_to_irq(EP93XX_GPIO_LINE_MAX_IRQ); ++gpio_irq) {
+	     gpio_irq < gpio_to_irq(8);
+	     gpio_irq++) {
+		irq_set_chip_data(gpio_irq, &epg->gc[0]);
+		irq_set_chip_and_handler(gpio_irq, &ep93xx_gpio_irq_chip,
+					 handle_level_irq);
+		irq_clear_status_flags(gpio_irq, IRQ_NOREQUEST);
+	}
+	/* The B bank */
+	for (gpio_irq = gpio_to_irq(8);
+	     gpio_irq < gpio_to_irq(16);
+	     gpio_irq++) {
+		irq_set_chip_data(gpio_irq, &epg->gc[1]);
+		irq_set_chip_and_handler(gpio_irq, &ep93xx_gpio_irq_chip,
+					 handle_level_irq);
+		irq_clear_status_flags(gpio_irq, IRQ_NOREQUEST);
+	}
+	/* The F bank */
+	for (gpio_irq = gpio_to_irq(16);
+	     gpio_irq < gpio_to_irq(EP93XX_GPIO_LINE_MAX_IRQ);
+	     gpio_irq++) {
+		irq_set_chip_data(gpio_irq, &epg->gc[5]);
 		irq_set_chip_and_handler(gpio_irq, &ep93xx_gpio_irq_chip,
 					 handle_level_irq);
 		irq_clear_status_flags(gpio_irq, IRQ_NOREQUEST);
 	}
 
-	irq_set_chained_handler(platform_get_irq(pdev, 0),
-				ep93xx_gpio_ab_irq_handler);
+	irq_set_chained_handler_and_data(platform_get_irq(pdev, 0),
+					 ep93xx_gpio_ab_irq_handler,
+					 &epg->gc[0]);
 	for (i = 1; i <= 8; i++)
-		irq_set_chained_handler(platform_get_irq(pdev, i),
-					ep93xx_gpio_f_irq_handler);
+		irq_set_chained_handler_and_data(platform_get_irq(pdev, i),
+						 ep93xx_gpio_f_irq_handler,
+						 &epg->gc[i]);
 }
 
 
@@ -285,10 +320,11 @@ static struct ep93xx_gpio_bank ep93xx_gpio_banks[] = {
 	EP93XX_GPIO_BANK("H", 0x40, 0x44, 56, false),
 };
 
-static int ep93xx_gpio_set_config(struct gpio_chip *chip, unsigned offset,
+static int ep93xx_gpio_set_config(struct gpio_chip *gc, unsigned offset,
 				  unsigned long config)
 {
-	int gpio = chip->base + offset;
+	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
+	int gpio = gc->base + offset;
 	int irq = gpio_to_irq(gpio);
 	u32 debounce;
 
@@ -299,7 +335,7 @@ static int ep93xx_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 		return -EINVAL;
 
 	debounce = pinconf_to_config_argument(config);
-	ep93xx_gpio_int_debounce(irq, debounce ? true : false);
+	ep93xx_gpio_int_debounce(epg, irq, debounce ? true : false);
 
 	return 0;
 }
@@ -320,10 +356,11 @@ static int ep93xx_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 }
 
 static int ep93xx_gpio_add_bank(struct gpio_chip *gc, struct device *dev,
-	void __iomem *base, struct ep93xx_gpio_bank *bank)
+				struct ep93xx_gpio *epg,
+				struct ep93xx_gpio_bank *bank)
 {
-	void __iomem *data = base + bank->data;
-	void __iomem *dir =  base + bank->dir;
+	void __iomem *data = epg->base + bank->data;
+	void __iomem *dir = epg->base + bank->dir;
 	int err;
 
 	err = bgpio_init(gc, dev, 1, data, NULL, NULL, dir, NULL, 0);
@@ -338,7 +375,7 @@ static int ep93xx_gpio_add_bank(struct gpio_chip *gc, struct device *dev,
 		gc->to_irq = ep93xx_gpio_to_irq;
 	}
 
-	return devm_gpiochip_add_data(dev, gc, NULL);
+	return devm_gpiochip_add_data(dev, gc, epg);
 }
 
 static int ep93xx_gpio_probe(struct platform_device *pdev)
@@ -356,19 +393,17 @@ static int ep93xx_gpio_probe(struct platform_device *pdev)
 	epg->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(epg->base))
 		return PTR_ERR(epg->base);
-	ep93xx_gpio_base = epg->base;
 
 	for (i = 0; i < ARRAY_SIZE(ep93xx_gpio_banks); i++) {
 		struct gpio_chip *gc = &epg->gc[i];
 		struct ep93xx_gpio_bank *bank = &ep93xx_gpio_banks[i];
 
-		if (ep93xx_gpio_add_bank(gc, &pdev->dev,
-					 epg->base, bank))
+		if (ep93xx_gpio_add_bank(gc, &pdev->dev, epg, bank))
 			dev_warn(&pdev->dev, "Unable to add gpio bank %s\n",
 				bank->label);
 	}
 
-	ep93xx_gpio_init_irq(pdev);
+	ep93xx_gpio_init_irq(pdev, epg);
 
 	return 0;
 }
-- 
2.17.1
