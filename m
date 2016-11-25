From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Nov 2016 11:09:22 +0100
Subject: [PATCH 3/5] gpio: pl061: rename variable from chip to pl061
In-Reply-To: <1480068564-9447-1-git-send-email-linus.walleij@linaro.org>
References: <1480068564-9447-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1480068564-9447-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename the local variable "chip" referring to the struct pl061
state container to "pl061": we already have gpio_chip and irq_chip
in the driver, we are needlessly adding yet another "chip" to
the confusion.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-pl061.c | 186 +++++++++++++++++++++++-----------------------
 1 file changed, 93 insertions(+), 93 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index b944aaefb59f..47f397236417 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -64,22 +64,22 @@ struct pl061 {
 
 static int pl061_get_direction(struct gpio_chip *gc, unsigned offset)
 {
-	struct pl061 *chip = gpiochip_get_data(gc);
+	struct pl061 *pl061 = gpiochip_get_data(gc);
 
-	return !(readb(chip->base + GPIODIR) & BIT(offset));
+	return !(readb(pl061->base + GPIODIR) & BIT(offset));
 }
 
 static int pl061_direction_input(struct gpio_chip *gc, unsigned offset)
 {
-	struct pl061 *chip = gpiochip_get_data(gc);
+	struct pl061 *pl061 = gpiochip_get_data(gc);
 	unsigned long flags;
 	unsigned char gpiodir;
 
-	spin_lock_irqsave(&chip->lock, flags);
-	gpiodir = readb(chip->base + GPIODIR);
+	spin_lock_irqsave(&pl061->lock, flags);
+	gpiodir = readb(pl061->base + GPIODIR);
 	gpiodir &= ~(BIT(offset));
-	writeb(gpiodir, chip->base + GPIODIR);
-	spin_unlock_irqrestore(&chip->lock, flags);
+	writeb(gpiodir, pl061->base + GPIODIR);
+	spin_unlock_irqrestore(&pl061->lock, flags);
 
 	return 0;
 }
@@ -87,44 +87,44 @@ static int pl061_direction_input(struct gpio_chip *gc, unsigned offset)
 static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
 		int value)
 {
-	struct pl061 *chip = gpiochip_get_data(gc);
+	struct pl061 *pl061 = gpiochip_get_data(gc);
 	unsigned long flags;
 	unsigned char gpiodir;
 
-	spin_lock_irqsave(&chip->lock, flags);
-	writeb(!!value << offset, chip->base + (BIT(offset + 2)));
-	gpiodir = readb(chip->base + GPIODIR);
+	spin_lock_irqsave(&pl061->lock, flags);
+	writeb(!!value << offset, pl061->base + (BIT(offset + 2)));
+	gpiodir = readb(pl061->base + GPIODIR);
 	gpiodir |= BIT(offset);
-	writeb(gpiodir, chip->base + GPIODIR);
+	writeb(gpiodir, pl061->base + GPIODIR);
 
 	/*
 	 * gpio value is set again, because pl061 doesn't allow to set value of
 	 * a gpio pin before configuring it in OUT mode.
 	 */
-	writeb(!!value << offset, chip->base + (BIT(offset + 2)));
-	spin_unlock_irqrestore(&chip->lock, flags);
+	writeb(!!value << offset, pl061->base + (BIT(offset + 2)));
+	spin_unlock_irqrestore(&pl061->lock, flags);
 
 	return 0;
 }
 
 static int pl061_get_value(struct gpio_chip *gc, unsigned offset)
 {
-	struct pl061 *chip = gpiochip_get_data(gc);
+	struct pl061 *pl061 = gpiochip_get_data(gc);
 
-	return !!readb(chip->base + (BIT(offset + 2)));
+	return !!readb(pl061->base + (BIT(offset + 2)));
 }
 
 static void pl061_set_value(struct gpio_chip *gc, unsigned offset, int value)
 {
-	struct pl061 *chip = gpiochip_get_data(gc);
+	struct pl061 *pl061 = gpiochip_get_data(gc);
 
-	writeb(!!value << offset, chip->base + (BIT(offset + 2)));
+	writeb(!!value << offset, pl061->base + (BIT(offset + 2)));
 }
 
 static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct pl061 *chip = gpiochip_get_data(gc);
