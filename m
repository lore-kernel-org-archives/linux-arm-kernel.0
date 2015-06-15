From: stillcompiling@gmail.com (Joshua Clayton)
Date: Mon, 15 Jun 2015 09:19:03 -0700
Subject: [PATCH 08/10] dma: imx-sdma: extract common sdma prep code
In-Reply-To: <1434385144-4432-1-git-send-email-stillcompiling@gmail.com>
References: <1434385144-4432-1-git-send-email-stillcompiling@gmail.com>
Message-ID: <1434385144-4432-9-git-send-email-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extract the code that is equivalent between
the slave and cyclic sdma functions.
Add some better errors for failure conditions.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/dma/imx-sdma.c | 76 +++++++++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 44 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index c9badd4..4d447be 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1018,6 +1018,34 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 	return 0;
 }
 
+int sdma_prep_common(struct sdma_channel *sdmac, int buf_count,
+			enum dma_transfer_direction direction)
+{
+	struct sdma_engine *sdma = to_sdma_engine(sdmac);
+
+	if (sdmac->status == DMA_IN_PROGRESS) {
+		dev_err(sdma->dev, "SDMA channel %d: dma already in progress\n",
+				sdmac->channel);
+		return -EBUSY;
+	}
+
+	sdmac->status = DMA_IN_PROGRESS;
+	sdmac->buf_tail = 0;
+	sdmac->direction = direction;
+
+	dev_dbg(sdma->dev, "setting up %d entries for channel %d.\n",
+			buf_count, sdmac->channel);
+
+	if (buf_count > NUM_BD) {
+		dev_err(sdma->dev, "SDMA channel %d: maximum number of buffers exceeded: %d > %d\n",
+				sdmac->channel, buf_count, NUM_BD);
+		return -EINVAL;
+	}
+	sdmac->num_bd = buf_count;
+
+	return sdma_load_context(sdmac);
+}
+
 static void sdma_free_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
@@ -1053,28 +1081,12 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	int channel = sdmac->channel;
 	struct scatterlist *sg;
 
-	if (sdmac->status == DMA_IN_PROGRESS)
-		return NULL;
-	sdmac->status = DMA_IN_PROGRESS;
-
-	sdmac->flags = 0;
-
-	sdmac->buf_tail = 0;
-
-	dev_dbg(sdma->dev, "setting up %d entries for channel %d.\n",
-			sg_len, channel);
-
-	sdmac->direction = direction;
-	ret = sdma_load_context(sdmac);
+	ret = sdma_prep_common(sdmac, sg_len, direction);
 	if (ret)
 		goto err_out;
 
-	if (sg_len > NUM_BD) {
-		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
-				channel, sg_len, NUM_BD);
-		ret = -EINVAL;
-		goto err_out;
-	}
+	sdmac->flags = 0;
+
 
 	sdmac->chn_count = 0;
 	for_each_sg(sgl, sg, sg_len, i) {
@@ -1129,7 +1141,6 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		bd->mode.status = param;
 	}
 
-	sdmac->num_bd = sg_len;
 	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
 
 	return &sdmac->desc;
@@ -1149,33 +1160,11 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	int channel = sdmac->channel;
 	int ret, i = 0, buf = 0;
 
-	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
-
-	if (sdmac->status == DMA_IN_PROGRESS)
-		return NULL;
-
-	sdmac->status = DMA_IN_PROGRESS;
+	sdma_prep_common(sdmac, buf_len / period_len, direction);
 
-	sdmac->buf_tail = 0;
 	sdmac->period_len = period_len;
 
 	sdmac->flags |= IMX_DMA_SG_LOOP;
-	sdmac->direction = direction;
-	ret = sdma_load_context(sdmac);
-	if (ret)
-		goto err_out;
-
-	if (num_periods > NUM_BD) {
-		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
-				channel, num_periods, NUM_BD);
-		goto err_out;
-	}
-
-	if (period_len > 0xffff) {
-		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %d > %d\n",
-				channel, period_len, 0xffff);
-		goto err_out;
-	}
 
 	while (buf < buf_len) {
 		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
@@ -1207,7 +1196,6 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		i++;
 	}
 
-	sdmac->num_bd = num_periods;
 	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
 
 	return &sdmac->desc;
-- 
2.1.4
