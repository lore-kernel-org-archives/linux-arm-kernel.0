From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Mon, 27 Nov 2017 21:57:34 +0100
Subject: [PATCH 01/17] drm/sun4i: Refactor DE2 code
In-Reply-To: <20171127205750.19277-1-jernej.skrabec@siol.net>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
Message-ID: <20171127205750.19277-2-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the time initial DE2 driver was written, some knowledge was gained
what setting are really necessary and what most of the magic values
mean.

This commit renames some of the macro names to better fit the real
meaning, replace default values with self explaining macros where
possible and removes settings which are not really needed.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 65 +++++++++++++++++++------------------
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 31 ++++++++----------
 2 files changed, 47 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index cb193c5f1686..015943c0ed5a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -44,7 +44,8 @@ void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
 	/* Currently the first UI channel is used */
 	int chan = mixer->cfg->vi_num;
 
-	DRM_DEBUG_DRIVER("Enabling layer %d in channel %d\n", layer, chan);
+	DRM_DEBUG_DRIVER("%sabling layer %d in channel %d\n",
+			 enable ? "En" : "Dis", layer, chan);
 
 	if (enable)
 		val = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN;
@@ -55,15 +56,14 @@ void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
 
-	/* Set the alpha configuration */
-	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_DEF);
+	if (enable)
+		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(chan);
+	else
+		val = 0;
+
 	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_DEF);
+			   SUN8I_MIXER_BLEND_PIPE_CTL,
+			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(chan), val);
 }
 
 static int sun8i_mixer_drm_format_to_layer(struct drm_plane *plane,
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
@@ -107,7 +107,7 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
 					      state->crtc_h));
 		DRM_DEBUG_DRIVER("Updating blender size\n");
 		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_BLEND_ATTR_INSIZE(0),
+			     SUN8I_MIXER_BLEND_ATTR_INSIZE(chan),
 			     SUN8I_MIXER_SIZE(state->crtc_w,
 					      state->crtc_h));
 		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_OUTSIZE,
@@ -173,6 +173,7 @@ int sun8i_mixer_update_layer_formats(struct sun8i_mixer *mixer,
 		return ret;
 	}
 
+	val <<= SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET;
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK, val);
@@ -247,6 +248,7 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	struct sun8i_mixer *mixer;
 	struct resource *res;
 	void __iomem *regs;
+	int plane_cnt;
 	int i, ret;
 
 	/*
@@ -325,27 +327,26 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	regmap_write(mixer->engine.regs, SUN8I_MIXER_GLOBAL_CTL,
 		     SUN8I_MIXER_GLOBAL_CTL_RT_EN);
 
-	/* Initialize blender */
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_FCOLOR_CTL,
-		     SUN8I_MIXER_BLEND_FCOLOR_CTL_DEF);
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_PREMULTIPLY,
-		     SUN8I_MIXER_BLEND_PREMULTIPLY_DEF);
+	/* Set background color to black */
 	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_BKCOLOR,
-		     SUN8I_MIXER_BLEND_BKCOLOR_DEF);
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_MODE(0),
-		     SUN8I_MIXER_BLEND_MODE_DEF);
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_CK_CTL,
-		     SUN8I_MIXER_BLEND_CK_CTL_DEF);
+		     SUN8I_MIXER_BLEND_COLOR_BLACK);
 
-	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_FCOLOR(0),
-		     SUN8I_MIXER_BLEND_ATTR_FCOLOR_DEF);
-
-	/* Select the first UI channel */
-	DRM_DEBUG_DRIVER("Selecting channel %d (first UI channel)\n",
-			 mixer->cfg->vi_num);
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ROUTE,
-		     mixer->cfg->vi_num);
+	/*
+	 * Set fill color of bottom plane to black. Generally not needed
+	 * except when VI plane is at bottom (zpos = 0) and enabled.
+	 */
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL,
+		     SUN8I_MIXER_BLEND_PIPE_CTL_FC_EN(0));
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ATTR_FCOLOR(0),
+		     SUN8I_MIXER_BLEND_COLOR_BLACK);
+
+	/* Fixed zpos for now */
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ROUTE, 0x43210);
+
+	plane_cnt = mixer->cfg->vi_num + mixer->cfg->ui_num;
+	for (i = 0; i < plane_cnt; i++)
+		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_MODE(i),
+			     SUN8I_MIXER_BLEND_MODE_DEF);
 
 	return 0;
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index 4785ac090b8c..76f0b2bd91e2 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -16,8 +16,6 @@
 
 #include "sunxi_engine.h"
 
