From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Wed, 14 Dec 2011 01:50:22 +0530
Subject: [PATCH v9 20/31] gpio/omap: fix incorrect access of debounce module
In-Reply-To: <1323807633-23713-1-git-send-email-tarun.kanti@ti.com>
References: <1323807633-23713-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1323807633-23713-21-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable debounce clock before writing/reading debounce registers.
Disable the clock at the end so that it is synchronized with the
pm_runtime_get/put_sync calls.

Enable debounce clock per module. This call is mandatory because
in omap_gpio_request() when *_runtime_get_sync() is called,
_gpio_dbck_enable() within runtime callbck fails to turn on dbck
 because dbck_enable_mask used within _gpio_dbck_enable() is still
not initialized at that point. Therefore we have to enable dbck here.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 3a3e09a..7f32391 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -205,22 +205,30 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 
 	l = GPIO_BIT(bank, gpio);
 
+	clk_enable(bank->dbck);
 	reg = bank->base + bank->regs->debounce;
 	__raw_writel(debounce, reg);
 
 	reg = bank->base + bank->regs->debounce_en;
 	val = __raw_readl(reg);
 
-	if (debounce) {
+	if (debounce)
 		val |= l;
-		clk_enable(bank->dbck);
-	} else {
+	else
 		val &= ~l;
-		clk_disable(bank->dbck);
-	}
 	bank->dbck_enable_mask = val;
 
 	__raw_writel(val, reg);
+	clk_disable(bank->dbck);
+	/*
+	 * Enable debounce clock per module.
+	 * This call is mandatory because in omap_gpio_request() when
+	 * *_runtime_get_sync() is called,  _gpio_dbck_enable() within
+	 * runtime callbck fails to turn on dbck because dbck_enable_mask
+	 * used within _gpio_dbck_enable() is still not initialized at
+	 * that point. Therefore we have to enable dbck here.
+	 */
+	_gpio_dbck_enable(bank);
 }
 
 static inline void set_gpio_trigger(struct gpio_bank *bank, int gpio,
-- 
1.7.0.4
