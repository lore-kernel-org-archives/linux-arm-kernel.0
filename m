From: agraf@suse.de (Alexander Graf)
Date: Wed, 18 May 2016 14:53:30 +0200
Subject: [PATCH v2] arm64: Allow for different DMA and CPU bus offsets
Message-ID: <1463576010-115428-1-git-send-email-agraf@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On arm64, all SoCs we supported so far either have an IOMMU or have bus
addresses equal to CPU addresses.

However, with the Raspberry Pi 3 coming up, this is no longer true. To
allow DMA to work with an AArch64 kernel on those devices, let's allow
devices to have DMA offsets again.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

This patch may conflict with another patch titled "swiotlb: prefix dma_to_phys
and phys_to_dma functions" which is in flight, but hasn't seen an update since
March.

Since this patch is very small and isolated to arm64, I'd prefer to keep them
separate rather than combine them. So if the other patch gets accepted first,
I'm happy to rebase this patch on top of a topic branch that would address the
rename.

v1 -> v2:

  - Use PAGE_SHIFT explicitly rather than __pfn_to_phys and __phys_to_pfn
---
 arch/arm64/include/asm/dma-mapping.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index ba437f0..c14e9cd 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -66,12 +66,16 @@ static inline bool is_device_dma_coherent(struct device *dev)
 
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	return (dma_addr_t)paddr;
+	dma_addr_t dev_addr = (dma_addr_t)paddr;
+
+	return dev_addr - ((dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
 }
 
 static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 {
-	return (phys_addr_t)dev_addr;
+	phys_addr_t paddr = (phys_addr_t)dev_addr;
+
+	return paddr + ((phys_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
 }
 
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
@@ -86,5 +90,14 @@ static inline void dma_mark_clean(void *addr, size_t size)
 {
 }
 
+/* Override for dma_max_pfn() */
+static inline unsigned long dma_max_pfn(struct device *dev)
+{
+	dma_addr_t dma_max = (dma_addr_t)*dev->dma_mask;
+
+	return (ulong)dma_to_phys(dev, dma_max) >> PAGE_SHIFT;
+}
+#define dma_max_pfn(dev) dma_max_pfn(dev)
+
 #endif	/* __KERNEL__ */
 #endif	/* __ASM_DMA_MAPPING_H */
-- 
1.8.5.6
