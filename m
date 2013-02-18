From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 18 Feb 2013 13:12:32 +0800
Subject: [PATCH v3 06/12] gpio: pxa: clean code for compatible name
In-Reply-To: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1361164358-5845-7-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use compatible variable name in gpio pxa driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/gpio/gpio-pxa.c |  194 ++++++++++++++++++++++++-----------------------
 1 file changed, 98 insertions(+), 96 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 8fbf4c6..95561d6 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -95,9 +95,9 @@ static void __iomem *gpio_reg_base;
 #define for_each_gpio_chip(i, c)			\
 	for (i = 0, c = &pxa_gpio_chips[0]; i <= pxa_last_gpio; i += 32, c++)
 
-static inline void __iomem *gpio_chip_base(struct gpio_chip *c)
+static inline void __iomem *gpio_chip_base(struct gpio_chip *gc)
 {
-	return container_of(c, struct pxa_gpio_chip, chip)->regbase;
+	return container_of(gc, struct pxa_gpio_chip, chip)->regbase;
 }
 
 static inline struct pxa_gpio_chip *gpio_to_pxachip(unsigned gpio)
@@ -210,14 +210,14 @@ static int pxa_gpio_direction_output(struct gpio_chip *gc,
 	return 0;
 }
 
-static int pxa_gpio_get(struct gpio_chip *chip, unsigned offset)
+static int pxa_gpio_get(struct gpio_chip *gc, unsigned offset)
 {
-	return readl_relaxed(gpio_chip_base(chip) + GPLR_OFFSET) & (1 << offset);
+	return readl_relaxed(gpio_chip_base(gc) + GPLR_OFFSET) & (1 << offset);
 }
 
