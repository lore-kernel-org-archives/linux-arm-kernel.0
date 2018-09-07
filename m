From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  7 Sep 2018 12:19:45 +0800
Subject: [PATCH v2 3/6] drm/sun4i: tcon: Add dithering support for
 RGB565/RGB666 LCD panels
In-Reply-To: <20180907041948.19913-1-wens@csie.org>
References: <20180907041948.19913-1-wens@csie.org>
Message-ID: <20180907041948.19913-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Liu <net147@gmail.com>

The hardware supports dithering on TCON channel 0 which is used for LCD
panels.

Dithering is a method of approximating a color from a mixture of other
colors when the required color isn't available. It reduces color
banding artifacts that can be observed when displaying gradients
(e.g. grayscale gradients). This may occur when the image that needs
to be displayed is 24-bit but the LCD panel is a lower bit depth and
does not perform dithering on its own.

Signed-off-by: Jonathan Liu <net147@gmail.com>
[wens at csie.org: check display_info.bpc first; handle LVDS and MIPI DSI]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 61 ++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index d6f9d5f3b15b..4834c90b4912 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -12,6 +12,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_encoder.h>
@@ -277,6 +278,57 @@ static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
 		     SUN4I_TCON0_BASIC0_Y(mode->crtc_vdisplay));
 }
 
+static void sun4i_tcon0_mode_set_dithering(struct sun4i_tcon *tcon,
+					   const struct drm_connector *connector)
+{
+	u32 bus_format = 0;
+	u32 val = 0;
+
+	/* XXX Would this ever happen? */
+	if (!connector)
+		return;
+
+	/*
+	 * FIXME: Undocumented bits
+	 *
+	 * The whole dithering process and these parameters are not
+	 * explained in the vendor documents or BSP kernel code.
+	 */
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED_PR_REG, 0x11111111);
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED_PG_REG, 0x11111111);
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED_PB_REG, 0x11111111);
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED_LR_REG, 0x11111111);
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED_LG_REG, 0x11111111);
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED_LB_REG, 0x11111111);
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_TBL0_REG, 0x01010000);
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_TBL1_REG, 0x15151111);
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_TBL2_REG, 0x57575555);
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_TBL3_REG, 0x7f7f7777);
+
+	/* Do dithering if panel only supports 6 bits per color */
+	if (connector->display_info.bpc == 6)
+		val |= SUN4I_TCON0_FRM_CTL_EN;
+
+	if (connector->display_info.num_bus_formats == 1)
+		bus_format = connector->display_info.bus_formats[0];
+
+	/* Check the connection format */
+	switch (bus_format) {
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		/* R and B components are only 5 bits deep */
+		val |= SUN4I_TCON0_FRM_CTL_MODE_R;
+		val |= SUN4I_TCON0_FRM_CTL_MODE_B;
+	case MEDIA_BUS_FMT_RGB666_1X18:
+	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
+		/* Fall through: enable dithering */
+		val |= SUN4I_TCON0_FRM_CTL_EN;
+		break;
+	}
+
+	/* Write dithering settings */
+	regmap_write(tcon->regs, SUN4I_TCON_FRM_CTL_REG, val);
+}
+
 static void sun4i_tcon0_mode_set_cpu(struct sun4i_tcon *tcon,
 				     const struct drm_encoder *encoder,
 				     const struct drm_display_mode *mode)
@@ -294,6 +346,9 @@ static void sun4i_tcon0_mode_set_cpu(struct sun4i_tcon *tcon,
 
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
+	/* Set dithering if needed */
+	sun4i_tcon0_mode_set_dithering(tcon, sun4i_tcon_get_connector(encoder));
+
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
 			   SUN4I_TCON0_CTL_IF_MASK,
 			   SUN4I_TCON0_CTL_IF_8080);
@@ -359,6 +414,9 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
 	tcon->dclk_max_div = 7;
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
+	/* Set dithering if needed */
+	sun4i_tcon0_mode_set_dithering(tcon, sun4i_tcon_get_connector(encoder));
+
 	/* Adjust clock delay */
 	clk_delay = sun4i_tcon_get_clk_delay(mode, 0);
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
@@ -432,6 +490,9 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	tcon->dclk_max_div = 127;
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
+	/* Set dithering if needed */
+	sun4i_tcon0_mode_set_dithering(tcon, tcon->panel->connector);
+
 	/* Adjust clock delay */
 	clk_delay = sun4i_tcon_get_clk_delay(mode, 0);
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
-- 
2.19.0.rc1
