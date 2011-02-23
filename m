From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Wed, 23 Feb 2011 18:24:50 +0530
Subject: [PATCH] nmk-gpio: use request_irq instead of chained handler
Message-ID: <1298465690-27077-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__nmk_gpio_irq_handler doesn't do anything more that what a normal handler
does, so it can become one.  This is also needed for changing the GIC
implementation to a different flow handler.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |   54 ++++++++++++++++++++---------------------
 1 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 45b1cf9..efa6737 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -651,22 +651,14 @@ static struct irq_chip nmk_gpio_irq_chip = {
 	.irq_set_wake	= nmk_gpio_irq_set_wake,
 };
 
-static void __nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc,
-				   u32 status)
+static irqreturn_t
+__nmk_gpio_irq_handler(struct nmk_gpio_chip *nmk_chip, u32 status)
 {
-	struct nmk_gpio_chip *nmk_chip;
-	struct irq_chip *host_chip = get_irq_chip(irq);
 	unsigned int first_irq;
 
-	if (host_chip->irq_mask_ack)
-		host_chip->irq_mask_ack(&desc->irq_data);
-	else {
-		host_chip->irq_mask(&desc->irq_data);
-		if (host_chip->irq_ack)
-			host_chip->irq_ack(&desc->irq_data);
-	}
+	if (!status)
+		return IRQ_NONE;
 
-	nmk_chip = get_irq_data(irq);
 	first_irq = NOMADIK_GPIO_TO_IRQ(nmk_chip->chip.base);
 	while (status) {
 		int bit = __ffs(status);
@@ -675,29 +667,30 @@ static void __nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc,
 		status &= ~BIT(bit);
 	}
 
-	host_chip->irq_unmask(&desc->irq_data);
+	return IRQ_HANDLED;
 }
 
-static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+static irqreturn_t nmk_gpio_irq_handler(int irq, void *dev_id)
 {
-	struct nmk_gpio_chip *nmk_chip = get_irq_data(irq);
+	struct nmk_gpio_chip *nmk_chip = dev_id;
 	u32 status = readl(nmk_chip->addr + NMK_GPIO_IS);
 
-	__nmk_gpio_irq_handler(irq, desc, status);
+	return __nmk_gpio_irq_handler(nmk_chip, status);
 }
 
-static void nmk_gpio_secondary_irq_handler(unsigned int irq,
-					   struct irq_desc *desc)
+static irqreturn_t nmk_gpio_secondary_irq_handler(int irq, void *dev_id)
 {
-	struct nmk_gpio_chip *nmk_chip = get_irq_data(irq);
+	struct nmk_gpio_chip *nmk_chip = dev_id;
 	u32 status = nmk_chip->get_secondary_status(nmk_chip->bank);
 
-	__nmk_gpio_irq_handler(irq, desc, status);
+	return __nmk_gpio_irq_handler(nmk_chip, status);
 }
 
-static int nmk_gpio_init_irq(struct nmk_gpio_chip *nmk_chip)
+static void nmk_gpio_init_irq(struct nmk_gpio_chip *nmk_chip)
 {
+	struct gpio_chip *gpio_chip = &nmk_chip->chip;
 	unsigned int first_irq;
+	int ret;
 	int i;
 
 	first_irq = NOMADIK_GPIO_TO_IRQ(nmk_chip->chip.base);
@@ -709,16 +702,21 @@ static int nmk_gpio_init_irq(struct nmk_gpio_chip *nmk_chip)
 		set_irq_type(i, IRQ_TYPE_EDGE_FALLING);
 	}
 
-	set_irq_chained_handler(nmk_chip->parent_irq, nmk_gpio_irq_handler);
-	set_irq_data(nmk_chip->parent_irq, nmk_chip);
+	ret = request_irq(nmk_chip->parent_irq, nmk_gpio_irq_handler,
+			  IRQF_NO_SUSPEND, gpio_chip->label, nmk_chip);
+	if (ret)
+		dev_err(gpio_chip->dev, "Unable to request IRQ%d: %d\n",
+			nmk_chip->parent_irq, ret);
 
 	if (nmk_chip->secondary_parent_irq >= 0) {
-		set_irq_chained_handler(nmk_chip->secondary_parent_irq,
-					nmk_gpio_secondary_irq_handler);
-		set_irq_data(nmk_chip->secondary_parent_irq, nmk_chip);
-	}
+		ret = request_irq(nmk_chip->secondary_parent_irq,
+				  nmk_gpio_secondary_irq_handler,
+				  IRQF_NO_SUSPEND, gpio_chip->label, nmk_chip);
 
-	return 0;
+		if (ret)
+			dev_err(gpio_chip->dev, "Unable to request secondary IRQ%d: %d\n",
+				nmk_chip->secondary_parent_irq, ret);
+	}
 }
 
 /* I/O Functions */
-- 
1.7.2.dirty
