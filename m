From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 23 Jan 2013 16:25:48 +0800
Subject: [PATCH 04/10] gpio: pxa: use platform data for gpio inverted
In-Reply-To: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
References: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1358929554-32265-5-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid to judge whether gpio is inverted by identifying cpu in gpio
driver. Move this into platform data of gpio driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-pxa/pxa25x.c |    3 +++
 drivers/gpio/gpio-pxa.c    |   41 ++++++++++++++++++++++++++---------------
 include/linux/gpio-pxa.h   |    1 +
 3 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index f4c293a..8d77090 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -340,6 +340,9 @@ void __init pxa25x_map_io(void)
 }
 
 static struct pxa_gpio_platform_data pxa25x_gpio_info __initdata = {
+#ifdef CONFIG_CPU_PXA26x
+	.inverted = 1,
+#endif
 	.gpio_set_wake = gpio_set_wake,
 };
 
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index da6e7fd..6d61a69 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -71,6 +71,7 @@ struct pxa_gpio_chip {
 	struct gpio_chip chip;
 	void __iomem	*regbase;
 	unsigned int	irq_base;
+	unsigned int	inverted;
 	char label[10];
 
 	unsigned long	irq_mask;
@@ -126,9 +127,9 @@ static inline int gpio_is_mmp_type(int type)
 /* GPIO86/87/88/89 on PXA26x have their direction bits in PXA_GPDR(2 inverted,
  * as well as their Alternate Function value being '1' for GPIO in GAFRx.
  */
-static inline int __gpio_is_inverted(int gpio)
+static inline int __gpio_is_inverted(struct pxa_gpio_chip *chip, int gpio)
 {
-	if ((gpio_type == PXA26X_GPIO) && (gpio > 85))
+	if ((chip->inverted) && (gpio > 85))
 		return 1;
 	return 0;
 }
@@ -139,15 +140,13 @@ static inline int __gpio_is_inverted(int gpio)
  * is attributed as "occupied" here (I know this terminology isn't
  * accurate, you are welcome to propose a better one :-)
  */
-static inline int __gpio_is_occupied(unsigned gpio)
+static inline int __gpio_is_occupied(struct pxa_gpio_chip *chip, unsigned gpio)
 {
-	struct pxa_gpio_chip *pxachip;
 	void __iomem *base;
 	unsigned long gafr = 0, gpdr = 0;
 	int ret, af = 0, dir = 0;
 
-	pxachip = gpio_to_pxachip(gpio);
-	base = gpio_chip_base(&pxachip->chip);
+	base = gpio_chip_base(&chip->chip);
 	gpdr = readl_relaxed(base + GPDR_OFFSET);
 
 	switch (gpio_type) {
@@ -158,7 +157,7 @@ static inline int __gpio_is_occupied(unsigned gpio)
 		af = (gafr >> ((gpio & 0xf) * 2)) & 0x3;
 		dir = gpdr & GPIO_bit(gpio);
 
-		if (__gpio_is_inverted(gpio))
+		if (__gpio_is_inverted(chip, gpio))
 			ret = (af != 1) || (dir == 0);
 		else
 			ret = (af != 0) || (dir != 0);
@@ -188,16 +187,19 @@ int pxa_irq_to_gpio(struct irq_data *d)
 	return gpio;
 }
 
-static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+static int pxa_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
 {
-	void __iomem *base = gpio_chip_base(chip);
+	struct pxa_gpio_chip *chip = NULL;
+	void __iomem *base = gpio_chip_base(gc);
 	uint32_t value, mask = 1 << offset;
 	unsigned long flags;
 
+	chip = container_of(gc, struct pxa_gpio_chip, chip);
+
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	value = readl_relaxed(base + GPDR_OFFSET);
-	if (__gpio_is_inverted(chip->base + offset))
+	if (__gpio_is_inverted(chip, gc->base + offset))
 		value |= mask;
 	else
 		value &= ~mask;
@@ -207,19 +209,22 @@ static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 	return 0;
 }
 
-static int pxa_gpio_direction_output(struct gpio_chip *chip,
+static int pxa_gpio_direction_output(struct gpio_chip *gc,
 				     unsigned offset, int value)
 {
-	void __iomem *base = gpio_chip_base(chip);
+	struct pxa_gpio_chip *chip = NULL;
+	void __iomem *base = gpio_chip_base(gc);
 	uint32_t tmp, mask = 1 << offset;
 	unsigned long flags;
 
+	chip = container_of(gc, struct pxa_gpio_chip, chip);
+
 	writel_relaxed(mask, base + (value ? GPSR_OFFSET : GPCR_OFFSET));
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	tmp = readl_relaxed(base + GPDR_OFFSET);
-	if (__gpio_is_inverted(chip->base + offset))
+	if (__gpio_is_inverted(chip, gc->base + offset))
 		tmp &= ~mask;
 	else
 		tmp |= mask;
@@ -288,7 +293,7 @@ static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
 		if ((c->irq_edge_rise | c->irq_edge_fall) & GPIO_bit(gpio))
 			return 0;
 
-		if (__gpio_is_occupied(gpio))
+		if (__gpio_is_occupied(c, gpio))
 			return 0;
 
 		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
@@ -296,7 +301,7 @@ static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
 
 	gpdr = readl_relaxed(c->regbase + GPDR_OFFSET);
 
-	if (__gpio_is_inverted(gpio))
+	if (__gpio_is_inverted(c, gpio))
 		writel_relaxed(gpdr | mask,  c->regbase + GPDR_OFFSET);
 	else
 		writel_relaxed(gpdr & ~mask, c->regbase + GPDR_OFFSET);
@@ -475,6 +480,10 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
 	ret = of_find_property(np, "marvell,gpio-ed-mask", NULL);
 	if (ret)
 		pdata->ed_mask = 1;
+	/* It's only valid for PXA26x */
+	ret = of_find_property(np, "marvell,gpio-inverted", NULL);
+	if (ret)
+		pdata->inverted = 1;
 	/* set the platform data */
 	pdev->dev.platform_data = pdata;
 	gpio_type = (int)of_id->data;
@@ -617,6 +626,8 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 		/* unmask GPIO edge detect for AP side */
 		if (info->ed_mask)
 			writel_relaxed(~0, c->regbase + ED_MASK_OFFSET);
+		/* update for gpio inverted */
+		c->inverted = info->inverted;
 	}
 
 	if (!use_of) {
diff --git a/include/linux/gpio-pxa.h b/include/linux/gpio-pxa.h
index bdee118..c8d07be5 100644
--- a/include/linux/gpio-pxa.h
+++ b/include/linux/gpio-pxa.h
@@ -17,6 +17,7 @@ extern int pxa_irq_to_gpio(struct irq_data *d);
 
 struct pxa_gpio_platform_data {
 	unsigned ed_mask;	/* not 0 means ed_mask reg is available */
+	unsigned inverted;	/* only valid for PXA26x */
 	int (*gpio_set_wake)(unsigned int gpio, unsigned int on);
 };
 
-- 
1.7.10.4
