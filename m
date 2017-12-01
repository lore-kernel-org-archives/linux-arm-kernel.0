From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:50 +0100
Subject: [PATCH v2 27/27] [DO NOT MERGE]drm/sun4i: Change zpos of bottom VI
 plane
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171201060550.10392-28-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change zpos of VI plane so it is above primary.

Clearly this works only if mixer supports only one VI plane, but it is
good enough for testing and developing.

Proper solution with zpos property should be developed instead.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    |  2 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 10 ++++++----
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 10 ++++++----
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 29ceeb016d72..5a6774d40912 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -424,7 +424,7 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 		     SUN8I_MIXER_BLEND_COLOR_BLACK);
 
 	/* Fixed zpos for now */
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ROUTE, 0x43210);
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ROUTE, 0x43201);
 
 	plane_cnt = mixer->cfg->vi_num + mixer->cfg->ui_num;
 	for (i = 0; i < plane_cnt; i++)
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index fd76ffd40580..472a846ac967 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -26,6 +26,8 @@
 #include "sun8i_mixer.h"
 #include "sun8i_ui_scaler.h"
 
+static int lmap[] = {1, 0, 2, 3, 4};
+
 static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int channel,
 				  int overlay, bool enable)
 {
@@ -44,13 +46,13 @@ static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int channel,
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
 
 	if (enable)
-		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(channel);
+		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(lmap[channel]);
 	else
 		val = 0;
 
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_BLEND_PIPE_CTL,
-			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(channel), val);
+			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(lmap[channel]), val);
 }
 
 static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
@@ -137,10 +139,10 @@ static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 			 state->dst.x1, state->dst.y1);
 	DRM_DEBUG_DRIVER("Layer destination size W: %d H: %d\n", dst_w, dst_h);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_COORD(channel),
+		     SUN8I_MIXER_BLEND_ATTR_COORD(lmap[channel]),
 		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_INSIZE(channel),
+		     SUN8I_MIXER_BLEND_ATTR_INSIZE(lmap[channel]),
 		     outsize);
 
 	return 0;
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 0b4800fd7ba1..e4ee2b51457f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -20,6 +20,8 @@
 #include "sun8i_mixer.h"
 #include "sun8i_vi_scaler.h"
 
+static int lmap[] = {1, 0, 2, 3, 4};
+
 static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel,
 				  int overlay, bool enable)
 {
@@ -38,13 +40,13 @@ static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel,
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN, val);
 
 	if (enable)
-		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(channel);
+		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(lmap[channel]);
 	else
 		val = 0;
 
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_BLEND_PIPE_CTL,
-			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(channel), val);
+			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(lmap[channel]), val);
 }
 
 static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
@@ -130,10 +132,10 @@ static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 			 state->dst.x1, state->dst.y1);
 	DRM_DEBUG_DRIVER("Layer destination size W: %d H: %d\n", dst_w, dst_h);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_COORD(channel),
+		     SUN8I_MIXER_BLEND_ATTR_COORD(lmap[channel]),
 		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_INSIZE(channel),
+		     SUN8I_MIXER_BLEND_ATTR_INSIZE(lmap[channel]),
 		     outsize);
 
 	return 0;
-- 
2.15.1
