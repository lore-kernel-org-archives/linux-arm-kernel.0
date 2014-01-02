From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 15:10:40 +0000
Subject: [PATCH RFC 11/26] dmaengine: omap-dma: consolidate clearing channel
 status register
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Message-ID: <E1Vyjuy-0005Ef-Rl@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index ba0e10db5185..574f38e3fead 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -168,6 +168,14 @@ static void omap_dma_desc_free(struct virt_dma_desc *vd)
 	kfree(container_of(vd, struct omap_desc, vd));
 }
 
+static void omap_dma_clear_csr(struct omap_chan *c)
+{
+	if (dma_omap1())
+		c->plat->dma_read(CSR, c->dma_ch);
+	else
+		c->plat->dma_write(~0, CSR, c->dma_ch);
+}
+
 static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
 {
 	struct omap_dmadev *od = to_omap_dma_dev(c->vc.chan.device);
@@ -190,11 +198,7 @@ static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
 	} else if (od->plat->errata & DMA_ERRATA_PARALLEL_CHANNELS)
 		c->plat->dma_write(c->dma_ch, CLNK_CTRL, c->dma_ch);
 
-	/* Clear CSR */
-	if (dma_omap1())
-		c->plat->dma_read(CSR, c->dma_ch);
-	else
-		c->plat->dma_write(~0, CSR, c->dma_ch);
+	omap_dma_clear_csr(c);
 
 	/* Enable interrupts */
 	c->plat->dma_write(d->cicr, CICR, c->dma_ch);
@@ -213,11 +217,7 @@ static void omap_dma_stop(struct omap_chan *c)
 	/* disable irq */
 	c->plat->dma_write(0, CICR, c->dma_ch);
 
-	/* Clear CSR */
-	if (dma_omap1())
-		c->plat->dma_read(CSR, c->dma_ch);
-	else
-		c->plat->dma_write(~0, CSR, c->dma_ch);
+	omap_dma_clear_csr(c);
 
 	val = c->plat->dma_read(CCR, c->dma_ch);
 	if (od->plat->errata & DMA_ERRATA_i541 && val & CCR_TRIGGER_SRC) {
-- 
1.7.4.4
