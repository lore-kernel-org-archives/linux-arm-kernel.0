From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Apr 2018 11:18:14 +0200
Subject: [PATCH 3/4] ARM: dma-mapping: Implement arch_iommu_detach_device()
In-Reply-To: <20180425091815.16264-1-thierry.reding@gmail.com>
References: <20180425091815.16264-1-thierry.reding@gmail.com>
Message-ID: <20180425091815.16264-3-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Implement this function to enable drivers from detaching from any IOMMU
domains that architecture code might have attached them to so that they
can take exclusive control of the IOMMU via the IOMMU API.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/include/asm/dma-mapping.h |  3 +++
 arch/arm/mm/dma-mapping-nommu.c    |  4 ++++
 arch/arm/mm/dma-mapping.c          | 19 +++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 8436f6ade57d..d6d5bd44f962 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -103,6 +103,9 @@ extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 #define arch_teardown_dma_ops arch_teardown_dma_ops
 extern void arch_teardown_dma_ops(struct device *dev);
 
+#define arch_iommu_detach_device arch_iommu_detach_device
+extern void arch_iommu_detach_device(struct device *dev);
+
 /* do not use this function in a driver */
 static inline bool is_device_dma_coherent(struct device *dev)
 {
diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index 619f24a42d09..60fef97d8452 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -242,6 +242,10 @@ void arch_teardown_dma_ops(struct device *dev)
 {
 }
 
+void arch_iommu_detach_device(struct device *dev)
+{
+}
+
 #define PREALLOC_DMA_DEBUG_ENTRIES	4096
 
 static int __init dma_debug_do_init(void)
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8c398fedbbb6..1957938d8c9c 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2366,6 +2366,21 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
 	arm_iommu_release_mapping(mapping);
 }
 
+void arch_iommu_detach_device(struct device *dev)
+{
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	const struct dma_map_ops *dma_ops;
+
+	if (!mapping)
+		return;
+
+	arm_iommu_release_mapping(mapping);
+	arm_iommu_detach_device(dev);
+
+	dma_ops = arm_get_dma_map_ops(dev->archdata.dma_coherent);
+	set_dma_ops(dev, dma_ops);
+}
+
 #else
 
 static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
@@ -2378,6 +2393,10 @@ static void arm_teardown_iommu_dma_ops(struct device *dev) { }
 
 #define arm_get_iommu_dma_map_ops arm_get_dma_map_ops
 
+void arch_iommu_detach_device(struct device *dev)
+{
+}
+
 #endif	/* CONFIG_ARM_DMA_USE_IOMMU */
 
 static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
-- 
2.17.0
