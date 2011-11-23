From: b32955@freescale.com (Huang Shijie)
Date: Wed, 23 Nov 2011 17:13:05 +0800
Subject: [PATCH] IMX/SDMA : save the real count for one DMA transaction.
Message-ID: <1322039585-7901-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we use the SDMA in the UART driver(such as imx6q), we will
meet one situation:
  Assume we set 64 bytes for the RX DMA buffer.
The receiving DMA buffer is not full, but the an Aging DMA request
will be received by the SDMA controller if we enable the
IDDMAEN(UCR4[6]).
  The UART driver needs to know the count of the real received bytes,
and push them to upper layer.

  So reuse the `private` field of dma_chan{}. Store the count of received bytes
to it, and use it in the UART driver.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/dma/imx-sdma.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index f993955..19ce579 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -501,6 +501,8 @@ static void sdma_handle_channel_loop(struct sdma_channel *sdmac)
 static void mxc_sdma_handle_channel_normal(struct sdma_channel *sdmac)
 {
 	struct sdma_buffer_descriptor *bd;
+	struct dma_chan *chan = &sdmac->chan;
+	unsigned int count;
 	int i, error = 0;
 
 	/*
@@ -512,8 +514,12 @@ static void mxc_sdma_handle_channel_normal(struct sdma_channel *sdmac)
 
 		 if (bd->mode.status & (BD_DONE | BD_RROR))
 			error = -EIO;
+		 count += bd->mode.count;
 	}
 
+	/* save the real count we received or transmitted. */
+	chan->private = (void *)count;
+
 	if (error)
 		sdmac->status = DMA_ERROR;
 	else
-- 
1.7.3.2
