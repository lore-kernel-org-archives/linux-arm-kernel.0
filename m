From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 15 Nov 2018 23:40:43 +0100
Subject: [PATCH v2 1/6] clk: meson: clk-pll: check if the clock is already
 enabled
In-Reply-To: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
References: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
Message-ID: <20181115224048.13511-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 6f888e7bc7bd58 ("clk: meson: clk-pll: add enable bit") our
PLLs also support the "enable" bit. Currently meson_clk_pll_enable
unconditionally resets the PLL, enables it, takes it out of reset and
waits until it is locked.

This works fine for our current clock trees. However, there will be a
problem once we allow modifications to sys_pll on Meson8, Meson8b and
Meson8m2 (which will be required for CPU frequency scaling):
the CPU clock is derived from the sys_pll clock. Once clk_enable is
called on the CPU clock this will be propagated by the common clock
framework up until the sys_pll clock. If we reset the PLL
unconditionally in meson_clk_pll_enable the CPU will be stopped (on
Meson8, Meson8b and Meson8m2).
To prevent this we simply check if the PLL is already enabled and do
reset the PLL if it's already enabled and locked.

Now that we have a utility function to check whether the PLL is enabled
we can also pass that to our clk_ops to let the common clock framework
know about the status of the hardware clock.
For now this is of limited use since the only common clock framework's
internal "disabled unused clocks" mechanism checks for this. Everything
else still uses the ref-counting (internal to the common clock
framework) when clk_enable is called.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/clk-pll.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index f5b5b3fabe3c..afffc1547e20 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -200,11 +200,28 @@ static void meson_clk_pll_init(struct clk_hw *hw)
 	}
 }
 
+static int meson_clk_pll_is_enabled(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
+
+	if (meson_parm_read(clk->map, &pll->rst) ||
+	    !meson_parm_read(clk->map, &pll->en) ||
+	    !meson_parm_read(clk->map, &pll->l))
+		return 0;
+
+	return 1;
+}
+
 static int meson_clk_pll_enable(struct clk_hw *hw)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
 
+	/* do nothing if the PLL is already enabled */
+	if (clk_hw_is_enabled(hw))
+		return 0;
+
 	/* Make sure the pll is in reset */
 	meson_parm_write(clk->map, &pll->rst, 1);
 
@@ -288,10 +305,12 @@ const struct clk_ops meson_clk_pll_ops = {
 	.recalc_rate	= meson_clk_pll_recalc_rate,
 	.round_rate	= meson_clk_pll_round_rate,
 	.set_rate	= meson_clk_pll_set_rate,
+	.is_enabled	= meson_clk_pll_is_enabled,
 	.enable		= meson_clk_pll_enable,
 	.disable	= meson_clk_pll_disable
 };
 
 const struct clk_ops meson_clk_pll_ro_ops = {
 	.recalc_rate	= meson_clk_pll_recalc_rate,
+	.is_enabled	= meson_clk_pll_is_enabled,
 };
-- 
2.19.1
