From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 25 Feb 2013 11:49:33 +0800
Subject: [PATCH v5 04/12] gpio: pxa: use platform data for gpio inverted
In-Reply-To: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1361764181-26647-5-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid to judge whether gpio is inverted by identifying cpu in
gpio driver. Move this into platform data of gpio driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-pxa/pxa25x.c |    3 +++
 drivers/gpio/gpio-pxa.c    |   28 ++++++++++++++++++----------
 include/linux/gpio-pxa.h   |    1 +
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 3f5171e..9c9c224 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -340,6 +340,9 @@ void __init pxa25x_map_io(void)
 }
 
 static struct pxa_gpio_platform_data pxa25x_gpio_info __initdata = {
+#ifdef CONFIG_CPU_PXA26x
+	.inverted = true,
+#endif
 	.gpio_set_wake = gpio_set_wake,
 };
 
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 9519ab9..735aa3e 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -71,6 +71,7 @@ static struct device_node *pxa_gpio_of_node;
 struct pxa_gpio_chip {
 	struct gpio_chip	gc;
 	void __iomem		*regbase;
+	bool			inverted;
 	char			label[10];
 
 	unsigned long		irq_mask;
@@ -126,9 +127,9 @@ static inline int gpio_is_mmp_type(int type)
 /* GPIO86/87/88/89 on PXA26x have their direction bits in PXA_GPDR(2 inverted,
  * as well as their Alternate Function value being '1' for GPIO in GAFRx.
  */
-static inline int pxa_gpio_is_inverted(int gpio)
+static inline int pxa_gpio_is_inverted(struct pxa_gpio_chip *chip, int gpio)
 {
-	if ((gpio_type == PXA26X_GPIO) && (gpio > 85))
+	if ((chip->inverted) && (gpio > 85))
 		return 1;
 	return 0;
 }
@@ -139,14 +140,12 @@ static inline int pxa_gpio_is_inverted(int gpio)
  * is attributed as "occupied" here (I know this terminology isn't
  * accurate, you are welcome to propose a better one :-)
  */
-static inline int pxa_gpio_is_occupied(unsigned gpio)
+static inline int pxa_gpio_is_occupied(struct pxa_gpio_chip *chip, unsigned gpio)
 {
-	struct pxa_gpio_chip *chip;
 	void __iomem *base;
 	unsigned long gafr = 0, gpdr = 0;
 	int ret, af = 0, dir = 0;
 
-	chip = gpio_to_pxachip(gpio);
 	base = gpio_chip_base(&chip->gc);
 	gpdr = readl_relaxed(base + GPDR_OFFSET);
 
@@ -158,7 +157,7 @@ static inline int pxa_gpio_is_occupied(unsigned gpio)
 		af = (gafr >> ((gpio & 0xf) * 2)) & 0x3;
 		dir = gpdr & GPIO_bit(gpio);
 
-		if (pxa_gpio_is_inverted(gpio))
+		if (pxa_gpio_is_inverted(chip, gpio))
 			ret = (af != 1) || (dir == 0);
 		else
 			ret = (af != 0) || (dir != 0);
@@ -183,13 +182,16 @@ int pxa_irq_to_gpio(int irq)
 static int pxa_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
 {
 	void __iomem *base = gpio_chip_base(gc);
+	struct pxa_gpio_chip *chip;
 	uint32_t value, mask = 1 << offset;
 	unsigned long flags;
 
+	chip = container_of(gc, struct pxa_gpio_chip, gc);
+
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	value = readl_relaxed(base + GPDR_OFFSET);
-	if (pxa_gpio_is_inverted(gc->base + offset))
+	if (pxa_gpio_is_inverted(chip, gc->base + offset))
 		value |= mask;
 	else
 		value &= ~mask;
@@ -203,15 +205,17 @@ static int pxa_gpio_direction_output(struct gpio_chip *gc,
 				     unsigned offset, int value)
 {
 	void __iomem *base = gpio_chip_base(gc);
+	struct pxa_gpio_chip *chip;
 	uint32_t tmp, mask = 1 << offset;
 	unsigned long flags;
 
+	chip = container_of(gc, struct pxa_gpio_chip, gc);
 	writel_relaxed(mask, base + (value ? GPSR_OFFSET : GPCR_OFFSET));
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	tmp = readl_relaxed(base + GPDR_OFFSET);
-	if (pxa_gpio_is_inverted(gc->base + offset))
+	if (pxa_gpio_is_inverted(chip, gc->base + offset))
 		tmp &= ~mask;
 	else
 		tmp |= mask;
@@ -322,7 +326,7 @@ static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
 		if ((c->irq_edge_rise | c->irq_edge_fall) & GPIO_bit(gpio))
 			return 0;
 
-		if (pxa_gpio_is_occupied(gpio))
+		if (pxa_gpio_is_occupied(c, gpio))
 			return 0;
 
 		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
@@ -330,7 +334,7 @@ static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
 
 	gpdr = readl_relaxed(c->regbase + GPDR_OFFSET);
 
-	if (pxa_gpio_is_inverted(gpio))
+	if (pxa_gpio_is_inverted(c, gpio))
 		writel_relaxed(gpdr | mask,  c->regbase + GPDR_OFFSET);
 	else
 		writel_relaxed(gpdr & ~mask, c->regbase + GPDR_OFFSET);
@@ -507,6 +511,8 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
 	if (!pdata)
 		return -ENOMEM;
 	pdata->ed_mask = of_property_read_bool(np, "marvell,gpio-ed-mask");
+	/* It's only valid for PXA26x */
+	pdata->inverted = of_property_read_bool(np, "marvell,gpio-inverted");
 	/* set the platform data */
 	pdev->dev.platform_data = pdata;
 	gpio_type = (int)of_id->data;
@@ -610,6 +616,8 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 		/* unmask GPIO edge detect for AP side */
 		if (info->ed_mask)
 			writel_relaxed(~0, c->regbase + ED_MASK_OFFSET);
+		/* update for gpio inverted */
+		c->inverted = info->inverted;
 	}
 
 	if (!use_of) {
diff --git a/include/linux/gpio-pxa.h b/include/linux/gpio-pxa.h
index bc5cae5..759e865 100644
--- a/include/linux/gpio-pxa.h
+++ b/include/linux/gpio-pxa.h
@@ -15,6 +15,7 @@ extern int pxa_irq_to_gpio(int irq);
 
 struct pxa_gpio_platform_data {
 	bool ed_mask;	/* true means that ed_mask reg is available */
+	bool inverted;	/* only valid for PXA26x */
 	int (*gpio_set_wake)(unsigned int gpio, unsigned int on);
 };
 
-- 
1.7.10.4
