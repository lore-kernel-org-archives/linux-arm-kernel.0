From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 12:17:17 +0200
Subject: [PATCH v2 18/53] dmaengine: imx: Split device_control
In-Reply-To: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413454672-27400-19-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split the device_control callback of the Freescale IMX DMA driver to make use
of the newly introduced callbacks, that will eventually be used to retrieve
slave capabilities.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/imx-dma.c | 103 +++++++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 52 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 9d2c9e7374dc..dfd1557384ca 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -669,69 +669,67 @@ out:
 
 }
 
-static int imxdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
-		unsigned long arg)
+static int imxdma_terminate_all(struct dma_chan *chan)
 {
 	struct imxdma_channel *imxdmac = to_imxdma_chan(chan);
-	struct dma_slave_config *dmaengine_cfg = (void *)arg;
 	struct imxdma_engine *imxdma = imxdmac->imxdma;
 	unsigned long flags;
-	unsigned int mode = 0;
-
-	switch (cmd) {
-	case DMA_TERMINATE_ALL:
-		imxdma_disable_hw(imxdmac);
 
-		spin_lock_irqsave(&imxdma->lock, flags);
-		list_splice_tail_init(&imxdmac->ld_active, &imxdmac->ld_free);
-		list_splice_tail_init(&imxdmac->ld_queue, &imxdmac->ld_free);
-		spin_unlock_irqrestore(&imxdma->lock, flags);
-		return 0;
-	case DMA_SLAVE_CONFIG:
-		if (dmaengine_cfg->direction == DMA_DEV_TO_MEM) {
-			imxdmac->per_address = dmaengine_cfg->src_addr;
-			imxdmac->watermark_level = dmaengine_cfg->src_maxburst;
-			imxdmac->word_size = dmaengine_cfg->src_addr_width;
-		} else {
-			imxdmac->per_address = dmaengine_cfg->dst_addr;
-			imxdmac->watermark_level = dmaengine_cfg->dst_maxburst;
-			imxdmac->word_size = dmaengine_cfg->dst_addr_width;
-		}
-
-		switch (imxdmac->word_size) {
-		case DMA_SLAVE_BUSWIDTH_1_BYTE:
-			mode = IMX_DMA_MEMSIZE_8;
-			break;
-		case DMA_SLAVE_BUSWIDTH_2_BYTES:
-			mode = IMX_DMA_MEMSIZE_16;
-			break;
-		default:
-		case DMA_SLAVE_BUSWIDTH_4_BYTES:
-			mode = IMX_DMA_MEMSIZE_32;
-			break;
-		}
+	imxdma_disable_hw(imxdmac);
 
-		imxdmac->hw_chaining = 0;
+	spin_lock_irqsave(&imxdma->lock, flags);
+	list_splice_tail_init(&imxdmac->ld_active, &imxdmac->ld_free);
+	list_splice_tail_init(&imxdmac->ld_queue, &imxdmac->ld_free);
+	spin_unlock_irqrestore(&imxdma->lock, flags);
+	return 0;
+}
 
-		imxdmac->ccr_from_device = (mode | IMX_DMA_TYPE_FIFO) |
-			((IMX_DMA_MEMSIZE_32 | IMX_DMA_TYPE_LINEAR) << 2) |
-			CCR_REN;
-		imxdmac->ccr_to_device =
-			(IMX_DMA_MEMSIZE_32 | IMX_DMA_TYPE_LINEAR) |
-			((mode | IMX_DMA_TYPE_FIFO) << 2) | CCR_REN;
-		imx_dmav1_writel(imxdma, imxdmac->dma_request,
-				 DMA_RSSR(imxdmac->channel));
+static int imxdma_config(struct dma_chan *chan,
+			 struct dma_slave_config *dmaengine_cfg)
+{
+	struct imxdma_channel *imxdmac = to_imxdma_chan(chan);
+	struct imxdma_engine *imxdma = imxdmac->imxdma;
+	unsigned int mode = 0;
 
-		/* Set burst length */
-		imx_dmav1_writel(imxdma, imxdmac->watermark_level *
-				imxdmac->word_size, DMA_BLR(imxdmac->channel));
+	if (dmaengine_cfg->direction == DMA_DEV_TO_MEM) {
+		imxdmac->per_address = dmaengine_cfg->src_addr;
+		imxdmac->watermark_level = dmaengine_cfg->src_maxburst;
+		imxdmac->word_size = dmaengine_cfg->src_addr_width;
+	} else {
+		imxdmac->per_address = dmaengine_cfg->dst_addr;
+		imxdmac->watermark_level = dmaengine_cfg->dst_maxburst;
+		imxdmac->word_size = dmaengine_cfg->dst_addr_width;
+	}
 
-		return 0;
+	switch (imxdmac->word_size) {
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		mode = IMX_DMA_MEMSIZE_8;
+		break;
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		mode = IMX_DMA_MEMSIZE_16;
+		break;
 	default:
-		return -ENOSYS;
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		mode = IMX_DMA_MEMSIZE_32;
+		break;
 	}
 
-	return -EINVAL;
+	imxdmac->hw_chaining = 0;
+
+	imxdmac->ccr_from_device = (mode | IMX_DMA_TYPE_FIFO) |
+		((IMX_DMA_MEMSIZE_32 | IMX_DMA_TYPE_LINEAR) << 2) |
+		CCR_REN;
+	imxdmac->ccr_to_device =
+		(IMX_DMA_MEMSIZE_32 | IMX_DMA_TYPE_LINEAR) |
+		((mode | IMX_DMA_TYPE_FIFO) << 2) | CCR_REN;
+	imx_dmav1_writel(imxdma, imxdmac->dma_request,
+			 DMA_RSSR(imxdmac->channel));
+
+	/* Set burst length */
+	imx_dmav1_writel(imxdma, imxdmac->watermark_level *
+			 imxdmac->word_size, DMA_BLR(imxdmac->channel));
+
+	return 0;
 }
 
 static enum dma_status imxdma_tx_status(struct dma_chan *chan,
@@ -1184,7 +1182,8 @@ static int __init imxdma_probe(struct platform_device *pdev)
 	imxdma->dma_device.device_prep_dma_cyclic = imxdma_prep_dma_cyclic;
 	imxdma->dma_device.device_prep_dma_memcpy = imxdma_prep_dma_memcpy;
 	imxdma->dma_device.device_prep_interleaved_dma = imxdma_prep_dma_interleaved;
-	imxdma->dma_device.device_control = imxdma_control;
+	imxdma->dma_device.device_config = imxdma_config;
+	imxdma->dma_device.device_terminate_all = imxdma_terminate_all;
 	imxdma->dma_device.device_issue_pending = imxdma_issue_pending;
 
 	platform_set_drvdata(pdev, imxdma);
-- 
2.1.1
