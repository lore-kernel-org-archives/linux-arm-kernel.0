From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:55:00 +0000
Subject: [PATCH v4 17/23] drm/rockchip: dw-mipi-dsi: improve PLL configuration
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-18-john@metanate.com>
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
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
v4:
- Add a comment explaining the limits so that it can be understood
  without finding the commit message above
- Add Sean's Reviewed-by
Unchanged in v3
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 9b6a60deb69e..e6b52c7cb5e3 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -518,7 +518,18 @@ static int dw_mipi_dsi_get_lane_bps(struct dw_mipi_dsi *dsi,
 	pllref = DIV_ROUND_UP(clk_get_rate(dsi->pllref_clk), USEC_PER_SEC);
 	tmp = pllref;
 
-	for (i = 1; i < 6; i++) {
+	/*
+	 * The limits on the PLL divisor are:
+	 *
+	 *	5MHz <= (pllref / n) <= 40MHz
+	 *
+	 * we walk over these values in descreasing order so that if we hit
+	 * an exact match for target_mbps it is more likely that "m" will be
+	 * even.
+	 *
+	 * TODO: ensure that "m" is even after this loop.
+	 */
+	for (i = pllref / 5; i > (pllref / 40); i--) {
 		pre = pllref / i;
 		if ((tmp > (target_mbps % pre)) && (target_mbps / pre < 512)) {
 			tmp = target_mbps % pre;
-- 
2.12.0.rc0.230.gf625d4cdb9.dirty
