From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  2 Feb 2017 00:25:46 +0800
Subject: [PATCH 1/2] pinctrl: sunxi: Support A31/A31s with pinctrl variants
In-Reply-To: <20170201162547.24232-1-wens@csie.org>
References: <20170201162547.24232-1-wens@csie.org>
Message-ID: <20170201162547.24232-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31s is a trimmed down version of the A31. Some hardware blocks
are removed, thus not available for muxing on the external pins.
Some external pins were directly removed.

This makes it easy to support the A31s pin controller with the A31
driver. We just mark the pins and functions that were trimmed as
A31 only.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c | 184 +++++++++++++++++++-----------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h     |   2 +
 2 files changed, 121 insertions(+), 65 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
index 9e58926bef37..951a25c18815 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
@@ -23,69 +23,79 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* TXD0 */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D0 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D0 */
 		  SUNXI_FUNCTION(0x4, "uart1"),		/* DTR */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),	/* PA_EINT0 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 1),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* TXD1 */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D1 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D1 */
 		  SUNXI_FUNCTION(0x4, "uart1"),		/* DSR */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),	/* PA_EINT1 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 2),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* TXD2 */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D2 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D2 */
 		  SUNXI_FUNCTION(0x4, "uart1"),		/* DCD */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),	/* PA_EINT2 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 3),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* TXD3 */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D3 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D3 */
 		  SUNXI_FUNCTION(0x4, "uart1"),		/* RING */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),	/* PA_EINT3 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 4),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* TXD4 */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D4 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D4 */
 		  SUNXI_FUNCTION(0x4, "uart1"),		/* TX */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),	/* PA_EINT4 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 5),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* TXD5 */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D5 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D5 */
 		  SUNXI_FUNCTION(0x4, "uart1"),		/* RX */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),	/* PA_EINT5 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 6),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* TXD6 */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D6 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D6 */
 		  SUNXI_FUNCTION(0x4, "uart1"),		/* RTS */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),	/* PA_EINT6 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 7),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* TXD7 */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D7 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D7 */
 		  SUNXI_FUNCTION(0x4, "uart1"),		/* CTS */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),	/* PA_EINT7 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 8),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* TXCLK */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D8 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D8 */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),	/* PA_EINT8 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 9),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* TXEN */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D9 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D9 */
 		  SUNXI_FUNCTION(0x4, "mmc3"),		/* CMD */
 		  SUNXI_FUNCTION(0x5, "mmc2"),		/* CMD */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 9)),	/* PA_EINT9 */
@@ -93,7 +103,8 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* GTXCLK */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D10 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D10 */
 		  SUNXI_FUNCTION(0x4, "mmc3"),		/* CLK */
 		  SUNXI_FUNCTION(0x5, "mmc2"),		/* CLK */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 10)),	/* PA_EINT10 */
@@ -101,7 +112,8 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXD0 */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D11 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D11 */
 		  SUNXI_FUNCTION(0x4, "mmc3"),		/* D0 */
 		  SUNXI_FUNCTION(0x5, "mmc2"),		/* D0 */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 11)),	/* PA_EINT11 */
@@ -109,7 +121,8 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXD1 */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D12 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D12 */
 		  SUNXI_FUNCTION(0x4, "mmc3"),		/* D1 */
 		  SUNXI_FUNCTION(0x5, "mmc2"),		/* D1 */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 12)),	/* PA_EINT12 */
@@ -117,7 +130,8 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXD2 */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D13 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D13 */
 		  SUNXI_FUNCTION(0x4, "mmc3"),		/* D2 */
 		  SUNXI_FUNCTION(0x5, "mmc2"),		/* D2 */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 13)),	/* PA_EINT13 */
@@ -125,7 +139,8 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXD3 */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D14 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D14 */
 		  SUNXI_FUNCTION(0x4, "mmc3"),		/* D3 */
 		  SUNXI_FUNCTION(0x5, "mmc2"),		/* D3 */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 14)),	/* PA_EINT14 */
