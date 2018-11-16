From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 16 Nov 2018 22:09:07 +0530
Subject: [PATCH v2 03/12] drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
In-Reply-To: <20181116163916.29621-1-jagan@amarulasolutions.com>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
Message-ID: <20181116163916.29621-4-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Burst mode display timings are different from convectional
video mode so update the horizontal and vertical timings.

Reference code taken from BSP (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_hsa  = 0;
dsi_hbp  = 0;
dsi_hact = x*dsi_pixel_bits[format]/8;
dsi_hblk = dsi_hact;
dsi_hfp  = 0;
dsi_vblk = 0;

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 128 +++++++++++++++----------
 1 file changed, 80 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 3ac002c4d8b3..efd08bfd0cb8 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -153,6 +153,14 @@
 
 #define SUN6I_DSI_CMD_TX_REG(n)		(0x300 + (n) * 0x04)
 
+struct sun6i_dsi_timings {
+	u16 hsa;
+	u16 hbp;
+	u16 hblk;
+	u16 hfp;
+	u16 vblk;
+};
+
 enum sun6i_dsi_start_inst {
 	DSI_START_LPRX,
 	DSI_START_LPTX,
@@ -379,6 +387,60 @@ static u16 sun6i_dsi_get_timings_vblk(struct sun6i_dsi *dsi,
 	return vblk;
 }
 
+static void sun6i_dsi_get_timings(struct sun6i_dsi *dsi,
+				  struct drm_display_mode *mode,
+				  struct sun6i_dsi_timings *timings)
+{
+	struct mipi_dsi_device *device = dsi->device;
+	unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
+	u16 hsa, hbp, hblk, hfp, vblk;
+
+	/*
+	 * A sync period is composed of a blanking packet (4 bytes +
+	 * payload + 2 bytes) and a sync event packet (4 bytes).
+	 * Its minimal size is therefore 10 bytes
+	 */
+#define HSA_PACKET_OVERHEAD	10
+	hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
+		  (mode->hsync_end - mode->hsync_start) * Bpp -
+		  HSA_PACKET_OVERHEAD);
+
+	/*
+	 * The backporch is set using a blanking packet (4 bytes +
+	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
+	 */
+#define HBP_PACKET_OVERHEAD	6
+	hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
+		  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
+
+	/*
+	 * hblk seems to be the line + porches length.
+	 * The blank is set using a blanking packet (4 bytes + 4 bytes
+	 * + payload + 2 bytes). So minimal size is 10 bytes
+	 */
+#define HBLK_PACKET_OVERHEAD	10
+	hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
+		   (mode->htotal - (mode->hsync_end - mode->hsync_start)) *
+		   Bpp - HBLK_PACKET_OVERHEAD);
+
+	/*
+	 * The frontporch is set using a blanking packet (4 bytes +
+	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
+	 */
+#define HFP_PACKET_OVERHEAD	6
+	hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
+		  (mode->hsync_start - mode->hdisplay) * Bpp -
+		  HFP_PACKET_OVERHEAD);
+
+	vblk = sun6i_dsi_get_timings_vblk(dsi, mode, hblk);
+
+	timings->hsa = hsa;
+	timings->hbp = hbp;
+	timings->hblk = hblk;
+	timings->hfp = hfp;
+	timings->vblk = vblk;
+}
+
 static u16 sun6i_dsi_setup_inst_delay(struct sun6i_dsi *dsi,
 				      struct drm_display_mode *mode)
 {
@@ -506,52 +568,22 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 {
 	struct mipi_dsi_device *device = dsi->device;
 	unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
-	u16 hbp, hfp, hsa, hblk, vblk;
+	struct sun6i_dsi_timings timings;
 	size_t bytes;
 	u8 *buffer;
 
 	/* Do all timing calculations up front to allocate buffer space */
 
-	/*
-	 * A sync period is composed of a blanking packet (4 bytes +
-	 * payload + 2 bytes) and a sync event packet (4 bytes). Its
-	 * minimal size is therefore 10 bytes
-	 */
-#define HSA_PACKET_OVERHEAD	10
-	hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
-		  (mode->hsync_end - mode->hsync_start) * Bpp - HSA_PACKET_OVERHEAD);
+	memset(&timings, 0, sizeof(timings));
 
-	/*
-	 * The backporch is set using a blanking packet (4 bytes +
-	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
-	 */
-#define HBP_PACKET_OVERHEAD	6
-	hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
-		  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
-
-	/*
-	 * The frontporch is set using a blanking packet (4 bytes +
-	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
-	 */
-#define HFP_PACKET_OVERHEAD	6
-	hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
-		  (mode->hsync_start - mode->hdisplay) * Bpp -
-		  HFP_PACKET_OVERHEAD);
-
-	/*
-	 * hblk seems to be the line + porches length.
-	 * The blank is set using a blanking packet (4 bytes + 4 bytes +
-	 * payload + 2 bytes). So minimal size is 10 bytes
-	 */
-#define HBLK_PACKET_OVERHEAD	10
-	hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
-		   (mode->htotal - (mode->hsync_end - mode->hsync_start)) *
-		   Bpp - HBLK_PACKET_OVERHEAD);
-
-	vblk = sun6i_dsi_get_timings_vblk(dsi, mode, hblk);
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		timings.hblk = (mode->hdisplay * Bpp);
+	else
+		sun6i_dsi_get_timings(dsi, mode, &timings);
 
 	/* How many bytes do we need to send all payloads? */
