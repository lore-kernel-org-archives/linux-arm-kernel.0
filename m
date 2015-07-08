From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  8 Jul 2015 15:15:22 +0200
Subject: [PATCH 2/2] ARM: ux500: fix MMC/SD card regression
Message-ID: <1436361322-27732-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ux500 is regressing due to commit
a21763a0b1e5a5ab8310f581886d04beadc16616
"pinctrl: nomadik: activate strict mux mode" which disallows
Nomadik GPIO 5 to be muxed in as a level shifter voltage select
pin, as it is currently described as being used for RX on UART1.

The behaviour is correct, instead the hardware config has been
incorrecly specified: UART1 is indeed unused on HREFv60plus and
Snowball and that is why HREFv60plus can use the pins it would
normally occupy as the voltage select line for the MMC/SD
levelshifter (Snowball uses it for I2C4).

The reason UART1 was anyway enabled on these platforms was
probably to secure the port enumeration to userspace. This
can be solved by using aliases (done in a separate patch) so
we can now deactivate UART1 and let MMC/SD use it properly
on HREFv60plus. We explicitly activate it only for the
older HREFprev60 board.

To complete, we set up the pin configuration for these pins
properly in the sdi0 node.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC guys: if it looks OK, please apply this patch directly
for fixes along with 1/1.
---
 arch/arm/boot/dts/ste-href.dtsi        |  2 +-
 arch/arm/boot/dts/ste-hrefprev60.dtsi  |  5 +++++
 arch/arm/boot/dts/ste-hrefv60plus.dtsi | 25 +++++++++++++++++++++++--
 arch/arm/boot/dts/ste-snowball.dts     | 18 ++++++++++++++++--
 4 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 744c1e3a744d..6d8ce154347e 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -32,11 +32,11 @@
 			status = "okay";
 		};
 
+		/* This UART is unused and thus left disabled */
 		uart at 80121000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&uart1_default_mode>;
 			pinctrl-1 = <&uart1_sleep_mode>;
-			status = "okay";
 		};
 
 		uart at 80007000 {
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dtsi b/arch/arm/boot/dts/ste-hrefprev60.dtsi
index 7f3975b58d16..b0278f4c486c 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dtsi
+++ b/arch/arm/boot/dts/ste-hrefprev60.dtsi
@@ -23,6 +23,11 @@
 	};
 
 	soc {
+		/* Enable UART1 on this board */
+		uart at 80121000 {
+			status = "okay";
+		};
+
 		i2c at 80004000 {
 			tps61052 at 33 {
 				compatible = "tps61052";
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
index a4bc9e77d640..810cda743b6d 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dtsi
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
@@ -43,15 +43,26 @@
 				  <&vaudio_hf_hrefv60_mode>,
 				  <&gbf_hrefv60_mode>,
 				  <&hdtv_hrefv60_mode>,
-				  <&touch_hrefv60_mode>;
+				  <&touch_hrefv60_mode>,
+				  <&gpios_hrefv60_mode>;
 
 			sdi0 {
-				/* SD card detect GPIO pin, extend default state */
 				sdi0_default_mode: sdi0_default {
+					/* SD card detect GPIO pin, extend default state */
 					default_hrefv60_cfg1 {
 						pins = "GPIO95_E8";
 						ste,config = <&gpio_in_pu>;
 					};
+					/* VMMCI level-shifter enable */
+					default_hrefv60_cfg2 {
+						pins = "GPIO169_D22";
+						ste,config = <&gpio_out_lo>;
+					};
+					/* VMMCI level-shifter voltage select */
+					default_hrefv60_cfg3 {
+						pins = "GPIO5_AG6";
+						ste,config = <&gpio_out_hi>;
+					};
 				};
 			};
 			ipgpio {
@@ -213,6 +224,16 @@
 					};
 				};
 			};
+			gpios {
+				/* Dangling GPIO pins */
+				gpios_hrefv60_mode: gpios_hrefv60 {
+					default_cfg1 {
+						/* Normally UART1 RXD, now dangling */
+						pins = "GPIO4_AH6";
+						ste,config = <&in_pu>;
+					};
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 9edadc37719f..70dfcbb48d3f 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -223,11 +223,11 @@
 			status = "okay";
 		};
 
+		/* This UART is unused and thus left disabled */
 		uart at 80121000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&uart1_default_mode>;
 			pinctrl-1 = <&uart1_sleep_mode>;
-			status = "okay";
 		};
 
 		uart at 80007000 {
@@ -452,7 +452,21 @@
 						pins = "GPIO21_AB3"; /* DAT31DIR */
 						ste,config = <&out_hi>;
 					};
-
+					/* SD card detect GPIO pin, extend default state */
+					snowball_cfg2 {
+						pins = "GPIO218_AH11";
+						ste,config = <&gpio_in_pu>;
+					};
+					/* VMMCI level-shifter enable */
+					snowball_cfg3 {
+						pins = "GPIO217_AH12";
+						ste,config = <&gpio_out_lo>;
+					};
+					/* VMMCI level-shifter voltage select */
+					snowball_cfg4 {
+						pins = "GPIO228_AJ6";
+						ste,config = <&gpio_out_hi>;
+					};
 				};
 			};
 			ssp0 {
-- 
2.4.3
