From: b32955@freescale.com (Huang Shijie)
Date: Fri, 5 Jul 2013 15:50:55 +0800
Subject: [PATCH] dma: imx-sdma: remove the unused completion
Message-ID: <1373010655-3800-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the patch: "2ccaef0 dma: imx-sdma: make channel0 operations atomic",
the "done" completion is not used any more.

Just remove it.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/dma/imx-sdma.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 1e44b8c..2c02a9d 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -243,7 +243,6 @@ struct sdma_engine;
  * @event_id1		for channels that use 2 events
  * @word_size		peripheral access size
  * @buf_tail		ID of the buffer that was processed
- * @done		channel completion
  * @num_bd		max NUM_BD. number of descriptors currently handling
  */
 struct sdma_channel {
@@ -255,7 +254,6 @@ struct sdma_channel {
 	unsigned int			event_id1;
 	enum dma_slave_buswidth		word_size;
 	unsigned int			buf_tail;
-	struct completion		done;
 	unsigned int			num_bd;
 	struct sdma_buffer_descriptor	*bd;
 	dma_addr_t			bd_phys;
@@ -547,8 +545,6 @@ static void sdma_tasklet(unsigned long data)
 {
 	struct sdma_channel *sdmac = (struct sdma_channel *) data;
 
-	complete(&sdmac->done);
-
 	if (sdmac->flags & IMX_DMA_SG_LOOP)
 		sdma_handle_channel_loop(sdmac);
 	else
@@ -812,9 +808,6 @@ static int sdma_request_channel(struct sdma_channel *sdmac)
 	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
 
 	sdma_set_channel_priority(sdmac, MXC_SDMA_DEFAULT_PRIORITY);
-
-	init_completion(&sdmac->done);
-
 	return 0;
 out:
 
-- 
1.7.1
