From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 27 May 2017 18:23:04 +0800
Subject: [PATCH v3 06/10] pinctrl: sunxi: add support of R40 to A10 pinctrl
 driver
In-Reply-To: <20170527102308.1988-1-icenowy@aosc.io>
References: <20170527102308.1988-1-icenowy@aosc.io>
Message-ID: <20170527102308.1988-7-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R40 is said to be an upgrade of A20, and its pin configuration is also
similar to A20 (and thus similar to A10).

Add support for R40 to the A10 pinctrl driver.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/pinctrl/sunxi/Kconfig             |   2 +-
 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c | 272 +++++++++++++++++++++---------
 2 files changed, 197 insertions(+), 77 deletions(-)

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 624d84e6c936..9d01da3b90bd 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -7,7 +7,7 @@ config PINCTRL_SUNXI
 	select GPIOLIB
 
 config PINCTRL_SUN4I_A10
-	def_bool MACH_SUN4I || MACH_SUN7I
+	def_bool MACH_SUN4I || MACH_SUN7I || MACH_SUN8I
 	select PINCTRL_SUNXI
 
 config PINCTRL_SUN5I
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
index 159580c04b14..0f6ca8391ea7 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
@@ -26,7 +26,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x3, "spi1"),		/* CS0 */
 		  SUNXI_FUNCTION(0x4, "uart2"),		/* RTS */
 		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GRXD3 */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 1),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -34,7 +35,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x3, "spi1"),		/* CLK */
 		  SUNXI_FUNCTION(0x4, "uart2"),		/* CTS */
 		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GRXD2 */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 2),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -42,7 +44,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x3, "spi1"),		/* MOSI */
 		  SUNXI_FUNCTION(0x4, "uart2"),		/* TX */
 		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GRXD1 */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 3),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -50,65 +53,75 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x3, "spi1"),		/* MISO */
 		  SUNXI_FUNCTION(0x4, "uart2"),		/* RX */
 		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GRXD0 */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 4),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ETXD3 */
 		  SUNXI_FUNCTION(0x3, "spi1"),		/* CS1 */
 		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GTXD3 */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 5),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ETXD2 */
 		  SUNXI_FUNCTION(0x3, "spi3"),		/* CS0 */
 		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GTXD2 */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 6),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ETXD1 */
 		  SUNXI_FUNCTION(0x3, "spi3"),		/* CLK */
 		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GTXD1 */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 7),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ETXD0 */
 		  SUNXI_FUNCTION(0x3, "spi3"),		/* MOSI */
 		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GTXD0 */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 8),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ERXCK */
 		  SUNXI_FUNCTION(0x3, "spi3"),		/* MISO */
 		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GRXCK */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 9),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ERXERR */
 		  SUNXI_FUNCTION(0x3, "spi3"),		/* CS1 */
 		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GNULL / ERXERR */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION_VARIANT(0x6, "i2s1",	/* MCLK */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 10),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* ERXDV */
 		  SUNXI_FUNCTION(0x4, "uart1"),		/* TX */
 		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GRXDV */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 11),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "emac"),		/* EMDC */
 		  SUNXI_FUNCTION(0x4, "uart1"),		/* RX */
 		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* EMDC */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 12),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -116,7 +129,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x3, "uart6"),		/* TX */
 		  SUNXI_FUNCTION(0x4, "uart1"),		/* RTS */
 		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* EMDIO */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 13),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -124,7 +138,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x3, "uart6"),		/* RX */
 		  SUNXI_FUNCTION(0x4, "uart1"),		/* CTS */
 		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GTXCTL / ETXEN */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 14),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -132,9 +147,11 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x3, "uart7"),		/* TX */
 		  SUNXI_FUNCTION(0x4, "uart1"),		/* DTR */
 		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GNULL / ETXCK */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION_VARIANT(0x6, "i2s1",	/* BCLK */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 15),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -142,9 +159,11 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x3, "uart7"),		/* RX */
 		  SUNXI_FUNCTION(0x4, "uart1"),		/* DSR */
 		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GTXCK / ECRS */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION_VARIANT(0x6, "i2s1",	/* LRCK */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 16),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -152,9 +171,11 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x3, "can"),		/* TX */
 		  SUNXI_FUNCTION(0x4, "uart1"),		/* DCD */
 		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GCLKIN / ECOL */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION_VARIANT(0x6, "i2s1",	/* DO */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 17),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -162,14 +183,19 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x3, "can"),		/* RX */
 		  SUNXI_FUNCTION(0x4, "uart1"),		/* RING */
 		  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GNULL / ETXERR */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION_VARIANT(0x6, "i2s1",	/* DI */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	/* Hole */
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
@@ -177,11 +203,19 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "pwm")),		/* PWM0 */
+		  SUNXI_FUNCTION_VARIANT(0x2, "pwm",	/* PWM0 */
+					 PINCTRL_SUN4I_A10 |
+					 PINCTRL_SUN7I_A20),
+		  SUNXI_FUNCTION_VARIANT(0x3, "pwm",	/* PWM0 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 3),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "ir0"),		/* TX */
+		  SUNXI_FUNCTION_VARIANT(0x2, "ir0",	/* TX */
+					 PINCTRL_SUN4I_A10 |
+					 PINCTRL_SUN7I_A20),
+		  SUNXI_FUNCTION_VARIANT(0x3, "pwm0",	/* PWM1 */
+					 PINCTRL_SUN8I_R40),
 		/*
 		 * The SPDIF block is not referenced at all in the A10 user
 		 * manual. However it is described in the code leaked and the
@@ -205,7 +239,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* MCLK */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* MCLK */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x3, "ac97")),		/* MCLK */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 6),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -213,7 +248,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* BCLK */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* BCLK */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x3, "ac97")),		/* BCLK */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 7),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -221,7 +257,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* LRCK */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* LRCK */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x3, "ac97")),		/* SYNC */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 8),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -229,7 +266,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DO0 */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DO0 */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x3, "ac97")),		/* DO */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 9),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -237,31 +275,41 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DO1 */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DO1 */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
+		  SUNXI_FUNCTION_VARIANT(0x4, "pwm",	/* PWM6 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 10),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DO2 */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DO2 */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
+		  SUNXI_FUNCTION_VARIANT(0x4, "pwm",	/* PWM7 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 11),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DO3 */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DO3 */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 12),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DI */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DI */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x3, "ac97"),		/* DI */
 		/* Undocumented mux function on A10 - See SPDIF MCLK above */
