From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 May 2015 09:50:53 +0200
Subject: [PATCH 1/2] ARM64: juno: add GPIO keys
Message-ID: <1432626653-17201-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Juno board has two keys connected to a PL061 GPIO block,
in accordance to DDI0524B "ARM Versatile Express Juno Development
Platform" revision 1.0, table 2-4 "GPIO (0) and GPIO (1) used
for additional user key entry". By trial-and-error I found that
these are connected to the two keys named "power" and "home"
on the motherboard.

Register the GPIO block and these two keys in the device tree
using the PL061 GPIO driver and the generic gpio keys.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 33 +++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
index 351c95bda89e..6458ec53a61d 100644
--- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
@@ -54,6 +54,27 @@
 				regulator-always-on;
 			};
 
+			gpio_keys {
+				compatible = "gpio-keys";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				button at 1 {
+					debounce_interval = <50>;
+					wakeup = <1>;
+					linux,code = <116>;
+					label = "power";
+					gpios = <&iofpga_gpio 0 0x4>;
+				};
+				button at 2 {
+					debounce_interval = <50>;
+					wakeup = <1>;
+					linux,code = <102>;
+					label = "home";
+					gpios = <&iofpga_gpio 1 0x4>;
+				};
+			};
+
 			ethernet at 2,00000000 {
 				compatible = "smsc,lan9118", "smsc,lan9115";
 				reg = <2 0x00000000 0x10000>;
@@ -148,5 +169,17 @@
 					clocks = <&soc_smc50mhz>;
 					clock-names = "apb_pclk";
 				};
+
+				iofpga_gpio: gpio at 1d0000 {
+					compatible = "arm,pl061", "arm,primecell";
+					reg = <0x1d0000 0x1000>;
+					interrupts = <6>;
+					clocks = <&soc_smc50mhz>;
+					clock-names = "apb_pclk";
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
 			};
 		};
-- 
1.9.3
