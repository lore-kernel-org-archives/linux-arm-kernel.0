From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 07 May 2014 23:15:30 +0200
Subject: [PATCH v2 09/11] ARM: dts: rk3188: add cru node and update device
 clocks to use it
In-Reply-To: <3477211.Gkyeur83TV@diego>
References: <3477211.Gkyeur83TV@diego>
Message-ID: <3177977.6ZVr2dKNOF@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a node for the clock and reset unit on rk3188 SoCs and updates
the device nodes retrieve their clocks from there, instead of the previous
gate clock nodes.

As the clocks diverge a bit until rk3066 can catch up, the shared nodes
between rk3066 and rk3188 get separated clocks-properties in the rk3188.dtsi.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3188.dtsi | 55 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index bb36596..dc3e986 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -15,6 +15,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/clock/rk3188-cru.h>
 #include "rk3xxx.dtsi"
 #include "rk3188-clocks.dtsi"
 
@@ -54,10 +55,12 @@
 	soc {
 		global-timer at 1013c200 {
 			interrupts = <GIC_PPI 11 0xf04>;
+			clocks = <&cru CORE_PERI>;
 		};
 
 		local-timer at 1013c600 {
 			interrupts = <GIC_PPI 13 0xf04>;
+			clocks = <&cru CORE_PERI>;
 		};
 
 		sram: sram at 10080000 {
@@ -73,6 +76,50 @@
 			};
 		};
 
+		uart0: serial at 10124000 {
+			clocks = <&cru SCLK_UART0>;
+		};
+
+		uart1: serial at 10126000 {
+			clocks = <&cru SCLK_UART1>;
+		};
+
+		uart2: serial at 20064000 {
+			clocks = <&cru SCLK_UART2>;
+		};
+
+		uart3: serial at 20068000 {
+			clocks = <&cru SCLK_UART3>;
+		};
+
+		dwmmc at 10214000 {
+			clocks = <&cru HCLK_MMC0>, <&cru SCLK_MMC0>;
+			clock-names = "biu", "ciu";
+		};
+
+		dwmmc at 10218000 {
+			clocks = <&cru HCLK_MMC1>, <&cru SCLK_MMC1>;
+			clock-names = "biu", "ciu";
+		};
+
+		cru: cru at 20000000 {
+			compatible = "rockchip,rk3188-cru";
+			reg = <0x20000000 0x1000>,
+			      <0x200080ac 0x4>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+
+			#rockchip,armclk-cells = <3>;
+			rockchip,armclk-divider-table = <1608000 2 3>,
+							<1416000 2 3>,
+							<1200000 2 3>,
+							<1008000 2 3>,
+							< 816000 2 3>,
+							< 504000 1 3>,
+							< 312000 0 1>;
+		};
+
 		pinctrl at 20008000 {
 			compatible = "rockchip,rk3188-pinctrl";
 			reg = <0x20008000 0xa0>,
@@ -87,7 +134,7 @@
 				reg = <0x2000a000 0x100>,
 				      <0x20004064 0x8>;
 				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk_gates8 9>;
+				clocks = <&cru PCLK_GPIO0>;
 
 				gpio-controller;
 				#gpio-cells = <2>;
@@ -100,7 +147,7 @@
 				compatible = "rockchip,gpio-bank";
 				reg = <0x2003c000 0x100>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk_gates8 10>;
+				clocks = <&cru PCLK_GPIO1>;
 
 				gpio-controller;
 				#gpio-cells = <2>;
@@ -113,7 +160,7 @@
 				compatible = "rockchip,gpio-bank";
 				reg = <0x2003e000 0x100>;
 				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk_gates8 11>;
+				clocks = <&cru PCLK_GPIO2>;
 
 				gpio-controller;
 				#gpio-cells = <2>;
@@ -126,7 +173,7 @@
 				compatible = "rockchip,gpio-bank";
 				reg = <0x20080000 0x100>;
 				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk_gates8 12>;
+				clocks = <&cru PCLK_GPIO3>;
 
 				gpio-controller;
 				#gpio-cells = <2>;
-- 
1.9.0
