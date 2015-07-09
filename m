From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 9 Jul 2015 18:15:46 +0800
Subject: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
Message-ID: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As since sama5d3, to reset the chip, we don't need to shutdown the ddr
controller.

So add a new compatible string and new restart function for sama5d3 and
later chips. As we don't use sama5d3 ddr controller, so remove it as
well.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---

 drivers/power/reset/at91-reset.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 36dc52f..8944b63 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -123,6 +123,14 @@ static int at91sam9g45_restart(struct notifier_block *this, unsigned long mode,
 	return NOTIFY_DONE;
 }
 
+static int sama5d3_restart(struct notifier_block *this, unsigned long mode,
+			void *cmd)
+{
+	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST),
+				at91_rstc_base);
+	return NOTIFY_DONE;
+}
+
 static void __init at91_reset_status(struct platform_device *pdev)
 {
 	u32 reg = readl(at91_rstc_base + AT91_RSTC_SR);
@@ -155,13 +163,13 @@ static void __init at91_reset_status(struct platform_device *pdev)
 static const struct of_device_id at91_ramc_of_match[] = {
 	{ .compatible = "atmel,at91sam9260-sdramc", },
 	{ .compatible = "atmel,at91sam9g45-ddramc", },
-	{ .compatible = "atmel,sama5d3-ddramc", },
 	{ /* sentinel */ }
 };
 
 static const struct of_device_id at91_reset_of_match[] = {
 	{ .compatible = "atmel,at91sam9260-rstc", .data = at91sam9260_restart },
 	{ .compatible = "atmel,at91sam9g45-rstc", .data = at91sam9g45_restart },
+	{ .compatible = "atmel,sama5d3-rstc", .data = sama5d3_restart },
 	{ /* sentinel */ }
 };
 
@@ -181,17 +189,21 @@ static int at91_reset_of_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	for_each_matching_node(np, at91_ramc_of_match) {
-		at91_ramc_base[idx] = of_iomap(np, 0);
-		if (!at91_ramc_base[idx]) {
-			dev_err(&pdev->dev, "Could not map ram controller address\n");
-			return -ENODEV;
+	match = of_match_node(at91_reset_of_match, pdev->dev.of_node);
+	at91_restart_nb.notifier_call = match->data;
+
+	if (match->data != sama5d3_restart) {
+		/* we need to shutdown the ddr controller, so get ramc base */
+		for_each_matching_node(np, at91_ramc_of_match) {
+			at91_ramc_base[idx] = of_iomap(np, 0);
+			if (!at91_ramc_base[idx]) {
+				dev_err(&pdev->dev, "Could not map ram controller address\n");
+				return -ENODEV;
+			}
+			idx++;
 		}
-		idx++;
 	}
 
-	match = of_match_node(at91_reset_of_match, pdev->dev.of_node);
-	at91_restart_nb.notifier_call = match->data;
 	return register_restart_handler(&at91_restart_nb);
 }
 
-- 
1.9.1