@@ -133,91 +148,104 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXD4 */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D15 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D15 */
 		  SUNXI_FUNCTION(0x4, "clk_out_a"),
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 15)),	/* PA_EINT15 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 16),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXD5 */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D16 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D16 */
 		  SUNXI_FUNCTION(0x4, "dmic"),		/* CLK */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 16)),	/* PA_EINT16 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 17),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXD6 */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D17 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D17 */
 		  SUNXI_FUNCTION(0x4, "dmic"),		/* DIN */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 17)),	/* PA_EINT17 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 18),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXD7 */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D18 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D18 */
 		  SUNXI_FUNCTION(0x4, "clk_out_b"),
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 18)),	/* PA_EINT18 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 19),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXDV */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D19 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D19 */
 		  SUNXI_FUNCTION(0x4, "pwm3"),		/* Positive */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 19)),	/* PA_EINT19 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 20),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXCLK */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D20 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D20 */
 		  SUNXI_FUNCTION(0x4, "pwm3"),		/* Negative */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 20)),	/* PA_EINT20 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 21),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* TXERR */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D21 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D21 */
 		  SUNXI_FUNCTION(0x4, "spi3"),		/* CS0 */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 21)),	/* PA_EINT21 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 22),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXERR */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D22 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D22 */
 		  SUNXI_FUNCTION(0x4, "spi3"),		/* CLK */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 22)),	/* PA_EINT22 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 23),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* COL */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D23 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* D23 */
 		  SUNXI_FUNCTION(0x4, "spi3"),		/* MOSI */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 23)),	/* PA_EINT23 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 24),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* CRS */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* CLK */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* CLK */
 		  SUNXI_FUNCTION(0x4, "spi3"),		/* MISO */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 24)),	/* PA_EINT24 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 25),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* CLKIN */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* DE */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* DE */
 		  SUNXI_FUNCTION(0x4, "spi3"),		/* CS1 */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 25)),	/* PA_EINT25 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 26),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* MDC */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* HSYNC */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* HSYNC */
 		  SUNXI_FUNCTION(0x4, "clk_out_c"),
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 26)),	/* PA_EINT26 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 27),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "gmac"),		/* MDIO */
-		  SUNXI_FUNCTION(0x3, "lcd1"),		/* VSYNC */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lcd1",
+					 PINCTRL_SUN6I_A31),	/* VSYNC */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 27)),	/* PA_EINT27 */
 	/* Hole */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 0),
@@ -225,7 +253,8 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "i2s0"),		/* MCLK */
 		  SUNXI_FUNCTION(0x3, "uart3"),		/* CTS */
-		  SUNXI_FUNCTION(0x4, "csi"),		/* MCLK1 */
+		  SUNXI_FUNCTION_VARIANT(0x4, "csi",
+					 PINCTRL_SUN6I_A31),	/* MCLK1 */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 0)),	/* PB_EINT0 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 1),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -355,42 +384,43 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
 		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ7 */
 		  SUNXI_FUNCTION(0x3, "mmc2"),		/* D7 */
 		  SUNXI_FUNCTION(0x4, "mmc3")),		/* D7 */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 16),
