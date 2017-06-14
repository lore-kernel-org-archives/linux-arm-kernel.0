From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 14 Jun 2017 10:29:17 +0200
Subject: [PATCH v5 4/4] ARM: dts: meson6: use stable UART bindings
In-Reply-To: <1497428957-19942-1-git-send-email-narmstrong@baylibre.com>
References: <1497428957-19942-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1497428957-19942-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UART bindings needs specifying a SoC family, use the meson6 family
for the UART nodes like the other nodes.
Switch to the stable UART bindings for meson6 by adding a XTAL node and
using the proper compatible strings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/meson.dtsi  |  8 ++++----
 arch/arm/boot/dts/meson6.dtsi | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 8d9c369..ecc9330 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -79,14 +79,14 @@
 			ranges = <0x0 0xc1100000 0x200000>;
 
 			uart_A: serial at 84c0 {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson6-uart";
 				reg = <0x84c0 0x18>;
 				interrupts = <0 26 1>;
 				status = "disabled";
 			};
 
 			uart_B: serial at 84dc {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson6-uart";
 				reg = <0x84dc 0x18>;
 				interrupts = <0 75 1>;
 				status = "disabled";
@@ -102,7 +102,7 @@
 			};
 
 			uart_C: serial at 8700 {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson6-uart";
 				reg = <0x8700 0x18>;
 				interrupts = <0 93 1>;
 				status = "disabled";
@@ -153,7 +153,7 @@
 			};
 
 			uart_AO: serial at 4c0 {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson6-uart", "amlogic,meson-ao-uart";
 				reg = <0x4c0 0x18>;
 				interrupts = <0 90 1>;
 				status = "disabled";
diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
index b0fc91f..a334fbe 100644
--- a/arch/arm/boot/dts/meson6.dtsi
+++ b/arch/arm/boot/dts/meson6.dtsi
@@ -70,9 +70,37 @@
 		};
 	};
 
+	xtal: xtal-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "xtal";
+		#clock-cells = <0>;
+	};
+
 	clk81: clk at 0 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <200000000>;
 	};
 }; /* end of / */
+
+
+&uart_AO {
+	clocks = <&xtal>, <&clk81>, <&clk81>;
+	clock-names = "xtal", "pclk", "baud";
+};
+
+&uart_A {
+	clocks = <&xtal>, <&clk81>, <&clk81>;
+	clock-names = "xtal", "pclk", "baud";
+};
+
+&uart_B {
+	clocks = <&xtal>, <&clk81>, <&clk81>;
+	clock-names = "xtal", "pclk", "baud";
+};
+
+&uart_C {
+	clocks = <&xtal>, <&clk81>, <&clk81>;
+	clock-names = "xtal", "pclk", "baud";
+};
-- 
1.9.1
