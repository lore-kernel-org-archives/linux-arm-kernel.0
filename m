From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Mon, 27 Nov 2017 21:57:50 +0100
Subject: [PATCH 17/17] [DO NOT MERGE]drm/sun4i: Change zpos of bottom VI plane
In-Reply-To: <20171127205750.19277-1-jernej.skrabec@siol.net>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
Message-ID: <20171127205750.19277-18-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change zpos of VI plane so it is above primary.

Clearly this works only if mixer supports only one VI plane, but it is
good enough for testing and developing.

Proper solution with zpos property should be developed instead.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 4d2b42804008..041b7136175c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -38,6 +38,8 @@ struct de2_fmt_info {
 	enum sun8i_csc_mode	csc;
 };
 
+static int lmap[] = {1, 0, 2, 3, 4};
+
 static const struct de2_fmt_info de2_formats[] = {
 	{
 		.drm_fmt = DRM_FORMAT_ARGB8888,
@@ -294,13 +296,13 @@ void sun8i_mixer_ui_layer_enable(struct sun8i_mixer *mixer,
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
 
 	if (enable)
-		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(layer);
+		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(lmap[layer]);
 	else
 		val = 0;
 
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_BLEND_PIPE_CTL,
-			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(layer), val);
+			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(lmap[layer]), val);
 }
 
 void sun8i_mixer_vi_layer_enable(struct sun8i_mixer *mixer,
@@ -321,13 +323,13 @@ void sun8i_mixer_vi_layer_enable(struct sun8i_mixer *mixer,
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN, val);
 
 	if (enable)
-		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(layer);
+		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(lmap[layer]);
 	else
 		val = 0;
 
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_BLEND_PIPE_CTL,
-			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(layer), val);
+			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(lmap[layer]), val);
 }
 
 int sun8i_mixer_update_ui_layer_coord(struct sun8i_mixer *mixer,
@@ -411,10 +413,10 @@ int sun8i_mixer_update_ui_layer_coord(struct sun8i_mixer *mixer,
 			 state->dst.x1, state->dst.y1);
 	DRM_DEBUG_DRIVER("Layer destination size W: %d H: %d\n", dst_w, dst_h);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_COORD(layer),
+		     SUN8I_MIXER_BLEND_ATTR_COORD(lmap[layer]),
 		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_INSIZE(layer),
+		     SUN8I_MIXER_BLEND_ATTR_INSIZE(lmap[layer]),
 		     outsize);
 
 	return 0;
@@ -499,10 +501,10 @@ int sun8i_mixer_update_vi_layer_coord(struct sun8i_mixer *mixer,
 			 state->dst.x1, state->dst.y1);
 	DRM_DEBUG_DRIVER("Layer destination size W: %d H: %d\n", dst_w, dst_h);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_COORD(layer),
+		     SUN8I_MIXER_BLEND_ATTR_COORD(lmap[layer]),
 		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_INSIZE(layer),
+		     SUN8I_MIXER_BLEND_ATTR_INSIZE(lmap[layer]),
 		     outsize);
 
 	return 0;
@@ -771,7 +773,7 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 		     SUN8I_MIXER_BLEND_COLOR_BLACK);
 
 	/* Fixed zpos for now */
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ROUTE, 0x43210);
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ROUTE, 0x43201);
 
 	plane_cnt = mixer->cfg->vi_num + mixer->cfg->ui_num;
 	for (i = 0; i < plane_cnt; i++)
-- 
2.15.0
