From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Nov 2016 11:09:21 +0100
Subject: [PATCH 2/5] gpio: pl061: rename state container struct
In-Reply-To: <1480068564-9447-1-git-send-email-linus.walleij@linaro.org>
References: <1480068564-9447-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1480068564-9447-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PL061 state container is named "pl061_gpio", let's rename it
to simply pl061. Less is more.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-pl061.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 8838a44351ce..b944aaefb59f 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -50,7 +50,7 @@ struct pl061_context_save_regs {
 };
 #endif
 
-struct pl061_gpio {
+struct pl061 {
 	spinlock_t		lock;
 
 	void __iomem		*base;
@@ -64,14 +64,14 @@ struct pl061_gpio {
 
 static int pl061_get_direction(struct gpio_chip *gc, unsigned offset)
 {
-	struct pl061_gpio *chip = gpiochip_get_data(gc);
+	struct pl061 *chip = gpiochip_get_data(gc);
 
 	return !(readb(chip->base + GPIODIR) & BIT(offset));
 }
 
 static int pl061_direction_input(struct gpio_chip *gc, unsigned offset)
 {
-	struct pl061_gpio *chip = gpiochip_get_data(gc);
+	struct pl061 *chip = gpiochip_get_data(gc);
 	unsigned long flags;
 	unsigned char gpiodir;
 
@@ -87,7 +87,7 @@ static int pl061_direction_input(struct gpio_chip *gc, unsigned offset)
 static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
 		int value)
 {
-	struct pl061_gpio *chip = gpiochip_get_data(gc);
+	struct pl061 *chip = gpiochip_get_data(gc);
 	unsigned long flags;
 	unsigned char gpiodir;
 
@@ -109,14 +109,14 @@ static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
 
 static int pl061_get_value(struct gpio_chip *gc, unsigned offset)
 {
-	struct pl061_gpio *chip = gpiochip_get_data(gc);
+	struct pl061 *chip = gpiochip_get_data(gc);
 
 	return !!readb(chip->base + (BIT(offset + 2)));
 }
 
 static void pl061_set_value(struct gpio_chip *gc, unsigned offset, int value)
 {
-	struct pl061_gpio *chip = gpiochip_get_data(gc);
+	struct pl061 *chip = gpiochip_get_data(gc);
 
 	writeb(!!value << offset, chip->base + (BIT(offset + 2)));
 }
@@ -124,7 +124,7 @@ static void pl061_set_value(struct gpio_chip *gc, unsigned offset, int value)
 static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct pl061_gpio *chip = gpiochip_get_data(gc);
+	struct pl061 *chip = gpiochip_get_data(gc);
 	int offset = irqd_to_hwirq(d);
 	unsigned long flags;
 	u8 gpiois, gpioibe, gpioiev;
@@ -214,7 +214,7 @@ static void pl061_irq_handler(struct irq_desc *desc)
 	unsigned long pending;
 	int offset;
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
-	struct pl061_gpio *chip = gpiochip_get_data(gc);
+	struct pl061 *chip = gpiochip_get_data(gc);
 	struct irq_chip *irqchip = irq_desc_get_chip(desc);
 
 	chained_irq_enter(irqchip, desc);
@@ -232,7 +232,7 @@ static void pl061_irq_handler(struct irq_desc *desc)
 static void pl061_irq_mask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct pl061_gpio *chip = gpiochip_get_data(gc);
+	struct pl061 *chip = gpiochip_get_data(gc);
 	u8 mask = BIT(irqd_to_hwirq(d) % PL061_GPIO_NR);
 	u8 gpioie;
 
@@ -245,7 +245,7 @@ static void pl061_irq_mask(struct irq_data *d)
 static void pl061_irq_unmask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct pl061_gpio *chip = gpiochip_get_data(gc);
+	struct pl061 *chip = gpiochip_get_data(gc);
 	u8 mask = BIT(irqd_to_hwirq(d) % PL061_GPIO_NR);
 	u8 gpioie;
 
@@ -266,7 +266,7 @@ static void pl061_irq_unmask(struct irq_data *d)
 static void pl061_irq_ack(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct pl061_gpio *chip = gpiochip_get_data(gc);
+	struct pl061 *chip = gpiochip_get_data(gc);
 	u8 mask = BIT(irqd_to_hwirq(d) % PL061_GPIO_NR);
 
 	spin_lock(&chip->lock);
@@ -277,7 +277,7 @@ static void pl061_irq_ack(struct irq_data *d)
 static int pl061_irq_set_wake(struct irq_data *d, unsigned int state)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct pl061_gpio *chip = gpiochip_get_data(gc);
+	struct pl061 *chip = gpiochip_get_data(gc);
 
 	return irq_set_irq_wake(chip->parent_irq, state);
 }
@@ -295,7 +295,7 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct device *dev = &adev->dev;
 	struct pl061_platform_data *pdata = dev_get_platdata(dev);
-	struct pl061_gpio *chip;
+	struct pl061 *chip;
 	int ret, irq, i, irq_base;
 
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
@@ -379,7 +379,7 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 #ifdef CONFIG_PM
 static int pl061_suspend(struct device *dev)
 {
-	struct pl061_gpio *chip = dev_get_drvdata(dev);
+	struct pl061 *chip = dev_get_drvdata(dev);
 	int offset;
 
 	chip->csave_regs.gpio_data = 0;
@@ -400,7 +400,7 @@ static int pl061_suspend(struct device *dev)
 
 static int pl061_resume(struct device *dev)
 {
-	struct pl061_gpio *chip = dev_get_drvdata(dev);
+	struct pl061 *chip = dev_get_drvdata(dev);
 	int offset;
 
 	for (offset = 0; offset < PL061_GPIO_NR; offset++) {
-- 
2.7.4
