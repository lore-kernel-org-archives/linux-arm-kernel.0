From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Nov 2014 14:42:49 +0100
Subject: [PATCH v5 55/61] dmaengine: omap: Declare slave capabilities for the
 generic code
In-Reply-To: <1416231775-31252-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1416231775-31252-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1416231775-31252-56-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the generic slave caps code can make use of the device assigned
capabilities, instead of relying on a callback to be implemented.

Make use of this code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/omap-dma.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 1cadf812f3b3..76bb63d6b223 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -1070,19 +1070,6 @@ static void omap_dma_free(struct omap_dmadev *od)
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
 
-static int omap_dma_device_slave_caps(struct dma_chan *dchan,
-				      struct dma_slave_caps *caps)
-{
-	caps->src_addr_widths = OMAP_DMA_BUSWIDTHS;
-	caps->dst_addr_widths = OMAP_DMA_BUSWIDTHS;
-	caps->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
-	caps->cmd_pause = true;
-	caps->cmd_terminate = true;
-	caps->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
-
-	return 0;
-}
-
 static int omap_dma_probe(struct platform_device *pdev)
 {
 	struct omap_dmadev *od;
@@ -1116,7 +1103,10 @@ static int omap_dma_probe(struct platform_device *pdev)
 	od->ddev.device_pause = omap_dma_pause;
 	od->ddev.device_resume = omap_dma_resume;
 	od->ddev.device_terminate_all = omap_dma_terminate_all;
-	od->ddev.device_slave_caps = omap_dma_device_slave_caps;
+	od->ddev.src_addr_widths = OMAP_DMA_BUSWIDTHS;
+	od->ddev.dst_addr_widths = OMAP_DMA_BUSWIDTHS;
+	od->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	od->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	od->ddev.dev = &pdev->dev;
 	INIT_LIST_HEAD(&od->ddev.channels);
 	INIT_LIST_HEAD(&od->pending);
-- 
2.1.1
