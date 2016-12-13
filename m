From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Tue, 13 Dec 2016 14:40:48 +0100
Subject: [PATCH 6/9] dmaengine: stm32-dma: Fix residue computation issue in
 cyclic mode
In-Reply-To: <1481636451-27863-1-git-send-email-cedric.madianga@gmail.com>
References: <1481636451-27863-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1481636451-27863-7-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch resolves the residue computation issue detected in cyclic mode.
Now, in cyclic mode, we increment next_sg variable as soon as a period is
transferred instead of after pushing a new sg request.
Then, we take into account that after transferring a complete buffer,
the next_sg variable is equal to 0.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Reviewed-by: Ludovic BARRE <ludovic.barre@st.com>
---
 drivers/dma/stm32-dma.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index adb846c..ba929a9 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -500,8 +500,6 @@ static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan)
 			dev_dbg(chan2dev(chan), "CT=0 <=> SM1AR: 0x%08x\n",
 				stm32_dma_read(dmadev, STM32_DMA_SM1AR(id)));
 		}
-
-		chan->next_sg++;
 	}
 }
 
@@ -510,6 +508,7 @@ static void stm32_dma_handle_chan_done(struct stm32_dma_chan *chan)
 	if (chan->desc) {
 		if (chan->desc->cyclic) {
 			vchan_cyclic_callback(&chan->desc->vdesc);
+			chan->next_sg++;
 			stm32_dma_configure_next_sg(chan);
 		} else {
 			chan->busy = false;
@@ -846,26 +845,40 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 }
 
+static u32 stm32_dma_get_remaining_bytes(struct stm32_dma_chan *chan)
+{
+	u32 dma_scr, width, ndtr;
+	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
+
+	dma_scr = stm32_dma_read(dmadev, STM32_DMA_SCR(chan->id));
+	width = STM32_DMA_SCR_PSIZE_GET(dma_scr);
+	ndtr = stm32_dma_read(dmadev, STM32_DMA_SNDTR(chan->id));
+
+	return ndtr << width;
+}
+
 static size_t stm32_dma_desc_residue(struct stm32_dma_chan *chan,
 				     struct stm32_dma_desc *desc,
 				     u32 next_sg)
 {
-	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
-	u32 dma_scr, width, residue, count;
+	u32 residue = 0;
 	int i;
 
-	residue = 0;
+	/*
+	 * In cyclic mode, for the last period, residue = remaining bytes from
+	 * NDTR
+	 */
+	if (chan->desc->cyclic && next_sg == 0)
+		return stm32_dma_get_remaining_bytes(chan);
 
+	/*
+	 * For all other periods in cyclic mode, and in sg mode,
+	 * residue = remaining bytes from NDTR + remaining periods/sg to be
+	 * transferred
+	 */
 	for (i = next_sg; i < desc->num_sgs; i++)
 		residue += desc->sg_req[i].len;
-
-	if (next_sg != 0) {
-		dma_scr = stm32_dma_read(dmadev, STM32_DMA_SCR(chan->id));
-		width = STM32_DMA_SCR_PSIZE_GET(dma_scr);
-		count = stm32_dma_read(dmadev, STM32_DMA_SNDTR(chan->id));
-
-		residue += count << width;
-	}
+	residue += stm32_dma_get_remaining_bytes(chan);
 
 	return residue;
 }
-- 
1.9.1
