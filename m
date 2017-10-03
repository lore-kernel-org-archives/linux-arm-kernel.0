From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 3 Oct 2017 11:35:37 +0300
Subject: [PATCH v2 1/2] dmaengine: edma: Implement protection for invalid
 max_burst
In-Reply-To: <20171003083538.11044-1-peter.ujfalusi@ti.com>
References: <20171003083538.11044-1-peter.ujfalusi@ti.com>
Message-ID: <20171003083538.11044-2-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?Set the device's max_burst to 32767 (CIDX is 16bit signed value) so clients
can take this into consideration when setting up the transfer.

During slave transfer preparation check if the requested maxburst is valid.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index a7ea20e7b8e9..9364a3ed345a 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -891,6 +891,10 @@ static int edma_slave_config(struct dma_chan *chan,
 	    cfg->dst_addr_width == DMA_SLAVE_BUSWIDTH_8_BYTES)
 		return -EINVAL;
 
+	if (cfg->src_maxburst > chan->device->max_burst ||
+	    cfg->dst_maxburst > chan->device->max_burst)
+		return -EINVAL;
+
 	memcpy(&echan->cfg, cfg, sizeof(echan->cfg));
 
 	return 0;
@@ -1868,6 +1872,7 @@ static void edma_dma_init(struct edma_cc *ecc, bool legacy_mode)
 	s_ddev->dst_addr_widths = EDMA_DMA_BUSWIDTHS;
 	s_ddev->directions |= (BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV));
 	s_ddev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+	s_ddev->max_burst = SZ_32K - 1; /* CIDX: 16bit signed */
 
 	s_ddev->dev = ecc->dev;
 	INIT_LIST_HEAD(&s_ddev->channels);
-- 
2.14.2


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
