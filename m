From: mark.yao@rock-chips.com (Mark Yao)
Date: Fri, 10 Feb 2017 14:29:34 +0800
Subject: [PATCH v3 1/2] drm/rockchip: Do not use DMA mapping API if attached
 to IOMMU domain
In-Reply-To: <1486708175-23857-1-git-send-email-mark.yao@rock-chips.com>
References: <1486708175-23857-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1486708175-23857-2-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Figa <tfiga@chromium.org>

The API is not suitable for subsystems consisting of multiple devices
and requires severe hacks to use it. To mitigate this, this patch
implements allocation and address space management locally by using
helpers provided by DRM framework, like other DRM drivers do, e.g.
Tegra.

This patch should not introduce any functional changes until the driver
is made to attach subdevices into an IOMMU domain with the generic IOMMU
API, which will happen in following patch. Based heavily on GEM
implementation of Tegra DRM driver.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
Signed-off-by: rjan Eide <orjan.eide@arm.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   6 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 244 ++++++++++++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_gem.h |   8 +
 3 files changed, 244 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index fb6226c..adc3930 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -30,6 +30,7 @@
 
 struct drm_device;
 struct drm_connector;
+struct iommu_domain;
 
 /*
  * Rockchip drm private crtc funcs.
@@ -60,7 +61,10 @@ struct rockchip_drm_private {
 	struct drm_gem_object *fbdev_bo;
 	const struct rockchip_crtc_funcs *crtc_funcs[ROCKCHIP_MAX_CRTC];
 	struct drm_atomic_state *state;
-
+	struct iommu_domain *domain;
+	/* protect drm_mm on multi-threads */
+	struct mutex mm_lock;
+	struct drm_mm mm;
 	struct list_head psr_list;
 	spinlock_t psr_list_lock;
 };
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index b70f942..df9e570 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -16,11 +16,146 @@
 #include <drm/drmP.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_vma_manager.h>
+#include <linux/iommu.h>
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_gem.h"
 
