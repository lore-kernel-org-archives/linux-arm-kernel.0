From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 17 Jan 2015 09:58:36 +0900
Subject: [PATCH 03/11] ARM: shmobile: r8a7740 dtsi: Add PM domain support
In-Reply-To: <cover.1421380713.git.horms+renesas@verge.net.au>
References: <cover.1421380713.git.horms+renesas@verge.net.au>
Message-ID: <aba07789d811b6cf645cffc83ac821393027819a.1421380713.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the System Controller, with subnodes that
represent the hardware power area hierarchy.
Hook up all devices to their respective PM domains.

Add a minimal device node for the Coresight-ETM hardware block, and hook
it up to the D4 PM domain, so the R-Mobile System Controller driver can
keep the domain powered, until the new Coresight code handles runtime
PM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 99 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 60ca622..52f2cf4 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -25,6 +25,7 @@
 			device_type = "cpu";
 			reg = <0x0>;
 			clock-frequency = <800000000>;
+			power-domains = <&pd_a3sm>;
 		};
 	};
 
@@ -41,12 +42,18 @@
 		interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	ptm {
+		compatible = "arm,coresight-etm3x";
+		power-domains = <&pd_d4>;
+	};
+
 	cmt1: timer at e6138000 {
 		compatible = "renesas,cmt-48-r8a7740", "renesas,cmt-48";
 		reg = <0xe6138000 0x170>;
 		interrupts = <0 58 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7740_CLK_CMT1>;
 		clock-names = "fck";
+		power-domains = <&pd_c5>;
 
 		renesas,channels-mask = <0x3f>;
 
@@ -72,6 +79,7 @@
 			      0 149 IRQ_TYPE_LEVEL_HIGH
 			      0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_INTCA>;
+		power-domains = <&pd_a4s>;
 	};
 
 	/* irqpin1: IRQ8 - IRQ15 */
@@ -93,6 +101,7 @@
 			      0 149 IRQ_TYPE_LEVEL_HIGH
 			      0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_INTCA>;
+		power-domains = <&pd_a4s>;
 	};
 
 	/* irqpin2: IRQ16 - IRQ23 */
@@ -114,6 +123,7 @@
 			      0 149 IRQ_TYPE_LEVEL_HIGH
 			      0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_INTCA>;
+		power-domains = <&pd_a4s>;
 	};
 
 	/* irqpin3: IRQ24 - IRQ31 */
@@ -135,6 +145,7 @@
 			      0 149 IRQ_TYPE_LEVEL_HIGH
 			      0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_INTCA>;
+		power-domains = <&pd_a4s>;
 	};
 
 	ether: ethernet at e9a00000 {
@@ -143,6 +154,7 @@
 		      <0xe9a01800 0x800>;
 		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7740_CLK_GETHER>;
+		power-domains = <&pd_a4s>;
 		phy-mode = "mii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -159,6 +171,7 @@
 			      0 203 IRQ_TYPE_LEVEL_HIGH
 			      0 204 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7740_CLK_IIC0>;
+		power-domains = <&pd_a4r>;
 		status = "disabled";
 	};
 
@@ -172,6 +185,7 @@
 			      0 72 IRQ_TYPE_LEVEL_HIGH
 			      0 73 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7740_CLK_IIC1>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -181,6 +195,7 @@
 		interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA0>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -190,6 +205,7 @@
 		interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA1>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -199,6 +215,7 @@
 		interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA2>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -208,6 +225,7 @@
 		interrupts = <0 103 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA3>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -217,6 +235,7 @@
 		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA4>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -226,6 +245,7 @@
 		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA5>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -235,6 +255,7 @@
 		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA6>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -244,6 +265,7 @@
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA7>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -253,6 +275,7 @@
 		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFB>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -271,12 +294,14 @@
 			<&irqpin2 4 0>, <&irqpin2 5 0>, <&irqpin2 6 0>, <&irqpin2 7 0>,
 			<&irqpin3 0 0>, <&irqpin3 1 0>, <&irqpin3 2 0>, <&irqpin3 3 0>,
 			<&irqpin3 4 0>, <&irqpin3 5 0>, <&irqpin3 6 0>, <&irqpin3 7 0>;
+		power-domains = <&pd_c5>;
 	};
 
 	tpu: pwm at e6600000 {
 		compatible = "renesas,tpu-r8a7740", "renesas,tpu";
 		reg = <0xe6600000 0x100>;
 		clocks = <&mstp3_clks R8A7740_CLK_TPU0>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 		#pwm-cells = <3>;
 	};
@@ -287,6 +312,7 @@
 		interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH
 			      0 57 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7740_CLK_MMC>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -297,6 +323,7 @@
 			      0 118 IRQ_TYPE_LEVEL_HIGH
 			      0 119 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7740_CLK_SDHI0>;
+		power-domains = <&pd_a3sp>;
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -309,6 +336,7 @@
 			      0 122 IRQ_TYPE_LEVEL_HIGH
 			      0 123 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7740_CLK_SDHI1>;
+		power-domains = <&pd_a3sp>;
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -321,6 +349,7 @@
 			      0 126 IRQ_TYPE_LEVEL_HIGH
 			      0 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A7740_CLK_SDHI2>;
+		power-domains = <&pd_a3sp>;
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -332,6 +361,7 @@
 		reg = <0xfe1f0000 0x400>;
 		interrupts = <0 9 0x4>;
 		clocks = <&mstp3_clks R8A7740_CLK_FSI>;
+		power-domains = <&pd_a4mp>;
 		status = "disabled";
 	};
 
@@ -343,6 +373,7 @@
 			     <0 200 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7740_CLK_TMU0>;
 		clock-names = "fck";
+		power-domains = <&pd_a4r>;
 
 		#renesas,channels = <3>;
 
@@ -357,6 +388,7 @@
 			     <0 172 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7740_CLK_TMU1>;
 		clock-names = "fck";
+		power-domains = <&pd_a4r>;
 
 		#renesas,channels = <3>;
 
@@ -543,4 +575,71 @@
 				"usbhost", "sdhi2", "usbfunc", "usphy";
 		};
 	};
+
+	sysc: system-controller at e6180000 {
+		compatible = "renesas,sysc-r8a7740", "renesas,sysc-rmobile";
+		reg = <0xe6180000 0x8000>, <0xe6188000 0x8000>;
+
+		pm-domains {
+			pd_c5: c5 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <0>;
+
+				pd_a4lc: a4lc at 1 {
+					reg = <1>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_a4mp: a4mp at 2 {
+					reg = <2>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_d4: d4 at 3 {
+					reg = <3>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_a4r: a4r at 5 {
+					reg = <5>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <0>;
+
+					pd_a3rv: a3rv at 6 {
+						reg = <6>;
+						#power-domain-cells = <0>;
+					};
+				};
+
+				pd_a4s: a4s at 10 {
+					reg = <10>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <0>;
+
+					pd_a3sp: a3sp at 11 {
+						reg = <11>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_a3sm: a3sm at 12 {
+						reg = <12>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_a3sg: a3sg at 13 {
+						reg = <13>;
+						#power-domain-cells = <0>;
+					};
+				};
+
+				pd_a4su: a4su at 20 {
+					reg = <20>;
+					#power-domain-cells = <0>;
+				};
+			};
+		};
+	};
 };
-- 
2.1.4
