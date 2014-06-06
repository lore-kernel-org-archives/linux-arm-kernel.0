From: ritesh.harjani@gmail.com (ritesh.harjani at gmail.com)
Date: Fri, 6 Jun 2014 14:12:39 +0530
Subject: [PATCHv3 1/3] device.h: arm dma-iommu: Move out dma_iommu_mapping
 struct
In-Reply-To: <1402044161-32980-1-git-send-email-ritesh.harjani@gmail.com>
References: <1402044161-32980-1-git-send-email-ritesh.harjani@gmail.com>
Message-ID: <1402044161-32980-2-git-send-email-ritesh.harjani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ritesh Harjani <ritesh.harjani@gmail.com>

This patch moves out *mapping pointer of dma_iommu_mapping
from arch/arm/include/asm/device.h to include/liunux/device.h

Also, it moves out complete structre definition of dma_iommu_mapping
to include/linux/iommu-helper.h

This is done since arm iommu's dma-mapping arch independent code,
needs to be moved out to lib/iommu-helper.c, this means
dma_iommu_mapping will be arch independent and later other archs
can make use of it.

Signed-off-by: Ritesh Harjani <ritesh.harjani@gmail.com>
---
 arch/arm/Kconfig                          |  4 ++++
 arch/arm/include/asm/device.h             |  9 ---------
 arch/arm/include/asm/dma-iommu.h          | 16 +---------------
 arch/arm/mm/dma-mapping.c                 | 20 ++++++++++----------
 drivers/gpu/drm/exynos/exynos_drm_iommu.c | 10 +++++-----
 include/linux/device.h                    |  5 +++++
 include/linux/iommu-helper.h              | 19 +++++++++++++++++++
 7 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index db3c541..e65042f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -92,6 +92,7 @@ config ARM_DMA_USE_IOMMU
 	bool
 	select ARM_HAS_SG_CHAIN
 	select NEED_SG_DMA_LENGTH
+	select DMA_USE_IOMMU_HELPER_MAPPING
 
 if ARM_DMA_USE_IOMMU
 
@@ -1911,6 +1912,9 @@ config SWIOTLB
 config IOMMU_HELPER
 	def_bool SWIOTLB
 
+config DMA_USE_IOMMU_HELPER_MAPPING
+	def_bool n
+
 config XEN_DOM0
 	def_bool y
 	depends on XEN
diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index dc662fc..6e2cb0e 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -14,9 +14,6 @@ struct dev_archdata {
 #ifdef CONFIG_IOMMU_API
 	void *iommu; /* private IOMMU data */
 #endif
-#ifdef CONFIG_ARM_DMA_USE_IOMMU
-	struct dma_iommu_mapping	*mapping;
-#endif
 };
 
 struct omap_device;
@@ -27,10 +24,4 @@ struct pdev_archdata {
 #endif
 };
 
-#ifdef CONFIG_ARM_DMA_USE_IOMMU
-#define to_dma_iommu_mapping(dev) ((dev)->archdata.mapping)
-#else
-#define to_dma_iommu_mapping(dev) NULL
-#endif
-
 #endif
diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index 8e3fcb9..50c010b 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -8,21 +8,7 @@
 #include <linux/dma-debug.h>
 #include <linux/kmemcheck.h>
 #include <linux/kref.h>
