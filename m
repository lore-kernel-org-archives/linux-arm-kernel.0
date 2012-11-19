From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:05:01 +0100
Subject: [PATCH 23/30] dma: mv_xor: rename mv_xor_private to mv_xor_device
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-24-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that mv_xor_device is no longer used to designate the per-channel
DMA devices, use it know to designate the XOR engine themselves
(currently composed of two XOR channels).

So, now we have the nice organization where:

 - mv_xor_device represents each XOR engine in the system
 - mv_xor_chan   represents each XOR channel of a given XOR engine

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |   66 +++++++++++++++++++++++++-------------------------
 drivers/dma/mv_xor.h |    4 +--
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 3b81ee1..aec7719 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1086,7 +1086,7 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 }
 
 static struct mv_xor_chan *
-mv_xor_channel_add(struct mv_xor_private *msp,
+mv_xor_channel_add(struct mv_xor_device *xordev,
 		   struct platform_device *pdev,
 		   int hw_id, dma_cap_mask_t cap_mask,
 		   size_t pool_size, int irq)
@@ -1118,7 +1118,7 @@ mv_xor_channel_add(struct mv_xor_private *msp,
 
 	/* discover transaction capabilites from the platform data */
 	dma_dev->cap_mask = cap_mask;
-	mv_chan->shared = msp;
+	mv_chan->shared = xordev;
 
 	INIT_LIST_HEAD(&dma_dev->channels);
 
@@ -1139,7 +1139,7 @@ mv_xor_channel_add(struct mv_xor_private *msp,
 		dma_dev->device_prep_dma_xor = mv_xor_prep_dma_xor;
 	}
 
-	mv_chan->mmr_base = msp->xor_base;
+	mv_chan->mmr_base = xordev->xor_base;
 	if (!mv_chan->mmr_base) {
 		ret = -ENOMEM;
 		goto err_free_dma;
@@ -1200,10 +1200,10 @@ mv_xor_channel_add(struct mv_xor_private *msp,
 }
 
 static void
-mv_xor_conf_mbus_windows(struct mv_xor_private *msp,
+mv_xor_conf_mbus_windows(struct mv_xor_device *xordev,
 			 const struct mbus_dram_target_info *dram)
 {
-	void __iomem *base = msp->xor_base;
+	void __iomem *base = xordev->xor_base;
 	u32 win_enable = 0;
 	int i;
 
@@ -1233,50 +1233,50 @@ mv_xor_conf_mbus_windows(struct mv_xor_private *msp,
 static int mv_xor_probe(struct platform_device *pdev)
 {
 	const struct mbus_dram_target_info *dram;
-	struct mv_xor_private *msp;
+	struct mv_xor_device *xordev;
 	struct mv_xor_platform_data *pdata = pdev->dev.platform_data;
 	struct resource *res;
 	int i, ret;
 
 	dev_notice(&pdev->dev, "Marvell XOR driver\n");
 
-	msp = devm_kzalloc(&pdev->dev, sizeof(*msp), GFP_KERNEL);
-	if (!msp)
+	xordev = devm_kzalloc(&pdev->dev, sizeof(*xordev), GFP_KERNEL);
+	if (!xordev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
 
-	msp->xor_base = devm_ioremap(&pdev->dev, res->start,
-				     resource_size(res));
-	if (!msp->xor_base)
+	xordev->xor_base = devm_ioremap(&pdev->dev, res->start,
+					resource_size(res));
+	if (!xordev->xor_base)
 		return -EBUSY;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (!res)
 		return -ENODEV;
 
-	msp->xor_high_base = devm_ioremap(&pdev->dev, res->start,
-					  resource_size(res));
-	if (!msp->xor_high_base)
+	xordev->xor_high_base = devm_ioremap(&pdev->dev, res->start,
+					     resource_size(res));
+	if (!xordev->xor_high_base)
 		return -EBUSY;
 
-	platform_set_drvdata(pdev, msp);
+	platform_set_drvdata(pdev, xordev);
 
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
 	 */
 	dram = mv_mbus_dram_info();
 	if (dram)
-		mv_xor_conf_mbus_windows(msp, dram);
+		mv_xor_conf_mbus_windows(xordev, dram);
 
 	/* Not all platforms can gate the clock, so it is not
 	 * an error if the clock does not exists.
 	 */
-	msp->clk = clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(msp->clk))
-		clk_prepare_enable(msp->clk);
+	xordev->clk = clk_get(&pdev->dev, NULL);
+	if (!IS_ERR(xordev->clk))
+		clk_prepare_enable(xordev->clk);
 
 	if (pdata && pdata->channels) {
 		for (i = 0; i < MV_XOR_MAX_CHANNELS; i++) {
@@ -1295,12 +1295,12 @@ static int mv_xor_probe(struct platform_device *pdev)
 				goto err_channel_add;
 			}
 
-			msp->channels[i] =
-				mv_xor_channel_add(msp, pdev, cd->hw_id,
+			xordev->channels[i] =
+				mv_xor_channel_add(xordev, pdev, cd->hw_id,
 						   cd->cap_mask,
 						   cd->pool_size, irq);
-			if (IS_ERR(msp->channels[i])) {
-				ret = PTR_ERR(msp->channels[i]);
+			if (IS_ERR(xordev->channels[i])) {
+				ret = PTR_ERR(xordev->channels[i]);
 				goto err_channel_add;
 			}
 		}
@@ -1310,27 +1310,27 @@ static int mv_xor_probe(struct platform_device *pdev)
 
 err_channel_add:
 	for (i = 0; i < MV_XOR_MAX_CHANNELS; i++)
-		if (msp->channels[i])
-			mv_xor_channel_remove(msp->channels[i]);
+		if (xordev->channels[i])
+			mv_xor_channel_remove(xordev->channels[i]);
 
-	clk_disable_unprepare(msp->clk);
-	clk_put(msp->clk);
+	clk_disable_unprepare(xordev->clk);
+	clk_put(xordev->clk);
 	return ret;
 }
 
 static int mv_xor_remove(struct platform_device *pdev)
 {
-	struct mv_xor_private *msp = platform_get_drvdata(pdev);
+	struct mv_xor_device *xordev = platform_get_drvdata(pdev);
 	int i;
 
 	for (i = 0; i < MV_XOR_MAX_CHANNELS; i++) {
-		if (msp->channels[i])
-			mv_xor_channel_remove(msp->channels[i]);
+		if (xordev->channels[i])
+			mv_xor_channel_remove(xordev->channels[i]);
 	}
 
-	if (!IS_ERR(msp->clk)) {
-		clk_disable_unprepare(msp->clk);
-		clk_put(msp->clk);
+	if (!IS_ERR(xordev->clk)) {
+		clk_disable_unprepare(xordev->clk);
+		clk_put(xordev->clk);
 	}
 
 	return 0;
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index 16de1f6..cedeaa0 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -53,7 +53,7 @@
 #define WINDOW_REMAP_HIGH(w)	(0x290 + ((w) << 2))
 #define WINDOW_BAR_ENABLE(chan)	(0x240 + ((chan) << 2))
 
-struct mv_xor_private {
+struct mv_xor_device {
 	void __iomem	     *xor_base;
 	void __iomem	     *xor_high_base;
 	struct clk	     *clk;
@@ -87,7 +87,7 @@ struct mv_xor_chan {
 	void			*dma_desc_pool_virt;
 	size_t                  pool_size;
 	struct dma_device	dmadev;
-	struct mv_xor_private	*shared;
+	struct mv_xor_device	*shared;
 	struct dma_chan		dmachan;
 	struct mv_xor_desc_slot	*last_used;
 	struct list_head	all_slots;
-- 
1.7.9.5
