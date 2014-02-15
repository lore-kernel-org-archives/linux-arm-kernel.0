From: david.lanzendoerfer@o2s.ch (David =?utf-8?q?Lanzend=C3=B6rfer?=)
Date: Sun, 16 Feb 2014 00:33:42 +0100
Subject: [PATCH v6 5/8] ARM: dts: sun7i: Add support for mmc
In-Reply-To: <20140215233011.30460.27261.stgit@dizzy-6.o2s.ch>
References: <20140215233011.30460.27261.stgit@dizzy-6.o2s.ch>
Message-ID: <20140215233342.30460.88486.stgit@dizzy-6.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     |    8 +++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      |    8 +++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |   23 +++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                |   61 +++++++++++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 5c51cb8..ae800b6 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -34,6 +34,14 @@
 			};
 		};
 
+		mmc0: mmc at 01c0f000 {
+			pinctrl-names = "default", "default";
+			pinctrl-0 = <&mmc0_pins_a>;
+			pinctrl-1 = <&mmc0_cd_pin_reference_design>;
+			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
 			led_pins_cubieboard2: led_pins at 0 {
 				allwinner,pins = "PH20", "PH21";
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index f9dcb61..370cef84 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -19,6 +19,14 @@
 	compatible = "cubietech,cubietruck", "allwinner,sun7i-a20";
 
 	soc at 01c00000 {
+		mmc0: mmc at 01c0f000 {
+			pinctrl-names = "default", "default";
+			pinctrl-0 = <&mmc0_pins_a>;
+			pinctrl-1 = <&mmc0_cd_pin_reference_design>;
+			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
 			led_pins_cubietruck: led_pins at 0 {
 				allwinner,pins = "PH7", "PH11", "PH20", "PH21";
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index ead3013..685ec06 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -34,7 +34,30 @@
 			};
 		};
 
+		mmc0: mmc at 01c0f000 {
+			pinctrl-names = "default", "default";
+			pinctrl-0 = <&mmc0_pins_a>;
+			pinctrl-1 = <&mmc0_cd_pin_reference_design>;
+			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			status = "okay";
+		};
+
+		mmc3: mmc at 01c12000 {
+			pinctrl-names = "default", "default";
+			pinctrl-0 = <&mmc3_pins_a>;
+			pinctrl-1 = <&mmc3_cd_pin_olinuxinom>;
+			cd-gpios = <&pio 7 11 0>; /* PH11 */
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
+			mmc3_cd_pin_olinuxinom: mmc3_cd_pin at 0 {
+				allwinner,pins = "PH11";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+
 			led_pins_olinuxino: led_pins at 0 {
 				allwinner,pins = "PH2";
 				allwinner,function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 9ff0948..5b55414 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -355,6 +355,46 @@
 			#size-cells = <0>;
 		};
 
+		mmc0: mmc at 01c0f000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c0f000 0x1000>;
+			clocks = <&ahb_gates 8>, <&mmc0_clk>;
+			clock-names = "ahb", "mod";
+			interrupts = <0 32 4>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		mmc1: mmc at 01c10000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c10000 0x1000>;
+			clocks = <&ahb_gates 9>, <&mmc1_clk>;
+			clock-names = "ahb", "mod";
+			interrupts = <0 33 4>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		mmc2: mmc at 01c11000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c11000 0x1000>;
+			clocks = <&ahb_gates 10>, <&mmc2_clk>;
+			clock-names = "ahb", "mod";
+			interrupts = <0 34 4>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		mmc3: mmc at 01c12000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c12000 0x1000>;
+			clocks = <&ahb_gates 11>, <&mmc3_clk>;
+			clock-names = "ahb", "mod";
+			interrupts = <0 35 4>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun7i-a20-pinctrl";
 			reg = <0x01c20800 0x400>;
@@ -432,6 +472,27 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			mmc0_pins_a: mmc0 at 0 {
+				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
+				allwinner,function = "mmc0";
+				allwinner,drive = <3>;
+				allwinner,pull = <0>;
+			};
+
+			mmc0_cd_pin_reference_design: mmc0_cd_pin at 0 {
+				allwinner,pins = "PH1";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+
+			mmc3_pins_a: mmc3 at 0 {
+				allwinner,pins = "PI4","PI5","PI6","PI7","PI8","PI9";
+				allwinner,function = "mmc3";
+				allwinner,drive = <3>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		timer at 01c20c00 {
