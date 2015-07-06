From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  6 Jul 2015 12:19:23 +0200
Subject: [PATCH 1/2] dmaengine: Add scatter-gathered memset
In-Reply-To: <1436177964-19380-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1436177964-19380-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1436177964-19380-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current API allows the driver to accelerate memset by using the DMA
controller.

However, it does so over a contiguous memory area, which might proves
inefficient when you have to do it over a non-contiguous yet repititive
pattern, since you have to create a number of descriptors and then submit
each other.

Add a memset operation going over a scatter list to handle such cases in a
single call.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 include/linux/dmaengine.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index e2f5eb419976..8da299cc7361 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -66,6 +66,7 @@ enum dma_transaction_type {
 	DMA_XOR_VAL,
 	DMA_PQ_VAL,
 	DMA_MEMSET,
+	DMA_MEMSET_SG,
 	DMA_INTERRUPT,
 	DMA_SG,
 	DMA_PRIVATE,
@@ -616,6 +617,7 @@ struct dma_tx_state {
  * @device_prep_dma_pq: prepares a pq operation
  * @device_prep_dma_pq_val: prepares a pqzero_sum operation
  * @device_prep_dma_memset: prepares a memset operation
+ * @device_prep_dma_memset_sg: prepares a memset operation over a scatter list
  * @device_prep_dma_interrupt: prepares an end of chain interrupt operation
  * @device_prep_slave_sg: prepares a slave dma operation
  * @device_prep_dma_cyclic: prepare a cyclic dma operation suitable for audio.
@@ -682,6 +684,9 @@ struct dma_device {
 	struct dma_async_tx_descriptor *(*device_prep_dma_memset)(
 		struct dma_chan *chan, dma_addr_t dest, int value, size_t len,
 		unsigned long flags);
+	struct dma_async_tx_descriptor *(*device_prep_dma_memset_sg)(
+		struct dma_chan *chan, struct scatterlist *sg,
+		unsigned int nents, int value, unsigned long flags);
 	struct dma_async_tx_descriptor *(*device_prep_dma_interrupt)(
 		struct dma_chan *chan, unsigned long flags);
 	struct dma_async_tx_descriptor *(*device_prep_dma_sg)(
-- 
2.4.5
