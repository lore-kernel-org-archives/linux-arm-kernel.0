From: stillcompiling@gmail.com (Joshua Clayton)
Date: Mon, 15 Jun 2015 09:19:02 -0700
Subject: [PATCH 07/10] dma: imx-sdma: validate word size when set
In-Reply-To: <1434385144-4432-1-git-send-email-stillcompiling@gmail.com>
References: <1434385144-4432-1-git-send-email-stillcompiling@gmail.com>
Message-ID: <1434385144-4432-8-git-send-email-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than failing during an sdma prep command,
dma_config_channel should fail if an invalid word size is selected.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/dma/imx-sdma.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index a13383b..c9badd4 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -858,6 +858,13 @@ static int sdma_config_channel(struct sdma_channel *sdmac,
 					dmaengine_cfg->dst_addr_width;
 		sdmac->word_size = dmaengine_cfg->dst_addr_width;
 	}
+
+	if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES) {
+		dev_err(sdma->dev, "SDMA channel %d: invalid word size: %d\n",
+				sdmac->channel, sdmac->word_size);
+		return -EINVAL;
+	}
+
 	sdmac->direction = dmaengine_cfg->direction;
 	sdma_disable_channel(sdma, channel);
 
@@ -1088,11 +1095,6 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		bd->mode.count = count;
 		sdmac->chn_count += count;
 
-		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES) {
-			ret =  -EINVAL;
-			goto err_out;
-		}
-
 		switch (sdmac->word_size) {
 		case DMA_SLAVE_BUSWIDTH_4_BYTES:
 			bd->mode.command = 0;
@@ -1183,8 +1185,6 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 
 		bd->mode.count = period_len;
 
-		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES)
-			goto err_out;
 		if (sdmac->word_size == DMA_SLAVE_BUSWIDTH_4_BYTES)
 			bd->mode.command = 0;
 		else
-- 
2.1.4
