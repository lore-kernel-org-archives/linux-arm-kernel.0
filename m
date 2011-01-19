From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 20 Jan 2011 05:50:36 +0800
Subject: [PATCH 2/6] dmaengine: imx-sdma: set sdmac->status to DMA_ERROR in
	err_out of sdma_prep_slave_sg()
In-Reply-To: <1295473840-17295-1-git-send-email-shawn.guo@freescale.com>
References: <1295473840-17295-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1295473840-17295-3-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdma_prep_dma_cyclic() sets sdmac->status to DMA_ERROR in err_out,
and sdma_prep_slave_sg() needs to do the same.  Otherwise,
sdmac->status stays at DMA_IN_PROGRESS, which will make the function
return immediately next time it gets called.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/dma/imx-sdma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 45413b7..2aa5131 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -947,6 +947,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 	return &sdmac->desc;
 err_out:
+	sdmac->status = DMA_ERROR;
 	return NULL;
 }
 
-- 
1.7.1
