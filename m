From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:25 +0100
Subject: [PATCH v2 02/27] drm/sun4i: Rename DE2 RGB format macros
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171201060550.10392-3-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current RGB formats macros are actually not specific to UI planes.
Rename it to something more universal and introduce shift macro.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 7 ++++---
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 8 +++++---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index cb193c5f1686..b9c48c60131f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -71,15 +71,15 @@ static int sun8i_mixer_drm_format_to_layer(struct drm_plane *plane,
 {
 	switch (format) {
 	case DRM_FORMAT_ARGB8888:
-		*mode = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_ARGB8888;
+		*mode = SUN8I_MIXER_FBFMT_ARGB8888;
 		break;
 
 	case DRM_FORMAT_XRGB8888:
-		*mode = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_XRGB8888;
+		*mode = SUN8I_MIXER_FBFMT_XRGB8888;
 		break;
 
 	case DRM_FORMAT_RGB888:
-		*mode = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_RGB888;
+		*mode = SUN8I_MIXER_FBFMT_RGB888;
 		break;
 
 	default:
@@ -173,6 +173,7 @@ int sun8i_mixer_update_layer_formats(struct sun8i_mixer *mixer,
 		return ret;
 	}
 
+	val <<= SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET;
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK, val);
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index c142fbb8661e..82c3416fbf3a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -81,13 +81,15 @@
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN		BIT(0)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK	GENMASK(2, 1)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK	GENMASK(12, 8)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET	8
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK	GENMASK(31, 24)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_DEF	(1 << 1)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_ARGB8888	(0 << 8)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_XRGB8888	(4 << 8)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_RGB888	(8 << 8)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_DEF	(0xff << 24)
 
+#define SUN8I_MIXER_FBFMT_ARGB8888	0
+#define SUN8I_MIXER_FBFMT_XRGB8888	4
+#define SUN8I_MIXER_FBFMT_RGB888	8
+
 /*
  * These sub-engines are still unknown now, the EN registers are here only to
  * be used to disable these sub-engines.
-- 
2.15.1
