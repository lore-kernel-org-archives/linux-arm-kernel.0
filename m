From: jonmason@broadcom.com (Jon Mason)
Date: Tue, 13 Oct 2015 17:22:24 -0400
Subject: [RFC 2/5] ARM: dts: enable clock support for Broadcom NSP
In-Reply-To: <1444771347-11382-1-git-send-email-jonmason@broadcom.com>
References: <1444771347-11382-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1444771347-11382-3-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace current device tree dummy clocks with real clock support for
Broadcom Northstar Plus SoC

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 93 ++++++++++++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 58aca27..768ee24 100644
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
 
@@ -58,27 +59,34 @@
 			};
 		};
 
-		L2: l2-cache {
-			compatible = "arm,pl310-cache";
-			reg = <0x2000 0x1000>;
-			cache-unified;
-			cache-level = <2>;
+		a9pll: arm_clk at 0000 {
+			#clock-cells = <0>;
+			compatible = "brcm,nsp-armpll";
+			clocks = <&osc>;
+			reg = <0x0000 0x1000>;
+		};
+
+		timer at 20200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0x20200 0x100>;
+			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&periph_clk>;
 		};
 
-		gic: interrupt-controller at 19021000 {
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
 
-		timer at 19020200 {
-			compatible = "arm,cortex-a9-global-timer";
-			reg = <0x0200 0x100>;
-			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&periph_clk>;
+		L2: l2-cache {
+			compatible = "arm,pl310-cache";
+			reg = <0x22000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
 		};
 	};
 
@@ -87,33 +95,76 @@
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
 			#clock-cells = <0>;
-			clock-frequency = <500000000>;
+			compatible = "fixed-factor-clock";
+			clocks = <&genpll BCM_NSP_GENPLL_IPROCFAST_CLK>;
+			clock-div = <4>;
+			clock-mult = <1>;
+		};
+
+		periph_clk: periph_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clocks = <&a9pll>;
+			clock-div = <2>;
+			clock-mult = <1>;
 		};
 	};
 
 	axi {
 		compatible = "simple-bus";
-		ranges = <0x00000000 0x18000000 0x00001000>;
+		ranges = <0x00000000 0x18000000 0x0003f164>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		uart0: serial at 18000300 {
+		uart0: serial at 00300 {
 			compatible = "ns16550a";
-			reg = <0x0300 0x100>;
+			reg = <0x00300 0x100>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <62499840>;
 			status = "disabled";
 		};
 
-		uart1: serial at 18000400 {
+		uart1: serial at 00400 {
 			compatible = "ns16550a";
-			reg = <0x0400 0x100>;
+			reg = <0x00400 0x100>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <62499840>;
 			status = "disabled";
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
