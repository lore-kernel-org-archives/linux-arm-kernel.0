From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 03 Jul 2014 02:03:23 +0200
Subject: [PATCH v5 12/14] ARM: dts: rockchip: add cru nodes and update device
 clocks to use it
In-Reply-To: <156042792.J76K6jxIGl@diego>
References: <156042792.J76K6jxIGl@diego>
Message-ID: <18982081.0k5rrF7RHT@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a node for the clock and reset unit on rk3188 and rk3066 SoCs and
also updates the device nodes retrieve their clocks from there, instead of
the previous gate clock nodes.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-By: Max Schwarz <max.schwarz@online.de>
Tested-By: Max Schwarz <max.schwarz@online.de>
---
 arch/arm/boot/dts/rk3066a.dtsi | 29 ++++++++++++++++++++---------
 arch/arm/boot/dts/rk3188.dtsi  | 18 ++++++++++++++----
 arch/arm/boot/dts/rk3xxx.dtsi  | 16 ++++++++--------
 3 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 4387cfd..0b36514 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -15,6 +15,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/clock/rk3066a-cru.h>
 #include "rk3xxx.dtsi"
 #include "rk3066a-clocks.dtsi"
 
@@ -45,7 +46,7 @@
 			compatible = "snps,dw-apb-timer-osc";
 			reg = <0x20038000 0x100>;
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_gates1 0>, <&clk_gates7 7>;
+			clocks = <&cru SCLK_TIMER0>, <&cru PCLK_TIMER0>;
 			clock-names = "timer", "pclk";
 		};
 
@@ -53,7 +54,7 @@
 			compatible = "snps,dw-apb-timer-osc";
 			reg = <0x2003a000 0x100>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_gates1 1>, <&clk_gates7 8>;
+			clocks = <&cru SCLK_TIMER1>, <&cru PCLK_TIMER1>;
 			clock-names = "timer", "pclk";
 		};
 
@@ -61,7 +62,7 @@
 			compatible = "snps,dw-apb-timer-osc";
 			reg = <0x2000e000 0x100>;
 			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_gates1 2>, <&clk_gates7 9>;
+			clocks = <&cru SCLK_TIMER2>, <&cru PCLK_TIMER2>;
 			clock-names = "timer", "pclk";
 		};
 
@@ -78,6 +79,16 @@
 			};
 		};
 
+		cru: cru at 20000000 {
+			compatible = "rockchip,rk3066a-cru";
+			reg = <0x20000000 0x1000>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+
+			rockchip,grf = <&grf>;
+		};
+
 		pinctrl at 20008000 {
 			compatible = "rockchip,rk3066a-pinctrl";
 			rockchip,grf = <&grf>;
@@ -89,7 +100,7 @@
 				compatible = "rockchip,gpio-bank";
 				reg = <0x20034000 0x100>;
 				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk_gates8 9>;
+				clocks = <&cru PCLK_GPIO0>;
 
 				gpio-controller;
 				#gpio-cells = <2>;
@@ -102,7 +113,7 @@
 				compatible = "rockchip,gpio-bank";
 				reg = <0x2003c000 0x100>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk_gates8 10>;
+				clocks = <&cru PCLK_GPIO1>;
 
 				gpio-controller;
 				#gpio-cells = <2>;
@@ -115,7 +126,7 @@
 				compatible = "rockchip,gpio-bank";
 				reg = <0x2003e000 0x100>;
 				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk_gates8 11>;
+				clocks = <&cru PCLK_GPIO2>;
 
 				gpio-controller;
 				#gpio-cells = <2>;
@@ -128,7 +139,7 @@
 				compatible = "rockchip,gpio-bank";
 				reg = <0x20080000 0x100>;
 				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk_gates8 12>;
+				clocks = <&cru PCLK_GPIO3>;
 
 				gpio-controller;
 				#gpio-cells = <2>;
@@ -141,7 +152,7 @@
 				compatible = "rockchip,gpio-bank";
 				reg = <0x20084000 0x100>;
 				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk_gates8 13>;
+				clocks = <&cru PCLK_GPIO4>;
 
 				gpio-controller;
 				#gpio-cells = <2>;
@@ -154,7 +165,7 @@
 				compatible = "rockchip,gpio-bank";
 				reg = <0x2000a000 0x100>;
 				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk_gates8 15>;
+				clocks = <&cru PCLK_GPIO6>;
 
 				gpio-controller;
 				#gpio-cells = <2>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 238c996..d77bc94 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -15,6 +15,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/clock/rk3188-cru.h>
 #include "rk3xxx.dtsi"
 #include "rk3188-clocks.dtsi"
 
@@ -74,6 +75,15 @@
 			};
 		};
 
