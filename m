From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:34 +0100
Subject: [PATCH v2 11/27] drm/sun4i: Add constraints checking to DE2 driver
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171201060550.10392-12-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since current DE2 driver doesn't know how to scale yet, add atomic check
function which checks that.

Nice side effect of that function is that populates clipped coordinates
and checks visibility of the plane. That data will be used in the
future.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_layer.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_layer.c b/drivers/gpu/drm/sun4i/sun8i_layer.c
index 5aa6e2c9728e..40e6b83aef3b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_layer.c
@@ -13,7 +13,9 @@
  * the License, or (at your option) any later version.
  */
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drmP.h>
 
@@ -26,6 +28,31 @@ struct sun8i_plane_desc {
 	       uint32_t                nformats;
 };
 
+static int sun8i_mixer_layer_atomic_check(struct drm_plane *plane,
+					  struct drm_plane_state *state)
+{
+	struct drm_crtc *crtc = state->crtc;
+	struct drm_crtc_state *crtc_state;
+	struct drm_rect clip;
+
+	if (!crtc)
+		return 0;
+
+	crtc_state = drm_atomic_get_existing_crtc_state(state->state, crtc);
+	if (WARN_ON(!crtc_state))
+		return -EINVAL;
+
+	clip.x1 = 0;
+	clip.y1 = 0;
+	clip.x2 = crtc_state->adjusted_mode.hdisplay;
+	clip.y2 = crtc_state->adjusted_mode.vdisplay;
+
+	return drm_plane_helper_check_state(state, &clip,
+					    DRM_PLANE_HELPER_NO_SCALING,
+					    DRM_PLANE_HELPER_NO_SCALING,
+					    true, true);
+}
+
 static void sun8i_mixer_layer_atomic_disable(struct drm_plane *plane,
 					       struct drm_plane_state *old_state)
 {
@@ -53,6 +80,7 @@ static void sun8i_mixer_layer_atomic_update(struct drm_plane *plane,
 }
 
 static struct drm_plane_helper_funcs sun8i_mixer_layer_helper_funcs = {
+	.atomic_check	= sun8i_mixer_layer_atomic_check,
 	.atomic_disable	= sun8i_mixer_layer_atomic_disable,
 	.atomic_update	= sun8i_mixer_layer_atomic_update,
 };
-- 
2.15.1
