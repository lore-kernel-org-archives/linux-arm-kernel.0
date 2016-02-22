From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Mon, 22 Feb 2016 11:24:36 +0530
Subject: [PATCH v2 3/4] dmaengine: xilinx_vdma: Fix issues with non-parking
 mode
In-Reply-To: <1456120477-32134-1-git-send-email-appanad@xilinx.com>
References: <1456120477-32134-1-git-send-email-appanad@xilinx.com>
Message-ID: <1456120477-32134-3-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes issues with the Non-parking mode(Cirular mode).
With the  existing driver in cirular mode if we submit frames less than h/w
configured we simply end-up having misconfigured vdma h/w.
This patch fixes this issue by configuring the frame count register.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v2:
---> splitted the changes into multiple patches.

 drivers/dma/xilinx/xilinx_vdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
index d646218..8db07f7 100644
--- a/drivers/dma/xilinx/xilinx_vdma.c
+++ b/drivers/dma/xilinx/xilinx_vdma.c
@@ -645,6 +645,10 @@ static void xilinx_vdma_start_transfer(struct xilinx_vdma_chan *chan)
 	else
 		reg &= ~XILINX_VDMA_DMACR_FRAMECNT_EN;
 
+	/* Configure channel to allow number frame buffers */
+	vdma_ctrl_write(chan, XILINX_VDMA_REG_FRMSTORE,
+			chan->desc_pendingcount);
+
 	/*
 	 * With SG, start with circular mode, so that BDs can be fetched.
 	 * In direct register mode, if not parking, enable circular mode
-- 
2.1.2
