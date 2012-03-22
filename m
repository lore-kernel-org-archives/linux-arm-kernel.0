From: javier.martin@vista-silicon.com (Javier Martin)
Date: Thu, 22 Mar 2012 14:54:11 +0100
Subject: [PATCH v4 11/15] dmaengine: imx-dma: remove unused arg of
 imxdma_sg_next.
In-Reply-To: <1332424455-15594-1-git-send-email-javier.martin@vista-silicon.com>
References: <1332424455-15594-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1332424455-15594-12-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since this function is always used with 'desc' as first argument
and 'desc->sg' as second argument, the latter is clearly redundant
and can be removed.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 drivers/dma/imx-dma.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 629be35..628b0f6 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -206,9 +206,10 @@ static int imxdma_hw_chain(struct imxdma_channel *imxdmac)
 /*
  * imxdma_sg_next - prepare next chunk for scatter-gather DMA emulation
  */
-static inline int imxdma_sg_next(struct imxdma_desc *d, struct scatterlist *sg)
+static inline int imxdma_sg_next(struct imxdma_desc *d)
 {
 	struct imxdma_channel *imxdmac = to_imxdma_chan(d->desc.chan);
+	struct scatterlist *sg = d->sg;
 	unsigned long now;
 
 	now = min(d->len, sg->length);
@@ -251,7 +252,7 @@ static void imxdma_enable_hw(struct imxdma_desc *d)
 		d->sg = sg_next(d->sg);
 		if (d->sg) {
 			u32 tmp;
-			imxdma_sg_next(d, d->sg);
+			imxdma_sg_next(d);
 			tmp = imx_dmav1_readl(DMA_CCR(channel));
 			imx_dmav1_writel(tmp | CCR_RPT | CCR_ACRPT,
 				DMA_CCR(channel));
@@ -365,7 +366,7 @@ static void dma_irq_handle_channel(struct imxdma_channel *imxdmac)
 		desc->sg = sg_next(desc->sg);
 
 		if (desc->sg) {
-			imxdma_sg_next(desc, desc->sg);
+			imxdma_sg_next(desc);
 
 			tmp = imx_dmav1_readl(DMA_CCR(chno));
 
@@ -475,7 +476,7 @@ static int imxdma_xfer_desc(struct imxdma_desc *d)
 			return -EINVAL;
 		}
 
-		imxdma_sg_next(d, d->sg);
+		imxdma_sg_next(d);
 
 		break;
 	default:
-- 
1.7.0.4
