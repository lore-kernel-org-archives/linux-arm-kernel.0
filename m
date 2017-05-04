From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu,  4 May 2017 21:49:59 +0800
Subject: [PATCH v2 03/10] pinctrl: sunxi: add A20 support to A10 driver
In-Reply-To: <20170504135006.16483-1-icenowy@aosc.io>
References: <20170504135006.16483-1-icenowy@aosc.io>
Message-ID: <20170504135006.16483-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As A20 is designed as a pin-compatible upgrade of A10, their pin
controller are very similar, and can share one driver.

Add A20 support to the A10 driver.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c | 287 +++++++++++++++++++++++-------
 1 file changed, 224 insertions(+), 63 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
index fb30b86a97ee..159580c04b14 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
@@ -24,101 +24,147 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ERXD3 */
 		  SUNXI_FUNCTION(0x3, "spi1"),		/* CS0 */
-		  SUNXI_FUNCTION(0x4, "uart2")),	/* RTS */
+		  SUNXI_FUNCTION(0x4, "uart2"),		/* RTS */
+		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GRXD3 */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 1),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ERXD2 */
 		  SUNXI_FUNCTION(0x3, "spi1"),		/* CLK */
-		  SUNXI_FUNCTION(0x4, "uart2")),	/* CTS */
+		  SUNXI_FUNCTION(0x4, "uart2"),		/* CTS */
+		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GRXD2 */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 2),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ERXD1 */
 		  SUNXI_FUNCTION(0x3, "spi1"),		/* MOSI */
-		  SUNXI_FUNCTION(0x4, "uart2")),	/* TX */
+		  SUNXI_FUNCTION(0x4, "uart2"),		/* TX */
+		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GRXD1 */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 3),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ERXD0 */
 		  SUNXI_FUNCTION(0x3, "spi1"),		/* MISO */
-		  SUNXI_FUNCTION(0x4, "uart2")),	/* RX */
+		  SUNXI_FUNCTION(0x4, "uart2"),		/* RX */
+		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GRXD0 */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 4),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ETXD3 */
-		  SUNXI_FUNCTION(0x3, "spi1")),		/* CS1 */
+		  SUNXI_FUNCTION(0x3, "spi1"),		/* CS1 */
+		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GTXD3 */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 5),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ETXD2 */
-		  SUNXI_FUNCTION(0x3, "spi3")),		/* CS0 */
+		  SUNXI_FUNCTION(0x3, "spi3"),		/* CS0 */
+		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GTXD2 */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 6),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ETXD1 */
-		  SUNXI_FUNCTION(0x3, "spi3")),		/* CLK */
+		  SUNXI_FUNCTION(0x3, "spi3"),		/* CLK */
+		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GTXD1 */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 7),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ETXD0 */
-		  SUNXI_FUNCTION(0x3, "spi3")),		/* MOSI */
+		  SUNXI_FUNCTION(0x3, "spi3"),		/* MOSI */
+		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GTXD0 */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 8),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ERXCK */
-		  SUNXI_FUNCTION(0x3, "spi3")),		/* MISO */
+		  SUNXI_FUNCTION(0x3, "spi3"),		/* MISO */
+		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GRXCK */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 9),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ERXERR */
-		  SUNXI_FUNCTION(0x3, "spi3")),		/* CS1 */
+		  SUNXI_FUNCTION(0x3, "spi3"),		/* CS1 */
+		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GNULL / ERXERR */
+					 PINCTRL_SUN7I_A20),
+		  SUNXI_FUNCTION_VARIANT(0x6, "i2s1",	/* MCLK */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 10),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ERXDV */
-		  SUNXI_FUNCTION(0x4, "uart1")),	/* TX */
+		  SUNXI_FUNCTION(0x4, "uart1"),		/* TX */
+		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GRXDV */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 11),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* EMDC */
-		  SUNXI_FUNCTION(0x4, "uart1")),	/* RX */
+		  SUNXI_FUNCTION(0x4, "uart1"),		/* RX */
+		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* EMDC */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 12),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* EMDIO */
 		  SUNXI_FUNCTION(0x3, "uart6"),		/* TX */
-		  SUNXI_FUNCTION(0x4, "uart1")),	/* RTS */
+		  SUNXI_FUNCTION(0x4, "uart1"),		/* RTS */
+		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* EMDIO */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 13),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ETXEN */
 		  SUNXI_FUNCTION(0x3, "uart6"),		/* RX */
