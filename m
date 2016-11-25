From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Nov 2016 11:09:20 +0100
Subject: [PATCH 1/5] gpio: pl061: use local state for parent IRQ storage
Message-ID: <1480068564-9447-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is poking around in the struct gpio_chip internals,
which is a no-no. Use a variable in the local state container.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-pl061.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 6e3c1430616f..8838a44351ce 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -55,6 +55,7 @@ struct pl061_gpio {
 
 	void __iomem		*base;
 	struct gpio_chip	gc;
+	int			parent_irq;
 
 #ifdef CONFIG_PM
 	struct pl061_context_save_regs csave_regs;
@@ -276,8 +277,9 @@ static void pl061_irq_ack(struct irq_data *d)
 static int pl061_irq_set_wake(struct irq_data *d, unsigned int state)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct pl061_gpio *chip = gpiochip_get_data(gc);
 
-	return irq_set_irq_wake(gc->irq_parent, state);
+	return irq_set_irq_wake(chip->parent_irq, state);
 }
 
 static struct irq_chip pl061_irqchip = {
@@ -345,6 +347,7 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 		dev_err(&adev->dev, "invalid IRQ\n");
 		return -ENODEV;
 	}
+	chip->parent_irq = irq;
 
 	ret = gpiochip_irqchip_add(&chip->gc, &pl061_irqchip,
 				   irq_base, handle_bad_irq,
-- 
2.7.4
