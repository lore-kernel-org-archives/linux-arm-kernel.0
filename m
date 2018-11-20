From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 21 Nov 2018 00:32:52 +0100
Subject: [PATCH V2] arm64: dts: renesas: r8a77965: Add CAN and CANFD
 controller nodes
Message-ID: <20181120233252.1612-1-marek.vasut+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds CAN{0,1} and CANFD controller nodes for the R8A77965 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
V2: Squash the CAN and CANFD addition patches together.
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 51 ++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 3a958fb25245..1c86e6f4dc71 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -907,13 +907,60 @@
 		};
 
 		can0: can at e6c30000 {
+			compatible = "renesas,can-r8a77965",
+				     "renesas,rcar-gen3-can";
 			reg = <0 0xe6c30000 0 0x1000>;
-			/* placeholder */
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 916>,
+			       <&cpg CPG_CORE R8A77965_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A77965_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 916>;
+			status = "disabled";
 		};
 
 		can1: can at e6c38000 {
+			compatible = "renesas,can-r8a77965",
+				     "renesas,rcar-gen3-can";
 			reg = <0 0xe6c38000 0 0x1000>;
-			/* placeholder */
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 915>,
+			       <&cpg CPG_CORE R8A77965_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A77965_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 915>;
+			status = "disabled";
+		};
+
+		canfd: can at e66c0000 {
+			compatible = "renesas,r8a77965-canfd",
+				     "renesas,rcar-gen3-canfd";
+			reg = <0 0xe66c0000 0 0x8000>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				   <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 914>,
+			       <&cpg CPG_CORE R8A77965_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "fck", "canfd", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A77965_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
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
 		};
 
 		pwm0: pwm at e6e30000 {
-- 
2.18.0
