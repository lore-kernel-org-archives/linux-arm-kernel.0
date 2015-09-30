From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 30 Sep 2015 19:42:14 +0200
Subject: [PATCH v2 1/2] dma: pxa_dma: fix the no-requestor case
Message-ID: <1443634935-28989-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A very small number of devices don't use the flow control offered by
requestor lines. In these specific cases, the pxa dma driver should be
aware of that and not try to use a requestor line.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: rebase on v4.3-rc3
---
 drivers/dma/pxa_dma.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 5cb61ce01036..7d3ff56caa0a 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -473,8 +473,10 @@ static void pxad_free_phy(struct pxad_chan *chan)
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
@@ -516,8 +518,10 @@ static void phy_enable(struct pxad_phy *phy, bool misaligned)
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
@@ -910,14 +914,18 @@ static void pxad_get_config(struct pxad_chan *chan,
 		width = chan->cfg.src_addr_width;
 		dev_addr = chan->cfg.src_addr;
 		*dev_src = dev_addr;
-		*dcmd |= PXA_DCMD_INCTRGADDR | PXA_DCMD_FLOWSRC;
+		*dcmd |= PXA_DCMD_INCTRGADDR;
+		if (chan->drcmr <= DRCMR_CHLNUM)
+			*dcmd |= PXA_DCMD_FLOWSRC;
 	}
 	if (dir == DMA_MEM_TO_DEV) {
 		maxburst = chan->cfg.dst_maxburst;
 		width = chan->cfg.dst_addr_width;
 		dev_addr = chan->cfg.dst_addr;
 		*dev_dst = dev_addr;
-		*dcmd |= PXA_DCMD_INCSRCADDR | PXA_DCMD_FLOWTRG;
+		*dcmd |= PXA_DCMD_INCSRCADDR;
+		if (chan->drcmr <= DRCMR_CHLNUM)
+			*dcmd |= PXA_DCMD_FLOWTRG;
 	}
 	if (dir == DMA_MEM_TO_MEM)
 		*dcmd |= PXA_DCMD_BURST32 | PXA_DCMD_INCTRGADDR |
-- 
2.1.4
