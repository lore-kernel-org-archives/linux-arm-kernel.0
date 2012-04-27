From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Fri, 27 Apr 2012 19:43:34 +0530
Subject: [PATCH 4/8] gpio/omap: remove saved_wakeup field from struct gpio_bank
In-Reply-To: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1335536018-16004-5-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no more need to have saved_wakeup because bank->context.wake_en
already holds that value. So getting rid of read/write operation associated
with this field.

Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 drivers/gpio/gpio-omap.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 7b00256..cb9f6d9 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -57,7 +57,6 @@ struct gpio_bank {
 	u16 irq;
 	int irq_base;
 	struct irq_domain *domain;
-	u32 saved_wakeup;
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
 	struct gpio_regs context;
@@ -786,7 +785,6 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
 	unsigned long		flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
-	bank->saved_wakeup = __raw_readl(mask_reg);
 	__raw_writel(0xffff & ~bank->context.wake_en, mask_reg);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
@@ -802,7 +800,7 @@ static int omap_mpuio_resume_noirq(struct device *dev)
 	unsigned long		flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
-	__raw_writel(bank->saved_wakeup, mask_reg);
+	__raw_writel(bank->context.wake_en, mask_reg);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -1158,7 +1156,6 @@ static int omap_gpio_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct gpio_bank *bank = platform_get_drvdata(pdev);
 	void __iomem *base = bank->base;
-	void __iomem *wakeup_enable;
 	unsigned long flags;
 
 	if (!bank->mod_usage || !bank->loses_context)
@@ -1167,10 +1164,7 @@ static int omap_gpio_suspend(struct device *dev)
 	if (!bank->regs->wkup_en || !bank->context.wake_en)
 		return 0;
 
-	wakeup_enable = bank->base + bank->regs->wkup_en;
-
 	spin_lock_irqsave(&bank->lock, flags);
-	bank->saved_wakeup = __raw_readl(wakeup_enable);
 	_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
 	_gpio_rmw(base, bank->regs->wkup_en, bank->context.wake_en, 1);
 	spin_unlock_irqrestore(&bank->lock, flags);
@@ -1188,12 +1182,12 @@ static int omap_gpio_resume(struct device *dev)
 	if (!bank->mod_usage || !bank->loses_context)
 		return 0;
 
-	if (!bank->regs->wkup_en || !bank->saved_wakeup)
+	if (!bank->regs->wkup_en || !bank->context.wake_en)
 		return 0;
 
 	spin_lock_irqsave(&bank->lock, flags);
 	_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
-	_gpio_rmw(base, bank->regs->wkup_en, bank->saved_wakeup, 1);
+	_gpio_rmw(base, bank->regs->wkup_en, bank->context.wake_en, 1);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
-- 
1.7.0.4
