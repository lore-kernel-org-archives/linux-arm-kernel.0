From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:26 +0100
Subject: [PATCH v2 03/27] drm/sun4i: Remove setting alpha mode in DE2 driver
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171201060550.10392-4-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current code sets alpha mode to global alpha mode and global alpha
value to 0xff which is totaly opaque. That is not needed for two
reasons:

- only one plane is active and thus it can be blended only with
background, which is black,
- it will hinder proper blending when more than one plane is supported

Default mode (0) considers pixel alpha value or 0xff if pixel has
no alpha information. Global alpha value is ignored in this case.

Because of that, just remove the code.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 10 ----------
 drivers/gpu/drm/sun4i/sun8i_mixer.h |  2 --
 2 files changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index b9c48c60131f..d3dee6131209 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -54,16 +54,6 @@ void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
-
-	/* Set the alpha configuration */
-	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_DEF);
-	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_DEF);
 }
 
 static int sun8i_mixer_drm_format_to_layer(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index 82c3416fbf3a..a7fe013c1d4a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -83,8 +83,6 @@
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK	GENMASK(12, 8)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET	8
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK	GENMASK(31, 24)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_DEF	(1 << 1)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_DEF	(0xff << 24)
 
 #define SUN8I_MIXER_FBFMT_ARGB8888	0
 #define SUN8I_MIXER_FBFMT_XRGB8888	4
-- 
2.15.1
