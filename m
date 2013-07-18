From: joelf@ti.com (Joel Fernandes)
Date: Thu, 18 Jul 2013 11:46:40 -0500
Subject: [PATCH 2/3] mmc: omap_hsmmc: set max_segs based on dma engine limits
In-Reply-To: <1374166001-31340-1-git-send-email-joelf@ti.com>
References: <1374166001-31340-1-git-send-email-joelf@ti.com>
Message-ID: <1374166001-31340-3-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matt Porter <mporter@ti.com>

The EDMA DMAC has a hardware limitation that prevents supporting
scatter gather lists with any number of segments. The DMA Engine
API reports the maximum number of segments a channel can support
via the optional dma_get_slave_sg_limits() API. If the max_nr_segs
limit is present, the value is used to configure mmc->max_segs
appropriately.

[Joel Fernandes <joelf@ti.com>: Allocate sg_limits structure in
client driver, and have the dmaengine implementation fill it up]
Signed-off-by: Matt Porter <mporter@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Joel Fernandes <joelf@ti.com>
Cc: Mark Jackson <mpfj-list@newflow.co.uk>
---
 drivers/mmc/host/omap_hsmmc.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index eccedc7..b723095 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1776,6 +1776,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	dma_cap_mask_t mask;
 	unsigned tx_req, rx_req;
+	struct dma_slave_sg_limits dma_sg_limits;
 	struct pinctrl *pinctrl;
 
 	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
@@ -1952,6 +1953,14 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
+	/* Some DMA Engines only handle a limited number of SG segments */
+	ret = dma_get_slave_sg_limits(host->rx_chan,
+				DMA_SLAVE_BUSWIDTH_4_BYTES,
+				mmc->max_blk_size / 4,
+				&dma_sg_limits);
+	if (!ret && dma_sg_limits.max_seg_nr)
+		mmc->max_segs = dma_sg_limits.max_seg_nr;
+
 	/* Request IRQ for MMC operations */
 	ret = request_irq(host->irq, omap_hsmmc_irq, 0,
 			mmc_hostname(mmc), host);
-- 
1.7.9.5
