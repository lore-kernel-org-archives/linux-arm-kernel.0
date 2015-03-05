From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:04 +0900
Subject: [PATCH 12/13] ARM: shmobile: r8a73a4 dtsi: Add PM domain support
In-Reply-To: <cover.1425517246.git.horms+renesas@verge.net.au>
References: <cover.1425517246.git.horms+renesas@verge.net.au>
Message-ID: <7b9ad9a0ab82be3cb0607d5242584a4a4948e89c.1425517246.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the System Controller, with subnodes that
represent the hardware power area hierarchy.
Hook up all devices to their respective PM domains.

Add a minimal device node for the Coresight-ETM hardware block, and
hook it up to the D4 PM domain, so the R-Mobile System Controller
driver can keep the domain powered, until the new Coresight code
handles runtime PM.

The System Controller is also used by the R-Mobile Reset driver, which
can now restart the system.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 177 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index d41201d..0fd889f 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -28,9 +28,15 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			clock-frequency = <1500000000>;
+			power-domains = <&pd_a2sl>;
 		};
 	};
 
+	ptm {
+		compatible = "arm,coresight-etm3x";
+		power-domains = <&pd_d4>;
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <1 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
@@ -42,11 +48,13 @@
 	dbsc1: memory-controller at e6790000 {
 		compatible = "renesas,dbsc-r8a73a4";
 		reg = <0 0xe6790000 0 0x10000>;
+		power-domains = <&pd_a3bc>;
 	};
 
 	dbsc2: memory-controller at e67a0000 {
 		compatible = "renesas,dbsc-r8a73a4";
 		reg = <0 0xe67a0000 0 0x10000>;
+		power-domains = <&pd_a3bc>;
 	};
 
 	dmac: dma-multiplexer {
@@ -89,6 +97,7 @@
 					"ch12", "ch13", "ch14", "ch15",
 					"ch16", "ch17", "ch18", "ch19";
 			clocks = <&mstp2_clks R8A73A4_CLK_DMAC>;
+			power-domains = <&pd_a3sp>;
 		};
 	};
 
@@ -99,6 +108,7 @@
 		reg = <0 0xe60b0000 0 0x428>;
 		interrupts = <0 179 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A73A4_CLK_IIC5>;
+		power-domains = <&pd_a3sp>;
 
 		status = "disabled";
 	};
@@ -109,6 +119,7 @@
 		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_CMT1>;
 		clock-names = "fck";
+		power-domains = <&pd_c5>;
 
 		renesas,channels-mask = <0xff>;
 
@@ -152,6 +163,7 @@
 			     <0 29 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 30 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 31 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&pd_c4>;
 	};
 
 	irqc1: interrupt-controller at e61c0200 {
@@ -185,6 +197,7 @@
 			     <0 55 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 56 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 57 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&pd_c4>;
 	};
 
 	pfc: pfc at e6050000 {
@@ -208,6 +221,7 @@
 			<&irqc1 16 0>, <&irqc1 17 0>, <&irqc1 18 0>, <&irqc1 19 0>,
 			<&irqc1 20 0>, <&irqc1 21 0>, <&irqc1 22 0>, <&irqc1 23 0>,
 			<&irqc1 24 0>, <&irqc1 25 0>;
+		power-domains = <&pd_c5>;
 	};
 
 	thermal at e61f0000 {
@@ -216,6 +230,7 @@
 			 <0 0xe61f0200 0 0x38>, <0 0xe61f0300 0 0x38>;
 		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A73A4_CLK_THERMAL>;
+		power-domains = <&pd_c5>;
 	};
 
 	i2c0: i2c at e6500000 {
@@ -225,6 +240,7 @@
 		reg = <0 0xe6500000 0 0x428>;
 		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_IIC0>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -235,6 +251,7 @@
 		reg = <0 0xe6510000 0 0x428>;
 		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_IIC1>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -245,6 +262,7 @@
 		reg = <0 0xe6520000 0 0x428>;
 		interrupts = <0 176 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_IIC2>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -255,6 +273,7 @@
 		reg = <0 0xe6530000 0 0x428>;
 		interrupts = <0 177 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A73A4_CLK_IIC3>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -265,6 +284,7 @@
 		reg = <0 0xe6540000 0 0x428>;
 		interrupts = <0 178 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A73A4_CLK_IIC4>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -275,6 +295,7 @@
 		reg = <0 0xe6550000 0 0x428>;
 		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_IIC6>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -285,6 +306,7 @@
 		reg = <0 0xe6560000 0 0x428>;
 		interrupts = <0 185 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_IIC7>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -295,6 +317,7 @@
 		reg = <0 0xe6570000 0 0x428>;
 		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A73A4_CLK_IIC8>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -304,6 +327,7 @@
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB0>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -313,6 +337,7 @@
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB1>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -322,6 +347,7 @@
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFA0>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -331,6 +357,7 @@
 		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFA1>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -340,6 +367,7 @@
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB2>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -349,6 +377,7 @@
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB3>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_c4>;
 		status = "disabled";
 	};
 
