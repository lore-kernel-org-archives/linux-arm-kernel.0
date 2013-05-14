From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 14 May 2013 23:03:20 +0800
Subject: [PATCH] dmaengine: sirf: set dma residue based on the current dma
 transfer position
Message-ID: <1368543800-20430-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <Rongjun.Ying@csr.com>

read SIRFSOC_DMA_CH_ADDR register to get current dma transfer position, then
update dma residue so that things like ALSA drivers work as ALSA drivers need
the right residue value.

Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/dma/sirf-dma.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 1765a0a..716b23e 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -466,12 +466,29 @@ static enum dma_status
 sirfsoc_dma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	struct dma_tx_state *txstate)
 {
+	struct sirfsoc_dma *sdma = dma_chan_to_sirfsoc_dma(chan);
 	struct sirfsoc_dma_chan *schan = dma_chan_to_sirfsoc_dma_chan(chan);
 	unsigned long flags;
 	enum dma_status ret;
+	struct sirfsoc_dma_desc *sdesc;
+	int cid = schan->chan.chan_id;
+	unsigned long dma_pos;
+	unsigned long dma_request_bytes;
+	unsigned long residue;
 
 	spin_lock_irqsave(&schan->lock, flags);
+
+	sdesc = list_first_entry(&schan->active, struct sirfsoc_dma_desc,
+			node);
+	dma_request_bytes = (sdesc->xlen + 1) * (sdesc->ylen + 1) *
+		(sdesc->width * SIRFSOC_DMA_WORD_LEN);
+
 	ret = dma_cookie_status(chan, cookie, txstate);
+	dma_pos = readl_relaxed(sdma->base + cid * 0x10 + SIRFSOC_DMA_CH_ADDR)
+		<< 2;
+	residue = dma_request_bytes - (dma_pos - sdesc->addr);
+	dma_set_residue(txstate, residue);
+
 	spin_unlock_irqrestore(&schan->lock, flags);
 
 	return ret;
-- 
1.7.4.1
