From: Barry.Song@csr.com (Barry Song)
Date: Fri, 14 Dec 2012 18:59:22 +0800
Subject: [PATCH v2] DMAEngine: sirf: add DMA pause/resume support
Message-ID: <1355482762-28688-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

pause/resume are important for users like ALSA sound drivers,
this patches make the sirf prima2/marco support DMA commands
DMA_PAUSE and DMA_RESUME.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 -v2:
 lock the critical section of writing shared hardware registers

 drivers/dma/sirf-dma.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 212f69f..623f195 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -313,6 +313,48 @@ static int sirfsoc_dma_terminate_all(struct sirfsoc_dma_chan *schan)
 	return 0;
 }
 
+static int sirfsoc_dma_pause_chan(struct sirfsoc_dma_chan *schan)
+{
+	struct sirfsoc_dma *sdma = dma_chan_to_sirfsoc_dma(&schan->chan);
+	int cid = schan->chan.chan_id;
+	unsigned long flags;
+
+	spin_lock_irqsave(&schan->lock, flags);
+
+	if (!sdma->is_marco)
+		writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL)
+			& ~((1 << cid) | 1 << (cid + 16)),
+			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
+	else
+		writel_relaxed((1 << cid) | 1 << (cid + 16),
+			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL_CLR);
+
+	spin_unlock_irqrestore(&schan->lock, flags);
+
+	return 0;
+}
+
+static int sirfsoc_dma_resume_chan(struct sirfsoc_dma_chan *schan)
+{
+	struct sirfsoc_dma *sdma = dma_chan_to_sirfsoc_dma(&schan->chan);
+	int cid = schan->chan.chan_id;
+	unsigned long flags;
+
+	spin_lock_irqsave(&schan->lock, flags);
+
+	if (!sdma->is_marco)
+		writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL)
+			| ((1 << cid) | 1 << (cid + 16)),
+			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
+	else
+		writel_relaxed((1 << cid) | 1 << (cid + 16),
+			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
+
+	spin_unlock_irqrestore(&schan->lock, flags);
+
+	return 0;
+}
+
 static int sirfsoc_dma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 	unsigned long arg)
 {
@@ -320,6 +362,10 @@ static int sirfsoc_dma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 	struct sirfsoc_dma_chan *schan = dma_chan_to_sirfsoc_dma_chan(chan);
 
 	switch (cmd) {
+	case DMA_PAUSE:
+		return sirfsoc_dma_pause_chan(schan);
+	case DMA_RESUME:
+		return sirfsoc_dma_resume_chan(schan);
 	case DMA_TERMINATE_ALL:
 		return sirfsoc_dma_terminate_all(schan);
 	case DMA_SLAVE_CONFIG:
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
