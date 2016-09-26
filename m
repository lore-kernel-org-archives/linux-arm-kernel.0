From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 26 Sep 2016 14:44:27 -0400
Subject: [PATCH] clk: lpc32xx: fix pwm clock divider computation
Message-ID: <1474915467-11101-1-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

A zero value in the PWM clock divider register
(PWM1_FREQ/PWM2_FREQ) turn off the PWM clock.

The "CLK_DIVIDER_ALLOW_ZERO" option is used for hardware that handle
the zero divider by not modifying their clock input (i.e. bypass).
See "/include/linux/clk-provider.h" for details.

Remove the CLK_DIVIDER_ALLOW_ZERO option and add support to handle
the clock rate computation of the PWM clock divider 0 value.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Note:
* Should we include a new CLK_DIVIDER option for this case
  (i.e. clock off when zero ) in "clk-provider.h"?

 drivers/clk/nxp/clk-lpc32xx.c | 52 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
index 34c9735..3ca3a14 100644
--- a/drivers/clk/nxp/clk-lpc32xx.c
+++ b/drivers/clk/nxp/clk-lpc32xx.c
@@ -959,6 +959,25 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
 				   divider->flags);
 }
 
+static unsigned long clk_divider_pwm_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct lpc32xx_clk_div *divider = to_lpc32xx_div(hw);
+	unsigned int val;
+
+	regmap_read(clk_regmap, divider->reg, &val);
+
+	val >>= divider->shift;
+	val &= div_mask(divider->width);
+
+	/* Handle 0 divider -> PWM clock is off. */
+	if(val == 0)
+		return 0;
+
+	return divider_recalc_rate(hw, parent_rate, val, divider->table,
+				   divider->flags);
+}
+
 static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long *prate)
 {
@@ -999,6 +1018,12 @@ static const struct clk_ops lpc32xx_clk_divider_ops = {
 	.set_rate = clk_divider_set_rate,
 };
 
+static const struct clk_ops lpc32xx_clk_pwm_divider_ops = {
+	.recalc_rate = clk_divider_pwm_recalc_rate,
+	.round_rate = clk_divider_round_rate,
+	.set_rate = clk_divider_set_rate,
+};
+
 static u8 clk_mux_get_parent(struct clk_hw *hw)
 {
 	struct lpc32xx_clk_mux *mux = to_lpc32xx_mux(hw);
@@ -1151,6 +1176,25 @@ struct clk_hw_proto {
 	},								\
 }
 
+#define LPC32XX_DEFINE_PWM_DIV(_idx, _reg, _shift, _width, _tab, _fl)	\
+[CLK_PREFIX(_idx)] = {							\
+	.type = CLK_DIV,						\
+	{								\
+		.hw0 = {						\
+			.ops = &lpc32xx_clk_pwm_divider_ops,		\
+			{						\
+				.div = {				\
+					.reg = LPC32XX_CLKPWR_ ## _reg,	\
+					.shift = (_shift),		\
+					.width = (_width),		\
+					.table = (_tab),		\
+					.flags = (_fl),			\
+				 },					\
+			},						\
+		 },							\
+	},								\
+}
+
 #define LPC32XX_DEFINE_GATE(_idx, _reg, _bit, _flags)			\
 [CLK_PREFIX(_idx)] = {							\
 	.type = CLK_GATE,						\
@@ -1281,14 +1325,14 @@ static struct clk_hw_proto clk_hw_proto[LPC32XX_CLK_HW_MAX] = {
 	LPC32XX_DEFINE_GATE(MCPWM, TIMCLK_CTRL1, 6, 0),
 
 	LPC32XX_DEFINE_MUX(PWM1_MUX, PWMCLK_CTRL, 1, 0x1, NULL, 0),
-	LPC32XX_DEFINE_DIV(PWM1_DIV, PWMCLK_CTRL, 4, 4, NULL,
-			   CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO),
+	LPC32XX_DEFINE_PWM_DIV(PWM1_DIV, PWMCLK_CTRL, 4, 4, NULL,
+			       CLK_DIVIDER_ONE_BASED),
 	LPC32XX_DEFINE_GATE(PWM1_GATE, PWMCLK_CTRL, 0, 0),
 	LPC32XX_DEFINE_COMPOSITE(PWM1, PWM1_MUX, PWM1_DIV, PWM1_GATE),
 
 	LPC32XX_DEFINE_MUX(PWM2_MUX, PWMCLK_CTRL, 3, 0x1, NULL, 0),
-	LPC32XX_DEFINE_DIV(PWM2_DIV, PWMCLK_CTRL, 8, 4, NULL,
-			   CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO),
+	LPC32XX_DEFINE_PWM_DIV(PWM2_DIV, PWMCLK_CTRL, 8, 4, NULL,
+			       CLK_DIVIDER_ONE_BASED),
 	LPC32XX_DEFINE_GATE(PWM2_GATE, PWMCLK_CTRL, 2, 0),
 	LPC32XX_DEFINE_COMPOSITE(PWM2, PWM2_MUX, PWM2_DIV, PWM2_GATE),
 
-- 
1.8.3.1