+	/* Hole in pin numbering for A31s */
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(C, 16), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ8 */
 		  SUNXI_FUNCTION(0x3, "nand1")),	/* DQ0 */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 17),
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(C, 17), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ9 */
 		  SUNXI_FUNCTION(0x3, "nand1")),	/* DQ1 */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 18),
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(C, 18), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ10 */
 		  SUNXI_FUNCTION(0x3, "nand1")),	/* DQ2 */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 19),
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(C, 19), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ11 */
 		  SUNXI_FUNCTION(0x3, "nand1")),	/* DQ3 */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 20),
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(C, 20), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ12 */
 		  SUNXI_FUNCTION(0x3, "nand1")),	/* DQ4 */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 21),
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(C, 21), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ13 */
 		  SUNXI_FUNCTION(0x3, "nand1")),	/* DQ5 */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 22),
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(C, 22), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ14 */
 		  SUNXI_FUNCTION(0x3, "nand1")),	/* DQ6 */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 23),
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(C, 23), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ15 */
@@ -468,52 +498,62 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D10 */
-		  SUNXI_FUNCTION(0x3, "lvds1")),	/* VP0 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lvds1",
+					 PINCTRL_SUN6I_A31)),	/* VP0 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 11),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D11 */
-		  SUNXI_FUNCTION(0x3, "lvds1")),	/* VN0 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lvds1",
+					 PINCTRL_SUN6I_A31)),	/* VN0 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 12),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D12 */
-		  SUNXI_FUNCTION(0x3, "lvds1")),	/* VP1 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lvds1",
+					 PINCTRL_SUN6I_A31)),	/* VP1 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 13),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D13 */
-		  SUNXI_FUNCTION(0x3, "lvds1")),	/* VN1 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lvds1",
+					 PINCTRL_SUN6I_A31)),	/* VN1 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 14),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D14 */
-		  SUNXI_FUNCTION(0x3, "lvds1")),	/* VP2 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lvds1",
+					 PINCTRL_SUN6I_A31)),	/* VP2 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 15),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D15 */
-		  SUNXI_FUNCTION(0x3, "lvds1")),	/* VN2 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lvds1",
+					 PINCTRL_SUN6I_A31)),	/* VN2 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 16),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D16 */
-		  SUNXI_FUNCTION(0x3, "lvds1")),	/* VPC */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lvds1",
+					 PINCTRL_SUN6I_A31)),	/* VPC */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 17),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D17 */
-		  SUNXI_FUNCTION(0x3, "lvds1")),	/* VNC */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lvds1",
+					 PINCTRL_SUN6I_A31)),	/* VNC */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 18),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D18 */
-		  SUNXI_FUNCTION(0x3, "lvds1")),	/* VP3 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lvds1",
+					 PINCTRL_SUN6I_A31)),	/* VP3 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 19),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D19 */
-		  SUNXI_FUNCTION(0x3, "lvds1")),	/* VN3 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "lvds1",
+					 PINCTRL_SUN6I_A31)),	/* VN3 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 20),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -643,7 +683,7 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
 		  SUNXI_FUNCTION(0x2, "csi"),		/* D11 */
 		  SUNXI_FUNCTION(0x3, "ts"),		/* D7 */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 15)),	/* PE_EINT15 */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 16),
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(E, 16), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* MIPI CSI MCLK */
@@ -734,13 +774,15 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "i2c3"),		/* SCK */
-		  SUNXI_FUNCTION(0x3, "usb"),		/* DP3 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "usb",
+					 PINCTRL_SUN6I_A31),	/* DP3 */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 10)),	/* PG_EINT10 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 11),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "i2c3"),		/* SDA */
-		  SUNXI_FUNCTION(0x3, "usb"),		/* DM3 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "usb",
+					 PINCTRL_SUN6I_A31),	/* DM3 */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 11)),	/* PG_EINT11 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 12),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -782,40 +824,40 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "uart4"),		/* RX */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 18)),	/* PG_EINT18 */
-	/* Hole */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 0),
+	/* Hole; H starts at pin 9 for A31s */
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(H, 0), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand1")),	/* WE */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 1),
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(H, 1), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand1")),	/* ALE */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 2),
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(H, 2), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand1")),	/* CLE */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 3),
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(H, 3), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand1")),	/* CE1 */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 4),
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(H, 4), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand1")),	/* CE0 */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 5),
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(H, 5), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand1")),	/* RE */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 6),
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(H, 6), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand1")),	/* RB0 */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 7),
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(H, 7), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand1")),	/* RB1 */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 8),
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(H, 8), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand1")),	/* DQS */
@@ -908,11 +950,12 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		/* Undocumented mux function - see above */
 		  SUNXI_FUNCTION(0x3, "spdif")),        /* SPDIF OUT */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 29),
+	/* 2 extra pins for A31 */
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(H, 29), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand1")),	/* CE2 */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 30),
+	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(H, 30), PINCTRL_SUN6I_A31,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "nand1")),	/* CE3 */
@@ -926,12 +969,23 @@ static const struct sunxi_pinctrl_desc sun6i_a31_pinctrl_data = {
 
 static int sun6i_a31_pinctrl_probe(struct platform_device *pdev)
 {
-	return sunxi_pinctrl_init(pdev,
-				  &sun6i_a31_pinctrl_data);
+	unsigned long variant =
+		(unsigned long)of_device_get_match_data(&pdev->dev);
+
+	return sunxi_pinctrl_init_with_variant(pdev,
+					       &sun6i_a31_pinctrl_data,
+					       variant);
 }
 
 static const struct of_device_id sun6i_a31_pinctrl_match[] = {
-	{ .compatible = "allwinner,sun6i-a31-pinctrl", },
+	{
+		.compatible = "allwinner,sun6i-a31-pinctrl",
+		.data = (void *)PINCTRL_SUN6I_A31
+	},
+	{
+		.compatible = "allwinner,sun6i-a31s-pinctrl",
+		.data = (void *)PINCTRL_SUN6I_A31S
+	},
 	{}
 };
 
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index 56be35387ccf..e1aedd260b2e 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -85,6 +85,8 @@
 #define PINCTRL_SUN5I_A10S	BIT(1)
 #define PINCTRL_SUN5I_A13	BIT(2)
 #define PINCTRL_SUN5I_GR8	BIT(3)
+#define PINCTRL_SUN6I_A31	BIT(4)
+#define PINCTRL_SUN6I_A31S	BIT(5)
 
 struct sunxi_desc_function {
 	unsigned long	variant;
-- 
2.11.0
