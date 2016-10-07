From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri,  7 Oct 2016 04:16:55 +0300
Subject: [PATCH] clk: lpc32xx: add a quirk for PWM and MS clock dividers
Message-ID: <1475803015-4067-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In common clock framework CLK_DIVIDER_ONE_BASED or'ed with
CLK_DIVIDER_ALLOW_ZERO flags indicates that
1) a divider clock may be set to zero value,
2) divider's zero value is interpreted as a non-divided clock.

On the LPC32xx platform clock dividers of PWM and memory card clocks
comply with the first condition, but zero value means a gated clock,
thus it may happen that the divider value is not updated when
the clock is enabled and the clock remains gated.

The change adds one-shot quirks, which check for zero value of divider
on initialization and set it to a non-zero value, therefore in runtime
a gate clock will work as expected.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/clk/nxp/clk-lpc32xx.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
index 34c9735..5b98ff9 100644
--- a/drivers/clk/nxp/clk-lpc32xx.c
+++ b/drivers/clk/nxp/clk-lpc32xx.c
@@ -1282,13 +1282,13 @@ static struct clk_hw_proto clk_hw_proto[LPC32XX_CLK_HW_MAX] = {
 
 	LPC32XX_DEFINE_MUX(PWM1_MUX, PWMCLK_CTRL, 1, 0x1, NULL, 0),
 	LPC32XX_DEFINE_DIV(PWM1_DIV, PWMCLK_CTRL, 4, 4, NULL,
-			   CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO),
+			   CLK_DIVIDER_ONE_BASED),
 	LPC32XX_DEFINE_GATE(PWM1_GATE, PWMCLK_CTRL, 0, 0),
 	LPC32XX_DEFINE_COMPOSITE(PWM1, PWM1_MUX, PWM1_DIV, PWM1_GATE),
 
 	LPC32XX_DEFINE_MUX(PWM2_MUX, PWMCLK_CTRL, 3, 0x1, NULL, 0),
 	LPC32XX_DEFINE_DIV(PWM2_DIV, PWMCLK_CTRL, 8, 4, NULL,
-			   CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO),
+			   CLK_DIVIDER_ONE_BASED),
 	LPC32XX_DEFINE_GATE(PWM2_GATE, PWMCLK_CTRL, 2, 0),
 	LPC32XX_DEFINE_COMPOSITE(PWM2, PWM2_MUX, PWM2_DIV, PWM2_GATE),
 
@@ -1335,8 +1335,7 @@ static struct clk_hw_proto clk_hw_proto[LPC32XX_CLK_HW_MAX] = {
 	LPC32XX_DEFINE_GATE(USB_DIV_GATE, USB_CTRL, 17, 0),
 	LPC32XX_DEFINE_COMPOSITE(USB_DIV, _NULL, USB_DIV_DIV, USB_DIV_GATE),
 
-	LPC32XX_DEFINE_DIV(SD_DIV, MS_CTRL, 0, 4, NULL,
-			   CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO),
+	LPC32XX_DEFINE_DIV(SD_DIV, MS_CTRL, 0, 4, NULL, CLK_DIVIDER_ONE_BASED),
 	LPC32XX_DEFINE_CLK(SD_GATE, MS_CTRL, BIT(5) | BIT(9), BIT(5) | BIT(9),
 			   0x0, BIT(5) | BIT(9), 0x0, 0x0, clk_mask_ops),
 	LPC32XX_DEFINE_COMPOSITE(SD, _NULL, SD_DIV, SD_GATE),
@@ -1478,6 +1477,20 @@ static struct clk * __init lpc32xx_clk_register(u32 id)
 	return clk;
 }
 
+static void __init lpc32xx_clk_div_quirk(u32 reg, u32 div_mask, u32 gate)
+{
+	u32 val;
+
+	regmap_read(clk_regmap, reg, &val);
+
+	if (!(val & div_mask)) {
+		val &= ~gate;
+		val |= BIT(__ffs(div_mask));
+	}
+
+	regmap_update_bits(clk_regmap, reg, gate | div_mask, val);
+}
+
 static void __init lpc32xx_clk_init(struct device_node *np)
 {
 	unsigned int i;
@@ -1517,6 +1530,17 @@ static void __init lpc32xx_clk_init(struct device_node *np)
 		return;
 	}
 
+	/*
+	 * Divider part of PWM and MS clocks requires a quirk to avoid
+	 * a misinterpretation of formally valid zero value in register
+	 * bitfield, which indicates another clock gate. Instead of
+	 * adding complexity to a gate clock ensure that zero value in
+	 * divider clock is never met in runtime.
+	 */
+	lpc32xx_clk_div_quirk(LPC32XX_CLKPWR_PWMCLK_CTRL, 0xf0, BIT(0));
+	lpc32xx_clk_div_quirk(LPC32XX_CLKPWR_PWMCLK_CTRL, 0xf00, BIT(2));
+	lpc32xx_clk_div_quirk(LPC32XX_CLKPWR_MS_CTRL, 0xf, BIT(5) | BIT(9));
+
 	for (i = 1; i < LPC32XX_CLK_MAX; i++) {
 		clk[i] = lpc32xx_clk_register(i);
 		if (IS_ERR(clk[i])) {
-- 
2.8.1
