From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Feb 2013 23:25:37 +0800
Subject: [PATCH 01/12] ARM: dts: add generic DMA device tree binding for
 mxs-dma
In-Reply-To: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1361978748-25281-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add generic DMA device tree binding for mxs-dma.  The changes include:

 * Add channel interrupts into DMA controller nodes
 * Add properties '#dma-cells' and 'dma-channels' for DMA controller nodes
 * And properties 'dmas' and 'dma-names' for DMA client nodes
 * Update mxs-dma device tree binding doc

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/dma/fsl-mxs-dma.txt        |   49 +++++++++++++++--
 arch/arm/boot/dts/imx23.dtsi                       |   42 +++++++++++++-
 arch/arm/boot/dts/imx28.dtsi                       |   58 +++++++++++++++++++-
 arch/arm/boot/dts/imx6qdl.dtsi                     |    8 ++-
 4 files changed, 148 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt b/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
index ded0398..a4873e5 100644
--- a/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
@@ -3,17 +3,58 @@
 Required properties:
 - compatible : Should be "fsl,<chip>-dma-apbh" or "fsl,<chip>-dma-apbx"
 - reg : Should contain registers location and length
+- interrupts : Should contain the interrupt numbers of DMA channels.
+  If a channel is empty/reserved, 0 should be filled in place.
+- #dma-cells : Must be <1>.  The number cell specifies the channel ID.
+- dma-channels : Number of channels supported by the DMA controller
+
+Optional properties:
+- interrupt-names : Name of DMA channel interrupts
 
 Supported chips:
 imx23, imx28.
 
 Examples:
-dma-apbh at 80004000 {
+
+dma_apbh: dma-apbh at 80004000 {
 	compatible = "fsl,imx28-dma-apbh";
-	reg = <0x80004000 2000>;
+	reg = <0x80004000 0x2000>;
+	interrupts = <82 83 84 85
+		      88 88 88 88
+		      88 88 88 88
+		      87 86 0 0>;
+	interrupt-names = "ssp0", "ssp1", "ssp2", "ssp3",
+			  "gpmi0", "gmpi1", "gpmi2", "gmpi3",
+			  "gpmi4", "gmpi5", "gpmi6", "gmpi7",
+			  "hsadc", "lcdif", "empty", "empty";
+	#dma-cells = <1>;
+	dma-channels = <16>;
 };
 
-dma-apbx at 80024000 {
+dma_apbx: dma-apbx at 80024000 {
 	compatible = "fsl,imx28-dma-apbx";
-	reg = <0x80024000 2000>;
+	reg = <0x80024000 0x2000>;
+	interrupts = <78 79 66 0
+		      80 81 68 69
+		      70 71 72 73
+		      74 75 76 77>;
+	interrupt-names = "auart4-rx", "aurat4-tx", "spdif-tx", "empty",
+			  "saif0", "saif1", "i2c0", "i2c1",
+			  "auart0-rx", "auart0-tx", "auart1-rx", "auart1-tx",
+			  "auart2-rx", "auart2-tx", "auart3-rx", "auart3-tx";
+	#dma-cells = <1>;
+	dma-channels = <16>;
+};
+
+DMA clients connected to the MXS DMA controller must use the format
+described in the dma.txt file.
+
+Examples:
+
+auart0: serial at 8006a000 {
+	compatible = "fsl,imx28-auart", "fsl,imx23-auart";
+	reg = <0x8006a000 0x2000>;
+	interrupts = <112>;
+	dmas = <&dma_apbx 8>, <&dma_apbx 9>;
+	dma-names = "rx", "tx";
 };
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 56afcf4..889a89a 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -49,9 +49,15 @@
 				reg = <0x80000000 0x2000>;
 			};
 
-			dma-apbh at 80004000 {
+			dma_apbh: dma-apbh at 80004000 {
 				compatible = "fsl,imx23-dma-apbh";
 				reg = <0x80004000 0x2000>;
+				interrupts = <0 14 20 0
+					      13 13 13 13>;
+				interrupt-names = "empty", "ssp0", "ssp1", "empty",
+						  "gpmi0", "gpmi1", "gpmi2", "gpmi3";
+				#dma-cells = <1>;
+				dma-channels = <8>;
 				clocks = <&clks 15>;
 			};
 
@@ -70,6 +76,8 @@
 				interrupt-names = "gpmi-dma", "bch";
 				clocks = <&clks 34>;
 				clock-names = "gpmi_io";
+				dmas = <&dma_apbh 4>;
+				dma-names = "ssp";
 				fsl,gpmi-dma-channel = <4>;
 				status = "disabled";
 			};
@@ -78,6 +86,8 @@
 				reg = <0x80010000 0x2000>;
 				interrupts = <15 14>;
 				clocks = <&clks 33>;
+				dmas = <&dma_apbh 1>;
+				dma-names = "ssp";
 				fsl,ssp-dma-channel = <1>;
 				status = "disabled";
 			};
