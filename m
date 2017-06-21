From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 21 Jun 2017 16:42:11 +0200
Subject: [PATCH v5.1 1/2] ARM64: dts: meson-gx: use stable UART bindings with
 correct gate clock
In-Reply-To: <1498056132-18508-1-git-send-email-narmstrong@baylibre.com>
References: <1498056132-18508-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1498056132-18508-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Helmut Klein <hgkr.klein@gmail.com>

This patch switches to the stable UART bindings but also add the correct
gate clock to the non-AO UART nodes for GXBB and GXL SoCs.

Acked-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Helmut Klein <hgkr.klein@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 12 +++++-------
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 25 +++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 25 +++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 35b8c88..1c6e4ed 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -225,7 +225,7 @@
 			};
 
 			uart_A: serial at 84c0 {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
 				reg = <0x0 0x84c0 0x0 0x14>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>;
@@ -233,7 +233,7 @@
 			};
 
 			uart_B: serial at 84dc {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
 				reg = <0x0 0x84dc 0x0 0x14>;
 				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>;
@@ -279,7 +279,7 @@
 			};
 
 			uart_C: serial at 8700 {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
 				reg = <0x0 0x8700 0x0 0x14>;
 				interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>;
@@ -375,18 +375,16 @@
 			};
 
 			uart_AO: serial at 4c0 {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart", "amlogic,meson-uart";
 				reg = <0x0 0x004c0 0x0 0x14>;
 				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>;
 				status = "disabled";
 			};
 
 			uart_AO_B: serial at 4e0 {
-				compatible = "amlogic,meson-uart";
+				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart", "amlogic,meson-uart";
 				reg = <0x0 0x004e0 0x0 0x14>;
 				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 17d3efd..ea53cc2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -682,6 +682,31 @@
 	clocks = <&clkc CLKID_SPI>;
 };
 
+&uart_A {
+	clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
+	clock-names = "xtal", "pclk", "baud";
+};
+
+&uart_AO {
+	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
+	clock-names = "xtal", "pclk", "baud";
+};
+
+&uart_AO_B {
+	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
+	clock-names = "xtal", "pclk", "baud";
+};
+
+&uart_B {
+	clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
+	clock-names = "xtal", "core", "baud";
+};
+
+&uart_C {
+	clocks = <&xtal>, <&clkc CLKID_UART2>, <&xtal>;
+	clock-names = "xtal", "core", "baud";
+};
+
 &vpu {
 	compatible = "amlogic,meson-gxbb-vpu", "amlogic,meson-gx-vpu";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 8d4f316..9e67444 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -623,6 +623,31 @@
 	clocks = <&clkc CLKID_SPI>;
 };
 
+&uart_A {
+	clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
+	clock-names = "xtal", "core", "baud";
+};
+
+&uart_AO {
+	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
+	clock-names = "xtal", "pclk", "baud";
+};
+
+&uart_AO_B {
+	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
+	clock-names = "xtal", "pclk", "baud";
+};
+
+&uart_B {
+	clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
+	clock-names = "xtal", "core", "baud";
+};
+
+&uart_C {
+	clocks = <&xtal>, <&clkc CLKID_UART2>, <&xtal>;
+	clock-names = "xtal", "core", "baud";
+};
+
 &vpu {
 	compatible = "amlogic,meson-gxl-vpu", "amlogic,meson-gx-vpu";
 };
-- 
1.9.1
