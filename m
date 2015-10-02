From: jonmason@broadcom.com (Jon Mason)
Date: Fri, 2 Oct 2015 18:57:45 -0400
Subject: [PATCH 10/10] ARM: dts: enable clock support for Broadcom NS2
In-Reply-To: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
References: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1443826665-17570-11-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree entries for clock support for Broadcom Northstar 2 SoC

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 81 +++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 3c92d92..0b8921e 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -31,6 +31,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/bcm-ns2.h>
 
 /memreserve/ 0x84b00000 0x00000008;
 
@@ -89,6 +90,86 @@
 			      IRQ_TYPE_EDGE_RISING)>;
 	};
 
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0x6501c000 0x00002000>;
+
+		osc: oscillator {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <25000000>;
+		};
+
+		lcpll_ddr: lcpll_ddr at 1058 {
+			#clock-cells = <1>;
+			compatible = "brcm,ns2-lcpll-ddr";
+			reg = <0x1058 0x20>,
+			      <0x0020 0x4>,
+			      <0x104c 0x4>;
+			clocks = <&osc>;
+			clock-output-names = "lcpll_ddr", "pcie_sata_usb",
+					     "ddr", "ddr_ch2_unused",
+					     "ddr_ch3_unused", "ddr_ch4_unused",
+					     "ddr_ch5_unused";
+		};
+
+		lcpll_ports: lcpll_ports at 1078 {
+			#clock-cells = <1>;
+			compatible = "brcm,ns2-lcpll-ports";
+			reg = <0x1078 0x20>,
+			      <0x0020 0x4>,
+			      <0x1054 0x4>;
+			clocks = <&osc>;
+			clock-output-names = "lcpll_ports", "wan", "rgmii",
+					     "ports_ch2_unused",
+					     "ports_ch3_unused",
+					     "ports_ch4_unused",
+					     "ports_ch5_unused";
+		};
+
+		genpll_scr: genpll_scr at 1098 {
+			#clock-cells = <1>;
+			compatible = "brcm,ns2-genpll-scr";
+			reg = <0x1098 0x32>,
+			      <0x0020 0x4>,
+			      <0x1044 0x4>;
+			clocks = <&osc>;
+			clock-output-names = "genpll_scr", "scr", "fs",
+					     "audio_ref", "scr_ch3_unused",
+					     "scr_ch4_unused", "scr_ch5_unused";
+		};
+
+		genpll_sw: genpll_sw at 10c4 {
+			#clock-cells = <1>;
+			compatible = "brcm,ns2-genpll-sw";
+			reg = <0x10c4 0x32>,
+			      <0x0020 0x4>,
+			      <0x1044 0x4>;
+			clocks = <&osc>;
+			clock-output-names = "genpll_sw", "rpe", "250", "nic",
+					     "chimp", "port", "sdio";
+		};
+
+		iprocmed: iprocmed {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clocks = <&genpll_scr BCM_NS2_GENPLL_SCR_SCR_CLK>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "iprocmed";
+		};
+
+		iprocslow: iprocslow {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clocks = <&genpll_scr BCM_NS2_GENPLL_SCR_SCR_CLK>;
+			clock-div = <4>;
+			clock-mult = <1>;
+			clock-output-names = "iprocslow";
+		};
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
1.9.1
