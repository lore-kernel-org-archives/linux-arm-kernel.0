From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 25 May 2015 23:29:22 +0200
Subject: [PATCH v4 5/5] dmaengine: pxa_dma: add support for legacy transition
In-Reply-To: <1432589362-23241-1-git-send-email-robert.jarzmik@free.fr>
References: <1432589362-23241-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1432589362-23241-5-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to achieve smooth transition of pxa drivers from old legacy dma
handling to new dmaengine, introduce a function to "hide" dma physical
channels from dmaengine.

This is temporary situation where pxa dma will be handled in 2 places :
 - arch/arm/plat-pxa/dma.c
 - drivers/dma/pxa_dma.c

The resources, ie. dma channels, will be controlled by pxa_dma. The
legacy code will request or release a channel with
pxad_toggle_reserved_channel().

This is not very pretty, but it ensures both legacy and dmaengine
consumers can live in the same kernel until the conversion is done.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/pxa_dma.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 7da79d0..ddcbbf5 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -410,6 +410,15 @@ static inline void pxad_init_debugfs(struct pxad_device *pdev) {}
 static inline void pxad_cleanup_debugfs(struct pxad_device *pdev) {}
 #endif
 
+/*
+ * In the transition phase where legacy pxa handling is done at the same time as
+ * mmp_dma, the DMA physical channel split between the 2 DMA providers is done
+ * through legacy_reserved. Legacy code reserves DMA channels by settings
+ * corresponding bits in legacy_reserved.
+ */
+static u32 legacy_reserved;
+static u32 legacy_unavailable;
+
 static struct pxad_phy *lookup_phy(struct pxad_chan *pchan)
 {
 	int prio, i;
@@ -430,10 +439,14 @@ static struct pxad_phy *lookup_phy(struct pxad_chan *pchan)
 		for (i = 0; i < pdev->nr_chans; i++) {
 			if (prio != (i & 0xf) >> 2)
 				continue;
+			if ((i < 32) && (legacy_reserved & BIT(i)))
+				continue;
 			phy = &pdev->phys[i];
 			if (!phy->vchan) {
 				phy->vchan = pchan;
 				found = phy;
+				if (i < 32)
+					legacy_unavailable |= BIT(i);
 				goto out_unlock;
 			}
 		}
@@ -453,6 +466,7 @@ static void pxad_free_phy(struct pxad_chan *chan)
 	struct pxad_device *pdev = to_pxad_dev(chan->vc.chan.device);
 	unsigned long flags;
 	u32 reg;
+	int i;
 
 	dev_dbg(&chan->vc.chan.dev->device,
 		"%s(): freeing\n", __func__);
@@ -464,6 +478,9 @@ static void pxad_free_phy(struct pxad_chan *chan)
 	writel_relaxed(0, chan->phy->base + reg);
 
 	spin_lock_irqsave(&pdev->phy_lock, flags);
+	for (i = 0; i < 32; i++)
+		if (chan->phy == &pdev->phys[i])
+			legacy_unavailable &= ~BIT(i);
 	chan->phy->vchan = NULL;
 	chan->phy = NULL;
 	spin_unlock_irqrestore(&pdev->phy_lock, flags);
@@ -694,6 +711,8 @@ static irqreturn_t pxad_int_handler(int irq, void *dev_id)
 		i = __ffs(dint);
 		dint &= (dint - 1);
 		phy = &pdev->phys[i];
+		if ((i < 32) && (legacy_reserved & BIT(i)))
+			continue;
 		if (pxad_chan_handler(irq, phy) == IRQ_HANDLED)
 			ret = IRQ_HANDLED;
 	}
@@ -1432,6 +1451,15 @@ bool pxad_filter_fn(struct dma_chan *chan, void *param)
 }
 EXPORT_SYMBOL_GPL(pxad_filter_fn);
 
+int pxad_toggle_reserved_channel(int legacy_channel)
+{
+	if (legacy_unavailable & (BIT(legacy_channel)))
+		return -EBUSY;
+	legacy_reserved ^= BIT(legacy_channel);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pxad_toggle_reserved_channel);
+
 module_platform_driver(pxad_driver);
 
 MODULE_DESCRIPTION("Marvell PXA Peripheral DMA Driver");
-- 
2.1.4
