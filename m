From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jun 2016 12:11:32 +0200
Subject: [PATCH v4 15/44] drm/rockship: dma-mapping: Use unsigned long for
 dma_attrs
In-Reply-To: <1465553521-27303-1-git-send-email-k.kozlowski@samsung.com>
References: <1465553521-27303-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1465553521-27303-16-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split out subsystem specific changes for easier reviews. This will be
squashed with main commit.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 17 +++++++----------
 drivers/gpu/drm/rockchip/rockchip_drm_gem.h |  2 +-
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 9c2d8a894093..7b1788e2a808 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -17,8 +17,6 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_vma_manager.h>
 
-#include <linux/dma-attrs.h>
-
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_gem.h"
 
@@ -28,15 +26,14 @@ static int rockchip_gem_alloc_buf(struct rockchip_gem_object *rk_obj,
 	struct drm_gem_object *obj = &rk_obj->base;
 	struct drm_device *drm = obj->dev;
 
-	init_dma_attrs(&rk_obj->dma_attrs);
-	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &rk_obj->dma_attrs);
+	rk_obj->dma_attrs = DMA_ATTR_WRITE_COMBINE;
 
 	if (!alloc_kmap)
-		dma_set_attr(DMA_ATTR_NO_KERNEL_MAPPING, &rk_obj->dma_attrs);
+		rk_obj->dma_attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
 
 	rk_obj->kvaddr = dma_alloc_attrs(drm->dev, obj->size,
 					 &rk_obj->dma_addr, GFP_KERNEL,
-					 &rk_obj->dma_attrs);
+					 rk_obj->dma_attrs);
 	if (!rk_obj->kvaddr) {
 		DRM_ERROR("failed to allocate %#x byte dma buffer", obj->size);
 		return -ENOMEM;
@@ -51,7 +48,7 @@ static void rockchip_gem_free_buf(struct rockchip_gem_object *rk_obj)
 	struct drm_device *drm = obj->dev;
 
 	dma_free_attrs(drm->dev, obj->size, rk_obj->kvaddr, rk_obj->dma_addr,
-		       &rk_obj->dma_attrs);
+		       rk_obj->dma_attrs);
 }
 
 static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
@@ -70,7 +67,7 @@ static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
 	vma->vm_pgoff = 0;
 
 	ret = dma_mmap_attrs(drm->dev, vma, rk_obj->kvaddr, rk_obj->dma_addr,
-			     obj->size, &rk_obj->dma_attrs);
+			     obj->size, rk_obj->dma_attrs);
 	if (ret)
 		drm_gem_vm_close(vma);
 
@@ -262,7 +259,7 @@ struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object *obj)
 
 	ret = dma_get_sgtable_attrs(drm->dev, sgt, rk_obj->kvaddr,
 				    rk_obj->dma_addr, obj->size,
-				    &rk_obj->dma_attrs);
+				    rk_obj->dma_attrs);
 	if (ret) {
 		DRM_ERROR("failed to allocate sgt, %d\n", ret);
 		kfree(sgt);
@@ -276,7 +273,7 @@ void *rockchip_gem_prime_vmap(struct drm_gem_object *obj)
 {
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
 
-	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, &rk_obj->dma_attrs))
+	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, rk_obj->dma_attrs))
 		return NULL;
 
 	return rk_obj->kvaddr;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
index ad22618473a4..18b3488db4ec 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
@@ -23,7 +23,7 @@ struct rockchip_gem_object {
 
 	void *kvaddr;
 	dma_addr_t dma_addr;
-	struct dma_attrs dma_attrs;
+	unsigned long dma_attrs;
 };
 
 struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object *obj);
-- 
1.9.1
