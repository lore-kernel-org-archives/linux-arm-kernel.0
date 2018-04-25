From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Apr 2018 12:10:49 +0200
Subject: [PATCH v2 3/5] ARM: dma-mapping: Implement arch_iommu_detach_device()
In-Reply-To: <20180425101051.15349-1-thierry.reding@gmail.com>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
Message-ID: <20180425101051.15349-3-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Implement this function to enable drivers from detaching from any IOMMU
domains that architecture code might have attached them to so that they
can take exclusive control of the IOMMU via the IOMMU API.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- fix compilation

 arch/arm/include/asm/dma-mapping.h |  3 +++
 arch/arm/mm/dma-mapping-nommu.c    |  4 ++++
 arch/arm/mm/dma-mapping.c          | 17 +++++++++++++++++
 3 files changed, 24 insertions(+)

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
index 8c398fedbbb6..cc63a25bd088 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2423,3 +2423,20 @@ void arch_teardown_dma_ops(struct device *dev)
 
 	arm_teardown_iommu_dma_ops(dev);
 }
+
+void arch_iommu_detach_device(struct device *dev)
+{
+#ifdef CONFIG_ARM_DMA_USE_IOMMU
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
+#endif
+}
-- 
2.17.0
