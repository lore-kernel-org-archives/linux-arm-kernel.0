From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jun 2016 12:11:29 +0200
Subject: [PATCH v4 12/44] drm/mediatek: dma-mapping: Use unsigned long for
 dma_attrs
In-Reply-To: <1465553521-27303-1-git-send-email-k.kozlowski@samsung.com>
References: <1465553521-27303-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1465553521-27303-13-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split out subsystem specific changes for easier reviews. This will be
squashed with main commit.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 13 ++++++-------
 drivers/gpu/drm/mediatek/mtk_drm_gem.h |  2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index fa2ec0cd00e8..7abc550ebc00 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -54,15 +54,14 @@ struct mtk_drm_gem_obj *mtk_drm_gem_create(struct drm_device *dev,
 
 	obj = &mtk_gem->base;
 
-	init_dma_attrs(&mtk_gem->dma_attrs);
-	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &mtk_gem->dma_attrs);
+	mtk_gem->dma_attrs = DMA_ATTR_WRITE_COMBINE;
 
 	if (!alloc_kmap)
-		dma_set_attr(DMA_ATTR_NO_KERNEL_MAPPING, &mtk_gem->dma_attrs);
+		mtk_gem->dma_attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
 
 	mtk_gem->cookie = dma_alloc_attrs(priv->dma_dev, obj->size,
 					  &mtk_gem->dma_addr, GFP_KERNEL,
-					  &mtk_gem->dma_attrs);
+					  mtk_gem->dma_attrs);
 	if (!mtk_gem->cookie) {
 		DRM_ERROR("failed to allocate %zx byte dma buffer", obj->size);
 		ret = -ENOMEM;
@@ -93,7 +92,7 @@ void mtk_drm_gem_free_object(struct drm_gem_object *obj)
 		drm_prime_gem_destroy(obj, mtk_gem->sg);
 	else
 		dma_free_attrs(priv->dma_dev, obj->size, mtk_gem->cookie,
-			       mtk_gem->dma_addr, &mtk_gem->dma_attrs);
+			       mtk_gem->dma_addr, mtk_gem->dma_attrs);
 
 	/* release file pointer to gem object. */
 	drm_gem_object_release(obj);
@@ -173,7 +172,7 @@ static int mtk_drm_gem_object_mmap(struct drm_gem_object *obj,
 	vma->vm_pgoff = 0;
 
 	ret = dma_mmap_attrs(priv->dma_dev, vma, mtk_gem->cookie,
-			     mtk_gem->dma_addr, obj->size, &mtk_gem->dma_attrs);
+			     mtk_gem->dma_addr, obj->size, mtk_gem->dma_attrs);
 	if (ret)
 		drm_gem_vm_close(vma);
 
@@ -224,7 +223,7 @@ struct sg_table *mtk_gem_prime_get_sg_table(struct drm_gem_object *obj)
 
 	ret = dma_get_sgtable_attrs(priv->dma_dev, sgt, mtk_gem->cookie,
 				    mtk_gem->dma_addr, obj->size,
-				    &mtk_gem->dma_attrs);
+				    mtk_gem->dma_attrs);
 	if (ret) {
 		DRM_ERROR("failed to allocate sgt, %d\n", ret);
 		kfree(sgt);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.h b/drivers/gpu/drm/mediatek/mtk_drm_gem.h
index 3a2a5624a1cb..2752718fa5b2 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.h
@@ -35,7 +35,7 @@ struct mtk_drm_gem_obj {
 	void			*cookie;
 	void			*kvaddr;
 	dma_addr_t		dma_addr;
-	struct dma_attrs	dma_attrs;
+	unsigned long		dma_attrs;
 	struct sg_table		*sg;
 };
 
-- 
1.9.1
