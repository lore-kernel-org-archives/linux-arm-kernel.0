From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 4 May 2010 09:23:09 +0530
Subject: [PATCH 1/4] nomadik-gpio: fix mask/unmask
Message-ID: <1272945192-23742-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mask/unmask should modify the interrupt mask register (RIMSC
and FIMSC) not the wakeup mask registers (RWIMSC and FWIMSC).

Acked-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 66381ff..df3a3da 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -124,14 +124,14 @@ static void nmk_gpio_irq_mask(unsigned int irq)
 	/* we must individually clear the two edges */
 	spin_lock_irqsave(&nmk_chip->lock, flags);
 	if (nmk_chip->edge_rising & bitmask) {
-		reg = readl(nmk_chip->addr + NMK_GPIO_RWIMSC);
+		reg = readl(nmk_chip->addr + NMK_GPIO_RIMSC);
 		reg &= ~bitmask;
-		writel(reg, nmk_chip->addr + NMK_GPIO_RWIMSC);
+		writel(reg, nmk_chip->addr + NMK_GPIO_RIMSC);
 	}
 	if (nmk_chip->edge_falling & bitmask) {
-		reg = readl(nmk_chip->addr + NMK_GPIO_FWIMSC);
+		reg = readl(nmk_chip->addr + NMK_GPIO_FIMSC);
 		reg &= ~bitmask;
-		writel(reg, nmk_chip->addr + NMK_GPIO_FWIMSC);
+		writel(reg, nmk_chip->addr + NMK_GPIO_FIMSC);
 	}
 	spin_unlock_irqrestore(&nmk_chip->lock, flags);
 };
@@ -152,14 +152,14 @@ static void nmk_gpio_irq_unmask(unsigned int irq)
 	/* we must individually set the two edges */
 	spin_lock_irqsave(&nmk_chip->lock, flags);
 	if (nmk_chip->edge_rising & bitmask) {
-		reg = readl(nmk_chip->addr + NMK_GPIO_RWIMSC);
+		reg = readl(nmk_chip->addr + NMK_GPIO_RIMSC);
 		reg |= bitmask;
-		writel(reg, nmk_chip->addr + NMK_GPIO_RWIMSC);
+		writel(reg, nmk_chip->addr + NMK_GPIO_RIMSC);
 	}
 	if (nmk_chip->edge_falling & bitmask) {
-		reg = readl(nmk_chip->addr + NMK_GPIO_FWIMSC);
+		reg = readl(nmk_chip->addr + NMK_GPIO_FIMSC);
 		reg |= bitmask;
-		writel(reg, nmk_chip->addr + NMK_GPIO_FWIMSC);
+		writel(reg, nmk_chip->addr + NMK_GPIO_FIMSC);
 	}
 	spin_unlock_irqrestore(&nmk_chip->lock, flags);
 }
-- 
1.7.0