-		  SUNXI_FUNCTION(0x4, "uart1")),	/* CTS */
+		  SUNXI_FUNCTION(0x4, "uart1"),		/* CTS */
+		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GTXCTL / ETXEN */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 14),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ETXCK */
 		  SUNXI_FUNCTION(0x3, "uart7"),		/* TX */
-		  SUNXI_FUNCTION(0x4, "uart1")),	/* DTR */
+		  SUNXI_FUNCTION(0x4, "uart1"),		/* DTR */
+		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GNULL / ETXCK */
+					 PINCTRL_SUN7I_A20),
+		  SUNXI_FUNCTION_VARIANT(0x6, "i2s1",	/* BCLK */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 15),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ECRS */
 		  SUNXI_FUNCTION(0x3, "uart7"),		/* RX */
-		  SUNXI_FUNCTION(0x4, "uart1")),	/* DSR */
+		  SUNXI_FUNCTION(0x4, "uart1"),		/* DSR */
+		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GTXCK / ECRS */
+					 PINCTRL_SUN7I_A20),
+		  SUNXI_FUNCTION_VARIANT(0x6, "i2s1",	/* LRCK */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 16),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ECOL */
 		  SUNXI_FUNCTION(0x3, "can"),		/* TX */
-		  SUNXI_FUNCTION(0x4, "uart1")),	/* DCD */
+		  SUNXI_FUNCTION(0x4, "uart1"),		/* DCD */
+		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GCLKIN / ECOL */
+					 PINCTRL_SUN7I_A20),
+		  SUNXI_FUNCTION_VARIANT(0x6, "i2s1",	/* DO */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 17),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ETXERR */
 		  SUNXI_FUNCTION(0x3, "can"),		/* RX */
-		  SUNXI_FUNCTION(0x4, "uart1")),	/* RING */
+		  SUNXI_FUNCTION(0x4, "uart1"),		/* RING */
+		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GNULL / ETXERR */
+					 PINCTRL_SUN7I_A20),
+		  SUNXI_FUNCTION_VARIANT(0x6, "i2s1",	/* DI */
+					 PINCTRL_SUN7I_A20)),
 	/* Hole */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 0),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -150,47 +196,77 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 5),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "i2s"),		/* MCLK */
+		  /*
+		   * On A10 there's only one I2S controller and the pin group
+		   * is simply named "i2s". On A20 there's two and thus it's
+		   * renamed to "i2s0". Deal with these name here, in order
+		   * to satisfy existing device trees.
+		   */
+		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* MCLK */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* MCLK */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x3, "ac97")),		/* MCLK */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 6),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "i2s"),		/* BCLK */
+		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* BCLK */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* BCLK */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x3, "ac97")),		/* BCLK */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 7),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "i2s"),		/* LRCK */
+		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* LRCK */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* LRCK */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x3, "ac97")),		/* SYNC */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 8),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "i2s"),		/* DO0 */
+		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DO0 */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DO0 */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x3, "ac97")),		/* DO */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 9),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "i2s")),		/* DO1 */
+		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DO1 */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DO1 */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 10),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "i2s")),		/* DO2 */
+		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DO2 */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DO2 */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 11),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "i2s")),		/* DO3 */
+		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DO3 */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DO3 */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 12),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "i2s"),		/* DI */
+		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DI */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DI */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x3, "ac97"),		/* DI */
-		/* Undocumented mux function - See SPDIF MCLK above */
+		/* Undocumented mux function on A10 - See SPDIF MCLK above */
 		  SUNXI_FUNCTION(0x4, "spdif")),        /* SPDIF IN */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 13),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi2"),		/* CS1 */
-		/* Undocumented mux function - See SPDIF MCLK above */
+		/* Undocumented mux function on A10 - See SPDIF MCLK above */
 		  SUNXI_FUNCTION(0x4, "spdif")),        /* SPDIF OUT */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 14),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -672,7 +748,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D0 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAA0 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAA0 */
+					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION(0x4, "uart3"),		/* TX */
 		  SUNXI_FUNCTION_IRQ(0x6, 0),		/* EINT0 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D0 */
@@ -680,7 +757,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D1 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAA1 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAA1 */
+					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION(0x4, "uart3"),		/* RX */
 		  SUNXI_FUNCTION_IRQ(0x6, 1),		/* EINT1 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D1 */
