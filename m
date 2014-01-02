From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 15:11:21 +0000
Subject: [PATCH RFC 15/26] dmaengine: omap-dma: use cached CCR value when
 enabling DMA
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Message-ID: <E1Vyjvd-0005Ew-9c@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need to read-modify-write the CCR register; we already know
what value it should contain at this point.  Use the cached CCR value
when setting the enable bit.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index e212e0df9b42..98e77adeaeb3 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -180,7 +180,6 @@ static void omap_dma_clear_csr(struct omap_chan *c)
 static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
 {
 	struct omap_dmadev *od = to_omap_dma_dev(c->vc.chan.device);
-	uint32_t val;
 
 	if (__dma_omap15xx(od->plat->dma_attr))
 		c->plat->dma_write(0, CPC, c->dma_ch);
@@ -192,9 +191,8 @@ static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
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
1.7.4.4
