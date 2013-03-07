From: mporter@ti.com (Matt Porter)
Date: Wed,  6 Mar 2013 23:16:38 -0500
Subject: [PATCH 1/2] mmc: omap_hsmmc: set max_segs based on dma engine limits
In-Reply-To: <1362629799-22485-1-git-send-email-mporter@ti.com>
References: <1362629799-22485-1-git-send-email-mporter@ti.com>
Message-ID: <1362629799-22485-2-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EDMA DMAC has a hardware limitation that prevents supporting
scatter gather lists with any number of segments. The DMA Engine
API reports the maximum number of segments a channel can support
via the optional dma_get_slave_sg_limits() API. If the max_nr_segs
limit is present, the value is used to configure mmc->max_segs
appropriately.

Signed-off-by: Matt Porter <mporter@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e79b12d..f74d2ef 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1769,6 +1769,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	dma_cap_mask_t mask;
 	unsigned tx_req, rx_req;
+	struct dma_slave_sg_limits *dma_sg_limits;
 	struct pinctrl *pinctrl;
 
 	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
@@ -1935,6 +1936,13 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
+	/* Some DMA Engines only handle a limited number of SG segments */
+	dma_sg_limits = dma_get_slave_sg_limits(host->rx_chan,
+						DMA_SLAVE_BUSWIDTH_4_BYTES,
+						mmc->max_blk_size / 4);
+	if (dma_sg_limits && dma_sg_limits->max_seg_nr)
+		mmc->max_segs = dma_sg_limits->max_seg_nr;
+
 	/* Request IRQ for MMC operations */
 	ret = request_irq(host->irq, omap_hsmmc_irq, 0,
 			mmc_hostname(mmc), host);
-- 
1.7.9.5
