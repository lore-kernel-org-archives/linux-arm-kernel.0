From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 14 Mar 2016 11:29:02 +0900
Subject: [PATCH 1/2] ARM: dts: r8a7794: add CAN clocks to device tree
In-Reply-To: <1457922543-20975-1-git-send-email-horms+renesas@verge.net.au>
References: <1457922543-20975-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1457922543-20975-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CAN nodes to r8a7794 device tree.
Based on work by Sergei Shtylyov for the r8a7791 SoC.

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 23 +++++++++++++++++++++--
 include/dt-bindings/clock/r8a7794-clock.h |  1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index eacb2b291361..c8742a599330 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -844,6 +844,24 @@
 			clock-output-names = "extal";
 		};
 
+		/* External USB clock - can be overridden by the board */
+		usb_extal_clk: usb_extal_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <48000000>;
+			clock-output-names = "usb_extal";
+		};
+
+		/* External CAN clock */
+		can_clk: can_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			/* This value must be overridden by the board. */
+			clock-frequency = <0>;
+			clock-output-names = "can_clk";
+			status = "disabled";
+		};
+
 		/* External SCIF clock */
 		scif_clk: scif {
 			compatible = "fixed-clock";
@@ -858,10 +876,11 @@
 			compatible = "renesas,r8a7794-cpg-clocks",
 				     "renesas,rcar-gen2-cpg-clocks";
 			reg = <0 0xe6150000 0 0x1000>;
-			clocks = <&extal_clk>;
+			clocks = <&extal_clk &usb_extal_clk>;
 			#clock-cells = <1>;
 			clock-output-names = "main", "pll0", "pll1", "pll3",
-					     "lb", "qspi", "sdh", "sd0", "z";
+					     "lb", "qspi", "sdh", "sd0", "z",
+					     "rcan";
 			#power-domain-cells = <0>;
 		};
 		/* Variable factor clocks */
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index f843de6bf377..222a9dcbabb8 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -21,6 +21,7 @@
 #define R8A7794_CLK_SDH			6
 #define R8A7794_CLK_SD0			7
 #define R8A7794_CLK_Z			8
+#define R8A7794_CLK_RCAN		9
 
 /* MSTP0 */
 #define R8A7794_CLK_MSIOF0		0
-- 
2.1.4
