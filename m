From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 18 Jun 2015 15:49:25 +0800
Subject: [PATCH 1/6] drm/rockchip: import dma_buf to gem
In-Reply-To: <1434613770-6608-1-git-send-email-mark.yao@rock-chips.com>
References: <1434613770-6608-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1434613770-6608-2-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to display a buffer allocated by other driver, need import
the buffer to gem.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |    1 +
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c |   45 +++++++++++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_gem.h |    5 ++-
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 3962176..9001a90 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -287,6 +287,7 @@ static struct drm_driver rockchip_drm_driver = {
 	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
 	.gem_prime_import	= drm_gem_prime_import,
+	.gem_prime_import_sg_table = rockchip_gem_prime_import_sg_table,
 	.gem_prime_export	= drm_gem_prime_export,
 	.gem_prime_get_sg_table	= rockchip_gem_prime_get_sg_table,
 	.gem_prime_vmap		= rockchip_gem_prime_vmap,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index eb2282c..2e30e23 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -18,6 +18,7 @@
 #include <drm/drm_vma_manager.h>
 
 #include <linux/dma-attrs.h>
+#include <linux/dma-buf.h>
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_gem.h"
@@ -105,6 +106,38 @@ int rockchip_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 	return ret;
 }
 
+struct drm_gem_object *
+rockchip_gem_prime_import_sg_table(struct drm_device *drm,
+				   struct dma_buf_attachment *attach,
+				   struct sg_table *sgt)
+{
+	struct rockchip_gem_object *rk_obj;
+	struct drm_gem_object *obj;
+	int ret;
+
+	rk_obj = kzalloc(sizeof(*rk_obj), GFP_KERNEL);
+	if (!rk_obj)
+		return ERR_PTR(-ENOMEM);
+
+	obj = &rk_obj->base;
+
+	drm_gem_private_object_init(drm, obj, attach->dmabuf->size);
+
+	if (!dma_map_sg(drm->dev, sgt->sgl, sgt->nents, DMA_TO_DEVICE)) {
+		ret = -ENOMEM;
+		goto err_free_obj;
+	}
+	rk_obj->dma_addr = sg_dma_address(sgt->sgl);
+	rk_obj->sgt = sgt;
+	obj->size = sg_dma_len(sgt->sgl);
+
+	return obj;
+
+err_free_obj:
+	kfree(rk_obj);
+	return ERR_PTR(ret);
+}
+
 struct rockchip_gem_object *
 	rockchip_gem_create_object(struct drm_device *drm, unsigned int size,
 				   bool alloc_kmap)
@@ -140,13 +173,19 @@ err_free_rk_obj:
  */
 void rockchip_gem_free_object(struct drm_gem_object *obj)
 {
+	struct drm_device *drm = obj->dev;
 	struct rockchip_gem_object *rk_obj;
 
-	drm_gem_free_mmap_offset(obj);
-
 	rk_obj = to_rockchip_obj(obj);
 
-	rockchip_gem_free_buf(rk_obj);
+	if (obj->import_attach) {
+		dma_unmap_sg(drm->dev, rk_obj->sgt->sgl,
+			     rk_obj->sgt->nents, DMA_TO_DEVICE);
+		drm_prime_gem_destroy(obj, rk_obj->sgt);
+	} else {
+		drm_gem_free_mmap_offset(obj);
+		rockchip_gem_free_buf(rk_obj);
+	}
 
 	kfree(rk_obj);
 }
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
index ad22618..9fd58e3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
@@ -21,6 +21,7 @@ struct rockchip_gem_object {
 	struct drm_gem_object base;
 	unsigned int flags;
 
+	struct sg_table *sgt;
 	void *kvaddr;
 	dma_addr_t dma_addr;
 	struct dma_attrs dma_attrs;
@@ -28,8 +29,10 @@ struct rockchip_gem_object {
 
 struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object *obj);
 struct drm_gem_object *
-rockchip_gem_prime_import_sg_table(struct drm_device *dev, size_t size,
+rockchip_gem_prime_import_sg_table(struct drm_device *drm,
+				   struct dma_buf_attachment *attach,
 				   struct sg_table *sgt);
+
 void *rockchip_gem_prime_vmap(struct drm_gem_object *obj);
 void rockchip_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
 
-- 
1.7.9.5
