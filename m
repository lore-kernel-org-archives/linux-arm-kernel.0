From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:32 +0100
Subject: [PATCH v2 09/27] drm/sun4i: Rework enabling plane in DE2 driver
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171201060550.10392-10-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we want to support multiple planes in the future, code which enables
pipe has to be moved to appropriate place and it must depend on channel
id instead of being hardcoded.

Side effect of that rework is definition of default Z position. For now,
put first channel at the bottom, second above it and so on.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index c7d4ccd605e0..015943c0ed5a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -55,6 +55,15 @@ void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
+
+	if (enable)
+		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(chan);
+	else
+		val = 0;
+
+	regmap_update_bits(mixer->engine.regs,
+			   SUN8I_MIXER_BLEND_PIPE_CTL,
+			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(chan), val);
 }
 
 static int sun8i_mixer_drm_format_to_layer(struct drm_plane *plane,
@@ -98,7 +107,7 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
 					      state->crtc_h));
 		DRM_DEBUG_DRIVER("Updating blender size\n");
 		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_BLEND_ATTR_INSIZE(0),
+			     SUN8I_MIXER_BLEND_ATTR_INSIZE(chan),
 			     SUN8I_MIXER_SIZE(state->crtc_w,
 					      state->crtc_h));
 		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_OUTSIZE,
@@ -322,20 +331,17 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_BKCOLOR,
 		     SUN8I_MIXER_BLEND_COLOR_BLACK);
 
-	/* Initialize blender */
+	/*
+	 * Set fill color of bottom plane to black. Generally not needed
+	 * except when VI plane is at bottom (zpos = 0) and enabled.
+	 */
 	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL,
-		     SUN8I_MIXER_BLEND_PIPE_CTL_EN(0) |
 		     SUN8I_MIXER_BLEND_PIPE_CTL_FC_EN(0));
-
-	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_FCOLOR(0),
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ATTR_FCOLOR(0),
 		     SUN8I_MIXER_BLEND_COLOR_BLACK);
 
-	/* Select the first UI channel */
-	DRM_DEBUG_DRIVER("Selecting channel %d (first UI channel)\n",
-			 mixer->cfg->vi_num);
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ROUTE,
-		     mixer->cfg->vi_num);
+	/* Fixed zpos for now */
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ROUTE, 0x43210);
 
 	plane_cnt = mixer->cfg->vi_num + mixer->cfg->ui_num;
 	for (i = 0; i < plane_cnt; i++)
-- 
2.15.1
