From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 29 Aug 2013 19:32:22 +0100
Subject: [PATCH v5 01/13] arm: make SWIOTLB available
In-Reply-To: <alpine.DEB.2.02.1308291917290.6397@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1308291917290.6397@kaball.uk.xensource.com>
Message-ID: <1377801154-29215-1-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IOMMU_HELPER is needed because SWIOTLB calls iommu_is_span_boundary,
provided by lib/iommu_helper.c.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: will.deacon at arm.com
CC: linux at arm.linux.org.uk


Changes in v5:
- implement dma_mark_clean using dmac_flush_range.

Changes in v3:
- dma_capable: do not treat dma_mask as a limit;
- remove SWIOTLB dependency on NEED_SG_DMA_LENGTH.
---
 arch/arm/Kconfig                   |    6 ++++++
 arch/arm/include/asm/dma-mapping.h |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ba412e0..c0bfb33 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1832,6 +1832,12 @@ config CC_STACKPROTECTOR
 	  neutralized via a kernel panic.
 	  This feature requires gcc version 4.2 or above.
 
+config SWIOTLB
+	def_bool y
+
+config IOMMU_HELPER
+	def_bool SWIOTLB
+
 config XEN_DOM0
 	def_bool y
 	depends on XEN
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 5b579b9..0982206 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -10,6 +10,7 @@
 
 #include <asm-generic/dma-coherent.h>
 #include <asm/memory.h>
+#include <asm/cacheflush.h>
 
 #define DMA_ERROR_CODE	(~0)
 extern struct dma_map_ops arm_dma_ops;
@@ -86,6 +87,37 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 }
 #endif
 
+static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	unsigned int offset = paddr & ~PAGE_MASK;
+	return pfn_to_dma(dev, paddr >> PAGE_SHIFT) + offset;
+}
+
+static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
+{
+	unsigned int offset = dev_addr & ~PAGE_MASK;
+	return (dma_to_pfn(dev, dev_addr) << PAGE_SHIFT) + offset;
+}
+
+static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
+{
+	u64 limit, mask = *dev->dma_mask;
+
+	limit = (mask + 1) & ~mask;
+	if (limit && size > limit)
+		return 0;
+
+	if ((addr | (addr + size - 1)) & ~mask)
+		return 0;
+
+	return 1;
+}
+
+static inline void dma_mark_clean(void *addr, size_t size)
+{
+	dmac_flush_range(addr, addr + size);
+}
+
 /*
  * DMA errors are defined by all-bits-set in the DMA address.
  */
-- 
1.7.2.5
