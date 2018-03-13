From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Tue, 13 Mar 2018 18:54:37 +0100
Subject: [PATCH v2] drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE
Message-ID: <1520963677-124239-1-git-send-email-giulio.benetti@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Handle both positive and negative dclk polarity,
according to bus_flags, taking care of this:

On A20 and similar SoCs, the only way to achieve Positive Edge
(Rising Edge), is setting dclk clock phase to 2/3(240?).
By default TCON works in Negative Edge(Falling Edge), this is why phase
is set to 0 in that case.
Unfortunately there's no way to logically invert dclk through IO_POL
register.
The only acceptable way to work, triple checked with scope,
is using clock phase set to 0? for Negative Edge and set to 240? for
Positive Edge.
On A33 and similar SoCs there would be a 90? phase option, but it divides
also dclk by 2.
This patch is a way to avoid quirks all around TCON and DOTCLOCK drivers
for using A33 90? phase divided by 2 and consequently increase code
complexity.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 8ee87c2..3f1455d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -17,6 +17,7 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_of.h>
+#include <drm/drm_panel.h>
 
 #include <uapi/drm/drm_mode.h>
 
@@ -345,6 +346,9 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
 static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 				     const struct drm_display_mode *mode)
 {
+	struct drm_panel *panel = tcon->panel;
+	struct drm_connector *connector = panel->connector;
+	struct drm_display_info display_info = connector->display_info;
 	unsigned int bp, hsync, vsync;
 	u8 clk_delay;
 	u32 val = 0;
@@ -400,6 +404,27 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
 
+	/*
+	 * On A20 and similar SoCs, the only way to achieve Positive Edge
+	 * (Rising Edge), is setting dclk clock phase to 2/3(240?).
+	 * By default TCON works in Negative Edge(Falling Edge),
+	 * this is why phase is set to 0 in that case.
+	 * Unfortunately there's no way to logically invert dclk through
+	 * IO_POL register.
+	 * The only acceptable way to work, triple checked with scope,
+	 * is using clock phase set to 0? for Negative Edge and set to 240?
+	 * for Positive Edge.
+	 * On A33 and similar SoCs there would be a 90? phase option,
+	 * but it divides also dclk by 2.
+	 * Following code is a way to avoid quirks all around TCON
+	 * and DOTCLOCK drivers.
+	 */
+	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
+		clk_set_phase(tcon->dclk, 240);
+
+	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
+		clk_set_phase(tcon->dclk, 0);
+
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
 			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
 			   val);
-- 
2.7.4
