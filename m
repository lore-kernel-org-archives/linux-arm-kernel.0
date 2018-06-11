From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Mon, 11 Jun 2018 11:50:09 +0200
Subject: [PATCH] media: stm32-dcmi: code cleanup
Message-ID: <1528710609-8501-1-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minor non-functional fixes around comments, variable namings
and trace point enhancement.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index c55e6b5..b796334 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -249,13 +249,12 @@ static int dcmi_restart_capture(struct stm32_dcmi *dcmi)
 static void dcmi_dma_callback(void *param)
 {
 	struct stm32_dcmi *dcmi = (struct stm32_dcmi *)param;
-	struct dma_chan *chan = dcmi->dma_chan;
 	struct dma_tx_state state;
 	enum dma_status status;
 	struct dcmi_buf *buf = dcmi->active;
 
 	/* Check DMA status */
-	status = dmaengine_tx_status(chan, dcmi->dma_cookie, &state);
+	status = dmaengine_tx_status(dcmi->dma_chan, dcmi->dma_cookie, &state);
 
 	switch (status) {
 	case DMA_IN_PROGRESS:
@@ -309,10 +308,11 @@ static int dcmi_start_dma(struct stm32_dcmi *dcmi,
 	/* Prepare a DMA transaction */
 	desc = dmaengine_prep_slave_single(dcmi->dma_chan, buf->paddr,
 					   buf->size,
-					   DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+					   DMA_DEV_TO_MEM,
+					   DMA_PREP_INTERRUPT);
 	if (!desc) {
-		dev_err(dcmi->dev, "%s: DMA dmaengine_prep_slave_single failed for buffer size %zu\n",
-			__func__, buf->size);
+		dev_err(dcmi->dev, "%s: DMA dmaengine_prep_slave_single failed for buffer phy=%pad size=%zu\n",
+			__func__, &buf->paddr, buf->size);
 		return -EINVAL;
 	}
 
@@ -378,7 +378,6 @@ static void dcmi_process_jpeg(struct stm32_dcmi *dcmi)
 {
 	struct dma_tx_state state;
 	enum dma_status status;
-	struct dma_chan *chan = dcmi->dma_chan;
 	struct dcmi_buf *buf = dcmi->active;
 
 	if (!buf)
@@ -386,8 +385,7 @@ static void dcmi_process_jpeg(struct stm32_dcmi *dcmi)
 
 	/*
 	 * Because of variable JPEG buffer size sent by sensor,
-	 * DMA transfer never completes due to transfer size
-	 * never reached.
+	 * DMA transfer never completes due to transfer size never reached.
 	 * In order to ensure that all the JPEG data are transferred
 	 * in active buffer memory, DMA is drained.
 	 * Then DMA tx status gives the amount of data transferred
@@ -396,10 +394,10 @@ static void dcmi_process_jpeg(struct stm32_dcmi *dcmi)
 	 */
 
 	/* Drain DMA */
-	dmaengine_synchronize(chan);
+	dmaengine_synchronize(dcmi->dma_chan);
 
 	/* Get DMA residue to get JPEG size */
-	status = dmaengine_tx_status(chan, dcmi->dma_cookie, &state);
+	status = dmaengine_tx_status(dcmi->dma_chan, dcmi->dma_cookie, &state);
 	if (status != DMA_ERROR && state.residue < buf->size) {
 		/* Return JPEG buffer to V4L2 with received JPEG buffer size */
 		dcmi_buffer_done(dcmi, buf, buf->size - state.residue, 0);
-- 
1.9.1
