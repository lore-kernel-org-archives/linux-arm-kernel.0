From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 24 Jan 2013 15:16:57 +0200
Subject: [PATCH 2/2] ARM: dma-mapping: Add arm_iommu_detach_device()
In-Reply-To: <1359033425-6674-1-git-send-email-hdoyu@nvidia.com>
References: <1359033425-6674-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1359033425-6674-2-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A counter part of arm_iommu_attach_device().

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/include/asm/dma-iommu.h |    1 +
 arch/arm/mm/dma-mapping.c        |   25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index 799b094..af1ac4ed 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -29,6 +29,7 @@ void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
 
 int arm_iommu_attach_device(struct device *dev,
 					struct dma_iommu_mapping *mapping);
+void arm_iommu_detach_device(struct device *dev);
 
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6b2fb87..b075a1f 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1842,4 +1842,29 @@ int arm_iommu_attach_device(struct device *dev,
 	return 0;
 }
 
+/**
+ * arm_iommu_detach_device
+ * @dev: valid struct device pointer
+ *
+ * Detaches the provided device from a previously attached map.
+ * This voids the dma operations (dma_map_ops pointer)
+ */
+void arm_iommu_detach_device(struct device *dev)
+{
+	struct dma_iommu_mapping *mapping;
+
+	mapping = to_dma_iommu_mapping(dev);
+	if (!mapping) {
+		dev_warn(dev, "Not attached\n");
+		return;
+	}
+
+	iommu_detach_device(mapping->domain, dev);
+	kref_put(&mapping->kref, release_iommu_mapping);
+	mapping = NULL;
+	set_dma_ops(dev, NULL);
+
+	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
+}
+
 #endif
-- 
1.7.9.5
