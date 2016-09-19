From: john@metanate.com (John Keeping)
Date: Mon, 19 Sep 2016 18:17:12 +0100
Subject: [PATCH 02/26] drm/rockchip: dw-mipi-dsi: pass new mode into MIPI mode
 set
In-Reply-To: <20160919171747.28512-1-john@metanate.com>
References: <20160919171747.28512-1-john@metanate.com>
Message-ID: <20160919171747.28512-3-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the atomic world the new connector state is not set when mode_set is
called and we should use the adjusted_mode parameter.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index a87037556f5c..fa90bb615fd0 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -459,9 +459,9 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 	return ret;
 }
 
-static int dw_mipi_dsi_get_lane_bps(struct dw_mipi_dsi *dsi)
+static int dw_mipi_dsi_get_lane_bps(struct dw_mipi_dsi *dsi,
+				    struct drm_display_mode *mode)
 {
-	struct drm_display_mode *mode = &dsi->connector.state->crtc->state->adjusted_mode;
 	unsigned int i, pre;
 	unsigned long mpclk, pllref, tmp;
 	unsigned int m = 1, n = 1, target_mbps = 1000;
@@ -824,7 +824,7 @@ static void dw_mipi_dsi_encoder_mode_set(struct drm_encoder *encoder,
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
 	int ret;
 
-	ret = dw_mipi_dsi_get_lane_bps(dsi);
+	ret = dw_mipi_dsi_get_lane_bps(dsi, adjusted_mode);
 	if (ret < 0)
 		return;
 
-- 
2.10.0.278.g4f427b1.dirty
