From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:26 +0900
Subject: [PATCH 10/11] ARM: shmobile: sh73a0 dtsi: Add PM domain support
In-Reply-To: <cover.1425518682.git.horms+renesas@verge.net.au>
References: <cover.1425518682.git.horms+renesas@verge.net.au>
Message-ID: <bee7a18e85421ed3ec0131574378de10b5762d54.1425518682.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the System Controller, with subnodes that
represent the hardware power area hierarchy.
Hook up all devices to their respective PM domains.

Note that unlike on R-Mobile A1 (r8a7740), PM domain D4 can be powered
down without ill effects on s2ram behavior, just like on SH-Mobile AP4
(sh7372).  Hence we can postpone adding a (minimal) device node for the
Coresight-ETM hardware block.

The System Controller is also used by the R-Mobile Reset driver, which
can now restart the system.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 144 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 0b933e2..45b539c 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -27,12 +27,14 @@
 			compatible = "arm,cortex-a9";
 			reg = <0>;
 			clock-frequency = <1196000000>;
+			power-domains = <&pd_a2sl>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
 			clock-frequency = <1196000000>;
+			power-domains = <&pd_a2sl>;
 		};
 	};
 
@@ -57,6 +59,7 @@
 		interrupts = <0 37 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 38 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "sec", "temp";
+		power-domains = <&pd_a4bc1>;
 	};
 
 	sbsc1: memory-controller at fe400000 {
@@ -65,6 +68,7 @@
 		interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 36 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "sec", "temp";
+		power-domains = <&pd_a4bc0>;
 	};
 
 	pmu {
@@ -77,11 +81,12 @@
 		compatible = "renesas,cmt-48-sh73a0", "renesas,cmt-48";
 		reg = <0xe6138000 0x200>;
 		interrupts = <0 65 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks SH73A0_CLK_CMT1>;
+		clock-names = "fck";
+		power-domains = <&pd_c5>;
 
 		renesas,channels-mask = <0x3f>;
 
-		clocks = <&mstp3_clks SH73A0_CLK_CMT1>;
-		clock-names = "fck";
 		status = "disabled";
 	};
 
@@ -103,6 +108,7 @@
 			      0 7 IRQ_TYPE_LEVEL_HIGH
 			      0 8 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks SH73A0_CLK_INTCA0>;
+		power-domains = <&pd_a4s>;
 		control-parent;
 	};
 
@@ -124,6 +130,7 @@
 			      0 15 IRQ_TYPE_LEVEL_HIGH
 			      0 16 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks SH73A0_CLK_INTCA0>;
+		power-domains = <&pd_a4s>;
 		control-parent;
 	};
 
@@ -145,6 +152,7 @@
 			      0 23 IRQ_TYPE_LEVEL_HIGH
 			      0 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks SH73A0_CLK_INTCA0>;
+		power-domains = <&pd_a4s>;
 		control-parent;
 	};
 
@@ -166,6 +174,7 @@
 			      0 31 IRQ_TYPE_LEVEL_HIGH
 			      0 32 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks SH73A0_CLK_INTCA0>;
+		power-domains = <&pd_a4s>;
 		control-parent;
 	};
 
@@ -179,6 +188,7 @@
 			      0 169 IRQ_TYPE_LEVEL_HIGH
 			      0 170 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks SH73A0_CLK_IIC0>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -192,6 +202,7 @@
 			      0 53 IRQ_TYPE_LEVEL_HIGH
 			      0 54 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks SH73A0_CLK_IIC1>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -205,6 +216,7 @@
 			      0 173 IRQ_TYPE_LEVEL_HIGH
 			      0 174 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks SH73A0_CLK_IIC2>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -218,6 +230,7 @@
 			      0 185 IRQ_TYPE_LEVEL_HIGH
 			      0 186 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks SH73A0_CLK_IIC3>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -231,6 +244,7 @@
 			      0 189 IRQ_TYPE_LEVEL_HIGH
 			      0 190 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks SH73A0_CLK_IIC4>;
+		power-domains = <&pd_c5>;
 		status = "disabled";
 	};
 
@@ -240,6 +254,7 @@
 		interrupts = <0 140 IRQ_TYPE_LEVEL_HIGH
 			      0 141 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks SH73A0_CLK_MMCIF0>;
