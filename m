From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:04:08 +0100
Subject: [PATCH 19/21] ARM: ux500: convert Snowball SPI pin reference
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-20-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPI0 block is not at all connected to the AB8500 on the
Snowball: it is connected to the external header. These pins
on the header may also be used for GPIO, but let's assume
that SPI is a probable usecase on the Snowball and mux in the
SPI block and use these for SPI.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-snowball.dts      | 28 ++++++++++++++++++++++++++++
 arch/arm/mach-ux500/board-mop500-pins.c |  5 -----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 4f5457a91589..744ab956059a 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -248,6 +248,11 @@
 			pinctrl-1 = <&i2c3_sleep_mode>;
 		};
 
+		ssp at 80002000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&ssp0_snowball_mode>;
+		};
+
 		cpufreq-cooling {
 			status = "okay";
 		};
@@ -386,6 +391,29 @@
 
 				};
 			};
+			ssp0 {
+				ssp0_snowball_mode: ssp0_snowball_default {
+					snowball_mux {
+						ste,function = "ssp0";
+						ste,pins = "ssp0_a_1";
+					};
+					snowball_cfg1 {
+						ste,pins = "GPIO144_B13"; /* FRM */
+						ste,config = <&gpio_out_hi>;
+					};
+					snowball_cfg2 {
+						ste,pins = "GPIO145_C13"; /* RXD */
+						ste,config = <&in_pd>;
+					};
+					snowball_cfg3 {
+						ste,pins =
+						"GPIO146_D13", /* TXD */
+						"GPIO143_D12"; /* CLK */
+						ste,config = <&out_lo>;
+					};
+
+				};
+			};
 		};
 
 		mcde at a0350000 {
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 55da56e39974..0e5d2684bc9a 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -19,8 +19,6 @@
 /* These simply sets bias for pins */
 #define BIAS(a,b) static unsigned long a[] = { b }
 
-BIAS(pd, PIN_PULL_DOWN);
-
 BIAS(abx500_out_lo, PIN_CONF_PACKED(PIN_CONFIG_OUTPUT, 0));
 BIAS(abx500_in_pd, PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN, 1));
 BIAS(abx500_in_nopull, PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN, 0));
@@ -299,9 +297,6 @@ static struct pinctrl_map __initdata ab8505_pinmap[] = {
 };
 
 static struct pinctrl_map __initdata snowball_pinmap[] = {
-	/* Mux in SSP0 connected to AB8500, pull down RXD pin */
-	DB8500_MUX_HOG("ssp0_a_1", "ssp0"),
-	DB8500_PIN_HOG("GPIO145_C13", pd),
 	/* User LED */
 	DB8500_PIN_HOG("GPIO142_C11", gpio_out_hi),
 	/*  Accelerometer/Magnetometer */
-- 
1.8.3.1
