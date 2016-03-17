From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 17 Mar 2016 11:50:29 -0400
Subject: [PATCH] arm64: dma-mapping: fix dma_to_phys API for IOMMU attached
 devices
Message-ID: <1458229833-4886-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies dma_to_phys to call iommu_iova_to_phys to perform dma
to phys conversions for IOMMU attached devices where dma and physical
addresses often have distinct values.

Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/arm64/include/asm/dma-mapping.h |  5 +----
 arch/arm64/mm/dma-mapping.c          | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index ba437f0..a0a486c 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -69,10 +69,7 @@ static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 	return (dma_addr_t)paddr;
 }
 
-static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
-{
-	return (phys_addr_t)dev_addr;
-}
+phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr);
 
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 331c4ca..8252a92 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -989,3 +989,19 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	dev->archdata.dma_coherent = coherent;
 	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
 }
+
+phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
+{
+	phys_addr_t phys = (phys_addr_t)dev_addr;
+
+#ifdef CONFIG_IOMMU_DMA
+	struct iommu_domain *domain;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (domain)
+		phys = iommu_iova_to_phys(domain, dev_addr);
+#endif
+
+	return phys;
+}
+EXPORT_SYMBOL(dma_to_phys);
-- 
1.8.2.1
