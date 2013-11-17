From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:04:07 +0100
Subject: [PATCH 18/21] ARM: ux500: move snowball ethernet config to device tree
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-19-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This transfers the muxing and biasing of the ethernet-related
pins on the snowball over to the device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-snowball.dts      | 25 +++++++++++++++++++++++++
 arch/arm/mach-ux500/board-mop500-pins.c |  4 ----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 53febe58a1cb..4f5457a91589 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -130,6 +130,8 @@
 				interrupt-parent = <&gpio4>;
 				vdd33a-supply = <&en_3v3_reg>;
 				vddvario-supply = <&db8500_vape_reg>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&eth_snowball_mode>;
 
 				reg-shift = <1>;
 				reg-io-width = <2>;
@@ -348,6 +350,29 @@
 		};
 
 		pinctrl {
+			ethernet {
+				/*
+				 * Mux in "SM" which is used for the
+				 * SMSC911x Ethernet adapter
+				 */
+				eth_snowball_mode: eth_snowball {
+					snowball_mux {
+						ste,function = "sm";
+						ste,pins = "sm_b_1";
+					};
+					/* LAN IRQ pin */
+					snowball_cfg1 {
+						ste,pins = "GPIO140_B11";
+						ste,config = <&in_nopull>;
+					};
+					/* LAN reset pin */
+					snowball_cfg2 {
+						ste,pins = "GPIO141_C12";
+						ste,config = <&gpio_out_hi>;
+					};
+
+				};
+			};
 			sdi0 {
 				sdi0_default_mode: sdi0_default {
 					snowball_mux {
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 71ee944ea70f..55da56e39974 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -302,12 +302,8 @@ static struct pinctrl_map __initdata snowball_pinmap[] = {
 	/* Mux in SSP0 connected to AB8500, pull down RXD pin */
 	DB8500_MUX_HOG("ssp0_a_1", "ssp0"),
 	DB8500_PIN_HOG("GPIO145_C13", pd),
-	/* Mux in "SM" which is used for the SMSC911x Ethernet adapter */
-	DB8500_MUX_HOG("sm_b_1", "sm"),
 	/* User LED */
 	DB8500_PIN_HOG("GPIO142_C11", gpio_out_hi),
-	/* Drive RSTn_LAN high */
-	DB8500_PIN_HOG("GPIO141_C12", gpio_out_hi),
 	/*  Accelerometer/Magnetometer */
 	DB8500_PIN_HOG("GPIO163_C20", gpio_in_pu), /* ACCEL_IRQ1 */
 	DB8500_PIN_HOG("GPIO164_B21", gpio_in_pu), /* ACCEL_IRQ2 */
-- 
1.8.3.1
