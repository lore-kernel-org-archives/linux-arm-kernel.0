From: sricharan@codeaurora.org (Sricharan R)
Date: Sat, 27 May 2017 19:17:45 +0530
Subject: [PATCH v6 6/6] arm: dma-mapping: Reset the device's dma_ops
In-Reply-To: <1495892865-9506-1-git-send-email-sricharan@codeaurora.org>
References: <1495892865-9506-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1495892865-9506-6-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch_teardown_dma_ops() being the inverse of arch_setup_dma_ops()
,dma_ops should be cleared in the teardown path. Currently, only the
device's iommu mapping structures are cleared in arch_teardown_dma_ops,
but not the dma_ops. So on the next reprobe, dma_ops left in place is
stale from the first IOMMU setup, but iommu mappings has been disposed
of. This is a problem when the probe of the device is deferred and
recalled with the IOMMU probe deferral.

So for fixing this, slightly refactor by moving the code from
__arm_iommu_detach_device to arm_iommu_detach_device and cleanup
the former. This takes care of resetting the dma_ops in the teardown
path.

Fixes: 09515ef5ddad ("of/acpi: Configure dma operations at probe time for platform/amba/pci bus devices")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/mm/dma-mapping.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index b48998f..bd83c53 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2311,7 +2311,14 @@ int arm_iommu_attach_device(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
 
-static void __arm_iommu_detach_device(struct device *dev)
+/**
+ * arm_iommu_detach_device
+ * @dev: valid struct device pointer
+ *
+ * Detaches the provided device from a previously attached map.
+ * This voids the dma operations (dma_map_ops pointer)
+ */
+void arm_iommu_detach_device(struct device *dev)
 {
 	struct dma_iommu_mapping *mapping;
 
@@ -2324,22 +2331,10 @@ static void __arm_iommu_detach_device(struct device *dev)
 	iommu_detach_device(mapping->domain, dev);
 	kref_put(&mapping->kref, release_iommu_mapping);
 	to_dma_iommu_mapping(dev) = NULL;
+	set_dma_ops(dev, NULL);
 
 	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
 }
-
-/**
- * arm_iommu_detach_device
- * @dev: valid struct device pointer
- *
- * Detaches the provided device from a previously attached map.
- * This voids the dma operations (dma_map_ops pointer)
- */
-void arm_iommu_detach_device(struct device *dev)
-{
-	__arm_iommu_detach_device(dev);
-	set_dma_ops(dev, NULL);
-}
 EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
 
 static const struct dma_map_ops *arm_get_iommu_dma_map_ops(bool coherent)
@@ -2379,7 +2374,7 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
 	if (!mapping)
 		return;
 
-	__arm_iommu_detach_device(dev);
+	arm_iommu_detach_device(dev);
 	arm_iommu_release_mapping(mapping);
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
