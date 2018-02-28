From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Wed, 28 Feb 2018 18:53:52 +0100
Subject: [PATCH 2/2] drm/sun4i: add lvds mode_valid function
In-Reply-To: <1519840432-61489-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1519840432-61489-1-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <1519840432-61489-2-git-send-email-giulio.benetti@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mode_valid function is missing for lvds.

Add it based on rgb model, also setting up dclk_min_div and dclk_max_div

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_lvds.c | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
index be3f14d..75223ee 100644
--- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
@@ -46,8 +46,63 @@ static int sun4i_lvds_get_modes(struct drm_connector *connector)
 	return drm_panel_get_modes(tcon->panel);
 }
 
+static int sun4i_lvds_mode_valid(struct drm_connector *connector,
+				struct drm_display_mode *mode)
+{
+	struct sun4i_lvds *lvds = drm_connector_to_sun4i_lvds(connector);
+	struct sun4i_tcon *tcon = lvds->tcon;
+	u32 hsync = mode->hsync_end - mode->hsync_start;
+	u32 vsync = mode->vsync_end - mode->vsync_start;
+	unsigned long rate = mode->clock * 1000;
+	long rounded_rate;
+
+	DRM_DEBUG_DRIVER("Validating modes...\n");
+
+	if (hsync < 1)
+		return MODE_HSYNC_NARROW;
+
+	if (hsync > 0x3ff)
+		return MODE_HSYNC_WIDE;
+
+	if ((mode->hdisplay < 1) || (mode->htotal < 1))
+		return MODE_H_ILLEGAL;
+
+	if ((mode->hdisplay > 0x7ff) || (mode->htotal > 0xfff))
+		return MODE_BAD_HVALUE;
+
+	DRM_DEBUG_DRIVER("Horizontal parameters OK\n");
+
+	if (vsync < 1)
+		return MODE_VSYNC_NARROW;
+
+	if (vsync > 0x3ff)
+		return MODE_VSYNC_WIDE;
+
+	if ((mode->vdisplay < 1) || (mode->vtotal < 1))
+		return MODE_V_ILLEGAL;
+
+	if ((mode->vdisplay > 0x7ff) || (mode->vtotal > 0xfff))
+		return MODE_BAD_VVALUE;
+
+	DRM_DEBUG_DRIVER("Vertical parameters OK\n");
+
+	tcon->dclk_min_div = 7;
+	tcon->dclk_max_div = 18;
+	rounded_rate = clk_round_rate(tcon->dclk, rate);
+	if (rounded_rate < rate)
+		return MODE_CLOCK_LOW;
+
+	if (rounded_rate > rate)
+		return MODE_CLOCK_HIGH;
+
+	DRM_DEBUG_DRIVER("Clock rate OK\n");
+
+	return MODE_OK;
+}
+
 static struct drm_connector_helper_funcs sun4i_lvds_con_helper_funcs = {
 	.get_modes	= sun4i_lvds_get_modes,
+	.mode_valid	= sun4i_lvds_mode_valid,
 };
 
 static void
-- 
2.7.4
