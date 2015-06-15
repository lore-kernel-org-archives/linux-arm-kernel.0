From: stillcompiling@gmail.com (Joshua Clayton)
Date: Mon, 15 Jun 2015 09:19:04 -0700
Subject: [PATCH 09/10] dma: imx-sdma: use a for loop
In-Reply-To: <1434385144-4432-1-git-send-email-stillcompiling@gmail.com>
References: <1434385144-4432-1-git-send-email-stillcompiling@gmail.com>
Message-ID: <1434385144-4432-10-git-send-email-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch out the strange while loop for a for loop
Someone might have thought the this construction potects against
odd sized buffers, but num_periods will alwasy be no bigger than
the number of whole buffer descriptors

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/dma/imx-sdma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 4d447be..dfebef9 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1158,7 +1158,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	struct sdma_engine *sdma = to_sdma_engine(sdmac);
 	int num_periods = buf_len / period_len;
 	int channel = sdmac->channel;
-	int ret, i = 0, buf = 0;
+	int ret, i;
 
 	sdma_prep_common(sdmac, buf_len / period_len, direction);
 
@@ -1166,7 +1166,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 
 	sdmac->flags |= IMX_DMA_SG_LOOP;
 
-	while (buf < buf_len) {
+	for (i = 0; i < num_periods; i++) {
 		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
 		int param;
 
@@ -1191,9 +1191,6 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		bd->mode.status = param;
 
 		dma_addr += period_len;
-		buf += period_len;
-
-		i++;
 	}
 
 	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
-- 
2.1.4
