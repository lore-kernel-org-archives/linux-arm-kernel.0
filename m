From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Wed, 18 Jul 2018 16:23:57 +0200
Subject: [PATCH] drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE checking if
 panel is used.
In-Reply-To: <20180613081647.31183-1-paul.kocialkowski@bootlin.com>
References: <20180613081647.31183-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180718142357.120998-1-giulio.benetti@micronovasrl.com>
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

Check if panel is used. TCON can also handle VGA DAC, then panel could
be empty.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 8232b39e16ca..5c7d6ae53111 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -17,6 +17,7 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_of.h>
+#include <drm/drm_panel.h>
 
 #include <uapi/drm/drm_mode.h>
 
@@ -474,6 +475,33 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
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
+	if (!IS_ERR(tcon->panel)) {
+		struct drm_panel *panel = tcon->panel;
+		struct drm_connector *connector = panel->connector;
+		struct drm_display_info display_info = connector->display_info;
+
+		if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
+			clk_set_phase(tcon->dclk, 240);
+
+		if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
+			clk_set_phase(tcon->dclk, 0);
+	}
+
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
 			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
 			   val);
-- 
2.17.1
