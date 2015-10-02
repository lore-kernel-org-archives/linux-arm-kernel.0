From: jonmason@broadcom.com (Jon Mason)
Date: Fri, 2 Oct 2015 18:57:39 -0400
Subject: [PATCH 04/10] ARM: dts: enable clock support for BCM5301X
In-Reply-To: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
References: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1443826665-17570-5-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace current device tree dummy clocks with real clock support for
Broadcom Northstar SoCs.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 67 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 6f50f67..f717859 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -8,6 +8,7 @@
  * Licensed under the GNU/GPL. See COPYING for details.
  */
 
+#include <dt-bindings/clock/bcm-nsp.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -55,14 +56,14 @@
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x0200 0x100>;
 			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_periph>;
+			clocks = <&periph_clk>;
 		};
 
 		local-timer at 0600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x0600 0x100>;
 			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_periph>;
+			clocks = <&periph_clk>;
 		};
 
 		gic: interrupt-controller at 1000 {
@@ -94,14 +95,66 @@
 
 	clocks {
 		#address-cells = <1>;
-		#size-cells = <0>;
+		#size-cells = <1>;
+		ranges;
 
-		/* As long as we do not have a real clock driver us this
-		 * fixed clock */
-		clk_periph: periph {
+		osc: oscillator {
+			#clock-cells = <0>;
 			compatible = "fixed-clock";
+			clock-frequency = <25000000>;
+		};
+
+		lcpll0: lcpll0 at 1800c100 {
+			#clock-cells = <1>;
+			compatible = "brcm,nsp-lcpll0";
+			reg = <0x1800c100 0x14>;
+			clocks = <&osc>;
+			clock-output-names = "lcpll0", "pcie_phy", "sdio",
+					     "ddr_phy";
+		};
+
+		genpll: genpll at 1800c140 {
+			#clock-cells = <1>;
+			compatible = "brcm,nsp-genpll";
+			reg = <0x1800c140 0x24>;
+			clocks = <&osc>;
+			clock-output-names = "genpll", "phy", "ethernetclk",
+					     "usbclk", "iprocfast", "sata1",
+					     "sata2";
+		};
+
+		iprocmed: iprocmed {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clocks = <&genpll BCM_NSP_GENPLL_IPROCFAST_CLK>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "iprocmed";
+		};
+
+		iprocslow: iprocslow {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clocks = <&genpll BCM_NSP_GENPLL_IPROCFAST_CLK>;
+			clock-div = <4>;
+			clock-mult = <1>;
+			clock-output-names = "iprocslow";
+		};
+
+
+		a9pll: arm_clk at 19000000 {
+			#clock-cells = <0>;
+			compatible = "brcm,nsp-armpll";
+			clocks = <&osc>;
+			reg = <0x19000000 0x1000>;
+		};
+
+		periph_clk: periph_clk {
 			#clock-cells = <0>;
-			clock-frequency = <400000000>;
+			compatible = "fixed-factor-clock";
+			clocks = <&a9pll>;
+			clock-div = <2>;
+			clock-mult = <1>;
 		};
 	};
 
-- 
1.9.1
