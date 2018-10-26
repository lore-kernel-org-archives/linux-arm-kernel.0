From: ck.hu@mediatek.com (CK Hu)
Date: Fri, 26 Oct 2018 15:22:02 +0800
Subject: [PATCH 2/3] drm: Add drm_gem_cma_dumb_create_no_kmap() helper function
In-Reply-To: <1540538523-1973-1-git-send-email-ck.hu@mediatek.com>
References: <1540538523-1973-1-git-send-email-ck.hu@mediatek.com>
Message-ID: <1540538523-1973-3-git-send-email-ck.hu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For iommu-supporting device, mapping kernel virtual address would reduce
free virtual memory area, and kernel usually need not using this virtual
address, so add drm_gem_cma_dumb_create_no_kmap() to create cma dumb
without mapping kernel virtual address.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/drm_gem_cma_helper.c | 99 +++++++++++++++++++++++++++++-------
 include/drm/drm_gem_cma_helper.h     |  7 +++
 2 files changed, 88 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index 0ba2c2a..c8e0e8e 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -85,20 +85,23 @@
 }
 
 /**
- * drm_gem_cma_create - allocate an object with the given size
+ * drm_gem_cma_create_kmap - allocate an object with the given size and
+ * map kernel virtual address.
  * @drm: DRM device
  * @size: size of the object to allocate
+ * @alloc_kmap: dma allocation with kernel mapping
  *
- * This function creates a CMA GEM object and allocates a contiguous chunk of
- * memory as backing store. The backing memory has the writecombine attribute
- * set.
+ * This function creates a CMA GEM object and allocates a memory as
+ * backing store. The backing memory has the writecombine attribute
+ * set. If alloc_kmap is true, the backing memory also has the kernel mapping
+ * attribute set.
  *
  * Returns:
  * A struct drm_gem_cma_object * on success or an ERR_PTR()-encoded negative
  * error code on failure.
  */