-
-struct dma_iommu_mapping {
-	/* iommu specific data */
-	struct iommu_domain	*domain;
-
-	unsigned long		**bitmaps;	/* array of bitmaps */
-	unsigned int		nr_bitmaps;	/* nr of elements in array */
-	unsigned int		extensions;
-	size_t			bitmap_size;	/* size of a single bitmap */
-	size_t			bits;		/* per bitmap */
-	dma_addr_t		base;
-
-	spinlock_t		lock;
-	struct kref		kref;
-};
+#include <linux/iommu-helper.h>
 
 struct dma_iommu_mapping *
 arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size);
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 3d43c41..b82561e 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1292,7 +1292,7 @@ err:
 static dma_addr_t
 __iommu_create_mapping(struct device *dev, struct page **pages, size_t size)
 {
-	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	struct dma_iommu_mapping *mapping = dev->mapping;
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	dma_addr_t dma_addr, iova;
 	int i, ret = DMA_ERROR_CODE;
@@ -1328,7 +1328,7 @@ fail:
 
 static int __iommu_remove_mapping(struct device *dev, dma_addr_t iova, size_t size)
 {
-	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	struct dma_iommu_mapping *mapping = dev->mapping;
 
 	/*
 	 * add optional in-page offset from iova to size and align
@@ -1541,7 +1541,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 			  enum dma_data_direction dir, struct dma_attrs *attrs,
 			  bool is_coherent)
 {
-	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	struct dma_iommu_mapping *mapping = dev->mapping;
 	dma_addr_t iova, iova_base;
 	int ret = 0;
 	unsigned int count;
@@ -1762,7 +1762,7 @@ static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *p
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
 	     struct dma_attrs *attrs)
 {
-	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	struct dma_iommu_mapping *mapping = dev->mapping;
 	dma_addr_t dma_addr;
 	int ret, prot, len = PAGE_ALIGN(size + offset);
 
@@ -1815,7 +1815,7 @@ static void arm_coherent_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
 		struct dma_attrs *attrs)
 {
-	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	struct dma_iommu_mapping *mapping = dev->mapping;
 	dma_addr_t iova = handle & PAGE_MASK;
 	int offset = handle & ~PAGE_MASK;
 	int len = PAGE_ALIGN(size + offset);
@@ -1840,7 +1840,7 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
 		struct dma_attrs *attrs)
 {
-	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	struct dma_iommu_mapping *mapping = dev->mapping;
 	dma_addr_t iova = handle & PAGE_MASK;
 	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
 	int offset = handle & ~PAGE_MASK;
@@ -1859,7 +1859,7 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 static void arm_iommu_sync_single_for_cpu(struct device *dev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
-	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	struct dma_iommu_mapping *mapping = dev->mapping;
 	dma_addr_t iova = handle & PAGE_MASK;
 	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
 	unsigned int offset = handle & ~PAGE_MASK;
@@ -1873,7 +1873,7 @@ static void arm_iommu_sync_single_for_cpu(struct device *dev,
 static void arm_iommu_sync_single_for_device(struct device *dev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
-	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	struct dma_iommu_mapping *mapping = dev->mapping;
 	dma_addr_t iova = handle & PAGE_MASK;
 	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
 	unsigned int offset = handle & ~PAGE_MASK;
@@ -2045,7 +2045,7 @@ int arm_iommu_attach_device(struct device *dev,
 		return err;
 
 	kref_get(&mapping->kref);
-	dev->archdata.mapping = mapping;
+	dev->mapping = mapping;
 	set_dma_ops(dev, &iommu_ops);
 
 	pr_debug("Attached IOMMU controller to %s device.\n", dev_name(dev));
@@ -2072,7 +2072,7 @@ void arm_iommu_detach_device(struct device *dev)
 
 	iommu_detach_device(mapping->domain, dev);
 	kref_put(&mapping->kref, release_iommu_mapping);
-	dev->archdata.mapping = NULL;
+	dev->mapping = NULL;
 	set_dma_ops(dev, NULL);
 
 	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
diff --git a/drivers/gpu/drm/exynos/exynos_drm_iommu.c b/drivers/gpu/drm/exynos/exynos_drm_iommu.c
index b32b291..9dbf369 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_iommu.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_iommu.c
@@ -49,7 +49,7 @@ int drm_create_iommu_mapping(struct drm_device *drm_dev)
 		goto error;
 
 	dma_set_max_seg_size(dev, 0xffffffffu);
-	dev->archdata.mapping = mapping;
+	dev->mapping = mapping;
 
 	return 0;
 error:
@@ -69,7 +69,7 @@ void drm_release_iommu_mapping(struct drm_device *drm_dev)
 {
 	struct device *dev = drm_dev->dev;
 
-	arm_iommu_release_mapping(dev->archdata.mapping);
+	arm_iommu_release_mapping(dev->mapping);
 }
 
 /*
@@ -87,7 +87,7 @@ int drm_iommu_attach_device(struct drm_device *drm_dev,
 	struct device *dev = drm_dev->dev;
 	int ret;
 
-	if (!dev->archdata.mapping) {
+	if (!dev->mapping) {
 		DRM_ERROR("iommu_mapping is null.\n");
 		return -EFAULT;
 	}
@@ -100,7 +100,7 @@ int drm_iommu_attach_device(struct drm_device *drm_dev,
 
 	dma_set_max_seg_size(subdrv_dev, 0xffffffffu);
 
-	ret = arm_iommu_attach_device(subdrv_dev, dev->archdata.mapping);
+	ret = arm_iommu_attach_device(subdrv_dev, dev->mapping);
 	if (ret < 0) {
 		DRM_DEBUG_KMS("failed iommu attach.\n");
 		return ret;
@@ -133,7 +133,7 @@ void drm_iommu_detach_device(struct drm_device *drm_dev,
 				struct device *subdrv_dev)
 {
 	struct device *dev = drm_dev->dev;
-	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	struct dma_iommu_mapping *mapping = dev->mapping;
 
 	if (!mapping || !mapping->domain)
 		return;
diff --git a/include/linux/device.h b/include/linux/device.h
index d1d1c05..2bb58c9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -761,6 +761,11 @@ struct device {
 	struct cma *cma_area;		/* contiguous memory area for dma
 					   allocations */
 #endif
+
+#ifdef CONFIG_DMA_USE_IOMMU_HELPER_MAPPING
+	struct dma_iommu_mapping	*mapping;
+#endif
+
 	/* arch specific additions */
 	struct dev_archdata	archdata;
 
diff --git a/include/linux/iommu-helper.h b/include/linux/iommu-helper.h
index 86bdeff..961d8ef 100644
--- a/include/linux/iommu-helper.h
+++ b/include/linux/iommu-helper.h
@@ -3,6 +3,25 @@
 
 #include <linux/kernel.h>
 
+#ifdef CONFIG_DMA_USE_IOMMU_HELPER_MAPPING
+struct dma_iommu_mapping {
+	/* iommu specific data */
+	struct iommu_domain	*domain;
+
+	unsigned long		**bitmaps;	/* array of bitmaps */
+	unsigned int		nr_bitmaps;	/* nr of elements in array */
+	unsigned int		extensions;
+	size_t			bitmap_size;	/* size of a single bitmap */
+	size_t			bits;		/* per bitmap */
+	dma_addr_t		base;
+
+	spinlock_t		lock;
+	struct kref		kref;
+};
+
+#define to_dma_iommu_mapping(dev) ((dev)->mapping)
+#endif
+
 static inline unsigned long iommu_device_max_index(unsigned long size,
 						   unsigned long offset,
 						   u64 dma_mask)
-- 
1.8.1.3
