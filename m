From: rsahu@apm.com (Rameshwar Prasad Sahu)
Date: Sat,  7 Nov 2015 22:07:04 +0530
Subject: [PATCH v2 1/3] dmaengine: Add support for new feature CRC32C
 computations
In-Reply-To: <1446914226-23402-1-git-send-email-rsahu@apm.com>
References: <1446914226-23402-1-git-send-email-rsahu@apm.com>
Message-ID: <1446914226-23402-2-git-send-email-rsahu@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for new feature CRC32C computations in
dmaengine framework.

Signed-of-by: Rameshwar Prasad Sahu<rsahu@apm.com>
---
 Documentation/dmaengine/provider.txt |    3 +++
 drivers/dma/dmaengine.c              |    2 ++
 include/linux/dmaengine.h            |   13 +++++++++++++
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/dmaengine/provider.txt b/Documentation/dmaengine/provider.txt
index 67d4ce4..2399d6f 100644
--- a/Documentation/dmaengine/provider.txt
+++ b/Documentation/dmaengine/provider.txt
@@ -224,6 +224,9 @@ Currently, the types available are:
       want to transfer a portion of uncompressed data directly to the
       display to print it

+  * DMA_CRC32C
+    - The device is able to perform CRC32C computations
+
 These various types will also affect how the source and destination
 addresses change over time.

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 09479d4..8cd0365 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -865,6 +865,8 @@ int dma_async_device_register(struct dma_device *device)
 		!device->device_prep_dma_cyclic);
 	BUG_ON(dma_has_cap(DMA_INTERLEAVE, device->cap_mask) &&
 		!device->device_prep_interleaved_dma);
+	BUG_ON(dma_has_cap(DMA_CRC32C, device->cap_mask) &&
+		!device->device_prep_dma_crc32c);

 	BUG_ON(!device->device_tx_status);
 	BUG_ON(!device->device_issue_pending);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 7ea9184..7108d7c 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -74,6 +74,7 @@ enum dma_transaction_type {
 	DMA_SLAVE,
 	DMA_CYCLIC,
 	DMA_INTERLEAVE,
+	DMA_CRC32C,
 /* last transaction type for creation of the capabilities mask */
 	DMA_TX_TYPE_END,
 };
@@ -645,6 +646,7 @@ enum dmaengine_alignment {
  *	The function takes a buffer of size buf_len. The callback function will
  *	be called after period_len bytes have been transferred.
  * @device_prep_interleaved_dma: Transfer expression in a generic way.
+ * @device_prep_dma_crc32c: prepares a crc32c operation
  * @device_config: Pushes a new configuration to a channel, return 0 or an error
  *	code
  * @device_pause: Pauses any transfer happening on a channel. Returns
@@ -727,6 +729,9 @@ struct dma_device {
 	struct dma_async_tx_descriptor *(*device_prep_interleaved_dma)(
 		struct dma_chan *chan, struct dma_interleaved_template *xt,
 		unsigned long flags);
+	struct dma_async_tx_descriptor *(*device_prep_dma_crc32c)(
+		struct dma_chan *chan, struct scatterlist *src_sg, size_t len,
+		unsigned int seed, u8 *result, unsigned long flags);

 	int (*device_config)(struct dma_chan *chan,
 			     struct dma_slave_config *config);
@@ -824,6 +829,14 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_sg(
 			src_sg, src_nents, flags);
 }

+static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_crc3c(
+		struct dma_chan *chan, struct scatterlist *src_sg,
+		size_t len, unsigned int seed, u8 *result, unsigned long flags)
+{
+	return chan->device->device_prep_dma_crc32c(chan, src_sg, len,
+						    seed, result, flags);
+}
+
 static inline int dmaengine_terminate_all(struct dma_chan *chan)
 {
 	if (chan->device->device_terminate_all)
--
1.7.1