+	struct pl061 *pl061 = gpiochip_get_data(gc);
 	int offset = irqd_to_hwirq(d);
 	unsigned long flags;
 	u8 gpiois, gpioibe, gpioiev;
@@ -144,11 +144,11 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 	}
 
 
-	spin_lock_irqsave(&chip->lock, flags);
+	spin_lock_irqsave(&pl061->lock, flags);
 
-	gpioiev = readb(chip->base + GPIOIEV);
-	gpiois = readb(chip->base + GPIOIS);
-	gpioibe = readb(chip->base + GPIOIBE);
+	gpioiev = readb(pl061->base + GPIOIEV);
+	gpiois = readb(pl061->base + GPIOIS);
+	gpioibe = readb(pl061->base + GPIOIBE);
 
 	if (trigger & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW)) {
 		bool polarity = trigger & IRQ_TYPE_LEVEL_HIGH;
@@ -200,11 +200,11 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 			 offset);
 	}
 
-	writeb(gpiois, chip->base + GPIOIS);
-	writeb(gpioibe, chip->base + GPIOIBE);
-	writeb(gpioiev, chip->base + GPIOIEV);
+	writeb(gpiois, pl061->base + GPIOIS);
+	writeb(gpioibe, pl061->base + GPIOIBE);
+	writeb(gpioiev, pl061->base + GPIOIEV);
 
-	spin_unlock_irqrestore(&chip->lock, flags);
+	spin_unlock_irqrestore(&pl061->lock, flags);
 
 	return 0;
 }
@@ -214,12 +214,12 @@ static void pl061_irq_handler(struct irq_desc *desc)
 	unsigned long pending;
 	int offset;
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
-	struct pl061 *chip = gpiochip_get_data(gc);
+	struct pl061 *pl061 = gpiochip_get_data(gc);
 	struct irq_chip *irqchip = irq_desc_get_chip(desc);
 
 	chained_irq_enter(irqchip, desc);
 
