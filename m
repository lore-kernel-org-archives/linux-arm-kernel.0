From: net147@gmail.com (Jonathan Liu)
Date: Tue,  9 Jan 2018 13:03:21 +1100
Subject: [PATCH v3 1/3] drm/sun4i: hdmi: Check for unset best_parent in
 sun4i_tmds_determine_rate
In-Reply-To: <20180109020323.11852-1-net147@gmail.com>
References: <20180109020323.11852-1-net147@gmail.com>
Message-ID: <20180109020323.11852-2-net147@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is possible that if there is no exact rate match and
"rounded = clk_hw_round_rate(parent, ideal)" gives high enough values
(e.g. if rounded is 2 * ideal) that the condition
"abs(rate - rounded / i) < abs(rate - best_parent / best_div)" is never
met and best_parent is never set. This results in req->rate and
req->best_parent_rate being assigned 0.

To avoid this, we set best_parent to the first calculated rate if it is
unset. The sun4i_tmds_calc_divider function already has a similar check.

Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
index dc332ea56f6c..4d235e5ea31c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
@@ -102,7 +102,7 @@ static int sun4i_tmds_determine_rate(struct clk_hw *hw,
 					goto out;
 				}
 
-				if (abs(rate - rounded / i) <
+				if (!best_parent || abs(rate - rounded / i) <
 				    abs(rate - best_parent / best_div)) {
 					best_parent = rounded;
 					best_div = i;
-- 
2.15.1
