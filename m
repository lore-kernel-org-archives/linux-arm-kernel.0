From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Apr 2018 11:18:13 +0200
Subject: [PATCH 2/4] dma-mapping: Introduce dma_iommu_detach_device() API
In-Reply-To: <20180425091815.16264-1-thierry.reding@gmail.com>
References: <20180425091815.16264-1-thierry.reding@gmail.com>
Message-ID: <20180425091815.16264-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The dma_iommu_detach_device() API can be used by drivers to forcibly
detach a device from an IOMMU that architecture code might have attached
to. This is useful for drivers that need explicit control over the IOMMU
using the IOMMU API directly.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/base/dma-mapping.c  | 8 ++++++++
 include/linux/dma-mapping.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index d82566d6e237..18ddf32b10c9 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -366,3 +366,11 @@ void dma_deconfigure(struct device *dev)
 	of_dma_deconfigure(dev);
 	acpi_dma_deconfigure(dev);
 }
+
+void dma_iommu_detach_device(struct device *dev)
+{
+#ifdef arch_iommu_detach_device
+	arch_iommu_detach_device(dev);
+#endif
+}
+EXPORT_SYMBOL(dma_iommu_detach_device);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f8ab1c0f589e..732191a2c64e 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -671,6 +671,8 @@ static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
 static inline void arch_teardown_dma_ops(struct device *dev) { }
 #endif
 
+extern void dma_iommu_detach_device(struct device *dev);
+
 static inline unsigned int dma_get_max_seg_size(struct device *dev)
 {
 	if (dev->dma_parms && dev->dma_parms->max_segment_size)
-- 
2.17.0
