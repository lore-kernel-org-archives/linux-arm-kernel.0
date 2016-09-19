From: john@metanate.com (John Keeping)
Date: Mon, 19 Sep 2016 18:17:31 +0100
Subject: [PATCH 17/27] drm/rockchip: dw-mipi-dsi: ensure PHY is reset
In-Reply-To: <20160919171747.28512-1-john@metanate.com>
References: <20160919171747.28512-1-john@metanate.com>
Message-ID: <20160919171747.28512-22-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also don't power up the DSI host at this point since this is not
necessary in order to configure the PHY and we do so later when
selecting video or command mode.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index e621b66b9617..e310c3d81bb8 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -398,7 +398,10 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 		return testdin;
 	}
 
-	dsi_write(dsi, DSI_PWR_UP, POWERUP);
+	/* Start by clearing PHY state */
+	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLR);
+	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_TESTCLR);
+	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLR);
 
 	dw_mipi_dsi_phy_write(dsi, 0x10, BYPASS_VCO_RANGE |
 					 VCO_RANGE_CON_SEL(vco) |
-- 
2.10.0.278.g4f427b1.dirty
