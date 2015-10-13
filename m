From: jonmason@broadcom.com (Jon Mason)
Date: Tue, 13 Oct 2015 17:22:27 -0400
Subject: [RFC 5/5] ARM: dts: enable clock support for Broadcom NS2
In-Reply-To: <1444771347-11382-1-git-send-email-jonmason@broadcom.com>
References: <1444771347-11382-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1444771347-11382-6-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree entries for clock support for Broadcom Northstar 2 SoC

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 93 ++++++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 3c92d92..c632f3b 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -31,6 +31,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/bcm-ns2.h>
 
 /memreserve/ 0x84b00000 0x00000008;
 
@@ -89,25 +90,103 @@
 			      IRQ_TYPE_EDGE_RISING)>;
 	};
 
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		osc: oscillator {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <25000000>;
+		};
+
+		iprocmed: iprocmed {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clocks = <&genpll_scr BCM_NS2_GENPLL_SCR_SCR_CLK>;
+			clock-div = <2>;
+			clock-mult = <1>;
+		};
+
+		iprocslow: iprocslow {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clocks = <&genpll_scr BCM_NS2_GENPLL_SCR_SCR_CLK>;
+			clock-div = <4>;
+			clock-mult = <1>;
+		};
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
+		ranges = <0 0 0x65000000 0x01130100>;
+
+		lcpll_ddr: lcpll_ddr at 001d058 {
+			#clock-cells = <1>;
+			compatible = "brcm,ns2-lcpll-ddr";
+			reg = <0x001d058 0x20>,
+			      <0x001c020 0x4>,
+			      <0x001d04c 0x4>;
+			clocks = <&osc>;
+			clock-output-names = "lcpll_ddr", "pcie_sata_usb",
+					     "ddr", "ddr_ch2_unused",
+					     "ddr_ch3_unused", "ddr_ch4_unused",
+					     "ddr_ch5_unused";
+		};
+
+		lcpll_ports: lcpll_ports at 1d078 {
+			#clock-cells = <1>;
+			compatible = "brcm,ns2-lcpll-ports";
+			reg = <0x001d078 0x20>,
+			      <0x001c020 0x4>,
+			      <0x001d054 0x4>;
+			clocks = <&osc>;
+			clock-output-names = "lcpll_ports", "wan", "rgmii",
+					     "ports_ch2_unused",
+					     "ports_ch3_unused",
+					     "ports_ch4_unused",
+					     "ports_ch5_unused";
+		};
+
+		genpll_scr: genpll_scr at 001d098 {
+			#clock-cells = <1>;
+			compatible = "brcm,ns2-genpll-scr";
+			reg = <0x001d098 0x32>,
+			      <0x001c020 0x4>,
+			      <0x001d044 0x4>;
+			clocks = <&osc>;
+			clock-output-names = "genpll_scr", "scr", "fs",
+					     "audio_ref", "scr_ch3_unused",
+					     "scr_ch4_unused", "scr_ch5_unused";
+		};
+
+		genpll_sw: genpll_sw at 001d0c4 {
+			#clock-cells = <1>;
+			compatible = "brcm,ns2-genpll-sw";
+			reg = <0x001d0c4 0x32>,
+			      <0x001c020 0x4>,
+			      <0x001d044 0x4>;
+			clocks = <&osc>;
+			clock-output-names = "genpll_sw", "rpe", "250", "nic",
+					     "chimp", "port", "sdio";
+		};
 
-		gic: interrupt-controller at 65210000 {
+		gic: interrupt-controller at 0210000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
 			interrupt-controller;
-			reg = <0x65210000 0x1000>,
-			      <0x65220000 0x1000>,
-			      <0x65240000 0x2000>,
-			      <0x65260000 0x1000>;
+			reg = <0x0210000 0x1000>,
+			      <0x0220000 0x1000>,
+			      <0x0240000 0x2000>,
+			      <0x0260000 0x1000>;
 		};
 
-		uart3: serial at 66130000 {
+		uart3: serial at 1130000 {
 			compatible = "snps,dw-apb-uart";
-			reg = <0x66130000 0x100>;
+			reg = <0x1130000 0x100>;
 			interrupts = <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-- 
1.9.1
