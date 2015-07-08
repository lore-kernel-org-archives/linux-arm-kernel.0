From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 8 Jul 2015 14:27:47 +0300
Subject: [PATCH 4/5] drm/tegra: Support kernel mappings with IOMMU
In-Reply-To: <1436354868-24309-1-git-send-email-mperttunen@nvidia.com>
References: <1436354868-24309-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1436354868-24309-5-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arto Merilainen <amerilainen@nvidia.com>

Host1x command buffer patching requires that the buffer object can be
mapped into kernel address space, however, the recent addition of
IOMMU did not account to this requirement. Therefore Host1x engines
cannot be used if IOMMU is enabled.

This patch implements kmap, kunmap, mmap and munmap functions to
host1x bo objects.

Signed-off-by: Arto Merilainen <amerilainen@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/gem.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index 01e16e1..6aed866 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -2,7 +2,7 @@
  * NVIDIA Tegra DRM GEM helper functions
  *
  * Copyright (C) 2012 Sascha Hauer, Pengutronix
- * Copyright (C) 2013 NVIDIA CORPORATION, All rights reserved.
+ * Copyright (C) 2013-2015 NVIDIA CORPORATION, All rights reserved.
  *
  * Based on the GEM/CMA helpers
  *
@@ -50,23 +50,51 @@ static void *tegra_bo_mmap(struct host1x_bo *bo)
 {
 	struct tegra_bo *obj = host1x_to_tegra_bo(bo);
 
-	return obj->vaddr;
+	if (obj->vaddr)
+		return obj->vaddr;
+	else if (obj->gem.import_attach)
+		return dma_buf_vmap(obj->gem.import_attach->dmabuf);
+	else
+		return vmap(obj->pages, obj->num_pages, VM_MAP,
+			    pgprot_writecombine(PAGE_KERNEL));
 }
 
 static void tegra_bo_munmap(struct host1x_bo *bo, void *addr)
 {
+	struct tegra_bo *obj = host1x_to_tegra_bo(bo);
+
+	if (obj->vaddr)
+		return;
+	else if (obj->gem.import_attach)
+		dma_buf_vunmap(obj->gem.import_attach->dmabuf, addr);
+	else
+		vunmap(addr);
 }
 
 static void *tegra_bo_kmap(struct host1x_bo *bo, unsigned int page)
 {
 	struct tegra_bo *obj = host1x_to_tegra_bo(bo);
 
-	return obj->vaddr + page * PAGE_SIZE;
+	if (obj->vaddr)
+		return obj->vaddr + page * PAGE_SIZE;
+	else if (obj->gem.import_attach)
+		return dma_buf_kmap(obj->gem.import_attach->dmabuf, page);
+	else
+		return vmap(obj->pages + page, 1, VM_MAP,
+			    pgprot_writecombine(PAGE_KERNEL));
 }
 
 static void tegra_bo_kunmap(struct host1x_bo *bo, unsigned int page,
 			    void *addr)
 {
+	struct tegra_bo *obj = host1x_to_tegra_bo(bo);
+
+	if (obj->vaddr)
+		return;
+	else if (obj->gem.import_attach)
+		dma_buf_kunmap(obj->gem.import_attach->dmabuf, page, addr);
+	else
+		vunmap(addr);
 }
 
 static struct host1x_bo *tegra_bo_get(struct host1x_bo *bo)
-- 
2.1.4