@@ -357,6 +386,7 @@
 		reg = <0 0xee100000 0 0x100>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_SDHI0>;
+		power-domains = <&pd_a3sp>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -366,6 +396,7 @@
 		reg = <0 0xee120000 0 0x100>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_SDHI1>;
+		power-domains = <&pd_a3sp>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -375,6 +406,7 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_SDHI2>;
+		power-domains = <&pd_a3sp>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -384,6 +416,7 @@
 		reg = <0 0xee200000 0 0x80>;
 		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_MMCIF0>;
+		power-domains = <&pd_a3sp>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -393,6 +426,7 @@
 		reg = <0 0xee220000 0 0x80>;
 		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_MMCIF1>;
+		power-domains = <&pd_a3sp>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -417,6 +451,7 @@
 		ranges = <0 0 0 0x20000000>;
 		reg = <0 0xfec10000 0 0x400>;
 		clocks = <&zb_clk>;
+		power-domains = <&pd_c4>;
 	};
 
 	clocks {
@@ -711,4 +746,146 @@
 				"thermal", "iic8";
 		};
 	};
+
+	sysc: system-controller at e6180000 {
+		compatible = "renesas,sysc-r8a73a4", "renesas,sysc-rmobile";
+		reg = <0 0xe6180000 0 0x8000>, <0 0xe6188000 0 0x8000>;
+
+		pm-domains {
+			pd_c5: c5 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <0>;
+
+				pd_c4: c4 at 0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <0>;
+
+					pd_a3sg: a3sg at 16 {
+						reg = <16>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_a3ex: a3ex at 17 {
+						reg = <17>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_a3sp: a3sp at 18 {
+						reg = <18>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <0>;
+
+						pd_a2us: a2us at 19 {
+							reg = <19>;
+							#power-domain-cells = <0>;
+						};
+					};
+
+					pd_a3sm: a3sm at 20 {
+						reg = <20>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <0>;
+
+						pd_a2sl: a2sl at 21 {
+							reg = <21>;
+							#power-domain-cells = <0>;
+						};
+					};
+
+					pd_a3km: a3km at 22 {
+						reg = <22>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <0>;
+
+						pd_a2kl: a2kl at 23 {
+							reg = <23>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+
+				pd_c4ma: c4ma at 1 {
+					reg = <1>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_c4cl: c4cl at 2 {
+					reg = <2>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_d4: d4 at 3 {
+					reg = <3>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_a4bc: a4bc at 4 {
+					reg = <4>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <0>;
+
+					pd_a3bc: a3bc at 5 {
+						reg = <5>;
+						#power-domain-cells = <0>;
+					};
+				};
+
+				pd_a4l: a4l at 6 {
+					reg = <6>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_a4lc: a4lc at 7 {
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
+				pd_a4sf: a4sf at 11 {
+					reg = <11>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_a3r: a3r at 12 {
+					reg = <12>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <0>;
+
+					pd_a2rv: a2rv at 13 {
+						reg = <13>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_a2is: a2is at 14 {
+						reg = <14>;
+						#power-domain-cells = <0>;
+					};
+				};
+			};
+		};
+	};
 };
-- 
2.1.4
