From: bay@hackerdom.ru (Alexander Bersenev)
Date: Thu, 15 May 2014 03:56:42 +0600
Subject: [PATCH v7 3/3] ARM: sunxi: Add IR controller support in DT on A20
In-Reply-To: <1400104602-16431-1-git-send-email-bay@hackerdom.ru>
References: <1400104602-16431-1-git-send-email-bay@hackerdom.ru>
Message-ID: <1400104602-16431-4-git-send-email-bay@hackerdom.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds IR controller in A20 Device-Tree:
- Two IR devices found in A20 user manual
- Pins for two devices
- One IR device physically found on Cubieboard 2
- One IR device physically found on Cubietruck

Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>
Signed-off-by: Alexsey Shestacov <wingrime@linux-sunxi.org>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts |  6 ++++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts  |  6 ++++++
 arch/arm/boot/dts/sun7i-a20.dtsi            | 32 +++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index feeff64..b44d61b 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -65,6 +65,12 @@
 			};
 		};
 
+		ir0: ir at 01c21800 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&ir0_pins_a>;
+			status = "okay";
+		};
+
 		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index e288562..5f5c31d 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -121,6 +121,12 @@
 			};
 		};
 
+		ir0: ir at 01c21800 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&ir0_pins_a>;
+			status = "okay";
+		};
+
 		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 0ae2b77..fe1f8ff 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -724,6 +724,20 @@
 				allwinner,drive = <2>;
 				allwinner,pull = <0>;
 			};
+
+			ir0_pins_a: ir0 at 0 {
+				    allwinner,pins = "PB3","PB4";
+				    allwinner,function = "ir0";
+				    allwinner,drive = <0>;
+				    allwinner,pull = <0>;
+			};
+
+			ir1_pins_a: ir1 at 0 {
+				    allwinner,pins = "PB22","PB23";
+				    allwinner,function = "ir1";
+				    allwinner,drive = <0>;
+				    allwinner,pull = <0>;
+			};
 		};
 
 		timer at 01c20c00 {
@@ -749,6 +763,24 @@
 			interrupts = <0 24 4>;
 		};
 
+		ir0: ir at 01c21800 {
+			compatible = "allwinner,sun7i-a20-ir";
+			clocks = <&apb0_gates 6>, <&ir0_clk>;
+			clock-names = "apb", "ir";
+			interrupts = <0 5 4>;
+			reg = <0x01c21800 0x40>;
+			status = "disabled";
+		};
+
+		ir1: ir at 01c21c00 {
+			compatible = "allwinner,sun7i-a20-ir";
+			clocks = <&apb0_gates 7>, <&ir1_clk>;
+			clock-names = "apb", "ir";
+			interrupts = <0 6 4>;
+			reg = <0x01c21c00 0x40>;
+			status = "disabled";
+		};
+
 		lradc: lradc at 01c22800 {
 			compatible = "allwinner,sun4i-lradc-keys";
 			reg = <0x01c22800 0x100>;
-- 
1.9.3
