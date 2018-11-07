From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed,  7 Nov 2018 19:18:37 +0100
Subject: [PATCH v3 2/8] drm/sun4i: tcon: Get the connector from the encoder in
 RGB setup
In-Reply-To: <20181107181843.27628-1-contact@paulk.fr>
References: <20181107181843.27628-1-contact@paulk.fr>
Message-ID: <20181107181843.27628-3-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Features such as dithering and pixel data edge configuration currently
rely on the panel registered with the TCON driver. However, bridges are
also supported in addition to panels for RGB setup.

Instead of retrieving the connector from the panel, get it from the
encoder with the dedicated helper.

Even in the case of bridges, the connector is registered with the
encoder from our driver and is accessible when iterating connectors.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 5e1f762fc3db..262ffb6b0f82 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -481,6 +481,8 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 				     const struct drm_encoder *encoder,
 				     const struct drm_display_mode *mode)
 {
+	struct drm_connector *connector = sun4i_tcon_get_connector(encoder);
+	struct drm_display_info display_info = connector->display_info;
 	unsigned int bp, hsync, vsync;
 	u8 clk_delay;
 	u32 val = 0;
@@ -492,8 +494,7 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
 	/* Set dithering if needed */
-	if (tcon->panel)
-		sun4i_tcon0_mode_set_dithering(tcon, tcon->panel->connector);
+	sun4i_tcon0_mode_set_dithering(tcon, connector);
 
 	/* Adjust clock delay */
 	clk_delay = sun4i_tcon_get_clk_delay(mode, 0);
@@ -557,17 +558,11 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	 * Following code is a way to avoid quirks all around TCON
 	 * and DOTCLOCK drivers.
 	 */
-	if (tcon->panel) {
-		struct drm_panel *panel = tcon->panel;
-		struct drm_connector *connector = panel->connector;
-		struct drm_display_info display_info = connector->display_info;
+	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
+		clk_set_phase(tcon->dclk, 240);
 
-		if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
-			clk_set_phase(tcon->dclk, 240);
-
-		if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
-			clk_set_phase(tcon->dclk, 0);
-	}
+	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
+		clk_set_phase(tcon->dclk, 0);
 
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
 			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
-- 
2.19.1
