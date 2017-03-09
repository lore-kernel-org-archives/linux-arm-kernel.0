From: julia@ni.com (Julia Cartwright)
Date: Thu, 9 Mar 2017 10:22:05 -0600
Subject: [PATCH 18/19] pinctrl: sirf: atlas7: make use of raw_spinlock variants
In-Reply-To: <cover.1489015238.git.julia@ni.com>
References: <cover.1489015238.git.julia@ni.com>
Message-ID: <c68b030b8903bb1ca2f501b2e5c651d9206b1133.1489015238.git.julia@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sirf atlas7 pinctrl drivers currently implement an irq_chip for
handling interrupts; due to how irq_chip handling is done, it's
necessary for the irq_chip methods to be invoked from hardirq context,
even on a a real-time kernel.  Because the spinlock_t type becomes a
"sleeping" spinlock w/ RT kernels, it is not suitable to be used with
irq_chips.

A quick audit of the operations under the lock reveal that they do only
minimal, bounded work, and are therefore safe to do under a raw spinlock.

Signed-off-by: Julia Cartwright <julia@ni.com>
---
 drivers/pinctrl/sirf/pinctrl-atlas7.c | 44 +++++++++++++++++------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-atlas7.c b/drivers/pinctrl/sirf/pinctrl-atlas7.c
index 600d6427a978..1efa315a7dbe 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas7.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas7.c
@@ -352,7 +352,7 @@ struct atlas7_gpio_chip {
 	void __iomem *reg;
 	struct clk *clk;
 	int nbank;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct gpio_chip chip;
 	struct atlas7_gpio_bank banks[0];
 };
@@ -5650,13 +5650,13 @@ static void atlas7_gpio_irq_ack(struct irq_data *d)
 	pin_in_bank = d->hwirq - bank->gpio_offset;
 	ctrl_reg = ATLAS7_GPIO_CTRL(bank, pin_in_bank);
 
-	spin_lock_irqsave(&a7gc->lock, flags);
+	raw_spin_lock_irqsave(&a7gc->lock, flags);
 
 	val = readl(ctrl_reg);
 	/* clear interrupt status */
 	writel(val, ctrl_reg);
 
-	spin_unlock_irqrestore(&a7gc->lock, flags);
+	raw_spin_unlock_irqrestore(&a7gc->lock, flags);
 }
 
 static void __atlas7_gpio_irq_mask(struct atlas7_gpio_chip *a7gc, int idx)
@@ -5681,11 +5681,11 @@ static void atlas7_gpio_irq_mask(struct irq_data *d)
 	struct atlas7_gpio_chip *a7gc = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&a7gc->lock, flags);
+	raw_spin_lock_irqsave(&a7gc->lock, flags);
 
 	__atlas7_gpio_irq_mask(a7gc, d->hwirq);
 
-	spin_unlock_irqrestore(&a7gc->lock, flags);
+	raw_spin_unlock_irqrestore(&a7gc->lock, flags);
 }
 
 static void atlas7_gpio_irq_unmask(struct irq_data *d)
@@ -5701,14 +5701,14 @@ static void atlas7_gpio_irq_unmask(struct irq_data *d)
 	pin_in_bank = d->hwirq - bank->gpio_offset;
 	ctrl_reg = ATLAS7_GPIO_CTRL(bank, pin_in_bank);
 
-	spin_lock_irqsave(&a7gc->lock, flags);
+	raw_spin_lock_irqsave(&a7gc->lock, flags);
 
 	val = readl(ctrl_reg);
 	val &= ~ATLAS7_GPIO_CTL_INTR_STATUS_MASK;
 	val |= ATLAS7_GPIO_CTL_INTR_EN_MASK;
 	writel(val, ctrl_reg);
 
