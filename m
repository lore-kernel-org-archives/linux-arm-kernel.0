From: joel@joelfernandes.org (Joel Fernandes (Google))
Date: Mon,  8 Oct 2018 22:47:51 -0700
Subject: [PATCH 6/7] dmaengine: stm32-dma: fix max items per transfer
In-Reply-To: <20181009054752.145978-1-joel@joelfernandes.org>
References: <20181009054752.145978-1-joel@joelfernandes.org>
Message-ID: <20181009054752.145978-7-joel@joelfernandes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>

Having 0 in item counter register is valid and stands for a "No or Ended
transfer". Therefore valid transfer starts from @+0 to @+0xFFFE leading to
unaligned scatter gather at boundary. Thus it's safer to round down this
value on its FIFO size (16 Bytes).

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/stm32-dma.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index b40486454a2c..05a2974cd2c0 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -38,10 +38,6 @@
 #define STM32_DMA_TEI			BIT(3) /* Transfer Error Interrupt */
 #define STM32_DMA_DMEI			BIT(2) /* Direct Mode Error Interrupt */
 #define STM32_DMA_FEI			BIT(0) /* FIFO Error Interrupt */
-#define STM32_DMA_MASKI			(STM32_DMA_TCI \
-					 | STM32_DMA_TEI \
-					 | STM32_DMA_DMEI \
-					 | STM32_DMA_FEI)
 
 /* DMA Stream x Configuration Register */
 #define STM32_DMA_SCR(x)		(0x0010 + 0x18 * (x)) /* x = 0..7 */
@@ -118,6 +114,13 @@
 #define STM32_DMA_FIFO_THRESHOLD_FULL			0x03
 
 #define STM32_DMA_MAX_DATA_ITEMS	0xffff
+/*
+ * Valid transfer starts from @0 to @0xFFFE leading to unaligned scatter
+ * gather at boundary. Thus it's safer to round down this value on FIFO
+ * size (16 Bytes)
+ */
+#define STM32_DMA_ALIGNED_MAX_DATA_ITEMS	\
+	ALIGN_DOWN(STM32_DMA_MAX_DATA_ITEMS, 16)
 #define STM32_DMA_MAX_CHANNELS		0x08
 #define STM32_DMA_MAX_REQUEST_ID	0x08
 #define STM32_DMA_MAX_DATA_PARAM	0x03
@@ -869,7 +872,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
 		desc->sg_req[i].len = sg_dma_len(sg);
 
 		nb_data_items = desc->sg_req[i].len / buswidth;
-		if (nb_data_items > STM32_DMA_MAX_DATA_ITEMS) {
+		if (nb_data_items > STM32_DMA_ALIGNED_MAX_DATA_ITEMS) {
 			dev_err(chan2dev(chan), "nb items not supported\n");
 			goto err;
 		}
@@ -935,7 +938,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
 		return NULL;
 
 	nb_data_items = period_len / buswidth;
-	if (nb_data_items > STM32_DMA_MAX_DATA_ITEMS) {
+	if (nb_data_items > STM32_DMA_ALIGNED_MAX_DATA_ITEMS) {
 		dev_err(chan2dev(chan), "number of items not supported\n");
 		return NULL;
 	}
@@ -985,7 +988,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
 	u32 num_sgs, best_burst, dma_burst, threshold;
 	int i;
 
-	num_sgs = DIV_ROUND_UP(len, STM32_DMA_MAX_DATA_ITEMS);
+	num_sgs = DIV_ROUND_UP(len, STM32_DMA_ALIGNED_MAX_DATA_ITEMS);
 	desc = stm32_dma_alloc_desc(num_sgs);
 	if (!desc)
 		return NULL;
@@ -994,7 +997,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
 
 	for (offset = 0, i = 0; offset < len; offset += xfer_count, i++) {
 		xfer_count = min_t(size_t, len - offset,
-				   STM32_DMA_MAX_DATA_ITEMS);
+				   STM32_DMA_ALIGNED_MAX_DATA_ITEMS);
 
 		/* Compute best burst size */
 		max_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-- 
2.19.0.605.g01d371f741-goog