+		power-domains = <&pd_a3sp>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -251,6 +266,7 @@
 			      0 84 IRQ_TYPE_LEVEL_HIGH
 			      0 85 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks SH73A0_CLK_SDHI0>;
+		power-domains = <&pd_a3sp>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -262,6 +278,7 @@
 		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH
 			      0 89 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks SH73A0_CLK_SDHI1>;
+		power-domains = <&pd_a3sp>;
 		toshiba,mmc-wrprotect-disable;
 		cap-sd-highspeed;
 		status = "disabled";
@@ -273,6 +290,7 @@
 		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH
 			      0 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks SH73A0_CLK_SDHI2>;
+		power-domains = <&pd_a3sp>;
 		toshiba,mmc-wrprotect-disable;
 		cap-sd-highspeed;
 		status = "disabled";
@@ -284,6 +302,7 @@
 		interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA0>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -293,6 +312,7 @@
 		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA1>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -302,6 +322,7 @@
 		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA2>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -311,6 +332,7 @@
 		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA3>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -320,6 +342,7 @@
 		interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA4>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -329,6 +352,7 @@
 		interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA5>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -338,6 +362,7 @@
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks SH73A0_CLK_SCIFA6>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -347,6 +372,7 @@
 		interrupts = <0 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA7>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -356,6 +382,7 @@
 		interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFB>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -374,6 +401,117 @@
 			<&irqpin2 4 0>, <&irqpin2 5 0>, <&irqpin2 6 0>, <&irqpin2 7 0>,
 			<&irqpin3 0 0>, <&irqpin3 1 0>, <&irqpin3 2 0>, <&irqpin3 3 0>,
 			<&irqpin3 4 0>, <&irqpin3 5 0>, <&irqpin3 6 0>, <&irqpin3 7 0>;
+		power-domains = <&pd_c5>;
+	};
+
+	sysc: system-controller at e6180000 {
+		compatible = "renesas,sysc-sh73a0", "renesas,sysc-rmobile";
+		reg = <0xe6180000 0x8000>, <0xe6188000 0x8000>;
+
+		pm-domains {
+			pd_c5: c5 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <0>;
+
+				pd_c4: c4 at 0 {
+					reg = <0>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_d4: d4 at 1 {
+					reg = <1>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_a4bc0: a4bc0 at 4 {
+					reg = <4>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_a4bc1: a4bc1 at 5 {
+					reg = <5>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_a4lc0: a4lc0 at 6 {
+					reg = <6>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_a4lc1: a4lc1 at 7 {
+					reg = <7>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_a4mp: a4mp at 8 {
+					reg = <8>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <0>;
+
+					pd_a3mp: a3mp at 9 {
+						reg = <9>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_a3vc: a3vc at 10 {
+						reg = <10>;
+						#power-domain-cells = <0>;
+					};
+				};
+
+				pd_a4rm: a4rm at 12 {
+					reg = <12>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <0>;
+
+					pd_a3r: a3r at 13 {
+						reg = <13>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <0>;
+
+						pd_a2rv: a2rv at 14 {
+							reg = <14>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+
+				pd_a4s: a4s at 16 {
+					reg = <16>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <0>;
+
+					pd_a3sp: a3sp at 17 {
+						reg = <17>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_a3sg: a3sg at 18 {
+						reg = <18>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_a3sm: a3sm at 19 {
+						reg = <19>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <0>;
+
+						pd_a2sl: a2sl at 20 {
+							reg = <20>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+			};
+		};
 	};
 
 	sh_fsi2: sound at ec230000 {
@@ -381,6 +519,7 @@
 		compatible = "renesas,fsi2-sh73a0", "renesas,sh_fsi2";
 		reg = <0xec230000 0x400>;
 		interrupts = <0 146 0x4>;
+		power-domains = <&pd_a4mp>;
 		status = "disabled";
 	};
 
@@ -393,6 +532,7 @@
 		reg = <0xfec10000 0x400>;
 		interrupts = <0 39 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&zb_clk>;
+		power-domains = <&pd_a4s>;
 	};
 
 	clocks {
-- 
2.1.4
