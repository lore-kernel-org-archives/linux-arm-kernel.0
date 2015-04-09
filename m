From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu,  9 Apr 2015 16:34:08 +0200
Subject: [PATCH 5/6] drm/armada: gem: Use drm_clflush_*() functions
In-Reply-To: <1428590049-20357-1-git-send-email-thierry.reding@gmail.com>
References: <1428590049-20357-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1428590049-20357-5-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Instead of going through the DMA mapping API for cache maintenance, use
the drm_clflush_*() family of functions to achieve the same effect.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/armada/Kconfig      |  1 +
 drivers/gpu/drm/armada/armada_gem.c | 13 ++-----------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/armada/Kconfig b/drivers/gpu/drm/armada/Kconfig
index 50ae88ad4d76..7b7070128a05 100644
--- a/drivers/gpu/drm/armada/Kconfig
+++ b/drivers/gpu/drm/armada/Kconfig
@@ -4,6 +4,7 @@ config DRM_ARMADA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select DRM_CACHE
 	select DRM_KMS_HELPER
 	select DRM_KMS_FB_HELPER
 	help
diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index 580e10acaa3a..c2d4414031ab 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -453,19 +453,14 @@ armada_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
 			sg_set_page(sg, page, PAGE_SIZE, 0);
 		}
 
-		if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0) {
-			num = sgt->nents;
-			goto release;
-		}
+		drm_clflush_sg(sgt);
 	} else if (dobj->page) {
 		/* Single contiguous page */
 		if (sg_alloc_table(sgt, 1, GFP_KERNEL))
 			goto free_sgt;
 
 		sg_set_page(sgt->sgl, dobj->page, dobj->obj.size, 0);
-
-		if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0)
-			goto free_table;
+		drm_clflush_sg(sgt);
 	} else if (dobj->linear) {
 		/* Single contiguous physical region - no struct page */
 		if (sg_alloc_table(sgt, 1, GFP_KERNEL))
@@ -480,7 +475,6 @@ armada_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
  release:
 	for_each_sg(sgt->sgl, sg, num, i)
 		page_cache_release(sg_page(sg));
- free_table:
 	sg_free_table(sgt);
  free_sgt:
 	kfree(sgt);
@@ -494,9 +488,6 @@ static void armada_gem_prime_unmap_dma_buf(struct dma_buf_attachment *attach,
 	struct armada_gem_object *dobj = drm_to_armada_gem(obj);
 	int i;
 
-	if (!dobj->linear)
-		dma_unmap_sg(attach->dev, sgt->sgl, sgt->nents, dir);
-
 	if (dobj->obj.filp) {
 		struct scatterlist *sg;
 		for_each_sg(sgt->sgl, sg, sgt->nents, i)
-- 
2.3.2
