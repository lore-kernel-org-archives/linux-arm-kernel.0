From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Thu, 22 Mar 2012 10:42:09 +0530
Subject: [PATCH v4 RESEND 6/7] gpio/omap: fix incorrect update to
 context.irqenable1
Message-ID: <1332393130-10636-1-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In _enable_gpio_irqbank() when bank->regs->set_irqenable is TRUE,
gpio_mask can be directly set by writing to set_irqenable register
without overwriting current value. In order to ensure the same is
stored in context.irqenable1, we must avoid overwriting it with
gpio_mask at the end of the function. Instead, update irqenable1
appropriately by OR'ing with gpio_mask.
For the case where bank->regs->set_irqenable is FALSE, irqenable1
can be directly overwritten with 'l' which holds correct computed
value.

        if (bank->regs->set_irqenable) {
                reg += bank->regs->set_irqenable;
                l = gpio_mask;
        } else {
                reg += bank->regs->irqenable;
                l = __raw_readl(reg);
                if (bank->regs->irqenable_inv)
                        l &= ~gpio_mask;
                else
                        l |= gpio_mask;
        }

Make similar change for _disable_gpio_irqbank().

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Updated change log as per Kevin's suggestion.

 drivers/gpio/gpio-omap.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index bcb1061..6c17e58 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -451,6 +451,7 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	if (bank->regs->set_irqenable) {
 		reg += bank->regs->set_irqenable;
 		l = gpio_mask;
+		bank->context.irqenable1 |= gpio_mask;
 	} else {
 		reg += bank->regs->irqenable;
 		l = __raw_readl(reg);
@@ -458,10 +459,10 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 			l &= ~gpio_mask;
 		else
 			l |= gpio_mask;
+		bank->context.irqenable1 = l;
 	}
 
 	__raw_writel(l, reg);
-	bank->context.irqenable1 = l;
 }
 
 static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
@@ -472,6 +473,7 @@ static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	if (bank->regs->clr_irqenable) {
 		reg += bank->regs->clr_irqenable;
 		l = gpio_mask;
+		bank->context.irqenable1 &= ~gpio_mask;
 	} else {
 		reg += bank->regs->irqenable;
 		l = __raw_readl(reg);
@@ -479,10 +481,10 @@ static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 			l |= gpio_mask;
 		else
 			l &= ~gpio_mask;
+		bank->context.irqenable1 = l;
 	}
 
 	__raw_writel(l, reg);
-	bank->context.irqenable1 = l;
 }
 
 static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int enable)
-- 
1.7.0.4