@@ -304,9 +314,19 @@
 				status = "disabled";
 			};
 
-			dma-apbx at 80024000 {
+			dma_apbx: dma-apbx at 80024000 {
 				compatible = "fsl,imx23-dma-apbx";
 				reg = <0x80024000 0x2000>;
+				interrupts = <7 5 9 26
+					      19 0 25 23
+					      60 58 9 0
+					      0 0 0 0>;
+				interrupt-names = "audio-adc", "audio-dac", "spdif-tx", "i2c",
+						  "saif0", "empty", "auart0-rx", "auart0-tx",
+						  "auart1-rx", "auart1-tx", "saif1", "empty",
+						  "empty", "empty", "empty", "empty";
+				#dma-cells = <1>;
+				dma-channels = <16>;
 				clocks = <&clks 16>;
 			};
 
@@ -342,6 +362,8 @@
 				reg = <0x80034000 0x2000>;
 				interrupts = <2 20>;
 				clocks = <&clks 33>;
+				dmas = <&dma_apbh 2>;
+				dma-names = "ssp";
 				fsl,ssp-dma-channel = <2>;
 				status = "disabled";
 			};
@@ -367,6 +389,8 @@
 
 			saif0: saif at 80042000 {
 				reg = <0x80042000 0x2000>;
+				dmas = <&dma_apbx 4>;
+				dma-names = "saif";
 				status = "disabled";
 			};
 
@@ -377,16 +401,22 @@
 
 			saif1: saif at 80046000 {
 				reg = <0x80046000 0x2000>;
+				dmas = <&dma_apbx 10>;
+				dma-names = "saif";
 				status = "disabled";
 			};
 
 			audio-out at 80048000 {
 				reg = <0x80048000 0x2000>;
+				dmas = <&dma_apbx 1>;
+				dma-names = "dac";
 				status = "disabled";
 			};
 
 			audio-in at 8004c000 {
 				reg = <0x8004c000 0x2000>;
+				dmas = <&dma_apbx 0>;
+				dma-names = "adc";
 				status = "disabled";
 			};
 
@@ -399,11 +429,15 @@
 
 			spdif at 80054000 {
 				reg = <0x80054000 2000>;
+				dmas = <&dma_apbx 2>;
+				dma-names = "spdif";
 				status = "disabled";
 			};
 
 			i2c at 80058000 {
 				reg = <0x80058000 0x2000>;
+				dmas = <&dma_apbx 3>;
+				dma-names = "i2c";
 				status = "disabled";
 			};
 
@@ -433,6 +467,8 @@
 				reg = <0x8006c000 0x2000>;
 				interrupts = <24 25 23>;
 				clocks = <&clks 32>;
+				dmas = <&dma_apbx 6>, <&dma_apbx 7>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -441,6 +477,8 @@
 				reg = <0x8006e000 0x2000>;
 				interrupts = <59 60 58>;
 				clocks = <&clks 32>;
