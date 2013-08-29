From: broonie@kernel.org (Mark Brown)
Date: Thu, 29 Aug 2013 15:13:28 +0100
Subject: [PATCH] clk: wm831x: Provide is_prepared() rather than is_enabled()
Message-ID: <1377785608-30625-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Since the driver was written an is_prepared() operation has been made
possible. Since the driver uses I2C I/O only prepare operations are
provided so move the is_enabled() operation over to is_prepared().

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/clk/clk-wm831x.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-wm831x.c b/drivers/clk/clk-wm831x.c
index 1d5af3f..805b4c3 100644
--- a/drivers/clk/clk-wm831x.c
+++ b/drivers/clk/clk-wm831x.c
@@ -31,7 +31,7 @@ struct wm831x_clk {
 	bool xtal_ena;
 };
 
-static int wm831x_xtal_is_enabled(struct clk_hw *hw)
+static int wm831x_xtal_is_prepared(struct clk_hw *hw)
 {
 	struct wm831x_clk *clkdata = container_of(hw, struct wm831x_clk,
 						  xtal_hw);
@@ -52,7 +52,7 @@ static unsigned long wm831x_xtal_recalc_rate(struct clk_hw *hw,
 }
 
 static const struct clk_ops wm831x_xtal_ops = {
-	.is_enabled = wm831x_xtal_is_enabled,
+	.is_prepared = wm831x_xtal_is_prepared,
 	.recalc_rate = wm831x_xtal_recalc_rate,
 };
 
@@ -73,7 +73,7 @@ static const unsigned long wm831x_fll_auto_rates[] = {
 	24576000,
 };
 
-static int wm831x_fll_is_enabled(struct clk_hw *hw)
+static int wm831x_fll_is_prepared(struct clk_hw *hw)
 {
 	struct wm831x_clk *clkdata = container_of(hw, struct wm831x_clk,
 						  fll_hw);
@@ -170,7 +170,7 @@ static int wm831x_fll_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (i == ARRAY_SIZE(wm831x_fll_auto_rates))
 		return -EINVAL;
 
-	if (wm831x_fll_is_enabled(hw))
+	if (wm831x_fll_is_prepared(hw))
 		return -EPERM;
 
 	return wm831x_set_bits(wm831x, WM831X_CLOCK_CONTROL_2,
@@ -220,7 +220,7 @@ static u8 wm831x_fll_get_parent(struct clk_hw *hw)
 }
 
 static const struct clk_ops wm831x_fll_ops = {
-	.is_enabled = wm831x_fll_is_enabled,
+	.is_prepared = wm831x_fll_is_prepared,
 	.prepare = wm831x_fll_prepare,
 	.unprepare = wm831x_fll_unprepare,
 	.round_rate = wm831x_fll_round_rate,
@@ -237,7 +237,7 @@ static struct clk_init_data wm831x_fll_init = {
 	.flags = CLK_SET_RATE_GATE,
 };
 
-static int wm831x_clkout_is_enabled(struct clk_hw *hw)
+static int wm831x_clkout_is_prepared(struct clk_hw *hw)
 {
 	struct wm831x_clk *clkdata = container_of(hw, struct wm831x_clk,
 						  clkout_hw);
@@ -335,7 +335,7 @@ static int wm831x_clkout_set_parent(struct clk_hw *hw, u8 parent)
 }
 
 static const struct clk_ops wm831x_clkout_ops = {
-	.is_enabled = wm831x_clkout_is_enabled,
+	.is_prepared = wm831x_clkout_is_prepared,
 	.prepare = wm831x_clkout_prepare,
 	.unprepare = wm831x_clkout_unprepare,
 	.get_parent = wm831x_clkout_get_parent,
-- 
1.8.4.rc3
