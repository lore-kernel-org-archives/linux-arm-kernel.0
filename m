From: jagan@amarulasolutions.com (Jagan Teki)
Date: Sat,  3 Nov 2018 15:38:57 +0530
Subject: [PATCH 07/10] drm/sun4i: sun6i_mipi_dsi: Enable burst mode HBP,
 HSA_HSE
In-Reply-To: <20181103100900.30313-1-jagan@amarulasolutions.com>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
Message-ID: <20181103100900.30313-8-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Horizontal back porch, sync active and sync end bits are
needed to enable for burst mode panel operations.

So, enable them via dsi base control register.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 2d34e5f48d29..feb8c54c5146 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -518,6 +518,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	u16 hbp, hfp_pkt_overhead, hfp, hsa, hblk, vblk;
 	size_t bytes;
 	u8 *buffer;
+	u32 val = 0;
 
 	/* Do all timing calculations up front to allocate buffer space */
 
@@ -527,6 +528,10 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 		hblk = mode->hdisplay * Bpp;
 		hfp = 0;
 		vblk = 0;
+
+		regmap_read(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, &val);
+		val |= SUN6I_DSI_BASIC_CTL_HBP_DIS;
+		val |= SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS;
 	} else {
 		/*
 		 * A sync period is composed of a blanking packet (4 bytes +
@@ -594,7 +599,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	if (WARN_ON(!buffer))
 		return;
 
-	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, 0);
+	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, val);
 
 	regmap_write(dsi->regs, SUN6I_DSI_SYNC_HSS_REG,
 		     sun6i_dsi_build_sync_pkt(MIPI_DSI_H_SYNC_START,
-- 
2.18.0.321.gffc6fa0e3
