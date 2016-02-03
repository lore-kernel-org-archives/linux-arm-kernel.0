From: Gang.Liu@nxp.com (Liu Gang)
Date: Wed, 3 Feb 2016 19:27:34 +0800
Subject: [PATCH V4] drivers/gpio: Switch gpio-mpc8xxx to use gpio-generic
Message-ID: <1454498854-33169-1-git-send-email-Gang.Liu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new Layerscape platforms has the same ip block/controller
as GPIO on PowerPC platforms(MPC8XXX), but the GPIO registers
may be big or little endian. So the code needs to get the
endian property from DTB, then make additional functions to
fit all the PowerPC/Layerscape GPIO register read/write
operations.

gpio-generic.c provides an universal infrastructure for both
big and little endian register operations. So switch the
gpio-mpc8xxx to use gpio-generic can simplify the driver and
reduce a lot of code.

The IRQ and some workaround parts in gpio-mpc8xxx.c will be
updated with the new API interfaces but following the
original functionalities.

Signed-off-by: Liu Gang <Gang.Liu@nxp.com>
---
-V4: Rebase the kernel to v4.5-rc1 for the new gpio-generic
     infrastructure based on Linus Walleij comments.

 drivers/gpio/gpio-mpc8xxx.c | 259 +++++++++++++++++---------------------------
 1 file changed, 100 insertions(+), 159 deletions(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index 9d40787..ecdb27a 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -1,7 +1,8 @@
 /*
- * GPIOs on MPC512x/8349/8572/8610 and compatible
+ * GPIOs on MPC512x/8349/8572/8610/QorIQ and compatible
  *
  * Copyright (C) 2008 Peter Korsgaard <jacmet@sunsite.dk>
+ * Copyright (C) 2016 Freescale Semiconductor Inc.
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
@@ -14,11 +15,12 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/irq.h>
+#include <linux/gpio/driver.h>
 
 #define MPC8XXX_GPIO_PINS	32
 
@@ -31,32 +33,20 @@
 #define GPIO_ICR2		0x18
 
 struct mpc8xxx_gpio_chip {
-	struct of_mm_gpio_chip mm_gc;
+	struct gpio_chip	gc;
+	void __iomem *regs;
 	raw_spinlock_t lock;
 
-	/*
-	 * shadowed data register to be able to clear/set output pins in
-	 * open drain mode safely
-	 */
-	u32 data;
+	unsigned long (*read_reg)(void __iomem *reg);
+	void (*write_reg)(void __iomem *reg, unsigned long data);
+
+	int (*direction_output)(struct gpio_chip *chip,
+				unsigned offset, int value);
+
 	struct irq_domain *irq;
 	unsigned int irqn;
-	const void *of_dev_id_data;
 };
 
-static inline u32 mpc8xxx_gpio2mask(unsigned int gpio)
-{
-	return 1u << (MPC8XXX_GPIO_PINS - 1 - gpio);
-}
-
-static void mpc8xxx_gpio_save_regs(struct of_mm_gpio_chip *mm)
-{
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc =
-		container_of(mm, struct mpc8xxx_gpio_chip, mm_gc);
-
-	mpc8xxx_gc->data = in_be32(mm->regs + GPIO_DAT);
-}
-
 /* Workaround GPIO 1 errata on MPC8572/MPC8536. The status of GPIOs
  * defined as output cannot be determined by reading GPDAT register,
  * so we use shadow data register instead. The status of input pins
@@ -65,117 +55,36 @@ static void mpc8xxx_gpio_save_regs(struct of_mm_gpio_chip *mm)
 static int mpc8572_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 {
 	u32 val;
-	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = gpiochip_get_data(gc);
 	u32 out_mask, out_shadow;
 
-	out_mask = in_be32(mm->regs + GPIO_DIR);
-
-	val = in_be32(mm->regs + GPIO_DAT) & ~out_mask;
-	out_shadow = mpc8xxx_gc->data & out_mask;
+	out_mask = mpc8xxx_gc->read_reg(mpc8xxx_gc->regs + GPIO_DIR);
+	val = mpc8xxx_gc->read_reg(mpc8xxx_gc->regs + GPIO_DAT) & ~out_mask;
+	out_shadow = gc->bgpio_data & out_mask;
 
-	return !!((val | out_shadow) & mpc8xxx_gpio2mask(gpio));
+	return !!((val | out_shadow) & gc->pin2mask(gc, gpio));
 }
 
-static int mpc8xxx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+static int mpc5121_gpio_dir_out(struct gpio_chip *gc,
+				unsigned int gpio, int val)
 {
-	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
-
-	return in_be32(mm->regs + GPIO_DAT) & mpc8xxx_gpio2mask(gpio);
-}
-
-static void mpc8xxx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
-{
-	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = gpiochip_get_data(gc);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-
-	if (val)
-		mpc8xxx_gc->data |= mpc8xxx_gpio2mask(gpio);
-	else
-		mpc8xxx_gc->data &= ~mpc8xxx_gpio2mask(gpio);
-
-	out_be32(mm->regs + GPIO_DAT, mpc8xxx_gc->data);
-
-	raw_spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
-}
-
-static void mpc8xxx_gpio_set_multiple(struct gpio_chip *gc,
-				      unsigned long *mask, unsigned long *bits)
-{
-	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = gpiochip_get_data(gc);
-	unsigned long flags;
-	int i;
-
-	raw_spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-
-	for (i = 0; i < gc->ngpio; i++) {
-		if (*mask == 0)
-			break;
-		if (__test_and_clear_bit(i, mask)) {
-			if (test_bit(i, bits))
-				mpc8xxx_gc->data |= mpc8xxx_gpio2mask(i);
-			else
-				mpc8xxx_gc->data &= ~mpc8xxx_gpio2mask(i);
-		}
-	}
-
-	out_be32(mm->regs + GPIO_DAT, mpc8xxx_gc->data);
-
-	raw_spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
-}
-
-static int mpc8xxx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
-{
-	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = gpiochip_get_data(gc);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-
-	clrbits32(mm->regs + GPIO_DIR, mpc8xxx_gpio2mask(gpio));
-
-	raw_spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
-
-	return 0;
-}
-
-static int mpc8xxx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
-{
-	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = gpiochip_get_data(gc);
-	unsigned long flags;
-
-	mpc8xxx_gpio_set(gc, gpio, val);
-
-	raw_spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-
-	setbits32(mm->regs + GPIO_DIR, mpc8xxx_gpio2mask(gpio));
-
-	raw_spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
-
-	return 0;
-}
-
-static int mpc5121_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
-{
 	/* GPIO 28..31 are input only on MPC5121 */
 	if (gpio >= 28)
 		return -EINVAL;
 
