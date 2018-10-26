From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 26 Oct 2018 20:13:33 +0530
Subject: [PATCH v3 14/25] drm/sun4i: sun6i_mipi_dsi: Increase hfp packet
 overhead
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
Message-ID: <20181026144344.27778-15-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the hfp packet overhead with another 10 bytes, the extra
10 bytes(which is hblk packet overhead) is adding for hfp packet
overhead since hfp depends on hblk.

This is truely as per BSP code from BPI-M64-bsp.
The real computation from BSP is
(in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
dsi_hbp = (hbp-hspw)*dsi_pixel_bits[format]/8 - (4+2);
dsi_hact = x * dsi_pixel_bits[format]/8;
dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
dsi_hfp = dsi_hblk - (4+dsi_hact+2) - (4+dsi_hbp+2);

Example,
u32 fmt = dsi_pixel_bits[format]/8;
=> ((ht-hspw)*fmt - 10) - (6 + x * fmt) - (6 + (hbp-hspw)*fmt - 6)
=> (ht - hspw - x - (hbp - hspw)) * fmt - 16
=> (ht - x - hbp) * fmt - 16
=> (ht - x - (timmings->hor_total_time - timmings->hor_front_porch - x)
* fmt - 16
=> (timmings->hor_total_time - x - timmings->hor_total_time +
timmings->hor_front_porch + x) * fmt - 16
=> timmings->hor_front_porch * fmt - 16

So, increase the DSI hfp packet overhead by hblk packet overhead.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- new patch
Changes for v2:
- none

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 6584b51736a9..20e330186b7f 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -461,7 +461,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 {
 	struct mipi_dsi_device *device = dsi->device;
 	unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
-	u16 hbp, hfp, hsa, hblk_max, hblk, vblk;
+	u16 hbp, hfp_pkt_overhead, hfp, hsa, hblk_max, hblk, vblk;
 	size_t bytes;
 	u8 *buffer;
 
@@ -484,14 +484,6 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
 		  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
 
-	/*
-	 * The frontporch is set using a blanking packet (4 bytes +
-	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
-	 */
-#define HFP_PACKET_OVERHEAD	6
-	hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
-		  (mode->hsync_start - mode->hdisplay) * Bpp - HFP_PACKET_OVERHEAD);
-
 	/*
 	 * hblk seems to be the line + porches length.
 	 * The blank is set using a blanking packet (4 bytes + 4 bytes +
@@ -502,6 +494,18 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	hblk_max -= HBLK_PACKET_OVERHEAD;
 	hblk = max((unsigned int)HBLK_PACKET_OVERHEAD, hblk_max);
 
+	/*
+	 * The frontporch is set using a blanking packet (4 bytes +
+	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
+	 *
+	 * According to BSP code, extra 10 bytes(which is hblk packet overhead)
+	 * is adding for hfp packet overhead since hfp depends on hblk.
+	 */
+#define HFP_PACKET_OVERHEAD	6
+	hfp_pkt_overhead = (HFP_PACKET_OVERHEAD + HBLK_PACKET_OVERHEAD);
+	hfp = max((unsigned int)hfp_pkt_overhead,
+		  (mode->hsync_start - mode->hdisplay) * Bpp - hfp_pkt_overhead);
+
 	/*
 	 * And I'm not entirely sure what vblk is about. The driver in
 	 * Allwinner BSP is using a rather convoluted calculation
-- 
2.18.0.321.gffc6fa0e3
