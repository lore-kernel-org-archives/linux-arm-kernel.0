From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 05 Aug 2014 12:47:36 +0200
Subject: [PATCH 08/29] ARM: dma-mapping: add helpers for managing default
 per-device dma mappings
In-Reply-To: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1407235677-26324-9-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds 2 helpers: arm_iommu_create_default_mapping and
arm_iommu_release_default_mapping for managing default iommu-based
dma-mapping address space, created for exlusive use only by the given
device. Those helpers are convenient for setting up iommu-based
dma-mapping for most typical devices in the system.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/include/asm/dma-iommu.h |  5 +++++
 arch/arm/mm/dma-mapping.c        | 31 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index 8e3fcb9..ae3dac0 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -33,5 +33,10 @@ int arm_iommu_attach_device(struct device *dev,
 					struct dma_iommu_mapping *mapping);
 void arm_iommu_detach_device(struct device *dev);
 
+int arm_iommu_create_default_mapping(struct device *dev, dma_addr_t base,
+				     size_t size);
+
+void arm_iommu_release_default_mapping(struct device *dev);
+
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8161102..233a8cf 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2106,4 +2106,35 @@ void arm_iommu_detach_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
 
+int arm_iommu_create_default_mapping(struct device *dev, dma_addr_t base,
+				     size_t size)
+{
+	struct dma_iommu_mapping *mapping;
+	int ret;
+
+	mapping = arm_iommu_create_mapping(dev->bus, base, size);
+	if (IS_ERR(mapping))
+		return PTR_ERR(mapping);
+
+	ret = arm_iommu_attach_device(dev, mapping);
+	if (ret) {
+		arm_iommu_release_mapping(mapping);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arm_iommu_create_default_mapping);
+
+void arm_iommu_release_default_mapping(struct device *dev)
+{
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	if (!mapping)
+		return;
+
+	arm_iommu_detach_device(dev);
+	arm_iommu_release_mapping(mapping);
+}
+EXPORT_SYMBOL_GPL(arm_iommu_release_default_mapping);
+
 #endif
-- 
1.9.2
