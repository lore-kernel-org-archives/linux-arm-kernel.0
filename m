From: rsahu@apm.com (Rameshwar Prasad Sahu)
Date: Thu, 30 Jul 2015 17:41:05 +0530
Subject: [PATCH v1 1/4] dmaengine: Add support for new feature CRC32C
In-Reply-To: <1438258268-3099-1-git-send-email-rsahu@apm.com>
References: <1438258268-3099-1-git-send-email-rsahu@apm.com>
Message-ID: <1438258268-3099-2-git-send-email-rsahu@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for new feature CRC32C calculation in
dmaengine framework.

Signed-of-by: Rameshwar Prasad Sahu<rsahu@apm.com>
---
 drivers/dma/dmaengine.c   | 2 ++
 include/linux/dmaengine.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 4a4cce1..55ba799 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -853,6 +853,8 @@ int dma_async_device_register(struct dma_device *device)
 		!device->device_prep_dma_cyclic);
 	BUG_ON(dma_has_cap(DMA_INTERLEAVE, device->cap_mask) &&
 		!device->device_prep_interleaved_dma);
+	BUG_ON(dma_has_cap(DMA_CRC32C, device->cap_mask) &&
+		!device->device_prep_dma_crc32c);

 	BUG_ON(!device->device_tx_status);
 	BUG_ON(!device->device_issue_pending);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index e2f5eb4..9da70b6 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -73,6 +73,7 @@ enum dma_transaction_type {
 	DMA_SLAVE,
 	DMA_CYCLIC,
 	DMA_INTERLEAVE,
+	DMA_CRC32C,
 /* last transaction type for creation of the capabilities mask */
 	DMA_TX_TYPE_END,
 };
@@ -622,6 +623,7 @@ struct dma_tx_state {
  *	The function takes a buffer of size buf_len. The callback function will
  *	be called after period_len bytes have been transferred.
  * @device_prep_interleaved_dma: Transfer expression in a generic way.
+ * @device_prep_dma_crc32c: prepares a crc32c operation
  * @device_config: Pushes a new configuration to a channel, return 0 or an error
  *	code
  * @device_pause: Pauses any transfer happening on a channel. Returns
@@ -701,6 +703,9 @@ struct dma_device {
 	struct dma_async_tx_descriptor *(*device_prep_interleaved_dma)(
 		struct dma_chan *chan, struct dma_interleaved_template *xt,
 		unsigned long flags);
+	struct dma_async_tx_descriptor *(*device_prep_dma_crc32c)(
+		struct dma_chan *chan, struct scatterlist *src_sg, size_t len,
+		unsigned int seed, u8 *result, unsigned long flags);

 	int (*device_config)(struct dma_chan *chan,
 			     struct dma_slave_config *config);
--
1.8.2.1
