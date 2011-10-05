From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Wed, 5 Oct 2011 14:03:12 +0530
Subject: [PATCH v8 23/24] gpio/omap: restore OE only after setting the output
	level
In-Reply-To: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1317803593-12259-24-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

Setup the dataout register before restoring OE. This is to make
sure that we have valid data in dataout register which would be
made available in output pins as soon as OE is enabled. Else,
there is risk of unknown data getting out into gpio pins.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index bb1ff16..4009446 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1343,7 +1343,6 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 	__raw_writel(bank->context.wake_en,
 				bank->base + bank->regs->wkup_en);
 	__raw_writel(bank->context.ctrl, bank->base + bank->regs->ctrl);
-	__raw_writel(bank->context.oe, bank->base + bank->regs->direction);
 	__raw_writel(bank->context.leveldetect0,
 				bank->base + bank->regs->leveldetect0);
 	__raw_writel(bank->context.leveldetect1,
@@ -1353,6 +1352,8 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 	__raw_writel(bank->context.fallingdetect,
 				bank->base + bank->regs->fallingdetect);
 	__raw_writel(bank->context.dataout, bank->base + bank->regs->dataout);
+	__raw_writel(bank->context.oe, bank->base + bank->regs->direction);
+
 	if (bank->dbck_enable_mask) {
 		__raw_writel(bank->context.debounce, bank->base +
 					bank->regs->debounce);
-- 
1.7.0.4
