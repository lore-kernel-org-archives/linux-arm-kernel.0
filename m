From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Oct 2016 10:29:36 +0200
Subject: [PATCH 3/5] drm/sun4i: Add custom crtc state
In-Reply-To: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
References: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
Message-ID: <3767617c131ac19912e30c9c0ea567ea73f54692.1476779323.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We'll need a custom CRTC state to deal with the overscan setup.

We'll store in it the actual display size that can be used by the
applications, and the size to use on the plane.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 18 +++++++++-----
 drivers/gpu/drm/sun4i/sun4i_crtc.c    | 37 ++++++++++++++++++++++++++--
 drivers/gpu/drm/sun4i/sun4i_crtc.h    | 16 ++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_rgb.c     | 10 ++++++++-
 drivers/gpu/drm/sun4i/sun4i_tv.c      | 14 +++++++++++-
 5 files changed, 87 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 32c0584e3c35..9b36b7104c15 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -22,6 +22,7 @@
 #include <linux/reset.h>
 
 #include "sun4i_backend.h"
+#include "sun4i_crtc.h"
 #include "sun4i_drv.h"
 
 static u32 sunxi_rgb2yuv_coef[12] = {
@@ -115,15 +116,19 @@ int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
+	struct sun4i_crtc_state *s_state = drm_crtc_state_to_sun4i_crtc_state(state->crtc->state);
+	u16 x, y;
+
 
 	DRM_DEBUG_DRIVER("Updating layer %d\n", layer);
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
 		DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: %u\n",
-				 state->crtc_w, state->crtc_h);
+				 s_state->display_x_size,
+				 s_state->display_y_size);
 		regmap_write(backend->regs, SUN4I_BACKEND_DISSIZE_REG,
-			     SUN4I_BACKEND_DISSIZE(state->crtc_w,
-						   state->crtc_h));
+			     SUN4I_BACKEND_DISSIZE(s_state->display_x_size,
+						   s_state->display_y_size));
 	}
 
 	/* Set the line width */
@@ -139,11 +144,12 @@ int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
 					   state->crtc_h));
 
 	/* Set base coordinates */
+	x = s_state->plane_x_offset + state->crtc_x;
+	y = s_state->plane_y_offset + state->crtc_y;
 	DRM_DEBUG_DRIVER("Layer coordinates X: %d Y: %d\n",
-			 state->crtc_x, state->crtc_y);
+			 x, y);
 	regmap_write(backend->regs, SUN4I_BACKEND_LAYCOOR_REG(layer),
-		     SUN4I_BACKEND_LAYCOOR(state->crtc_x,
-					   state->crtc_y));
+		     SUN4I_BACKEND_LAYCOOR(x, y));
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index 4a192210574f..772e0ecd72db 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -104,9 +104,42 @@ static const struct drm_crtc_helper_funcs sun4i_crtc_helper_funcs = {
 	.enable		= sun4i_crtc_enable,
 };
 
+struct drm_crtc_state *sun4i_crtc_duplicate_state(struct drm_crtc *crtc)
+{
+	struct sun4i_crtc_state *state = drm_crtc_state_to_sun4i_crtc_state(crtc->state);
+	struct sun4i_crtc_state *copy;
+
+	copy = kmalloc(sizeof(*copy), GFP_KERNEL);
+	if (!copy)
+		return NULL;
+
+	DRM_DEBUG_DRIVER("Copying state %p to %p", state, copy);
+
+	__drm_atomic_helper_crtc_duplicate_state(crtc, &copy->base);
+
+	copy->display_x_size = state->display_x_size;
+	copy->display_y_size = state->display_y_size;
+
+	copy->plane_x_offset = state->plane_x_offset;
+	copy->plane_y_offset = state->plane_y_offset;
+
+	return &copy->base;
+}
+
+void sun4i_crtc_destroy_state(struct drm_crtc *crtc,
+			      struct drm_crtc_state *c_state)
+{
+	struct sun4i_crtc_state *s_state = drm_crtc_state_to_sun4i_crtc_state(c_state);
+
+	DRM_DEBUG_DRIVER("Freeing state %p", s_state);
+
+	__drm_atomic_helper_crtc_destroy_state(c_state);
+	kfree(s_state);
+}
+
 static const struct drm_crtc_funcs sun4i_crtc_funcs = {
-	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
-	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= sun4i_crtc_destroy_state,
+	.atomic_duplicate_state	= sun4i_crtc_duplicate_state,
 	.destroy		= drm_crtc_cleanup,
 	.page_flip		= drm_atomic_helper_page_flip,
 	.reset			= drm_atomic_helper_crtc_reset,
diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.h b/drivers/gpu/drm/sun4i/sun4i_crtc.h
index dec8ce4d9b25..625c9ac41434 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.h
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.h
@@ -20,11 +20,27 @@ struct sun4i_crtc {
 	struct sun4i_drv		*drv;
 };
 
+struct sun4i_crtc_state {
+	struct drm_crtc_state	base;
+
+	u32			display_x_size;
+	u32			display_y_size;
+
+	u32			plane_x_offset;
+	u32			plane_y_offset;
+};
+
 static inline struct sun4i_crtc *drm_crtc_to_sun4i_crtc(struct drm_crtc *crtc)
 {
 	return container_of(crtc, struct sun4i_crtc, crtc);
 }
 
+static inline struct sun4i_crtc_state *
+drm_crtc_state_to_sun4i_crtc_state(struct drm_crtc_state *state)
+{
+	return container_of(state, struct sun4i_crtc_state, base);
+}
+
 struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm);
 
 #endif /* _SUN4I_CRTC_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index c3ff10f559cc..b1f792ad84c2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -17,6 +17,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_panel.h>
 
+#include "sun4i_crtc.h"
 #include "sun4i_drv.h"
 #include "sun4i_tcon.h"
 #include "sun4i_rgb.h"
@@ -141,6 +142,15 @@ static int sun4i_rgb_atomic_check(struct drm_encoder *encoder,
 				  struct drm_crtc_state *crtc_state,
 				  struct drm_connector_state *conn_state)
 {
+	struct drm_display_mode *mode = &crtc_state->mode;
+	struct sun4i_crtc_state *state = drm_crtc_state_to_sun4i_crtc_state(crtc_state);
+
+	state->display_x_size = mode->hdisplay;
+	state->display_y_size = mode->vdisplay;
+
+	state->plane_x_offset = 0;
+	state->plane_y_offset = 0;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index 1dd3d9eabf2e..6f8077013be3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -22,6 +22,7 @@
 #include <drm/drm_panel.h>
 
 #include "sun4i_backend.h"
+#include "sun4i_crtc.h"
 #include "sun4i_drv.h"
 #include "sun4i_tcon.h"
 
@@ -343,6 +344,19 @@ static int sun4i_tv_atomic_check(struct drm_encoder *encoder,
 				 struct drm_crtc_state *crtc_state,
 				 struct drm_connector_state *conn_state)
 {
+	struct drm_display_mode *mode = &crtc_state->mode;
+	const struct tv_mode *tv_mode = sun4i_tv_find_tv_by_mode(mode);
+	struct sun4i_crtc_state *state = drm_crtc_state_to_sun4i_crtc_state(crtc_state);
+
+	if (!tv_mode)
+		return -EINVAL;
+
+	state->display_x_size = tv_mode->hdisplay;
+	state->plane_x_offset = 0;
+
+	state->display_y_size = tv_mode->vdisplay;
+	state->plane_y_offset = 0;
+
 	return 0;
 }
 
-- 
git-series 0.8.10
