From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 27 Apr 2018 22:12:51 +0300
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77980: add CAN-FD support
In-Reply-To: <c184f961-2f98-532f-ed02-6f3751256d9c@cogentembedded.com>
References: <c184f961-2f98-532f-ed02-6f3751256d9c@cogentembedded.com>
Message-ID: <f07c00b3-228c-e0d2-f7fe-38b8e9f25a4d@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A77980 part of the CAN-FD device node.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77980.dtsi |   31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -38,6 +38,13 @@
 		};
 	};
 
+	/* External CAN clock - to be overridden by boards that provide it */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
 	extal_clk: extal {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -170,6 +177,30 @@
 			status = "disabled";
 		};
 
+		canfd: can at e66c0000 {
+			compatible = "renesas,r8a77980-canfd",
+				     "renesas,rcar-gen3-canfd";
+			reg = <0 0xe66c0000 0 0x8000>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 914>,
+			         <&cpg CPG_CORE R8A77980_CLK_CANFD>,
+				 <&can_clk>;
+			clock-names = "fck", "canfd", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A77980_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
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
 		avb: ethernet at e6800000 {
 			compatible = "renesas,etheravb-r8a77980",
 				     "renesas,etheravb-rcar-gen3";
