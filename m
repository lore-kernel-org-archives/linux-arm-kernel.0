From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 24 Feb 2015 16:21:21 +0200
Subject: [PATCH 4/6] dmaengine: omap-dma: Take DMA request number from DT if
 it is available
In-Reply-To: <1424787683-19151-1-git-send-email-peter.ujfalusi@ti.com>
References: <1424787683-19151-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1424787683-19151-5-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the dma-requests property from DT to get the number of DMA requests.
In case of legacy boot or failure to find the property, use the default
127 as number of requests.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 56c33e93dd24..7def31c919f4 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -34,6 +34,7 @@ struct omap_dmadev {
 	const struct omap_dma_reg *reg_map;
 	struct omap_system_dma_plat_info *plat;
 	bool legacy;
+	unsigned dma_requests;
 	spinlock_t irq_lock;
 	uint32_t irq_enable_mask;
 	struct omap_chan *lch_map[OMAP_SDMA_CHANNELS];
@@ -1118,7 +1119,15 @@ static int omap_dma_probe(struct platform_device *pdev)
 
 	tasklet_init(&od->task, omap_dma_sched, (unsigned long)od);
 
-	for (i = 0; i < OMAP_SDMA_REQUESTS; i++) {
+	if (!pdev->dev.of_node || of_property_read_u32(pdev->dev.of_node,
+						       "dma-requests",
+						       &od->dma_requests)) {
+		dev_info(&pdev->dev,
+			 "DMA request lines not specified, using 127\n");
+		od->dma_requests = 127;
+	}
+
+	for (i = 0; i < od->dma_requests; i++) {
 		rc = omap_dma_chan_init(od, i);
 		if (rc) {
 			omap_dma_free(od);
-- 
2.3.0
