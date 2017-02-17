From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 18 Feb 2017 01:37:16 +0800
Subject: [PATCH 3/9] pinctrl: sunxi: add support for R40 pinctrl
In-Reply-To: <20170217173722.6477-1-icenowy@aosc.xyz>
References: <20170217173722.6477-1-icenowy@aosc.xyz>
Message-ID: <20170217173722.6477-4-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner R40 have a pin controller similar to A20, only added 8-bit
eMMC function to mmc2 at PC bank.

Add support for it in the already renamed sunxi-a20-r40 driver via
variant framework.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi-a20-r40.c | 161 ++++++++++++++++++++------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h         |   2 +
 2 files changed, 125 insertions(+), 38 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi-a20-r40.c b/drivers/pinctrl/sunxi/pinctrl-sunxi-a20-r40.c
index b6f4c68ffb39..a925e6b835bc 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi-a20-r40.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi-a20-r40.c
@@ -18,7 +18,7 @@
 
 #include "pinctrl-sunxi.h"
 
-static const struct sunxi_desc_pin sun7i_a20_pins[] = {
+static const struct sunxi_desc_pin sunxi_a20_r40_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 0),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -146,7 +146,10 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 0),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "i2c0")),		/* SCK */
+		  SUNXI_FUNCTION(0x2, "i2c0"),		/* SCK */
+		  SUNXI_FUNCTION_VARIANT(0x3,
+					 "pll-lock-dbg",
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 1),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -154,11 +157,21 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "pwm")),		/* PWM0 */
+		  SUNXI_FUNCTION_VARIANT(0x2,
+					 "pwm",		/* PWM0 */
+					 PINCTRL_SUN7I_A20),
+		  SUNXI_FUNCTION_VARIANT(0x3,
+					 "pwm",		/* PWM0 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 3),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "ir0"),		/* TX */
+		  SUNXI_FUNCTION_VARIANT(0x2,
+					 "ir0",		/* TX */
+					 PINCTRL_SUN7I_A20),
+		  SUNXI_FUNCTION_VARIANT(0x3,
+					 "pwm",		/* PWM1 */
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "spdif")),	/* MCLK */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 4),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -187,11 +200,17 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 9),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "i2s0")),		/* DO1 */
+		  SUNXI_FUNCTION(0x2, "i2s0"),		/* DO1 */
+		  SUNXI_FUNCTION_VARIANT(0x4,
+					 "pwm",		/* PWM6 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 10),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "i2s0")),		/* DO2 */
+		  SUNXI_FUNCTION(0x2, "i2s0"),		/* DO2 */
+		  SUNXI_FUNCTION_VARIANT(0x4,
+					 "pwm",		/* PWM7 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 11),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -201,12 +220,16 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "i2s0"),		/* DI */
 		  SUNXI_FUNCTION(0x3, "ac97"),		/* DI */
-		  SUNXI_FUNCTION(0x4, "spdif")),	/* DI */
+		  SUNXI_FUNCTION_VARIANT(0x4,
+					 "spdif",	/* DI */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 13),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi2"),		/* CS1 */
-		  SUNXI_FUNCTION(0x4, "spdif")),	/* DO */
+		  SUNXI_FUNCTION_VARIANT(0x4,
+					 "spdif",	/* DO */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 14),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -247,7 +270,9 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "uart0"),		/* TX */
-		  SUNXI_FUNCTION(0x3, "ir1")),		/* TX */
+		  SUNXI_FUNCTION_VARIANT(0x2,
+					 "ir1",		/* TX */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 23),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -280,7 +305,10 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 5),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand0")),	/* NRE# */
+		  SUNXI_FUNCTION(0x2, "nand0"),	/* NRE# */
+		  SUNXI_FUNCTION_VARIANT(0x3,
+					 "mmc2",	/* DS */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 6),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -314,19 +342,31 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 12),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand0")),	/* NDQ4 */
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ4 */
+		  SUNXI_FUNCTION_VARIANT(0x3,
+					 "mmc2",	/* D4 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 13),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand0")),	/* NDQ5 */
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ5 */
+		  SUNXI_FUNCTION_VARIANT(0x3,
+					 "mmc2",	/* D5 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 14),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand0")),	/* NDQ6 */
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ6 */
+		  SUNXI_FUNCTION_VARIANT(0x3,
+					 "mmc2",	/* D6 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 15),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand0")),	/* NDQ7 */
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ7 */
+		  SUNXI_FUNCTION_VARIANT(0x3,
+					 "mmc2",	/* D7 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 16),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -366,7 +406,10 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 24),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand0")),	/* NDQS */
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQS */
+		  SUNXI_FUNCTION_VARIANT(0x3,
+					 "mmc2",	/* RST */
+					 PINCTRL_SUN8I_R40)),
 	/* Hole */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 0),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -667,14 +710,20 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 		  SUNXI_FUNCTION(0x2, "ts1"),		/* D5 */
 		  SUNXI_FUNCTION(0x3, "csi1"),		/* D5 */
 		  SUNXI_FUNCTION(0x4, "uart3"),		/* CTS */
-		  SUNXI_FUNCTION(0x5, "csi0")),		/* D13 */
+		  SUNXI_FUNCTION(0x5, "csi0"),		/* D13 */
+		  SUNXI_FUNCTION_VARIANT(0x6,
+					 "bist",	/* RESULT0 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 10),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "ts1"),		/* D6 */
 		  SUNXI_FUNCTION(0x3, "csi1"),		/* D6 */
 		  SUNXI_FUNCTION(0x4, "uart4"),		/* TX */
-		  SUNXI_FUNCTION(0x5, "csi0")),		/* D14 */
+		  SUNXI_FUNCTION(0x5, "csi0"),		/* D14 */
+		  SUNXI_FUNCTION_VARIANT(0x6,
+					 "bist",	/* RESULT1 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 11),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -730,7 +779,9 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D6 */
 		  SUNXI_FUNCTION(0x4, "uart5"),		/* TX */
-		  SUNXI_FUNCTION(0x5, "ms"),		/* BS */
+		  SUNXI_FUNCTION_VARIANT(0x5,
+					 "ms",		/* BS */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION_IRQ(0x6, 6),		/* EINT6 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D6 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 7),
@@ -738,7 +789,9 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D7 */
 		  SUNXI_FUNCTION(0x4, "uart5"),		/* RX */
-		  SUNXI_FUNCTION(0x5, "ms"),		/* CLK */
+		  SUNXI_FUNCTION_VARIANT(0x5,
+					 "ms",		/* CLK */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION_IRQ(0x6, 7),		/* EINT7 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D7 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 8),
@@ -747,7 +800,9 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D8 */
 		  SUNXI_FUNCTION(0x3, "emac"),		/* ERXD3 */
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN0 */
-		  SUNXI_FUNCTION(0x5, "ms"),		/* D0 */
+		  SUNXI_FUNCTION_VARIANT(0x5,
+					 "ms",		/* D0 */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION_IRQ(0x6, 8),		/* EINT8 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D8 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 9),
@@ -756,7 +811,9 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D9 */
 		  SUNXI_FUNCTION(0x3, "emac"),		/* ERXD2 */
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN1 */
-		  SUNXI_FUNCTION(0x5, "ms"),		/* D1 */
+		  SUNXI_FUNCTION_VARIANT(0x5,
+					 "ms",		/* D1 */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION_IRQ(0x6, 9),		/* EINT9 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D9 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 10),
@@ -765,7 +822,9 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D10 */
 		  SUNXI_FUNCTION(0x3, "emac"),		/* ERXD1 */
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN2 */
-		  SUNXI_FUNCTION(0x5, "ms"),		/* D2 */
+		  SUNXI_FUNCTION_VARIANT(0x5,
+					 "ms",		/* D2 */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION_IRQ(0x6, 10),		/* EINT10 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D10 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 11),
@@ -774,7 +833,9 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D11 */
 		  SUNXI_FUNCTION(0x3, "emac"),		/* ERXD0 */
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN3 */
-		  SUNXI_FUNCTION(0x5, "ms"),		/* D3 */
+		  SUNXI_FUNCTION_VARIANT(0x5,
+					 "ms",		/* D3 */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION_IRQ(0x6, 11),		/* EINT11 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D11 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 12),
@@ -816,6 +877,9 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D16 */
 		  SUNXI_FUNCTION(0x3, "emac"),		/* ETXD2 */
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN6 */
+		  SUNXI_FUNCTION_VARIANT(0x5,
+					 "sim",		/* DET */
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION_IRQ(0x6, 16),		/* EINT16 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D16 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 17),
@@ -1020,37 +1084,58 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "ps2"),		/* SCK0 */
 		  SUNXI_FUNCTION(0x3, "uart7"),		/* TX */
-		  SUNXI_FUNCTION(0x4, "hdmi")),		/* HSCL */
+		  SUNXI_FUNCTION_VARIANT(0x4,
+					 "hdmi",	/* HSCL */
+					 PINCTRL_SUN7I_A20),
+		  SUNXI_FUNCTION_VARIANT(0x6,
+					 "pwm",		/* PWM2 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 21),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "ps2"),		/* SDA0 */
 		  SUNXI_FUNCTION(0x3, "uart7"),		/* RX */
-		  SUNXI_FUNCTION(0x4, "hdmi")),		/* HSDA */
+		  SUNXI_FUNCTION_VARIANT(0x4,
+					 "hdmi",	/* HSDA */
+					 PINCTRL_SUN7I_A20),
+		  SUNXI_FUNCTION_VARIANT(0x6,
+					 "pwm",		/* PWM3 */
+					 PINCTRL_SUN8I_R40)),
 };
 
-static const struct sunxi_pinctrl_desc sun7i_a20_pinctrl_data = {
-	.pins = sun7i_a20_pins,
-	.npins = ARRAY_SIZE(sun7i_a20_pins),
+static const struct sunxi_pinctrl_desc sunxi_a20_r40_pinctrl_data = {
+	.pins = sunxi_a20_r40_pins,
+	.npins = ARRAY_SIZE(sunxi_a20_r40_pins),
 	.irq_banks = 1,
 };
 
-static int sun7i_a20_pinctrl_probe(struct platform_device *pdev)
+static int sunxi_a20_r40_pinctrl_probe(struct platform_device *pdev)
 {
-	return sunxi_pinctrl_init(pdev,
-				  &sun7i_a20_pinctrl_data);
+	unsigned long variant =
+		(unsigned long)of_device_get_match_data(&pdev->dev);
+
+	return sunxi_pinctrl_init_with_variant(pdev,
+					       &sunxi_a20_r40_pinctrl_data,
+					       variant);
 }
 
-static const struct of_device_id sun7i_a20_pinctrl_match[] = {
-	{ .compatible = "allwinner,sun7i-a20-pinctrl", },
+static const struct of_device_id sunxi_a20_r40_pinctrl_match[] = {
+	{
+		.compatible = "allwinner,sun7i-a20-pinctrl",
+		.data = (void *) PINCTRL_SUN7I_A20,
+	},
+	{
+		.compatible = "allwinner,sun8i-r40-pinctrl",
+		.data = (void *) PINCTRL_SUN8I_R40,
+	},
 	{}
 };
 
-static struct platform_driver sun7i_a20_pinctrl_driver = {
-	.probe	= sun7i_a20_pinctrl_probe,
+static struct platform_driver sunxi_a20_r40_pinctrl_driver = {
+	.probe	= sunxi_a20_r40_pinctrl_probe,
 	.driver	= {
-		.name		= "sun7i-a20-pinctrl",
-		.of_match_table	= sun7i_a20_pinctrl_match,
+		.name		= "sunxi-a20-r40-pinctrl",
+		.of_match_table	= sunxi_a20_r40_pinctrl_match,
 	},
 };
-builtin_platform_driver(sun7i_a20_pinctrl_driver);
+builtin_platform_driver(sunxi_a20_r40_pinctrl_driver);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index 56be35387ccf..4d1afa29d744 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -85,6 +85,8 @@
 #define PINCTRL_SUN5I_A10S	BIT(1)
 #define PINCTRL_SUN5I_A13	BIT(2)
 #define PINCTRL_SUN5I_GR8	BIT(3)
+#define PINCTRL_SUN7I_A20	BIT(4)
+#define PINCTRL_SUN8I_R40	BIT(5)
 
 struct sunxi_desc_function {
 	unsigned long	variant;
-- 
2.11.1
