From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 18 Oct 2016 08:46:32 +0200
Subject: [PATCH] Revert "dmaengine: pxa_dma: add support for legacy transition"
Message-ID: <1476773192-23715-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit c91134d9194478144ba579ca6efeddf628055650.

The conversion of the pxa architecture is now finished for all
drivers, so this functions has fullfilled its purpose and can
now be removed.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/pxa_dma.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 3f56f9ca4482..b53fb618bbf6 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -413,15 +413,6 @@ static inline void pxad_init_debugfs(struct pxad_device *pdev) {}
 static inline void pxad_cleanup_debugfs(struct pxad_device *pdev) {}
 #endif
 
-/*
- * In the transition phase where legacy pxa handling is done at the same time as
- * mmp_dma, the DMA physical channel split between the 2 DMA providers is done
- * through legacy_reserved. Legacy code reserves DMA channels by settings
- * corresponding bits in legacy_reserved.
- */
-static u32 legacy_reserved;
-static u32 legacy_unavailable;
-
 static struct pxad_phy *lookup_phy(struct pxad_chan *pchan)
 {
 	int prio, i;
@@ -442,14 +433,10 @@ static struct pxad_phy *lookup_phy(struct pxad_chan *pchan)
 		for (i = 0; i < pdev->nr_chans; i++) {
 			if (prio != (i & 0xf) >> 2)
 				continue;
-			if ((i < 32) && (legacy_reserved & BIT(i)))
-				continue;
 			phy = &pdev->phys[i];
 			if (!phy->vchan) {
 				phy->vchan = pchan;
 				found = phy;
-				if (i < 32)
-					legacy_unavailable |= BIT(i);
 				goto out_unlock;
 			}
 		}
@@ -469,7 +456,6 @@ static void pxad_free_phy(struct pxad_chan *chan)
 	struct pxad_device *pdev = to_pxad_dev(chan->vc.chan.device);
 	unsigned long flags;
 	u32 reg;
-	int i;
 
 	dev_dbg(&chan->vc.chan.dev->device,
 		"%s(): freeing\n", __func__);
@@ -483,9 +469,6 @@ static void pxad_free_phy(struct pxad_chan *chan)
 	}
 
 	spin_lock_irqsave(&pdev->phy_lock, flags);
-	for (i = 0; i < 32; i++)
-		if (chan->phy == &pdev->phys[i])
-			legacy_unavailable &= ~BIT(i);
 	chan->phy->vchan = NULL;
 	chan->phy = NULL;
 	spin_unlock_irqrestore(&pdev->phy_lock, flags);
@@ -739,8 +722,6 @@ static irqreturn_t pxad_int_handler(int irq, void *dev_id)
 		i = __ffs(dint);
 		dint &= (dint - 1);
 		phy = &pdev->phys[i];
-		if ((i < 32) && (legacy_reserved & BIT(i)))
-			continue;
 		if (pxad_chan_handler(irq, phy) == IRQ_HANDLED)
 			ret = IRQ_HANDLED;
 	}
@@ -1522,15 +1503,6 @@ bool pxad_filter_fn(struct dma_chan *chan, void *param)
 }
 EXPORT_SYMBOL_GPL(pxad_filter_fn);
 
-int pxad_toggle_reserved_channel(int legacy_channel)
-{
-	if (legacy_unavailable & (BIT(legacy_channel)))
-		return -EBUSY;
-	legacy_reserved ^= BIT(legacy_channel);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pxad_toggle_reserved_channel);
-
 module_platform_driver(pxad_driver);
 
 MODULE_DESCRIPTION("Marvell PXA Peripheral DMA Driver");
-- 
2.1.4
