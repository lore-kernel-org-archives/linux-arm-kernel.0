From: julia@ni.com (Julia Cartwright)
Date: Thu, 9 Mar 2017 10:22:03 -0600
Subject: [PATCH 16/19] pinctrl: bcm: make use of raw_spinlock variants
In-Reply-To: <cover.1489015238.git.julia@ni.com>
References: <cover.1489015238.git.julia@ni.com>
Message-ID: <47cee188d7e2046b72f56bfc282fd601da237d3b.1489015238.git.julia@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bcm pinctrl drivers currently implement an irq_chip for handling
interrupts; due to how irq_chip handling is done, it's necessary for the
irq_chip methods to be invoked from hardirq context, even on a a
real-time kernel.  Because the spinlock_t type becomes a "sleeping"
spinlock w/ RT kernels, it is not suitable to be used with irq_chips.

A quick audit of the operations under the lock reveal that they do only
minimal, bounded work, and are therefore safe to do under a raw spinlock.

Signed-off-by: Julia Cartwright <julia@ni.com>
---
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c | 44 +++++++++++++++---------------
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c   | 46 ++++++++++++++++----------------
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
index 3ca925dfefd1..af5e904d4a1e 100644
--- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -99,7 +99,7 @@ struct iproc_gpio {
 	void __iomem *base;
 	void __iomem *io_ctrl;
 
-	spinlock_t lock;
+	raw_spinlock_t lock;
 
 	struct gpio_chip gc;
 	unsigned num_banks;
@@ -221,9 +221,9 @@ static void iproc_gpio_irq_mask(struct irq_data *d)
 	struct iproc_gpio *chip = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	iproc_gpio_irq_set_mask(d, false);
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 }
 
 static void iproc_gpio_irq_unmask(struct irq_data *d)
@@ -232,9 +232,9 @@ static void iproc_gpio_irq_unmask(struct irq_data *d)
 	struct iproc_gpio *chip = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	iproc_gpio_irq_set_mask(d, true);
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 }
 
 static int iproc_gpio_irq_set_type(struct irq_data *d, unsigned int type)
