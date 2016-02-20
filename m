From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 20 Feb 2016 20:06:49 +0100
Subject: [PATCH] reset: lpc18xx: get rid of global variables for restart
 notifier
Message-ID: <1455995209-5213-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving the notifier_block into the drivers priv struct allows us
to retrive the priv struct with container_of and remove the
global variables.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
Hi Philipp,

Just a simple clean up patch for lpc18xx reset controller.

 drivers/reset/reset-lpc18xx.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/reset/reset-lpc18xx.c b/drivers/reset/reset-lpc18xx.c
index 3b8a4f5a1ff6..54cca0055171 100644
--- a/drivers/reset/reset-lpc18xx.c
+++ b/drivers/reset/reset-lpc18xx.c
@@ -35,6 +35,7 @@
 
 struct lpc18xx_rgu_data {
 	struct reset_controller_dev rcdev;
+	struct notifier_block restart_nb;
 	struct clk *clk_delay;
 	struct clk *clk_reg;
 	void __iomem *base;
@@ -44,12 +45,13 @@ struct lpc18xx_rgu_data {
 
 #define to_rgu_data(p) container_of(p, struct lpc18xx_rgu_data, rcdev)
 
-static void __iomem *rgu_base;
-
-static int lpc18xx_rgu_restart(struct notifier_block *this, unsigned long mode,
+static int lpc18xx_rgu_restart(struct notifier_block *nb, unsigned long mode,
 			       void *cmd)
 {
-	writel(BIT(LPC18XX_RGU_CORE_RST), rgu_base + LPC18XX_RGU_CTRL0);
+	struct lpc18xx_rgu_data *rc = container_of(nb, struct lpc18xx_rgu_data,
+						   restart_nb);
+
+	writel(BIT(LPC18XX_RGU_CORE_RST), rc->base + LPC18XX_RGU_CTRL0);
 	mdelay(2000);
 
 	pr_emerg("%s: unable to restart system\n", __func__);
@@ -57,11 +59,6 @@ static int lpc18xx_rgu_restart(struct notifier_block *this, unsigned long mode,
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block lpc18xx_rgu_restart_nb = {
-	.notifier_call = lpc18xx_rgu_restart,
-	.priority = 192,
-};
-
 /*
  * The LPC18xx RGU has mostly self-deasserting resets except for the
  * two reset lines going to the internal Cortex-M0 cores.
@@ -205,8 +202,9 @@ static int lpc18xx_rgu_probe(struct platform_device *pdev)
 		goto dis_clks;
 	}
 
-	rgu_base = rc->base;
-	ret = register_restart_handler(&lpc18xx_rgu_restart_nb);
+	rc->restart_nb.priority = 192,
+	rc->restart_nb.notifier_call = lpc18xx_rgu_restart,
+	ret = register_restart_handler(&rc->restart_nb);
 	if (ret)
 		dev_warn(&pdev->dev, "failed to register restart handler\n");
 
@@ -225,7 +223,7 @@ static int lpc18xx_rgu_remove(struct platform_device *pdev)
 	struct lpc18xx_rgu_data *rc = platform_get_drvdata(pdev);
 	int ret;
 
-	ret = unregister_restart_handler(&lpc18xx_rgu_restart_nb);
+	ret = unregister_restart_handler(&rc->restart_nb);
 	if (ret)
 		dev_warn(&pdev->dev, "failed to unregister restart handler\n");
 
-- 
1.8.0
