From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Jul 2015 10:41:32 +0200
Subject: [PATCH v2 1/2] dmaengine: Add an enum for the dmaengine alignment
 constraints
Message-ID: <1437381693-18948-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most drivers need to set constraints on the buffer alignment for async tx
operations. However, even though it is documented, some drivers either use
a defined constant that is not matching what the alignment variable expects
(like DMA_BUSWIDTH_* constants) or fill the alignment in bytes instead of
power of two.

Add a new enum for these alignments that matches what the framework
expects, and convert the drivers to it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/coh901318.c    |  2 +-
 drivers/dma/dma-jz4780.c   |  2 +-
 drivers/dma/edma.c         |  2 +-
 drivers/dma/imx-dma.c      |  2 +-
 drivers/dma/k3dma.c        |  3 +--
 drivers/dma/mic_x100_dma.h |  2 +-
 drivers/dma/mmp_pdma.c     |  3 +--
 drivers/dma/mmp_tdma.c     |  3 +--
 drivers/dma/ste_dma40.c    |  2 +-
 drivers/dma/sun6i-dma.c    |  2 +-
 drivers/dma/xgene-dma.c    |  5 ++---
 include/linux/dmaengine.h  | 25 ++++++++++++++++++++-----
 12 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index fd22dd36985f..c340ca9bd2b5 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -2730,7 +2730,7 @@ static int __init coh901318_probe(struct platform_device *pdev)
 	 * This controller can only access address at even 32bit boundaries,
 	 * i.e. 2^2
 	 */
-	base->dma_memcpy.copy_align = 2;
+	base->dma_memcpy.copy_align = DMAENGINE_ALIGN_4_BYTES;
 	err = dma_async_device_register(&base->dma_memcpy);
 
 	if (err)
diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 26d2f0e09ea3..c29569ac9e4f 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -775,7 +775,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_CYCLIC, dd->cap_mask);
 
 	dd->dev = dev;
-	dd->copy_align = 2; /* 2^2 = 4 byte alignment */
+	dd->copy_align = DMAENGINE_ALIGN_4_BYTES;
 	dd->device_alloc_chan_resources = jz4780_dma_alloc_chan_resources;
 	dd->device_free_chan_resources = jz4780_dma_free_chan_resources;
 	dd->device_prep_slave_sg = jz4780_dma_prep_slave_sg;
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 88853af69489..3e5d4f193005 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1000,7 +1000,7 @@ static void edma_dma_init(struct edma_cc *ecc, struct dma_device *dma,
 	 * code using dma memcpy must make sure alignment of
 	 * length is at dma->copy_align boundary.
 	 */
-	dma->copy_align = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	dma->copy_align = DMAENGINE_ALIGN_4_BYTES;
 
 	INIT_LIST_HEAD(&dma->channels);
 }
diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 865501fcc67d..00f49722babe 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -1183,7 +1183,7 @@ static int __init imxdma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, imxdma);
 
-	imxdma->dma_device.copy_align = 2; /* 2^2 = 4 bytes alignment */
+	imxdma->dma_device.copy_align = DMAENGINE_ALIGN_4_BYTES;
 	imxdma->dma_device.dev->dma_parms = &imxdma->dma_parms;
 	dma_set_max_seg_size(imxdma->dma_device.dev, 0xffffff);
 
diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index 647e362f01fd..1ba2fd73852d 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -24,7 +24,6 @@
 #include "virt-dma.h"
 
 #define DRIVER_NAME		"k3-dma"
-#define DMA_ALIGN		3
 #define DMA_MAX_SIZE		0x1ffc
 
 #define INT_STAT		0x00
@@ -732,7 +731,7 @@ static int k3_dma_probe(struct platform_device *op)
 	d->slave.device_pause = k3_dma_transfer_pause;
 	d->slave.device_resume = k3_dma_transfer_resume;
 	d->slave.device_terminate_all = k3_dma_terminate_all;
