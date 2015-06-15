From: stillcompiling@gmail.com (Joshua Clayton)
Date: Mon, 15 Jun 2015 09:19:01 -0700
Subject: [PATCH 06/10] dma: imx-sdma: config in sdma_config_channel()
In-Reply-To: <1434385144-4432-1-git-send-email-stillcompiling@gmail.com>
References: <1434385144-4432-1-git-send-email-stillcompiling@gmail.com>
Message-ID: <1434385144-4432-7-git-send-email-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move functionality that is part of sdma_config_channel()
from the switch statement into the function itself.
This puts code together that belongs together, and
gets rid of a single use variable in struct sdma_channel

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/dma/imx-sdma.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 8358a1a..a13383b 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -258,7 +258,6 @@ struct sdma_channel {
 	struct sdma_buffer_descriptor	*bd;
 	dma_addr_t			bd_phys;
 	unsigned long			flags;
-	dma_addr_t			per_address;
 	unsigned long			event_mask[2];
 	unsigned long			watermark_level;
 	u32				shp_addr, per_addr;
@@ -840,12 +839,26 @@ static void sdma_disable_channel(struct sdma_engine *sdma, int channel)
 	sdma->channel[channel].status = DMA_ERROR;
 }
 
-static int sdma_config_channel(struct sdma_channel *sdmac)
+static int sdma_config_channel(struct sdma_channel *sdmac,
+		struct dma_slave_config *dmaengine_cfg)
 {
 	int ret;
 	int channel = sdmac->channel;
 	struct sdma_engine *sdma = to_sdma_engine(sdmac);
+	dma_addr_t per_address;
 
+	if (dmaengine_cfg->direction == DMA_DEV_TO_MEM) {
+		per_address = dmaengine_cfg->src_addr;
+		sdmac->watermark_level = dmaengine_cfg->src_maxburst *
+					dmaengine_cfg->src_addr_width;
+		sdmac->word_size = dmaengine_cfg->src_addr_width;
+	} else {
+		per_address = dmaengine_cfg->dst_addr;
+		sdmac->watermark_level = dmaengine_cfg->dst_maxburst *
+					dmaengine_cfg->dst_addr_width;
+		sdmac->word_size = dmaengine_cfg->dst_addr_width;
+	}
+	sdmac->direction = dmaengine_cfg->direction;
 	sdma_disable_channel(sdma, channel);
 
 	sdmac->event_mask[0] = 0;
@@ -887,7 +900,7 @@ static int sdma_config_channel(struct sdma_channel *sdmac)
 		/* Watermark Level */
 		sdmac->watermark_level |= sdmac->watermark_level;
 		/* Address */
-		sdmac->shp_addr = sdmac->per_address;
+		sdmac->shp_addr = per_address;
 	} else {
 		sdmac->watermark_level = 0; /* FIXME: M3_BASE_ADDRESS */
 	}
@@ -1215,19 +1228,7 @@ static int sdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 		sdma_disable_channel(sdma, sdmac->channel);
 		return 0;
 	case DMA_SLAVE_CONFIG:
-		if (dmaengine_cfg->direction == DMA_DEV_TO_MEM) {
-			sdmac->per_address = dmaengine_cfg->src_addr;
-			sdmac->watermark_level = dmaengine_cfg->src_maxburst *
-						dmaengine_cfg->src_addr_width;
-			sdmac->word_size = dmaengine_cfg->src_addr_width;
-		} else {
-			sdmac->per_address = dmaengine_cfg->dst_addr;
-			sdmac->watermark_level = dmaengine_cfg->dst_maxburst *
-						dmaengine_cfg->dst_addr_width;
-			sdmac->word_size = dmaengine_cfg->dst_addr_width;
-		}
-		sdmac->direction = dmaengine_cfg->direction;
-		return sdma_config_channel(sdmac);
+		return sdma_config_channel(sdmac, dmaengine_cfg);
 	default:
 		return -ENOSYS;
 	}
-- 
2.1.4
