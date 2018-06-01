From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 1 Jun 2018 13:24:29 +0300
Subject: [RFC] dmaengine: Add metadat_ops for dma_async_tx_descriptor
In-Reply-To: <32208a9c-2b15-d345-1432-f1e387531f9b@ti.com>
References: <32208a9c-2b15-d345-1432-f1e387531f9b@ti.com>
Message-ID: <20180601102429.16429-1-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the DMA supports per descriptor metadata it can implement the attach,
get_ptr/set_len callbacks.

Client drivers must only use either attach or get_ptr/set_len to avoid
miss configuration.

Wrappers are also added for the metadata_ops:
dmaengine_desc_attach_metadata()
dmaengine_desc_get_metadata_ptr()
dmaengine_desc_set_metadata_len()

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

since attachments are bouncing back, I send the patch separately

Regards,
Peter

 include/linux/dmaengine.h | 50 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 51fbb861e84b..ac42ace36aa3 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -491,6 +491,18 @@ struct dmaengine_unmap_data {
 	dma_addr_t addr[0];
 };
 
+struct dma_async_tx_descriptor;
+
+struct dma_descriptor_metadata_ops {
+	int (*attach)(struct dma_async_tx_descriptor *desc, void *data,
+		      size_t len);
+
+	void *(*get_ptr)(struct dma_async_tx_descriptor *desc,
+			 size_t *payload_len, size_t *max_len);
+	int (*set_len)(struct dma_async_tx_descriptor *desc,
+		       size_t payload_len);
+};
+
 /**
  * struct dma_async_tx_descriptor - async transaction descriptor
  * ---dma generic offload fields---
@@ -520,6 +532,7 @@ struct dma_async_tx_descriptor {
 	dma_async_tx_callback_result callback_result;
 	void *callback_param;
 	struct dmaengine_unmap_data *unmap;
+	struct dma_descriptor_metadata_ops *metadata_ops;
 #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
 	struct dma_async_tx_descriptor *next;
 	struct dma_async_tx_descriptor *parent;
@@ -932,6 +945,43 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
 						    len, flags);
 }
 
+static inline int dmaengine_desc_attach_metadata(
+		struct dma_async_tx_descriptor *desc, void *data, size_t len)
+{
+	if (!desc)
+		return 0;
+
+	if (!desc->metadata_ops || !desc->metadata_ops->attach)
+		return -ENOTSUPP;
+
+	return desc->metadata_ops->attach(desc, data, len);
+}
+
+static inline void *dmaengine_desc_get_metadata_ptr(
+		struct dma_async_tx_descriptor *desc, size_t *payload_len,
+		size_t *max_len)
+{
+	if (!desc)
+		return NULL;
+
+	if (!desc->metadata_ops || !desc->metadata_ops->get_ptr)
+		return ERR_PTR(-ENOTSUPP);
+
+	return desc->metadata_ops->get_ptr(desc, payload_len, max_len);
+}
+
+static inline int dmaengine_desc_set_metadata_len(
+		struct dma_async_tx_descriptor *desc, size_t payload_len)
+{
+	if (!desc)
+		return 0;
+
+	if (!desc->metadata_ops || !desc->metadata_ops->set_len)
+		return -ENOTSUPP;
+
+	return desc->metadata_ops->set_len(desc, payload_len);
+}
+
 /**
  * dmaengine_terminate_all() - Terminate all active DMA transfers
  * @chan: The channel for which to terminate the transfers
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