@@ -274,13 +274,13 @@ static int iproc_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	iproc_set_bit(chip, IPROC_GPIO_INT_TYPE_OFFSET, gpio,
 		       level_triggered);
 	iproc_set_bit(chip, IPROC_GPIO_INT_DE_OFFSET, gpio, dual_edge);
 	iproc_set_bit(chip, IPROC_GPIO_INT_EDGE_OFFSET, gpio,
 		       rising_or_high);
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 
 	dev_dbg(chip->dev,
 		"gpio:%u level_triggered:%d dual_edge:%d rising_or_high:%d\n",
@@ -328,9 +328,9 @@ static int iproc_gpio_direction_input(struct gpio_chip *gc, unsigned gpio)
 	struct iproc_gpio *chip = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	iproc_set_bit(chip, IPROC_GPIO_OUT_EN_OFFSET, gpio, false);
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 
 	dev_dbg(chip->dev, "gpio:%u set input\n", gpio);
 
@@ -343,10 +343,10 @@ static int iproc_gpio_direction_output(struct gpio_chip *gc, unsigned gpio,
 	struct iproc_gpio *chip = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	iproc_set_bit(chip, IPROC_GPIO_OUT_EN_OFFSET, gpio, true);
 	iproc_set_bit(chip, IPROC_GPIO_DATA_OUT_OFFSET, gpio, !!(val));
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 
 	dev_dbg(chip->dev, "gpio:%u set output, value:%d\n", gpio, val);
 
@@ -358,9 +358,9 @@ static void iproc_gpio_set(struct gpio_chip *gc, unsigned gpio, int val)
 	struct iproc_gpio *chip = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	iproc_set_bit(chip, IPROC_GPIO_DATA_OUT_OFFSET, gpio, !!(val));
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 
 	dev_dbg(chip->dev, "gpio:%u set, value:%d\n", gpio, val);
 }
@@ -461,7 +461,7 @@ static int iproc_gpio_set_pull(struct iproc_gpio *chip, unsigned gpio,
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 
 	if (disable) {
 		iproc_set_bit(chip, IPROC_GPIO_RES_EN_OFFSET, gpio, false);
@@ -471,7 +471,7 @@ static int iproc_gpio_set_pull(struct iproc_gpio *chip, unsigned gpio,
 		iproc_set_bit(chip, IPROC_GPIO_RES_EN_OFFSET, gpio, true);
 	}
 
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 
 	dev_dbg(chip->dev, "gpio:%u set pullup:%d\n", gpio, pull_up);
 
@@ -483,10 +483,10 @@ static void iproc_gpio_get_pull(struct iproc_gpio *chip, unsigned gpio,
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	*disable = !iproc_get_bit(chip, IPROC_GPIO_RES_EN_OFFSET, gpio);
 	*pull_up = iproc_get_bit(chip, IPROC_GPIO_PAD_RES_OFFSET, gpio);
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 }
 
 static int iproc_gpio_set_strength(struct iproc_gpio *chip, unsigned gpio,
@@ -515,7 +515,7 @@ static int iproc_gpio_set_strength(struct iproc_gpio *chip, unsigned gpio,
 	dev_dbg(chip->dev, "gpio:%u set drive strength:%d mA\n", gpio,
 		strength);
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	strength = (strength / 2) - 1;
 	for (i = 0; i < GPIO_DRV_STRENGTH_BITS; i++) {
 		val = readl(base + offset);
@@ -524,7 +524,7 @@ static int iproc_gpio_set_strength(struct iproc_gpio *chip, unsigned gpio,
 		writel(val, base + offset);
 		offset += 4;
 	}
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 
 	return 0;
 }
@@ -548,7 +548,7 @@ static int iproc_gpio_get_strength(struct iproc_gpio *chip, unsigned gpio,
 
 	shift = IPROC_GPIO_SHIFT(gpio);
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	*strength = 0;
 	for (i = 0; i < GPIO_DRV_STRENGTH_BITS; i++) {
 		val = readl(base + offset) & BIT(shift);
@@ -559,7 +559,7 @@ static int iproc_gpio_get_strength(struct iproc_gpio *chip, unsigned gpio,
 
 	/* convert to mA */
 	*strength = (*strength + 1) * 2;
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 
 	return 0;
 }
@@ -769,7 +769,7 @@ static int iproc_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	spin_lock_init(&chip->lock);
+	raw_spin_lock_init(&chip->lock);
 
 	gc = &chip->gc;
 	gc->base = -1;
diff --git a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
index 91ea32dc1e7f..22442438275a 100644
--- a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
@@ -73,7 +73,7 @@ struct nsp_gpio {
 	struct pinctrl_dev *pctl;
 	struct pinctrl_desc pctldesc;
 	struct irq_domain *irq_domain;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 };
 
 enum base_type {
@@ -203,9 +203,9 @@ static void nsp_gpio_irq_mask(struct irq_data *d)
 	struct nsp_gpio *chip = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	nsp_gpio_irq_set_mask(d, false);
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 }
 
 static void nsp_gpio_irq_unmask(struct irq_data *d)
@@ -213,9 +213,9 @@ static void nsp_gpio_irq_unmask(struct irq_data *d)
 	struct nsp_gpio *chip = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	nsp_gpio_irq_set_mask(d, true);
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 }
 
 static int nsp_gpio_irq_set_type(struct irq_data *d, unsigned int type)
@@ -226,7 +226,7 @@ static int nsp_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	bool falling;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	falling = nsp_get_bit(chip, REG, NSP_GPIO_EVENT_INT_POLARITY, gpio);
 	level_low = nsp_get_bit(chip, REG, NSP_GPIO_INT_POLARITY, gpio);
 
@@ -250,13 +250,13 @@ static int nsp_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	default:
 		dev_err(chip->dev, "invalid GPIO IRQ type 0x%x\n",
 			type);
-		spin_unlock_irqrestore(&chip->lock, flags);
+		raw_spin_unlock_irqrestore(&chip->lock, flags);
 		return -EINVAL;
 	}
 
 	nsp_set_bit(chip, REG, NSP_GPIO_EVENT_INT_POLARITY, gpio, falling);
 	nsp_set_bit(chip, REG, NSP_GPIO_INT_POLARITY, gpio, level_low);
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 
 	dev_dbg(chip->dev, "gpio:%u level_low:%s falling:%s\n", gpio,
 		level_low ? "true" : "false", falling ? "true" : "false");
@@ -295,9 +295,9 @@ static int nsp_gpio_direction_input(struct gpio_chip *gc, unsigned gpio)
 	struct nsp_gpio *chip = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	nsp_set_bit(chip, REG, NSP_GPIO_OUT_EN, gpio, false);
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 
 	dev_dbg(chip->dev, "gpio:%u set input\n", gpio);
 	return 0;
@@ -309,10 +309,10 @@ static int nsp_gpio_direction_output(struct gpio_chip *gc, unsigned gpio,
 	struct nsp_gpio *chip = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	nsp_set_bit(chip, REG, NSP_GPIO_OUT_EN, gpio, true);
 	nsp_set_bit(chip, REG, NSP_GPIO_DATA_OUT, gpio, !!(val));
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 
 	dev_dbg(chip->dev, "gpio:%u set output, value:%d\n", gpio, val);
 	return 0;
@@ -323,9 +323,9 @@ static void nsp_gpio_set(struct gpio_chip *gc, unsigned gpio, int val)
 	struct nsp_gpio *chip = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	nsp_set_bit(chip, REG, NSP_GPIO_DATA_OUT, gpio, !!(val));
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 
 	dev_dbg(chip->dev, "gpio:%u set, value:%d\n", gpio, val);
 }
@@ -381,10 +381,10 @@ static int nsp_gpio_set_pull(struct nsp_gpio *chip, unsigned gpio,
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	nsp_set_bit(chip, IO_CTRL, NSP_PULL_DOWN_EN, gpio, pull_down);
 	nsp_set_bit(chip, IO_CTRL, NSP_PULL_UP_EN, gpio, pull_up);
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 
 	dev_dbg(chip->dev, "gpio:%u set pullup:%d pulldown: %d\n",
 		gpio, pull_up, pull_down);
@@ -396,10 +396,10 @@ static void nsp_gpio_get_pull(struct nsp_gpio *chip, unsigned gpio,
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	*pull_up = nsp_get_bit(chip, IO_CTRL, NSP_PULL_UP_EN, gpio);
 	*pull_down = nsp_get_bit(chip, IO_CTRL, NSP_PULL_DOWN_EN, gpio);
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 }
 
 static int nsp_gpio_set_strength(struct nsp_gpio *chip, unsigned gpio,
@@ -417,7 +417,7 @@ static int nsp_gpio_set_strength(struct nsp_gpio *chip, unsigned gpio,
 	offset = NSP_GPIO_DRV_CTRL;
 	dev_dbg(chip->dev, "gpio:%u set drive strength:%d mA\n", gpio,
 		strength);
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	strength = (strength / 2) - 1;
 	for (i = GPIO_DRV_STRENGTH_BITS; i > 0; i--) {
 		val = readl(chip->io_ctrl + offset);
@@ -426,7 +426,7 @@ static int nsp_gpio_set_strength(struct nsp_gpio *chip, unsigned gpio,
 		writel(val, chip->io_ctrl + offset);
 		offset += 4;
 	}
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 
 	return 0;
 }
@@ -442,7 +442,7 @@ static int nsp_gpio_get_strength(struct nsp_gpio *chip, unsigned gpio,
 	offset = NSP_GPIO_DRV_CTRL;
 	shift = gpio;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	raw_spin_lock_irqsave(&chip->lock, flags);
 	*strength = 0;
 	for (i = (GPIO_DRV_STRENGTH_BITS - 1); i >= 0; i--) {
 		val = readl(chip->io_ctrl + offset) & BIT(shift);
@@ -453,7 +453,7 @@ static int nsp_gpio_get_strength(struct nsp_gpio *chip, unsigned gpio,
 
 	/* convert to mA */
 	*strength = (*strength + 1) * 2;
-	spin_unlock_irqrestore(&chip->lock, flags);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
 
 	return 0;
 }
@@ -660,7 +660,7 @@ static int nsp_gpio_probe(struct platform_device *pdev)
 		return PTR_ERR(chip->io_ctrl);
 	}
 
-	spin_lock_init(&chip->lock);
+	raw_spin_lock_init(&chip->lock);
 	gc = &chip->gc;
 	gc->base = -1;
 	gc->can_sleep = false;
-- 
2.11.1
