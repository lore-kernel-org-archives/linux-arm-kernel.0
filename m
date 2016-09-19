From: john@metanate.com (John Keeping)
Date: Mon, 19 Sep 2016 18:17:38 +0100
Subject: [PATCH 21/27] drm/rockchip: dw-mipi-dsi: improve PLL configuration
In-Reply-To: <20160919171747.28512-1-john@metanate.com>
References: <20160919171747.28512-1-john@metanate.com>
Message-ID: <20160919171747.28512-29-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The multiplication ratio for the PLL is required to be even due to the
use of a "by 2 pre-scaler".  Currently we are likely to end up with an
odd multiplier even though there is an equivalent set of parameters with
an even multiplier.

For example, using the 324MHz bit rate with a reference clock of 24MHz
we end up with M = 27, N = 2 whereas the example in the PHY databook
gives M = 54, N = 4 for this bit rate and reference clock.

By walking down through the available multiplier instead of up we are
more likely to hit an even multiplier.  With the above example we do now
get M = 54, N = 4 as given by the databook.

While doing this, change the loop limits to encode the actual limits on
the divisor, which are:

	40MHz >= (pllref / N) >= 5MHz

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 911ddcbab00d..2b26a54972da 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -520,7 +520,7 @@ static int dw_mipi_dsi_get_lane_bps(struct dw_mipi_dsi *dsi,
 	pllref = DIV_ROUND_UP(clk_get_rate(dsi->pllref_clk), USEC_PER_SEC);
 	tmp = pllref;
 
-	for (i = 1; i < 6; i++) {
+	for (i = pllref / 5; i > (pllref / 40); i--) {
 		pre = pllref / i;
 		if ((tmp > (target_mbps % pre)) && (target_mbps / pre < 512)) {
 			tmp = target_mbps % pre;
-- 
2.10.0.278.g4f427b1.dirty
