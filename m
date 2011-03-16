From: b32955@freescale.com (Huang Shijie)
Date: Wed, 16 Mar 2011 09:42:52 +0800
Subject: [PATCH 6/7] dmaengine: change the flags of request_irq()
In-Reply-To: <1300239773-4222-1-git-send-email-b32955@freescale.com>
References: <1300239773-4222-1-git-send-email-b32955@freescale.com>
Message-ID: <1300239773-4222-7-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPMI may have many DMA channels, such as the imx23 has
four DMA channels. All these DMA channels share the same interrupt.
So change the flags from '0' to IRQF_SHARED, else there will be
an EBUSY error returns.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/dma/mxs-dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 88aad4f..0ee5b52 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -328,7 +328,7 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
 	memset(mxs_chan->ccw, 0, PAGE_SIZE);
 
 	ret = request_irq(mxs_chan->chan_irq, mxs_dma_int_handler,
-				0, "mxs-dma", mxs_dma);
+				IRQF_SHARED, "mxs-dma", mxs_dma);
 	if (ret)
 		goto err_irq;
 
-- 
1.7.0.4
