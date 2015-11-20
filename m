From: jonmason@broadcom.com (Jon Mason)
Date: Fri, 20 Nov 2015 10:17:19 -0500
Subject: [PATCH v3 2/3] ARM: dts: enable clock support for Broadcom NSP
In-Reply-To: <1448032640-27713-1-git-send-email-jonmason@broadcom.com>
References: <1448032640-27713-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1448032640-27713-3-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace current device tree dummy clocks with real clock support for
Broadcom Northstar Plus SoC

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 81 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index b74438c..d9bfc56 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -32,6 +32,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/bcm-nsp.h>
 
 #include "skeleton.dtsi"
 
@@ -42,7 +43,7 @@
 
 	mpcore {
 		compatible = "simple-bus";
-		ranges = <0x00000000 0x19020000 0x00003000>;
+		ranges = <0x00000000 0x19000000 0x00023000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
@@ -58,41 +59,48 @@
 			};
 		};
 
-		timer at 0200 {
+		a9pll: arm_clk at 00000 {
+			#clock-cells = <0>;
+			compatible = "brcm,nsp-armpll";
+			clocks = <&osc>;
+			reg = <0x00000 0x1000>;
+		};
+
+		timer at 20200 {
 			compatible = "arm,cortex-a9-global-timer";
-			reg = <0x0200 0x100>;
+			reg = <0x20200 0x100>;
 			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&periph_clk>;
 		};
 
-		twd-timer at 0600 {
+		twd-timer at 20600 {
 			compatible = "arm,cortex-a9-twd-timer";
-			reg = <0x0600 0x20>;
+			reg = <0x20600 0x20>;
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
 						  IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&periph_clk>;
 		};
 
-		twd-watchdog at 0620 {
+		twd-watchdog at 20620 {
 			compatible = "arm,cortex-a9-twd-wdt";
-			reg = <0x0620 0x20>;
+			reg = <0x20620 0x20>;
 			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
 						  IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&periph_clk>;
 		};
 
-		gic: interrupt-controller at 1000 {
+		gic: interrupt-controller at 21000 {
 			compatible = "arm,cortex-a9-gic";
 			#interrupt-cells = <3>;
 			#address-cells = <0>;
 			interrupt-controller;
-			reg = <0x1000 0x1000>,
-			      <0x0100 0x100>;
+			reg = <0x21000 0x1000>,
+			      <0x20100 0x100>;
 		};
 
 		L2: l2-cache {
 			compatible = "arm,pl310-cache";
-			reg = <0x2000 0x1000>;
+			reg = <0x22000 0x1000>;
 			cache-unified;
 			cache-level = <2>;
 		};
@@ -103,10 +111,34 @@
 		#size-cells = <1>;
 		ranges;
 
-		periph_clk: periph_clk {
+		osc: oscillator {
+			#clock-cells = <0>;
 			compatible = "fixed-clock";
+			clock-frequency = <25000000>;
+		};
+
+		iprocmed: iprocmed {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clocks = <&genpll BCM_NSP_GENPLL_IPROCFAST_CLK>;
+			clock-div = <2>;
+			clock-mult = <1>;
+		};
+
+		iprocslow: iprocslow {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clocks = <&genpll BCM_NSP_GENPLL_IPROCFAST_CLK>;
+			clock-div = <4>;
+			clock-mult = <1>;
+		};
+
+		periph_clk: periph_clk {
 			#clock-cells = <0>;
-			clock-frequency = <500000000>;
+			compatible = "fixed-factor-clock";
+			clocks = <&a9pll>;
+			clock-div = <2>;
+			clock-mult = <1>;
 		};
 	};
 
@@ -120,7 +152,7 @@
 			compatible = "ns16550a";
 			reg = <0x0300 0x100>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
-			clock-frequency = <62499840>;
+			clocks = <&osc>;
 			status = "disabled";
 		};
 
@@ -128,7 +160,7 @@
 			compatible = "ns16550a";
 			reg = <0x0400 0x100>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
-			clock-frequency = <62499840>;
+			clocks = <&osc>;
 			status = "disabled";
 		};
 
@@ -226,5 +258,24 @@
 			interrupts = <GIC_SPI 89 IRQ_TYPE_NONE>;
 			clock-frequency = <100000>;
 		};
+
+		lcpll0: lcpll0 at 3f100 {
+			#clock-cells = <1>;
+			compatible = "brcm,nsp-lcpll0";
+			reg = <0x3f100 0x14>;
+			clocks = <&osc>;
+			clock-output-names = "lcpll0", "pcie_phy", "sdio",
+					     "ddr_phy";
+		};
+
+		genpll: genpll at 3f140 {
+			#clock-cells = <1>;
+			compatible = "brcm,nsp-genpll";
+			reg = <0x3f140 0x24>;
+			clocks = <&osc>;
+			clock-output-names = "genpll", "phy", "ethernetclk",
+					     "usbclk", "iprocfast", "sata1",
+					     "sata2";
+		};
 	};
 };
-- 
1.9.1
