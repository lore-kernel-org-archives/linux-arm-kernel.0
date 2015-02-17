From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 17 Feb 2015 21:39:06 +0100
Subject: [PATCH v2 1/2] dma: mmp_dma: add support for legacy transition
In-Reply-To: <1423954053-21760-1-git-send-email-robert.jarzmik@free.fr>
References: <1423954053-21760-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1424205547-15429-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to achieve smooth transition of pxa drivers from old legacy dma
handling to new dmaengine, introduce a function to "hide" dma physical
channels from dmaengine.

This is temporary situation where pxa dma will be handled in 2 places :
 - arch/arm/plat-pxa/dma.c
 - drivers/dma/mmp_pdma.c

The resources, ie. dma channels, will be controlled by mmp_dma. The
legacy code will request or release a channel with
mmp_pdma_toggle_reserved_channel().

This is not very pretty, but it ensures both legacy and dmaengine
consumers can live in the same kernel until the conversion is done.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: fix irq handler to not touch legacy reserved dma interrupts
---
 drivers/dma/mmp_pdma.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 8926f27..1b82bd6 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -198,6 +198,15 @@ static int clear_chan_irq(struct mmp_pdma_phy *phy)
 	return 0;
 }
 
+/*
+ * In the transition phase where legacy pxa handling is done at the same time as
+ * mmp_dma, the DMA physical channel split between the 2 DMA providers is done
+ * through legacy_reserved. Legacy code reserves DMA channels by settings
+ * corresponding bits in legacy_reserved.
+ */
+static u32 legacy_reserved;
+static u32 legacy_unavailable;
+
 static irqreturn_t mmp_pdma_chan_handler(int irq, void *dev_id)
 {
 	struct mmp_pdma_phy *phy = dev_id;
@@ -221,6 +230,8 @@ static irqreturn_t mmp_pdma_int_handler(int irq, void *dev_id)
 		i = __ffs(dint);
 		dint &= (dint - 1);
 		phy = &pdev->phy[i];
+		if ((i < 32) && (legacy_reserved & (1 << i)))
+			continue;
 		ret = mmp_pdma_chan_handler(irq, phy);
 		if (ret == IRQ_HANDLED)
 			irq_num++;
@@ -253,10 +264,14 @@ static struct mmp_pdma_phy *lookup_phy(struct mmp_pdma_chan *pchan)
 		for (i = 0; i < pdev->dma_channels; i++) {
 			if (prio != (i & 0xf) >> 2)
 				continue;
+			if ((i < 32) && (legacy_reserved & (1 << i)))
+				continue;
 			phy = &pdev->phy[i];
 			if (!phy->vchan) {
 				phy->vchan = pchan;
 				found = phy;
+				if (i < 32)
+					legacy_unavailable |= (1 << i);
 				goto out_unlock;
 			}
 		}
@@ -272,6 +287,7 @@ static void mmp_pdma_free_phy(struct mmp_pdma_chan *pchan)
 	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(pchan->chan.device);
 	unsigned long flags;
 	u32 reg;
+	int i;
 
 	if (!pchan->phy)
 		return;
@@ -281,6 +297,9 @@ static void mmp_pdma_free_phy(struct mmp_pdma_chan *pchan)
 	writel(0, pchan->phy->base + reg);
 
 	spin_lock_irqsave(&pdev->phy_lock, flags);
+	for (i = 0; i < 32; i++)
+		if (pchan->phy == &pdev->phy[i])
+			legacy_unavailable &= ~(1 << i);
 	pchan->phy->vchan = NULL;
 	pchan->phy = NULL;
 	spin_unlock_irqrestore(&pdev->phy_lock, flags);
@@ -1121,6 +1140,15 @@ bool mmp_pdma_filter_fn(struct dma_chan *chan, void *param)
 }
 EXPORT_SYMBOL_GPL(mmp_pdma_filter_fn);
 
+int mmp_pdma_toggle_reserved_channel(int legacy_channel)
+{
+	if (legacy_unavailable & (1 << legacy_channel))
+		return -EBUSY;
+	legacy_reserved ^= 1 << legacy_channel;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mmp_pdma_toggle_reserved_channel);
+
 module_platform_driver(mmp_pdma_driver);
 
 MODULE_DESCRIPTION("MARVELL MMP Peripheral DMA Driver");
-- 
2.1.0
