From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:25:52 +0200
Subject: [PATCH 15/24] ste_dma40: Move two assignments in d40_prep_sg()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <820bf972-3613-cf77-d243-9ba480c4c9e0@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 15:40:05 +0200

Move assignments for two local variables so that their setting
will only be performed after corresponding data processing succeeded
by this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index a7e7cd0..6725b66 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2236,8 +2236,8 @@ d40_prep_sg(struct dma_chan *dchan, struct scatterlist *sg_src,
 	    enum dma_transfer_direction direction, unsigned long dma_flags)
 {
 	struct d40_chan *chan = container_of(dchan, struct d40_chan, chan);
-	dma_addr_t src_dev_addr = 0;
-	dma_addr_t dst_dev_addr = 0;
+	dma_addr_t src_dev_addr;
+	dma_addr_t dst_dev_addr;
 	struct d40_desc *desc;
 	unsigned long flags;
 	int ret;
@@ -2256,6 +2256,8 @@ d40_prep_sg(struct dma_chan *dchan, struct scatterlist *sg_src,
 	if (sg_next(&sg_src[sg_len - 1]) == sg_src)
 		desc->cyclic = true;
 
+	src_dev_addr = 0;
+	dst_dev_addr = 0;
 	if (direction == DMA_DEV_TO_MEM)
 		src_dev_addr = chan->runtime_addr;
 	else if (direction == DMA_MEM_TO_DEV)
-- 
2.10.0
