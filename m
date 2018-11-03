From: jagan@amarulasolutions.com (Jagan Teki)
Date: Sat,  3 Nov 2018 15:38:54 +0530
Subject: [PATCH 04/10] drm/sun4i: sun6i_mipi_dsi: Setup burst mode
In-Reply-To: <20181103100900.30313-1-jagan@amarulasolutions.com>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
Message-ID: <20181103100900.30313-5-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting up burst mode display would require to compute
- Horizontal timing edge values to fill burst drq register
- Line, sync values to fill burst line register

Since there is no direct documentation for these computations
the edge and line formulas are taken from BSP code
(in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
line_num = panel->lcd_ht*dsi_pixel_bits[panel->lcd_dsi_format]/
	  (8*panel->lcd_dsi_lane);
edge1 = sync_point+(panel->lcd_x+panel->lcd_hbp+20)*
	dsi_pixel_bits[panel->lcd_dsi_format] /(8*panel->lcd_dsi_lane);
edge1 = (edge1>line_num)?line_num:edge1;
edge0 = edge1+(panel->lcd_x+40)*tcon_div/8;
edge0 = (edge0>line_num)?(edge0-line_num):1;

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 48 +++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 4965b2c71e4c..b6c01891df36 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -375,20 +375,52 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 				  struct drm_display_mode *mode)
 {
 	struct mipi_dsi_device *device = dsi->device;
+	unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format);
+	u32 line_num, edge0, edge1, hact_sync_bp;
+	u32 sync_point, tcon_div;
 	u32 val = 0;
 
-	if ((mode->hsync_start - mode->hdisplay) > 20) {
-		/* Maaaaaagic */
-		u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
+	if (device->mode_flags != MIPI_DSI_MODE_VIDEO_BURST) {
+		if ((mode->hsync_start - mode->hdisplay) > 20) {
+			/* Maaaaaagic */
+			u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
 
-		drq *= mipi_dsi_pixel_format_to_bpp(device->format);
-		drq /= 32;
+			drq *= Bpp;
+			drq /= 32;
 
-		val = (SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
-		       SUN6I_DSI_TCON_DRQ_SET(drq));
+			val = (SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
+			       SUN6I_DSI_TCON_DRQ_SET(drq));
+		}
+
+		regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG, val);
+
+		return;
 	}
 
-	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG, val);
+	sync_point = 40;
+	tcon_div = 8;	/* FIXME need to retrive the divider from TCON */
+
+	line_num = mode->htotal * Bpp / (8 * device->lanes);
+	/* Horizental timings duration excluding front porch */
+	hact_sync_bp = (mode->hdisplay + mode->htotal - mode->hsync_start);
+	edge1 = sync_point + ((hact_sync_bp + 20) * Bpp / (8 * device->lanes));
+	if (edge1 > line_num)
+		edge1 = line_num;
+
+	edge0 = edge1 + (mode->hdisplay + 40) * tcon_div / 8;
+	if (edge0 > line_num)
+		edge0 -= line_num;
+	else
+		edge0 = 1;
+
+	regmap_write(dsi->regs, SUN6I_DSI_BURST_DRQ_REG,
+		     SUN6I_DSI_BURST_DRQ_EDGE1(edge1) |
+		     SUN6I_DSI_BURST_DRQ_EDGE0(edge0));
+	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG,
+		     SUN6I_DSI_TCON_DRQ_ENABLE_MODE);
+	regmap_write(dsi->regs, SUN6I_DSI_BURST_LINE_REG,
+		     SUN6I_DSI_BURST_LINE_NUM(line_num) |
+		     SUN6I_DSI_BURST_LINE_SYNC_POINT(sync_point));
 }
 
 static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
-- 
2.18.0.321.gffc6fa0e3
