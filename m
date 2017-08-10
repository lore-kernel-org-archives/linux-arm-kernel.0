From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Thu, 10 Aug 2017 08:34:05 +0200
Subject: [PATCH v5 5/7] clk: at91: clk-generated: make gclk determine
 audio_pll rate
In-Reply-To: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
References: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
Message-ID: <600ed1e3623477c8083c6c4fa16299e33f7b76a9.1502346448.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows gclk to determine audio_pll rate and set the parent rate
accordingly.

However, there are multiple children clocks that could technically
change the rate of audio_pll (via gck). With the rate locking, the first
consumer to enable the clock will be the one definitely setting the rate
of the clock.

Since audio IPs are most likely to request the same rate, we enforce
that the only clks able to modify gck rate are those of audio IPs.

To remain consistent, we deny other clocks to be children of audio_pll.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/clk/at91/clk-generated.c | 63 +++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index 7260e49..3348136 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -26,6 +26,13 @@
 #define GENERATED_SOURCE_MAX	6
 #define GENERATED_MAX_DIV	255
 
+#define GCK_ID_SSC0		43
+#define GCK_ID_SSC1		44
+#define GCK_ID_I2S0		54
+#define GCK_ID_I2S1		55
+#define GCK_ID_CLASSD		59
+#define GCK_INDEX_DT_AUDIO_PLL	5
+
 struct clk_generated {
 	struct clk_hw hw;
 	struct regmap *regmap;
@@ -34,6 +41,7 @@ struct clk_generated {
 	u32 id;
 	u32 gckdiv;
 	u8 parent_id;
+	bool audio_pll_allowed;
 };
 
 #define to_clk_generated(hw) \
@@ -126,15 +134,14 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
 {
 	struct clk_generated *gck = to_clk_generated(hw);
 	struct clk_hw *parent = NULL;
+	struct clk_rate_request req_parent = *req;
 	long best_rate = -EINVAL;
-	unsigned long min_rate;
+	unsigned long min_rate, parent_rate;
 	int best_diff = -1;
 	int i;
+	u32 div;
 
-	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
-		u32 div;
-		unsigned long parent_rate;
-
+	for (i = 0; i < clk_hw_get_num_parents(hw) - 1; i++) {
 		parent = clk_hw_get_parent_by_index(hw, i);
 		if (!parent)
 			continue;
@@ -150,11 +157,38 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
 		clk_generated_best_diff(req, parent, parent_rate, div,
 					&best_diff, &best_rate);
 
+		if (!best_diff)
+			break;
+	}
+
+	/*
+	 * The audio_pll rate can be modified, unlike the five others clocks
+	 * that should never be altered.
+	 * The audio_pll can technically be used by multiple consumers. However,
+	 * with the rate locking, the first consumer to enable to clock will be
+	 * the one definitely setting the rate of the clock.
+	 * Since audio IPs are most likely to request the same rate, we enforce
+	 * that the only clks able to modify gck rate are those of audio IPs.
+	 */
+
+	if (!gck->audio_pll_allowed)
+		goto end;
+
+	parent = clk_hw_get_parent_by_index(hw, GCK_INDEX_DT_AUDIO_PLL);
+	if (!parent)
+		goto end;
+
+	for (div = 1; div < GENERATED_MAX_DIV + 2; div++) {
+		req_parent.rate = req->rate * div;
+		__clk_determine_rate(parent, &req_parent);
+		clk_generated_best_diff(req, parent, req_parent.rate, div,
+					&best_diff, &best_rate);
 
 		if (!best_diff)
 			break;
 	}
 
+end:
 	pr_debug("GCLK: %s, best_rate = %ld, parent clk: %s @ %ld\n",
 		 __func__, best_rate,
 		 __clk_get_name((req->best_parent_hw)->clk),
@@ -264,7 +298,8 @@ at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
 	init.ops = &generated_ops;
 	init.parent_names = parent_names;
 	init.num_parents = num_parents;
-	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
+	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
+		CLK_SET_RATE_PARENT;
 
 	gck->id = id;
 	gck->hw.init = &init;
@@ -296,6 +331,7 @@ static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
 	struct device_node *gcknp;
 	struct clk_range range = CLK_RANGE(0, 0);
 	struct regmap *regmap;
+	struct clk_generated *gck;
 
 	num_parents = of_clk_get_parent_count(np);
 	if (num_parents == 0 || num_parents > GENERATED_SOURCE_MAX)
@@ -327,6 +363,21 @@ static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock, name,
 						  parent_names, num_parents,
 						  id, &range);
+
+		gck = to_clk_generated(hw);
+
+		if (of_device_is_compatible(np,
+					    "atmel,sama5d2-clk-generated")) {
+			if (gck->id == GCK_ID_SSC0 || gck->id == GCK_ID_SSC1 ||
+			    gck->id == GCK_ID_I2S0 || gck->id == GCK_ID_I2S1 ||
+			    gck->id == GCK_ID_CLASSD)
+				gck->audio_pll_allowed = true;
+			else
+				gck->audio_pll_allowed = false;
+		} else {
+			gck->audio_pll_allowed = false;
+		}
+
 		if (IS_ERR(hw))
 			continue;
 
-- 
git-series 0.9.1
