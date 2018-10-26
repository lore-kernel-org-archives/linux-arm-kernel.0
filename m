From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 26 Oct 2018 20:13:34 +0530
Subject: [PATCH v3 15/25] drm/sun4i: sun6i_mipi_dsi: Set proper vblk timing
 calculation
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
Message-ID: <20181026144344.27778-16-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unlike hblk, the vblk timings should follow an equation to compute
the desired value for lane 4 devices and rest of devices it would be 0.

BSP code from BPI-M64-bsp is computing vblk as for 4-lane devices
(in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
tmp = (ht*dsi_pixel_bits[format]/8)*vt-(4+dsi_hblk+2);
dsi_vblk = (lane-tmp%lane);

So, update the vblk timing calculation accordingly.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- new patch
Changes for v2:
- none

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 20e330186b7f..42bd7506abaf 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -511,8 +511,19 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	 * Allwinner BSP is using a rather convoluted calculation
 	 * there only for 4 lanes. However, using 0 (the !4 lanes
 	 * case) even with a 4 lanes screen seems to work...
+	 *
+	 * The vertical blank is set using a blanking packet (4 bytes +
+	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
 	 */
-	vblk = 0;
+#define VBLK_PACKET_OVERHEAD	6
+	if (device->lanes == 4) {
+		int tmp;
+
+		tmp = (mode->htotal * Bpp) * mode->vtotal - (hblk + VBLK_PACKET_OVERHEAD);
+		vblk =(device->lanes - tmp % device->lanes);
+	} else {
+		vblk = 0;
+	}
 
 	/* How many bytes do we need to send all payloads? */
 	bytes = max_t(size_t, max(max(hfp, hblk), max(hsa, hbp)), vblk);
-- 
2.18.0.321.gffc6fa0e3
