From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 4 Aug 2016 10:59:52 +0800
Subject: [PATCH v2 2/7] drm/mediatek: plane: Remove plane zpos/index
In-Reply-To: <1470279597-60453-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1470279597-60453-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1470279597-60453-3-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Kurtz <djkurtz@chromium.org>

It is not actually useful to a mtk plane to know its zpos/index, so just
remove this field.

This let's completely remove struct mtk_drm_plane in a follow up patch.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c  |    2 +-
 drivers/gpu/drm/mediatek/mtk_drm_plane.c |    4 +---
 drivers/gpu/drm/mediatek/mtk_drm_plane.h |    4 +---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 24aa3ba..18211ab 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -559,7 +559,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 				(zpos == 1) ? DRM_PLANE_TYPE_CURSOR :
 						DRM_PLANE_TYPE_OVERLAY;
 		ret = mtk_plane_init(drm_dev, &mtk_crtc->planes[zpos],
-				     BIT(pipe), type, zpos);
+				     BIT(pipe), type);
 		if (ret)
 			goto unprepare;
 	}
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index 5f2516f..32a8e55 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -189,8 +189,7 @@ static const struct drm_plane_helper_funcs mtk_plane_helper_funcs = {
 };
 
 int mtk_plane_init(struct drm_device *dev, struct mtk_drm_plane *mtk_plane,
-		   unsigned long possible_crtcs, enum drm_plane_type type,
-		   unsigned int zpos)
+		   unsigned long possible_crtcs, enum drm_plane_type type)
 {
 	int err;
 
@@ -203,7 +202,6 @@ int mtk_plane_init(struct drm_device *dev, struct mtk_drm_plane *mtk_plane,
 	}
 
 	drm_plane_helper_add(&mtk_plane->base, &mtk_plane_helper_funcs);
-	mtk_plane->idx = zpos;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.h b/drivers/gpu/drm/mediatek/mtk_drm_plane.h
index 72a7b3e..74dbeda 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.h
@@ -20,7 +20,6 @@
 
 struct mtk_drm_plane {
 	struct drm_plane		base;
-	unsigned int			idx;
 };
 
 struct mtk_plane_pending_state {
@@ -53,7 +52,6 @@ to_mtk_plane_state(struct drm_plane_state *state)
 }
 
 int mtk_plane_init(struct drm_device *dev, struct mtk_drm_plane *mtk_plane,
-		   unsigned long possible_crtcs, enum drm_plane_type type,
-		   unsigned int zpos);
+		   unsigned long possible_crtcs, enum drm_plane_type type);
 
 #endif
-- 
1.7.9.5
