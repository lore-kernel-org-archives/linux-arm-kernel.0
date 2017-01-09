From: shawnguo@kernel.org (Shawn Guo)
Date: Mon,  9 Jan 2017 22:35:42 +0800
Subject: [PATCH v4 1/3] drm: zte: make zx_plane accessible from zx_vou driver
In-Reply-To: <1483972544-12731-1-git-send-email-shawnguo@kernel.org>
References: <1483972544-12731-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1483972544-12731-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Move struct zx_plane from zx_plane.c to zx_plane.h, so that it can be
accessed from zx_vou driver, and we can save the use of struct
zx_layer_data completely.  More importantly, those additional data used
by VOU controller to enable/disable graphic and video layers can later
be added and accessed much more easily from zx_vou driver.

While at it, we make two changes to zx_plane_init() interface:

 - Encode struct device pointer in zx_plane, so that we do not need to
   pass it as a parameter.
 - Change return of zx_plane_init() from struct drm_plane pointer to
   error code, since we can get the pointer from zx_plane in zx_vou
   driver now.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/zte/zx_plane.c | 36 +++++++-----------------------------
 drivers/gpu/drm/zte/zx_plane.h | 11 +++++++----
 drivers/gpu/drm/zte/zx_vou.c   | 31 +++++++++++++++++++------------
 3 files changed, 33 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/zte/zx_plane.c b/drivers/gpu/drm/zte/zx_plane.c
index 546eb92a94e8..78d29b1db91c 100644
--- a/drivers/gpu/drm/zte/zx_plane.c
+++ b/drivers/gpu/drm/zte/zx_plane.c
@@ -21,16 +21,6 @@
 #include "zx_plane_regs.h"
 #include "zx_vou.h"
 
-struct zx_plane {
-	struct drm_plane plane;
-	void __iomem *layer;
-	void __iomem *csc;
-	void __iomem *hbsc;
-	void __iomem *rsz;
-};
-
-#define to_zx_plane(plane)	container_of(plane, struct zx_plane, plane)
-
 static const uint32_t gl_formats[] = {
 	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XRGB8888,
@@ -248,28 +238,16 @@ static void zx_plane_hbsc_init(struct zx_plane *zplane)
 	zx_writel(hbsc + HBSC_THRESHOLD_COL3, (0x3c0 << 16) | 0x40);
 }
 
