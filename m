From: zonque@gmail.com (Daniel Mack)
Date: Sat, 10 Aug 2013 18:52:22 +0200
Subject: [PATCH v2 08/11] dma: mmp_pdma: add support for byte-aligned transfers
In-Reply-To: <1376153545-14361-1-git-send-email-zonque@gmail.com>
References: <1376153545-14361-1-git-send-email-zonque@gmail.com>
Message-ID: <1376153545-14361-9-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PXA DMA controller has a DALGN register which allows for
byte-aligned DMA transfers. Use it in case any of the transfer
descriptors is not aligned to a mask of ~0x7.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/mmp_pdma.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index d7ccc90..579f79a 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -109,6 +109,7 @@ struct mmp_pdma_chan {
 	struct list_head chain_pending;	/* Link descriptors queue for pending */
 	struct list_head chain_running;	/* Link descriptors queue for running */
 	bool idle;			/* channel statue machine */
+	bool byte_align;
 
 	struct dma_pool *desc_pool;	/* Descriptors pool */
 };
@@ -142,7 +143,7 @@ static void set_desc(struct mmp_pdma_phy *phy, dma_addr_t addr)
 
 static void enable_chan(struct mmp_pdma_phy *phy)
 {
-	u32 reg;
+	u32 reg, dalgn;
 
 	if (!phy->vchan)
 		return;
@@ -150,6 +151,13 @@ static void enable_chan(struct mmp_pdma_phy *phy)
 	reg = DRCMR(phy->vchan->drcmr);
 	writel(DRCMR_MAPVLD | phy->idx, phy->base + reg);
 
+	dalgn = readl(phy->base + DALGN);
+	if (phy->vchan->byte_align)
+		dalgn |= 1 << phy->idx;
+	else
+		dalgn &= ~(1 << phy->idx);
+	writel(dalgn, phy->base + DALGN);
+
 	reg = (phy->idx << 2) + DCSR;
 	writel(readl(phy->base + reg) | DCSR_RUN,
 					phy->base + reg);
@@ -454,6 +462,7 @@ mmp_pdma_prep_memcpy(struct dma_chan *dchan,
 		return NULL;
 
 	chan = to_mmp_pdma_chan(dchan);
+	chan->byte_align = false;
 
 	if (!chan->dir) {
 		chan->dir = DMA_MEM_TO_MEM;
@@ -470,6 +479,8 @@ mmp_pdma_prep_memcpy(struct dma_chan *dchan,
 		}
 
 		copy = min_t(size_t, len, PDMA_MAX_DESC_BYTES);
+		if (dma_src & 0x7 || dma_dst & 0x7)
+			chan->byte_align = true;
 
 		new->desc.dcmd = chan->dcmd | (DCMD_LENGTH & copy);
 		new->desc.dsadr = dma_src;
@@ -529,12 +540,16 @@ mmp_pdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	if ((sgl == NULL) || (sg_len == 0))
 		return NULL;
 
+	chan->byte_align = false;
+
 	for_each_sg(sgl, sg, sg_len, i) {
 		addr = sg_dma_address(sg);
 		avail = sg_dma_len(sgl);
 
 		do {
 			len = min_t(size_t, avail, PDMA_MAX_DESC_BYTES);
+			if (addr & 0x7)
+				chan->byte_align = true;
 
 			/* allocate and populate the descriptor */
 			new = mmp_pdma_alloc_descriptor(chan);
-- 
1.8.3.1
