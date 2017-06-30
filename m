From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 29 Jun 2017 22:30:57 -0400
Subject: [PATCH V3 1/2] dmaengine: qcom_hidma: introduce memset support
Message-ID: <1498789858-18583-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HIDMA HW supports memset operation in addition to memcpy.
Since the memset API is present on the kernel now, bring the
memset feature into life.

The descriptor format is the same for both memcpy and memset.
Type of the descriptor is 4 when memset is requested.
The lowest 8 bits of the source DMA argument is used as a
fill pattern.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma.c    | 37 ++++++++++++++++++++++++++++++++++++-
 drivers/dma/qcom/hidma.h    |  7 ++++++-
 drivers/dma/qcom/hidma_ll.c | 11 ++++-------
 3 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 8ed29bd..e185872 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -410,7 +410,40 @@ static int hidma_alloc_chan_resources(struct dma_chan *dmach)
 		return NULL;
 
 	hidma_ll_set_transfer_params(mdma->lldev, mdesc->tre_ch,
-				     src, dest, len, flags);
+				     src, dest, len, flags,
+				     HIDMA_TRE_MEMCPY);
+
+	/* Place descriptor in prepared list */
+	spin_lock_irqsave(&mchan->lock, irqflags);
+	list_add_tail(&mdesc->node, &mchan->prepared);
+	spin_unlock_irqrestore(&mchan->lock, irqflags);
+
+	return &mdesc->desc;
+}
+
+static struct dma_async_tx_descriptor *
+hidma_prep_dma_memset(struct dma_chan *dmach, dma_addr_t dest, int value,
+		size_t len, unsigned long flags)
+{
+	struct hidma_chan *mchan = to_hidma_chan(dmach);
+	struct hidma_desc *mdesc = NULL;
+	struct hidma_dev *mdma = mchan->dmadev;
+	unsigned long irqflags;
+
+	/* Get free descriptor */
+	spin_lock_irqsave(&mchan->lock, irqflags);
+	if (!list_empty(&mchan->free)) {
+		mdesc = list_first_entry(&mchan->free, struct hidma_desc, node);
+		list_del(&mdesc->node);
+	}
+	spin_unlock_irqrestore(&mchan->lock, irqflags);
+
+	if (!mdesc)
+		return NULL;
+
+	hidma_ll_set_transfer_params(mdma->lldev, mdesc->tre_ch,
+				     value, dest, len, flags,
+				     HIDMA_TRE_MEMSET);
 
 	/* Place descriptor in prepared list */
 	spin_lock_irqsave(&mchan->lock, irqflags);
@@ -775,6 +808,7 @@ static int hidma_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(dmadev->ddev.dev);
 
 	dma_cap_set(DMA_MEMCPY, dmadev->ddev.cap_mask);
+	dma_cap_set(DMA_MEMSET, dmadev->ddev.cap_mask);
 	if (WARN_ON(!pdev->dev.dma_mask)) {
 		rc = -ENXIO;
 		goto dmafree;
@@ -785,6 +819,7 @@ static int hidma_probe(struct platform_device *pdev)
 	dmadev->dev_trca = trca;
 	dmadev->trca_resource = trca_resource;
 	dmadev->ddev.device_prep_dma_memcpy = hidma_prep_dma_memcpy;
+	dmadev->ddev.device_prep_dma_memset = hidma_prep_dma_memset;
 	dmadev->ddev.device_alloc_chan_resources = hidma_alloc_chan_resources;
 	dmadev->ddev.device_free_chan_resources = hidma_free_chan_resources;
 	dmadev->ddev.device_tx_status = hidma_tx_status;
diff --git a/drivers/dma/qcom/hidma.h b/drivers/dma/qcom/hidma.h
index 41e0aa2..5f9966e 100644
--- a/drivers/dma/qcom/hidma.h
+++ b/drivers/dma/qcom/hidma.h
@@ -28,6 +28,11 @@
 #define HIDMA_TRE_DEST_LOW_IDX		4
 #define HIDMA_TRE_DEST_HI_IDX		5
 
+enum tre_type {
+	HIDMA_TRE_MEMCPY = 3,
+	HIDMA_TRE_MEMSET = 4,
+};
+
 struct hidma_tre {
 	atomic_t allocated;		/* if this channel is allocated	    */
 	bool queued;			/* flag whether this is pending     */
@@ -150,7 +155,7 @@ int hidma_ll_request(struct hidma_lldev *llhndl, u32 dev_id,
 int hidma_ll_disable(struct hidma_lldev *lldev);
 int hidma_ll_enable(struct hidma_lldev *llhndl);
 void hidma_ll_set_transfer_params(struct hidma_lldev *llhndl, u32 tre_ch,
-	dma_addr_t src, dma_addr_t dest, u32 len, u32 flags);
+	dma_addr_t src, dma_addr_t dest, u32 len, u32 flags, u32 txntype);
 void hidma_ll_setup_irq(struct hidma_lldev *lldev, bool msi);
 int hidma_ll_setup(struct hidma_lldev *lldev);
 struct hidma_lldev *hidma_ll_init(struct device *dev, u32 max_channels,
diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index 1530a66..4999e26 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -105,10 +105,6 @@ enum ch_state {
 	HIDMA_CH_STOPPED = 4,
 };
 
-enum tre_type {
-	HIDMA_TRE_MEMCPY = 3,
-};
-
 enum err_code {
 	HIDMA_EVRE_STATUS_COMPLETE = 1,
 	HIDMA_EVRE_STATUS_ERROR = 4,
@@ -174,8 +170,7 @@ int hidma_ll_request(struct hidma_lldev *lldev, u32 sig, const char *dev_name,
 	tre->err_info = 0;
 	tre->lldev = lldev;
 	tre_local = &tre->tre_local[0];
-	tre_local[HIDMA_TRE_CFG_IDX] = HIDMA_TRE_MEMCPY;
-	tre_local[HIDMA_TRE_CFG_IDX] |= (lldev->chidx & 0xFF) << 8;
+	tre_local[HIDMA_TRE_CFG_IDX] = (lldev->chidx & 0xFF) << 8;
 	tre_local[HIDMA_TRE_CFG_IDX] |= BIT(16);	/* set IEOB */
 	*tre_ch = i;
 	if (callback)
@@ -607,7 +602,7 @@ int hidma_ll_disable(struct hidma_lldev *lldev)
 
 void hidma_ll_set_transfer_params(struct hidma_lldev *lldev, u32 tre_ch,
 				  dma_addr_t src, dma_addr_t dest, u32 len,
-				  u32 flags)
+				  u32 flags, u32 txntype)
 {
 	struct hidma_tre *tre;
 	u32 *tre_local;
@@ -626,6 +621,8 @@ void hidma_ll_set_transfer_params(struct hidma_lldev *lldev, u32 tre_ch,
 	}
 
 	tre_local = &tre->tre_local[0];
+	tre_local[HIDMA_TRE_CFG_IDX] &= ~GENMASK(7, 0);
+	tre_local[HIDMA_TRE_CFG_IDX] |= txntype;
 	tre_local[HIDMA_TRE_LEN_IDX] = len;
 	tre_local[HIDMA_TRE_SRC_LOW_IDX] = lower_32_bits(src);
 	tre_local[HIDMA_TRE_SRC_HI_IDX] = upper_32_bits(src);
-- 
1.9.1
