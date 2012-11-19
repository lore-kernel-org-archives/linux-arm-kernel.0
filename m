From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:42 +0100
Subject: [PATCH 04/30] dma: mv_xor: allow channels to be registered directly
 from the main device
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the XOR engine driver (currently called "mv_xor_shared") so
that XOR channels can be passed in the platform_data structure, and be
registered from there.

This will allow the users of the driver to be converted to the single
platform_driver variant of the mv_xor driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c                     |   45 ++++++++++++++++++++++++++++++
 drivers/dma/mv_xor.h                     |    8 ++++--
 include/linux/platform_data/dma-mv_xor.h |    3 ++
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index f7b9919..6ed3162 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1292,7 +1292,9 @@ static int mv_xor_shared_probe(struct platform_device *pdev)
 {
 	const struct mbus_dram_target_info *dram;
 	struct mv_xor_shared_private *msp;
+	struct mv_xor_shared_platform_data *pdata = pdev->dev.platform_data;
 	struct resource *res;
+	int i, ret;
 
 	dev_notice(&pdev->dev, "Marvell shared XOR driver\n");
 
@@ -1334,12 +1336,55 @@ static int mv_xor_shared_probe(struct platform_device *pdev)
 	if (!IS_ERR(msp->clk))
 		clk_prepare_enable(msp->clk);
 
+	if (pdata && pdata->channels) {
+		for (i = 0; i < MV_XOR_MAX_CHANNELS; i++) {
+			struct mv_xor_platform_data *cd;
+			int irq;
+
+			cd = &pdata->channels[i];
+			if (!cd) {
+				ret = -ENODEV;
+				goto err_channel_add;
+			}
+
+			irq = platform_get_irq(pdev, i);
+			if (irq < 0) {
+				ret = irq;
+				goto err_channel_add;
+			}
+
+			msp->channels[i] =
+				mv_xor_channel_add(msp, pdev, cd->hw_id,
+						   cd->cap_mask,
+						   cd->pool_size, irq);
+			if (IS_ERR(msp->channels[i])) {
+				ret = PTR_ERR(msp->channels[i]);
+				goto err_channel_add;
+			}
+		}
+	}
+
 	return 0;
+
+err_channel_add:
+	for (i = 0; i < MV_XOR_MAX_CHANNELS; i++)
+		if (msp->channels[i])
+			mv_xor_channel_remove(msp->channels[i]);
+
+	clk_disable_unprepare(msp->clk);
+	clk_put(msp->clk);
+	return ret;
 }
 
 static int mv_xor_shared_remove(struct platform_device *pdev)
 {
 	struct mv_xor_shared_private *msp = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < MV_XOR_MAX_CHANNELS; i++) {
+		if (msp->channels[i])
+			mv_xor_channel_remove(msp->channels[i]);
+	}
 
 	if (!IS_ERR(msp->clk)) {
 		clk_disable_unprepare(msp->clk);
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index a0641ae..686575f 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -26,6 +26,7 @@
 #define USE_TIMER
 #define MV_XOR_SLOT_SIZE		64
 #define MV_XOR_THRESHOLD		1
+#define MV_XOR_MAX_CHANNELS             2
 
 #define XOR_OPERATION_MODE_XOR		0
 #define XOR_OPERATION_MODE_MEMCPY	2
@@ -53,9 +54,10 @@
 #define WINDOW_BAR_ENABLE(chan)	(0x240 + ((chan) << 2))
 
 struct mv_xor_shared_private {
-	void __iomem	*xor_base;
-	void __iomem	*xor_high_base;
-	struct clk	*clk;
+	void __iomem	     *xor_base;
+	void __iomem	     *xor_high_base;
+	struct clk	     *clk;
+	struct mv_xor_device *channels[MV_XOR_MAX_CHANNELS];
 };
 
 
diff --git a/include/linux/platform_data/dma-mv_xor.h b/include/linux/platform_data/dma-mv_xor.h
index 2ba1f7d..f2aed97 100644
--- a/include/linux/platform_data/dma-mv_xor.h
+++ b/include/linux/platform_data/dma-mv_xor.h
@@ -20,5 +20,8 @@ struct mv_xor_platform_data {
 	size_t				pool_size;
 };
 
+struct mv_xor_shared_platform_data {
+	struct mv_xor_platform_data    *channels;
+};
 
 #endif
-- 
1.7.9.5
