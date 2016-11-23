From: chris.paterson2@renesas.com (Chris Paterson)
Date: Wed, 23 Nov 2016 12:14:39 +0000
Subject: [PATCH 2/3] arm64: dts: r8a7796: Add CAN support
Message-ID: <1479903279-1950-1-git-send-email-chris.paterson2@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds CAN controller nodes for r8a7796.

Based on a patch for r8a7795 by Ramesh Shanmugasundaram.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 .../devicetree/bindings/net/can/rcar_can.txt       | 12 +++++----
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 30 ++++++++++++++++++++++
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
index 8d40ab2..06bb7cc 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
@@ -10,6 +10,7 @@ Required properties:
 	      "renesas,can-r8a7793" if CAN controller is a part of R8A7793 SoC.
 	      "renesas,can-r8a7794" if CAN controller is a part of R8A7794 SoC.
 	      "renesas,can-r8a7795" if CAN controller is a part of R8A7795 SoC.
+	      "renesas,can-r8a7796" if CAN controller is a part of R8A7796 SoC.
 	      "renesas,rcar-gen1-can" for a generic R-Car Gen1 compatible device.
 	      "renesas,rcar-gen2-can" for a generic R-Car Gen2 compatible device.
 	      "renesas,rcar-gen3-can" for a generic R-Car Gen3 compatible device.
@@ -24,11 +25,12 @@ Required properties:
 - pinctrl-0: pin control group to be used for this controller.
 - pinctrl-names: must be "default".
 
-Required properties for "renesas,can-r8a7795" compatible:
-In R8A7795 SoC, "clkp2" can be CANFD clock. This is a div6 clock and can be
-used by both CAN and CAN FD controller at the same time. It needs to be scaled
-to maximum frequency if any of these controllers use it. This is done using
-the below properties.
+Required properties for "renesas,can-r8a7795" and "renesas,can-r8a7796"
+compatible:
+In R8A7795 and R8A7796 SoCs, "clkp2" can be CANFD clock. This is a div6 clock
+and can be used by both CAN and CAN FD controller at the same time. It needs to
+be scaled to maximum frequency if any of these controllers use it. This is done
+using the below properties:
 
 - assigned-clocks: phandle of clkp2(CANFD) clock.
 - assigned-clock-rates: maximum frequency of this clock.
diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 91d716e..95857fc 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -362,6 +362,36 @@
 			status = "disabled";
 		};
 
+		can0: can at e6c30000 {
+			compatible = "renesas,can-r8a7796",
+				     "renesas,rcar-gen3-can";
+			reg = <0 0xe6c30000 0 0x1000>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 916>,
+			       <&cpg CPG_CORE R8A7796_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A7796_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		can1: can at e6c38000 {
+			compatible = "renesas,can-r8a7796",
+				     "renesas,rcar-gen3-can";
+			reg = <0 0xe6c38000 0 0x1000>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 915>,
+			       <&cpg CPG_CORE R8A7796_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A7796_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		scif2: serial at e6e88000 {
 			compatible = "renesas,scif-r8a7796",
 				     "renesas,rcar-gen3-scif", "renesas,scif";
-- 
1.9.1
