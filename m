From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Tue, 20 Mar 2012 16:23:18 +0530
Subject: [PATCH v4 RESEND 6/7] gpio/omap: fix incorrect update to
 context.irqenable1
In-Reply-To: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
References: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1332240799-6748-7-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In _enable_gpio_irqbank() when bank->regs->set_irqenable is valid,
gpio_mask can be directly set by writing to set_irqenable register
without overwriting current value. In order to ensure the same is
stored in context.irqenable1, we must read from regs->irqenable
instead of overwriting it with gpio_mask.
The overwriting makes sense only in the second case where irqenable
is explicitly read and updated with new gpio_mask before writing it
back. However, for consistency reading regs->irqenable into the
bank->context.irqenable1 takes care of both the scenarios.

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

Make the same change for _disable_gpio_irqbank().

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
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
