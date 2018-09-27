From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu, 27 Sep 2018 17:18:45 +0530
Subject: [PATCH 07/12] drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
In-Reply-To: <20180927114850.24565-1-jagan@amarulasolutions.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
Message-ID: <20180927114850.24565-8-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TCON DRQ set bits for non-burst DSI mode can computed via
horizontal front porch instead of front porch + sync timings.

Since there no documentation for TCON_DRQ_REG(0x7c) register
this change is taken as reference from BPI-M64-bsp.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 599284971ab6..9918fdb990ff 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -367,9 +367,9 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 	struct mipi_dsi_device *device = dsi->device;
 	u32 val = 0;
 
-	if ((mode->hsync_end - mode->hdisplay) > 20) {
+	if ((mode->hsync_start - mode->hdisplay) > 20) {
 		/* Maaaaaagic */
-		u16 drq = (mode->hsync_end - mode->hdisplay) - 20;
+		u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
 
 		drq *= mipi_dsi_pixel_format_to_bpp(device->format);
 		drq /= 32;
-- 
2.18.0.321.gffc6fa0e3