-struct drm_plane *zx_plane_init(struct drm_device *drm, struct device *dev,
-				struct zx_layer_data *data,
-				enum drm_plane_type type)
+int zx_plane_init(struct drm_device *drm, struct zx_plane *zplane,
+		  enum drm_plane_type type)
 {
 	const struct drm_plane_helper_funcs *helper;
-	struct zx_plane *zplane;
-	struct drm_plane *plane;
+	struct drm_plane *plane = &zplane->plane;
+	struct device *dev = zplane->dev;
 	const uint32_t *formats;
 	unsigned int format_count;
 	int ret;
 
-	zplane = devm_kzalloc(dev, sizeof(*zplane), GFP_KERNEL);
-	if (!zplane)
-		return ERR_PTR(-ENOMEM);
-
-	plane = &zplane->plane;
-
-	zplane->layer = data->layer;
-	zplane->hbsc = data->hbsc;
-	zplane->csc = data->csc;
-	zplane->rsz = data->rsz;
-
 	zx_plane_hbsc_init(zplane);
 
 	switch (type) {
@@ -282,7 +260,7 @@ struct drm_plane *zx_plane_init(struct drm_device *drm, struct device *dev,
 		/* TODO: add video layer (vl) support */
 		break;
 	default:
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 	}
 
 	ret = drm_universal_plane_init(drm, plane, VOU_CRTC_MASK,
@@ -290,10 +268,10 @@ struct drm_plane *zx_plane_init(struct drm_device *drm, struct device *dev,
 				       type, NULL);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to init universal plane: %d\n", ret);
-		return ERR_PTR(ret);
+		return ret;
 	}
 
 	drm_plane_helper_add(plane, helper);
 
-	return plane;
+	return 0;
 }
diff --git a/drivers/gpu/drm/zte/zx_plane.h b/drivers/gpu/drm/zte/zx_plane.h
index 2b82cd558d9d..264a92e0b532 100644
--- a/drivers/gpu/drm/zte/zx_plane.h
+++ b/drivers/gpu/drm/zte/zx_plane.h
@@ -11,16 +11,19 @@
 #ifndef __ZX_PLANE_H__
 #define __ZX_PLANE_H__
 
-struct zx_layer_data {
+struct zx_plane {
+	struct drm_plane plane;
+	struct device *dev;
 	void __iomem *layer;
 	void __iomem *csc;
 	void __iomem *hbsc;
 	void __iomem *rsz;
 };
 
-struct drm_plane *zx_plane_init(struct drm_device *drm, struct device *dev,
-				struct zx_layer_data *data,
-				enum drm_plane_type type);
+#define to_zx_plane(plane) container_of(plane, struct zx_plane, plane)
+
+int zx_plane_init(struct drm_device *drm, struct zx_plane *zplane,
+		  enum drm_plane_type type);
 void zx_plane_set_update(struct drm_plane *plane);
 
 #endif /* __ZX_PLANE_H__ */
diff --git a/drivers/gpu/drm/zte/zx_vou.c b/drivers/gpu/drm/zte/zx_vou.c
index 73fe15c17c32..d5c801f6f97b 100644
--- a/drivers/gpu/drm/zte/zx_vou.c
+++ b/drivers/gpu/drm/zte/zx_vou.c
@@ -294,7 +294,7 @@ static int zx_crtc_init(struct drm_device *drm, struct zx_vou_hw *vou,
 			enum vou_chn_type chn_type)
 {
 	struct device *dev = vou->dev;
-	struct zx_layer_data data;
+	struct zx_plane *zplane;
 	struct zx_crtc *zcrtc;
 	int ret;
 
@@ -305,19 +305,25 @@ static int zx_crtc_init(struct drm_device *drm, struct zx_vou_hw *vou,
 	zcrtc->vou = vou;
 	zcrtc->chn_type = chn_type;
 
+	zplane = devm_kzalloc(dev, sizeof(*zplane), GFP_KERNEL);
+	if (!zplane)
+		return -ENOMEM;
+
+	zplane->dev = dev;
+
 	if (chn_type == VOU_CHN_MAIN) {
-		data.layer = vou->osd + MAIN_GL_OFFSET;
-		data.csc = vou->osd + MAIN_CSC_OFFSET;
-		data.hbsc = vou->osd + MAIN_HBSC_OFFSET;
-		data.rsz = vou->otfppu + MAIN_RSZ_OFFSET;
+		zplane->layer = vou->osd + MAIN_GL_OFFSET;
+		zplane->csc = vou->osd + MAIN_CSC_OFFSET;
+		zplane->hbsc = vou->osd + MAIN_HBSC_OFFSET;
+		zplane->rsz = vou->otfppu + MAIN_RSZ_OFFSET;
 		zcrtc->chnreg = vou->osd + OSD_MAIN_CHN;
 		zcrtc->regs = &main_crtc_regs;
 		zcrtc->bits = &main_crtc_bits;
 	} else {
-		data.layer = vou->osd + AUX_GL_OFFSET;
-		data.csc = vou->osd + AUX_CSC_OFFSET;
-		data.hbsc = vou->osd + AUX_HBSC_OFFSET;
-		data.rsz = vou->otfppu + AUX_RSZ_OFFSET;
+		zplane->layer = vou->osd + AUX_GL_OFFSET;
+		zplane->csc = vou->osd + AUX_CSC_OFFSET;
+		zplane->hbsc = vou->osd + AUX_HBSC_OFFSET;
+		zplane->rsz = vou->otfppu + AUX_RSZ_OFFSET;
 		zcrtc->chnreg = vou->osd + OSD_AUX_CHN;
 		zcrtc->regs = &aux_crtc_regs;
 		zcrtc->bits = &aux_crtc_bits;
@@ -331,13 +337,14 @@ static int zx_crtc_init(struct drm_device *drm, struct zx_vou_hw *vou,
 		return ret;
 	}
 
-	zcrtc->primary = zx_plane_init(drm, dev, &data, DRM_PLANE_TYPE_PRIMARY);
-	if (IS_ERR(zcrtc->primary)) {
-		ret = PTR_ERR(zcrtc->primary);
+	ret = zx_plane_init(drm, zplane, DRM_PLANE_TYPE_PRIMARY);
+	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to init primary plane: %d\n", ret);
 		return ret;
 	}
 
+	zcrtc->primary = &zplane->plane;
+
 	ret = drm_crtc_init_with_planes(drm, &zcrtc->crtc, zcrtc->primary, NULL,
 					&zx_crtc_funcs, NULL);
 	if (ret) {
-- 
1.9.1
