From: denis@eukrea.com (Denis Carikli)
Date: Mon, 16 Jun 2014 11:28:51 +0200
Subject: [PATCH v3 4/6] ARM: dts: imx25: Add TSC and ADC support
In-Reply-To: <1402910933-20534-1-git-send-email-denis@eukrea.com>
References: <1402910933-20534-1-git-send-email-denis@eukrea.com>
Message-ID: <1402910933-20534-4-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
Changelog v2->v3:
- Added ADC controller support: making a separate patch
  for it would have been overkill.
- Moved the common TSC and ADC sub-nodes inside this patch
  instead of having a copy in each dts using it.
---
 arch/arm/boot/dts/imx25.dtsi |   30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 98783f5..3187342 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -264,13 +264,37 @@
 				status = "disabled";
 			};
 
-			tsc: tsc at 50030000 {
-				compatible = "fsl,imx25-adc", "fsl,imx21-tsc";
-				reg = <0x50030000 0x4000>;
+			tscadc: tscadc at 50030000 {
+				compatible = "fsl,imx25-tsadc";
+				reg = <0x50030000 0xc>;
 				interrupts = <46>;
 				clocks = <&clks 119>;
 				clock-names = "ipg";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
 				status = "disabled";
+
+				adc: adc at 50030800 {
+					compatible = "fsl,imx25-gcq";
+					reg = <0x50030800 0x60>;
+					interrupt-parent = <&tscadc>;
+					interrupts = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					status = "disabled";
+				};
+
+				tsc: tcq at 50030400 {
+					compatible = "fsl,imx25-tcq";
+					reg = <0x50030400 0x60>;
+					interrupt-parent = <&tscadc>;
+					interrupts = <0>;
+					fsl,wires = <4>;
+					status = "disabled";
+				};
 			};
 
 			ssi1: ssi at 50034000 {
-- 
1.7.9.5
