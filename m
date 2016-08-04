From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 4 Aug 2016 10:59:53 +0800
Subject: [PATCH v2 3/7] drm/mediatek: Remove mtk_drm_plane
In-Reply-To: <1470279597-60453-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1470279597-60453-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1470279597-60453-4-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Kurtz <djkurtz@chromium.org>

Now that mtk_drm_plane just contains its base struct drm_plane, we can
just remove it and use struct drm_plane everywhere.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c  |   16 ++++++++--------
 drivers/gpu/drm/mediatek/mtk_drm_plane.c |   12 +++++-------
 drivers/gpu/drm/mediatek/mtk_drm_plane.h |   11 +----------
 3 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 18211ab..d6fbefa 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -31,7 +31,7 @@
  * struct mtk_drm_crtc - MediaTek specific crtc structure.
  * @base: crtc object.
  * @enabled: records whether crtc_enable succeeded
- * @planes: array of 4 mtk_drm_plane structures, one for each overlay plane
+ * @planes: array of 4 drm_plane structures, one for each overlay plane
  * @pending_planes: whether any plane has pending changes to be applied
  * @config_regs: memory mapped mmsys configuration register space
  * @mutex: handle to one of the ten disp_mutex streams
@@ -45,7 +45,7 @@ struct mtk_drm_crtc {
 	bool				pending_needs_vblank;
 	struct drm_pending_vblank_event	*event;
 
-	struct mtk_drm_plane		planes[OVL_LAYER_NR];
+	struct drm_plane		planes[OVL_LAYER_NR];
 	bool				pending_planes;
 
 	void __iomem			*config_regs;
@@ -272,7 +272,7 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
 
 	/* Initially configure all planes */
 	for (i = 0; i < OVL_LAYER_NR; i++) {
-		struct drm_plane *plane = &mtk_crtc->planes[i].base;
+		struct drm_plane *plane = &mtk_crtc->planes[i];
 		struct mtk_plane_state *plane_state;
 
 		plane_state = to_mtk_plane_state(plane->state);
@@ -351,7 +351,7 @@ static void mtk_drm_crtc_disable(struct drm_crtc *crtc)
 
 	/* Set all pending plane state to disabled */
 	for (i = 0; i < OVL_LAYER_NR; i++) {
-		struct drm_plane *plane = &mtk_crtc->planes[i].base;
+		struct drm_plane *plane = &mtk_crtc->planes[i];
 		struct mtk_plane_state *plane_state;
 
 		plane_state = to_mtk_plane_state(plane->state);
@@ -397,7 +397,7 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 	if (mtk_crtc->event)
 		mtk_crtc->pending_needs_vblank = true;
 	for (i = 0; i < OVL_LAYER_NR; i++) {
-		struct drm_plane *plane = &mtk_crtc->planes[i].base;
+		struct drm_plane *plane = &mtk_crtc->planes[i];
 		struct mtk_plane_state *plane_state;
 
 		plane_state = to_mtk_plane_state(plane->state);
@@ -471,7 +471,7 @@ void mtk_crtc_ddp_irq(struct drm_crtc *crtc, struct mtk_ddp_comp *ovl)
 
 	if (mtk_crtc->pending_planes) {
 		for (i = 0; i < OVL_LAYER_NR; i++) {
-			struct drm_plane *plane = &mtk_crtc->planes[i].base;
+			struct drm_plane *plane = &mtk_crtc->planes[i];
 			struct mtk_plane_state *plane_state;
 
 			plane_state = to_mtk_plane_state(plane->state);
@@ -564,8 +564,8 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 			goto unprepare;
 	}
 
-	ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, &mtk_crtc->planes[0].base,
-				&mtk_crtc->planes[1].base, pipe);
+	ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, &mtk_crtc->planes[0],
+				&mtk_crtc->planes[1], pipe);
 	if (ret < 0)
 		goto unprepare;
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index 32a8e55..86b7aed 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -30,10 +30,9 @@ static const u32 formats[] = {
 	DRM_FORMAT_RGB565,
 };
 
-static void mtk_plane_enable(struct mtk_drm_plane *mtk_plane,
+static void mtk_plane_enable(struct drm_plane *plane,
 			     dma_addr_t addr)
 {
-	struct drm_plane *plane = &mtk_plane->base;
 	struct mtk_plane_state *state = to_mtk_plane_state(plane->state);
 	unsigned int pitch, format;
 	bool enable;
@@ -162,14 +161,13 @@ static void mtk_plane_atomic_update(struct drm_plane *plane,
 	struct drm_crtc *crtc = state->base.crtc;
 	struct drm_gem_object *gem;
 	struct mtk_drm_gem_obj *mtk_gem;
-	struct mtk_drm_plane *mtk_plane = to_mtk_plane(plane);
 
 	if (!crtc)
 		return;
 
 	gem = mtk_fb_get_gem_obj(state->base.fb);
 	mtk_gem = to_mtk_gem_obj(gem);
-	mtk_plane_enable(mtk_plane, mtk_gem->dma_addr);
+	mtk_plane_enable(plane, mtk_gem->dma_addr);
 }
 
 static void mtk_plane_atomic_disable(struct drm_plane *plane,
@@ -188,12 +186,12 @@ static const struct drm_plane_helper_funcs mtk_plane_helper_funcs = {
 	.atomic_disable = mtk_plane_atomic_disable,
 };
 
-int mtk_plane_init(struct drm_device *dev, struct mtk_drm_plane *mtk_plane,
+int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 		   unsigned long possible_crtcs, enum drm_plane_type type)
 {
 	int err;
 
-	err = drm_universal_plane_init(dev, &mtk_plane->base, possible_crtcs,
+	err = drm_universal_plane_init(dev, plane, possible_crtcs,
 				       &mtk_plane_funcs, formats,
 				       ARRAY_SIZE(formats), type, NULL);
 	if (err) {
@@ -201,7 +199,7 @@ int mtk_plane_init(struct drm_device *dev, struct mtk_drm_plane *mtk_plane,
 		return err;
 	}
 
-	drm_plane_helper_add(&mtk_plane->base, &mtk_plane_helper_funcs);
+	drm_plane_helper_add(plane, &mtk_plane_helper_funcs);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.h b/drivers/gpu/drm/mediatek/mtk_drm_plane.h
index 74dbeda..6a20b49 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.h
@@ -18,10 +18,6 @@
 #include <drm/drm_crtc.h>
 #include <linux/types.h>
 
-struct mtk_drm_plane {
-	struct drm_plane		base;
-};
-
 struct mtk_plane_pending_state {
 	bool				config;
 	bool				enable;
@@ -40,18 +36,13 @@ struct mtk_plane_state {
 	struct mtk_plane_pending_state	pending;
 };
 
-static inline struct mtk_drm_plane *to_mtk_plane(struct drm_plane *plane)
-{
-	return container_of(plane, struct mtk_drm_plane, base);
-}
-
 static inline struct mtk_plane_state *
 to_mtk_plane_state(struct drm_plane_state *state)
 {
 	return container_of(state, struct mtk_plane_state, base);
 }
 
-int mtk_plane_init(struct drm_device *dev, struct mtk_drm_plane *mtk_plane,
+int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 		   unsigned long possible_crtcs, enum drm_plane_type type);
 
 #endif
-- 
1.7.9.5
