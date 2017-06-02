From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  2 Jun 2017 18:10:12 +0800
Subject: [PATCH 07/19] drm/sun4i: hdmi: Support different variants of the TMDS
 clock
In-Reply-To: <20170602101024.18940-1-wens@csie.org>
References: <20170602101024.18940-1-wens@csie.org>
Message-ID: <20170602101024.18940-8-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the A31, the HDMI TMDS clock has a different value offset for the
divider.

This patch adds support for custom offsets to the TMDS clock.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
index 5692e41833ae..3c304e1fbe3b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
@@ -18,6 +18,8 @@
 struct sun4i_tmds {
 	struct clk_hw		hw;
 	struct sun4i_hdmi	*hdmi;
+
+	u8			div_offset;
 };
 
 static inline struct sun4i_tmds *hw_to_tmds(struct clk_hw *hw)
@@ -28,6 +30,7 @@ static inline struct sun4i_tmds *hw_to_tmds(struct clk_hw *hw)
 
 static unsigned long sun4i_tmds_calc_divider(unsigned long rate,
 					     unsigned long parent_rate,
+					     u8 div_offset,
 					     u8 *div,
 					     bool *half)
 {
@@ -35,7 +38,7 @@ static unsigned long sun4i_tmds_calc_divider(unsigned long rate,
 	u8 best_m = 0, m;
 	bool is_double;
 
-	for (m = 1; m < 16; m++) {
+	for (m = div_offset ?: 1; m < (16 + div_offset); m++) {
 		u8 d;
 
 		for (d = 1; d < 3; d++) {
@@ -67,7 +70,8 @@ static unsigned long sun4i_tmds_calc_divider(unsigned long rate,
 static int sun4i_tmds_determine_rate(struct clk_hw *hw,
 				     struct clk_rate_request *req)
 {
-	struct clk_hw *parent;
+	struct sun4i_tmds *tmds = hw_to_tmds(hw);
+	struct clk_hw *parent = NULL;
 	unsigned long best_parent = 0;
 	unsigned long rate = req->rate;
 	int best_div = 1, best_half = 1;
@@ -85,7 +89,8 @@ static int sun4i_tmds_determine_rate(struct clk_hw *hw,
 			continue;
 
 		for (i = 1; i < 3; i++) {
-			for (j = 1; j < 16; j++) {
+			for (j = tmds->div_offset ?: 1;
+			     j < (16 + tmds->div_offset); j++) {
 				unsigned long ideal = rate * i * j;
 				unsigned long rounded;
 
@@ -129,7 +134,7 @@ static unsigned long sun4i_tmds_recalc_rate(struct clk_hw *hw,
 		parent_rate /= 2;
 
 	reg = readl(tmds->hdmi->base + SUN4I_HDMI_PLL_CTRL_REG);
-	reg = (reg >> 4) & 0xf;
+	reg = ((reg >> 4) & 0xf) + tmds->div_offset;
 	if (!reg)
 		reg = 1;
 
@@ -144,7 +149,8 @@ static int sun4i_tmds_set_rate(struct clk_hw *hw, unsigned long rate,
 	u32 reg;
 	u8 div;
 
-	sun4i_tmds_calc_divider(rate, parent_rate, &div, &half);
+	sun4i_tmds_calc_divider(rate, parent_rate, tmds->div_offset,
+				&div, &half);
 
 	reg = readl(tmds->hdmi->base + SUN4I_HDMI_PAD_CTRL1_REG);
 	reg &= ~SUN4I_HDMI_PAD_CTRL1_HALVE_CLK;
@@ -154,7 +160,7 @@ static int sun4i_tmds_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	reg = readl(tmds->hdmi->base + SUN4I_HDMI_PLL_CTRL_REG);
 	reg &= ~SUN4I_HDMI_PLL_CTRL_DIV_MASK;
-	writel(reg | SUN4I_HDMI_PLL_CTRL_DIV(div),
+	writel(reg | SUN4I_HDMI_PLL_CTRL_DIV(div - tmds->div_offset),
 	       tmds->hdmi->base + SUN4I_HDMI_PLL_CTRL_REG);
 
 	return 0;
@@ -195,7 +201,7 @@ static const struct clk_ops sun4i_tmds_ops = {
 	.set_parent	= sun4i_tmds_set_parent,
 };
 
-int sun4i_tmds_create(struct sun4i_hdmi *hdmi)
+static int _sun4i_tmds_create(struct sun4i_hdmi *hdmi, u8 div_offset)
 {
 	struct clk_init_data init;
 	struct sun4i_tmds *tmds;
@@ -221,6 +227,7 @@ int sun4i_tmds_create(struct sun4i_hdmi *hdmi)
 
 	tmds->hdmi = hdmi;
 	tmds->hw.init = &init;
+	tmds->div_offset = div_offset;
 
 	hdmi->tmds_clk = devm_clk_register(hdmi->dev, &tmds->hw);
 	if (IS_ERR(hdmi->tmds_clk))
@@ -228,3 +235,8 @@ int sun4i_tmds_create(struct sun4i_hdmi *hdmi)
 
 	return 0;
 }
+
+int sun4i_tmds_create(struct sun4i_hdmi *hdmi)
+{
+	return _sun4i_tmds_create(hdmi, 0);
+}
-- 
2.11.0
