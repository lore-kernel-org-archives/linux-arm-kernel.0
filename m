From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Wed, 3 Jan 2018 12:12:09 +0530
Subject: [PATCH v2 2/4] dmaengine: xilinx_dma: properly configure the SG mode
 bit in the driver for cdma
In-Reply-To: <1514961731-1916-1-git-send-email-appanad@xilinx.com>
References: <1514961731-1916-1-git-send-email-appanad@xilinx.com>
Message-ID: <1514961731-1916-3-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the hardware is configured for Scatter Gather(SG) mode,
and hardware is idle, in the control register SG mode bit
must be set to a 0 then back to 1 by the software, to force
the CDMA SG engine to use a new value written to the CURDESC_PNTR
register, failure to do so could result errors from the dmaengine.

This patch updates the same.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v2:
--> Improved commit message title and description 
as suggested by Vinod.

 drivers/dma/xilinx/xilinx_dma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 21ac954..8467671 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1204,6 +1204,12 @@ static void xilinx_cdma_start_transfer(struct xilinx_dma_chan *chan)
 	}
 
 	if (chan->has_sg) {
+		dma_ctrl_clr(chan, XILINX_DMA_REG_DMACR,
+			     XILINX_CDMA_CR_SGMODE);
+
+		dma_ctrl_set(chan, XILINX_DMA_REG_DMACR,
+			     XILINX_CDMA_CR_SGMODE);
+
 		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
 			     head_desc->async_tx.phys);
 
@@ -2052,6 +2058,10 @@ static int xilinx_dma_terminate_all(struct dma_chan *dchan)
 		chan->cyclic = false;
 	}
 
+	if ((chan->xdev->dma_config->dmatype == XDMA_TYPE_CDMA) && chan->has_sg)
+		dma_ctrl_clr(chan, XILINX_DMA_REG_DMACR,
+			     XILINX_CDMA_CR_SGMODE);
+
 	return 0;
 }
 
-- 
2.7.4