-	return mpc8xxx_gpio_dir_out(gc, gpio, val);
+	return mpc8xxx_gc->direction_output(gc, gpio, val);
 }
 
-static int mpc5125_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+static int mpc5125_gpio_dir_out(struct gpio_chip *gc,
+				unsigned int gpio, int val)
 {
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = gpiochip_get_data(gc);
 	/* GPIO 0..3 are input only on MPC5125 */
 	if (gpio <= 3)
 		return -EINVAL;
 
-	return mpc8xxx_gpio_dir_out(gc, gpio, val);
+	return mpc8xxx_gc->direction_output(gc, gpio, val);
 }
 
 static int mpc8xxx_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
@@ -192,10 +101,10 @@ static void mpc8xxx_gpio_irq_cascade(struct irq_desc *desc)
 {
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 	unsigned int mask;
 
-	mask = in_be32(mm->regs + GPIO_IER) & in_be32(mm->regs + GPIO_IMR);
+	mask = mpc8xxx_gc->read_reg(mpc8xxx_gc->regs + GPIO_IER)
+		& mpc8xxx_gc->read_reg(mpc8xxx_gc->regs + GPIO_IMR);
 	if (mask)
 		generic_handle_irq(irq_linear_revmap(mpc8xxx_gc->irq,
 						     32 - ffs(mask)));
@@ -206,12 +115,14 @@ static void mpc8xxx_gpio_irq_cascade(struct irq_desc *desc)
 static void mpc8xxx_irq_unmask(struct irq_data *d)
 {
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
-	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
+	struct gpio_chip *gc = &mpc8xxx_gc->gc;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 
-	setbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(irqd_to_hwirq(d)));
+	mpc8xxx_gc->write_reg(mpc8xxx_gc->regs + GPIO_IMR,
+		mpc8xxx_gc->read_reg(mpc8xxx_gc->regs + GPIO_IMR)
+		| gc->pin2mask(gc, irqd_to_hwirq(d)));
 
 	raw_spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 }
@@ -219,12 +130,14 @@ static void mpc8xxx_irq_unmask(struct irq_data *d)
 static void mpc8xxx_irq_mask(struct irq_data *d)
 {
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
-	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
+	struct gpio_chip *gc = &mpc8xxx_gc->gc;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 
-	clrbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(irqd_to_hwirq(d)));
+	mpc8xxx_gc->write_reg(mpc8xxx_gc->regs + GPIO_IMR,
+		mpc8xxx_gc->read_reg(mpc8xxx_gc->regs + GPIO_IMR)
+		& ~(gc->pin2mask(gc, irqd_to_hwirq(d))));
 
 	raw_spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 }
