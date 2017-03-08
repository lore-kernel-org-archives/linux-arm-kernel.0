From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed,  8 Mar 2017 16:30:25 +0000
Subject: [PATCH v2] drm: hdlcd: Fix the calculation of the scanout start
 address
In-Reply-To: <20170222153036.GI31595@intel.com>
References: <20170222153036.GI31595@intel.com>
Message-ID: <20170308163025.31098-1-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The calculation of the framebuffer's start address was wrongly using
the CRTC's x and y position rather than the one of the source
framebuffer. To fix that we need to update the plane_check code to
call drm_plane_helper_check_state() to clip the src and dst coordinates.
While there so some minor cleanup of redundant freeing of
devm_alloc-ated memory.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---

v1 was discussed here: https://lists.freedesktop.org/archives/dri-devel/2017-February/133379.html

 drivers/gpu/drm/arm/hdlcd_crtc.c | 47 ++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index 20ebfb4fbdfa..c65116348281 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -10,6 +10,7 @@
  */
 
 #include <drm/drmP.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
@@ -206,16 +207,33 @@ static const struct drm_crtc_helper_funcs hdlcd_crtc_helper_funcs = {
 static int hdlcd_plane_atomic_check(struct drm_plane *plane,
 				    struct drm_plane_state *state)
 {
-	u32 src_w, src_h;
+	struct drm_rect clip = { 0 };
+	struct drm_crtc_state *crtc_state;
+	u32 src_h = state->src_h >> 16;
 
-	src_w = state->src_w >> 16;
-	src_h = state->src_h >> 16;
+	/* only the HDLCD_REG_FB_LINE_COUNT register has a limit */
+	if (src_h >= HDLCD_MAX_YRES) {
+		DRM_DEBUG_KMS("Invalid source width: %d\n", src_h);
+		return -EINVAL;
+	}
+
+	if (!state->fb || !state->crtc)
+		return 0;
 
-	/* we can't do any scaling of the plane source */
-	if ((src_w != state->crtc_w) || (src_h != state->crtc_h))
+	crtc_state = drm_atomic_get_existing_crtc_state(state->state,
+							state->crtc);
+	if (!crtc_state) {
+		DRM_DEBUG_KMS("Invalid crtc state\n");
 		return -EINVAL;
+	}
 
-	return 0;
+	clip.x2 = crtc_state->adjusted_mode.hdisplay;
+	clip.y2 = crtc_state->adjusted_mode.vdisplay;
+
+	return drm_plane_helper_check_state(state, &clip,
+					    DRM_PLANE_HELPER_NO_SCALING,
+					    DRM_PLANE_HELPER_NO_SCALING,
+					    false, true);
 }
 
 static void hdlcd_plane_atomic_update(struct drm_plane *plane,
@@ -224,21 +242,20 @@ static void hdlcd_plane_atomic_update(struct drm_plane *plane,
 	struct drm_framebuffer *fb = plane->state->fb;
 	struct hdlcd_drm_private *hdlcd;
 	struct drm_gem_cma_object *gem;
-	u32 src_w, src_h, dest_w, dest_h;
+	u32 src_x, src_y, dest_h;
 	dma_addr_t scanout_start;
 
 	if (!fb)
 		return;
 
-	src_w = plane->state->src_w >> 16;
-	src_h = plane->state->src_h >> 16;
-	dest_w = plane->state->crtc_w;
-	dest_h = plane->state->crtc_h;
+	src_x = plane->state->src.x1 >> 16;
+	src_y = plane->state->src.y1 >> 16;
+	dest_h = drm_rect_height(&plane->state->dst);
 	gem = drm_fb_cma_get_gem_obj(fb, 0);
+
 	scanout_start = gem->paddr + fb->offsets[0] +
-		plane->state->crtc_y * fb->pitches[0] +
-		plane->state->crtc_x *
-		fb->format->cpp[0];
+			src_y * fb->pitches[0] +
+			src_x *	fb->format->cpp[0];
 
 	hdlcd = plane->dev->dev_private;
 	hdlcd_write(hdlcd, HDLCD_REG_FB_LINE_LENGTH, fb->pitches[0]);
@@ -285,7 +302,6 @@ static struct drm_plane *hdlcd_plane_init(struct drm_device *drm)
 				       formats, ARRAY_SIZE(formats),
 				       DRM_PLANE_TYPE_PRIMARY, NULL);
 	if (ret) {
-		devm_kfree(drm->dev, plane);
 		return ERR_PTR(ret);
 	}
 
@@ -309,7 +325,6 @@ int hdlcd_setup_crtc(struct drm_device *drm)
 					&hdlcd_crtc_funcs, NULL);
 	if (ret) {
 		hdlcd_plane_destroy(primary);
-		devm_kfree(drm->dev, primary);
 		return ret;
 	}
 
-- 
2.12.0