-static void pxa_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static void pxa_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 {
-	writel_relaxed(1 << offset, gpio_chip_base(chip) +
+	writel_relaxed(1 << offset, gpio_chip_base(gc) +
 				(value ? GPSR_OFFSET : GPCR_OFFSET));
 }
 
@@ -242,57 +242,58 @@ static int pxa_gpio_of_xlate(struct gpio_chip *gc,
 /* Update only those GRERx and GFERx edge detection register bits if those
  * bits are set in c->irq_mask
  */
-static inline void update_edge_detect(struct pxa_gpio_chip *c)
+static inline void update_edge_detect(struct pxa_gpio_chip *chip)
 {
 	uint32_t grer, gfer;
 
-	grer = readl_relaxed(c->regbase + GRER_OFFSET) & ~c->irq_mask;
-	gfer = readl_relaxed(c->regbase + GFER_OFFSET) & ~c->irq_mask;
-	grer |= c->irq_edge_rise & c->irq_mask;
-	gfer |= c->irq_edge_fall & c->irq_mask;
-	writel_relaxed(grer, c->regbase + GRER_OFFSET);
-	writel_relaxed(gfer, c->regbase + GFER_OFFSET);
+	grer = readl_relaxed(chip->regbase + GRER_OFFSET) & ~chip->irq_mask;
+	gfer = readl_relaxed(chip->regbase + GFER_OFFSET) & ~chip->irq_mask;
+	grer |= chip->irq_edge_rise & chip->irq_mask;
+	gfer |= chip->irq_edge_fall & chip->irq_mask;
+	writel_relaxed(grer, chip->regbase + GRER_OFFSET);
+	writel_relaxed(gfer, chip->regbase + GFER_OFFSET);
 }
 
 static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
 {
-	struct pxa_gpio_chip *c;
+	struct pxa_gpio_chip *chip;
 	int gpio = pxa_irq_to_gpio(d);
 	unsigned long gpdr, mask = GPIO_bit(gpio);
 
-	c = gpio_to_pxachip(gpio);
+	chip = gpio_to_pxachip(gpio);
 
 	if (type == IRQ_TYPE_PROBE) {
 		/* Don't mess with enabled GPIOs using preconfigured edges or
 		 * GPIOs set to alternate function or to output during probe
 		 */
-		if ((c->irq_edge_rise | c->irq_edge_fall) & GPIO_bit(gpio))
+		if ((chip->irq_edge_rise | chip->irq_edge_fall)
+			& GPIO_bit(gpio))
 			return 0;
 
-		if (__gpio_is_occupied(c, gpio))
+		if (__gpio_is_occupied(chip, gpio))
 			return 0;
 
 		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
 	}
 
-	gpdr = readl_relaxed(c->regbase + GPDR_OFFSET);
+	gpdr = readl_relaxed(chip->regbase + GPDR_OFFSET);
 
-	if (__gpio_is_inverted(c, gpio))
-		writel_relaxed(gpdr | mask,  c->regbase + GPDR_OFFSET);
+	if (__gpio_is_inverted(chip, gpio))
+		writel_relaxed(gpdr | mask,  chip->regbase + GPDR_OFFSET);
 	else
-		writel_relaxed(gpdr & ~mask, c->regbase + GPDR_OFFSET);
+		writel_relaxed(gpdr & ~mask, chip->regbase + GPDR_OFFSET);
 
 	if (type & IRQ_TYPE_EDGE_RISING)
-		c->irq_edge_rise |= mask;
+		chip->irq_edge_rise |= mask;
 	else
-		c->irq_edge_rise &= ~mask;
+		chip->irq_edge_rise &= ~mask;
 
 	if (type & IRQ_TYPE_EDGE_FALLING)
-		c->irq_edge_fall |= mask;
+		chip->irq_edge_fall |= mask;
 	else
-		c->irq_edge_fall &= ~mask;
+		chip->irq_edge_fall &= ~mask;
 
-	update_edge_detect(c);
+	update_edge_detect(chip);
 
 	pr_debug("%s: IRQ%d (GPIO%d) - edge%s%s\n", __func__, d->irq, gpio,
 		((type & IRQ_TYPE_EDGE_RISING)  ? " rising"  : ""),
@@ -302,21 +303,21 @@ static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
 
 static void pxa_gpio_demux_handler(unsigned int irq, struct irq_desc *desc)
 {
-	struct pxa_gpio_chip *c;
+	struct pxa_gpio_chip *chip;
 	int loop, gpio, gpio_base, n;
 	unsigned long gedr;
-	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irq_chip *ic = irq_desc_get_chip(desc);
 
-	chained_irq_enter(chip, desc);
+	chained_irq_enter(ic, desc);
 
 	do {
 		loop = 0;
-		for_each_gpio_chip(gpio, c) {
-			gpio_base = c->chip.base;
+		for_each_gpio_chip(gpio, chip) {
+			gpio_base = chip->chip.base;
 
-			gedr = readl_relaxed(c->regbase + GEDR_OFFSET);
-			gedr = gedr & c->irq_mask;
-			writel_relaxed(gedr, c->regbase + GEDR_OFFSET);
+			gedr = readl_relaxed(chip->regbase + GEDR_OFFSET);
+			gedr = gedr & chip->irq_mask;
+			writel_relaxed(gedr, chip->regbase + GEDR_OFFSET);
 
 			for_each_set_bit(n, &gedr, BITS_PER_LONG) {
 				loop = 1;
@@ -326,38 +327,38 @@ static void pxa_gpio_demux_handler(unsigned int irq, struct irq_desc *desc)
 		}
 	} while (loop);
 
-	chained_irq_exit(chip, desc);
+	chained_irq_exit(ic, desc);
 }
 
 static void pxa_ack_muxed_gpio(struct irq_data *d)
 {
 	int gpio = pxa_irq_to_gpio(d);
-	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
+	struct pxa_gpio_chip *chip = gpio_to_pxachip(gpio);
 
-	writel_relaxed(GPIO_bit(gpio), c->regbase + GEDR_OFFSET);
+	writel_relaxed(GPIO_bit(gpio), chip->regbase + GEDR_OFFSET);
 }
 
 static void pxa_mask_muxed_gpio(struct irq_data *d)
 {
 	int gpio = pxa_irq_to_gpio(d);
-	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
+	struct pxa_gpio_chip *chip = gpio_to_pxachip(gpio);
 	uint32_t grer, gfer;
 
-	c->irq_mask &= ~GPIO_bit(gpio);
+	chip->irq_mask &= ~GPIO_bit(gpio);
 
-	grer = readl_relaxed(c->regbase + GRER_OFFSET) & ~GPIO_bit(gpio);
-	gfer = readl_relaxed(c->regbase + GFER_OFFSET) & ~GPIO_bit(gpio);
-	writel_relaxed(grer, c->regbase + GRER_OFFSET);
-	writel_relaxed(gfer, c->regbase + GFER_OFFSET);
+	grer = readl_relaxed(chip->regbase + GRER_OFFSET) & ~GPIO_bit(gpio);
+	gfer = readl_relaxed(chip->regbase + GFER_OFFSET) & ~GPIO_bit(gpio);
+	writel_relaxed(grer, chip->regbase + GRER_OFFSET);
+	writel_relaxed(gfer, chip->regbase + GFER_OFFSET);
 }
 
 static int pxa_gpio_set_wake(struct irq_data *d, unsigned int on)
 {
 	int gpio = pxa_irq_to_gpio(d);
-	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
+	struct pxa_gpio_chip *chip = gpio_to_pxachip(gpio);
 
-	if (c->set_wake)
-		return c->set_wake(gpio, on);
+	if (chip->set_wake)
+		return chip->set_wake(gpio, on);
 	else
 		return 0;
 }
@@ -365,10 +366,10 @@ static int pxa_gpio_set_wake(struct irq_data *d, unsigned int on)
 static void pxa_unmask_muxed_gpio(struct irq_data *d)
 {
 	int gpio = pxa_irq_to_gpio(d);
-	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
+	struct pxa_gpio_chip *chip = gpio_to_pxachip(gpio);
 
-	c->irq_mask |= GPIO_bit(gpio);
-	update_edge_detect(c);
+	chip->irq_mask |= GPIO_bit(gpio);
+	update_edge_detect(chip);
 }
 
 static struct irq_chip pxa_muxed_gpio_chip = {
@@ -466,38 +467,37 @@ static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end,
 	}
 
 	for (i = 0, gpio = 0; i < nbanks; i++, gpio += 32) {
-		struct gpio_chip *c = &chips[i].chip;
+		struct gpio_chip *gc = &chips[i].chip;
 
 		sprintf(chips[i].label, "gpio-%d", i);
 		chips[i].regbase = gpio_reg_base + BANK_OFF(i);
 		chips[i].set_wake = set_wake;
 
-		c->base  = gpio;
-		c->label = chips[i].label;
-
-		c->direction_input  = pxa_gpio_direction_input;
-		c->direction_output = pxa_gpio_direction_output;
-		c->get = pxa_gpio_get;
-		c->set = pxa_gpio_set;
-		c->to_irq = pxa_gpio_to_irq;
-#ifdef CONFIG_OF_GPIO
-		c->of_node = pxa_gpio_of_node;
-		c->of_xlate = pxa_gpio_of_xlate;
-		c->of_gpio_n_cells = 2;
-#endif
-
 		/* number of GPIOs on last bank may be less than 32 */
-		c->ngpio = (gpio + 31 > gpio_end) ? (gpio_end - gpio + 1) : 32;
+		gc->ngpio = (gpio + 31 > gpio_end) ? (gpio_end - gpio + 1) : 32;
 
-		chips[i].irq_base = irq_alloc_descs(-1, 0, c->ngpio, 0);
+		chips[i].irq_base = irq_alloc_descs(-1, 0, gc->ngpio, 0);
 		if (chips[i].irq_base < 0)
 			return -EINVAL;
-		if (!irq_domain_add_legacy(pdev->dev.of_node, c->ngpio,
+		if (!irq_domain_add_legacy(pdev->dev.of_node, gc->ngpio,
 					   chips[i].irq_base, 0,
 					   &pxa_irq_domain_ops, &chips[i]))
 			return -ENODEV;
 
-		gpiochip_add(c);
+		gc->base  = gpio;
+		gc->label = chips[i].label;
+
+		gc->direction_input  = pxa_gpio_direction_input;
+		gc->direction_output = pxa_gpio_direction_output;
+		gc->get = pxa_gpio_get;
+		gc->set = pxa_gpio_set;
+		gc->to_irq = pxa_gpio_to_irq;
+#ifdef CONFIG_OF_GPIO
+		gc->of_node = pxa_gpio_of_node;
+		gc->of_xlate = pxa_gpio_of_xlate;
+		gc->of_gpio_n_cells = 2;
+#endif
+		gpiochip_add(gc);
 	}
 	pxa_gpio_chips = chips;
 	return 0;
@@ -505,10 +505,10 @@ static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end,
 
 static int pxa_gpio_probe(struct platform_device *pdev)
 {
-	struct pxa_gpio_chip *c;
+	struct pxa_gpio_chip *chip;
 	struct resource *res;
 	struct clk *clk;
-	struct pxa_gpio_platform_data *info;
+	struct pxa_gpio_platform_data *pdata;
 	int gpio, irq, ret, use_of = 0;
 	int irq0 = 0, irq1 = 0, irq_mux, gpio_offset = 0;
 
@@ -547,22 +547,24 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize GPIO chips */
-	info = dev_get_platdata(&pdev->dev);
-	pxa_last_gpio = info->nr_gpios - 1;
-	pxa_init_gpio_chip(pdev, pxa_last_gpio,
-			   info ? info->gpio_set_wake : NULL);
+	pdata = dev_get_platdata(&pdev->dev);
+	pxa_last_gpio = pdata->nr_gpios - 1;
+	ret = pxa_init_gpio_chip(pdev, pxa_last_gpio,
+				 pdata ? pdata->gpio_set_wake : NULL);
+	if (ret < 0)
+		return ret;
 
 	/* clear all GPIO edge detects */
-	for_each_gpio_chip(gpio, c) {
-		writel_relaxed(0, c->regbase + GFER_OFFSET);
-		writel_relaxed(0, c->regbase + GRER_OFFSET);
-		writel_relaxed(~0,c->regbase + GEDR_OFFSET);
+	for_each_gpio_chip(gpio, chip) {
+		writel_relaxed(0, chip->regbase + GFER_OFFSET);
+		writel_relaxed(0, chip->regbase + GRER_OFFSET);
+		writel_relaxed(~0,chip->regbase + GEDR_OFFSET);
 		/* unmask GPIO edge detect for AP side */
-		if (info->ed_mask)
-			writel_relaxed(~0, c->regbase + ED_MASK_OFFSET);
+		if (pdata->ed_mask)
+			writel_relaxed(~0, chip->regbase + ED_MASK_OFFSET);
 		/* update for gpio inverted & gafr */
-		c->inverted = info->inverted;
-		c->gafr = info->gafr;
+		chip->inverted = pdata->inverted;
+		chip->gafr = pdata->gafr;
 	}
 
 	if (!use_of) {
@@ -604,34 +606,34 @@ module_platform_driver(pxa_gpio_driver);
 #ifdef CONFIG_PM
 static int pxa_gpio_suspend(void)
 {
-	struct pxa_gpio_chip *c;
+	struct pxa_gpio_chip *chip;
 	int gpio;
 
-	for_each_gpio_chip(gpio, c) {
-		c->saved_gplr = readl_relaxed(c->regbase + GPLR_OFFSET);
-		c->saved_gpdr = readl_relaxed(c->regbase + GPDR_OFFSET);
-		c->saved_grer = readl_relaxed(c->regbase + GRER_OFFSET);
-		c->saved_gfer = readl_relaxed(c->regbase + GFER_OFFSET);
+	for_each_gpio_chip(gpio, chip) {
+		chip->saved_gplr = readl_relaxed(chip->regbase + GPLR_OFFSET);
+		chip->saved_gpdr = readl_relaxed(chip->regbase + GPDR_OFFSET);
+		chip->saved_grer = readl_relaxed(chip->regbase + GRER_OFFSET);
+		chip->saved_gfer = readl_relaxed(chip->regbase + GFER_OFFSET);
 
 		/* Clear GPIO transition detect bits */
-		writel_relaxed(0xffffffff, c->regbase + GEDR_OFFSET);
+		writel_relaxed(~0, chip->regbase + GEDR_OFFSET);
 	}
 	return 0;
 }
 
 static void pxa_gpio_resume(void)
 {
-	struct pxa_gpio_chip *c;
+	struct pxa_gpio_chip *chip;
 	int gpio;
 
-	for_each_gpio_chip(gpio, c) {
+	for_each_gpio_chip(gpio, chip) {
 		/* restore level with set/clear */
-		writel_relaxed( c->saved_gplr, c->regbase + GPSR_OFFSET);
-		writel_relaxed(~c->saved_gplr, c->regbase + GPCR_OFFSET);
+		writel_relaxed( chip->saved_gplr, chip->regbase + GPSR_OFFSET);
+		writel_relaxed(~chip->saved_gplr, chip->regbase + GPCR_OFFSET);
 
-		writel_relaxed(c->saved_grer, c->regbase + GRER_OFFSET);
-		writel_relaxed(c->saved_gfer, c->regbase + GFER_OFFSET);
-		writel_relaxed(c->saved_gpdr, c->regbase + GPDR_OFFSET);
+		writel_relaxed(chip->saved_grer, chip->regbase + GRER_OFFSET);
+		writel_relaxed(chip->saved_gfer, chip->regbase + GFER_OFFSET);
+		writel_relaxed(chip->saved_gpdr, chip->regbase + GPDR_OFFSET);
 	}
 }
 #else
-- 
1.7.10.4
