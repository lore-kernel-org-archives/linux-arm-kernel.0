From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 10 Aug 2010 22:36:21 +0200
Subject: ARM: 2.6.3[45] PCI regression (IXP4xx and PXA?)
Message-ID: <m3sk2m433u.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Noticed this problem a bit late :-(

6fee48cd330c68332f9712bc968d934a1a84a32a broke
pci_set_consistent_dma_mask() on IXP4xx and most probably PXA. Affected
devices are e.g. IDE controller (CS5536-based: disk inaccessible) and
e1000 ethernet ("Detected Tx Unit Hang").

The attached patch makes it work again, though I'm not sure it's the
best solution.

Ideas?

Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ca32ed7..bd2a7d3 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -129,6 +129,14 @@ static inline u64 dma_get_mask(struct device *dev)
 
 static inline int dma_set_coherent_mask(struct device *dev, u64 mask)
 {
+#ifdef CONFIG_DMABOUNCE
+	if (dev->archdata.dmabounce) {
+		if (mask >= ISA_DMA_THRESHOLD)
+			return 0;
+		else
+			return -EIO;
+	}
+#endif
 	if (!dma_supported(dev, mask))
 		return -EIO;
 	dev->coherent_dma_mask = mask;
