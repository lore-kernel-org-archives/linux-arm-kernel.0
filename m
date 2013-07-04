From: Baohua.Song@csr.com (Barry Song)
Date: Thu, 4 Jul 2013 16:42:53 +0800
Subject: [PATCH] DMAEngine: sirf: let the users be able to pause and resume
 specific buffer
Message-ID: <1372927373-17407-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

this patch adds a buffer_index in pause and resume entries, then users
can pause and resume a buffer they want, but don't pause the whole dma.

a typical application scenerios is Ping-Pang in two buffers:
at the beginning, we enable buf1 and buf2 to receive dma data, after
buf1 is full, we pause buf1 and handle the data in this buffer to avoid
overflow in buf1. but at the same time, dma is still tranferring in buf2.
once we have finished data process in buf1, we enable buf1 again.
this will maximize the chance of dma transferring. users pause buf1 by:
dmaengine_device_control(sirfport->rx_dma_chan, DMA_PAUSE, 1);
users pause buf2 by:
dmaengine_device_control(sirfport->rx_dma_chan, DMA_PAUSE, 2);
users can still pause the whole dma transferring by dmaengine_pause().

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/dma/sirf-dma.c | 102 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 80 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 1d627e2..7d500d2 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -315,43 +315,101 @@ static int sirfsoc_dma_terminate_all(struct sirfsoc_dma_chan *schan)
 	return 0;
 }
 
-static int sirfsoc_dma_pause_chan(struct sirfsoc_dma_chan *schan)
+static int sirfsoc_dma_pause_chan(struct sirfsoc_dma_chan *schan,
+						unsigned long buf_index)
 {
 	struct sirfsoc_dma *sdma = dma_chan_to_sirfsoc_dma(&schan->chan);
 	int cid = schan->chan.chan_id;
 	unsigned long flags;
+	unsigned long loop_ctrl_val;
 
 	spin_lock_irqsave(&schan->lock, flags);
-
-	if (!sdma->is_marco)
-		writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL)
-			& ~((1 << cid) | 1 << (cid + 16)),
-			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
-	else
-		writel_relaxed((1 << cid) | 1 << (cid + 16),
-			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL_CLR);
-
+	if (!sdma->is_marco) {
+		loop_ctrl_val = readl_relaxed(sdma->base +
+				SIRFSOC_DMA_CH_LOOP_CTRL);
+		switch (buf_index) {
+		case 1:
+			writel_relaxed(loop_ctrl_val & ~(1 << cid),
+					sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
+			break;
+		case 2:
+			writel_relaxed(loop_ctrl_val & ~(1 << (cid + 16)),
+					sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
+			break;
+		case 0:
+		default:
+			writel_relaxed(loop_ctrl_val &
+					~((1 << cid) | 1 << (cid + 16)),
+					sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
+			break;
+		}
+	} else {
+		switch (buf_index) {
+		case 1:
+			writel_relaxed((1 << cid), sdma->base +
+						SIRFSOC_DMA_CH_LOOP_CTRL_CLR);
+			break;
+		case 2:
+			writel_relaxed(1 << (cid + 16), sdma->base +
+						SIRFSOC_DMA_CH_LOOP_CTRL_CLR);
+			break;
+		case 0:
+		default:
+			writel_relaxed((1 << cid) | 1 << (cid + 16),
+				sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL_CLR);
+			break;
+		}
+	}
 	spin_unlock_irqrestore(&schan->lock, flags);
 
 	return 0;
 }
 
-static int sirfsoc_dma_resume_chan(struct sirfsoc_dma_chan *schan)
+static int sirfsoc_dma_resume_chan(struct sirfsoc_dma_chan *schan,
+						unsigned long buf_index)
 {
 	struct sirfsoc_dma *sdma = dma_chan_to_sirfsoc_dma(&schan->chan);
 	int cid = schan->chan.chan_id;
 	unsigned long flags;
+	unsigned long loop_ctrl_val;
 
 	spin_lock_irqsave(&schan->lock, flags);
-
-	if (!sdma->is_marco)
-		writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL)
-			| ((1 << cid) | 1 << (cid + 16)),
-			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
-	else
-		writel_relaxed((1 << cid) | 1 << (cid + 16),
-			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
-
+	if (!sdma->is_marco) {
+		loop_ctrl_val = readl_relaxed(sdma->base +
+				SIRFSOC_DMA_CH_LOOP_CTRL);
+		switch (buf_index) {
+		case 1:
+			writel_relaxed(loop_ctrl_val | (1 << cid),
+					sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
+			break;
+		case 2:
+			writel_relaxed(loop_ctrl_val | 1 << (cid + 16),
+					sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
+			break;
+		case 0:
+		default:
+			writel_relaxed(loop_ctrl_val | (1 << cid) |
+					1 << (cid + 16),
+					sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
+			break;
+		}
+	} else {
+		switch (buf_index) {
+		case 1:
+			writel_relaxed((1 << cid),
+					sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
+			break;
+		case 2:
+			writel_relaxed((1 << (cid + 16)),
+					sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
+			break;
+		case 0:
+		default:
+			writel_relaxed((1 << cid) | 1 << (cid + 16),
+					sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
+			break;
+		}
+	}
 	spin_unlock_irqrestore(&schan->lock, flags);
 
 	return 0;
@@ -365,9 +423,9 @@ static int sirfsoc_dma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 
 	switch (cmd) {
 	case DMA_PAUSE:
-		return sirfsoc_dma_pause_chan(schan);
+		return sirfsoc_dma_pause_chan(schan, arg);
 	case DMA_RESUME:
-		return sirfsoc_dma_resume_chan(schan);
+		return sirfsoc_dma_resume_chan(schan, arg);
 	case DMA_TERMINATE_ALL:
 		return sirfsoc_dma_terminate_all(schan);
 	case DMA_SLAVE_CONFIG:
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
