From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  9 Jan 2018 11:09:14 +0100
Subject: [PATCH v3 01/13] drm/sun4i: backend: Move line stride setup to buffer
 setup function
In-Reply-To: <cover.8538fc1191390239557a21e2b0444c81eef1c581.1515492513.git-series.maxime.ripard@free-electrons.com>
References: <cover.8538fc1191390239557a21e2b0444c81eef1c581.1515492513.git-series.maxime.ripard@free-electrons.com>
Message-ID: <cbec84125bc0d5a6cf1d856b8291fbf77b138881.1515492513.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setup the line stride in the buffer setup function, since it's tied to the
buffer itself, and is not needed when we do not set the buffer in the
backend.

This is for example the case when using the frontend and then routing its
output to the backend.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 847eecbe4d14..c99d1a7e815a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -141,7 +141,6 @@ int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
 				     int layer, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
-	struct drm_framebuffer *fb = state->fb;
 
 	DRM_DEBUG_DRIVER("Updating layer %d\n", layer);
 
@@ -153,12 +152,6 @@ int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
 						   state->crtc_h));
 	}
 
-	/* Set the line width */
-	DRM_DEBUG_DRIVER("Layer line width: %d bits\n", fb->pitches[0] * 8);
-	regmap_write(backend->engine.regs,
-		     SUN4I_BACKEND_LAYLINEWIDTH_REG(layer),
-		     fb->pitches[0] * 8);
-
 	/* Set height and width */
 	DRM_DEBUG_DRIVER("Layer size W: %u H: %u\n",
 			 state->crtc_w, state->crtc_h);
@@ -218,6 +211,13 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 	u32 lo_paddr, hi_paddr;
 	dma_addr_t paddr;
 
+	/* Set the line width */
+	DRM_DEBUG_DRIVER("Layer line width: %d bits\n", fb->pitches[0] * 8);
+	regmap_write(backend->engine.regs,
+		     SUN4I_BACKEND_LAYLINEWIDTH_REG(layer),
+		     fb->pitches[0] * 8);
+
+
 	/* Get the start of the displayed memory */
 	paddr = drm_fb_cma_get_gem_addr(fb, state, 0);
 	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
-- 
git-series 0.9.1