-#define SUN8I_MIXER_MAX_CHAN_COUNT		4
-
 #define SUN8I_MIXER_SIZE(w, h)			(((h) - 1) << 16 | ((w) - 1))
 #define SUN8I_MIXER_COORD(x, y)			((y) << 16 | (x))
 
@@ -26,14 +24,14 @@
 #define SUN8I_MIXER_GLOBAL_DBUFF		0x8
 #define SUN8I_MIXER_GLOBAL_SIZE			0xc
 
-#define SUN8I_MIXER_GLOBAL_CTL_RT_EN		0x1
+#define SUN8I_MIXER_GLOBAL_CTL_RT_EN		BIT(0)
 
-#define SUN8I_MIXER_GLOBAL_DBUFF_ENABLE		0x1
+#define SUN8I_MIXER_GLOBAL_DBUFF_ENABLE		BIT(0)
 
-#define SUN8I_MIXER_BLEND_FCOLOR_CTL		0x1000
+#define SUN8I_MIXER_BLEND_PIPE_CTL		0x1000
 #define SUN8I_MIXER_BLEND_ATTR_FCOLOR(x)	(0x1004 + 0x10 * (x) + 0x0)
 #define SUN8I_MIXER_BLEND_ATTR_INSIZE(x)	(0x1004 + 0x10 * (x) + 0x4)
-#define SUN8I_MIXER_BLEND_ATTR_OFFSET(x)	(0x1004 + 0x10 * (x) + 0x8)
+#define SUN8I_MIXER_BLEND_ATTR_COORD(x)		(0x1004 + 0x10 * (x) + 0x8)
 #define SUN8I_MIXER_BLEND_ROUTE			0x1080
 #define SUN8I_MIXER_BLEND_PREMULTIPLY		0x1084
 #define SUN8I_MIXER_BLEND_BKCOLOR		0x1088
@@ -45,13 +43,12 @@
 #define SUN8I_MIXER_BLEND_CK_MIN(x)		(0x10e0 + 0x04 * (x))
 #define SUN8I_MIXER_BLEND_OUTCTL		0x10fc
 
+#define SUN8I_MIXER_BLEND_PIPE_CTL_EN(pipe)	BIT(8 + pipe)
+#define SUN8I_MIXER_BLEND_PIPE_CTL_FC_EN(pipe)	BIT(pipe)
+/* colors are always in AARRGGBB format */
+#define SUN8I_MIXER_BLEND_COLOR_BLACK		0xff000000
 /* The following numbers are some still unknown magic numbers */
-#define SUN8I_MIXER_BLEND_ATTR_FCOLOR_DEF	0xff000000
-#define SUN8I_MIXER_BLEND_FCOLOR_CTL_DEF	0x00000101
-#define SUN8I_MIXER_BLEND_PREMULTIPLY_DEF	0x0
-#define SUN8I_MIXER_BLEND_BKCOLOR_DEF		0xff000000
 #define SUN8I_MIXER_BLEND_MODE_DEF		0x03010301
-#define SUN8I_MIXER_BLEND_CK_CTL_DEF		0x0
 
 #define SUN8I_MIXER_BLEND_OUTCTL_INTERLACED	BIT(1)
 
@@ -80,13 +77,13 @@
 
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN		BIT(0)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK	GENMASK(2, 1)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK	GENMASK(11, 8)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK	GENMASK(12, 8)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET	8
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK	GENMASK(31, 24)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_DEF	(1 << 1)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_ARGB8888	(0 << 8)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_XRGB8888	(4 << 8)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_RGB888	(8 << 8)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_DEF	(0xff << 24)
+
+#define SUN8I_MIXER_FBFMT_ARGB8888	0
+#define SUN8I_MIXER_FBFMT_XRGB8888	4
+#define SUN8I_MIXER_FBFMT_RGB888	8
 
 /*
  * These sub-engines are still unknown now, the EN registers are here only to
-- 
2.15.0
