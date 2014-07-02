From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 03 Jul 2014 01:57:30 +0200
Subject: [PATCH v5 02/14] clk: composite: allow read-only clocks
In-Reply-To: <156042792.J76K6jxIGl@diego>
References: <156042792.J76K6jxIGl@diego>
Message-ID: <1461225.1d2kt5TZOy@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows readl-only composite clocks by making mux_ops->set_parent and
divider_ops->round_rate/set_rate optional.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-By: Max Schwarz <max.schwarz@online.de>
Tested-By: Max Schwarz <max.schwarz@online.de>
---
 drivers/clk/clk-composite.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 9548bfc..faf7c32 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -207,7 +207,7 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 	clk_composite_ops = &composite->ops;
 
 	if (mux_hw && mux_ops) {
-		if (!mux_ops->get_parent || !mux_ops->set_parent) {
+		if (!mux_ops->get_parent) {
 			clk = ERR_PTR(-EINVAL);
 			goto err;
 		}
@@ -215,7 +215,8 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 		composite->mux_hw = mux_hw;
 		composite->mux_ops = mux_ops;
 		clk_composite_ops->get_parent = clk_composite_get_parent;
-		clk_composite_ops->set_parent = clk_composite_set_parent;
+		if (mux_ops->set_parent)
+			clk_composite_ops->set_parent = clk_composite_set_parent;
 		if (mux_ops->determine_rate)
 			clk_composite_ops->determine_rate = clk_composite_determine_rate;
 	}
@@ -232,10 +233,6 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
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
