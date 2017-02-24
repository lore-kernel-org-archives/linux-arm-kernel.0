From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:54:56 +0000
Subject: [PATCH v4 13/23] drm/rockchip: dw-mipi-dsi: fix escape clock rate
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-14-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This clock rate is derived from the PHY PLL, so it should be calculated
dynamically.  This calculation is the same as that used by the vendor
kernel and ensures that the escape clock runs at <20MHz as required by
the MIPI specification.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Chris Zhong <zyw@rock-chips.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
v4:
- Add a comment explaining the calculation and reword the commit message
  so that the calculation doesn't seem so magical
- Add Sean's Reviewed-by
v3:
- Improve the commit message a bit
- Add Chris' Reviewed-by
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 4201a2143295..0f9be41f0361 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -712,11 +712,21 @@ static void dw_mipi_dsi_disable(struct dw_mipi_dsi *dsi)
 
 static void dw_mipi_dsi_init(struct dw_mipi_dsi *dsi)
 {
+	/*
+	 * The maximum permitted escape clock is 20MHz and it is derived from
+	 * lanebyteclk, which is running at "lane_mbps / 8".  Thus we want:
+	 *
+	 *     (lane_mbps >> 3) / esc_clk_division < 20
+	 * which is:
+	 *     (lane_mbps >> 3) / 20 > esc_clk_division
+	 */
+	u32 esc_clk_division = (dsi->lane_mbps >> 3) / 20 + 1;
+
 	dsi_write(dsi, DSI_PWR_UP, RESET);
 	dsi_write(dsi, DSI_PHY_RSTZ, PHY_DISFORCEPLL | PHY_DISABLECLK
 		  | PHY_RSTZ | PHY_SHUTDOWNZ);
 	dsi_write(dsi, DSI_CLKMGR_CFG, TO_CLK_DIVIDSION(10) |
-		  TX_ESC_CLK_DIVIDSION(7));
+		  TX_ESC_CLK_DIVIDSION(esc_clk_division));
 }
 
 static void dw_mipi_dsi_dpi_config(struct dw_mipi_dsi *dsi,
-- 
2.12.0.rc0.230.gf625d4cdb9.dirty
