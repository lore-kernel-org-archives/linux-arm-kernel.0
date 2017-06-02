From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  2 Jun 2017 18:10:14 +0800
Subject: [PATCH 09/19] drm/sun4i: hdmi: Support different variants of the DDC
 clock
In-Reply-To: <20170602101024.18940-1-wens@csie.org>
References: <20170602101024.18940-1-wens@csie.org>
Message-ID: <20170602101024.18940-10-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the A31, the HDMI DDC block is different from the one in the
other SoCs. As far as the DDC clock goes, it has no pre-divider,
as it is clocked from a slower parent clock, not the TMDS clock.
The divider offset from the register value is different. And the
clock control register is at a different offset.

This patch adds support for different variants of the DDC clock.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c | 42 ++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
index 4692e8c345ed..e1071838f487 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
@@ -15,9 +15,16 @@
 #include "sun4i_tcon.h"
 #include "sun4i_hdmi.h"
 
+struct sun4i_ddc_variant {
+	u32	reg_offset;
+	u8	pre_divider;
+	u8	m_offset;
+};
+
 struct sun4i_ddc {
 	struct clk_hw		hw;
 	struct sun4i_hdmi	*hdmi;
+	const struct sun4i_ddc_variant	*variant;
 };
 
 static inline struct sun4i_ddc *hw_to_ddc(struct clk_hw *hw)
@@ -27,6 +34,7 @@ static inline struct sun4i_ddc *hw_to_ddc(struct clk_hw *hw)
 
 static unsigned long sun4i_ddc_calc_divider(unsigned long rate,
 					    unsigned long parent_rate,
+					    const struct sun4i_ddc_variant *variant,
 					    u8 *m, u8 *n)
 {
 	unsigned long best_rate = 0;
@@ -36,7 +44,8 @@ static unsigned long sun4i_ddc_calc_divider(unsigned long rate,
 		for (_n = 0; _n < 8; _n++) {
 			unsigned long tmp_rate;
 
-			tmp_rate = (((parent_rate / 2) / 10) >> _n) / (_m + 1);
+			tmp_rate = (((parent_rate / variant->pre_divider) /
+				     10) >> _n) / (_m + variant->m_offset);
 
 			if (tmp_rate > rate)
 				continue;
@@ -60,7 +69,9 @@ static unsigned long sun4i_ddc_calc_divider(unsigned long rate,
 static long sun4i_ddc_round_rate(struct clk_hw *hw, unsigned long rate,
 				 unsigned long *prate)
 {
-	return sun4i_ddc_calc_divider(rate, *prate, NULL, NULL);
+	struct sun4i_ddc *ddc = hw_to_ddc(hw);
+
+	return sun4i_ddc_calc_divider(rate, *prate, ddc->variant, NULL, NULL);
 }
 
 static unsigned long sun4i_ddc_recalc_rate(struct clk_hw *hw,
@@ -70,11 +81,12 @@ static unsigned long sun4i_ddc_recalc_rate(struct clk_hw *hw,
 	u32 reg;
 	u8 m, n;
 
-	reg = readl(ddc->hdmi->base + SUN4I_HDMI_DDC_CLK_REG);
-	m = (reg >> 3) & 0x7;
+	reg = readl(ddc->hdmi->base + ddc->variant->reg_offset);
+	m = (reg >> 3) & 0xf;
 	n = reg & 0x7;
 
-	return (((parent_rate / 2) / 10) >> n) / (m + 1);
+	return (((parent_rate / ddc->variant->pre_divider) / 10) >> n) /
+	       (m + ddc->variant->m_offset);
 }
 
 static int sun4i_ddc_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -83,10 +95,11 @@ static int sun4i_ddc_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct sun4i_ddc *ddc = hw_to_ddc(hw);
 	u8 div_m, div_n;
 
-	sun4i_ddc_calc_divider(rate, parent_rate, &div_m, &div_n);
+	sun4i_ddc_calc_divider(rate, parent_rate, ddc->variant,
+			       &div_m, &div_n);
 
 	writel(SUN4I_HDMI_DDC_CLK_M(div_m) | SUN4I_HDMI_DDC_CLK_N(div_n),
-	       ddc->hdmi->base + SUN4I_HDMI_DDC_CLK_REG);
+	       ddc->hdmi->base + ddc->variant->reg_offset);
 
 	return 0;
 }
@@ -97,7 +110,8 @@ static const struct clk_ops sun4i_ddc_ops = {
 	.set_rate	= sun4i_ddc_set_rate,
 };
 
-int sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *parent)
+static int _sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *parent,
+			     const struct sun4i_ddc_variant *variant)
 {
 	struct clk_init_data init;
 	struct sun4i_ddc *ddc;
@@ -117,6 +131,7 @@ int sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *parent)
 	init.num_parents = 1;
 
 	ddc->hdmi = hdmi;
+	ddc->variant = variant;
 	ddc->hw.init = &init;
 
 	hdmi->ddc_clk = devm_clk_register(hdmi->dev, &ddc->hw);
@@ -125,3 +140,14 @@ int sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *parent)
 
 	return 0;
 }
+
+static const struct sun4i_ddc_variant sun4i_variant = {
+	.reg_offset	= SUN4I_HDMI_DDC_CLK_REG,
+	.pre_divider	= 2,
+	.m_offset	= 1,
+};
+
+int sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *parent)
+{
+	return _sun4i_ddc_create(hdmi, parent, &sun4i_variant);
+}
-- 
2.11.0
