From: jianxin.pan@amlogic.com (Jianxin Pan)
Date: Thu, 15 Nov 2018 20:18:32 +0800
Subject: [PATCH v7 4/4] clk: meson: add one based divider support for sclk
 divider
In-Reply-To: <1542284312-55418-1-git-send-email-jianxin.pan@amlogic.com>
References: <1542284312-55418-1-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <1542284312-55418-5-git-send-email-jianxin.pan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CLK_DIVIDER_ONE_BASED flag is set, the sclk divider will be:
one based divider (div = val), and zero value gates the clock

Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
---
 drivers/clk/meson/clkc-audio.h |  1 +
 drivers/clk/meson/sclk-div.c   | 28 ++++++++++++++++++----------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/meson/clkc-audio.h b/drivers/clk/meson/clkc-audio.h
index 0a7c157..9bd6ced 100644
--- a/drivers/clk/meson/clkc-audio.h
+++ b/drivers/clk/meson/clkc-audio.h
@@ -20,6 +20,7 @@ struct meson_sclk_div_data {
 	struct parm hi;
 	unsigned int cached_div;
 	struct clk_duty cached_duty;
+	u8	flags;
 };
 
 extern const struct clk_ops meson_clk_triphase_ops;
diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
index bc64019..d98707b 100644
--- a/drivers/clk/meson/sclk-div.c
+++ b/drivers/clk/meson/sclk-div.c
@@ -24,22 +24,23 @@
 	return (struct meson_sclk_div_data *)clk->data;
 }
 
-static int sclk_div_maxval(struct meson_sclk_div_data *sclk)
-{
-	return (1 << sclk->div.width) - 1;
-}
-
 static int sclk_div_maxdiv(struct meson_sclk_div_data *sclk)
 {
-	return sclk_div_maxval(sclk) + 1;
+	if (sclk->flags & CLK_DIVIDER_ONE_BASED)
+		return clk_div_mask(sclk->div.width);
+	else
+		return clk_div_mask(sclk->div.width) + 1;
 }
 
 static int sclk_div_getdiv(struct clk_hw *hw, unsigned long rate,
 			   unsigned long prate, int maxdiv)
 {
 	int div = DIV_ROUND_CLOSEST_ULL((u64)prate, rate);
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
+	int mindiv = (sclk->flags & CLK_DIVIDER_ONE_BASED) ? 1 : 2;
 
-	return clamp(div, 2, maxdiv);
+	return clamp(div, mindiv, maxdiv);
 }
 
 static int sclk_div_bestdiv(struct clk_hw *hw, unsigned long rate,
@@ -47,7 +48,7 @@ static int sclk_div_bestdiv(struct clk_hw *hw, unsigned long rate,
 			    struct meson_sclk_div_data *sclk)
 {
 	struct clk_hw *parent = clk_hw_get_parent(hw);
-	int bestdiv = 0, i;
+	int bestdiv = 0, i, mindiv;
 	unsigned long maxdiv, now, parent_now;
 	unsigned long best = 0, best_parent = 0;
 
@@ -64,8 +65,9 @@ static int sclk_div_bestdiv(struct clk_hw *hw, unsigned long rate,
 	 * unsigned long in rate * i below
 	 */
 	maxdiv = min(ULONG_MAX / rate, maxdiv);
+	mindiv = (sclk->flags & CLK_DIVIDER_ONE_BASED) ? 1 : 2;
 
-	for (i = 2; i <= maxdiv; i++) {
+	for (i = mindiv; i <= maxdiv; i++) {
 		/*
 		 * It's the most ideal case if the requested rate can be
 		 * divided from parent clock without needing to change
@@ -153,10 +155,14 @@ static int sclk_div_get_duty_cycle(struct clk_hw *hw,
 static void sclk_apply_divider(struct clk_regmap *clk,
 			       struct meson_sclk_div_data *sclk)
 {
+	unsigned int div;
+
 	if (MESON_PARM_APPLICABLE(&sclk->hi))
 		sclk_apply_ratio(clk, sclk);
 
-	meson_parm_write(clk->map, &sclk->div, sclk->cached_div - 1);
+	div = (sclk->flags & CLK_DIVIDER_ONE_BASED) ?
+		sclk->cached_div : (sclk->cached_div - 1);
+	meson_parm_write(clk->map, &sclk->div, div);
 }
 
 static int sclk_div_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -223,6 +229,8 @@ static void sclk_div_init(struct clk_hw *hw)
 	/* if the divider is initially disabled, assume max */
 	if (!val)
 		sclk->cached_div = sclk_div_maxdiv(sclk);
+	else if (sclk->flags & CLK_DIVIDER_ONE_BASED)
+		sclk->cached_div = val;
 	else
 		sclk->cached_div = val + 1;
 
-- 
1.9.1