-		  SUNXI_FUNCTION(0x4, "spdif")),        /* SPDIF IN */
+		  SUNXI_FUNCTION_VARIANT(0x4, "spdif",	/* SPDIF IN */
+					 PINCTRL_SUN4I_A10 |
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 13),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -308,7 +356,9 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "uart0"),		/* TX */
-		  SUNXI_FUNCTION(0x3, "ir1")),		/* TX */
+		  SUNXI_FUNCTION_VARIANT(0x3, "ir1",	/* TX */
+					 PINCTRL_SUN4I_A10 |
+					 PINCTRL_SUN7I_A20)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 23),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -341,7 +391,9 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 5),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand0")),	/* NRE# */
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NRE# */
+		  SUNXI_FUNCTION_VARIANT(0x3, "mmc2",	/* DS */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 6),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -375,19 +427,27 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 12),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand0")),	/* NDQ4 */
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ4 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "mmc2",	/* D4 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 13),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand0")),	/* NDQ5 */
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ5 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "mmc2",	/* D5 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 14),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand0")),	/* NDQ6 */
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ6 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "mmc2",	/* D6 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 15),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand0")),	/* NDQ7 */
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ7 */
+		  SUNXI_FUNCTION_VARIANT(0x3, "mmc2",	/* D7 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 16),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -427,7 +487,9 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 24),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "nand0")),	/* NDQS */
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQS */
+		  SUNXI_FUNCTION_VARIANT(0x3, "mmc2",	/* RST */
+					 PINCTRL_SUN8I_R40)),
 	/* Hole */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 0),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -728,14 +790,18 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x2, "ts1"),		/* D5 */
 		  SUNXI_FUNCTION(0x3, "csi1"),		/* D5 */
 		  SUNXI_FUNCTION(0x4, "uart3"),		/* CTS */
