From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Oct 2017 11:06:20 +0200
Subject: [PATCH 13/23] drm/sun4i: Reorder and document DE2 mixer registers
In-Reply-To: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <021d9256ec51cc6b2fbc4112652560fbd7faf517.1508231063.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some registers values have been hardcoded so far, or were not as
descriptive as supposed to, because of missing information. The various
BSP that poped up since have given us more details, some hopefully we can
be more explicit about things.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 25 ++++----
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 89 ++++++++++++++++--------------
 2 files changed, 63 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 5afe8ef709a5..86c6c24b5105 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -61,7 +61,7 @@ void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer, struct sun8i_ui *ui,
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ui->chan, ui->id),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_DEF);
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA(255));
 }
 
 static int sun8i_mixer_drm_format_to_layer(struct drm_plane *plane,
@@ -322,19 +322,20 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 
 	/* Initialize blender */
 	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_FCOLOR_CTL,
-		     SUN8I_MIXER_BLEND_FCOLOR_CTL_DEF);
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_PREMULTIPLY,
-		     SUN8I_MIXER_BLEND_PREMULTIPLY_DEF);
+		     SUN8I_MIXER_BLEND_FCOLOR_CTL_FCOLOR_EN(0) |
+		     SUN8I_MIXER_BLEND_FCOLOR_CTL_EN(0));
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_PREMULTIPLY, 0);
 	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_BKCOLOR,
-		     SUN8I_MIXER_BLEND_BKCOLOR_DEF);
+		     SUN8I_MIXER_BLEND_BKCOLOR_ALPHA(255));
 	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_MODE(0),
-		     SUN8I_MIXER_BLEND_MODE_DEF);
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_CK_CTL,
-		     SUN8I_MIXER_BLEND_CK_CTL_DEF);
-
-	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_FCOLOR(0),
-		     SUN8I_MIXER_BLEND_ATTR_FCOLOR_DEF);
+		     SUN8I_MIXER_BLEND_MODE_PIXEL_FS(1) |
+		     SUN8I_MIXER_BLEND_MODE_PIXEL_FD(3) |
+		     SUN8I_MIXER_BLEND_MODE_ALPHA_FS(1) |
+		     SUN8I_MIXER_BLEND_MODE_ALPHA_FD(3));
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_CK_CTL, 0);
+
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ATTR_FCOLOR(0),
+		     SUN8I_MIXER_BLEND_ATTR_FCOLOR_ALPHA(255));
 
 	/* Select the first UI channel */
 	DRM_DEBUG_DRIVER("Selecting channel %d (first UI channel)\n", 1);
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index 20d2ee1c4187..22877a008e0d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -22,71 +22,82 @@
 #define SUN8I_MIXER_COORD(x, y)			((y) << 16 | (x))
 
 #define SUN8I_MIXER_GLOBAL_CTL			0x0
+#define SUN8I_MIXER_GLOBAL_CTL_RT_EN			BIT(0)
+
 #define SUN8I_MIXER_GLOBAL_STATUS		0x4
 #define SUN8I_MIXER_GLOBAL_DBUFF		0x8
-#define SUN8I_MIXER_GLOBAL_SIZE			0xc
-
-#define SUN8I_MIXER_GLOBAL_CTL_RT_EN		0x1
+#define SUN8I_MIXER_GLOBAL_DBUFF_ENABLE			BIT(0)
 
-#define SUN8I_MIXER_GLOBAL_DBUFF_ENABLE		0x1
+#define SUN8I_MIXER_GLOBAL_SIZE			0xc
 
 #define SUN8I_MIXER_BLEND_FCOLOR_CTL		0x1000
+#define SUN8I_MIXER_BLEND_FCOLOR_CTL_EN(x)		BIT(8 + (x))
+#define SUN8I_MIXER_BLEND_FCOLOR_CTL_FCOLOR_EN(x)	BIT(x)
+
 #define SUN8I_MIXER_BLEND_ATTR_FCOLOR(x)	(0x1004 + 0x10 * (x) + 0x0)
+#define SUN8I_MIXER_BLEND_ATTR_FCOLOR_ALPHA(x)		(((x) & 0xff) << 24)
+
 #define SUN8I_MIXER_BLEND_ATTR_INSIZE(x)	(0x1004 + 0x10 * (x) + 0x4)
+
 #define SUN8I_MIXER_BLEND_ATTR_OFFSET(x)	(0x1004 + 0x10 * (x) + 0x8)
 #define SUN8I_MIXER_BLEND_ROUTE			0x1080
 #define SUN8I_MIXER_BLEND_PREMULTIPLY		0x1084
+
 #define SUN8I_MIXER_BLEND_BKCOLOR		0x1088
+#define SUN8I_MIXER_BLEND_BKCOLOR_ALPHA(x)		(((x) & 0xff) << 24)
+
 #define SUN8I_MIXER_BLEND_OUTSIZE		0x108c
+
 #define SUN8I_MIXER_BLEND_MODE(x)		(0x1090 + 0x04 * (x))
+#define SUN8I_MIXER_BLEND_MODE_ALPHA_FD(x)		(((x) & 0xf) << 24)
+#define SUN8I_MIXER_BLEND_MODE_ALPHA_FS(x)		(((x) & 0xf) << 16)
+#define SUN8I_MIXER_BLEND_MODE_PIXEL_FD(x)		(((x) & 0xf) << 8)
+#define SUN8I_MIXER_BLEND_MODE_PIXEL_FS(x)		((x) & 0xf)
+
 #define SUN8I_MIXER_BLEND_CK_CTL		0x10b0
 #define SUN8I_MIXER_BLEND_CK_CFG		0x10b4
 #define SUN8I_MIXER_BLEND_CK_MAX(x)		(0x10c0 + 0x04 * (x))
 #define SUN8I_MIXER_BLEND_CK_MIN(x)		(0x10e0 + 0x04 * (x))
