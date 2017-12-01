From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:29 +0100
Subject: [PATCH v2 06/27] drm/sun4i: Explain color macro in DE2 driver
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171201060550.10392-7-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Color attribute have same format troughout the whole driver.

Rename macro, add comment with simple explanation and remove redundant
definitions.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 8 +++++---
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index f4a7fa0ba7ad..5144e6d0ac56 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -317,17 +317,19 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	regmap_write(mixer->engine.regs, SUN8I_MIXER_GLOBAL_CTL,
 		     SUN8I_MIXER_GLOBAL_CTL_RT_EN);
 
+	/* Set background color to black */
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_BKCOLOR,
+		     SUN8I_MIXER_BLEND_COLOR_BLACK);
+
 	/* Initialize blender */
 	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_FCOLOR_CTL,
 		     SUN8I_MIXER_BLEND_FCOLOR_CTL_DEF);
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_BKCOLOR,
-		     SUN8I_MIXER_BLEND_BKCOLOR_DEF);
 	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_MODE(0),
 		     SUN8I_MIXER_BLEND_MODE_DEF);
 
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_BLEND_ATTR_FCOLOR(0),
-		     SUN8I_MIXER_BLEND_ATTR_FCOLOR_DEF);
+		     SUN8I_MIXER_BLEND_COLOR_BLACK);
 
 	/* Select the first UI channel */
 	DRM_DEBUG_DRIVER("Selecting channel %d (first UI channel)\n",
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index db005a4bca43..9b50733298b8 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -45,10 +45,10 @@
 #define SUN8I_MIXER_BLEND_CK_MIN(x)		(0x10e0 + 0x04 * (x))
 #define SUN8I_MIXER_BLEND_OUTCTL		0x10fc
 
+/* colors are always in AARRGGBB format */
+#define SUN8I_MIXER_BLEND_COLOR_BLACK		0xff000000
 /* The following numbers are some still unknown magic numbers */
-#define SUN8I_MIXER_BLEND_ATTR_FCOLOR_DEF	0xff000000
 #define SUN8I_MIXER_BLEND_FCOLOR_CTL_DEF	0x00000101
-#define SUN8I_MIXER_BLEND_BKCOLOR_DEF		0xff000000
 #define SUN8I_MIXER_BLEND_MODE_DEF		0x03010301
 
 #define SUN8I_MIXER_BLEND_OUTCTL_INTERLACED	BIT(1)
-- 
2.15.1
