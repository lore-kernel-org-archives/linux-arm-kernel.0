From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 3 Oct 2017 11:35:38 +0300
Subject: [PATCH v2 2/2] dmaengine: omap-dma: Implement protection for invalid
 max_burst
In-Reply-To: <20171003083538.11044-1-peter.ujfalusi@ti.com>
References: <20171003083538.11044-1-peter.ujfalusi@ti.com>
Message-ID: <20171003083538.11044-3-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?Set the device's max_burst to 16777215 (EN is 24bit unsigned value) so
clients can take this into consideration when setting up the transfer.

During slave transfer preparation check if the requested maxburst is valid.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <linux@armlinux.org.uk>
---
 drivers/dma/omap-dma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 8c1665c8fe33..f6dd849159d8 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -1288,6 +1288,10 @@ static int omap_dma_slave_config(struct dma_chan *chan, struct dma_slave_config
 	    cfg->dst_addr_width == DMA_SLAVE_BUSWIDTH_8_BYTES)
 		return -EINVAL;
 
+	if (cfg->src_maxburst > chan->device->max_burst ||
+	    cfg->dst_maxburst > chan->device->max_burst)
+		return -EINVAL;
+
 	memcpy(&c->cfg, cfg, sizeof(c->cfg));
 
 	return 0;
@@ -1482,6 +1486,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 	od->ddev.dst_addr_widths = OMAP_DMA_BUSWIDTHS;
 	od->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	od->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+	od->ddev.max_burst = SZ_16M - 1; /* CCEN: 24bit unsigned */
 	od->ddev.dev = &pdev->dev;
 	INIT_LIST_HEAD(&od->ddev.channels);
 	spin_lock_init(&od->lock);
-- 
2.14.2


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