+				dmas = <&dma_apbx 8>, <&dma_apbx 9>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 7ba4966..bb63d4e 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -61,12 +61,24 @@
 			hsadc at 80002000 {
 				reg = <0x80002000 0x2000>;
 				interrupts = <13 87>;
+				dmas = <&dma_apbh 12>;
+				dma-names = "hsadc";
 				status = "disabled";
 			};
 
-			dma-apbh at 80004000 {
+			dma_apbh: dma-apbh at 80004000 {
 				compatible = "fsl,imx28-dma-apbh";
 				reg = <0x80004000 0x2000>;
+				interrupts = <82 83 84 85
+					      88 88 88 88
+					      88 88 88 88
+					      87 86 0 0>;
+				interrupt-names = "ssp0", "ssp1", "ssp2", "ssp3",
+						  "gpmi0", "gmpi1", "gpmi2", "gmpi3",
+						  "gpmi4", "gmpi5", "gpmi6", "gmpi7",
+						  "hsadc", "lcdif", "empty", "empty";
+				#dma-cells = <1>;
+				dma-channels = <16>;
 				clocks = <&clks 25>;
 			};
 
@@ -86,6 +98,8 @@
 				interrupt-names = "gpmi-dma", "bch";
 				clocks = <&clks 50>;
 				clock-names = "gpmi_io";
+				dmas = <&dma_apbh 4>;
+				dma-names = "gpmi";
 				fsl,gpmi-dma-channel = <4>;
 				status = "disabled";
 			};
@@ -96,6 +110,8 @@
 				reg = <0x80010000 0x2000>;
 				interrupts = <96 82>;
 				clocks = <&clks 46>;
+				dmas = <&dma_apbh 0>;
+				dma-names = "ssp";
 				fsl,ssp-dma-channel = <0>;
 				status = "disabled";
 			};
@@ -106,6 +122,8 @@
 				reg = <0x80012000 0x2000>;
 				interrupts = <97 83>;
 				clocks = <&clks 47>;
+				dmas = <&dma_apbh 1>;
+				dma-names = "ssp";
 				fsl,ssp-dma-channel = <1>;
 				status = "disabled";
 			};
@@ -116,6 +134,8 @@
 				reg = <0x80014000 0x2000>;
 				interrupts = <98 84>;
 				clocks = <&clks 48>;
+				dmas = <&dma_apbh 2>;
+				dma-names = "ssp";
 				fsl,ssp-dma-channel = <2>;
 				status = "disabled";
 			};
@@ -126,6 +146,8 @@
 				reg = <0x80016000 0x2000>;
 				interrupts = <99 85>;
 				clocks = <&clks 49>;
+				dmas = <&dma_apbh 3>;
+				dma-names = "ssp";
 				fsl,ssp-dma-channel = <3>;
 				status = "disabled";
 			};
@@ -657,9 +679,19 @@
 				status = "disabled";
 			};
 
-			dma-apbx at 80024000 {
+			dma_apbx: dma-apbx at 80024000 {
 				compatible = "fsl,imx28-dma-apbx";
 				reg = <0x80024000 0x2000>;
+				interrupts = <78 79 66 0
+					      80 81 68 69
+					      70 71 72 73
+					      74 75 76 77>;
+				interrupt-names = "auart4-rx", "aurat4-tx", "spdif-tx", "empty",
+						  "saif0", "saif1", "i2c0", "i2c1",
+						  "auart0-rx", "auart0-tx", "auart1-rx", "auart1-tx",
+						  "auart2-rx", "auart2-tx", "auart3-rx", "auart3-tx";
+				#dma-cells = <1>;
+				dma-channels = <16>;
 				clocks = <&clks 26>;
 			};
 
@@ -690,6 +722,8 @@
 				reg = <0x80030000 0x2000>;
 				interrupts = <38 86>;
 				clocks = <&clks 55>;
+				dmas = <&dma_apbh 13>;
+				dma-names = "lcdif";
 				status = "disabled";
 			};
 
@@ -765,6 +799,8 @@
 				reg = <0x80042000 0x2000>;
 				interrupts = <59 80>;
 				clocks = <&clks 53>;
