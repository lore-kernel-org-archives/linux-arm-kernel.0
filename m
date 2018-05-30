From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 30 May 2018 16:06:24 +0200
Subject: [PATCH v4 1/2] ARM: dma-mapping: Set proper DMA ops in
 arm_iommu_detach_device()
In-Reply-To: <20180530140625.21247-1-thierry.reding@gmail.com>
References: <20180530140625.21247-1-thierry.reding@gmail.com>
Message-ID: <20180530140625.21247-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Instead of setting the DMA ops pointer to NULL, set the correct,
non-IOMMU ops depending on the device's coherency setting.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v4:
- new patch to fix existing arm_iommu_detach_device() to do what we need

 arch/arm/mm/dma-mapping.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index af27f1c22d93..87a0037574e4 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1151,6 +1151,11 @@ int arm_dma_supported(struct device *dev, u64 mask)
 	return __dma_supported(dev, mask, false);
 }
 
+static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
+{
+	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
+}
+
 #ifdef CONFIG_ARM_DMA_USE_IOMMU
 
 static int __dma_info_to_prot(enum dma_data_direction dir, unsigned long attrs)
@@ -2296,7 +2301,7 @@ void arm_iommu_detach_device(struct device *dev)
 	iommu_detach_device(mapping->domain, dev);
 	kref_put(&mapping->kref, release_iommu_mapping);
 	to_dma_iommu_mapping(dev) = NULL;
-	set_dma_ops(dev, NULL);
+	set_dma_ops(dev, arm_get_dma_map_ops(dev->archdata.dma_coherent));
 
 	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
 }
@@ -2357,11 +2362,6 @@ static void arm_teardown_iommu_dma_ops(struct device *dev) { }
 
 #endif	/* CONFIG_ARM_DMA_USE_IOMMU */
 
-static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
-{
-	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
-}
-
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
-- 
2.17.0