@@ -688,7 +766,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D2 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAA2 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAA2 */
+					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION(0x4, "uart3"),		/* RTS */
 		  SUNXI_FUNCTION_IRQ(0x6, 2),		/* EINT2 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D2 */
@@ -696,7 +775,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D3 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAIRQ */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAIRQ */
+					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION(0x4, "uart3"),		/* CTS */
 		  SUNXI_FUNCTION_IRQ(0x6, 3),		/* EINT3 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D3 */
@@ -704,7 +784,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D4 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAD0 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD0 */
+					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION(0x4, "uart4"),		/* TX */
 		  SUNXI_FUNCTION_IRQ(0x6, 4),		/* EINT4 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D4 */
@@ -712,7 +793,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D5 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAD1 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD1 */
+					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION(0x4, "uart4"),		/* RX */
 		  SUNXI_FUNCTION_IRQ(0x6, 5),		/* EINT5 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D5 */
@@ -720,7 +802,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D6 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAD2 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD2 */
+					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION(0x4, "uart5"),		/* TX */
 		  SUNXI_FUNCTION(0x5, "ms"),		/* BS */
 		  SUNXI_FUNCTION_IRQ(0x6, 6),		/* EINT6 */
@@ -729,7 +812,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D7 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAD3 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD3 */
+					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION(0x4, "uart5"),		/* RX */
 		  SUNXI_FUNCTION(0x5, "ms"),		/* CLK */
 		  SUNXI_FUNCTION_IRQ(0x6, 7),		/* EINT7 */
@@ -738,7 +822,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D8 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAD4 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD4 */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXD3 */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN0 */
 		  SUNXI_FUNCTION(0x5, "ms"),		/* D0 */
 		  SUNXI_FUNCTION_IRQ(0x6, 8),		/* EINT8 */
@@ -747,7 +834,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D9 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAD5 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD5 */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXD2 */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN1 */
 		  SUNXI_FUNCTION(0x5, "ms"),		/* D1 */
 		  SUNXI_FUNCTION_IRQ(0x6, 9),		/* EINT9 */
@@ -756,7 +846,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D10 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAD6 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD6 */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXD1 */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN2 */
 		  SUNXI_FUNCTION(0x5, "ms"),		/* D2 */
 		  SUNXI_FUNCTION_IRQ(0x6, 10),		/* EINT10 */
@@ -765,7 +858,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D11 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAD7 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD7 */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXD0 */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN3 */
 		  SUNXI_FUNCTION(0x5, "ms"),		/* D3 */
 		  SUNXI_FUNCTION_IRQ(0x6, 11),		/* EINT11 */
@@ -774,7 +870,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D12 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAD8 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD8 */
+					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION(0x4, "ps2"),		/* SCK1 */
 		  SUNXI_FUNCTION_IRQ(0x6, 12),		/* EINT12 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D12 */
@@ -782,7 +879,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D13 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAD9 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD9 */
+					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION(0x4, "ps2"),		/* SDA1 */
 		  SUNXI_FUNCTION(0x5, "sim"),		/* RST */
 		  SUNXI_FUNCTION_IRQ(0x6, 13),		/* EINT13 */
@@ -791,7 +889,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D14 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAD10 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD10 */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXD3 */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN4 */
 		  SUNXI_FUNCTION(0x5, "sim"),		/* VPPEN */
 		  SUNXI_FUNCTION_IRQ(0x6, 14),		/* EINT14 */
@@ -800,7 +901,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D15 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAD11 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD11 */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXD2 */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN5 */
 		  SUNXI_FUNCTION(0x5, "sim"),		/* VPPPP */
 		  SUNXI_FUNCTION_IRQ(0x6, 15),		/* EINT15 */
@@ -809,7 +913,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D16 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAD12 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD12 */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXD1 */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN6 */
 		  SUNXI_FUNCTION_IRQ(0x6, 16),		/* EINT16 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D16 */
@@ -817,7 +924,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D17 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAD13 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD13 */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXD0 */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN7 */
 		  SUNXI_FUNCTION(0x5, "sim"),		/* VCCEN */
 		  SUNXI_FUNCTION_IRQ(0x6, 17),		/* EINT17 */