-	spin_unlock_irqrestore(&a7gc->lock, flags);
+	raw_spin_unlock_irqrestore(&a7gc->lock, flags);
 }
 
 static int atlas7_gpio_irq_type(struct irq_data *d,
@@ -5725,7 +5725,7 @@ static int atlas7_gpio_irq_type(struct irq_data *d,
 	pin_in_bank = d->hwirq - bank->gpio_offset;
 	ctrl_reg = ATLAS7_GPIO_CTRL(bank, pin_in_bank);
 
-	spin_lock_irqsave(&a7gc->lock, flags);
+	raw_spin_lock_irqsave(&a7gc->lock, flags);
 
 	val = readl(ctrl_reg);
 	val &= ~(ATLAS7_GPIO_CTL_INTR_STATUS_MASK |
@@ -5768,7 +5768,7 @@ static int atlas7_gpio_irq_type(struct irq_data *d,
 
 	writel(val, ctrl_reg);
 
-	spin_unlock_irqrestore(&a7gc->lock, flags);
+	raw_spin_unlock_irqrestore(&a7gc->lock, flags);
 
 	return 0;
 }
@@ -5863,7 +5863,7 @@ static int atlas7_gpio_request(struct gpio_chip *chip,
 	if (pinctrl_request_gpio(chip->base + gpio))
 		return -ENODEV;
 
-	spin_lock_irqsave(&a7gc->lock, flags);
+	raw_spin_lock_irqsave(&a7gc->lock, flags);
 
 	/*
 	 * default status:
@@ -5872,7 +5872,7 @@ static int atlas7_gpio_request(struct gpio_chip *chip,
 	__atlas7_gpio_set_input(a7gc, gpio);
 	__atlas7_gpio_irq_mask(a7gc, gpio);
 
-	spin_unlock_irqrestore(&a7gc->lock, flags);
+	raw_spin_unlock_irqrestore(&a7gc->lock, flags);
 
 	return 0;
 }
@@ -5883,12 +5883,12 @@ static void atlas7_gpio_free(struct gpio_chip *chip,
 	struct atlas7_gpio_chip *a7gc = gpiochip_get_data(chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&a7gc->lock, flags);
+	raw_spin_lock_irqsave(&a7gc->lock, flags);
 
 	__atlas7_gpio_irq_mask(a7gc, gpio);
 	__atlas7_gpio_set_input(a7gc, gpio);
 
-	spin_unlock_irqrestore(&a7gc->lock, flags);
+	raw_spin_unlock_irqrestore(&a7gc->lock, flags);
 
 	pinctrl_free_gpio(chip->base + gpio);
 }
@@ -5899,11 +5899,11 @@ static int atlas7_gpio_direction_input(struct gpio_chip *chip,
 	struct atlas7_gpio_chip *a7gc = gpiochip_get_data(chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&a7gc->lock, flags);
+	raw_spin_lock_irqsave(&a7gc->lock, flags);
 
 	__atlas7_gpio_set_input(a7gc, gpio);
 
-	spin_unlock_irqrestore(&a7gc->lock, flags);
+	raw_spin_unlock_irqrestore(&a7gc->lock, flags);
 
 	return 0;
 }
@@ -5936,11 +5936,11 @@ static int atlas7_gpio_direction_output(struct gpio_chip *chip,
 	struct atlas7_gpio_chip *a7gc = gpiochip_get_data(chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&a7gc->lock, flags);
+	raw_spin_lock_irqsave(&a7gc->lock, flags);
 
 	__atlas7_gpio_set_output(a7gc, gpio, value);
 
-	spin_unlock_irqrestore(&a7gc->lock, flags);
+	raw_spin_unlock_irqrestore(&a7gc->lock, flags);
 
 	return 0;
 }
@@ -5956,11 +5956,11 @@ static int atlas7_gpio_get_value(struct gpio_chip *chip,
 	bank = atlas7_gpio_to_bank(a7gc, gpio);
 	pin_in_bank = gpio - bank->gpio_offset;
 
-	spin_lock_irqsave(&a7gc->lock, flags);
+	raw_spin_lock_irqsave(&a7gc->lock, flags);
 
 	val = readl(ATLAS7_GPIO_CTRL(bank, pin_in_bank));
 
-	spin_unlock_irqrestore(&a7gc->lock, flags);
+	raw_spin_unlock_irqrestore(&a7gc->lock, flags);
 
 	return !!(val & ATLAS7_GPIO_CTL_DATAIN_MASK);
 }
@@ -5978,7 +5978,7 @@ static void atlas7_gpio_set_value(struct gpio_chip *chip,
 	pin_in_bank = gpio - bank->gpio_offset;
 	ctrl_reg = ATLAS7_GPIO_CTRL(bank, pin_in_bank);
 
-	spin_lock_irqsave(&a7gc->lock, flags);
+	raw_spin_lock_irqsave(&a7gc->lock, flags);
 
 	ctrl = readl(ctrl_reg);
 	if (value)
@@ -5987,7 +5987,7 @@ static void atlas7_gpio_set_value(struct gpio_chip *chip,
 		ctrl &= ~ATLAS7_GPIO_CTL_DATAOUT_MASK;
 	writel(ctrl, ctrl_reg);
 
-	spin_unlock_irqrestore(&a7gc->lock, flags);
+	raw_spin_unlock_irqrestore(&a7gc->lock, flags);
 }
 
 static const struct of_device_id atlas7_gpio_ids[] = {
@@ -6036,7 +6036,7 @@ static int atlas7_gpio_probe(struct platform_device *pdev)
 	}
 
 	a7gc->nbank = nbank;
-	spin_lock_init(&a7gc->lock);
+	raw_spin_lock_init(&a7gc->lock);
 
 	/* Setup GPIO Chip */
 	chip = &a7gc->chip;
-- 
2.11.1
