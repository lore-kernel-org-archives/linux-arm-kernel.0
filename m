From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 10 Feb 2014 15:56:49 +0000
Subject: [PATCH 11/26] dmaengine: omap-dma: consolidate clearing channel
 status register
In-Reply-To: <20140210155531.GB26684@n2100.arm.linux.org.uk>
References: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Message-ID: <E1WCtE1-0006Wk-HU@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 324f4c7c5dd0..d1641aa9d113 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -169,6 +169,14 @@ static void omap_dma_desc_free(struct virt_dma_desc *vd)
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
@@ -191,11 +199,7 @@ static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
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
@@ -214,11 +218,7 @@ static void omap_dma_stop(struct omap_chan *c)
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
1.8.3.1