-	bytes = max_t(size_t, max(max(hfp, hblk), max(hsa, hbp)), vblk);
+	bytes = max_t(size_t, max(max(timings.hfp, timings.hblk),
+		      max(timings.hsa, timings.hbp)), timings.vblk);
 	buffer = kmalloc(bytes, GFP_KERNEL);
 	if (WARN_ON(!buffer))
 		return;
@@ -590,33 +622,33 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 
 	/* sync */
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HSA0_REG,
-		     sun6i_dsi_build_blk0_pkt(device->channel, hsa));
+		     sun6i_dsi_build_blk0_pkt(device->channel, timings.hsa));
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HSA1_REG,
-		     sun6i_dsi_build_blk1_pkt(0, buffer, hsa));
+		     sun6i_dsi_build_blk1_pkt(0, buffer, timings.hsa));
 
 	/* backporch */
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HBP0_REG,
-		     sun6i_dsi_build_blk0_pkt(device->channel, hbp));
+		     sun6i_dsi_build_blk0_pkt(device->channel, timings.hbp));
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HBP1_REG,
-		     sun6i_dsi_build_blk1_pkt(0, buffer, hbp));
+		     sun6i_dsi_build_blk1_pkt(0, buffer, timings.hbp));
 
 	/* frontporch */
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HFP0_REG,
-		     sun6i_dsi_build_blk0_pkt(device->channel, hfp));
+		     sun6i_dsi_build_blk0_pkt(device->channel, timings.hfp));
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HFP1_REG,
-		     sun6i_dsi_build_blk1_pkt(0, buffer, hfp));
+		     sun6i_dsi_build_blk1_pkt(0, buffer, timings.hfp));
 
 	/* hblk */
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HBLK0_REG,
-		     sun6i_dsi_build_blk0_pkt(device->channel, hblk));
+		     sun6i_dsi_build_blk0_pkt(device->channel, timings.hblk));
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HBLK1_REG,
-		     sun6i_dsi_build_blk1_pkt(0, buffer, hblk));
+		     sun6i_dsi_build_blk1_pkt(0, buffer, timings.hblk));
 
 	/* vblk */
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_VBLK0_REG,
-		     sun6i_dsi_build_blk0_pkt(device->channel, vblk));
+		     sun6i_dsi_build_blk0_pkt(device->channel, timings.vblk));
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_VBLK1_REG,
-		     sun6i_dsi_build_blk1_pkt(0, buffer, vblk));
+		     sun6i_dsi_build_blk1_pkt(0, buffer, timings.vblk));
 
 	kfree(buffer);
 }
-- 
2.18.0.321.gffc6fa0e3
