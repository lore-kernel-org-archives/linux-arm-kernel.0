From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Wed,  6 Dec 2017 16:26:03 +0100
Subject: [PATCH] drm/sun4i: Fix uninitialized variables in vi layer
Message-ID: <20171206152603.25937-1-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

min_scale and max_scale in sun8i_vi_layer_atomic_check() can be used
without initialization.

Fix that.

Fixes: 	b862a648de3b (drm/sun4i: Add support for HW scaling to DE2)

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index e39af8d377d0..40c3b303068a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -253,6 +253,9 @@ static int sun8i_vi_layer_atomic_check(struct drm_plane *plane,
 	clip.x2 = crtc_state->adjusted_mode.hdisplay;
 	clip.y2 = crtc_state->adjusted_mode.vdisplay;
 
+	min_scale = DRM_PLANE_HELPER_NO_SCALING;
+	max_scale = DRM_PLANE_HELPER_NO_SCALING;
+
 	if (layer->mixer->cfg->scaler_mask & BIT(layer->channel)) {
 		min_scale = SUN8I_VI_SCALER_SCALE_MIN;
 		max_scale = SUN8I_VI_SCALER_SCALE_MAX;
-- 
2.15.1
