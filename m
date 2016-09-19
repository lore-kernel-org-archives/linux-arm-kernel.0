From: john@metanate.com (John Keeping)
Date: Mon, 19 Sep 2016 18:17:24 +0100
Subject: [PATCH 14/26] drm/rockchip: dw-mipi-dsi: fix escape clock rate
In-Reply-To: <20160919171747.28512-1-john@metanate.com>
References: <20160919171747.28512-1-john@metanate.com>
Message-ID: <20160919171747.28512-15-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the same calculation as the vendor kernel to derive the escape clock
speed.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 5e343b54f0d0..8854b8670d72 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -711,11 +711,13 @@ static void dw_mipi_dsi_disable(struct dw_mipi_dsi *dsi)
 
 static void dw_mipi_dsi_init(struct dw_mipi_dsi *dsi)
 {
+	u32 esc_clk_division = (dsi->lane_mbps >> 3) / 20 + 1;
+
 	dsi_write(dsi, DSI_PWR_UP, RESET);
 	dsi_write(dsi, DSI_PHY_RSTZ, PHY_DISFORCEPLL | PHY_DISABLECLK
 		  | PHY_RSTZ | PHY_SHUTDOWNZ);
 	dsi_write(dsi, DSI_CLKMGR_CFG, TO_CLK_DIVIDSION(10) |
-		  TX_ESC_CLK_DIVIDSION(7));
+		  TX_ESC_CLK_DIVIDSION(esc_clk_division));
 }
 
 static void dw_mipi_dsi_dpi_config(struct dw_mipi_dsi *dsi)
-- 
2.10.0.278.g4f427b1.dirty
