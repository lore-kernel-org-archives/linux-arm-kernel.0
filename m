From: petr@barix.com (Petr Kulhavy)
Date: Mon,  9 May 2016 16:35:22 +0200
Subject: [PATCH v5 4/4] ARM: DTS: da850: Add McBSP0 and McBSP1
In-Reply-To: <1462804522-29544-1-git-send-email-petr@barix.com>
References: <1462804522-29544-1-git-send-email-petr@barix.com>
Message-ID: <1462804522-29544-5-git-send-email-petr@barix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SoC nodes for McBSP0 and McBSP1 as well as the corresponding pinmux
configurations.

Signed-off-by: Petr Kulhavy <petr@barix.com>
---
v1: initial
v2: add missing TC channel in dmas properties (for compatibility with the new EDMA3 binding)
    remove "-audio" postfix from the compatible string
v3: no change
v4: no change
v5: rebased to current master of git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git
    using "sound@" prefix instead of "mcbsp@" prefix
    address corrected to match the reg value
    removed leading zeros from the reg values

 arch/arm/boot/dts/da850.dtsi | 45 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index cf1aad8190f1..3a4450b7ae4a 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -166,7 +166,24 @@
 					0xc 0x88888888 0xffffffff
 				>;
 			};
-
+			mcbsp0_pins: pinmux_mcbsp0_pins {
+				pinctrl-single,bits = <
+					/* PINMUX2:
+					* CLKS0, DX0, DR0, FSX0
+					* FSR0, CLKX0, CLKR0
+					*/
+					0x8 0x02222220 0xfffffff0
+				>;
+			};
+			mcbsp1_pins: pinmux_mcbsp1_pins {
+				pinctrl-single,bits = <
+					/* PINMUX1:
+					* CLKS1, DX1, DR1, FSX1,
+					* FSR1, CLKX1, CLKR1
+					*/
+					0x4 0x22222220 0xfffffff0
+				>;
+			};
 		};
 		edma0: edma at 0 {
 			compatible = "ti,edma3-tpcc";
@@ -374,6 +391,32 @@
 				<&edma0 0 1>;
 			dma-names = "tx", "rx";
 		};
+
+		mcbsp0: sound at 110000 {
+			compatible = "ti,da850-mcbsp";
+			reg =	<0x110000 0x1000>,
+				<0x310000 0x1000>;
+			reg-names = "mpu", "dat";
+			interrupts = <97 98>;
+			interrupts-names = "rx", "tx";
+			dmas = <&edma0 3 1
+				&edma0 2 1>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+		mcbsp1: sound at 111000 {
+			compatible = "ti,da850-mcbsp";
+			reg =	<0x111000 0x1000>,
+				<0x311000 0x1000>;
+			reg-names = "mpu", "dat";
+			interrupts = <99 100>;
+			interrupts-names = "rx", "tx";
+			dmas = <&edma0 5 1
+				&edma0 4 1>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
 	};
 	nand_cs3 at 62000000 {
 		compatible = "ti,davinci-nand";
-- 
1.9.1
