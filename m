From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 17 Oct 2017 11:17:58 +0200
Subject: [PATCHv3 07/12] ARM: dts: imx6-tx6: convert to using simple-audio-card
In-Reply-To: <1508231883-12067-1-git-send-email-LW@KARO-electronics.de>
References: <1508230414-8090-1-git-send-email-LW@KARO-electronics.de>
 <1508231883-12067-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1508231883-12067-8-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the DTS sound setup to use the simple-audio-card driver.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6qdl-tx6.dtsi | 50 ++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index f1655b3..eb5accd 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -43,6 +43,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
 	aliases {
@@ -183,24 +184,56 @@
 	};
 
 	sound {
-		compatible = "karo,imx6qdl-tx6qdl-sgtl5000",
-			     "fsl,imx-audio-sgtl5000";
-		model = "sgtl5000-audio";
+		compatible = "karo,imx6qdl-tx6-sgtl5000",
+			     "simple-audio-card";
+		simple-audio-card,name = "imx6qdl-tx6-sgtl5000-audio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_audmux>;
-		ssi-controller = <&ssi1>;
-		audio-codec = <&sgtl5000>;
-		audio-routing =
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&codec_dai>;
+		simple-audio-card,frame-master = <&codec_dai>;
+		simple-audio-card,widgets =
+			"Microphone", "Mic Jack",
+			"Line", "Line In",
+			"Line", "Line Out",
+			"Headphone", "Headphone Jack";
+		simple-audio-card,routing =
 			"MIC_IN", "Mic Jack",
 			"Mic Jack", "Mic Bias",
 			"Headphone Jack", "HP_OUT";
-		mux-int-port = <1>;
-		mux-ext-port = <5>;
+
+		cpu_dai: simple-audio-card,cpu {
+			sound-dai = <&ssi1>;
+		};
+
+		codec_dai: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+		};
 	};
 };
 
 &audmux {
 	status = "okay";
+
+	ssi1 {
+		fsl,audmux-port = <0>;
+		fsl,port-config = <
+			(IMX_AUDMUX_V2_PTCR_SYN |
+			IMX_AUDMUX_V2_PTCR_TFSEL(4) |
+			IMX_AUDMUX_V2_PTCR_TCSEL(4) |
+			IMX_AUDMUX_V2_PTCR_TFSDIR |
+			IMX_AUDMUX_V2_PTCR_TCLKDIR)
+			IMX_AUDMUX_V2_PDCR_RXDSEL(4)
+		>;
+	};
+
+	pins5 {
+		fsl,audmux-port = <4>;
+		fsl,port-config = <
+			IMX_AUDMUX_V2_PTCR_SYN
+			IMX_AUDMUX_V2_PDCR_RXDSEL(0)
+		>;
+	};
 };
 
 &can1 {
@@ -299,6 +332,7 @@
 
 	sgtl5000: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
+		#sound-dai-cells = <0>;
 		reg = <0x0a>;
 		VDDA-supply = <&reg_2v5>;
 		VDDIO-supply = <&reg_3v3>;
-- 
2.1.4
