From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Wed, 31 Aug 2011 19:12:38 +0530
Subject: [PATCH v6 22/25] gpio/omap: save and restore debounce registers
In-Reply-To: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1314798161-19523-23-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishant Menon <nm@ti.com>

GPIO debounce registers need to be saved and restored for proper functioning
of driver. To save the registers, we cannot cut the clock before the save,
hence move the clk disable after the save.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index dc382f6..67e08e9 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -41,6 +41,8 @@ struct gpio_regs {
 	u32 risingdetect;
 	u32 fallingdetect;
 	u32 dataout;
+	u32 debounce;
+	u32 debounce_en;
 };
 
 struct gpio_bank {
@@ -1158,9 +1160,6 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 	u32 l1 = 0, l2 = 0;
 	int j;
 
-	for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
-		clk_disable(bank->dbck);
-
 	if (!bank->mod_usage)
 		return 0;
 
@@ -1192,6 +1191,16 @@ update_gpio_context_count:
 		bank->context_loss_count =
 				bank->get_context_loss_count(bank->dev);
 
+	if (bank->dbck_enable_mask) {
+		bank->context.debounce = __raw_readl(bank->base +
+						bank->regs->debounce);
+		bank->context.debounce_en = __raw_readl(bank->base +
+						bank->regs->debounce_en);
+	}
+
+	for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
+		clk_disable(bank->dbck);
+
 	return 0;
 }
 
@@ -1331,6 +1340,13 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 	__raw_writel(bank->context.fallingdetect,
 				bank->base + bank->regs->fallingdetect);
 	__raw_writel(bank->context.dataout, bank->base + bank->regs->dataout);
+
+	if (bank->dbck_enable_mask) {
+		__raw_writel(bank->context.debounce, bank->base +
+					bank->regs->debounce);
+		__raw_writel(bank->context.debounce_en,
+					bank->base + bank->regs->debounce_en);
+	}
 }
 #else
 #define omap_gpio_runtime_suspend NULL
-- 
1.7.0.4
