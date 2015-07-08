From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 8 Jul 2015 14:35:12 +0300
Subject: [PATCH 5/5] drm/tegra: Add Tegra DRM allocation API
In-Reply-To: <1436354868-24309-1-git-send-email-mperttunen@nvidia.com>
References: <1436354868-24309-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1436355312-13765-1-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new IO virtual memory allocation API to allow clients to
allocate non-GEM memory in the Tegra DRM IOMMU domain. This is
required e.g. for loading client firmware when clients are attached
to the IOMMU domain.

The allocator allocates contiguous physical pages that are then
mapped contiguously to the IOMMU domain using a bitmap allocator
inside a 64 MiB reserved for non-GEM allocations. Contiguous
physical pages are used so that the same allocator works also
when IOMMU support is disabled and therefore devices access
physical memory directly.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/drm.c | 99 ++++++++++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/tegra/drm.h |  9 +++++
 2 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 427f50c..af4ff86 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1,12 +1,13 @@
 /*
  * Copyright (C) 2012 Avionic Design GmbH
- * Copyright (C) 2012-2013 NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (C) 2012-2015 NVIDIA CORPORATION.  All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
 
+#include <linux/bitops.h>
 #include <linux/host1x.h>
 #include <linux/iommu.h>
 
@@ -23,6 +24,8 @@
 #define DRIVER_MINOR 0
 #define DRIVER_PATCHLEVEL 0
 
+#define IOVA_AREA_SZ (1024 * 1024 * 64) /* 64 MiB */
+
 struct tegra_drm_file {
 	struct list_head contexts;
 };
@@ -125,7 +128,8 @@ static int tegra_drm_load(struct drm_device *drm, unsigned long flags)
 
 	if (iommu_present(&platform_bus_type)) {
 		struct iommu_domain_geometry *geometry;
-		u64 start, end;
+		u64 start, end, iova_start;
+		size_t bitmap_size;
 
 		tegra->domain = iommu_domain_alloc(&platform_bus_type);
 		if (!tegra->domain) {
@@ -136,10 +140,23 @@ static int tegra_drm_load(struct drm_device *drm, unsigned long flags)
 		geometry = &tegra->domain->geometry;
 		start = geometry->aperture_start;
 		end = geometry->aperture_end;
+		iova_start = end - IOVA_AREA_SZ + 1;
+
+		DRM_DEBUG("IOMMU context initialized (GEM aperture: %#llx-%#llx, IOVA aperture: %#llx-%#llx)\n",
+			  start, iova_start-1, iova_start, end);
+		bitmap_size = BITS_TO_LONGS(IOVA_AREA_SZ >> PAGE_SHIFT) *
+			sizeof(long);
+		tegra->iova_bitmap = devm_kzalloc(drm->dev, bitmap_size,
+						  GFP_KERNEL);
+		if (!tegra->iova_bitmap) {
+			err = -ENOMEM;
+			goto free;
+		}
+		tegra->iova_bitmap_bits = BITS_PER_BYTE * bitmap_size;
+		tegra->iova_start = iova_start;
+		mutex_init(&tegra->iova_lock);
 
-		DRM_DEBUG("IOMMU context initialized (aperture: %#llx-%#llx)\n",
-			  start, end);
-		drm_mm_init(&tegra->mm, start, end - start + 1);
+		drm_mm_init(&tegra->mm, start, iova_start - start);
 	}
 
 	mutex_init(&tegra->clients_lock);
@@ -979,6 +996,78 @@ int tegra_drm_unregister_client(struct tegra_drm *tegra,
 	return 0;
 }
 
+void *tegra_drm_alloc(struct tegra_drm *tegra, size_t size,
+			      dma_addr_t *iova)
+{
+	size_t aligned = PAGE_ALIGN(size);
+	int num_pages = aligned >> PAGE_SHIFT;
+	void *virt;
+	unsigned int start;
+	int err;
+
+	virt = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+					get_order(aligned));
+	if (!virt)
+		return NULL;
+
+	if (!tegra->domain) {
+		/*
+		 * If IOMMU is disabled, devices address physical memory
+		 * directly.
+		 */
+		*iova = virt_to_phys(virt);
+		return virt;
+	}
+
+	mutex_lock(&tegra->iova_lock);
+
+	start = bitmap_find_next_zero_area(tegra->iova_bitmap,
+					   tegra->iova_bitmap_bits, 0,
+					   num_pages, 0);
+	if (start > tegra->iova_bitmap_bits)
+		goto free_pages;
+
+	bitmap_set(tegra->iova_bitmap, start, num_pages);
+
+	*iova = tegra->iova_start + (start << PAGE_SHIFT);
+	err = iommu_map(tegra->domain, *iova, virt_to_phys(virt),
+			aligned, IOMMU_READ | IOMMU_WRITE);
+	if (err < 0)
+		goto free_iova;
+
+	mutex_unlock(&tegra->iova_lock);
+
+	return virt;
+
+free_iova:
+	bitmap_clear(tegra->iova_bitmap, start, num_pages);
+free_pages:
+	mutex_unlock(&tegra->iova_lock);
+
+	free_pages((unsigned long)virt, get_order(aligned));
+
+	return NULL;
+}
+
+void tegra_drm_free(struct tegra_drm *tegra, size_t size, void *virt,
+		    dma_addr_t iova)
+{
+	size_t aligned = PAGE_ALIGN(size);
+	int num_pages = aligned >> PAGE_SHIFT;
+
+	if (tegra->domain) {
+		unsigned int start = (iova - tegra->iova_start) >> PAGE_SHIFT;
+
+		iommu_unmap(tegra->domain, iova, aligned);
+
+		mutex_lock(&tegra->iova_lock);
+		bitmap_clear(tegra->iova_bitmap, start, num_pages);
+		mutex_unlock(&tegra->iova_lock);
+	}
+
+	free_pages((unsigned long)virt, get_order(aligned));
+}
+
 static int host1x_drm_probe(struct host1x_device *dev)
 {
 	struct drm_driver *driver = &tegra_drm_driver;
diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index 0e7756e..58c83b11 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -42,6 +42,11 @@ struct tegra_drm {
 	struct iommu_domain *domain;
 	struct drm_mm mm;
 
+	struct mutex iova_lock;
+	dma_addr_t iova_start;
+	unsigned long *iova_bitmap;
+	unsigned int iova_bitmap_bits;
+
 	struct mutex clients_lock;
 	struct list_head clients;
 
@@ -101,6 +106,10 @@ int tegra_drm_unregister_client(struct tegra_drm *tegra,
 int tegra_drm_init(struct tegra_drm *tegra, struct drm_device *drm);
 int tegra_drm_exit(struct tegra_drm *tegra);
 
+void *tegra_drm_alloc(struct tegra_drm *tegra, size_t size, dma_addr_t *iova);
+void tegra_drm_free(struct tegra_drm *tegra, size_t size, void *virt,
+		    dma_addr_t iova);
+
 struct tegra_dc_soc_info;
 struct tegra_output;
 
-- 
2.1.4