-		  SUNXI_FUNCTION(0x5, "csi0")),		/* D13 */
+		  SUNXI_FUNCTION(0x5, "csi0"),		/* D13 */
+		  SUNXI_FUNCTION_VARIANT(0x6, "bist",	/* RESULT0 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 10),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "ts1"),		/* D6 */
 		  SUNXI_FUNCTION(0x3, "csi1"),		/* D6 */
 		  SUNXI_FUNCTION(0x4, "uart4"),		/* TX */
-		  SUNXI_FUNCTION(0x5, "csi0")),		/* D14 */
+		  SUNXI_FUNCTION(0x5, "csi0"),		/* D14 */
+		  SUNXI_FUNCTION_VARIANT(0x6, "bist",	/* RESULT1 */
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 11),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -805,7 +871,9 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD2 */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION(0x4, "uart5"),		/* TX */
-		  SUNXI_FUNCTION(0x5, "ms"),		/* BS */
+		  SUNXI_FUNCTION_VARIANT(0x5, "ms",	/* BS */
+					 PINCTRL_SUN4I_A10 |
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION_IRQ(0x6, 6),		/* EINT6 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D6 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 7),
@@ -815,7 +883,9 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD3 */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION(0x4, "uart5"),		/* RX */
-		  SUNXI_FUNCTION(0x5, "ms"),		/* CLK */
+		  SUNXI_FUNCTION_VARIANT(0x5, "ms",	/* CLK */
+					 PINCTRL_SUN4I_A10 |
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION_IRQ(0x6, 7),		/* EINT7 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D7 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 8),
@@ -825,9 +895,12 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD4 */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXD3 */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN0 */
-		  SUNXI_FUNCTION(0x5, "ms"),		/* D0 */
+		  SUNXI_FUNCTION_VARIANT(0x5, "ms",	/* D0 */
+					 PINCTRL_SUN4I_A10 |
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION_IRQ(0x6, 8),		/* EINT8 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D8 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 9),
@@ -837,9 +910,12 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD5 */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXD2 */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN1 */
-		  SUNXI_FUNCTION(0x5, "ms"),		/* D1 */
+		  SUNXI_FUNCTION_VARIANT(0x5, "ms",	/* D1 */
+					 PINCTRL_SUN4I_A10 |
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION_IRQ(0x6, 9),		/* EINT9 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D9 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 10),
@@ -849,9 +925,12 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD6 */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXD1 */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN2 */
-		  SUNXI_FUNCTION(0x5, "ms"),		/* D2 */
+		  SUNXI_FUNCTION_VARIANT(0x5, "ms",	/* D2 */
+					 PINCTRL_SUN4I_A10 |
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION_IRQ(0x6, 10),		/* EINT10 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D10 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 11),
@@ -861,9 +940,12 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD7 */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXD0 */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN3 */
-		  SUNXI_FUNCTION(0x5, "ms"),		/* D3 */
+		  SUNXI_FUNCTION_VARIANT(0x5, "ms",	/* D3 */
+					 PINCTRL_SUN4I_A10 |
+					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION_IRQ(0x6, 11),		/* EINT11 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D11 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 12),
@@ -892,7 +974,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD10 */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXD3 */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN4 */
 		  SUNXI_FUNCTION(0x5, "sim"),		/* VPPEN */
 		  SUNXI_FUNCTION_IRQ(0x6, 14),		/* EINT14 */
@@ -904,7 +987,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD11 */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXD2 */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN5 */
 		  SUNXI_FUNCTION(0x5, "sim"),		/* VPPPP */
 		  SUNXI_FUNCTION_IRQ(0x6, 15),		/* EINT15 */
@@ -916,7 +1000,10 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD12 */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXD1 */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
+		  SUNXI_FUNCTION_VARIANT(0x5, "sim",	/* DET */
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN6 */
 		  SUNXI_FUNCTION_IRQ(0x6, 16),		/* EINT16 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D16 */
@@ -927,7 +1014,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD13 */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXD0 */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN7 */
 		  SUNXI_FUNCTION(0x5, "sim"),		/* VCCEN */
 		  SUNXI_FUNCTION_IRQ(0x6, 17),		/* EINT17 */
@@ -939,7 +1027,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD14 */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXCK */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT0 */
 		  SUNXI_FUNCTION(0x5, "sim"),		/* SCK */
 		  SUNXI_FUNCTION_IRQ(0x6, 18),		/* EINT18 */
@@ -951,7 +1040,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD15 */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXERR */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT1 */
 		  SUNXI_FUNCTION(0x5, "sim"),		/* SDA */
 		  SUNXI_FUNCTION_IRQ(0x6, 19),		/* EINT19 */
@@ -963,7 +1053,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAOE */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXDV */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "can"),		/* TX */
 		  SUNXI_FUNCTION_IRQ(0x6, 20),		/* EINT20 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D20 */
@@ -974,7 +1065,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATADREQ */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* EMDC */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "can"),		/* RX */
 		  SUNXI_FUNCTION_IRQ(0x6, 21),		/* EINT21 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D21 */
@@ -985,7 +1077,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATADACK */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* EMDIO */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT2 */
 		  SUNXI_FUNCTION(0x5, "mmc1"),		/* CMD */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D22 */
@@ -996,7 +1089,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATACS0 */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXEN */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT3 */
 		  SUNXI_FUNCTION(0x5, "mmc1"),		/* CLK */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D23 */
@@ -1007,7 +1101,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATACS1 */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXCK */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT4 */
 		  SUNXI_FUNCTION(0x5, "mmc1"),		/* D0 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* PCLK */
@@ -1018,7 +1113,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAIORDY */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ECRS */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT5 */
 		  SUNXI_FUNCTION(0x5, "mmc1"),		/* D1 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* FIELD */
@@ -1029,7 +1125,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAIOR */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ECOL */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT6 */
 		  SUNXI_FUNCTION(0x5, "mmc1"),		/* D2 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* HSYNC */
@@ -1040,7 +1137,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAIOW */
 					 PINCTRL_SUN4I_A10),
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXERR */
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT7 */
 		  SUNXI_FUNCTION(0x5, "mmc1"),		/* D3 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* VSYNC */
@@ -1049,23 +1147,27 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION_VARIANT(0x3, "i2c3",	/* SCK */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 1),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION_VARIANT(0x3, "i2c3",	/* SDA */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 2),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION_VARIANT(0x3, "i2c4",	/* SCK */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 3),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "pwm"),		/* PWM1 */
 		  SUNXI_FUNCTION_VARIANT(0x3, "i2c3",	/* SDA */
-					 PINCTRL_SUN7I_A20)),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 4),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -1108,7 +1210,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x2, "spi0"),		/* MOSI */
 		  SUNXI_FUNCTION(0x3, "uart6"),		/* TX */
 		  SUNXI_FUNCTION_VARIANT(0x4, "clk_out_a",
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION_IRQ(0x6, 24)),		/* EINT24 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 13),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -1116,7 +1219,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x2, "spi0"),		/* MISO */
 		  SUNXI_FUNCTION(0x3, "uart6"),		/* RX */
 		  SUNXI_FUNCTION_VARIANT(0x4, "clk_out_b",
-					 PINCTRL_SUN7I_A20),
+					 PINCTRL_SUN7I_A20 |
+					 PINCTRL_SUN8I_R40),
 		  SUNXI_FUNCTION_IRQ(0x6, 25)),		/* EINT25 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 14),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -1161,13 +1265,25 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "ps2"),		/* SCK0 */
 		  SUNXI_FUNCTION(0x3, "uart7"),		/* TX */
-		  SUNXI_FUNCTION(0x4, "hdmi")),		/* HSCL */
+		  SUNXI_FUNCTION_VARIANT(0x4,
+					 "hdmi",	/* HSCL */
+					 PINCTRL_SUN4I_A10 |
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
+					 PINCTRL_SUN4I_A10 |
+					 PINCTRL_SUN7I_A20),
+		  SUNXI_FUNCTION_VARIANT(0x6,
+					 "pwm",		/* PWM3 */
+					 PINCTRL_SUN8I_R40)),
 };
 
 static const struct sunxi_pinctrl_desc sun4i_a10_pinctrl_data = {
@@ -1194,6 +1310,10 @@ static const struct of_device_id sun4i_a10_pinctrl_match[] = {
 		.compatible = "allwinner,sun7i-a20-pinctrl",
 		.data = (void *)PINCTRL_SUN7I_A20
 	},
+	{
+		.compatible = "allwinner,sun8i-r40-pinctrl",
+		.data = (void *)PINCTRL_SUN8I_R40
+	},
 	{}
 };
 
-- 
2.12.2
