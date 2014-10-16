From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 12:17:48 +0200
Subject: [PATCH v2 49/53] dmaengine: omap: Declare slave capabilities for the
 generic code
In-Reply-To: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413454672-27400-50-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the generic slave caps code can make use of the device assigned
capabilities, instead of relying on a callback to be implemented.

Make use of this code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/omap-dma.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 767fbfaa6592..def56ea309ab 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -1067,19 +1067,6 @@ static void omap_dma_free(struct omap_dmadev *od)
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
@@ -1113,7 +1100,11 @@ static int omap_dma_probe(struct platform_device *pdev)
 	od->ddev.device_pause = omap_dma_pause;
 	od->ddev.device_resume = omap_dma_resume;
 	od->ddev.device_terminate_all = omap_dma_terminate_all;
-	od->ddev.device_slave_caps = omap_dma_device_slave_caps;
+	od->ddev.src_addr_widths = OMAP_DMA_BUSWIDTHS;
+	od->ddev.dst_addr_widths = OMAP_DMA_BUSWIDTHS;
+	od->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	od->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+	od->ddev.generic_slave_caps = true;
 	od->ddev.dev = &pdev->dev;
 	INIT_LIST_HEAD(&od->ddev.channels);
 	INIT_LIST_HEAD(&od->pending);
-- 
2.1.1
