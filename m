From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 24 May 2014 10:27:05 +0400
Subject: [PATCH RFT] ARM: dts: imx51-eukrea-mbimxsd51-baseboard: Use
 simple-audio-card for sound
Message-ID: <1400912825-10735-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces usage of special driver for sound with simple-audio-card.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---

I ask Eukrea developers to test this.

---
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  | 39 ++++++++++++++++++----
 arch/arm/boot/dts/imx51.dtsi                       |  4 +++
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
index 75e66c9..03f81cc 100644
--- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
@@ -18,7 +18,6 @@
 
 /dts-v1/;
 #include "imx51-eukrea-cpuimx51.dtsi"
-#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Eukrea CPUIMX51";
@@ -76,11 +75,18 @@
 	};
 
 	sound {
-		compatible = "eukrea,asoc-tlv320";
-		eukrea,model = "imx51-eukrea-tlv320aic23";
-		ssi-controller = <&ssi2>;
-		fsl,mux-int-port = <2>;
-		fsl,mux-ext-port = <3>;
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+
+		simple-audio-card,cpu {
+			sound-dai = <&ssi2>;
+			system-clock-frequency = <0>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&tlv320aic23>;
+			system-clock-frequency = <12000000>;
+		};
 	};
 
 	usbphy {
@@ -102,6 +108,26 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_audmux>;
 	status = "okay";
+
+	ssi1 {
+		fsl,audmux-port = <MX51_AUDMUX_PORT2_SSI1>;
+		fsl,port-config = <
+			(IMX_AUDMUX_V2_PTCR_SYN |
+			IMX_AUDMUX_V2_PTCR_TFSDIR |
+			IMX_AUDMUX_V2_PTCR_TFSEL(MX51_AUDMUX_PORT3) |
+			IMX_AUDMUX_V2_PTCR_TCLKDIR |
+			IMX_AUDMUX_V2_PTCR_TCSEL(MX51_AUDMUX_PORT3))
+			IMX_AUDMUX_V2_PDCR_RXDSEL(MX51_AUDMUX_PORT3)
+		>;
+	};
+
+	port3 {
+		fsl,audmux-port = <MX51_AUDMUX_PORT3>;
+		fsl,port-config = <
+			IMX_AUDMUX_V2_PTCR_SYN
+			IMX_AUDMUX_V2_PDCR_RXDSEL(MX51_AUDMUX_PORT2_SSI1)
+		>;
+	};
 };
 
 &esdhc1 {
@@ -133,6 +159,7 @@
 
 &i2c1 {
 	tlv320aic23: codec at 1a {
+		#sound-dai-cells = <0>;
 		compatible = "ti,tlv320aic23";
 		reg = <0x1a>;
 	};
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index bebbf3b..7cd6d26 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -16,6 +16,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
 	aliases {
@@ -210,6 +211,7 @@
 				};
 
 				ssi2: ssi at 70014000 {
+					#sound-dai-cells = <0>;
 					compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
 					reg = <0x70014000 0x4000>;
 					interrupts = <30>;
@@ -500,6 +502,7 @@
 			};
 
 			ssi1: ssi at 83fcc000 {
+				#sound-dai-cells = <0>;
 				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
 				reg = <0x83fcc000 0x4000>;
 				interrupts = <29>;
@@ -556,6 +559,7 @@
 			};
 
 			ssi3: ssi at 83fe8000 {
+				#sound-dai-cells = <0>;
 				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
 				reg = <0x83fe8000 0x4000>;
 				interrupts = <96>;
-- 
1.8.5.5
