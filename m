From: seanpaul@chromium.org (Sean Paul)
Date: Thu,  9 Mar 2017 23:32:18 -0500
Subject: [PATCH 03/41] drm/rockchip: support prime import sg table
In-Reply-To: <20170310043305.17216-1-seanpaul@chromium.org>
References: <20170310043305.17216-1-seanpaul@chromium.org>
Message-ID: <20170310043305.17216-4-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haixia Shi <hshi@chromium.org>

The prime fd to handle ioctl was not used with rockchip before. Support
was added in order to pass graphics_Gbm and to support potential uses
within Chrome OS (e.g. zero-copy video decode, camera).

Signed-off-by: Haixia Shi <hshi@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 118 ++++++++++++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_gem.h |   5 +-
 3 files changed, 115 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index ccf456938792..1e371b7a1506 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -238,6 +238,7 @@ static struct drm_driver rockchip_drm_driver = {
 	.gem_prime_import	= drm_gem_prime_import,
 	.gem_prime_export	= drm_gem_prime_export,
 	.gem_prime_get_sg_table	= rockchip_gem_prime_get_sg_table,
+	.gem_prime_import_sg_table	= rockchip_gem_prime_import_sg_table,
 	.gem_prime_vmap		= rockchip_gem_prime_vmap,
 	.gem_prime_vunmap	= rockchip_gem_prime_vunmap,
 	.gem_prime_mmap		= rockchip_gem_mmap_buf,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index df9e57064f19..5dffe276d2a7 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -16,6 +16,8 @@
 #include <drm/drmP.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_vma_manager.h>
+
+#include <linux/dma-buf.h>
 #include <linux/iommu.h>
 
 #include "rockchip_drm_drv.h"
@@ -308,12 +310,10 @@ static void rockchip_gem_release_object(struct rockchip_gem_object *rk_obj)
 }
 
 struct rockchip_gem_object *
-	rockchip_gem_create_object(struct drm_device *drm, unsigned int size,
-				   bool alloc_kmap)
+	rockchip_gem_alloc_object(struct drm_device *drm, unsigned int size)
 {
 	struct rockchip_gem_object *rk_obj;
 	struct drm_gem_object *obj;
-	int ret;
 
 	size = round_up(size, PAGE_SIZE);
 
@@ -325,6 +325,20 @@ struct rockchip_gem_object *
 
 	drm_gem_object_init(drm, obj, size);
 
+	return rk_obj;
+}
+
+struct rockchip_gem_object *
+rockchip_gem_create_object(struct drm_device *drm, unsigned int size,
+			   bool alloc_kmap)
+{
+	struct rockchip_gem_object *rk_obj;
+	int ret;
+
+	rk_obj = rockchip_gem_alloc_object(drm, size);
+	if (IS_ERR(rk_obj))
+		return rk_obj;
+
 	ret = rockchip_gem_alloc_buf(rk_obj, alloc_kmap);
 	if (ret)
 		goto err_free_rk_obj;
@@ -342,11 +356,21 @@ struct rockchip_gem_object *
  */
 void rockchip_gem_free_object(struct drm_gem_object *obj)
 {
-	struct rockchip_gem_object *rk_obj;
-
-	rk_obj = to_rockchip_obj(obj);
+	struct drm_device *drm = obj->dev;
+	struct rockchip_drm_private *private = drm->dev_private;
+	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
 
-	rockchip_gem_free_buf(rk_obj);
+	if (obj->import_attach) {
+		if (private->domain) {
+			rockchip_gem_iommu_unmap(rk_obj);
+		} else {
+			dma_unmap_sg(drm->dev, rk_obj->sgt->sgl,
+				     rk_obj->sgt->nents, DMA_BIDIRECTIONAL);
+		}
+		drm_prime_gem_destroy(obj, rk_obj->sgt);
+	} else {
+		rockchip_gem_free_buf(rk_obj);
+	}
 
 	rockchip_gem_release_object(rk_obj);
 }
@@ -476,6 +500,86 @@ struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object *obj)
 	return sgt;
 }
 
+static unsigned long rockchip_sg_get_contiguous_size(struct sg_table *sgt,
+						     int count)
+{
+	struct scatterlist *s;
+	dma_addr_t expected = sg_dma_address(sgt->sgl);
+	unsigned int i;
+	unsigned long size = 0;
+
+	for_each_sg(sgt->sgl, s, count, i) {
+		if (sg_dma_address(s) != expected)
+			break;
+		expected = sg_dma_address(s) + sg_dma_len(s);
+		size += sg_dma_len(s);
+	}
+	return size;
+}
+
+static int
+rockchip_gem_iommu_map_sg(struct drm_device *drm,
+			  struct dma_buf_attachment *attach,
+			  struct sg_table *sg,
+			  struct rockchip_gem_object *rk_obj)
+{
+	rk_obj->sgt = sg;
+	return rockchip_gem_iommu_map(rk_obj);
+}
+
+static int
+rockchip_gem_dma_map_sg(struct drm_device *drm,
+			struct dma_buf_attachment *attach,
+			struct sg_table *sg,
+			struct rockchip_gem_object *rk_obj)
+{
+	int count = dma_map_sg(drm->dev, sg->sgl, sg->nents,
+			       DMA_BIDIRECTIONAL);
+	if (!count)
+		return -EINVAL;
+
+	if (rockchip_sg_get_contiguous_size(sg, count) < attach->dmabuf->size) {
+		DRM_ERROR("failed to map sg_table to contiguous linear address.\n");
+		dma_unmap_sg(drm->dev, sg->sgl, sg->nents,
+			     DMA_BIDIRECTIONAL);
+		return -EINVAL;
+	}
+
+	rk_obj->dma_addr = sg_dma_address(sg->sgl);
+	rk_obj->sgt = sg;
+	return 0;
+}
+
+struct drm_gem_object *
+rockchip_gem_prime_import_sg_table(struct drm_device *drm,
+				   struct dma_buf_attachment *attach,
+				   struct sg_table *sg)
+{
+	struct rockchip_drm_private *private = drm->dev_private;
+	struct rockchip_gem_object *rk_obj;
+	int ret;
+
+	rk_obj = rockchip_gem_alloc_object(drm, attach->dmabuf->size);
+	if (IS_ERR(rk_obj))
+		return ERR_CAST(rk_obj);
+
+	if (private->domain)
+		ret = rockchip_gem_iommu_map_sg(drm, attach, sg, rk_obj);
+	else
+		ret = rockchip_gem_dma_map_sg(drm, attach, sg, rk_obj);
+
+	if (ret < 0) {
+		DRM_ERROR("failed to import sg table: %d\n", ret);
+		goto err_free_rk_obj;
+	}
+
+	return &rk_obj->base;
+
+err_free_rk_obj:
+	rockchip_gem_release_object(rk_obj);
+	return ERR_PTR(ret);
+}
+
 void *rockchip_gem_prime_vmap(struct drm_gem_object *obj)
 {
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
index 3f6ea4d18a5c..89209a5f5e2c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
@@ -36,8 +36,9 @@ struct rockchip_gem_object {
 
 struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object *obj);
 struct drm_gem_object *
-rockchip_gem_prime_import_sg_table(struct drm_device *dev, size_t size,
-				   struct sg_table *sgt);
+rockchip_gem_prime_import_sg_table(struct drm_device *dev,
+				   struct dma_buf_attachment *attach,
+				   struct sg_table *sg);
 void *rockchip_gem_prime_vmap(struct drm_gem_object *obj);
 void rockchip_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
 
-- 
2.12.0.246.ga2ecc84866-goog