-	pending = readb(chip->base + GPIOMIS);
+	pending = readb(pl061->base + GPIOMIS);
 	if (pending) {
 		for_each_set_bit(offset, &pending, PL061_GPIO_NR)
 			generic_handle_irq(irq_find_mapping(gc->irqdomain,
@@ -232,27 +232,27 @@ static void pl061_irq_handler(struct irq_desc *desc)
 static void pl061_irq_mask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct pl061 *chip = gpiochip_get_data(gc);
+	struct pl061 *pl061 = gpiochip_get_data(gc);
 	u8 mask = BIT(irqd_to_hwirq(d) % PL061_GPIO_NR);
 	u8 gpioie;
 
-	spin_lock(&chip->lock);
-	gpioie = readb(chip->base + GPIOIE) & ~mask;
-	writeb(gpioie, chip->base + GPIOIE);
-	spin_unlock(&chip->lock);
+	spin_lock(&pl061->lock);
+	gpioie = readb(pl061->base + GPIOIE) & ~mask;
+	writeb(gpioie, pl061->base + GPIOIE);
+	spin_unlock(&pl061->lock);
 }
 
 static void pl061_irq_unmask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct pl061 *chip = gpiochip_get_data(gc);
+	struct pl061 *pl061 = gpiochip_get_data(gc);
 	u8 mask = BIT(irqd_to_hwirq(d) % PL061_GPIO_NR);
 	u8 gpioie;
 
-	spin_lock(&chip->lock);
-	gpioie = readb(chip->base + GPIOIE) | mask;
-	writeb(gpioie, chip->base + GPIOIE);
-	spin_unlock(&chip->lock);
+	spin_lock(&pl061->lock);
+	gpioie = readb(pl061->base + GPIOIE) | mask;
+	writeb(gpioie, pl061->base + GPIOIE);
+	spin_unlock(&pl061->lock);
 }
 
 /**
@@ -266,20 +266,20 @@ static void pl061_irq_unmask(struct irq_data *d)
 static void pl061_irq_ack(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct pl061 *chip = gpiochip_get_data(gc);
+	struct pl061 *pl061 = gpiochip_get_data(gc);
 	u8 mask = BIT(irqd_to_hwirq(d) % PL061_GPIO_NR);
 
-	spin_lock(&chip->lock);
-	writeb(mask, chip->base + GPIOIC);
-	spin_unlock(&chip->lock);
+	spin_lock(&pl061->lock);
+	writeb(mask, pl061->base + GPIOIC);
+	spin_unlock(&pl061->lock);
 }
 
 static int pl061_irq_set_wake(struct irq_data *d, unsigned int state)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct pl061 *chip = gpiochip_get_data(gc);
+	struct pl061 *pl061 = gpiochip_get_data(gc);
 
-	return irq_set_irq_wake(chip->parent_irq, state);
+	return irq_set_irq_wake(pl061->parent_irq, state);
 }
 
 static struct irq_chip pl061_irqchip = {
@@ -295,81 +295,81 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct device *dev = &adev->dev;
 	struct pl061_platform_data *pdata = dev_get_platdata(dev);
-	struct pl061 *chip;
+	struct pl061 *pl061;
 	int ret, irq, i, irq_base;
 
-	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL)
+	pl061 = devm_kzalloc(dev, sizeof(*pl061), GFP_KERNEL);
+	if (pl061 == NULL)
 		return -ENOMEM;
 
 	if (pdata) {
-		chip->gc.base = pdata->gpio_base;
+		pl061->gc.base = pdata->gpio_base;
 		irq_base = pdata->irq_base;
 		if (irq_base <= 0) {
 			dev_err(&adev->dev, "invalid IRQ base in pdata\n");
 			return -ENODEV;
 		}
 	} else {
-		chip->gc.base = -1;
+		pl061->gc.base = -1;
 		irq_base = 0;
 	}
 
-	chip->base = devm_ioremap_resource(dev, &adev->res);
-	if (IS_ERR(chip->base))
-		return PTR_ERR(chip->base);
+	pl061->base = devm_ioremap_resource(dev, &adev->res);
+	if (IS_ERR(pl061->base))
+		return PTR_ERR(pl061->base);
 
-	spin_lock_init(&chip->lock);
+	spin_lock_init(&pl061->lock);
 	if (of_property_read_bool(dev->of_node, "gpio-ranges")) {
-		chip->gc.request = gpiochip_generic_request;
-		chip->gc.free = gpiochip_generic_free;
+		pl061->gc.request = gpiochip_generic_request;
+		pl061->gc.free = gpiochip_generic_free;
 	}
 
-	chip->gc.get_direction = pl061_get_direction;
-	chip->gc.direction_input = pl061_direction_input;
-	chip->gc.direction_output = pl061_direction_output;
-	chip->gc.get = pl061_get_value;
-	chip->gc.set = pl061_set_value;
-	chip->gc.ngpio = PL061_GPIO_NR;
-	chip->gc.label = dev_name(dev);
-	chip->gc.parent = dev;
-	chip->gc.owner = THIS_MODULE;
-
-	ret = gpiochip_add_data(&chip->gc, chip);
+	pl061->gc.get_direction = pl061_get_direction;
+	pl061->gc.direction_input = pl061_direction_input;
+	pl061->gc.direction_output = pl061_direction_output;
+	pl061->gc.get = pl061_get_value;
+	pl061->gc.set = pl061_set_value;
+	pl061->gc.ngpio = PL061_GPIO_NR;
+	pl061->gc.label = dev_name(dev);
+	pl061->gc.parent = dev;
+	pl061->gc.owner = THIS_MODULE;
+
+	ret = gpiochip_add_data(&pl061->gc, pl061);
 	if (ret)
 		return ret;
 
 	/*
 	 * irq_chip support
 	 */
-	writeb(0, chip->base + GPIOIE); /* disable irqs */
+	writeb(0, pl061->base + GPIOIE); /* disable irqs */
 	irq = adev->irq[0];
 	if (irq < 0) {
 		dev_err(&adev->dev, "invalid IRQ\n");
 		return -ENODEV;
 	}
-	chip->parent_irq = irq;
+	pl061->parent_irq = irq;
 
-	ret = gpiochip_irqchip_add(&chip->gc, &pl061_irqchip,
+	ret = gpiochip_irqchip_add(&pl061->gc, &pl061_irqchip,
 				   irq_base, handle_bad_irq,
 				   IRQ_TYPE_NONE);
 	if (ret) {
 		dev_info(&adev->dev, "could not add irqchip\n");
 		return ret;
 	}
-	gpiochip_set_chained_irqchip(&chip->gc, &pl061_irqchip,
+	gpiochip_set_chained_irqchip(&pl061->gc, &pl061_irqchip,
 				     irq, pl061_irq_handler);
 
 	for (i = 0; i < PL061_GPIO_NR; i++) {
 		if (pdata) {
 			if (pdata->directions & (BIT(i)))
-				pl061_direction_output(&chip->gc, i,
+				pl061_direction_output(&pl061->gc, i,
 						pdata->values & (BIT(i)));
 			else
-				pl061_direction_input(&chip->gc, i);
+				pl061_direction_input(&pl061->gc, i);
 		}
 	}
 
-	amba_set_drvdata(adev, chip);
+	amba_set_drvdata(adev, pl061);
 	dev_info(&adev->dev, "PL061 GPIO chip @%pa registered\n",
 		 &adev->res.start);
 
@@ -379,20 +379,20 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 #ifdef CONFIG_PM
 static int pl061_suspend(struct device *dev)
 {
-	struct pl061 *chip = dev_get_drvdata(dev);
+	struct pl061 *pl061 = dev_get_drvdata(dev);
 	int offset;
 
-	chip->csave_regs.gpio_data = 0;
-	chip->csave_regs.gpio_dir = readb(chip->base + GPIODIR);
-	chip->csave_regs.gpio_is = readb(chip->base + GPIOIS);
-	chip->csave_regs.gpio_ibe = readb(chip->base + GPIOIBE);
-	chip->csave_regs.gpio_iev = readb(chip->base + GPIOIEV);
-	chip->csave_regs.gpio_ie = readb(chip->base + GPIOIE);
+	pl061->csave_regs.gpio_data = 0;
+	pl061->csave_regs.gpio_dir = readb(pl061->base + GPIODIR);
+	pl061->csave_regs.gpio_is = readb(pl061->base + GPIOIS);
+	pl061->csave_regs.gpio_ibe = readb(pl061->base + GPIOIBE);
+	pl061->csave_regs.gpio_iev = readb(pl061->base + GPIOIEV);
+	pl061->csave_regs.gpio_ie = readb(pl061->base + GPIOIE);
 
 	for (offset = 0; offset < PL061_GPIO_NR; offset++) {
-		if (chip->csave_regs.gpio_dir & (BIT(offset)))
-			chip->csave_regs.gpio_data |=
-				pl061_get_value(&chip->gc, offset) << offset;
+		if (pl061->csave_regs.gpio_dir & (BIT(offset)))
+			pl061->csave_regs.gpio_data |=
+				pl061_get_value(&pl061->gc, offset) << offset;
 	}
 
 	return 0;
@@ -400,22 +400,22 @@ static int pl061_suspend(struct device *dev)
 
 static int pl061_resume(struct device *dev)
 {
-	struct pl061 *chip = dev_get_drvdata(dev);
+	struct pl061 *pl061 = dev_get_drvdata(dev);
 	int offset;
 
 	for (offset = 0; offset < PL061_GPIO_NR; offset++) {
-		if (chip->csave_regs.gpio_dir & (BIT(offset)))
-			pl061_direction_output(&chip->gc, offset,
-					chip->csave_regs.gpio_data &
+		if (pl061->csave_regs.gpio_dir & (BIT(offset)))
+			pl061_direction_output(&pl061->gc, offset,
+					pl061->csave_regs.gpio_data &
 					(BIT(offset)));
 		else
-			pl061_direction_input(&chip->gc, offset);
+			pl061_direction_input(&pl061->gc, offset);
 	}
 
-	writeb(chip->csave_regs.gpio_is, chip->base + GPIOIS);
-	writeb(chip->csave_regs.gpio_ibe, chip->base + GPIOIBE);
-	writeb(chip->csave_regs.gpio_iev, chip->base + GPIOIEV);
-	writeb(chip->csave_regs.gpio_ie, chip->base + GPIOIE);
+	writeb(pl061->csave_regs.gpio_is, pl061->base + GPIOIS);
+	writeb(pl061->csave_regs.gpio_ibe, pl061->base + GPIOIBE);
+	writeb(pl061->csave_regs.gpio_iev, pl061->base + GPIOIEV);
+	writeb(pl061->csave_regs.gpio_ie, pl061->base + GPIOIE);
 
 	return 0;
 }
-- 
2.7.4
