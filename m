From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Tue, 02 Oct 2012 17:33:43 +0530
Subject: [RFC PATCH 08/13] mmc: omap_hsmmc: limit max_segs with the
 EDMA DMAC
In-Reply-To: <20121001163955.GO5641@beef>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1348152226-13588-9-git-send-email-mporter@ti.com>
 <CANfBPZ81anOy8fWgKM1PgCtB4V2pEp2x1Qi4x1uPsq7QieMN5g@mail.gmail.com>
 <20120921184721.GD31374@n2100.arm.linux.org.uk>
 <1348738868.1648.13.camel@vkoul-udesk3>  <20121001163955.GO5641@beef>
Message-ID: <1349179423.1648.44.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-10-01 at 12:39 -0400, Matt Porter wrote:
> Anything you can show at this point? ;) I'd be happy to drop the
> half-hack
> for a real API. If not, I'm going to carry that to v2 atm. 

This is what I had done sometime back. Feel free to update....

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 9c02a45..94ae006 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -86,11 +86,11 @@ enum dma_transaction_type {
  * @DMA_DEV_TO_DEV: Slave mode & From Device to Device
  */
 enum dma_transfer_direction {
-	DMA_MEM_TO_MEM,
-	DMA_MEM_TO_DEV,
-	DMA_DEV_TO_MEM,
-	DMA_DEV_TO_DEV,
-	DMA_TRANS_NONE,
+	DMA_MEM_TO_MEM	= 0x01,
+	DMA_MEM_TO_DEV	= 0x02,
+	DMA_DEV_TO_MEM	= 0x04,
+	DMA_DEV_TO_DEV	= 0x08,
+	DMA_TRANS_NONE	= 0x10,
 };
 
 /**
@@ -371,6 +371,41 @@ struct dma_slave_config {
 	unsigned int slave_id;
 };
 
+enum dmaengine_apis {
+	DMAENGINE_MEMCPY	= 0x0001,
+	DMAENGINE_XOR		= 0x0002,
+	DMAENGINE_XOR_VAL	= 0x0004,
+	DMAENGINE_PQ		= 0x0008,
+	DMAENGINE_PQ_VAL	= 0x0010,
+	DMAENGINE_MEMSET	= 0x0020,
+	DMAENGINE_SLAVE		= 0x0040,
+	DMAENGINE_CYCLIC	= 0x0080,
+	DMAENGINE_INTERLEAVED	= 0x0100,
+	DMAENGINE_SG		= 0x0200,
+};
+
+/* struct dmaengine_chan_caps - expose capability of a channel
+ * Note: each channel can have same or different capabilities
+ *
+ * This primarily classifies capabilities into
+ * a) APIs/ops supported
+ * b) channel physical capabilities
+ *
+ * @ops: or'ed api capability
+ * @widths: channel widths supported
+ * @dirn: channel directions supported
+ * @bursts: bitmask of burst lengths supported
+ * @mux: configurable slave id or hard wired
+ * 	-1 for hard wired, otherwise valid positive slave id (including zero)
+ */
+struct dmaengine_chan_caps {
+	enum dmaengine_apis	ops;
+	enum dma_slave_buswidth widths;
+	enum dma_transfer_direction dirn;
+	unsigned int dma_bursts;
+	int mux;
+};
+
 static inline const char *dma_chan_name(struct dma_chan *chan)
 {
 	return dev_name(&chan->dev->device);
@@ -534,6 +569,7 @@ struct dma_tx_state {
  *	struct with auxiliary transfer status information, otherwise the call
  *	will just return a simple status code
  * @device_issue_pending: push pending transactions to hardware
+ * @device_channel_caps: return the capablities of channel
  */
 struct dma_device {
 
@@ -602,6 +638,9 @@ struct dma_device {
 					    dma_cookie_t cookie,
 					    struct dma_tx_state *txstate);
 	void (*device_issue_pending)(struct dma_chan *chan);
+
+	struct dmaengine_chan_caps *(*device_channel_caps)(
+		struct dma_chan *chan);
 };
 
 static inline int dmaengine_device_control(struct dma_chan *chan,


-- 
~Vinod
