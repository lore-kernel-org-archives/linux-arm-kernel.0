From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 4 May 2010 09:23:11 +0530
Subject: [PATCH 3/4] nomadik-gpio: don't enable in set_type
In-Reply-To: <1272945192-23742-1-git-send-email-rabin.vincent@stericsson.com>
References: <1272945192-23742-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1272945192-23742-3-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On this peripheral, setting the trigger type enables the interrupt, and
the current set_type() implementation unconditionally enables the
interrupt, even if it is called when the interrupt is disabled.  Fix
set_type() to:

 - if the interrupt is disabled, defer the actual trigger setting to
   when it is unmasked

 - if the interrupt is enabled, change the type immediately by clearing
   the old type and then re-enabling with the new type.

Acked-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 5253f3d..f4c680c 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -163,6 +163,7 @@ static void nmk_gpio_irq_unmask(unsigned int irq)
 
 static int nmk_gpio_irq_set_type(unsigned int irq, unsigned int type)
 {
+	bool enabled = !(irq_to_desc(irq)->status & IRQ_DISABLED);
 	int gpio;
 	struct nmk_gpio_chip *nmk_chip;
 	unsigned long flags;
@@ -181,19 +182,21 @@ static int nmk_gpio_irq_set_type(unsigned int irq, unsigned int type)
 
 	spin_lock_irqsave(&nmk_chip->lock, flags);
 
+	if (enabled)
+		__nmk_gpio_irq_modify(nmk_chip, gpio, false);
+
 	nmk_chip->edge_rising &= ~bitmask;
 	if (type & IRQ_TYPE_EDGE_RISING)
 		nmk_chip->edge_rising |= bitmask;
-	writel(nmk_chip->edge_rising, nmk_chip->addr + NMK_GPIO_RIMSC);
 
 	nmk_chip->edge_falling &= ~bitmask;
 	if (type & IRQ_TYPE_EDGE_FALLING)
 		nmk_chip->edge_falling |= bitmask;
-	writel(nmk_chip->edge_falling, nmk_chip->addr + NMK_GPIO_FIMSC);
 
-	spin_unlock_irqrestore(&nmk_chip->lock, flags);
+	if (enabled)
+		__nmk_gpio_irq_modify(nmk_chip, gpio, true);
 
-	nmk_gpio_irq_unmask(irq);
+	spin_unlock_irqrestore(&nmk_chip->lock, flags);
 
 	return 0;
 }
-- 
1.7.0
