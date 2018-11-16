From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 16 Nov 2018 22:09:05 +0530
Subject: [PATCH v2 01/12] drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop
 N1 instruction delay
In-Reply-To: <20181116163916.29621-1-jagan@amarulasolutions.com>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
Message-ID: <20181116163916.29621-2-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Loop N1 instruction delay for burst mode lcd panel are
computed as per BSP code.

Reference code is available in BSP (from linux-sunxi
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_dev[sel]->dsi_inst_loop_num.bits.loop_n1=
(panel->lcd_ht-panel->lcd_x)*(150)/(panel->lcd_dclk_freq*8) - 50;
=> (((mode->htotal - mode->hdisplay) * 150) /
     ((mode->clock / 1000) * 8)) - 50;

So use the similar computation for loop N1 delay.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index def145086a5c..43ab7127d428 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -379,6 +379,24 @@ static u16 sun6i_dsi_get_timings_vblk(struct sun6i_dsi *dsi,
 	return vblk;
 }
 
+static u16 sun6i_dsi_setup_inst_delay(struct sun6i_dsi *dsi,
+				      struct drm_display_mode *mode)
+{
+	struct mipi_dsi_device *device = dsi->device;
+	u32 hsync_porch, dclk;
+	u16 delay;
+
+	hsync_porch = (mode->htotal - mode->hdisplay);
+	dclk = (mode->clock / 1000);
+
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		delay = ((hsync_porch * 150) / (dclk * 8)) - 50;
+	else
+		delay = 50 - 1;
+
+	return delay;
+}
+
 static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 					   struct drm_display_mode *mode)
 {
@@ -418,7 +436,7 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
 				      struct drm_display_mode *mode)
 {
-	u16 delay = 50 - 1;
+	u16 delay = sun6i_dsi_setup_inst_delay(dsi, mode);
 
 	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_NUM_REG(0),
 		     SUN6I_DSI_INST_LOOP_NUM_N0(50 - 1) |
-- 
2.18.0.321.gffc6fa0e3