-static int rockchip_gem_alloc_buf(struct rockchip_gem_object *rk_obj,
+static int rockchip_gem_iommu_map(struct rockchip_gem_object *rk_obj)
+{
+	struct drm_device *drm = rk_obj->base.dev;
+	struct rockchip_drm_private *private = drm->dev_private;
+	int prot = IOMMU_READ | IOMMU_WRITE;
+	ssize_t ret;
+
+	mutex_lock(&private->mm_lock);
+
+	ret = drm_mm_insert_node_generic(&private->mm, &rk_obj->mm,
+					 rk_obj->base.size, PAGE_SIZE,
+					 0, 0);
+
+	mutex_unlock(&private->mm_lock);
+	if (ret < 0) {
+		DRM_ERROR("out of I/O virtual memory: %zd\n", ret);
+		return ret;
+	}
+
+	rk_obj->dma_addr = rk_obj->mm.start;
+
+	ret = iommu_map_sg(private->domain, rk_obj->dma_addr, rk_obj->sgt->sgl,
+			   rk_obj->sgt->nents, prot);
+	if (ret < rk_obj->base.size) {
+		DRM_ERROR("failed to map buffer: size=%zd request_size=%zd\n",
+			  ret, rk_obj->base.size);
+		ret = -ENOMEM;
+		goto err_remove_node;
+	}
+
+	rk_obj->size = ret;
+
+	return 0;
+
+err_remove_node:
+	drm_mm_remove_node(&rk_obj->mm);
+
+	return ret;
+}
+
+static int rockchip_gem_iommu_unmap(struct rockchip_gem_object *rk_obj)
+{
+	struct drm_device *drm = rk_obj->base.dev;
+	struct rockchip_drm_private *private = drm->dev_private;
+
+	iommu_unmap(private->domain, rk_obj->dma_addr, rk_obj->size);
+
+	mutex_lock(&private->mm_lock);
+
+	drm_mm_remove_node(&rk_obj->mm);
+
+	mutex_unlock(&private->mm_lock);
+
+	return 0;
+}
+
+static int rockchip_gem_get_pages(struct rockchip_gem_object *rk_obj)
+{
+	struct drm_device *drm = rk_obj->base.dev;
+	int ret, i;
+	struct scatterlist *s;
+
+	rk_obj->pages = drm_gem_get_pages(&rk_obj->base);
+	if (IS_ERR(rk_obj->pages))
+		return PTR_ERR(rk_obj->pages);
+
+	rk_obj->num_pages = rk_obj->base.size >> PAGE_SHIFT;
+
+	rk_obj->sgt = drm_prime_pages_to_sg(rk_obj->pages, rk_obj->num_pages);
+	if (IS_ERR(rk_obj->sgt)) {
+		ret = PTR_ERR(rk_obj->sgt);
+		goto err_put_pages;
+	}
+
+	/*
+	 * Fake up the SG table so that dma_sync_sg_for_device() can be used
+	 * to flush the pages associated with it.
+	 *
+	 * TODO: Replace this by drm_clflush_sg() once it can be implemented
+	 * without relying on symbols that are not exported.
+	 */
+	for_each_sg(rk_obj->sgt->sgl, s, rk_obj->sgt->nents, i)
+		sg_dma_address(s) = sg_phys(s);
+
+	dma_sync_sg_for_device(drm->dev, rk_obj->sgt->sgl, rk_obj->sgt->nents,
+			       DMA_TO_DEVICE);
+
+	return 0;
+
+err_put_pages:
+	drm_gem_put_pages(&rk_obj->base, rk_obj->pages, false, false);
+	return ret;
+}
+
+static void rockchip_gem_put_pages(struct rockchip_gem_object *rk_obj)
+{
+	sg_free_table(rk_obj->sgt);
+	kfree(rk_obj->sgt);
+	drm_gem_put_pages(&rk_obj->base, rk_obj->pages, true, true);
+}
+
+static int rockchip_gem_alloc_iommu(struct rockchip_gem_object *rk_obj,
+				    bool alloc_kmap)
+{
+	int ret;
+
+	ret = rockchip_gem_get_pages(rk_obj);
+	if (ret < 0)
+		return ret;
+
+	ret = rockchip_gem_iommu_map(rk_obj);
+	if (ret < 0)
+		goto err_free;
+
+	if (alloc_kmap) {
+		rk_obj->kvaddr = vmap(rk_obj->pages, rk_obj->num_pages, VM_MAP,
+				      pgprot_writecombine(PAGE_KERNEL));
+		if (!rk_obj->kvaddr) {
+			DRM_ERROR("failed to vmap() buffer\n");
+			ret = -ENOMEM;
+			goto err_unmap;
+		}
+	}
+
+	return 0;
+
+err_unmap:
+	rockchip_gem_iommu_unmap(rk_obj);
+err_free:
+	rockchip_gem_put_pages(rk_obj);
+
+	return ret;
+}
+
+static int rockchip_gem_alloc_dma(struct rockchip_gem_object *rk_obj,
 				  bool alloc_kmap)
 {
 	struct drm_gem_object *obj = &rk_obj->base;
@@ -42,7 +177,27 @@ static int rockchip_gem_alloc_buf(struct rockchip_gem_object *rk_obj,
 	return 0;
 }
 
-static void rockchip_gem_free_buf(struct rockchip_gem_object *rk_obj)
+static int rockchip_gem_alloc_buf(struct rockchip_gem_object *rk_obj,
+				  bool alloc_kmap)
+{
+	struct drm_gem_object *obj = &rk_obj->base;
+	struct drm_device *drm = obj->dev;
+	struct rockchip_drm_private *private = drm->dev_private;
+
+	if (private->domain)
+		return rockchip_gem_alloc_iommu(rk_obj, alloc_kmap);
+	else
+		return rockchip_gem_alloc_dma(rk_obj, alloc_kmap);
+}
+
+static void rockchip_gem_free_iommu(struct rockchip_gem_object *rk_obj)
+{
+	vunmap(rk_obj->kvaddr);
+	rockchip_gem_iommu_unmap(rk_obj);
+	rockchip_gem_put_pages(rk_obj);
+}
+
+static void rockchip_gem_free_dma(struct rockchip_gem_object *rk_obj)
 {
 	struct drm_gem_object *obj = &rk_obj->base;
 	struct drm_device *drm = obj->dev;
@@ -51,23 +206,68 @@ static void rockchip_gem_free_buf(struct rockchip_gem_object *rk_obj)
 		       rk_obj->dma_attrs);
 }
 
-static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
-					struct vm_area_struct *vma)
+static void rockchip_gem_free_buf(struct rockchip_gem_object *rk_obj)
+{
+	if (rk_obj->pages)
+		rockchip_gem_free_iommu(rk_obj);
+	else
+		rockchip_gem_free_dma(rk_obj);
+}
 
