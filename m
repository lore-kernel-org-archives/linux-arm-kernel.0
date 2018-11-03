From: jagan@amarulasolutions.com (Jagan Teki)
Date: Sat,  3 Nov 2018 15:38:56 +0530
Subject: [PATCH 06/10] drm/sun4i: sun6i_mipi_dsi: Enable 2byte trail for
 4-lane burst mode
In-Reply-To: <20181103100900.30313-1-jagan@amarulasolutions.com>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
Message-ID: <20181103100900.30313-7-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For 4-lane, burst mode panels would need to enable 2byte trail_fill
along with filling trail_env in dsi base control register.

Similar reference code avialable in BSP
(in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
if (panel->lcd_dsi_lane == 4)
{
   dsi_dev[sel]->dsi_basic_ctl.bits.trail_inv = 0xc;
   dsi_dev[sel]->dsi_basic_ctl.bits.trail_fill     = 1;
}

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index b18a01361f11..2d34e5f48d29 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -33,6 +33,8 @@
 #define SUN6I_DSI_CTL_EN			BIT(0)
 
 #define SUN6I_DSI_BASIC_CTL_REG		0x00c
+#define SUN6I_DSI_BASIC_CTL_TRAIL_INV(n)	(((n) & 0xf) << 4)
+#define SUN6I_DSI_BASIC_CTL_TRAIL_FILL		BIT(3)
 #define SUN6I_DSI_BASIC_CTL_HBP_DIS		BIT(2)
 #define SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS		BIT(1)
 #define SUN6I_DSI_BASIC_CTL_VIDEO_BURST		BIT(0)
@@ -424,6 +426,10 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 
 	regmap_read(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, &val);
 	val |= SUN6I_DSI_BASIC_CTL_VIDEO_BURST;
+	if (device->lanes == 4) {
+		val |= SUN6I_DSI_BASIC_CTL_TRAIL_INV(0xc);
+		val |= SUN6I_DSI_BASIC_CTL_TRAIL_FILL;
+	}
 	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, val);
 }
 
-- 
2.18.0.321.gffc6fa0e3
