From: rsahu@apm.com (Rameshwar Prasad Sahu)
Date: Tue, 21 Jul 2015 18:44:39 +0530
Subject: [PATCH] dmaengine: xgene-dma: Add ACPI support for X-Gene DMA engine
 driver
Message-ID: <1437484479-2822-1-git-send-email-rsahu@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds ACPI support for the APM X-Gene DMA engine driver.

Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
---
 drivers/dma/xgene-dma.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index dff22ab..d0a148d 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -21,6 +21,7 @@
  * NOTE: PM support is currently not available.
  */

+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -1944,16 +1945,18 @@ static int xgene_dma_probe(struct platform_device *pdev)
 		return ret;

 	pdma->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(pdma->clk)) {
+	if (IS_ERR(pdma->clk) && !ACPI_COMPANION(&pdev->dev)) {
 		dev_err(&pdev->dev, "Failed to get clk\n");
 		return PTR_ERR(pdma->clk);
 	}

 	/* Enable clk before accessing registers */
-	ret = clk_prepare_enable(pdma->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to enable clk %d\n", ret);
-		return ret;
+	if (!IS_ERR(pdma->clk)) {
+		ret = clk_prepare_enable(pdma->clk);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to enable clk %d\n", ret);
+			return ret;
+		}
 	}

 	/* Remove DMA RAM out of shutdown */
@@ -1998,7 +2001,8 @@ err_request_irq:

 err_dma_mask:
 err_clk_enable:
-	clk_disable_unprepare(pdma->clk);
+	if (!IS_ERR(pdma->clk))
+		clk_disable_unprepare(pdma->clk);

 	return ret;
 }
@@ -2022,11 +2026,20 @@ static int xgene_dma_remove(struct platform_device *pdev)
 		xgene_dma_delete_chan_rings(chan);
 	}

-	clk_disable_unprepare(pdma->clk);
+	if (!IS_ERR(pdma->clk))
+		clk_disable_unprepare(pdma->clk);

 	return 0;
 }

+#ifdef CONFIG_ACPI
+static const struct acpi_device_id xgene_dma_acpi_match_ptr[] = {
+	{"APMC0D43", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, xgene_dma_acpi_match_ptr);
+#endif
+
 static const struct of_device_id xgene_dma_of_match_ptr[] = {
 	{.compatible = "apm,xgene-storm-dma",},
 	{},
@@ -2039,6 +2052,7 @@ static struct platform_driver xgene_dma_driver = {
 	.driver = {
 		.name = "X-Gene-DMA",
 		.of_match_table = xgene_dma_of_match_ptr,
+		.acpi_match_table = ACPI_PTR(xgene_dma_acpi_match_ptr),
 	},
 };

--
1.8.2.1