+static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
+					      struct vm_area_struct *vma)
 {
+	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
+	unsigned int i, count = obj->size >> PAGE_SHIFT;
+	unsigned long user_count = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	unsigned long uaddr = vma->vm_start;
+	unsigned long offset = vma->vm_pgoff;
+	unsigned long end = user_count + offset;
 	int ret;
+
+	if (user_count == 0)
+		return -ENXIO;
+	if (end > count)
+		return -ENXIO;
+
+	for (i = offset; i < end; i++) {
+		ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
+		if (ret)
+			return ret;
+		uaddr += PAGE_SIZE;
+	}
+
+	return 0;
+}
+
+static int rockchip_drm_gem_object_mmap_dma(struct drm_gem_object *obj,
+					    struct vm_area_struct *vma)
+{
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
 	struct drm_device *drm = obj->dev;
 
+	return dma_mmap_attrs(drm->dev, vma, rk_obj->kvaddr, rk_obj->dma_addr,
+			      obj->size, rk_obj->dma_attrs);
+}
+
+static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
+					struct vm_area_struct *vma)
+{
+	int ret;
+	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
+
 	/*
-	 * dma_alloc_attrs() allocated a struct page table for rk_obj, so clear
+	 * We allocated a struct page table for rk_obj, so clear
 	 * VM_PFNMAP flag that was set by drm_gem_mmap_obj()/drm_gem_mmap().
 	 */
 	vma->vm_flags &= ~VM_PFNMAP;
 	vma->vm_pgoff = 0;
 
-	ret = dma_mmap_attrs(drm->dev, vma, rk_obj->kvaddr, rk_obj->dma_addr,
-			     obj->size, rk_obj->dma_attrs);
+	if (rk_obj->pages)
+		ret = rockchip_drm_gem_object_mmap_iommu(obj, vma);
+	else
+		ret = rockchip_drm_gem_object_mmap_dma(obj, vma);
+
 	if (ret)
 		drm_gem_vm_close(vma);
 
@@ -101,6 +301,12 @@ int rockchip_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 	return rockchip_drm_gem_object_mmap(obj, vma);
 }
 
+static void rockchip_gem_release_object(struct rockchip_gem_object *rk_obj)
+{
+	drm_gem_object_release(&rk_obj->base);
+	kfree(rk_obj);
+}
+
 struct rockchip_gem_object *
 	rockchip_gem_create_object(struct drm_device *drm, unsigned int size,
 				   bool alloc_kmap)
@@ -117,7 +323,7 @@ struct rockchip_gem_object *
 
 	obj = &rk_obj->base;
 
-	drm_gem_private_object_init(drm, obj, size);
+	drm_gem_object_init(drm, obj, size);
 
 	ret = rockchip_gem_alloc_buf(rk_obj, alloc_kmap);
 	if (ret)
@@ -126,7 +332,7 @@ struct rockchip_gem_object *
 	return rk_obj;
 
 err_free_rk_obj:
-	kfree(rk_obj);
+	rockchip_gem_release_object(rk_obj);
 	return ERR_PTR(ret);
 }
 
@@ -138,13 +344,11 @@ void rockchip_gem_free_object(struct drm_gem_object *obj)
 {
 	struct rockchip_gem_object *rk_obj;
 
-	drm_gem_free_mmap_offset(obj);
-
 	rk_obj = to_rockchip_obj(obj);
 
 	rockchip_gem_free_buf(rk_obj);
 
-	kfree(rk_obj);
+	rockchip_gem_release_object(rk_obj);
 }
 
 /*
@@ -253,6 +457,9 @@ struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object *obj)
 	struct sg_table *sgt;
 	int ret;
 
+	if (rk_obj->pages)
+		return drm_prime_pages_to_sg(rk_obj->pages, rk_obj->num_pages);
+
 	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
 	if (!sgt)
 		return ERR_PTR(-ENOMEM);
@@ -273,6 +480,10 @@ void *rockchip_gem_prime_vmap(struct drm_gem_object *obj)
 {
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
 
+	if (rk_obj->pages)
+		return vmap(rk_obj->pages, rk_obj->num_pages, VM_MAP,
+			    pgprot_writecombine(PAGE_KERNEL));
+
 	if (rk_obj->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING)
 		return NULL;
 
@@ -281,5 +492,12 @@ void *rockchip_gem_prime_vmap(struct drm_gem_object *obj)
 
 void rockchip_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
 {
-	/* Nothing to do */
+	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
+
+	if (rk_obj->pages) {
+		vunmap(vaddr);
+		return;
+	}
+
+	/* Nothing to do if allocated by DMA mapping API. */
 }
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
index 18b3488..3f6ea4d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
@@ -23,7 +23,15 @@ struct rockchip_gem_object {
 
 	void *kvaddr;
 	dma_addr_t dma_addr;
+	/* Used when IOMMU is disabled */
 	unsigned long dma_attrs;
+
+	/* Used when IOMMU is enabled */
+	struct drm_mm_node mm;
+	unsigned long num_pages;
+	struct page **pages;
+	struct sg_table *sgt;
+	size_t size;
 };
 
 struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object *obj);
-- 
1.9.1
