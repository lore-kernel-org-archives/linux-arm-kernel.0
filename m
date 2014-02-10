From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 10 Feb 2014 15:57:10 +0000
Subject: [PATCH 15/26] dmaengine: omap-dma: use cached CCR value when enabling
 DMA
In-Reply-To: <20140210155531.GB26684@n2100.arm.linux.org.uk>
References: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Message-ID: <E1WCtEM-0006X0-04@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need to read-modify-write the CCR register; we already know
what value it should contain at this point.  Use the cached CCR value
when setting the enable bit.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 49b303296d75..b270aedf1d15 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -181,7 +181,6 @@ static void omap_dma_clear_csr(struct omap_chan *c)
 static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
 {
 	struct omap_dmadev *od = to_omap_dma_dev(c->vc.chan.device);
-	uint32_t val;
 
 	if (__dma_omap15xx(od->plat->dma_attr))
 		c->plat->dma_write(0, CPC, c->dma_ch);
@@ -193,9 +192,8 @@ static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
 	/* Enable interrupts */
 	c->plat->dma_write(d->cicr, CICR, c->dma_ch);
 
-	val = c->plat->dma_read(CCR, c->dma_ch);
-	val |= CCR_ENABLE;
-	c->plat->dma_write(val, CCR, c->dma_ch);
+	/* Enable channel */
+	c->plat->dma_write(d->ccr | CCR_ENABLE, CCR, c->dma_ch);
 }
 
 static void omap_dma_stop(struct omap_chan *c)
-- 
1.8.3.1
