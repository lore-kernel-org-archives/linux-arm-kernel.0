From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Tue,  9 Apr 2013 10:48:02 -0300
Subject: [PATCH 1/3] clk: composite: Add fixed-rate support
In-Reply-To: <1365515284-32061-1-git-send-email-emilio@elopez.com.ar>
References: <1365515284-32061-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1365515284-32061-2-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds fixed-rate support to the composite clock, allowing
us to register gatable oscillators.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 drivers/clk/clk-composite.c  | 57 ++++++++++++++++++++++++++++++++++++++++----
 include/linux/clk-provider.h |  6 +++++
 2 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 097dee4..5416e1d 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -43,8 +43,8 @@ static int clk_composite_set_parent(struct clk_hw *hw, u8 index)
 	return mux_ops->set_parent(mux_hw, index);
 }
 
-static unsigned long clk_composite_recalc_rate(struct clk_hw *hw,
-					    unsigned long parent_rate)
+static unsigned long clk_composite_recalc_rate_div(struct clk_hw *hw,
+						   unsigned long parent_rate)
 {
 	struct clk_composite *composite = to_clk_composite(hw);
 	const struct clk_ops *div_ops = composite->div_ops;
@@ -55,6 +55,18 @@ static unsigned long clk_composite_recalc_rate(struct clk_hw *hw,
 	return div_ops->recalc_rate(div_hw, parent_rate);
 }
 
+static unsigned long clk_composite_recalc_rate_fixed(struct clk_hw *hw,
+						     unsigned long parent_rate)
+{
+	struct clk_composite *composite = to_clk_composite(hw);
+	const struct clk_ops *fixed_ops = composite->fixed_ops;
+	struct clk_hw *fixed_hw = composite->fixed_hw;
+
+	fixed_hw->clk = hw->clk;
+
+	return fixed_ops->recalc_rate(fixed_hw, parent_rate);
+}
+
 static long clk_composite_round_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long *prate)
 {
@@ -112,11 +124,12 @@ static void clk_composite_disable(struct clk_hw *hw)
 	gate_ops->disable(gate_hw);
 }
 
-struct clk *clk_register_composite(struct device *dev, const char *name,
+static struct clk *_clk_register_composite(struct device *dev, const char *name,
 			const char **parent_names, int num_parents,
 			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
 			struct clk_hw *div_hw, const struct clk_ops *div_ops,
 			struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
+			struct clk_hw *fixed_hw, const struct clk_ops *fixed_ops,
 			unsigned long flags)
 {
 	struct clk *clk;
@@ -158,7 +171,7 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 
 		composite->div_hw = div_hw;
 		composite->div_ops = div_ops;
-		clk_composite_ops->recalc_rate = clk_composite_recalc_rate;
+		clk_composite_ops->recalc_rate = clk_composite_recalc_rate_div;
 		clk_composite_ops->round_rate = clk_composite_round_rate;
 		clk_composite_ops->set_rate = clk_composite_set_rate;
 	}
@@ -177,6 +190,17 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 		clk_composite_ops->disable = clk_composite_disable;
 	}
 
+	if (fixed_hw && fixed_ops) {
+		if (!fixed_ops->recalc_rate) {
+			clk = ERR_PTR(-EINVAL);
+			goto err;
+		}
+
+		composite->fixed_hw = fixed_hw;
+		composite->fixed_ops = fixed_ops;
+		clk_composite_ops->recalc_rate = clk_composite_recalc_rate_fixed;
+	}
+
 	init.ops = clk_composite_ops;
 	composite->hw.init = &init;
 
@@ -193,9 +217,34 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 	if (composite->gate_hw)
 		composite->gate_hw->clk = clk;
 
+	if (composite->fixed_hw)
+		composite->fixed_hw->clk = clk;
+
 	return clk;
 
 err:
 	kfree(composite);
 	return clk;
 }
+
+struct clk *clk_register_composite(struct device *dev, const char *name,
+			const char **parent_names, int num_parents,
+			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
+			struct clk_hw *div_hw, const struct clk_ops *div_ops,
+			struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
+			unsigned long flags)
+{
+	return _clk_register_composite(dev, name, parent_names, num_parents,
+				       mux_hw, mux_ops, div_hw, div_ops,
+				       gate_hw, gate_ops, NULL, NULL, flags);
+}
+
+struct clk *clk_register_gatable_osc(struct device *dev, const char *name,
+			struct clk_hw *fixed_hw, const struct clk_ops *fixed_ops,
+			struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
+			unsigned long flags)
+{
+	return _clk_register_composite(dev, name, NULL, 0, NULL, NULL,
+				       NULL, NULL, gate_hw, gate_ops,
+				       fixed_hw, fixed_ops, flags);
+}
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 33e7e64..82dd006 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -343,10 +343,12 @@ struct clk_composite {
 	struct clk_hw	*mux_hw;
 	struct clk_hw	*div_hw;
 	struct clk_hw	*gate_hw;
+	struct clk_hw	*fixed_hw;
 
 	const struct clk_ops	*mux_ops;
 	const struct clk_ops	*div_ops;
 	const struct clk_ops	*gate_ops;
+	const struct clk_ops	*fixed_ops;
 };
 
 struct clk *clk_register_composite(struct device *dev, const char *name,
@@ -356,6 +358,10 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 		struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
 		unsigned long flags);
 
+struct clk *clk_register_gatable_osc(struct device *dev, const char *name,
+		struct clk_hw *fixed_hw, const struct clk_ops *fixed_ops,
+		struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
+		unsigned long flags);
 /**
  * clk_register - allocate a new clock, register it and return an opaque cookie
  * @dev: device that is registering this clock
-- 
1.8.2.1
