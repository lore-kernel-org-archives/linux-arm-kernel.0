From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 14 Dec 2013 22:58:12 +0100
Subject: [PATCH 2/5] ARM: dts: sun4i: Add support for mmc
In-Reply-To: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1387058295-20641-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 16 ++++++++++++++++
 arch/arm/boot/dts/sun4i-a10.dtsi           | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 425a7db..d193937 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -42,7 +42,23 @@
 			};
 		};
 
+		sdc0: sdc at 01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdc0_pins_a>;
+			pinctrl-1 = <&mmc0_cd_pin_cubieboard>;
+			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-mode = <1>;
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
+			mmc0_cd_pin_cubieboard: mmc0_cd_pin at 0 {
+				allwinner,pins = "PH1";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			led_pins_cubieboard: led_pins at 0 {
 				allwinner,pins = "PH20", "PH21";
 				allwinner,function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 4dccdb0..13bccd5 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -306,6 +306,15 @@
 			#size-cells = <0>;
 		};
 
+		sdc0: sdc at 01c0f000 {
+			compatible = "allwinner,sun4i-mmc";
+			reg = <0x01c0f000 0x1000>;
+			clocks = <&ahb_gates 8>, <&mmc0>;
+			interrupts = <32>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		intc: interrupt-controller at 01c20400 {
 			compatible = "allwinner,sun4i-ic";
 			reg = <0x01c20400 0x400>;
@@ -376,6 +385,13 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			sdc0_pins_a: sdc0 at 0 {
+				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
+				allwinner,function = "mmc0";
+				allwinner,drive = <3>;
+				allwinner,pull = <1>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
1.8.4.2
