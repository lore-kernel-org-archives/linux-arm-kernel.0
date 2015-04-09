From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu,  9 Apr 2015 16:34:07 +0200
Subject: [PATCH 4/6] drm/tegra: gem: Use drm_clflush_*() functions
In-Reply-To: <1428590049-20357-1-git-send-email-thierry.reding@gmail.com>
References: <1428590049-20357-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1428590049-20357-4-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Instead of going through the DMA mapping API for cache maintenance, use
the drm_clflush_*() family of functions to achieve the same effect.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/tegra/Kconfig |  1 +
 drivers/gpu/drm/tegra/gem.c   | 42 +++++++++++-------------------------------
 2 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
index 74d9d621453d..4901f20f99a1 100644
--- a/drivers/gpu/drm/tegra/Kconfig
+++ b/drivers/gpu/drm/tegra/Kconfig
@@ -4,6 +4,7 @@ config DRM_TEGRA
 	depends on COMMON_CLK
 	depends on DRM
 	depends on RESET_CONTROLLER
+	select DRM_CACHE
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL
diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index 499f86739786..11e97a46e63d 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -203,48 +203,28 @@ static void tegra_bo_free(struct drm_device *drm, struct tegra_bo *bo)
 
 static int tegra_bo_get_pages(struct drm_device *drm, struct tegra_bo *bo)
 {
-	struct scatterlist *s;
-	struct sg_table *sgt;
-	unsigned int i;
-
 	bo->pages = drm_gem_get_pages(&bo->gem);
 	if (IS_ERR(bo->pages))
 		return PTR_ERR(bo->pages);
 
 	bo->num_pages = bo->gem.size >> PAGE_SHIFT;
 
-	sgt = drm_prime_pages_to_sg(bo->pages, bo->num_pages);
-	if (IS_ERR(sgt))
-		goto put_pages;
+	bo->sgt = drm_prime_pages_to_sg(bo->pages, bo->num_pages);
+	if (IS_ERR(bo->sgt)) {
+		drm_gem_put_pages(&bo->gem, bo->pages, false, false);
+		return PTR_ERR(bo->sgt);
+	}
 
-#ifndef CONFIG_ARM64
 	/*
-	 * Fake up the SG table so that dma_map_sg() can be used to flush the
-	 * pages associated with it. Note that this relies on the fact that
-	 * the DMA API doesn't hook into IOMMU on Tegra, therefore mapping is
-	 * only cache maintenance.
-	 *
-	 * TODO: Replace this by drm_clflash_sg() once it can be implemented
-	 * without relying on symbols that are not exported.
+	 * Pages allocated by shmemfs are marked dirty but not flushed on
+	 * ARMv7 and ARMv8. Since this memory is used to back framebuffers,
+	 * however, they must be forced out of caches to avoid corruption
+	 * on screen later on as the result of dirty cache-lines being
+	 * flushed.
 	 */
-	for_each_sg(sgt->sgl, s, sgt->nents, i)
-		sg_dma_address(s) = sg_phys(s);
-
-	if (dma_map_sg(drm->dev, sgt->sgl, sgt->nents, DMA_TO_DEVICE) == 0)
-		goto release_sgt;
-#endif
-
-	bo->sgt = sgt;
+	drm_clflush_sg(bo->sgt);
 
 	return 0;
-
-release_sgt:
-	sg_free_table(sgt);
-	kfree(sgt);
-	sgt = ERR_PTR(-ENOMEM);
-put_pages:
-	drm_gem_put_pages(&bo->gem, bo->pages, false, false);
-	return PTR_ERR(sgt);
 }
 
 static int tegra_bo_alloc(struct drm_device *drm, struct tegra_bo *bo)
-- 
2.3.2
