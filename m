From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 4 May 2010 09:23:10 +0530
Subject: [PATCH 2/4] nomadik-gpio: factor out helper to enable/disable irqs
In-Reply-To: <1272945192-23742-1-git-send-email-rabin.vincent@stericsson.com>
References: <1272945192-23742-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1272945192-23742-2-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove some nearly-duplicated code to make the following patch simpler.

Acked-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |   57 ++++++++++++++++++++----------------------
 1 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index df3a3da..5253f3d 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -108,40 +108,37 @@ static void nmk_gpio_irq_ack(unsigned int irq)
 	writel(nmk_gpio_get_bitmask(gpio), nmk_chip->addr + NMK_GPIO_IC);
 }
 
-static void nmk_gpio_irq_mask(unsigned int irq)
+static void __nmk_gpio_irq_modify(struct nmk_gpio_chip *nmk_chip,
+				  int gpio, bool enable)
 {
-	int gpio;
-	struct nmk_gpio_chip *nmk_chip;
-	unsigned long flags;
-	u32 bitmask, reg;
-
-	gpio = NOMADIK_IRQ_TO_GPIO(irq);
-	nmk_chip = get_irq_chip_data(irq);
-	bitmask = nmk_gpio_get_bitmask(gpio);
-	if (!nmk_chip)
-		return;
+	u32 bitmask = nmk_gpio_get_bitmask(gpio);
+	u32 reg;
 
-	/* we must individually clear the two edges */
-	spin_lock_irqsave(&nmk_chip->lock, flags);
+	/* we must individually set/clear the two edges */
 	if (nmk_chip->edge_rising & bitmask) {
 		reg = readl(nmk_chip->addr + NMK_GPIO_RIMSC);
-		reg &= ~bitmask;
+		if (enable)
+			reg |= bitmask;
+		else
+			reg &= ~bitmask;
 		writel(reg, nmk_chip->addr + NMK_GPIO_RIMSC);
 	}
 	if (nmk_chip->edge_falling & bitmask) {
 		reg = readl(nmk_chip->addr + NMK_GPIO_FIMSC);
-		reg &= ~bitmask;
+		if (enable)
+			reg |= bitmask;
+		else
+			reg &= ~bitmask;
 		writel(reg, nmk_chip->addr + NMK_GPIO_FIMSC);
 	}
-	spin_unlock_irqrestore(&nmk_chip->lock, flags);
-};
+}
 
-static void nmk_gpio_irq_unmask(unsigned int irq)
+static void nmk_gpio_irq_modify(unsigned int irq, bool enable)
 {
 	int gpio;
 	struct nmk_gpio_chip *nmk_chip;
 	unsigned long flags;
-	u32 bitmask, reg;
+	u32 bitmask;
 
 	gpio = NOMADIK_IRQ_TO_GPIO(irq);
 	nmk_chip = get_irq_chip_data(irq);
@@ -149,21 +146,21 @@ static void nmk_gpio_irq_unmask(unsigned int irq)
 	if (!nmk_chip)
 		return;
 
-	/* we must individually set the two edges */
 	spin_lock_irqsave(&nmk_chip->lock, flags);
-	if (nmk_chip->edge_rising & bitmask) {
-		reg = readl(nmk_chip->addr + NMK_GPIO_RIMSC);
-		reg |= bitmask;
-		writel(reg, nmk_chip->addr + NMK_GPIO_RIMSC);
-	}
-	if (nmk_chip->edge_falling & bitmask) {
-		reg = readl(nmk_chip->addr + NMK_GPIO_FIMSC);
-		reg |= bitmask;
-		writel(reg, nmk_chip->addr + NMK_GPIO_FIMSC);
-	}
+	__nmk_gpio_irq_modify(nmk_chip, gpio, enable);
 	spin_unlock_irqrestore(&nmk_chip->lock, flags);
 }
 
+static void nmk_gpio_irq_mask(unsigned int irq)
+{
+	nmk_gpio_irq_modify(irq, false);
+};
+
+static void nmk_gpio_irq_unmask(unsigned int irq)
+{
+	nmk_gpio_irq_modify(irq, true);
+}
+
 static int nmk_gpio_irq_set_type(unsigned int irq, unsigned int type)
 {
 	int gpio;
-- 
1.7.0