@@ -826,7 +936,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D18 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAD14 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD14 */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXCK */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT0 */
 		  SUNXI_FUNCTION(0x5, "sim"),		/* SCK */
 		  SUNXI_FUNCTION_IRQ(0x6, 18),		/* EINT18 */
@@ -835,7 +948,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D19 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAD15 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD15 */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXERR */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT1 */
 		  SUNXI_FUNCTION(0x5, "sim"),		/* SDA */
 		  SUNXI_FUNCTION_IRQ(0x6, 19),		/* EINT19 */
@@ -844,7 +960,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D20 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAOE */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAOE */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXDV */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "can"),		/* TX */
 		  SUNXI_FUNCTION_IRQ(0x6, 20),		/* EINT20 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D20 */
@@ -852,7 +971,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D21 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATADREQ */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATADREQ */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* EMDC */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "can"),		/* RX */
 		  SUNXI_FUNCTION_IRQ(0x6, 21),		/* EINT21 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D21 */
@@ -860,7 +982,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D22 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATADACK */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATADACK */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* EMDIO */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT2 */
 		  SUNXI_FUNCTION(0x5, "mmc1"),		/* CMD */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D22 */
@@ -868,7 +993,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* D23 */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATACS0 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATACS0 */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXEN */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT3 */
 		  SUNXI_FUNCTION(0x5, "mmc1"),		/* CLK */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D23 */
@@ -876,7 +1004,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* CLK */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATACS1 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATACS1 */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXCK */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT4 */
 		  SUNXI_FUNCTION(0x5, "mmc1"),		/* D0 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* PCLK */
@@ -884,7 +1015,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* DE */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAIORDY */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAIORDY */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ECRS */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT5 */
 		  SUNXI_FUNCTION(0x5, "mmc1"),		/* D1 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* FIELD */
@@ -892,7 +1026,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* HSYNC */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAIOR */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAIOR */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ECOL */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT6 */
 		  SUNXI_FUNCTION(0x5, "mmc1"),		/* D2 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* HSYNC */
@@ -900,24 +1037,35 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd1"),		/* VSYNC */
-		  SUNXI_FUNCTION(0x3, "pata"),		/* ATAIOW */
+		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAIOW */
+					 PINCTRL_SUN4I_A10),
+		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXERR */
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT7 */
 		  SUNXI_FUNCTION(0x5, "mmc1"),		/* D3 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* VSYNC */
 	/* Hole */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 0),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out")),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_VARIANT(0x3, "i2c3",	/* SCK */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 1),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out")),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_VARIANT(0x3, "i2c3",	/* SDA */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 2),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out")),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_VARIANT(0x3, "i2c4",	/* SCK */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 3),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "pwm")),		/* PWM1 */
+		  SUNXI_FUNCTION(0x2, "pwm"),		/* PWM1 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "i2c3",	/* SDA */
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 4),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -959,12 +1107,16 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi0"),		/* MOSI */
 		  SUNXI_FUNCTION(0x3, "uart6"),		/* TX */
+		  SUNXI_FUNCTION_VARIANT(0x4, "clk_out_a",
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION_IRQ(0x6, 24)),		/* EINT24 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 13),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi0"),		/* MISO */
 		  SUNXI_FUNCTION(0x3, "uart6"),		/* RX */
+		  SUNXI_FUNCTION_VARIANT(0x4, "clk_out_b",
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION_IRQ(0x6, 25)),		/* EINT25 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 14),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -1027,12 +1179,21 @@ static const struct sunxi_pinctrl_desc sun4i_a10_pinctrl_data = {
 
 static int sun4i_a10_pinctrl_probe(struct platform_device *pdev)
 {
-	return sunxi_pinctrl_init(pdev,
-				  &sun4i_a10_pinctrl_data);
+	unsigned long variant = (unsigned long)of_device_get_match_data(&pdev->dev);
+
+	return sunxi_pinctrl_init_with_variant(pdev, &sun4i_a10_pinctrl_data,
+					       variant);
 }
 
 static const struct of_device_id sun4i_a10_pinctrl_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-pinctrl", },
+	{
+		.compatible = "allwinner,sun4i-a10-pinctrl",
+		.data = (void *)PINCTRL_SUN4I_A10
+	},
+	{
+		.compatible = "allwinner,sun7i-a20-pinctrl",
+		.data = (void *)PINCTRL_SUN7I_A20
+	},
 	{}
 };
 
-- 
2.12.2
