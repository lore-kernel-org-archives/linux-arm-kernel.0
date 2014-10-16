From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 12:17:45 +0200
Subject: [PATCH v2 46/53] dmaengine: fsl-edma: Declare slave capabilities for
 the generic code
In-Reply-To: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413454672-27400-47-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the generic slave caps code can make use of the device assigned
capabilities, instead of relying on a callback to be implemented.

Make use of this code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/fsl-edma.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index b5b7474f8859..2d76a2fad3f7 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -784,18 +784,6 @@ static void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	fsl_chan->tcd_pool = NULL;
 }
 
-static int fsl_dma_device_slave_caps(struct dma_chan *dchan,
-		struct dma_slave_caps *caps)
-{
-	caps->src_addr_widths = FSL_EDMA_BUSWIDTHS;
-	caps->dst_addr_widths = FSL_EDMA_BUSWIDTHS;
-	caps->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
-	caps->cmd_pause = true;
-	caps->cmd_terminate = true;
-
-	return 0;
-}
-
 static int
 fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
 {
@@ -926,7 +914,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma->dma_dev.device_resume = fsl_edma_resume;
 	fsl_edma->dma_dev.device_terminate_all = fsl_edma_terminate_all;
 	fsl_edma->dma_dev.device_issue_pending = fsl_edma_issue_pending;
-	fsl_edma->dma_dev.device_slave_caps = fsl_dma_device_slave_caps;
+
+	fsl_edma->dma_dev.src_addr_widths = FSL_EDMA_BUSWIDTHS;
+	fsl_edma->dma_dev.dst_addr_widths = FSL_EDMA_BUSWIDTHS;
+	fsl_edma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	fsl_edma->dma_dev.generic_slave_caps = true;
 
 	platform_set_drvdata(pdev, fsl_edma);
 
-- 
2.1.1
