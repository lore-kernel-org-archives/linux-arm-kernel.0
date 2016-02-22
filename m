From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Feb 2016 09:33:26 +0100
Subject: [PATCH] ARM: Ux500: add synaptics RMI4 for Ux500 TVK DT
Message-ID: <1456130006-4169-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Synaptics RMI4 touchscreen to the Ux500 TVK
user interface board. Tested on the U8500 HREFv60plus with
the TVK UIB.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC maintainers: please apply this patch directly for-next
on some DT branch, I have no other Ux500 DT patches. These bindings
are ACKed by Rob Herring in another thread so I think it's pointless
to keep it out of tree.
---
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi | 37 +++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
index b7b4211c5353..55f9d0cc90f3 100644
--- a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
+++ b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
@@ -37,7 +37,6 @@
 	};
 
 	soc {
-		/* Add Synaptics touch screen, TC35893 keypad etc here */
 		i2c at 80004000 {
 			tc35893 at 44 {
 				compatible = "toshiba,tc35893";
@@ -159,6 +158,33 @@
 				vddio-supply = <&db8500_vsmps2_reg>;
 			};
 		};
+
+		i2c at 80110000 {
+			synaptics at 4b {
+				/* Synaptics RMI4 TM1217 touchscreen */
+				compatible = "syna,rmi4-i2c";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x4b>;
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&synaptics_tvk_mode>;
+				interrupt-parent = <&gpio2>;
+				interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
+
+				rmi-f01 at 1 {
+					reg = <0x1>;
+					syna,nosleep = <1>;
+				};
+				rmi-f11 at 11 {
+					reg = <0x11>;
+					touchscreen-inverted-x;
+					syna,sensor-type = <1>;
+				};
+			};
+		};
+
 		pinctrl {
 			/* Pull up this GPIO pin */
 			tc35893 {
@@ -212,6 +238,15 @@
 					};
 				};
 			};
+			synaptics {
+				synaptics_tvk_mode: synaptics_tvk {
+					/* Touchscreen uses GPIO 84 */
+					tvk_cfg1 {
+						pins = "GPIO84_C2";
+						ste,config = <&gpio_in_pu>;
+					};
+				};
+			};
 		};
 	};
 };
-- 
2.4.3
