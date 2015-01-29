From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 29 Jan 2015 15:09:15 +0100
Subject: [PATCH v6 7/8] ARM: dts: imx25: Add TSC and ADC support
In-Reply-To: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
References: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1422540556-14828-8-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Denis Carikli <denis@eukrea.com>

Signed-off-by: Denis Carikli <denis@eukrea.com>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx25.dtsi | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index e4d3aecc4ed2..4780926fa20e 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -265,13 +265,37 @@
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
2.1.4
