From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 20 Jan 2016 12:53:52 +0300
Subject: [patch] drm: rockchip: signedness bug in dw_mipi_dsi_get_lane_bps()
Message-ID: <20160120095352.GA19898@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"bpp" needs to be signed for the error handling to work.

Fixes: 84e05408fcfe ('drm: rockchip: Support Synopsys DW MIPI DSI')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 7bfe243..c35e5af 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -461,7 +461,8 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 
 static int dw_mipi_dsi_get_lane_bps(struct dw_mipi_dsi *dsi)
 {
-	unsigned int bpp, i, pre;
+	int bpp;
+	unsigned int i, pre;
 	unsigned long mpclk, pllref, tmp;
 	unsigned int m = 1, n = 1, target_mbps = 1000;
 	unsigned int max_mbps = dptdin_map[ARRAY_SIZE(dptdin_map) - 1].max_mbps;
