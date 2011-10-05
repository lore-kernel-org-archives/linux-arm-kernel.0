From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Wed, 5 Oct 2011 14:03:13 +0530
Subject: [PATCH v8 24/24] gpio/omap: handle set_dataout reg capable IP on
	restore
In-Reply-To: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1317803593-12259-25-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

GPIO IP revisions such as those used in OMAP4 have a set_dataout
while the previous revisions used a single dataout register.
Depending on what is available restore the dataout settings
to the right register.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 4009446..3df7a98 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1073,7 +1073,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->get_context_loss_count = pdata->get_context_loss_count;
 	bank->regs = pdata->regs;
 
-	if (bank->regs->set_dataout && bank->regs->clr_dataout)
+	if (bank->regs->set_dataout)
 		bank->set_dataout = _set_gpio_dataout_reg;
 	else
 		bank->set_dataout = _set_gpio_dataout_mask;
@@ -1351,7 +1351,12 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 				bank->base + bank->regs->risingdetect);
 	__raw_writel(bank->context.fallingdetect,
 				bank->base + bank->regs->fallingdetect);
-	__raw_writel(bank->context.dataout, bank->base + bank->regs->dataout);
+	if (bank->regs->set_dataout)
+		__raw_writel(bank->context.dataout,
+				bank->base + bank->regs->set_dataout);
+	else
+		__raw_writel(bank->context.dataout,
+				bank->base + bank->regs->dataout);
 	__raw_writel(bank->context.oe, bank->base + bank->regs->direction);
 
 	if (bank->dbck_enable_mask) {
-- 
1.7.0.4
