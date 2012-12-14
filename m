From: Barry.Song@csr.com (Barry Song)
Date: Fri, 14 Dec 2012 19:06:58 +0800
Subject: [PATCH] DMAEngine: sirf: lock the shared registers access in
 sirfsoc_dma_terminate_all
Message-ID: <1355483218-28814-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Just like Russell pointed out in "DMAEngine: sirf: add DMA
pause/resume support" at
http://www.spinics.net/lists/arm-kernel/msg212496.html
here I find sirfsoc_dma_terminate_all() has same problem,
so move the locking to the front of registers access.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 drivers/dma/sirf-dma.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 623f195..df8e2e6 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -291,6 +291,8 @@ static int sirfsoc_dma_terminate_all(struct sirfsoc_dma_chan *schan)
 	int cid = schan->chan.chan_id;
 	unsigned long flags;
 
+	spin_lock_irqsave(&schan->lock, flags);
+
 	if (!sdma->is_marco) {
 		writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_INT_EN) &
 			~(1 << cid), sdma->base + SIRFSOC_DMA_INT_EN);
@@ -305,9 +307,9 @@ static int sirfsoc_dma_terminate_all(struct sirfsoc_dma_chan *schan)
 
 	writel_relaxed(1 << cid, sdma->base + SIRFSOC_DMA_CH_VALID);
 
-	spin_lock_irqsave(&schan->lock, flags);
 	list_splice_tail_init(&schan->active, &schan->free);
 	list_splice_tail_init(&schan->queued, &schan->free);
+
 	spin_unlock_irqrestore(&schan->lock, flags);
 
 	return 0;
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
