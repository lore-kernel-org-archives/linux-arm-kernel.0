From: acourbot@nvidia.com (Alexandre Courbot)
Date: Fri, 27 Jun 2014 20:22:14 +0900
Subject: [PATCH v3 2/2] drm/nouveau: use DMA TT population method on ARM
In-Reply-To: <1403868134-31741-1-git-send-email-acourbot@nvidia.com>
References: <1403868134-31741-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1403868134-31741-3-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cached memory accesses between the CPU and the GPU are not coherent on
ARM. Use the DMA TTM allocator on this architecture to obtain coherent
memory.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_ttm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
index 70893416d4b6..d77fc8a5167d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
@@ -385,6 +385,8 @@ nouveau_ttm_init(struct nouveau_drm *drm)
 	if (swiotlb_nr_tbl())
 		drm->ttm.populate_method = DMA;
 #endif
+	if (IS_ENABLED(CONFIG_ARM))
+		drm->ttm.populate_method = DMA;
 #if defined(TTM_HAS_AGP)
 	if (drm->agp.stat == ENABLED)
 		drm->ttm.populate_method = AGP;
-- 
2.0.0
