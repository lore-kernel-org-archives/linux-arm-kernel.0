From: dailemon.gl@gmail.com (Lemon Dai)
Date: Sat, 11 Jan 2014 17:15:58 +0800
Subject: Add .determine_rate to composite clk
Message-ID: <CAJiWf8W6rCnnF9Tv+cpcqqshEb4ALD+J_RnYeLkaNVG-Rcd+QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

As .determine_rate was added to struct clk and clk_mux_ops, maybe we
should also copy determine_rate operation from mux_ops to
clk_composite_ops in clk_register_composite( ),
to make composite clk implementation more generic.

Patch:
diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index a33f46f..d224d6e 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -43,6 +43,20 @@ static int clk_composite_set_parent(struct clk_hw
*hw, u8 index)
        return mux_ops->set_parent(mux_hw, index);
 }

+static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
+                               unsigned long *best_parent_rate,
+                               struct clk **best_parent_p)
+{
+       struct clk_composite *composite = to_clk_composite(hw);
+       const struct clk_ops *mux_ops = composite->mux_ops;
+       struct clk_hw *mux_hw = composite->mux_hw;
+
+       mux_hw->clk = hw->clk;
+
+       return mux_ops->determine_rate(mux_hw, rate, best_parent_rate,
+                               best_parent_p);
+}
+
 static unsigned long clk_composite_recalc_rate(struct clk_hw *hw,
                                            unsigned long parent_rate)
 {
@@ -147,6 +161,11 @@ struct clk *clk_register_composite(struct device
*dev, const char *name,
                composite->mux_ops = mux_ops;
                clk_composite_ops->get_parent = clk_composite_get_parent;
                clk_composite_ops->set_parent = clk_composite_set_parent;
+
+               if (mux_ops->determine_rate) {
+                       clk_composite_ops->determine_rate =
+                                       clk_composite_determine_rate;
+               }
        }

        if (rate_hw && rate_ops) {


--
Best regards,

Lemon Dai
