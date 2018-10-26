From: ck.hu@mediatek.com (CK Hu)
Date: Fri, 26 Oct 2018 15:22:01 +0800
Subject: [PATCH 1/3] drm: Add dma_dev in struct drm_device
In-Reply-To: <1540538523-1973-1-git-send-email-ck.hu@mediatek.com>
References: <1540538523-1973-1-git-send-email-ck.hu@mediatek.com>
Message-ID: <1540538523-1973-2-git-send-email-ck.hu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For drm device which has sub device, the dma function may be in the sub
device rather than it, so the dma_dev is the device which has dma
function and use this device for dma operation.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/drm_gem_cma_helper.c | 19 ++++++++++++++-----
 include/drm/drm_device.h             |  1 +
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index 80a5115..0ba2c2a 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -101,6 +101,7 @@ struct drm_gem_cma_object *drm_gem_cma_create(struct drm_device *drm,
 					      size_t size)
 {
 	struct drm_gem_cma_object *cma_obj;
+	struct device *dev = drm->dma_dev ? drm->dma_dev : drm->dev;
 	int ret;
 
 	size = round_up(size, PAGE_SIZE);
@@ -109,10 +110,10 @@ struct drm_gem_cma_object *drm_gem_cma_create(struct drm_device *drm,
 	if (IS_ERR(cma_obj))
 		return cma_obj;
 
-	cma_obj->vaddr = dma_alloc_wc(drm->dev, size, &cma_obj->paddr,
+	cma_obj->vaddr = dma_alloc_wc(dev, size, &cma_obj->paddr,
 				      GFP_KERNEL | __GFP_NOWARN);
 	if (!cma_obj->vaddr) {
-		dev_dbg(drm->dev, "failed to allocate buffer with size %zu\n",
+		dev_dbg(dev, "failed to allocate buffer with size %zu\n",
 			size);
 		ret = -ENOMEM;
 		goto error;
@@ -182,11 +183,14 @@ struct drm_gem_cma_object *drm_gem_cma_create(struct drm_device *drm,
 void drm_gem_cma_free_object(struct drm_gem_object *gem_obj)
 {
 	struct drm_gem_cma_object *cma_obj;
+	struct device *dev;
 
 	cma_obj = to_drm_gem_cma_obj(gem_obj);
 
 	if (cma_obj->vaddr) {
-		dma_free_wc(gem_obj->dev->dev, cma_obj->base.size,
+		dev = gem_obj->dev->dma_dev ?
+		      gem_obj->dev->dma_dev : gem_obj->dev->dev;
+		dma_free_wc(dev, cma_obj->base.size,
 			    cma_obj->vaddr, cma_obj->paddr);
 	} else if (gem_obj->import_attach) {
 		drm_prime_gem_destroy(gem_obj, cma_obj->sgt);
@@ -274,6 +278,7 @@ static int drm_gem_cma_mmap_obj(struct drm_gem_cma_object *cma_obj,
 				struct vm_area_struct *vma)
 {
 	int ret;
+	struct device *dev;
 
 	/*
 	 * Clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and set the
@@ -283,7 +288,9 @@ static int drm_gem_cma_mmap_obj(struct drm_gem_cma_object *cma_obj,
 	vma->vm_flags &= ~VM_PFNMAP;
 	vma->vm_pgoff = 0;
 
-	ret = dma_mmap_wc(cma_obj->base.dev->dev, vma, cma_obj->vaddr,
+	dev = cma_obj->base.dev->dma_dev ?
+	      cma_obj->base.dev->dma_dev : cma_obj->base.dev->dev;
+	ret = dma_mmap_wc(dev, vma, cma_obj->vaddr,
 			  cma_obj->paddr, vma->vm_end - vma->vm_start);
 	if (ret)
 		drm_gem_vm_close(vma);
@@ -432,13 +439,15 @@ struct sg_table *drm_gem_cma_prime_get_sg_table(struct drm_gem_object *obj)
 {
 	struct drm_gem_cma_object *cma_obj = to_drm_gem_cma_obj(obj);
 	struct sg_table *sgt;
+	struct device *dev;
 	int ret;
 
 	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
 	if (!sgt)
 		return NULL;
 
-	ret = dma_get_sgtable(obj->dev->dev, sgt, cma_obj->vaddr,
+	dev = obj->dev->dma_dev ? obj->dev->dma_dev : obj->dev->dev;
+	ret = dma_get_sgtable(dev, sgt, cma_obj->vaddr,
 			      cma_obj->paddr, obj->size);
 	if (ret < 0)
 		goto out;
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index f9c6e0e..ede9228 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -113,6 +113,7 @@ struct drm_device {
 
 	/** \name DMA support */
 	/*@{ */
+	struct device *dma_dev;		/**< Device structure of dma device */
 	struct drm_device_dma *dma;		/**< Optional pointer for DMA support */
 	/*@} */
 
-- 
1.9.1
