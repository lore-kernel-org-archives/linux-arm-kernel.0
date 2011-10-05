From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Wed, 5 Oct 2011 14:03:07 +0530
Subject: [PATCH v8 18/24] gpio/omap: optimize suspend and resume functions
In-Reply-To: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1317803593-12259-19-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to operate on all the banks every time the function is called.
Just operate on the current bank passed by the framework.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |   54 ++++++++++++++++++++++++---------------------
 1 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 1ec35a1..d101438 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1068,6 +1068,8 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
+	platform_set_drvdata(pdev, bank);
+
 	pm_runtime_enable(bank->dev);
 	pm_runtime_irq_safe(bank->dev);
 	pm_runtime_get_sync(bank->dev);
@@ -1095,46 +1097,48 @@ err_exit:
 
 static int omap_gpio_suspend(struct device *dev)
 {
-	struct gpio_bank *bank;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	void __iomem *base = bank->base;
+	void __iomem *wakeup_enable;
+	unsigned long flags;
 
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		void __iomem *base = bank->base;
-		void __iomem *wake_status;
-		unsigned long flags;
+	if (!bank->mod_usage || !bank->loses_context)
+		return 0;
 
-		if (!bank->regs->wkup_en)
-			return 0;
+	if (!bank->regs->wkup_en || !bank->suspend_wakeup)
+		return 0;
 
-		wake_status = bank->base + bank->regs->wkup_en;
+	wakeup_enable = bank->base + bank->regs->wkup_en;
 
-		spin_lock_irqsave(&bank->lock, flags);
-		bank->saved_wakeup = __raw_readl(wake_status);
-		_gpio_rmw(base, bank->regs->wkup_en, bank->suspend_wakeup, 1);
-		spin_unlock_irqrestore(&bank->lock, flags);
+	spin_lock_irqsave(&bank->lock, flags);
+	bank->saved_wakeup = __raw_readl(wakeup_enable);
+	_gpio_rmw(base, bank->regs->wkup_en, bank->suspend_wakeup, 1);
+	spin_unlock_irqrestore(&bank->lock, flags);
 
-		_gpio_dbck_disable(bank);
-	}
+	_gpio_dbck_disable(bank);
 
 	return 0;
 }
 
 static int omap_gpio_resume(struct device *dev)
 {
-	struct gpio_bank *bank;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	void __iomem *base = bank->base;
+	unsigned long flags;
 
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		void __iomem *base = bank->base;
-		unsigned long flags;
+	if (!bank->mod_usage || !bank->loses_context)
+		return 0;
 
-		if (!bank->regs->wkup_en)
-			return 0;
+	if (!bank->regs->wkup_en || !bank->saved_wakeup)
+		return 0;
 
-		_gpio_dbck_enable(bank);
+	_gpio_dbck_enable(bank);
 
-		spin_lock_irqsave(&bank->lock, flags);
-		_gpio_rmw(base, bank->regs->wkup_en, bank->saved_wakeup, 1);
-		spin_unlock_irqrestore(&bank->lock, flags);
-	}
+	spin_lock_irqsave(&bank->lock, flags);
+	_gpio_rmw(base, bank->regs->wkup_en, bank->saved_wakeup, 1);
+	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
-- 
1.7.0.4
