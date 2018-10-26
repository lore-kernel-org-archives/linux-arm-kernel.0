From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 26 Oct 2018 20:13:30 +0530
Subject: [PATCH v3 11/25] drm/sun4i: sun6i_mipi_dsi: Fix DSI hblk timing
 calculation
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
Message-ID: <20181026144344.27778-12-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hblk is adding line with all porch timing values, or timings
values from htotal without sync time.

Current driver is subtracting htotal with hsa, but the hsa
is bounded with packet overhead. For real hblk calculation
needed by subtracting htotal with back and front porch values
and BSP code BPI-M64-bsp is eventually following the same.

BPI-M64-bsp is computing hbp as
(in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
=> (timmings->hor_total_time - timmings->hor_sync_time)
=> (mode->htotal - (mode->hsync_end - mode->hsync_start))

So, update the DSI hblk timing accordingly.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- new patch
Changes for v2:
- none

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 78bad71045ca..596e560263bf 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -495,7 +495,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	/*
 	 * hblk seems to be the line + porches length.
 	 */
-	hblk = mode->htotal * Bpp - hsa;
+	hblk = (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp;
 
 	/*
 	 * And I'm not entirely sure what vblk is about. The driver in
-- 
2.18.0.321.gffc6fa0e3