-struct drm_gem_cma_object *drm_gem_cma_create(struct drm_device *drm,
-					      size_t size)
+static struct drm_gem_cma_object *
+drm_gem_cma_create_kmap(struct drm_device *drm, size_t size, bool alloc_kmap)
 {
 	struct drm_gem_cma_object *cma_obj;
 	struct device *dev = drm->dma_dev ? drm->dma_dev : drm->dev;
@@ -110,21 +113,48 @@ struct drm_gem_cma_object *drm_gem_cma_create(struct drm_device *drm,
 	if (IS_ERR(cma_obj))
 		return cma_obj;
 
-	cma_obj->vaddr = dma_alloc_wc(dev, size, &cma_obj->paddr,
-				      GFP_KERNEL | __GFP_NOWARN);
-	if (!cma_obj->vaddr) {
+	cma_obj->dma_attrs = DMA_ATTR_WRITE_COMBINE;
+	if (!alloc_kmap)
+		cma_obj->dma_attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
+
+	cma_obj->cookie = dma_alloc_attrs(dev, size, &cma_obj->paddr,
+					 GFP_KERNEL | __GFP_NOWARN,
+					 cma_obj->dma_attrs);
+	if (!cma_obj->cookie) {
 		dev_dbg(dev, "failed to allocate buffer with size %zu\n",
 			size);
 		ret = -ENOMEM;
 		goto error;
 	}
 
+	if (alloc_kmap)
+		cma_obj->vaddr = cma_obj->cookie;
+
 	return cma_obj;
 
 error:
 	drm_gem_object_put_unlocked(&cma_obj->base);
 	return ERR_PTR(ret);
 }
+
+/**
+ * drm_gem_cma_create - allocate an object with the given size
+ * @drm: DRM device
+ * @size: size of the object to allocate
+ *
+ * This function creates a CMA GEM object and allocates a contiguous chunk of
+ * memory as backing store. The backing memory has the writecombine attribute
+ * set.
+ *
+ * Returns:
+ * A struct drm_gem_cma_object * on success or an ERR_PTR()-encoded negative
+ * error code on failure.
+ */
+struct drm_gem_cma_object *drm_gem_cma_create(struct drm_device *drm,
+					      size_t size)
+{
+	return drm_gem_cma_create_kmap(drm, size, true);
+}
 EXPORT_SYMBOL_GPL(drm_gem_cma_create);
 
 /**
@@ -146,13 +176,13 @@ struct drm_gem_cma_object *drm_gem_cma_create(struct drm_device *drm,
 static struct drm_gem_cma_object *
 drm_gem_cma_create_with_handle(struct drm_file *file_priv,
 			       struct drm_device *drm, size_t size,
-			       uint32_t *handle)
+			       uint32_t *handle, bool alloc_kmap)
 {
 	struct drm_gem_cma_object *cma_obj;
 	struct drm_gem_object *gem_obj;
 	int ret;
 
-	cma_obj = drm_gem_cma_create(drm, size);
+	cma_obj = drm_gem_cma_create_kmap(drm, size, alloc_kmap);
 	if (IS_ERR(cma_obj))
 		return cma_obj;
 
@@ -187,11 +217,12 @@ void drm_gem_cma_free_object(struct drm_gem_object *gem_obj)
 
 	cma_obj = to_drm_gem_cma_obj(gem_obj);
 
-	if (cma_obj->vaddr) {
+	if (cma_obj->cookie) {
 		dev = gem_obj->dev->dma_dev ?
 		      gem_obj->dev->dma_dev : gem_obj->dev->dev;
-		dma_free_wc(dev, cma_obj->base.size,
-			    cma_obj->vaddr, cma_obj->paddr);
+		dma_free_attrs(dev, cma_obj->base.size,
+			       cma_obj->cookie, cma_obj->paddr,
+			       cma_obj->dma_attrs);
 	} else if (gem_obj->import_attach) {
 		drm_prime_gem_destroy(gem_obj, cma_obj->sgt);
 	}
@@ -230,7 +261,7 @@ int drm_gem_cma_dumb_create_internal(struct drm_file *file_priv,
 		args->size = args->pitch * args->height;
 
 	cma_obj = drm_gem_cma_create_with_handle(file_priv, drm, args->size,
-						 &args->handle);
+						 &args->handle, true);
 	return PTR_ERR_OR_ZERO(cma_obj);
 }
 EXPORT_SYMBOL_GPL(drm_gem_cma_dumb_create_internal);
@@ -263,11 +294,43 @@ int drm_gem_cma_dumb_create(struct drm_file *file_priv,
 	args->size = args->pitch * args->height;
 
 	cma_obj = drm_gem_cma_create_with_handle(file_priv, drm, args->size,
-						 &args->handle);
+						 &args->handle, true);
 	return PTR_ERR_OR_ZERO(cma_obj);
 }
 EXPORT_SYMBOL_GPL(drm_gem_cma_dumb_create);
 
+/**
+ * drm_gem_cma_dumb_create_no_kmap - create a dumb buffer object without
+ *                                   kernel mapping
+ * @file_priv: DRM file-private structure to create the dumb buffer for
+ * @drm: DRM device
+ * @args: IOCTL data
+ *
+ * This function computes the pitch of the dumb buffer and rounds it up to an
+ * integer number of bytes per pixel. Drivers for hardware that doesn't have
+ * any additional restrictions on the pitch can directly use this function as
+ * their &drm_driver.dumb_create callback.
+ *
+ * For hardware with additional restrictions, don't use this function.
+ *
+ * Returns:
+ * 0 on success or a negative error code on failure.
+ */
+int drm_gem_cma_dumb_create_no_kmap(struct drm_file *file_priv,
+				    struct drm_device *drm,
+				    struct drm_mode_create_dumb *args)
+{
+	struct drm_gem_cma_object *cma_obj;
+
+	args->pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
+	args->size = args->pitch * args->height;
+
+	cma_obj = drm_gem_cma_create_with_handle(file_priv, drm, args->size,
+						 &args->handle, false);
+	return PTR_ERR_OR_ZERO(cma_obj);
+}
+EXPORT_SYMBOL_GPL(drm_gem_cma_dumb_create_no_kmap);
+
 const struct vm_operations_struct drm_gem_cma_vm_ops = {
 	.open = drm_gem_vm_open,
 	.close = drm_gem_vm_close,
@@ -290,7 +353,7 @@ static int drm_gem_cma_mmap_obj(struct drm_gem_cma_object *cma_obj,
 
 	dev = cma_obj->base.dev->dma_dev ?
 	      cma_obj->base.dev->dma_dev : cma_obj->base.dev->dev;
-	ret = dma_mmap_wc(dev, vma, cma_obj->vaddr,
+	ret = dma_mmap_wc(dev, vma, cma_obj->cookie,
 			  cma_obj->paddr, vma->vm_end - vma->vm_start);
 	if (ret)
 		drm_gem_vm_close(vma);
@@ -447,7 +510,7 @@ struct sg_table *drm_gem_cma_prime_get_sg_table(struct drm_gem_object *obj)
 		return NULL;
 
 	dev = obj->dev->dma_dev ? obj->dev->dma_dev : obj->dev->dev;
-	ret = dma_get_sgtable(dev, sgt, cma_obj->vaddr,
+	ret = dma_get_sgtable(dev, sgt, cma_obj->cookie,
 			      cma_obj->paddr, obj->size);
 	if (ret < 0)
 		goto out;
diff --git a/include/drm/drm_gem_cma_helper.h b/include/drm/drm_gem_cma_helper.h
index 1977714..5164925 100644
--- a/include/drm/drm_gem_cma_helper.h
+++ b/include/drm/drm_gem_cma_helper.h
@@ -20,7 +20,9 @@ struct drm_gem_cma_object {
 	struct sg_table *sgt;
 
 	/* For objects with DMA memory allocated by GEM CMA */
+	void *cookie;
 	void *vaddr;
+	unsigned long dma_attrs;
 };
 
 #define to_drm_gem_cma_obj(gem_obj) \
@@ -73,6 +75,11 @@ int drm_gem_cma_dumb_create(struct drm_file *file_priv,
 			    struct drm_device *drm,
 			    struct drm_mode_create_dumb *args);
 
+/* create memory region for DRM framebuffer */
+int drm_gem_cma_dumb_create_no_kmap(struct drm_file *file_priv,
+				    struct drm_device *drm,
+				    struct drm_mode_create_dumb *args);
+
 /* set vm_flags and we can change the VM attribute to other one@here */
 int drm_gem_cma_mmap(struct file *filp, struct vm_area_struct *vma);
 
-- 
1.9.1
