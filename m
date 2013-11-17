From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:04:04 +0100
Subject: [PATCH 15/21] ARM: ux500: move the HREFv60plus IPGPIO pins to device
 tree
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-16-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the control of muxing and enabling the IPGPIO (image
processor GPIO) from the static set-up to the device tree.
Use a hog as we have no device for the flash controller yet.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-hrefv60plus.dtsi  | 31 +++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/board-mop500-pins.c | 16 ----------------
 2 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
index 6e0105d2f461..ecd26848f24f 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dtsi
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
@@ -62,6 +62,10 @@
 		};
 
 		pinctrl {
+			/* Set this up using hogs */
+			pinctrl-names = "default";
+			pinctrl-0 = <&ipgpio_hrefv60_mode>;
+
 			sdi0 {
 				/* SD card detect GPIO pin, extend default state */
 				sdi0_default_mode: sdi0_default {
@@ -71,6 +75,33 @@
 					};
 				};
 			};
+			ipgpio {
+				/*
+				 * XENON Flashgun on image processor GPIO (controlled from image
+				 * processor firmware), mux in these image processor GPIO lines 0
+				 * (XENON_FLASH_ID), 1 (XENON_READY) and there is an assistant
+				 * LED on IP GPIO 4 (XENON_EN2) on altfunction C, that need bias
+				 * from GPIO21 so pull up 0, 1 and drive 4 and GPIO21 low as output.
+				 */
+				ipgpio_hrefv60_mode: ipgpio_hrefv60 {
+					hrefv60_mux {
+						ste,function = "ipgpio";
+						ste,pins = "ipgpio0_c_1", "ipgpio1_c_1", "ipgpio4_c_1";
+					};
+					hrefv60_cfg1 {
+						ste,pins = "GPIO6_AF6", "GPIO7_AG5";
+						ste,config = <&in_pu>;
+					};
+					hrefv60_cfg2 {
+						ste,pins = "GPIO21_AB3";
+						ste,config = <&gpio_out_lo>;
+					};
+					hrefv60_cfg3 {
+						ste,pins = "GPIO64_F3";
+						ste,config = <&out_lo>;
+					};
+				 };
+			};
 		};
 	};
 };
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index d0d527a3d205..e208dddfeda9 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -20,8 +20,6 @@
 #define BIAS(a,b) static unsigned long a[] = { b }
 
 BIAS(pd, PIN_PULL_DOWN);
-BIAS(in_pu, PIN_INPUT_PULLUP);
-BIAS(out_lo, PIN_OUTPUT_LOW);
 
 BIAS(abx500_out_lo, PIN_CONF_PACKED(PIN_CONFIG_OUTPUT, 0));
 BIAS(abx500_in_pd, PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN, 1));
@@ -307,20 +305,6 @@ static struct pinctrl_map __initdata ab8505_pinmap[] = {
  * and SSP1 ports (previously connected to the AB8500) as generic GPIO lines.
  */
 static struct pinctrl_map __initdata hrefv60_pinmap[] = {
-	/*
-	 * XENON Flashgun on image processor GPIO (controlled from image
-	 * processor firmware), mux in these image processor GPIO lines 0
-	 * (XENON_FLASH_ID), 1 (XENON_READY) and there is an assistant
-	 * LED on IP GPIO 4 (XENON_EN2) on altfunction C, that need bias
-	 * from GPIO21 so pull up 0, 1 and drive 4 and GPIO21 low as output.
-	 */
-	DB8500_MUX_HOG("ipgpio0_c_1", "ipgpio"),
-	DB8500_MUX_HOG("ipgpio1_c_1", "ipgpio"),
-	DB8500_MUX_HOG("ipgpio4_c_1", "ipgpio"),
-	DB8500_PIN_HOG("GPIO6_AF6", in_pu), /* XENON_FLASH_ID */
-	DB8500_PIN_HOG("GPIO7_AG5", in_pu), /* XENON_READY */
-	DB8500_PIN_HOG("GPIO21_AB3", gpio_out_lo), /* XENON_EN1 */
-	DB8500_PIN_HOG("GPIO64_F3", out_lo), /* XENON_EN2 */
 	/* Magnetometer uses GPIO 31 and 32, pull these up/down respectively */
 	DB8500_PIN_HOG("GPIO31_V3", gpio_in_pu), /* EN1 */
 	DB8500_PIN_HOG("GPIO32_V2", gpio_in_pd), /* DRDY */
-- 
1.8.3.1
