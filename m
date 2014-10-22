From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 Oct 2014 17:44:06 +0200
Subject: [PATCH v3 52/59] dmaengine: edma: Declare slave capabilities for the
 generic code
In-Reply-To: <1413992653-21963-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413992653-21963-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413992653-21963-53-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the generic slave caps code can make use of the device assigned
capabilities, instead of relying on a callback to be implemented.

Make use of this code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/edma.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 56735a0aa3a8..ea9c03122806 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -971,19 +971,6 @@ static void __init edma_chan_init(struct edma_cc *ecc,
 				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
 
-static int edma_dma_device_slave_caps(struct dma_chan *dchan,
-				      struct dma_slave_caps *caps)
-{
-	caps->src_addr_widths = EDMA_DMA_BUSWIDTHS;
-	caps->dst_addr_widths = EDMA_DMA_BUSWIDTHS;
-	caps->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
-	caps->cmd_pause = true;
-	caps->cmd_terminate = true;
-	caps->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
-
-	return 0;
-}
-
 static void edma_dma_init(struct edma_cc *ecc, struct dma_device *dma,
 			  struct device *dev)
 {
@@ -998,7 +985,13 @@ static void edma_dma_init(struct edma_cc *ecc, struct dma_device *dma,
 	dma->device_pause = edma_dma_pause;
 	dma->device_resume = edma_dma_resume;
 	dma->device_terminate_all = edma_terminate_all;
-	dma->device_slave_caps = edma_dma_device_slave_caps;
+
+	dma->src_addr_widths = EDMA_DMA_BUSWIDTHS;
+	dma->dst_addr_widths = EDMA_DMA_BUSWIDTHS;
+	dma->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	dma->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+	dma->generic_slave_caps = true;
+
 	dma->dev = dev;
 
 	/*
-- 
2.1.1