+		cru: cru at 20000000 {
+			compatible = "rockchip,rk3188-cru";
+			reg = <0x20000000 0x1000>;
+			rockchip,grf = <&grf>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		pinctrl at 20008000 {
 			compatible = "rockchip,rk3188-pinctrl";
 			rockchip,grf = <&grf>;
@@ -87,7 +97,7 @@
 				compatible = "rockchip,rk3188-gpio-bank0";
 				reg = <0x2000a000 0x100>;
 				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk_gates8 9>;
+				clocks = <&cru PCLK_GPIO0>;
 
 				gpio-controller;
 				#gpio-cells = <2>;
@@ -100,7 +110,7 @@
 				compatible = "rockchip,gpio-bank";
 				reg = <0x2003c000 0x100>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk_gates8 10>;
+				clocks = <&cru PCLK_GPIO1>;
 
 				gpio-controller;
 				#gpio-cells = <2>;
@@ -113,7 +123,7 @@
 				compatible = "rockchip,gpio-bank";
 				reg = <0x2003e000 0x100>;
 				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk_gates8 11>;
+				clocks = <&cru PCLK_GPIO2>;
 
 				gpio-controller;
 				#gpio-cells = <2>;
@@ -126,7 +136,7 @@
 				compatible = "rockchip,gpio-bank";
 				reg = <0x20080000 0x100>;
 				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk_gates8 12>;
+				clocks = <&cru PCLK_GPIO3>;
 
 				gpio-controller;
 				#gpio-cells = <2>;
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 2adf1cc9e..b47d5fe 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -60,14 +60,14 @@
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x1013c200 0x20>;
 			interrupts = <GIC_PPI 11 0x304>;
-			clocks = <&dummy150m>;
+			clocks = <&cru CORE_PERI>;
 		};
 
 		local-timer at 1013c600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x1013c600 0x20>;
 			interrupts = <GIC_PPI 13 0x304>;
-			clocks = <&dummy150m>;
+			clocks = <&cru CORE_PERI>;
 		};
 
 		uart0: serial at 10124000 {
@@ -76,7 +76,7 @@
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <1>;
-			clocks = <&clk_gates1 8>;
+			clocks = <&cru SCLK_UART0>;
 			status = "disabled";
 		};
 
@@ -86,7 +86,7 @@
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <1>;
-			clocks = <&clk_gates1 10>;
+			clocks = <&cru SCLK_UART1>;
 			status = "disabled";
 		};
 
@@ -96,7 +96,7 @@
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <1>;
-			clocks = <&clk_gates1 12>;
+			clocks = <&cru SCLK_UART2>;
 			status = "disabled";
 		};
 
@@ -106,7 +106,7 @@
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <1>;
-			clocks = <&clk_gates1 14>;
+			clocks = <&cru SCLK_UART3>;
 			status = "disabled";
 		};
 
@@ -117,7 +117,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			clocks = <&clk_gates5 10>, <&clk_gates2 11>;
+			clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
 			clock-names = "biu", "ciu";
 
 			status = "disabled";
@@ -130,7 +130,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			clocks = <&clk_gates5 11>, <&clk_gates2 13>;
+			clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>;
 			clock-names = "biu", "ciu";
 
 			status = "disabled";
-- 
1.9.0
