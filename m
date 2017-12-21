From: net147@gmail.com (Jonathan Liu)
Date: Thu, 21 Dec 2017 22:24:11 +1100
Subject: [PATCH] drm/sun4i: hdmi: Fix sun4i_tmds_determine_rate
Message-ID: <20171221112411.21550-1-net147@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are several issues in sun4i_tmds_determine_rate:
- doesn't check if the best match was already set before comparing it
  with the enumerated parameters which could result in integer divide
  by zero
- doesn't consider rate halving when determining closest match if it
  can't match the requested rate exactly
- sets best_div to i which corresponds to rate halving when it should be
  set to j which corresponds to the divider

Fix these issues.

Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
index dc332ea56f6c..3ecffa52c814 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
@@ -102,10 +102,13 @@ static int sun4i_tmds_determine_rate(struct clk_hw *hw,
 					goto out;
 				}
 
-				if (abs(rate - rounded / i) <
-				    abs(rate - best_parent / best_div)) {
+				if (!best_parent ||
+				    abs(rate - rounded / i / j) <
+				    abs(rate - best_parent / best_half /
+					best_div)) {
 					best_parent = rounded;
-					best_div = i;
+					best_half = i;
+					best_div = j;
 				}
 			}
 		}
-- 
2.15.0
