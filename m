From: Barry.Song@csr.com (Barry Song)
Date: Thu, 27 Sep 2012 16:36:10 +0800
Subject: [PATCH 2/3] dmaengine: sirf: fix a typo in moving running dma_desc to
 active queue
Message-ID: <1348734970-20050-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

list_move_tail(&schan->queued, &schan->active) makes the list_empty(schan->queued)
undefined, we either should change it to:
list_move_tail(schan->queued.next, &schan->active)
or
list_move_tail(&sdesc->node, &schan->active)

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/dma/sirf-dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 35a329d..c439489 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -109,7 +109,7 @@ static void sirfsoc_dma_execute(struct sirfsoc_dma_chan *schan)
 	sdesc = list_first_entry(&schan->queued, struct sirfsoc_dma_desc,
 		node);
 	/* Move the first queued descriptor to active list */
-	list_move_tail(&schan->queued, &schan->active);
+	list_move_tail(&sdesc->node, &schan->active);
 
 	/* Start the DMA transfer */
 	writel_relaxed(sdesc->width, sdma->base + SIRFSOC_DMA_WIDTH_0 +
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
