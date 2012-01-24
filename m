From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Tue, 24 Jan 2012 14:22:01 +0100
Subject: [PATCH 1/1 v2] i.MX SDMA: Fix burstsize settings
In-Reply-To: <4F1D5304.3080003@ru.mvista.com>
References: <4F1D5304.3080003@ru.mvista.com>
Message-ID: <1327411321-30017-1-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 6584cb88 (ARM i.MX dma: Fix burstsize settings) fixed
the mxcmmc driver but forgot to fix the SDMA driver to handle the
correct burtsize.
This make the SD card access works again with DMA on i.MX31 boards.

Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index f993955..c193dac 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1095,11 +1095,13 @@ static int sdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 	case DMA_SLAVE_CONFIG:
 		if (dmaengine_cfg->direction == DMA_FROM_DEVICE) {
 			sdmac->per_address = dmaengine_cfg->src_addr;
-			sdmac->watermark_level = dmaengine_cfg->src_maxburst;
+			sdmac->watermark_level = dmaengine_cfg->src_maxburst *
+						dmaengine_cfg->src_addr_width;
 			sdmac->word_size = dmaengine_cfg->src_addr_width;
 		} else {
 			sdmac->per_address = dmaengine_cfg->dst_addr;
-			sdmac->watermark_level = dmaengine_cfg->dst_maxburst;
+			sdmac->watermark_level = dmaengine_cfg->dst_maxburst *
+						dmaengine_cfg->dst_addr_width;
 			sdmac->word_size = dmaengine_cfg->dst_addr_width;
 		}
 		return sdma_config_channel(sdmac);
-- 
1.6.3.3