-#define SUN8I_MIXER_BLEND_OUTCTL		0x10fc
-
-/* The following numbers are some still unknown magic numbers */
-#define SUN8I_MIXER_BLEND_ATTR_FCOLOR_DEF	0xff000000
-#define SUN8I_MIXER_BLEND_FCOLOR_CTL_DEF	0x00000101
-#define SUN8I_MIXER_BLEND_PREMULTIPLY_DEF	0x0
-#define SUN8I_MIXER_BLEND_BKCOLOR_DEF		0xff000000
-#define SUN8I_MIXER_BLEND_MODE_DEF		0x03010301
-#define SUN8I_MIXER_BLEND_CK_CTL_DEF		0x0
 
-#define SUN8I_MIXER_BLEND_OUTCTL_INTERLACED	BIT(1)
+#define SUN8I_MIXER_BLEND_OUTCTL		0x10fc
+#define SUN8I_MIXER_BLEND_OUTCTL_INTERLACED		BIT(1)
 
 /*
  * VI channels are not used now, but the support of them may be introduced in
  * the future.
  */
 
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch, layer) \
-			(0x3000 + 0x1000 * (ch) + 0x20 * (layer) + 0x0)
-#define SUN8I_MIXER_CHAN_UI_LAYER_SIZE(ch, layer) \
-			(0x3000 + 0x1000 * (ch) + 0x20 * (layer) + 0x4)
-#define SUN8I_MIXER_CHAN_UI_LAYER_COORD(ch, layer) \
-			(0x3000 + 0x1000 * (ch) + 0x20 * (layer) + 0x8)
-#define SUN8I_MIXER_CHAN_UI_LAYER_PITCH(ch, layer) \
-			(0x3000 + 0x1000 * (ch) + 0x20 * (layer) + 0xc)
-#define SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(ch, layer) \
-			(0x3000 + 0x1000 * (ch) + 0x20 * (layer) + 0x10)
-#define SUN8I_MIXER_CHAN_UI_LAYER_BOT_LADDR(ch, layer) \
-			(0x3000 + 0x1000 * (ch) + 0x20 * (layer) + 0x14)
-#define SUN8I_MIXER_CHAN_UI_LAYER_FCOLOR(ch, layer) \
-			(0x3000 + 0x1000 * (ch) + 0x20 * (layer) + 0x18)
-#define SUN8I_MIXER_CHAN_UI_TOP_HADDR(ch)	(0x3000 + 0x1000 * (ch) + 0x80)
-#define SUN8I_MIXER_CHAN_UI_BOT_HADDR(ch)	(0x3000 + 0x1000 * (ch) + 0x84)
-#define SUN8I_MIXER_CHAN_UI_OVL_SIZE(ch)	(0x3000 + 0x1000 * (ch) + 0x88)
+#define SUN8I_MIXER_CHAN(ch)		(0x3000 + 0x1000 * (ch))
+#define SUN8I_MIXER_UI_LAYER(ch, layer)	(SUN8I_MIXER_CHAN(ch) + 0x20 * (layer))
 
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN		BIT(0)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK	GENMASK(2, 1)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK	GENMASK(11, 8)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch, layer)	\
+	(SUN8I_MIXER_UI_LAYER(ch, layer) + 0x00)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK	GENMASK(31, 24)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_DEF	(1 << 1)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_ARGB8888	(0 << 8)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_XRGB8888	(4 << 8)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_RGB888	(8 << 8)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_DEF	(0xff << 24)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA(x)			(0xff << 24)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK	GENMASK(11, 8)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_RGB888		(8 << 8)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_XRGB8888		(4 << 8)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_ARGB8888		(0 << 8)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK	GENMASK(2, 1)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_DEF		(1 << 1)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN		BIT(0)
+
+#define SUN8I_MIXER_CHAN_UI_LAYER_SIZE(ch, layer)	\
+	(SUN8I_MIXER_UI_LAYER(ch, layer) + 0x04)
+#define SUN8I_MIXER_CHAN_UI_LAYER_COORD(ch, layer)	\
+	(SUN8I_MIXER_UI_LAYER(ch, layer) + 0x08)
+#define SUN8I_MIXER_CHAN_UI_LAYER_PITCH(ch, layer)	\
+	(SUN8I_MIXER_UI_LAYER(ch, layer) + 0x0c)
+#define SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(ch, layer)	\
+	(SUN8I_MIXER_UI_LAYER(ch, layer) + 0x10)
+#define SUN8I_MIXER_CHAN_UI_LAYER_BOT_LADDR(ch, layer)	\
+	(SUN8I_MIXER_UI_LAYER(ch, layer) + 0x14)
+#define SUN8I_MIXER_CHAN_UI_LAYER_FCOLOR(ch, layer)	\
+	(SUN8I_MIXER_UI_LAYER(ch, layer) + 0x18)
+
+#define SUN8I_MIXER_CHAN_UI_TOP_HADDR(ch)	(SUN8I_MIXER_CHAN(ch) + 0x80)
+#define SUN8I_MIXER_CHAN_UI_BOT_HADDR(ch)	(SUN8I_MIXER_CHAN(ch) + 0x84)
+#define SUN8I_MIXER_CHAN_UI_OVL_SIZE(ch)	(SUN8I_MIXER_CHAN(ch) + 0x88)
 
 /*
  * These sub-engines are still unknown now, the EN registers are here only to
-- 
git-series 0.9.1