@@ -232,29 +145,32 @@ static void mpc8xxx_irq_mask(struct irq_data *d)
 static void mpc8xxx_irq_ack(struct irq_data *d)
 {
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
-	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
+	struct gpio_chip *gc = &mpc8xxx_gc->gc;
 
-	out_be32(mm->regs + GPIO_IER, mpc8xxx_gpio2mask(irqd_to_hwirq(d)));
+	mpc8xxx_gc->write_reg(mpc8xxx_gc->regs + GPIO_IER,
+		gc->pin2mask(gc, irqd_to_hwirq(d)));
 }
 
 static int mpc8xxx_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
-	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
+	struct gpio_chip *gc = &mpc8xxx_gc->gc;
 	unsigned long flags;
 
 	switch (flow_type) {
 	case IRQ_TYPE_EDGE_FALLING:
 		raw_spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-		setbits32(mm->regs + GPIO_ICR,
-			  mpc8xxx_gpio2mask(irqd_to_hwirq(d)));
+		mpc8xxx_gc->write_reg(mpc8xxx_gc->regs + GPIO_ICR,
+			mpc8xxx_gc->read_reg(mpc8xxx_gc->regs + GPIO_ICR)
+			| gc->pin2mask(gc, irqd_to_hwirq(d)));
 		raw_spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 		break;
 
 	case IRQ_TYPE_EDGE_BOTH:
 		raw_spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-		clrbits32(mm->regs + GPIO_ICR,
-			  mpc8xxx_gpio2mask(irqd_to_hwirq(d)));
+		mpc8xxx_gc->write_reg(mpc8xxx_gc->regs + GPIO_ICR,
+			mpc8xxx_gc->read_reg(mpc8xxx_gc->regs + GPIO_ICR)
+			& ~(gc->pin2mask(gc, irqd_to_hwirq(d))));
 		raw_spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 		break;
 
@@ -268,17 +184,16 @@ static int mpc8xxx_irq_set_type(struct irq_data *d, unsigned int flow_type)
 static int mpc512x_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
-	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 	unsigned long gpio = irqd_to_hwirq(d);
 	void __iomem *reg;
 	unsigned int shift;
 	unsigned long flags;
 
 	if (gpio < 16) {
-		reg = mm->regs + GPIO_ICR;
+		reg = mpc8xxx_gc->regs + GPIO_ICR;
 		shift = (15 - gpio) * 2;
 	} else {
-		reg = mm->regs + GPIO_ICR2;
+		reg = mpc8xxx_gc->regs + GPIO_ICR2;
 		shift = (15 - (gpio % 16)) * 2;
 	}
 
@@ -286,20 +201,25 @@ static int mpc512x_irq_set_type(struct irq_data *d, unsigned int flow_type)
 	case IRQ_TYPE_EDGE_FALLING:
 	case IRQ_TYPE_LEVEL_LOW:
 		raw_spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-		clrsetbits_be32(reg, 3 << shift, 2 << shift);
+		mpc8xxx_gc->write_reg(reg,
+			(mpc8xxx_gc->read_reg(reg) & ~(3 << shift))
+			| (2 << shift));
 		raw_spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 		break;
 
 	case IRQ_TYPE_EDGE_RISING:
 	case IRQ_TYPE_LEVEL_HIGH:
 		raw_spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-		clrsetbits_be32(reg, 3 << shift, 1 << shift);
+		mpc8xxx_gc->write_reg(reg,
+			(mpc8xxx_gc->read_reg(reg) & ~(3 << shift))
+			| (1 << shift));
 		raw_spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 		break;
 
 	case IRQ_TYPE_EDGE_BOTH:
 		raw_spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-		clrbits32(reg, 3 << shift);
+		mpc8xxx_gc->write_reg(reg,
+			(mpc8xxx_gc->read_reg(reg) & ~(3 << shift)));
 		raw_spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 		break;
 
@@ -354,8 +274,6 @@ static const struct mpc8xxx_gpio_devtype mpc8572_gpio_devtype = {
 };
 
 static const struct mpc8xxx_gpio_devtype mpc8xxx_gpio_devtype_default = {
-	.gpio_dir_out = mpc8xxx_gpio_dir_out,
-	.gpio_get = mpc8xxx_gpio_get,
 	.irq_set_type = mpc8xxx_irq_set_type,
 };
 
@@ -374,9 +292,7 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc;
-	struct of_mm_gpio_chip *mm_gc;
-	struct gpio_chip *gc;
-	const struct of_device_id *id;
+	struct gpio_chip	*gc;
 	const struct mpc8xxx_gpio_devtype *devtype =
 		of_device_get_match_data(&pdev->dev);
 	int ret;
@@ -389,12 +305,35 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 
 	raw_spin_lock_init(&mpc8xxx_gc->lock);
 
-	mm_gc = &mpc8xxx_gc->mm_gc;
-	gc = &mm_gc->gc;
+	mpc8xxx_gc->regs = of_iomap(np, 0);
+	if (!mpc8xxx_gc->regs)
+		return -ENOMEM;
+
+	gc = &mpc8xxx_gc->gc;
+
+	if (of_property_read_bool(np, "little-endian")) {
+		ret = bgpio_init(gc, &pdev->dev, 4,
+				 mpc8xxx_gc->regs + GPIO_DAT,
+				 NULL, NULL,
+				 mpc8xxx_gc->regs + GPIO_DIR, NULL,
+				 BGPIOF_BIG_ENDIAN);
+		if (ret)
+			goto err;
+		dev_dbg(&pdev->dev, "GPIO registers are LITTLE endian\n");
+	} else {
+		ret = bgpio_init(gc, &pdev->dev, 4,
+				 mpc8xxx_gc->regs + GPIO_DAT,
+				 NULL, NULL,
+				 mpc8xxx_gc->regs + GPIO_DIR, NULL,
+				 BGPIOF_BIG_ENDIAN
+				 | BGPIOF_BIG_ENDIAN_BYTE_ORDER);
+		if (ret)
+			goto err;
+		dev_dbg(&pdev->dev, "GPIO registers are BIG endian\n");
+	}
 
-	mm_gc->save_regs = mpc8xxx_gpio_save_regs;
-	gc->ngpio = MPC8XXX_GPIO_PINS;
-	gc->direction_input = mpc8xxx_gpio_dir_in;
+	mpc8xxx_gc->read_reg = gc->read_reg;
+	mpc8xxx_gc->write_reg = gc->write_reg;
 
 	if (!devtype)
 		devtype = &mpc8xxx_gpio_devtype_default;
@@ -405,18 +344,21 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 	 */
 	mpc8xxx_irq_chip.irq_set_type = devtype->irq_set_type;
 
-	gc->direction_output = devtype->gpio_dir_out ?: mpc8xxx_gpio_dir_out;
-	gc->get = devtype->gpio_get ?: mpc8xxx_gpio_get;
-	gc->set = mpc8xxx_gpio_set;
-	gc->set_multiple = mpc8xxx_gpio_set_multiple;
+	gc->direction_output = devtype->gpio_dir_out ?: gc->direction_output;
+	gc->get = devtype->gpio_get ?: gc->get;
 	gc->to_irq = mpc8xxx_gpio_to_irq;
 
-	ret = of_mm_gpiochip_add_data(np, mm_gc, mpc8xxx_gc);
-	if (ret)
-		return ret;
+	mpc8xxx_gc->direction_output = gc->direction_output;
+
+	ret = gpiochip_add_data(gc, mpc8xxx_gc);
+	if (ret) {
+		pr_err("%s: GPIO chip registration failed with status %d\n",
+		       np->full_name, ret);
+		goto err;
+	}
 
 	mpc8xxx_gc->irqn = irq_of_parse_and_map(np, 0);
-	if (mpc8xxx_gc->irqn == NO_IRQ)
+	if (!mpc8xxx_gc->irqn)
 		return 0;
 
 	mpc8xxx_gc->irq = irq_domain_add_linear(np, MPC8XXX_GPIO_PINS,
@@ -424,18 +366,16 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 	if (!mpc8xxx_gc->irq)
 		return 0;
 
-	id = of_match_node(mpc8xxx_gpio_ids, np);
-	if (id)
-		mpc8xxx_gc->of_dev_id_data = id->data;
-
 	/* ack and mask all irqs */
-	out_be32(mm_gc->regs + GPIO_IER, 0xffffffff);
-	out_be32(mm_gc->regs + GPIO_IMR, 0);
+	mpc8xxx_gc->write_reg(mpc8xxx_gc->regs + GPIO_IER, 0xffffffff);
+	mpc8xxx_gc->write_reg(mpc8xxx_gc->regs + GPIO_IMR, 0);
 
 	irq_set_chained_handler_and_data(mpc8xxx_gc->irqn,
 					 mpc8xxx_gpio_irq_cascade, mpc8xxx_gc);
-
 	return 0;
+err:
+	iounmap(mpc8xxx_gc->regs);
+	return ret;
 }
 
 static int mpc8xxx_remove(struct platform_device *pdev)
@@ -447,7 +387,8 @@ static int mpc8xxx_remove(struct platform_device *pdev)
 		irq_domain_remove(mpc8xxx_gc->irq);
 	}
 
-	of_mm_gpiochip_remove(&mpc8xxx_gc->mm_gc);
+	gpiochip_remove(&mpc8xxx_gc->gc);
+	iounmap(mpc8xxx_gc->regs);
 
 	return 0;
 }
-- 
2.1.0.27.g96db324