-	d->slave.copy_align = DMA_ALIGN;
+	d->slave.copy_align = DMAENGINE_ALIGN_8_BYTES;
 
 	/* init virtual channel */
 	d->chans = devm_kzalloc(&op->dev,
diff --git a/drivers/dma/mic_x100_dma.h b/drivers/dma/mic_x100_dma.h
index f663b0bdd11d..d89982034e68 100644
--- a/drivers/dma/mic_x100_dma.h
+++ b/drivers/dma/mic_x100_dma.h
@@ -39,7 +39,7 @@
  */
 #define MIC_DMA_MAX_NUM_CHAN	8
 #define MIC_DMA_NUM_CHAN	4
-#define MIC_DMA_ALIGN_SHIFT	6
+#define MIC_DMA_ALIGN_SHIFT	DMAENGINE_ALIGN_64_BYTES
 #define MIC_DMA_ALIGN_BYTES	(1 << MIC_DMA_ALIGN_SHIFT)
 #define MIC_DMA_DESC_RX_SIZE	(128 * 1024 - 4)
 
diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 462a0229a743..e39457f13d4d 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -72,7 +72,6 @@
 #define DCMD_WIDTH4	(3 << 14)	/* 4 byte width (Word) */
 #define DCMD_LENGTH	0x01fff		/* length mask (max = 8K - 1) */
 
-#define PDMA_ALIGNMENT		3
 #define PDMA_MAX_DESC_BYTES	DCMD_LENGTH
 
 struct mmp_pdma_desc_hw {
@@ -1071,7 +1070,7 @@ static int mmp_pdma_probe(struct platform_device *op)
 	pdev->device.device_issue_pending = mmp_pdma_issue_pending;
 	pdev->device.device_config = mmp_pdma_config;
 	pdev->device.device_terminate_all = mmp_pdma_terminate_all;
-	pdev->device.copy_align = PDMA_ALIGNMENT;
+	pdev->device.copy_align = DMAENGINE_ALIGN_8_BYTES;
 	pdev->device.src_addr_widths = widths;
 	pdev->device.dst_addr_widths = widths;
 	pdev->device.directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index e683761e0f8f..3df0422607d5 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -100,7 +100,6 @@ enum mmp_tdma_type {
 	PXA910_SQU,
 };
 
-#define TDMA_ALIGNMENT		3
 #define TDMA_MAX_XFER_BYTES    SZ_64K
 
 struct mmp_tdma_chan {
@@ -695,7 +694,7 @@ static int mmp_tdma_probe(struct platform_device *pdev)
 	tdev->device.device_pause = mmp_tdma_pause_chan;
 	tdev->device.device_resume = mmp_tdma_resume_chan;
 	tdev->device.device_terminate_all = mmp_tdma_terminate_all;
-	tdev->device.copy_align = TDMA_ALIGNMENT;
+	tdev->device.copy_align = DMAENGINE_ALIGN_8_BYTES;
 
 	dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
 	platform_set_drvdata(pdev, tdev);
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 3c10f034d4b9..750d1b313684 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2853,7 +2853,7 @@ static void d40_ops_init(struct d40_base *base, struct dma_device *dev)
 		 * This controller can only access address at even
 		 * 32bit boundaries, i.e. 2^2
 		 */
-		dev->copy_align = 2;
+		dev->copy_align = DMAENGINE_ALIGN_4_BYTES;
 	}
 
 	if (dma_has_cap(DMA_SG, dev->cap_mask))
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 842ff97c2cfb..73e0be6e2100 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -969,7 +969,7 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	sdc->slave.device_issue_pending		= sun6i_dma_issue_pending;
 	sdc->slave.device_prep_slave_sg		= sun6i_dma_prep_slave_sg;
 	sdc->slave.device_prep_dma_memcpy	= sun6i_dma_prep_dma_memcpy;
-	sdc->slave.copy_align			= 4;
+	sdc->slave.copy_align			= DMAENGINE_ALIGN_4_BYTES;
 	sdc->slave.device_config		= sun6i_dma_config;
 	sdc->slave.device_pause			= sun6i_dma_pause;
 	sdc->slave.device_resume		= sun6i_dma_resume;
diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index 620fd55ec766..fe87a634b145 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -150,7 +150,6 @@
 #define XGENE_DMA_PQ_CHANNEL		1
 #define XGENE_DMA_MAX_BYTE_CNT		0x4000	/* 16 KB */
 #define XGENE_DMA_MAX_64B_DESC_BYTE_CNT	0x14000	/* 80 KB */
-#define XGENE_DMA_XOR_ALIGNMENT		6	/* 64 Bytes */
 #define XGENE_DMA_MAX_XOR_SRC		5
 #define XGENE_DMA_16K_BUFFER_LEN_CODE	0x0
 #define XGENE_DMA_INVALID_LEN_CODE	0x7800000000000000ULL
@@ -1740,13 +1739,13 @@ static void xgene_dma_set_caps(struct xgene_dma_chan *chan,
 	if (dma_has_cap(DMA_XOR, dma_dev->cap_mask)) {
 		dma_dev->device_prep_dma_xor = xgene_dma_prep_xor;
 		dma_dev->max_xor = XGENE_DMA_MAX_XOR_SRC;
-		dma_dev->xor_align = XGENE_DMA_XOR_ALIGNMENT;
+		dma_dev->xor_align = DMAENGINE_ALIGN_64_BYTES;
 	}
 
 	if (dma_has_cap(DMA_PQ, dma_dev->cap_mask)) {
 		dma_dev->device_prep_dma_pq = xgene_dma_prep_pq;
 		dma_dev->max_pq = XGENE_DMA_MAX_XOR_SRC;
-		dma_dev->pq_align = XGENE_DMA_XOR_ALIGNMENT;
+		dma_dev->pq_align = DMAENGINE_ALIGN_64_BYTES;
 	}
 }
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index e2f5eb419976..03ed832adbc2 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -585,6 +585,20 @@ struct dma_tx_state {
 };
 
 /**
+ * enum dmaengine_alignment - defines alignment of the DMA async tx
+ * buffers
+ */
+enum dmaengine_alignment {
+	DMAENGINE_ALIGN_1_BYTE = 0,
+	DMAENGINE_ALIGN_2_BYTES = 1,
+	DMAENGINE_ALIGN_4_BYTES = 2,
+	DMAENGINE_ALIGN_8_BYTES = 3,
+	DMAENGINE_ALIGN_16_BYTES = 4,
+	DMAENGINE_ALIGN_32_BYTES = 5,
+	DMAENGINE_ALIGN_64_BYTES = 6,
+};
+
+/**
  * struct dma_device - info on the entity supplying DMA services
  * @chancnt: how many DMA channels are supported
  * @privatecnt: how many DMA channels are requested by dma_request_channel
@@ -645,10 +659,10 @@ struct dma_device {
 	dma_cap_mask_t  cap_mask;
 	unsigned short max_xor;
 	unsigned short max_pq;
-	u8 copy_align;
-	u8 xor_align;
-	u8 pq_align;
-	u8 fill_align;
+	enum dmaengine_alignment copy_align;
+	enum dmaengine_alignment xor_align;
+	enum dmaengine_alignment pq_align;
+	enum dmaengine_alignment fill_align;
 	#define DMA_HAS_PQ_CONTINUE (1 << 15)
 
 	int dev_id;
@@ -833,7 +847,8 @@ static inline dma_cookie_t dmaengine_submit(struct dma_async_tx_descriptor *desc
 	return desc->tx_submit(desc);
 }
 
-static inline bool dmaengine_check_align(u8 align, size_t off1, size_t off2, size_t len)
+static inline bool dmaengine_check_align(enum dmaengine_alignment align,
+					 size_t off1, size_t off2, size_t len)
 {
 	size_t mask;
 
-- 
2.4.5
