From: javier.martin@vista-silicon.com (Javier Martin)
Date: Thu, 22 Mar 2012 14:54:09 +0100
Subject: [PATCH v4 09/15] dmaengine: imx-dma: remove 'resbytes' field of
 'internal' structure.
In-Reply-To: <1332424455-15594-1-git-send-email-javier.martin@vista-silicon.com>
References: <1332424455-15594-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1332424455-15594-10-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use per-descriptor 'len' field to keep track of the remaining bytes
instead. This goes on the direction of eventually removing the
'internal' structure.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 drivers/dma/imx-dma.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index d7309e4..6e03f92 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -129,8 +129,6 @@ enum  imxdma_prep_type {
  */
 
 struct imxdma_channel_internal {
-	unsigned int resbytes;
-
 	struct timer_list watchdog;
 
 	int hw_chaining;
@@ -233,12 +231,11 @@ static int imxdma_hw_chain(struct imxdma_channel_internal *imxdma)
 static inline int imxdma_sg_next(struct imxdma_desc *d, struct scatterlist *sg)
 {
 	struct imxdma_channel *imxdmac = to_imxdma_chan(d->desc.chan);
-	struct imxdma_channel_internal *imxdma = &imxdmac->internal;
 	unsigned long now;
 
-	now = min(imxdma->resbytes, sg->length);
-	if (imxdma->resbytes != IMX_DMA_LENGTH_LOOP)
-		imxdma->resbytes -= now;
+	now = min(d->len, sg->length);
+	if (d->len != IMX_DMA_LENGTH_LOOP)
+		d->len -= now;
 
 	if (d->direction == DMA_DEV_TO_MEM)
 		imx_dmav1_writel(sg->dma_address, DMA_DAR(imxdmac->channel));
@@ -480,8 +477,6 @@ static int imxdma_xfer_desc(struct imxdma_desc *d)
 	/* Cyclic transfer is the same as slave_sg with special sg configuration. */
 	case IMXDMA_DESC_CYCLIC:
 	case IMXDMA_DESC_SLAVE_SG:
-		imxdmac->internal.resbytes = d->len;
-
 		if (d->direction == DMA_DEV_TO_MEM) {
 			imx_dmav1_writel(imxdmac->per_address,
 					 DMA_SAR(imxdmac->channel));
-- 
1.7.0.4
