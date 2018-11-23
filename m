From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:39 +0100
Subject: [PATCH v2 07/43] drm/sun4i: backend: Use a specific function to check
 if a plane is supported
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-8-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before this patch, it is assumed that a plane is supported either
through the frontend or through the backend alone. However, the DRM
interface does not allow finely reporting our hardware capabilities
and there are cases where neither are support.

In particular, some plane formats are supported by the backend and not
the frontend, so they can only be supported without scaling.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 735fea7ead0b..52caf561da0e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -477,6 +477,23 @@ static bool sun4i_backend_plane_uses_frontend(struct drm_plane_state *state)
 	return false;
 }
 
+static bool sun4i_backend_plane_is_supported(struct drm_plane_state *state,
+					     bool *uses_frontend)
+{
+	if (sun4i_backend_plane_uses_frontend(state)) {
+		*uses_frontend = true;
+		return true;
+	}
+
+	*uses_frontend = false;
+
+	/* Scaling is not supported without the frontend. */
+	if (sun4i_backend_plane_uses_scaler(state))
+		return false;
+
+	return true;
+}
+
 static void sun4i_backend_atomic_begin(struct sunxi_engine *engine,
 				       struct drm_crtc_state *old_state)
 {
@@ -517,14 +534,14 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		struct drm_framebuffer *fb = plane_state->fb;
 		struct drm_format_name_buf format_name;
 
-		if (sun4i_backend_plane_uses_frontend(plane_state)) {
+		if (!sun4i_backend_plane_is_supported(plane_state,
+						      &layer_state->uses_frontend))
+			return -EINVAL;
+
+		if (layer_state->uses_frontend) {
 			DRM_DEBUG_DRIVER("Using the frontend for plane %d\n",
 					 plane->index);
-
-			layer_state->uses_frontend = true;
 			num_frontend_planes++;
-		} else {
-			layer_state->uses_frontend = false;
 		}
 
 		DRM_DEBUG_DRIVER("Plane FB format is %s\n",
-- 
2.19.1
