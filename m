From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Sat, 20 Jan 2018 19:50:20 +0100
Subject: [PATCH 1/2] drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE
Message-ID: <1516474221-114596-1-git-send-email-giulio.benetti@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Can't set dclk polarity on sun4i.

Handle both positive and negative dclk polarity,
according to bus_flags.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index f4284b5..6121210 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -17,6 +17,7 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_of.h>
+#include <drm/drm_panel.h>
 
 #include <uapi/drm/drm_mode.h>
 
@@ -173,6 +174,9 @@ static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
 static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 				     const struct drm_display_mode *mode)
 {
+	struct drm_panel *panel = tcon->panel;
+	struct drm_connector *connector = panel->connector;
+	struct drm_display_info display_info = connector->display_info;
 	unsigned int bp, hsync, vsync;
 	u8 clk_delay;
 	u32 val = 0;
@@ -226,8 +230,13 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
 		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
 
+	if(display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
+		val |= SUN4I_TCON0_IO_POL_DCLK_PHASE(1);
+
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
-			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
+			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE |
+			   SUN4I_TCON0_IO_POL_VSYNC_POSITIVE |
+			   SUN4I_TCON0_IO_POL_DCLK_PHASE(3),
 			   val);
 
 	/* Map output pins to channel 0 */
-- 
2.7.4
