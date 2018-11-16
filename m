From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 16 Nov 2018 22:09:13 +0530
Subject: [PATCH v2 09/12] drm/sun4i: sun6i_mipi_dsi: Enable burst mode HBP,
 HSA_HSE
In-Reply-To: <20181116163916.29621-1-jagan@amarulasolutions.com>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
Message-ID: <20181116163916.29621-10-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Horizontal back porch, sync active and sync end bits are
needed to disable for burst mode panel operations.

So, disable them via dsi base control register.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 22d2987c3298..20a1de8493e0 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -644,15 +644,21 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	struct sun6i_dsi_timings timings;
 	size_t bytes;
 	u8 *buffer;
+	u32 val = 0;
 
 	/* Do all timing calculations up front to allocate buffer space */
 
 	memset(&timings, 0, sizeof(timings));
 
-	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
 		timings.hblk = (mode->hdisplay * Bpp);
-	else
+
+		regmap_read(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, &val);
+		val |= SUN6I_DSI_BASIC_CTL_HBP_DIS;
+		val |= SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS;
+	} else {
 		sun6i_dsi_get_timings(dsi, mode, &timings);
+	}
 
 	/* How many bytes do we need to send all payloads? */
 	bytes = max_t(size_t, max(max(timings.hfp, timings.hblk),
@@ -661,7 +667,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	if (WARN_ON(!buffer))
 		return;
 
-	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, 0);
+	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, val);
 
 	regmap_write(dsi->regs, SUN6I_DSI_SYNC_HSS_REG,
 		     sun6i_dsi_build_sync_pkt(MIPI_DSI_H_SYNC_START,
-- 
2.18.0.321.gffc6fa0e3
