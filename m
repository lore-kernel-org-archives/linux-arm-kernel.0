From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  3 May 2017 13:59:41 +0200
Subject: [PATCH v2 4/20] clk: sunxi-ng: mux: Don't just rely on the parent for
 CLK_SET_RATE_PARENT
In-Reply-To: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <27fcae13e64ef86d32001478f1923e9a02deb7b8.1493812478.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code only rely on the parent to change its rate in the case
where CLK_SET_RATE_PARENT is set.

However, some clock rates might be obtained only through a modification of
the parent and the clock divider. Just rely on the round rate of the clocks
to give us the best computation that might be achieved for a given rate.

round_rate functions now need to honor CLK_SET_RATE_PARENT, but either the
functions already do that if they modify the parent, or don't modify the
praents at all.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu_mux.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index bae735e252b6..58b6e349a0ed 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -95,19 +95,7 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
 		if (!parent)
 			continue;
 
-		if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
-			struct clk_rate_request parent_req = *req;
-			int ret = __clk_determine_rate(parent, &parent_req);
-
-			if (ret)
-				continue;
-
-			parent_rate = parent_req.rate;
-		} else {
-			parent_rate = clk_hw_get_rate(parent);
-		}
-
-		adj_parent_rate = parent_rate;
+		adj_parent_rate = parent_rate = clk_hw_get_rate(parent);
 		ccu_mux_helper_adjust_parent_for_prediv(common, cm, i,
 							&adj_parent_rate);
 
-- 
git-series 0.8.11
