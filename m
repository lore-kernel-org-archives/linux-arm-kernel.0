From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 22 Jun 2014 22:43:35 +0200
Subject: [PATCH v4 02/13] clk: composite: allow read-only clocks
In-Reply-To: <1808429.dNxms7FR7U@diego>
References: <1808429.dNxms7FR7U@diego>
Message-ID: <3089033.Y3HT2Lq8qX@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows readl-only composite clocks by making mux_ops->set_parent and
divider_ops->round_rate/set_rate optional.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/clk-composite.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 0a4cd21..046d3f6 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -210,7 +210,7 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 	clk_composite_ops = &composite->ops;
 
 	if (mux_hw && mux_ops) {
-		if (!mux_ops->get_parent || !mux_ops->set_parent) {
+		if (!mux_ops->get_parent) {
 			clk = ERR_PTR(-EINVAL);
 			goto err;
 		}
@@ -218,7 +218,8 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 		composite->mux_hw = mux_hw;
 		composite->mux_ops = mux_ops;
 		clk_composite_ops->get_parent = clk_composite_get_parent;
-		clk_composite_ops->set_parent = clk_composite_set_parent;
+		if (mux_ops->set_parent)
+			clk_composite_ops->set_parent = clk_composite_set_parent;
 		if (mux_ops->determine_rate)
 			clk_composite_ops->determine_rate = clk_composite_determine_rate;
 	}
@@ -235,10 +236,6 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 			if (rate_ops->set_rate) {
 				clk_composite_ops->set_rate = clk_composite_set_rate;
 			}
-		} else {
-			WARN(rate_ops->set_rate,
-				"%s: missing round_rate op is required\n",
-				__func__);
 		}
 
 		composite->rate_hw = rate_hw;
-- 
1.9.0