+				dmas = <&dma_apbx 4>;
+				dma-names = "saif";
 				fsl,saif-dma-channel = <4>;
 				status = "disabled";
 			};
@@ -779,6 +815,8 @@
 				reg = <0x80046000 0x2000>;
 				interrupts = <58 81>;
 				clocks = <&clks 54>;
+				dmas = <&dma_apbx 5>;
+				dma-names = "saif";
 				fsl,saif-dma-channel = <5>;
 				status = "disabled";
 			};
@@ -794,6 +832,8 @@
 			spdif at 80054000 {
 				reg = <0x80054000 0x2000>;
 				interrupts = <45 66>;
+				dmas = <&dma_apbx 2>;
+				dma-names = "spdif";
 				status = "disabled";
 			};
 
@@ -810,6 +850,8 @@
 				reg = <0x80058000 0x2000>;
 				interrupts = <111 68>;
 				clock-frequency = <100000>;
+				dmas = <&dma_apbx 6>;
+				dma-names = "i2c";
 				fsl,i2c-dma-channel = <6>;
 				status = "disabled";
 			};
@@ -821,6 +863,8 @@
 				reg = <0x8005a000 0x2000>;
 				interrupts = <110 69>;
 				clock-frequency = <100000>;
+				dmas = <&dma_apbx 7>;
+				dma-names = "i2c";
 				fsl,i2c-dma-channel = <7>;
 				status = "disabled";
 			};
@@ -844,6 +888,8 @@
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x8006a000 0x2000>;
 				interrupts = <112 70 71>;
+				dmas = <&dma_apbx 8>, <&dma_apbx 9>;
+				dma-names = "rx", "tx";
 				fsl,auart-dma-channel = <8 9>;
 				clocks = <&clks 45>;
 				status = "disabled";
@@ -853,6 +899,8 @@
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x8006c000 0x2000>;
 				interrupts = <113 72 73>;
+				dmas = <&dma_apbx 10>, <&dma_apbx 11>;
+				dma-names = "rx", "tx";
 				clocks = <&clks 45>;
 				status = "disabled";
 			};
@@ -861,6 +909,8 @@
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x8006e000 0x2000>;
 				interrupts = <114 74 75>;
+				dmas = <&dma_apbx 12>, <&dma_apbx 13>;
+				dma-names = "rx", "tx";
 				clocks = <&clks 45>;
 				status = "disabled";
 			};
@@ -869,6 +919,8 @@
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x80070000 0x2000>;
 				interrupts = <115 76 77>;
+				dmas = <&dma_apbx 14>, <&dma_apbx 15>;
+				dma-names = "rx", "tx";
 				clocks = <&clks 45>;
 				status = "disabled";
 			};
@@ -877,6 +929,8 @@
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x80072000 0x2000>;
 				interrupts = <116 78 79>;
+				dmas = <&dma_apbx 0>, <&dma_apbx 1>;
+				dma-names = "rx", "tx";
 				clocks = <&clks 45>;
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 8f34a3cd..ccdcb06 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -65,9 +65,13 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
-		dma-apbh at 00110000 {
+		dma_apbh: dma-apbh at 00110000 {
 			compatible = "fsl,imx6q-dma-apbh", "fsl,imx28-dma-apbh";
 			reg = <0x00110000 0x2000>;
+			interrupts = <0 13 0x04>, <0 13 0x04>, <0 13 0x04>, <0 13 0x04>;
+			interrupt-names = "gpmi0", "gpmi1", "gpmi2", "gpmi3";
+			#dma-cells = <1>;
+			dma-channels = <4>;
 			clocks = <&clks 106>;
 		};
 
@@ -83,6 +87,8 @@
 				 <&clks 150>, <&clks 149>;
 			clock-names = "gpmi_io", "gpmi_apb", "gpmi_bch",
 				      "gpmi_bch_apb", "per1_bch";
+			dmas = <&dma_apbh 0>;
+			dma-names = "gpmi";
 			fsl,gpmi-dma-channel = <0>;
 			status = "disabled";
 		};
-- 
1.7.9.5
