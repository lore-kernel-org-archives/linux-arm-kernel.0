From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Thu, 10 Jun 2010 15:25:59 +0530
Subject: [PATCH 1/3] nomadik-gpio: implement set_wake
Message-ID: <1276163761-28342-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So that set_irq_wake() works.

Cc: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |   53 ++++++++++++++++++++++++++++++-----------
 1 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 12d1c7c..a98f618 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -301,32 +301,41 @@ static void nmk_gpio_irq_ack(unsigned int irq)
 	writel(nmk_gpio_get_bitmask(gpio), nmk_chip->addr + NMK_GPIO_IC);
 }
 
+enum nmk_gpio_irq_type {
+	NORMAL,
+	WAKE,
+};
+
 static void __nmk_gpio_irq_modify(struct nmk_gpio_chip *nmk_chip,
-				  int gpio, bool enable)
+				  int gpio, enum nmk_gpio_irq_type which,
+				  bool enable)
 {
+	u32 rimsc = which == WAKE ? NMK_GPIO_RWIMSC : NMK_GPIO_RIMSC;
+	u32 fimsc = which == WAKE ? NMK_GPIO_FWIMSC : NMK_GPIO_FIMSC;
 	u32 bitmask = nmk_gpio_get_bitmask(gpio);
 	u32 reg;
 
 	/* we must individually set/clear the two edges */
 	if (nmk_chip->edge_rising & bitmask) {
-		reg = readl(nmk_chip->addr + NMK_GPIO_RIMSC);
+		reg = readl(nmk_chip->addr + rimsc);
 		if (enable)
 			reg |= bitmask;
 		else
 			reg &= ~bitmask;
-		writel(reg, nmk_chip->addr + NMK_GPIO_RIMSC);
+		writel(reg, nmk_chip->addr + rimsc);
 	}
 	if (nmk_chip->edge_falling & bitmask) {
-		reg = readl(nmk_chip->addr + NMK_GPIO_FIMSC);
+		reg = readl(nmk_chip->addr + fimsc);
 		if (enable)
 			reg |= bitmask;
 		else
 			reg &= ~bitmask;
-		writel(reg, nmk_chip->addr + NMK_GPIO_FIMSC);
+		writel(reg, nmk_chip->addr + fimsc);
 	}
 }
 
-static void nmk_gpio_irq_modify(unsigned int irq, bool enable)
+static int nmk_gpio_irq_modify(unsigned int irq, enum nmk_gpio_irq_type which,
+			       bool enable)
 {
 	int gpio;
 	struct nmk_gpio_chip *nmk_chip;
@@ -337,26 +346,35 @@ static void nmk_gpio_irq_modify(unsigned int irq, bool enable)
 	nmk_chip = get_irq_chip_data(irq);
 	bitmask = nmk_gpio_get_bitmask(gpio);
 	if (!nmk_chip)
-		return;
+		return -EINVAL;
 
 	spin_lock_irqsave(&nmk_chip->lock, flags);
-	__nmk_gpio_irq_modify(nmk_chip, gpio, enable);
+	__nmk_gpio_irq_modify(nmk_chip, gpio, which, enable);
 	spin_unlock_irqrestore(&nmk_chip->lock, flags);
+
+	return 0;
 }
 
 static void nmk_gpio_irq_mask(unsigned int irq)
 {
-	nmk_gpio_irq_modify(irq, false);
-};
+	nmk_gpio_irq_modify(irq, NORMAL, false);
+}
 
 static void nmk_gpio_irq_unmask(unsigned int irq)
 {
-	nmk_gpio_irq_modify(irq, true);
+	nmk_gpio_irq_modify(irq, NORMAL, true);
+}
+
+static int nmk_gpio_irq_set_wake(unsigned int irq, unsigned int on)
+{
+	return nmk_gpio_irq_modify(irq, WAKE, on);
 }
 
 static int nmk_gpio_irq_set_type(unsigned int irq, unsigned int type)
 {
-	bool enabled = !(irq_to_desc(irq)->status & IRQ_DISABLED);
+	struct irq_desc *desc = irq_to_desc(irq);
+	bool enabled = !(desc->status & IRQ_DISABLED);
+	bool wake = desc->wake_depth;
 	int gpio;
 	struct nmk_gpio_chip *nmk_chip;
 	unsigned long flags;
@@ -376,7 +394,10 @@ static int nmk_gpio_irq_set_type(unsigned int irq, unsigned int type)
 	spin_lock_irqsave(&nmk_chip->lock, flags);
 
 	if (enabled)
-		__nmk_gpio_irq_modify(nmk_chip, gpio, false);
+		__nmk_gpio_irq_modify(nmk_chip, gpio, NORMAL, false);
+
+	if (wake)
+		__nmk_gpio_irq_modify(nmk_chip, gpio, WAKE, false);
 
 	nmk_chip->edge_rising &= ~bitmask;
 	if (type & IRQ_TYPE_EDGE_RISING)
@@ -387,7 +408,10 @@ static int nmk_gpio_irq_set_type(unsigned int irq, unsigned int type)
 		nmk_chip->edge_falling |= bitmask;
 
 	if (enabled)
-		__nmk_gpio_irq_modify(nmk_chip, gpio, true);
+		__nmk_gpio_irq_modify(nmk_chip, gpio, NORMAL, true);
+
+	if (wake)
+		__nmk_gpio_irq_modify(nmk_chip, gpio, WAKE, true);
 
 	spin_unlock_irqrestore(&nmk_chip->lock, flags);
 
@@ -400,6 +424,7 @@ static struct irq_chip nmk_gpio_irq_chip = {
 	.mask		= nmk_gpio_irq_mask,
 	.unmask		= nmk_gpio_irq_unmask,
 	.set_type	= nmk_gpio_irq_set_type,
+	.set_wake	= nmk_gpio_irq_set_wake,
 };
 
 static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
-- 
1.7.0
