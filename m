From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:57 +0100
Subject: [PATCH v2 25/43] drm/sun4i: frontend: Apply format sub-sampling to
 CH1 dimensions
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-26-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The frontend comes with two "channels", that can be configured
independently. When used in YUV mode, the first channel (CH0) represents
the luminance component while the second channel (CH1) represents the
chrominance. In RGB mode, both have to be configured the same way.

Use variables (with the YUV terminology) for each channel's
dimensions, calculating the chroma dimensions from the luma dimensions
and the sub-sampling factors from the format description.

Since the configured size only has pixel precision, the fractional
fixed-point part of the source size is dropped for both components to
ensure that the scaling factors are accurate.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 5626334c6e87..4700133b96e0 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -276,16 +276,24 @@ void sun4i_frontend_update_coord(struct sun4i_frontend *frontend,
 				 struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
+	struct drm_framebuffer *fb = state->fb;
+	uint32_t luma_width, luma_height;
+	uint32_t chroma_width, chroma_height;
 
 	/* Set height and width */
 	DRM_DEBUG_DRIVER("Frontend size W: %u H: %u\n",
 			 state->crtc_w, state->crtc_h);
+
+	luma_width = state->src_w >> 16;
+	luma_height = state->src_h >> 16;
+
+	chroma_width = DIV_ROUND_UP(luma_width, fb->format->hsub);
+	chroma_height = DIV_ROUND_UP(luma_height, fb->format->vsub);
+
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_INSIZE_REG,
-		     SUN4I_FRONTEND_INSIZE(state->src_h >> 16,
-					   state->src_w >> 16));
+		     SUN4I_FRONTEND_INSIZE(luma_height, luma_width));
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_INSIZE_REG,
-		     SUN4I_FRONTEND_INSIZE(state->src_h >> 16,
-					   state->src_w >> 16));
+		     SUN4I_FRONTEND_INSIZE(chroma_height, chroma_width));
 
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_OUTSIZE_REG,
 		     SUN4I_FRONTEND_OUTSIZE(state->crtc_h, state->crtc_w));
@@ -293,14 +301,14 @@ void sun4i_frontend_update_coord(struct sun4i_frontend *frontend,
 		     SUN4I_FRONTEND_OUTSIZE(state->crtc_h, state->crtc_w));
 
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_HORZFACT_REG,
-		     state->src_w / state->crtc_w);
+		     (luma_width << 16) / state->crtc_w);
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_HORZFACT_REG,
-		     state->src_w / state->crtc_w);
+		     (chroma_width << 16) / state->crtc_w);
 
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTFACT_REG,
-		     state->src_h / state->crtc_h);
+		     (luma_height << 16) / state->crtc_h);
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTFACT_REG,
-		     state->src_h / state->crtc_h);
+		     (chroma_height << 16) / state->crtc_h);
 
 	regmap_write_bits(frontend->regs, SUN4I_FRONTEND_FRM_CTRL_REG,
 			  SUN4I_FRONTEND_FRM_CTRL_REG_RDY,
-- 
2.19.1
