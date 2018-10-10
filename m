From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed, 10 Oct 2018 13:41:31 +0200
Subject: [PATCH 1/4] drm/sun4i: tcon: Support an active-low DE signal with RGB
 interface
Message-ID: <20181010114134.8211-1-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some panels need an active-low data enable (DE) signal for the RGB
interface. This requires flipping a bit in the TCON0 polarity register
when setting up the mode for the RGB interface.

Add a new helper function to match specific bus flags and use it to set
the polarity inversion bit for the DE signal when required.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 28 ++++++++++++++++++++++++++--
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 3fb084f802e2..d249a462ec09 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -78,6 +78,24 @@ static int sun4i_tcon_get_pixel_depth(const struct drm_encoder *encoder)
 	return -EINVAL;
 }
 
+static bool sun4i_tcon_match_bus_flags(const struct drm_encoder *encoder,
+				       u32 bus_flags)
+{
+	struct drm_connector *connector;
+	struct drm_display_info *info;
+
+	connector = sun4i_tcon_get_connector(encoder);
+	if (!connector)
+		return false;
+
+	info = &connector->display_info;
+
+	if ((info->bus_flags & bus_flags) == bus_flags)
+		return true;
+
+	return false;
+}
+
 static void sun4i_tcon_channel_set_status(struct sun4i_tcon *tcon, int channel,
 					  bool enabled)
 {
@@ -415,6 +433,7 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
 }
 
 static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
+				     const struct drm_encoder *encoder,
 				     const struct drm_display_mode *mode)
 {
 	unsigned int bp, hsync, vsync;
@@ -474,8 +493,13 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
 
+	if (sun4i_tcon_match_bus_flags(encoder, DRM_BUS_FLAG_DE_LOW))
+		val |= SUN4I_TCON0_IO_POL_DE_NEGATIVE;
+
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
-			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
+			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE |
+			   SUN4I_TCON0_IO_POL_VSYNC_POSITIVE |
+			   SUN4I_TCON0_IO_POL_DE_NEGATIVE,
 			   val);
 
 	/* Map output pins to channel 0 */
@@ -596,7 +620,7 @@ void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
 		sun4i_tcon0_mode_set_lvds(tcon, encoder, mode);
 		break;
 	case DRM_MODE_ENCODER_NONE:
-		sun4i_tcon0_mode_set_rgb(tcon, mode);
+		sun4i_tcon0_mode_set_rgb(tcon, encoder, mode);
 		sun4i_tcon_set_mux(tcon, 0, encoder);
 		break;
 	case DRM_MODE_ENCODER_TVDAC:
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index f6a071cd5a6f..708399c80561 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -113,6 +113,7 @@
 
 #define SUN4I_TCON0_IO_POL_REG			0x88
 #define SUN4I_TCON0_IO_POL_DCLK_PHASE(phase)		((phase & 3) << 28)
+#define SUN4I_TCON0_IO_POL_DE_NEGATIVE			BIT(27)
 #define SUN4I_TCON0_IO_POL_HSYNC_POSITIVE		BIT(25)
 #define SUN4I_TCON0_IO_POL_VSYNC_POSITIVE		BIT(24)
 
-- 
2.19.0
