From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Jan 2017 10:32:22 +0800
Subject: [PATCH 03/11] clk: sunxi-ng: mux: Get closest parent rate possible
 with CLK_SET_RATE_PARENT
In-Reply-To: <20170124023230.3990-1-wens@csie.org>
References: <20170124023230.3990-1-wens@csie.org>
Message-ID: <20170124023230.3990-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the CLK_SET_RATE_PARENT flag is set, we want to try getting the
closest parent rate.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_mux.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 7cee17cf9c19..c6e83ba47fa4 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -93,7 +93,18 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
 		if (!parent)
 			continue;
 
-		parent_rate = clk_hw_get_rate(parent);
+		if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
+			struct clk_rate_request parent_req = *req;
+			int ret = __clk_determine_rate(parent, &parent_req);
+
+			if (ret)
+				continue;
+
+			parent_rate = parent_req.rate;
+		} else {
+			parent_rate = clk_hw_get_rate(parent);
+		}
+
 		adj_parent_rate = parent_rate;
 		ccu_mux_helper_adjust_parent_for_prediv(common, cm, i,
 							&adj_parent_rate);
-- 
2.11.0
