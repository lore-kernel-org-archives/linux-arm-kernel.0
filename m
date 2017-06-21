From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 21 Jun 2017 16:42:12 +0200
Subject: [PATCH v5.1 2/2] ARM: dts: meson6: use stable UART bindings
In-Reply-To: <1498056132-18508-1-git-send-email-narmstrong@baylibre.com>
References: <1498056132-18508-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1498056132-18508-3-git-send-email-narmstrong@baylibre.com>
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
index 15204e4..1ce9aa0 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -86,14 +86,14 @@
 			};
 
 			uart_A: serial at 84c0 {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson6-uart", "amlogic,meson-uart";
 				reg = <0x84c0 0x18>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
 
 			uart_B: serial at 84dc {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson6-uart", "amlogic,meson-uart";
 				reg = <0x84dc 0x18>;
 				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
@@ -117,7 +117,7 @@
 			};
 
 			uart_C: serial at 8700 {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson6-uart", "amlogic,meson-uart";
 				reg = <0x8700 0x18>;
 				interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
@@ -182,7 +182,7 @@
 			};
 
 			uart_AO: serial at 4c0 {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson6-uart", "amlogic,meson-ao-uart", "amlogic,meson-uart";
 				reg = <0x4c0 0x18>;
 				interrupts = <GIC_SPI 90 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
index 8557b61..ef281d2 100644
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
