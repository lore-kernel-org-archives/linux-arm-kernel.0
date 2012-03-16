From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Fri, 16 Mar 2012 19:35:59 +0530
Subject: [PATCH v4 11/12] gpio/omap: fix incorrect context restore logic in
 omap_gpio_runtime_*
In-Reply-To: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
References: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1331906760-5259-12-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In omap_gpio_runtime_suspend/resume() the context save/restore should
be independent of bank->enabled_non_wakeup_gpios. This was preventing
context restore of GPIO lines which are not wakeup enabled.

Reported-by: Govindraj Raja <govindraj.raja@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 072a841..c5aff7c 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1187,9 +1187,6 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 	 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
 	 * generated.  See OMAP2420 Errata item 1.101.
 	 */
-	if (!(bank->enabled_non_wakeup_gpios))
-		goto update_gpio_context_count;
-
 	bank->saved_datain = __raw_readl(bank->base +
 						bank->regs->datain);
 	l1 = bank->context.fallingdetect;
@@ -1236,7 +1233,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	__raw_writel(bank->context.risingdetect,
 		     bank->base + bank->regs->risingdetect);
 
-	if (!bank->enabled_non_wakeup_gpios || !bank->workaround_enabled) {
+	if (!bank->workaround_enabled) {
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
 	}
-- 
1.7.0.4
