From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu,  9 Apr 2015 16:34:09 +0200
Subject: [PATCH 6/6] drm/msm: gem: Use drm_clflush_*() functions
In-Reply-To: <1428590049-20357-1-git-send-email-thierry.reding@gmail.com>
References: <1428590049-20357-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1428590049-20357-6-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Instead of going through the DMA mapping API for cache maintenance, use
the drm_clflush_*() family of functions to achieve the same effect.

Cc: Rob Clark <robdclark@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/msm/Kconfig   | 1 +
 drivers/gpu/drm/msm/msm_gem.c | 9 +--------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 0a6f6764a37c..5da7fe793e89 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -5,6 +5,7 @@ config DRM_MSM
 	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
 	depends on OF && COMMON_CLK
 	select REGULATOR
+	select DRM_CACHE
 	select DRM_KMS_HELPER
 	select DRM_PANEL
 	select SHMEM
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 52839769eb6c..ce265085fc57 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -101,8 +101,7 @@ static struct page **get_pages(struct drm_gem_object *obj)
 		 * because display controller, GPU, etc. are not coherent:
 		 */
 		if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
-			dma_map_sg(dev->dev, msm_obj->sgt->sgl,
-					msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
+			drm_clflush_sg(msm_obj->sgt);
 	}
 
 	return msm_obj->pages;
@@ -113,12 +112,6 @@ static void put_pages(struct drm_gem_object *obj)
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
 	if (msm_obj->pages) {
-		/* For non-cached buffers, ensure the new pages are clean
-		 * because display controller, GPU, etc. are not coherent:
-		 */
-		if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
-			dma_unmap_sg(obj->dev->dev, msm_obj->sgt->sgl,
-					msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
 		sg_free_table(msm_obj->sgt);
 		kfree(msm_obj->sgt);
 
-- 
2.3.2
