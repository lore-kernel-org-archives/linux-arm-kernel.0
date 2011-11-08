From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue,  8 Nov 2011 18:24:15 +0800
Subject: [PATCH v6 07/11] ARM: pxa: use little endian read write in gpio driver
In-Reply-To: <1320747859-8366-1-git-send-email-haojian.zhuang@marvell.com>
References: <1320747859-8366-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1320747859-8366-8-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove __raw_readl()/__raw_writel(). Use readl_relaxed()/writel_relaxed()
instead.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/gpio/gpio-pxa.c |   68 +++++++++++++++++++++++-----------------------
 1 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index aebc4e8..31d2da4 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -143,12 +143,12 @@ static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
-	value = __raw_readl(base + GPDR_OFFSET);
+	value = readl_relaxed(base + GPDR_OFFSET);
 	if (__gpio_is_inverted(chip->base + offset))
 		value |= mask;
 	else
 		value &= ~mask;
-	__raw_writel(value, base + GPDR_OFFSET);
+	writel_relaxed(value, base + GPDR_OFFSET);
 
 	spin_unlock_irqrestore(&gpio_lock, flags);
 	return 0;
@@ -161,16 +161,16 @@ static int pxa_gpio_direction_output(struct gpio_chip *chip,
 	uint32_t tmp, mask = 1 << offset;
 	unsigned long flags;
 
-	__raw_writel(mask, base + (value ? GPSR_OFFSET : GPCR_OFFSET));
+	writel_relaxed(mask, base + (value ? GPSR_OFFSET : GPCR_OFFSET));
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
-	tmp = __raw_readl(base + GPDR_OFFSET);
+	tmp = readl_relaxed(base + GPDR_OFFSET);
 	if (__gpio_is_inverted(chip->base + offset))
 		tmp &= ~mask;
 	else
 		tmp |= mask;
-	__raw_writel(tmp, base + GPDR_OFFSET);
+	writel_relaxed(tmp, base + GPDR_OFFSET);
 
 	spin_unlock_irqrestore(&gpio_lock, flags);
 	return 0;
@@ -178,12 +178,12 @@ static int pxa_gpio_direction_output(struct gpio_chip *chip,
 
 static int pxa_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	return __raw_readl(gpio_chip_base(chip) + GPLR_OFFSET) & (1 << offset);
+	return readl_relaxed(gpio_chip_base(chip) + GPLR_OFFSET) & (1 << offset);
 }
 
 static void pxa_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
-	__raw_writel(1 << offset, gpio_chip_base(chip) +
+	writel_relaxed(1 << offset, gpio_chip_base(chip) +
 				(value ? GPSR_OFFSET : GPCR_OFFSET));
 }
 
@@ -228,12 +228,12 @@ static inline void update_edge_detect(struct pxa_gpio_chip *c)
 {
 	uint32_t grer, gfer;
 
-	grer = __raw_readl(c->regbase + GRER_OFFSET) & ~c->irq_mask;
-	gfer = __raw_readl(c->regbase + GFER_OFFSET) & ~c->irq_mask;
+	grer = readl_relaxed(c->regbase + GRER_OFFSET) & ~c->irq_mask;
+	gfer = readl_relaxed(c->regbase + GFER_OFFSET) & ~c->irq_mask;
 	grer |= c->irq_edge_rise & c->irq_mask;
 	gfer |= c->irq_edge_fall & c->irq_mask;
-	__raw_writel(grer, c->regbase + GRER_OFFSET);
-	__raw_writel(gfer, c->regbase + GFER_OFFSET);
+	writel_relaxed(grer, c->regbase + GRER_OFFSET);
+	writel_relaxed(gfer, c->regbase + GFER_OFFSET);
 }
 
 static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
@@ -257,12 +257,12 @@ static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
 		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
 	}
 
-	gpdr = __raw_readl(c->regbase + GPDR_OFFSET);
+	gpdr = readl_relaxed(c->regbase + GPDR_OFFSET);
 
 	if (__gpio_is_inverted(gpio))
-		__raw_writel(gpdr | mask,  c->regbase + GPDR_OFFSET);
+		writel_relaxed(gpdr | mask,  c->regbase + GPDR_OFFSET);
 	else
-		__raw_writel(gpdr & ~mask, c->regbase + GPDR_OFFSET);
+		writel_relaxed(gpdr & ~mask, c->regbase + GPDR_OFFSET);
 
 	if (type & IRQ_TYPE_EDGE_RISING)
 		c->irq_edge_rise |= mask;
