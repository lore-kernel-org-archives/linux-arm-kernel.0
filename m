From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 12 Sep 2017 13:44:24 +0300
Subject: [PATCH 5/5] dmaengine: omap-dma: Implement device_get_max_len callback
In-Reply-To: <20170912104424.18495-1-peter.ujfalusi@ti.com>
References: <20170912104424.18495-1-peter.ujfalusi@ti.com>
Message-ID: <20170912104424.18495-6-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?sDMA can support maximum of 65535 number of bursts in one transfer.
The limitation is because the CFN counter is 16bit unsigned.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index f6dd849159d8..6418be98a782 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -1297,6 +1297,28 @@ static int omap_dma_slave_config(struct dma_chan *chan, struct dma_slave_config
 	return 0;
 }
 
+static u32 omap_dma_get_max_len(struct dma_chan *chan,
+				enum dma_transfer_direction dir)
+{
+	struct omap_chan *c = to_omap_dma_chan(chan);
+	enum dma_slave_buswidth dev_width;
+	u32 burst;
+
+	if (!is_slave_direction(dir))
+		return 0;
+
+	if (dir == DMA_DEV_TO_MEM) {
+		dev_width = c->cfg.src_addr_width;
+		burst = c->cfg.src_maxburst;
+	} else {
+		burst = c->cfg.dst_maxburst;
+		dev_width = c->cfg.dst_addr_width;
+	}
+
+	/* CFN: 16bit unsigned. Number of bursts */
+	return dev_width * burst * (SZ_64K - 1);
+}
+
 static int omap_dma_terminate_all(struct dma_chan *chan)
 {
 	struct omap_chan *c = to_omap_dma_chan(chan);
@@ -1478,6 +1500,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 	od->ddev.device_prep_dma_memcpy = omap_dma_prep_dma_memcpy;
 	od->ddev.device_prep_interleaved_dma = omap_dma_prep_dma_interleaved;
 	od->ddev.device_config = omap_dma_slave_config;
+	od->ddev.device_get_max_len = omap_dma_get_max_len;
 	od->ddev.device_pause = omap_dma_pause;
 	od->ddev.device_resume = omap_dma_resume;
 	od->ddev.device_terminate_all = omap_dma_terminate_all;
-- 
2.14.1


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
