From: stillcompiling@gmail.com (Joshua Clayton)
Date: Mon, 15 Jun 2015 09:21:45 -0700
Subject: [PATCH 10/10] dma: imx-sdma: extract sdma_set_buffer_descriptor()
Message-ID: <1434385305-4748-1-git-send-email-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

extract common per/buffer descriptor setup
from dma prep functions

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/dma/imx-sdma.c | 111 ++++++++++++++++++++++++-------------------------
 1 file changed, 54 insertions(+), 57 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index dfebef9..13a3574 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1046,6 +1046,50 @@ int sdma_prep_common(struct sdma_channel *sdmac, int buf_count,
 	return sdma_load_context(sdmac);
 }
 
+int sdma_set_buffer_descriptor(struct sdma_channel *sdmac,
+		struct sdma_buffer_descriptor *bd, u32 addr,
+		int len, u32 status)
+{
+	struct sdma_engine *sdma = to_sdma_engine(sdmac);
+
+	bd->buffer_addr = addr;
+
+	if (len > 0xffff) {
+		dev_err(sdma->dev, "SDMA channel %d: maximum buffer description size exceeded: %d > %d\n",
+			sdmac->channel, len, 0xffff);
+		return -EINVAL;
+	}
+
+	bd->mode.count = len;
+
+	switch (sdmac->word_size) {
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		bd->mode.command = 0;
+		if (len & 3 || addr & 3)
+			return -EFAULT;
+		break;
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		bd->mode.command = 2;
+		if (len & 1 || addr & 1)
+			return -EFAULT;
+		break;
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		bd->mode.command = 1;
+		break;
+	default:
+		return -EFAULT;
+	}
+
+	dev_dbg(sdma->dev, "count: %d dma: %#llx %s%s\n",
+			len, (u64)addr,
+			status & BD_WRAP ? "wrap" : "",
+			status & BD_INTR ? " intr" : "");
+
+	bd->mode.status = status;
+
+	return 0;
+}
+
 static void sdma_free_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
@@ -1077,7 +1121,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = to_sdma_engine(sdmac);
-	int ret, i, count;
+	int ret, i;
 	int channel = sdmac->channel;
 	struct scatterlist *sg;
 
@@ -1090,41 +1134,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 	sdmac->chn_count = 0;
 	for_each_sg(sgl, sg, sg_len, i) {
-		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
 		int param;
 
-		bd->buffer_addr = sg->dma_address;
-
-		count = sg_dma_len(sg);
-
-		if (count > 0xffff) {
-			dev_err(sdma->dev, "SDMA channel %d: maximum bytes for sg entry exceeded: %d > %d\n",
-					channel, count, 0xffff);
-			ret = -EINVAL;
-			goto err_out;
-		}
-
-		bd->mode.count = count;
-		sdmac->chn_count += count;
-
-		switch (sdmac->word_size) {
-		case DMA_SLAVE_BUSWIDTH_4_BYTES:
-			bd->mode.command = 0;
-			if (count & 3 || sg->dma_address & 3)
-				return NULL;
-			break;
-		case DMA_SLAVE_BUSWIDTH_2_BYTES:
-			bd->mode.command = 2;
-			if (count & 1 || sg->dma_address & 1)
-				return NULL;
-			break;
-		case DMA_SLAVE_BUSWIDTH_1_BYTE:
-			bd->mode.command = 1;
-			break;
-		default:
-			return NULL;
-		}
-
+		sdmac->chn_count += sg_dma_len(sg);
 		param = BD_DONE | BD_EXTD | BD_CONT;
 
 		if (i + 1 == sg_len) {
@@ -1133,12 +1145,10 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 			param &= ~BD_CONT;
 		}
 
-		dev_dbg(sdma->dev, "entry %d: count: %d dma: %#llx %s%s\n",
-				i, count, (u64)sg->dma_address,
-				param & BD_WRAP ? "wrap" : "",
-				param & BD_INTR ? " intr" : "");
-
-		bd->mode.status = param;
+		ret = sdma_set_buffer_descriptor(sdmac, &sdmac->bd[i],
+				sg->dma_address, sg_dma_len(sg), param);
+		if (ret)
+			goto err_out;
 	}
 
 	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
@@ -1167,28 +1177,15 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	sdmac->flags |= IMX_DMA_SG_LOOP;
 
 	for (i = 0; i < num_periods; i++) {
-		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
 		int param;
-
-		bd->buffer_addr = dma_addr;
-
-		bd->mode.count = period_len;
-
-		if (sdmac->word_size == DMA_SLAVE_BUSWIDTH_4_BYTES)
-			bd->mode.command = 0;
-		else
-			bd->mode.command = sdmac->word_size;
-
 		param = BD_DONE | BD_EXTD | BD_CONT | BD_INTR;
 		if (i + 1 == num_periods)
 			param |= BD_WRAP;
 
-		dev_dbg(sdma->dev, "entry %d: count: %d dma: %#llx %s%s\n",
-				i, period_len, (u64)dma_addr,
-				param & BD_WRAP ? "wrap" : "",
-				param & BD_INTR ? " intr" : "");
-
-		bd->mode.status = param;
+		ret = sdma_set_buffer_descriptor(sdmac, &sdmac->bd[i],
+				dma_addr, sdmac->period_len, param);
+		if (ret)
+			goto err_out;
 
 		dma_addr += period_len;
 	}
-- 
2.1.4
