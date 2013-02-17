From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun, 17 Feb 2013 19:42:49 +0800
Subject: [PATCH v9 03/10] gpio: pl061: support irqdomain
In-Reply-To: <1361101376-3783-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361101376-3783-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1361101376-3783-4-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop the support of irq generic chip. Now support irqdomain instead.

Although set_wake() is defined in irq generic chip & it is not really
used in pl061 gpio driver. Drop it at the same time.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/gpio/gpio-pl061.c |  104 ++++++++++++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 39 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index b820869..d1d6035 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/bitops.h>
 #include <linux/workqueue.h>
 #include <linux/gpio.h>
@@ -51,8 +52,7 @@ struct pl061_gpio {
 	spinlock_t		lock;
 
 	void __iomem		*base;
-	int			irq_base;
-	struct irq_chip_generic	*irq_gc;
+	struct irq_domain	*domain;
 	struct gpio_chip	gc;
 
 #ifdef CONFIG_PM
@@ -122,24 +122,20 @@ static int pl061_to_irq(struct gpio_chip *gc, unsigned offset)
 {
 	struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
 
-	if (chip->irq_base <= 0)
-		return -EINVAL;
-
-	return chip->irq_base + offset;
+	return irq_create_mapping(chip->domain, offset);
 }
 
 static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 {
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
-	struct pl061_gpio *chip = gc->private;
-	int offset = d->irq - chip->irq_base;
+	struct pl061_gpio *chip = irq_data_get_irq_chip_data(d);
+	int offset = irqd_to_hwirq(d);
 	unsigned long flags;
 	u8 gpiois, gpioibe, gpioiev;
 
 	if (offset < 0 || offset >= PL061_GPIO_NR)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&gc->lock, flags);
+	spin_lock_irqsave(&chip->lock, flags);
 
 	gpioiev = readb(chip->base + GPIOIEV);
 
@@ -168,7 +164,7 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 
 	writeb(gpioiev, chip->base + GPIOIEV);
 
-	raw_spin_unlock_irqrestore(&gc->lock, flags);
+	spin_unlock_irqrestore(&chip->lock, flags);
 
 	return 0;
 }
@@ -192,31 +188,61 @@ static void pl061_irq_handler(unsigned irq, struct irq_desc *desc)
 	chained_irq_exit(irqchip, desc);
 }
 
-static void __init pl061_init_gc(struct pl061_gpio *chip, int irq_base)
+static void pl061_irq_mask(struct irq_data *d)
 {
-	struct irq_chip_type *ct;
+	struct pl061_gpio *chip = irq_data_get_irq_chip_data(d);
+	u8 mask = 1 << (irqd_to_hwirq(d) % PL061_GPIO_NR);
+	u8 gpioie;
+
+	spin_lock(&chip->lock);
+	gpioie = readb(chip->base + GPIOIE) & ~mask;
+	writeb(gpioie, chip->base + GPIOIE);
+	spin_unlock(&chip->lock);
+}
 
-	chip->irq_gc = irq_alloc_generic_chip("gpio-pl061", 1, irq_base,
-					      chip->base, handle_simple_irq);
-	chip->irq_gc->private = chip;
+static void pl061_irq_unmask(struct irq_data *d)
+{
+	struct pl061_gpio *chip = irq_data_get_irq_chip_data(d);
+	u8 mask = 1 << (irqd_to_hwirq(d) % PL061_GPIO_NR);
+	u8 gpioie;
+
+	spin_lock(&chip->lock);
+	gpioie = readb(chip->base + GPIOIE) | mask;
+	writeb(gpioie, chip->base + GPIOIE);
+	spin_unlock(&chip->lock);
+}
+
+static struct irq_chip pl061_irqchip = {
+	.name		= "pl061 gpio",
+	.irq_mask	= pl061_irq_mask,
+	.irq_unmask	= pl061_irq_unmask,
+	.irq_set_type	= pl061_irq_type,
+};
+
+static int pl061_irq_map(struct irq_domain *d, unsigned int virq,
+			 irq_hw_number_t hw)
+{
+	struct pl061_gpio *chip = d->host_data;
 
-	ct = chip->irq_gc->chip_types;
-	ct->chip.irq_mask = irq_gc_mask_clr_bit;
-	ct->chip.irq_unmask = irq_gc_mask_set_bit;
-	ct->chip.irq_set_type = pl061_irq_type;
-	ct->chip.irq_set_wake = irq_gc_set_wake;
-	ct->regs.mask = GPIOIE;
+	irq_set_chip_and_handler_name(virq, &pl061_irqchip, handle_simple_irq,
+				      "pl061");
+	irq_set_chip_data(virq, chip);
+	irq_set_irq_type(virq, IRQ_TYPE_NONE);
 
-	irq_setup_generic_chip(chip->irq_gc, IRQ_MSK(PL061_GPIO_NR),
-			       IRQ_GC_INIT_NESTED_LOCK, IRQ_NOREQUEST, 0);
+	return 0;
 }
 
+static const struct irq_domain_ops pl061_domain_ops = {
+	.map	= pl061_irq_map,
+	.xlate	= irq_domain_xlate_twocell,
+};
+
 static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct device *dev = &adev->dev;
 	struct pl061_platform_data *pdata = dev->platform_data;
 	struct pl061_gpio *chip;
-	int ret, irq, i;
+	int ret, irq, i, irq_base;
 
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
@@ -224,22 +250,28 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 
 	if (pdata) {
 		chip->gc.base = pdata->gpio_base;
-		chip->irq_base = pdata->irq_base;
-	} else if (adev->dev.of_node) {
+		irq_base = pdata->irq_base;
+		if (irq_base <= 0)
+			return -ENODEV;
+	} else {
 		chip->gc.base = -1;
-		chip->irq_base = 0;
-	} else
-		return -ENODEV;
+		irq_base = 0;
+	}
 
 	if (!devm_request_mem_region(dev, adev->res.start,
-				resource_size(&adev->res), "pl061"))
+				     resource_size(&adev->res), "pl061"))
 		return -EBUSY;
 
 	chip->base = devm_ioremap(dev, adev->res.start,
-				resource_size(&adev->res));
-	if (chip->base == NULL)
+				  resource_size(&adev->res));
+	if (!chip->base)
 		return -ENOMEM;
 
+	chip->domain = irq_domain_add_simple(adev->dev.of_node, PL061_GPIO_NR,
+					     irq_base, &pl061_domain_ops, chip);
+	if (!chip->domain)
+		return -ENODEV;
+
 	spin_lock_init(&chip->lock);
 
 	chip->gc.direction_input = pl061_direction_input;
@@ -259,12 +291,6 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 	/*
 	 * irq_chip support
 	 */
-
-	if (chip->irq_base <= 0)
-		return 0;
-
-	pl061_init_gc(chip, chip->irq_base);
-
 	writeb(0, chip->base + GPIOIE); /* disable irqs */
 	irq = adev->irq[0];
 	if (irq < 0)
-- 
1.7.10.4
