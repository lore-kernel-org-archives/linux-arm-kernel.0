From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:55:00 +0100
Subject: [PATCH 34/40] arm64: dts: renesas: r8a77990: ebisu: Add and enable
 CAN, FD device nodes
In-Reply-To: <cover.1543229515.git.horms+renesas@verge.net.au>
References: <cover.1543229515.git.horms+renesas@verge.net.au>
Message-ID: <327d1f320872c6c616e4cd369257f31eb48d0401.1543229516.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Vasut <marek.vasut@gmail.com>

This patch adds CAN0,1 and CANFD device nodes for the r8a77990 SoC
and enables CANFD connected to CN10 on the E3 Ebisu board using the
R8A77990 SoC.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts | 15 ++++++
 arch/arm64/boot/dts/renesas/r8a77990.dtsi      | 64 ++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
index 3e4d90b654cc..62bdddcbbae7 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -260,6 +260,16 @@
 	};
 };
 
+&canfd {
+	pinctrl-0 = <&canfd0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	channel0 {
+		status = "okay";
+	};
+};
+
 &csi40 {
 	status = "okay";
 
@@ -460,6 +470,11 @@
 		};
 	};
 
+	canfd0_pins: canfd0 {
+		groups = "canfd0_data";
+		function = "canfd0";
+	};
+
 	du_pins: du {
 		groups = "du_rgb888", "du_sync", "du_disp", "du_clk_out_0";
 		function = "du";
diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index 46868dacbeef..b0398e05e8ed 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -48,6 +48,13 @@
 		clock-frequency = <0>;
 	};
 
+	/* External CAN clock - to be overridden by boards that provide it */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -773,6 +780,63 @@
 			status = "disabled";
 		};
 
+		can0: can at e6c30000 {
+			compatible = "renesas,can-r8a77990",
+				     "renesas,rcar-gen3-can";
+			reg = <0 0xe6c30000 0 0x1000>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 916>,
+			       <&cpg CPG_CORE R8A77990_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A77990_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 916>;
+			status = "disabled";
+		};
+
+		can1: can at e6c38000 {
+			compatible = "renesas,can-r8a77990",
+				     "renesas,rcar-gen3-can";
+			reg = <0 0xe6c38000 0 0x1000>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 915>,
+			       <&cpg CPG_CORE R8A77990_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A77990_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 915>;
+			status = "disabled";
+		};
+
+		canfd: can at e66c0000 {
+			compatible = "renesas,r8a77990-canfd",
+				     "renesas,rcar-gen3-canfd";
+			reg = <0 0xe66c0000 0 0x8000>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				   <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 914>,
+			       <&cpg CPG_CORE R8A77990_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "fck", "canfd", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A77990_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 914>;
+			status = "disabled";
+
+			channel0 {
+				status = "disabled";
+			};
+
+			channel1 {
+				status = "disabled";
+			};
+		};
+
 		pwm0: pwm at e6e30000 {
 			compatible = "renesas,pwm-r8a77990", "renesas,pwm-rcar";
 			reg = <0 0xe6e30000 0 0x8>;
-- 
2.11.0
