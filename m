From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 10 Sep 2015 19:17:45 +0200
Subject: [PATCH 1/2] dma: pxa_dma: fix the no-requestor case
Message-ID: <1441905466-17459-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A very small number of devices don't use the flow control offered by
requestor lines. In these specific cases, the pxa dma driver should be
aware of that and not try to use a requestor line.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/pxa_dma.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index bb85cd7b5b70..5647c1579c44 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -474,8 +474,10 @@ static void pxad_free_phy(struct pxad_chan *chan)
 		return;
 
 	/* clear the channel mapping in DRCMR */
-	reg = pxad_drcmr(chan->drcmr);
-	writel_relaxed(0, chan->phy->base + reg);
+	if (chan->drcmr <= DRCMR_CHLNUM) {
+		reg = pxad_drcmr(chan->drcmr);
+		writel_relaxed(0, chan->phy->base + reg);
+	}
 
 	spin_lock_irqsave(&pdev->phy_lock, flags);
 	for (i = 0; i < 32; i++)
@@ -517,8 +519,10 @@ static void phy_enable(struct pxad_phy *phy, bool misaligned)
 		"%s(); phy=%p(%d) misaligned=%d\n", __func__,
 		phy, phy->idx, misaligned);
 
-	reg = pxad_drcmr(phy->vchan->drcmr);
-	writel_relaxed(DRCMR_MAPVLD | phy->idx, phy->base + reg);
+	if (phy->vchan->drcmr <= DRCMR_CHLNUM) {
+		reg = pxad_drcmr(phy->vchan->drcmr);
+		writel_relaxed(DRCMR_MAPVLD | phy->idx, phy->base + reg);
+	}
 
 	dalgn = phy_readl_relaxed(phy, DALGN);
 	if (misaligned)
@@ -911,14 +915,18 @@ static void pxad_get_config(struct pxad_chan *chan,
 		width = chan->cfg.src_addr_width;
 		dev_addr = chan->cfg.src_addr;
 		*dev_src = dev_addr;
-		*dcmd |= PXA_DCMD_INCTRGADDR | PXA_DCMD_FLOWSRC;
+		*dcmd |= PXA_DCMD_INCTRGADDR;
+		if (chan->drcmr <= DRCMR_CHLNUM)
+			*dcmd |= PXA_DCMD_FLOWSRC;
 	}
 	if (chan->cfg.direction == DMA_MEM_TO_DEV) {
 		maxburst = chan->cfg.dst_maxburst;
 		width = chan->cfg.dst_addr_width;
 		dev_addr = chan->cfg.dst_addr;
 		*dev_dst = dev_addr;
-		*dcmd |= PXA_DCMD_INCSRCADDR | PXA_DCMD_FLOWTRG;
+		*dcmd |= PXA_DCMD_INCSRCADDR;
+		if (chan->drcmr <= DRCMR_CHLNUM)
+			*dcmd |= PXA_DCMD_FLOWTRG;
 	}
 	if (chan->cfg.direction == DMA_MEM_TO_MEM)
 		*dcmd |= PXA_DCMD_BURST32 | PXA_DCMD_INCTRGADDR |
-- 
2.1.4