@@ -293,9 +293,9 @@ static void pxa_gpio_demux_handler(unsigned int irq, struct irq_desc *desc)
 		for_each_gpio_chip(gpio, c) {
 			gpio_base = c->chip.base;
 
-			gedr = __raw_readl(c->regbase + GEDR_OFFSET);
+			gedr = readl_relaxed(c->regbase + GEDR_OFFSET);
 			gedr = gedr & c->irq_mask;
-			__raw_writel(gedr, c->regbase + GEDR_OFFSET);
+			writel_relaxed(gedr, c->regbase + GEDR_OFFSET);
 
 			n = find_first_bit(&gedr, BITS_PER_LONG);
 			while (n < BITS_PER_LONG) {
@@ -313,7 +313,7 @@ static void pxa_ack_muxed_gpio(struct irq_data *d)
 	int gpio = pxa_irq_to_gpio(d->irq);
 	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
 
-	__raw_writel(GPIO_bit(gpio), c->regbase + GEDR_OFFSET);
+	writel_relaxed(GPIO_bit(gpio), c->regbase + GEDR_OFFSET);
 }
 
 static void pxa_mask_muxed_gpio(struct irq_data *d)
@@ -324,10 +324,10 @@ static void pxa_mask_muxed_gpio(struct irq_data *d)
 
 	c->irq_mask &= ~GPIO_bit(gpio);
 
-	grer = __raw_readl(c->regbase + GRER_OFFSET) & ~GPIO_bit(gpio);
-	gfer = __raw_readl(c->regbase + GFER_OFFSET) & ~GPIO_bit(gpio);
-	__raw_writel(grer, c->regbase + GRER_OFFSET);
-	__raw_writel(gfer, c->regbase + GFER_OFFSET);
+	grer = readl_relaxed(c->regbase + GRER_OFFSET) & ~GPIO_bit(gpio);
+	gfer = readl_relaxed(c->regbase + GFER_OFFSET) & ~GPIO_bit(gpio);
+	writel_relaxed(grer, c->regbase + GRER_OFFSET);
+	writel_relaxed(gfer, c->regbase + GFER_OFFSET);
 }
 
 static void pxa_unmask_muxed_gpio(struct irq_data *d)
@@ -398,9 +398,9 @@ void __init pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn)
 
 	/* clear all GPIO edge detects */
 	for_each_gpio_chip(gpio, c) {
-		__raw_writel(0, c->regbase + GFER_OFFSET);
-		__raw_writel(0, c->regbase + GRER_OFFSET);
-		__raw_writel(~0,c->regbase + GEDR_OFFSET);
+		writel_relaxed(0, c->regbase + GFER_OFFSET);
+		writel_relaxed(0, c->regbase + GRER_OFFSET);
+		writel_relaxed(~0,c->regbase + GEDR_OFFSET);
 	}
 
 #ifdef CONFIG_ARCH_PXA
@@ -435,13 +435,13 @@ static int pxa_gpio_suspend(void)
 	int gpio;
 
 	for_each_gpio_chip(gpio, c) {
-		c->saved_gplr = __raw_readl(c->regbase + GPLR_OFFSET);
-		c->saved_gpdr = __raw_readl(c->regbase + GPDR_OFFSET);
-		c->saved_grer = __raw_readl(c->regbase + GRER_OFFSET);
-		c->saved_gfer = __raw_readl(c->regbase + GFER_OFFSET);
+		c->saved_gplr = readl_relaxed(c->regbase + GPLR_OFFSET);
+		c->saved_gpdr = readl_relaxed(c->regbase + GPDR_OFFSET);
+		c->saved_grer = readl_relaxed(c->regbase + GRER_OFFSET);
+		c->saved_gfer = readl_relaxed(c->regbase + GFER_OFFSET);
 
 		/* Clear GPIO transition detect bits */
-		__raw_writel(0xffffffff, c->regbase + GEDR_OFFSET);
+		writel_relaxed(0xffffffff, c->regbase + GEDR_OFFSET);
 	}
 	return 0;
 }
@@ -453,12 +453,12 @@ static void pxa_gpio_resume(void)
 
 	for_each_gpio_chip(gpio, c) {
 		/* restore level with set/clear */
-		__raw_writel( c->saved_gplr, c->regbase + GPSR_OFFSET);
-		__raw_writel(~c->saved_gplr, c->regbase + GPCR_OFFSET);
+		writel_relaxed( c->saved_gplr, c->regbase + GPSR_OFFSET);
+		writel_relaxed(~c->saved_gplr, c->regbase + GPCR_OFFSET);
 
-		__raw_writel(c->saved_grer, c->regbase + GRER_OFFSET);
-		__raw_writel(c->saved_gfer, c->regbase + GFER_OFFSET);
-		__raw_writel(c->saved_gpdr, c->regbase + GPDR_OFFSET);
+		writel_relaxed(c->saved_grer, c->regbase + GRER_OFFSET);
+		writel_relaxed(c->saved_gfer, c->regbase + GFER_OFFSET);
+		writel_relaxed(c->saved_gpdr, c->regbase + GPDR_OFFSET);
 	}
 }
 #else
-- 
1.7.4.1
