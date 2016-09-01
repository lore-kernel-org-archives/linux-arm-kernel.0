From: chris.brandt@renesas.com (Chris Brandt)
Date: Thu,  1 Sep 2016 11:54:29 -0400
Subject: [PATCH 2/3] ARM: dts: r7s72100: add ethernet to device tree
In-Reply-To: <20160901155430.23400-1-chris.brandt@renesas.com>
References: <20160901155430.23400-1-chris.brandt@renesas.com>
Message-ID: <20160901155430.23400-2-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 arch/arm/boot/dts/r7s72100.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index e8e2a5d7..fb9ef9c 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -108,6 +108,15 @@
 			clock-output-names = "scif0", "scif1", "scif2", "scif3", "scif4", "scif5", "scif6", "scif7";
 		};
 
+		mstp7_clks: mstp7_clks at fcfe0430 {
+			#clock-cells = <1>;
+			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xfcfe0430 4>;
+			clocks = <&p0_clk>;
+			clock-indices = <R7S72100_CLK_ETHER>;
+			clock-output-names = "ether";
+		};
+
 		mstp9_clks: mstp9_clks at fcfe0438 {
 			#clock-cells = <1>;
 			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
@@ -419,4 +428,17 @@
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
+
+	ether: ethernet at e8203000 {
+		compatible = "renesas,ether-r7s72100";
+		reg = <0xe8203000 0x800>,
+		      <0xe8204800 0x200>;
+		interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R7S72100_CLK_ETHER>;
+		power-domains = <&cpg_clocks>;
+		phy-mode = "mii";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
 };
-- 
2.9.2
