From: gurchetansingh@chromium.org (Gurchetan Singh)
Date: Tue, 23 Jan 2018 18:56:06 -0800
Subject: [PATCH 5/5] drm: use drm_flush_sg where possible
In-Reply-To: <20180124025606.3020-2-gurchetansingh@chromium.org>
References: <20180124025606.3020-2-gurchetansingh@chromium.org>
Message-ID: <20180124025606.3020-5-gurchetansingh@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should use our common cache maintenance functions when possible.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 7 ++-----
 drivers/gpu/drm/tegra/gem.c                 | 7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 8ac7eb25e46d..0652c2f79719 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -14,6 +14,7 @@
 
 #include <drm/drm.h>
 #include <drm/drmP.h>
+#include <drm/drm_cache.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_vma_manager.h>
 #include <linux/iommu.h>
@@ -99,15 +100,11 @@ static int rockchip_gem_get_pages(struct rockchip_gem_object *rk_obj)
 	/*
 	 * Fake up the SG table so that dma_sync_sg_for_device() can be used
 	 * to flush the pages associated with it.
-	 *
-	 * TODO: Replace this by drm_flush_sg() once it can be implemented
-	 * without relying on symbols that are not exported.
 	 */
 	for_each_sg(rk_obj->sgt->sgl, s, rk_obj->sgt->nents, i)
 		sg_dma_address(s) = sg_phys(s);
 
-	dma_sync_sg_for_device(drm->dev, rk_obj->sgt->sgl, rk_obj->sgt->nents,
-			       DMA_TO_DEVICE);
+	drm_flush_sg(rk_obj->sgt);
 
 	return 0;
 
diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index 49b9bf28f872..0db403653adc 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -15,6 +15,7 @@
 
 #include <linux/dma-buf.h>
 #include <linux/iommu.h>
+#include <drm/drm_cache.h>
 #include <drm/tegra_drm.h>
 
 #include "drm.h"
@@ -229,15 +230,11 @@ static int tegra_bo_get_pages(struct drm_device *drm, struct tegra_bo *bo)
 	/*
 	 * Fake up the SG table so that dma_sync_sg_for_device() can be used
 	 * to flush the pages associated with it.
-	 *
-	 * TODO: Replace this by drm_clflash_sg() once it can be implemented
-	 * without relying on symbols that are not exported.
 	 */
 	for_each_sg(bo->sgt->sgl, s, bo->sgt->nents, i)
 		sg_dma_address(s) = sg_phys(s);
 
-	dma_sync_sg_for_device(drm->dev, bo->sgt->sgl, bo->sgt->nents,
-			       DMA_TO_DEVICE);
+	drm_flush_sg(bo->sgt);
 
 	return 0;
 
-- 
2.13.5
