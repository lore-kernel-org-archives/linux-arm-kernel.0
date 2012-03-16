From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Fri, 16 Mar 2012 19:35:57 +0530
Subject: [PATCH v4 09/12] gpio/omap: remove suspend/resume callbacks
In-Reply-To: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
References: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1331906760-5259-10-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both omap_gpio_suspend() and omap_gpio_resume() does programming
of wakeup_en register.
_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
_gpio_rmw(base, bank->regs->wkup_en, bank->context.wake_en, 1);

This is redundant in omap_gpio_suspend() because wakeup_en
register automatically gets initialized in _set_gpio_wakeup()
and set_gpio_trigger() while being called either from
chip.irq_set_wake() or chip.irq_set_type().

This is also redundant in omap_gpio_resume() because wakeup_en
register is programmed in omap_gpio_restore_context() called
which is called from runtime resume callback.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |   47 ----------------------------------------------
 1 files changed, 0 insertions(+), 47 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index cce2c73..dba69b8 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1142,50 +1142,6 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
 
-#if defined(CONFIG_PM_SLEEP)
-static int omap_gpio_suspend(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_bank *bank = platform_get_drvdata(pdev);
-	void __iomem *base = bank->base;
-	unsigned long flags;
-
-	if (!bank->mod_usage || !bank->loses_context)
-		return 0;
-
-	if (!bank->regs->wkup_en || !bank->context.wake_en)
-		return 0;
-
-	spin_lock_irqsave(&bank->lock, flags);
-	_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
-	_gpio_rmw(base, bank->regs->wkup_en, bank->context.wake_en, 1);
-	spin_unlock_irqrestore(&bank->lock, flags);
-
-	return 0;
-}
-
-static int omap_gpio_resume(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_bank *bank = platform_get_drvdata(pdev);
-	void __iomem *base = bank->base;
-	unsigned long flags;
-
-	if (!bank->mod_usage || !bank->loses_context)
-		return 0;
-
-	if (!bank->regs->wkup_en || !bank->context.wake_en)
-		return 0;
-
-	spin_lock_irqsave(&bank->lock, flags);
-	_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
-	_gpio_rmw(base, bank->regs->wkup_en, bank->context.wake_en, 1);
-	spin_unlock_irqrestore(&bank->lock, flags);
-
-	return 0;
-}
-#endif /* CONFIG_PM_SLEEP */
-
 #if defined(CONFIG_PM_RUNTIME)
 static void omap_gpio_restore_context(struct gpio_bank *bank);
 
@@ -1417,14 +1373,11 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 }
 #endif /* CONFIG_PM_RUNTIME */
 #else
-#define omap_gpio_suspend NULL
-#define omap_gpio_resume NULL
 #define omap_gpio_runtime_suspend NULL
 #define omap_gpio_runtime_resume NULL
 #endif
 
 static const struct dev_pm_ops gpio_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(omap_gpio_suspend, omap_gpio_resume)
 	SET_RUNTIME_PM_OPS(omap_gpio_runtime_suspend, omap_gpio_runtime_resume,
 									NULL)
 };
-- 
1.7.0.4
