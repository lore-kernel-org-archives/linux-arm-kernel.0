From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:37 +0100
Subject: [PATCH v2 14/27] drm/sun4i: Move channel size related code in DE2
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171201060550.10392-15-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Channel size should be set every time plane is changed, not only when
primary plane changes. Current code works only because only one
(primary) plane is supported at the moment.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 9635c30651d6..00c0cc6440e2 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -109,16 +109,8 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer, int channel,
 		regmap_write(mixer->engine.regs,
 			     SUN8I_MIXER_GLOBAL_SIZE,
 			     size);
-		DRM_DEBUG_DRIVER("Updating blender size\n");
-		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_BLEND_ATTR_INSIZE(channel),
-			     size);
 		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_OUTSIZE,
 			     size);
-		DRM_DEBUG_DRIVER("Updating channel size\n");
-		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_CHAN_UI_OVL_SIZE(channel),
-			     size);
 	}
 
 	/* Set height and width */
@@ -126,6 +118,9 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer, int channel,
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_CHAN_UI_LAYER_SIZE(channel, overlay),
 		     size);
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_CHAN_UI_OVL_SIZE(channel),
+		     size);
 
 	/* Set base coordinates */
 	DRM_DEBUG_DRIVER("Layer coordinates X: %d Y: %d\n",
@@ -133,6 +128,9 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer, int channel,
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_BLEND_ATTR_COORD(channel),
 		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_BLEND_ATTR_INSIZE(channel),
+		     size);
 
 	return 0;
 }
-- 
2.15.1
