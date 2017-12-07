From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 7 Dec 2017 10:51:03 +0530
Subject: [PATCH v7 2/6] dmaeninge: xilinx_dma: Fix bug in multiple frame
 stores scenario in vdma
In-Reply-To: <1512624067-13554-1-git-send-email-appanad@xilinx.com>
References: <1512624067-13554-1-git-send-email-appanad@xilinx.com>
Message-ID: <1512624067-13554-3-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VDMA engine default frame buffer configuration is cirular mode.
in this mode dmaengine continuously circles through h/w configured fstore
frame buffers.

When vdma h/w is configured for more than one frame.
for example h/w is configured for n number of frames, user
submits less than n number of frames and triggered the dmaengine
using issue_pending API.

since the h/w (or) driver default configuraiton is circular mode
h/w tries to write/read from an invalid frame buffer resulting
errors from the vdma dmaengine.

This patch fixes this issue by enabling the park mode as
default mode configuration for frame buffers in s/w,
so that driver can handle all cases for "k" frames where n%k==0
(n is a multiple of k) by simply replicating the frame pointers.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v7:
---> Used park mode as default configuration as suggested
by Mike Looijmans.
---> Updated commit message as suggested by Vinod(No need to
start each line with Title cases).
Changes for v6:
---> Added Rob Acked-by
---> Updated commit message as suggested by Vinod.
Changes for v5:
---> Updated xlnx,fstore-config property to xlnx,fstore-enable
     and updated description as suggested by Rob.
Changes for v4:
---> Add Check for framestore configuration on Transmit case as well
     as suggested by Jose Abreu.
---> Modified the dev_dbg checks to dev_warn checks as suggested
     by Jose Abreu.
Changes for v3:
---> Added Checks for frame store configuration. If frame store
     Configuration is not present at the h/w level and user
     Submits less frames added debug prints in the driver as relevant.
Changes for v2:
---> Fixed race conditions in the driver as suggested by Jose Abreu
---> Fixed unnecessray if else checks in the vdma_start_transfer
     as suggested by Laurent Pinchart.

 drivers/dma/xilinx/xilinx_dma.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index c246563..9063ca0 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -99,7 +99,9 @@
 #define XILINX_DMA_REG_FRMPTR_STS		0x0024
 #define XILINX_DMA_REG_PARK_PTR		0x0028
 #define XILINX_DMA_PARK_PTR_WR_REF_SHIFT	8
+#define XILINX_DMA_PARK_PTR_WR_REF_MASK		GENMASK(12, 8)
 #define XILINX_DMA_PARK_PTR_RD_REF_SHIFT	0
+#define XILINX_DMA_PARK_PTR_RD_REF_MASK		GENMASK(4, 0)
 #define XILINX_DMA_REG_VDMA_VERSION		0x002c
 
 /* Register Direct Mode Registers */
@@ -998,7 +1000,7 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 {
 	struct xilinx_vdma_config *config = &chan->config;
 	struct xilinx_dma_tx_descriptor *desc, *tail_desc;
-	u32 reg;
+	u32 reg, j;
 	struct xilinx_vdma_tx_segment *tail_segment;
 
 	/* This function was invoked with lock held */
@@ -1035,10 +1037,6 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 	else
 		reg &= ~XILINX_DMA_DMACR_FRAMECNT_EN;
 
-	/* Configure channel to allow number frame buffers */
-	dma_ctrl_write(chan, XILINX_DMA_REG_FRMSTORE,
-			chan->desc_pendingcount);
-
 	/*
 	 * With SG, start with circular mode, so that BDs can be fetched.
 	 * In direct register mode, if not parking, enable circular mode
@@ -1051,17 +1049,16 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 
 	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 
-	if (config->park && (config->park_frm >= 0) &&
-			(config->park_frm < chan->num_frms)) {
-		if (chan->direction == DMA_MEM_TO_DEV)
-			dma_write(chan, XILINX_DMA_REG_PARK_PTR,
-				config->park_frm <<
-					XILINX_DMA_PARK_PTR_RD_REF_SHIFT);
-		else
-			dma_write(chan, XILINX_DMA_REG_PARK_PTR,
-				config->park_frm <<
-					XILINX_DMA_PARK_PTR_WR_REF_SHIFT);
+	j = chan->desc_submitcount;
+	reg = dma_read(chan, XILINX_DMA_REG_PARK_PTR);
+	if (chan->direction == DMA_MEM_TO_DEV) {
+		reg &= ~XILINX_DMA_PARK_PTR_RD_REF_MASK;
+		reg |= j << XILINX_DMA_PARK_PTR_RD_REF_SHIFT;
+	} else {
+		reg &= ~XILINX_DMA_PARK_PTR_WR_REF_MASK;
+		reg |= j << XILINX_DMA_PARK_PTR_WR_REF_SHIFT;
 	}
+	dma_write(chan, XILINX_DMA_REG_PARK_PTR, reg);
 
 	/* Start the hardware */
 	xilinx_dma_start(chan);
@@ -1073,6 +1070,8 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 	if (chan->has_sg) {
 		dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC,
 				tail_segment->phys);
+		list_splice_tail_init(&chan->pending_list, &chan->active_list);
+		chan->desc_pendingcount = 0;
 	} else {
 		struct xilinx_vdma_tx_segment *segment, *last = NULL;
 		int i = 0;
@@ -1102,18 +1101,13 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 		vdma_desc_write(chan, XILINX_DMA_REG_FRMDLY_STRIDE,
 				last->hw.stride);
 		vdma_desc_write(chan, XILINX_DMA_REG_VSIZE, last->hw.vsize);
-	}
 
-	if (!chan->has_sg) {
-		list_del(&desc->node);
-		list_add_tail(&desc->node, &chan->active_list);
 		chan->desc_submitcount++;
 		chan->desc_pendingcount--;
+		list_del(&desc->node);
+		list_add_tail(&desc->node, &chan->active_list);
 		if (chan->desc_submitcount == chan->num_frms)
 			chan->desc_submitcount = 0;
-	} else {
-		list_splice_tail_init(&chan->pending_list, &chan->active_list);
-		chan->desc_pendingcount = 0;
 	}
 
 	chan->idle = false;
@@ -1364,6 +1358,7 @@ static int xilinx_dma_reset(struct xilinx_dma_chan *chan)
 
 	chan->err = false;
 	chan->idle = true;
+	chan->desc_submitcount = 0;
 
 	return err;
 }
@@ -2363,6 +2358,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		chan->ctrl_offset = XILINX_DMA_MM2S_CTRL_OFFSET;
 		if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
 			chan->desc_offset = XILINX_VDMA_MM2S_DESC_OFFSET;
+			chan->config.park = 1;
 
 			if (xdev->flush_on_fsync == XILINX_DMA_FLUSH_BOTH ||
 			    xdev->flush_on_fsync == XILINX_DMA_FLUSH_MM2S)
@@ -2379,6 +2375,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		chan->ctrl_offset = XILINX_DMA_S2MM_CTRL_OFFSET;
 		if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
 			chan->desc_offset = XILINX_VDMA_S2MM_DESC_OFFSET;
+			chan->config.park = 1;
 
 			if (xdev->flush_on_fsync == XILINX_DMA_FLUSH_BOTH ||
 			    xdev->flush_on_fsync == XILINX_DMA_FLUSH_S2MM)
-- 
2.7.4
