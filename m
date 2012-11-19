From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:51 +0100
Subject: [PATCH 13/30] dma: mv_xor: rename many symbols to remove the 'shared'
 word
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-14-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'shared' word no longer makes sense in a number of places as we
renamed the 'mv_xor_shared' driver to 'mv_xor'.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |   24 ++++++++++++------------
 drivers/dma/mv_xor.h |    4 ++--
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 0ed5183..49461b6 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1097,7 +1097,7 @@ static int mv_xor_channel_remove(struct mv_xor_device *device)
 }
 
 static struct mv_xor_device *
-mv_xor_channel_add(struct mv_xor_shared_private *msp,
+mv_xor_channel_add(struct mv_xor_private *msp,
 		   struct platform_device *pdev,
 		   int hw_id, dma_cap_mask_t cap_mask,
 		   size_t pool_size, int irq)
@@ -1220,7 +1220,7 @@ mv_xor_channel_add(struct mv_xor_shared_private *msp,
 }
 
 static void
-mv_xor_conf_mbus_windows(struct mv_xor_shared_private *msp,
+mv_xor_conf_mbus_windows(struct mv_xor_private *msp,
 			 const struct mbus_dram_target_info *dram)
 {
 	void __iomem *base = msp->xor_base;
@@ -1250,15 +1250,15 @@ mv_xor_conf_mbus_windows(struct mv_xor_shared_private *msp,
 	writel(win_enable, base + WINDOW_BAR_ENABLE(1));
 }
 
-static int mv_xor_shared_probe(struct platform_device *pdev)
+static int mv_xor_probe(struct platform_device *pdev)
 {
 	const struct mbus_dram_target_info *dram;
-	struct mv_xor_shared_private *msp;
+	struct mv_xor_private *msp;
 	struct mv_xor_platform_data *pdata = pdev->dev.platform_data;
 	struct resource *res;
 	int i, ret;
 
-	dev_notice(&pdev->dev, "Marvell shared XOR driver\n");
+	dev_notice(&pdev->dev, "Marvell XOR driver\n");
 
 	msp = devm_kzalloc(&pdev->dev, sizeof(*msp), GFP_KERNEL);
 	if (!msp)
@@ -1338,9 +1338,9 @@ err_channel_add:
 	return ret;
 }
 
-static int mv_xor_shared_remove(struct platform_device *pdev)
+static int mv_xor_remove(struct platform_device *pdev)
 {
-	struct mv_xor_shared_private *msp = platform_get_drvdata(pdev);
+	struct mv_xor_private *msp = platform_get_drvdata(pdev);
 	int i;
 
 	for (i = 0; i < MV_XOR_MAX_CHANNELS; i++) {
@@ -1356,9 +1356,9 @@ static int mv_xor_shared_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver mv_xor_shared_driver = {
-	.probe		= mv_xor_shared_probe,
-	.remove		= mv_xor_shared_remove,
+static struct platform_driver mv_xor_driver = {
+	.probe		= mv_xor_probe,
+	.remove		= mv_xor_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= MV_XOR_NAME,
@@ -1368,7 +1368,7 @@ static struct platform_driver mv_xor_shared_driver = {
 
 static int __init mv_xor_init(void)
 {
-	return platform_driver_register(&mv_xor_shared_driver);
+	return platform_driver_register(&mv_xor_driver);
 }
 module_init(mv_xor_init);
 
@@ -1376,7 +1376,7 @@ module_init(mv_xor_init);
 #if 0
 static void __exit mv_xor_exit(void)
 {
-	platform_driver_unregister(&mv_xor_shared_driver);
+	platform_driver_unregister(&mv_xor_driver);
 	return;
 }
 
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index 686575f..7812565 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -53,7 +53,7 @@
 #define WINDOW_REMAP_HIGH(w)	(0x290 + ((w) << 2))
 #define WINDOW_BAR_ENABLE(chan)	(0x240 + ((chan) << 2))
 
-struct mv_xor_shared_private {
+struct mv_xor_private {
 	void __iomem	     *xor_base;
 	void __iomem	     *xor_high_base;
 	struct clk	     *clk;
@@ -76,7 +76,7 @@ struct mv_xor_device {
 	void				*dma_desc_pool_virt;
 	size_t                          pool_size;
 	struct dma_device		common;
-	struct mv_xor_shared_private	*shared;
+	struct mv_xor_private	        *shared;
 };
 
 /**
-- 
1.7.9.5
