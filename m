From: lars.persson@axis.com (Lars Persson)
Date: Thu, 25 Feb 2016 10:34:14 +0100
Subject: [PATCH] ARM: dts: artpec: update clock bindings in artpec6.dtsi
Message-ID: <1456392854-13527-1-git-send-email-larper@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock bindings for the main clock controller was changed to an
indexed controller style binding on request of the clk
maintainers. This updates the dtsi to use the new bindings.

Signed-off-by: Lars Persson <larper@axis.com>
---
Note: This patch depends on a header file delivered through the clk tree in
"clk: add device tree binding for Artpec-6 clock controller".

 arch/arm/boot/dts/artpec6.dtsi | 100 +++++++++--------------------------------
 1 file changed, 21 insertions(+), 79 deletions(-)

diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index 3043016..db41b52 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -41,6 +41,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/axis,artpec6-clkctrl.h>
 #include "skeleton.dtsi"
 
 / {
@@ -91,96 +92,32 @@
 		clock-frequency = <50000000>;
 	};
 
-	/* PLL1 is used by CPU and some peripherals */
-	pll1_clk: pll1_clk at f8000000 {
+	eth_phy_ref_clk: eth_phy_ref_clk {
 		#clock-cells = <0>;
-		compatible = "axis,artpec6-pll1-clock";
-		reg = <0xf8000000 4>;
-		clocks = <&ext_clk>;
-	};
-
-	cpu_clk: cpu_clk {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <1>;
-		clocks = <&pll1_clk>;
-		clock-output-names = "cpu_clk";
-	};
-
-	cpu_clkdiv2: cpu_clkdiv2 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <2>;
-		clock-mult = <1>;
-		clocks = <&cpu_clk>;
-	};
-
-	cpu_clkdiv4: cpu_clkdiv4 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <4>;
-		clock-mult = <1>;
-		clocks = <&cpu_clk>;
-	};
-
-	apb_pclk: apb_pclk {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <8>;
-		clock-mult = <1>;
-		clocks = <&cpu_clk>;
-		clock-output-names = "apb_pclk";
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
 	};
 
-	/* PLL2 is used by a number of peripherals, including UDL */
-	pll2: pll2 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <1>;
-		clock-mult = <24>;
+	clkctrl: clkctrl at 0xf8000000 {
+		#clock-cells = <1>;
+		compatible = "axis,artpec6-clkctrl";
+		reg = <0xf8000000 0x48>;
 		clocks = <&ext_clk>;
+		clock-names = "sys_refclk";
 	};
 
-	/* PLL2DIV2 is used by the Fractional Clock Divider, for i2s */
-	pll2div2: pll2div2 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <2>;
-		clock-mult = <1>;
-		clocks = <&pll2>;
-	};
-
-	pll2div12: pll2div12 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <12>;
-		clock-mult = <1>;
-		clocks = <&pll2>;
-	};
-
-	pll2div24: pll2div24 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clock-div = <24>;
-		clock-mult = <1>;
-		clocks = <&pll2>;
-		clock-output-names = "uart_clk";
-	};
-
-
 	gtimer at faf00200 {
 		compatible = "arm,cortex-a9-global-timer";
 		reg = <0xfaf00200 0x20>;
 		interrupts = <GIC_PPI 11 0xf01>;
-		clocks = <&cpu_clkdiv2>;
+		clocks = <&clkctrl ARTPEC6_CLK_CPU_PERIPH>;
 	};
 
 	timer at faf00600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0xfaf00600 0x20>;
 		interrupts = <GIC_PPI 13 0xf04>;
-		clocks = <&cpu_clkdiv2>;
+		clocks = <&clkctrl ARTPEC6_CLK_CPU_PERIPH>;
 		status = "disabled";
 	};
 
@@ -220,7 +157,8 @@
 
 		ethernet: ethernet at f8010000 {
 			clock-names = "phy_ref_clk", "apb_pclk";
-			clocks = <&ext_clk>, <&apb_pclk>;
+			clocks = <&eth_phy_ref_clk>,
+				<&clkctrl ARTPEC6_CLK_ETH_ACLK>;
 			compatible = "snps,dwc-qos-ethernet-4.10";
 			interrupt-parent = <&intc>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
@@ -238,7 +176,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xf8036000 0x1000>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pll2div24>, <&apb_pclk>;
+			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
+				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
 			status = "disabled";
 		};
@@ -246,7 +185,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xf8037000 0x1000>;
 			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pll2div24>, <&apb_pclk>;
+			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
+				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
 			status = "disabled";
 		};
@@ -254,7 +194,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xf8038000 0x1000>;
 			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pll2div24>, <&apb_pclk>;
+			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
+				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
 			status = "disabled";
 		};
@@ -262,7 +203,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xf8039000 0x1000>;
 			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pll2div24>, <&apb_pclk>;
+			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
+				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
 			status = "disabled";
 		};
-- 
2.1.4
