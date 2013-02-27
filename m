From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Feb 2013 23:25:47 +0800
Subject: [PATCH 11/12] dma: mxs-dma: remove code left from generic DMA binding
 conversion
In-Reply-To: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1361978748-25281-12-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With all mxs-dma clients moved to use generic DMA helper, the code
left from generic DMA binding conversion can be removed now.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/dma/mxs-dma.c       |   23 -----------------------
 include/linux/fsl/mxs-dma.h |   20 --------------------
 2 files changed, 43 deletions(-)
 delete mode 100644 include/linux/fsl/mxs-dma.h

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 4edf8e9..62b4ba1 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -23,7 +23,6 @@
 #include <linux/dmaengine.h>
 #include <linux/delay.h>
 #include <linux/module.h>
-#include <linux/fsl/mxs-dma.h>
 #include <linux/stmp_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -198,24 +197,6 @@ static struct mxs_dma_chan *to_mxs_dma_chan(struct dma_chan *chan)
 	return container_of(chan, struct mxs_dma_chan, chan);
 }
 
-int mxs_dma_is_apbh(struct dma_chan *chan)
-{
-	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
-	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
-
-	return dma_is_apbh(mxs_dma);
-}
-EXPORT_SYMBOL_GPL(mxs_dma_is_apbh);
-
-int mxs_dma_is_apbx(struct dma_chan *chan)
-{
-	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
-	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
-
-	return !dma_is_apbh(mxs_dma);
-}
-EXPORT_SYMBOL_GPL(mxs_dma_is_apbx);
-
 static void mxs_dma_reset_chan(struct mxs_dma_chan *mxs_chan)
 {
 	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
@@ -350,13 +331,9 @@ static irqreturn_t mxs_dma_int_handler(int irq, void *dev_id)
 static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
-	struct mxs_dma_data *data = chan->private;
 	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
 	int ret;
 
-	if (data)
-		mxs_chan->chan_irq = data->chan_irq;
-
 	mxs_chan->ccw = dma_alloc_coherent(mxs_dma->dma_device.dev,
 				CCW_BLOCK_SIZE, &mxs_chan->ccw_phys,
 				GFP_KERNEL);
diff --git a/include/linux/fsl/mxs-dma.h b/include/linux/fsl/mxs-dma.h
deleted file mode 100644
index 55d8702..0000000
--- a/include/linux/fsl/mxs-dma.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __MACH_MXS_DMA_H__
-#define __MACH_MXS_DMA_H__
-
-#include <linux/dmaengine.h>
-
-struct mxs_dma_data {
-	int chan_irq;
-};
-
-extern int mxs_dma_is_apbh(struct dma_chan *chan);
-extern int mxs_dma_is_apbx(struct dma_chan *chan);
-#endif /* __MACH_MXS_DMA_H__ */
-- 
1.7.9.5
