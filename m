From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 23 Jan 2015 16:21:49 +0200
Subject: [PATCH URGENT] arm: dma-mapping: Set DMA IOMMU ops in
 arm_iommu_attach_device()
Message-ID: <1422022909-31044-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 4bb25789ed28228a ("arm: dma-mapping: plumb our iommu mapping ops
into arch_setup_dma_ops") moved the setting of the DMA operations from
arm_iommu_attach_device() to arch_setup_dma_ops() where the DMA
operations to be used are selected based on whether the device is
connected to an IOMMU. However, the IOMMU detection scheme requires the
IOMMU driver to be ported to the new IOMMU of_xlate API. As no driver
has been ported yet, this effectively breaks all IOMMU ARM users that
depend on the IOMMU being handled transparently by the DMA mapping API.

Fix this by restoring the setting of DMA IOMMU ops in
arm_iommu_attach_device() and splitting the rest of the function into a
new internal __arm_iommu_attach_device() function, called by
arch_setup_dma_ops().

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mm/dma-mapping.c | 53 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 15 deletions(-)

This fixes a v3.19 regression that breaks IOMMU on the Exynos, OMAP3, Renesas
and Rockchip platforms.

The patch has been tested on a Renesas M2 platform with the ipmmu-vmsa driver.

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7864797609b3..a673c7f7e208 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1940,13 +1940,32 @@ void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping)
 }
 EXPORT_SYMBOL_GPL(arm_iommu_release_mapping);
 
+static int __arm_iommu_attach_device(struct device *dev,
+				     struct dma_iommu_mapping *mapping)
+{
+	int err;
+
+	err = iommu_attach_device(mapping->domain, dev);
+	if (err)
+		return err;
+
+	kref_get(&mapping->kref);
+	dev->archdata.mapping = mapping;
+
+	pr_debug("Attached IOMMU controller to %s device.\n", dev_name(dev));
+	return 0;
+}
+
 /**
  * arm_iommu_attach_device
  * @dev: valid struct device pointer
  * @mapping: io address space mapping structure (returned from
  *	arm_iommu_create_mapping)
  *
- * Attaches specified io address space mapping to the provided device,
+ * Attaches specified io address space mapping to the provided device.
+ * This replaces the dma operations (dma_map_ops pointer) with the
+ * IOMMU aware version.
+ *
  * More than one client might be attached to the same io address space
  * mapping.
  */
@@ -1955,25 +1974,16 @@ int arm_iommu_attach_device(struct device *dev,
 {
 	int err;
 
-	err = iommu_attach_device(mapping->domain, dev);
+	err = __arm_iommu_attach_device(dev, mapping);
 	if (err)
 		return err;
 
-	kref_get(&mapping->kref);
-	dev->archdata.mapping = mapping;
-
-	pr_debug("Attached IOMMU controller to %s device.\n", dev_name(dev));
+	set_dma_ops(dev, &iommu_ops);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
 
-/**
- * arm_iommu_detach_device
- * @dev: valid struct device pointer
- *
- * Detaches the provided device from a previously attached map.
- */
-void arm_iommu_detach_device(struct device *dev)
+static void __arm_iommu_detach_device(struct device *dev)
 {
 	struct dma_iommu_mapping *mapping;
 
@@ -1989,6 +1999,19 @@ void arm_iommu_detach_device(struct device *dev)
 
 	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
 }
+
+/**
+ * arm_iommu_detach_device
+ * @dev: valid struct device pointer
+ *
+ * Detaches the provided device from a previously attached map.
+ * This voids the dma operations (dma_map_ops pointer)
+ */
+void arm_iommu_detach_device(struct device *dev)
+{
+	__arm_iommu_detach_device(dev);
+	set_dma_ops(dev, NULL);
+}
 EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
 
 static struct dma_map_ops *arm_get_iommu_dma_map_ops(bool coherent)
@@ -2011,7 +2034,7 @@ static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		return false;
 	}
 
-	if (arm_iommu_attach_device(dev, mapping)) {
+	if (__arm_iommu_attach_device(dev, mapping)) {
 		pr_warn("Failed to attached device %s to IOMMU_mapping\n",
 				dev_name(dev));
 		arm_iommu_release_mapping(mapping);
@@ -2025,7 +2048,7 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
 {
 	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
 
-	arm_iommu_detach_device(dev);
+	__arm_iommu_detach_device(dev);
 	arm_iommu_release_mapping(mapping);
 }
 
-- 
Regards,

Laurent Pinchart
