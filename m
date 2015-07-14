From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 14 Jul 2015 15:39:48 +0200
Subject: [PATCH 13/17] ARM: dts: lpc4357-ea4357: add gpio joystick
In-Reply-To: <1436881192-23930-1-git-send-email-manabian@gmail.com>
References: <1436881192-23930-1-git-send-email-manabian@gmail.com>
Message-ID: <1436881192-23930-14-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook up the small joystick found on the EA4357 devkit.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 52 +++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
index d02f93f19bf5..ee9d97350d34 100644
--- a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
+++ b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
@@ -15,6 +15,9 @@
 #include "lpc18xx.dtsi"
 #include "lpc4357.dtsi"
 
+#include "dt-bindings/input/input.h"
+#include "dt-bindings/gpio/gpio.h"
+
 / {
 	model = "Embedded Artists' LPC4357 Developer's Kit";
 	compatible = "ea,lpc4357-developers-kit", "nxp,lpc4357", "nxp,lpc4350";
@@ -42,9 +45,58 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	gpio_joystick {
+		compatible = "gpio-keys-polled";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_joystick_pins>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <100>;
+		autorepeat;
+
+		button at 0 {
+			label = "joy_enter";
+			linux,code = <KEY_ENTER>;
+			gpios = <&gpio LPC_GPIO(4,8) GPIO_ACTIVE_LOW>;
+		};
+
+		button at 1 {
+			label = "joy_left";
+			linux,code = <KEY_LEFT>;
+			gpios = <&gpio LPC_GPIO(4,9) GPIO_ACTIVE_LOW>;
+		};
+
+		button at 2 {
+			label = "joy_up";
+			linux,code = <KEY_UP>;
+			gpios = <&gpio LPC_GPIO(4,10) GPIO_ACTIVE_LOW>;
+		};
+
+		button at 3 {
+			label = "joy_right";
+			linux,code = <KEY_RIGHT>;
+			gpios = <&gpio LPC_GPIO(4,12) GPIO_ACTIVE_LOW>;
+		};
+
+		button at 4 {
+			label = "joy_down";
+			linux,code = <KEY_DOWN>;
+			gpios = <&gpio LPC_GPIO(4,13) GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &pinctrl {
+	gpio_joystick_pins: gpio-joystick-pins {
+		gpio_joystick_cfg {
+			pins =	"p9_0", "p9_1", "pa_1", "pa_2", "pa_3";
+			function = "gpio";
+			input-enable;
+			bias-disable;
+		};
+	};
+
 	sdmmc_pins: sdmmc-pins {
 		sdmmc_clk_cfg {
 			pins = "pc_0";
-- 
1.8.0
