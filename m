From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 05 Aug 2014 12:47:37 +0200
Subject: [PATCH 09/29] ARM: dma-mapping: provide stubs if no ARM_DMA_USE_IOMMU
 has been selected
In-Reply-To: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1407235677-26324-10-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides stubs returing errors for all iommu related arm
dma-mapping functions, which are used when CONFIG_ARM_DMA_USE_IOMMU is
not set. This let drivers to use common code for iommu and non-iommu
cases without additional ifdefs.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/include/asm/dma-iommu.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index ae3dac0..1e57569 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -9,6 +9,8 @@
 #include <linux/kmemcheck.h>
 #include <linux/kref.h>
 
+#ifdef CONFIG_ARM_DMA_USE_IOMMU
+
 struct dma_iommu_mapping {
 	/* iommu specific data */
 	struct iommu_domain	*domain;
@@ -38,5 +40,34 @@ int arm_iommu_create_default_mapping(struct device *dev, dma_addr_t base,
 
 void arm_iommu_release_default_mapping(struct device *dev);
 
+#else
+
+static inline struct dma_iommu_mapping *
+arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline void
+arm_iommu_release_mapping(struct dma_iommu_mapping *mapping) { }
+
+static inline int arm_iommu_attach_device(struct device *dev,
+					struct dma_iommu_mapping *mapping)
+{
+	return -ENOSYS;
+}
+
+static inline void arm_iommu_detach_device(struct device *dev) { }
+
+static inline int arm_iommu_create_default_mapping(struct device *dev,
+						dma_addr_t base, size_t size)
+{
+	return -ENOSYS;
+}
+
+static inline void arm_iommu_release_default_mapping(struct device *dev) { }
+
+#endif
+
 #endif /* __KERNEL__ */
 #endif
-- 
1.9.2
