From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Oct 2014 22:26:04 +0100
Subject: [PATCH v4 49/58] dmaengine: bcm2835: Declare slave capabilities for
 the generic code
In-Reply-To: <1414531573-18807-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1414531573-18807-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1414531573-18807-50-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the generic slave caps code can make use of the device assigned
capabilities, instead of relying on a callback to be implemented.

Make use of this code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
---
 drivers/dma/bcm2835-dma.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 243bb1ed6bfc..891183ff6d1b 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -552,18 +552,6 @@ static struct dma_chan *bcm2835_dma_xlate(struct of_phandle_args *spec,
 	return chan;
 }
 
-static int bcm2835_dma_device_slave_caps(struct dma_chan *dchan,
-	struct dma_slave_caps *caps)
-{
-	caps->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
-	caps->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
-	caps->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
-	caps->cmd_pause = false;
-	caps->cmd_terminate = true;
-
-	return 0;
-}
-
 static int bcm2835_dma_probe(struct platform_device *pdev)
 {
 	struct bcm2835_dmadev *od;
@@ -605,6 +593,9 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	od->ddev.device_prep_dma_cyclic = bcm2835_dma_prep_dma_cyclic;
 	od->ddev.device_config = bcm2835_dma_slave_config;
 	od->ddev.device_terminate_all = bcm2835_dma_terminate_all;
+	od->ddev.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	od->ddev.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	od->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	od->ddev.dev = &pdev->dev;
 	INIT_LIST_HEAD(&od->ddev.channels);
 	spin_lock_init(&od->lock);
-- 
2.1.1
