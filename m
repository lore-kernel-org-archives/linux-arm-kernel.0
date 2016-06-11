From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 11 Jun 2016 08:02:20 +0300
Subject: [PATCH 2/7] ARM: dts: imx51-babbage: Switch using simple-audio-card
 for audio support
In-Reply-To: <1465621345-12597-1-git-send-email-shc_work@mail.ru>
References: <1465621345-12597-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465621345-12597-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sound support can be handled by "simple-audio-card" instead of
use a private driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-babbage.dts | 51 +++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 018d24e..54c38ce 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -11,6 +11,8 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/sound/fsl-imx-audmux.h>
+
 #include "imx51.dtsi"
 
 / {
@@ -141,17 +143,29 @@
 	};
 
 	sound {
-		compatible = "fsl,imx51-babbage-sgtl5000",
-			     "fsl,imx-audio-sgtl5000";
-		model = "imx51-babbage-sgtl5000";
-		ssi-controller = <&ssi2>;
-		audio-codec = <&sgtl5000>;
-		audio-routing =
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "imx51-babbage-sgtl5000";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&master>;
+		simple-audio-card,frame-master = <&master>;
+		simple-audio-card,widgets =
+			"Microphone", "Mic Jack",
+			"Line", "Line In Jack",
+			"Headphone", "Headphone Jack",
+			"Speaker", "Line Out Jack",
+			"Speaker", "Ext Spk";
+		simple-audio-card,routing =
 			"MIC_IN", "Mic Jack",
 			"Mic Jack", "Mic Bias",
 			"Headphone Jack", "HP_OUT";
-		mux-int-port = <2>;
-		mux-ext-port = <3>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&ssi2>;
+		};
+
+		master: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+		};
 	};
 
 	usbphy {
@@ -173,6 +187,26 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_audmux>;
 	status = "okay";
+
+	audmux_ssi1 {
+		fsl,audmux-port = <MX51_AUDMUX_PORT2_SSI1>;
+		fsl,port-config = <
+			(IMX_AUDMUX_V2_PTCR_TFSDIR |
+			IMX_AUDMUX_V2_PTCR_TFSEL(MX51_AUDMUX_PORT3) |
+			IMX_AUDMUX_V2_PTCR_TCLKDIR |
+			IMX_AUDMUX_V2_PTCR_TCSEL(MX51_AUDMUX_PORT3) |
+			IMX_AUDMUX_V2_PTCR_SYN)
+			IMX_AUDMUX_V2_PDCR_RXDSEL(MX51_AUDMUX_PORT3)
+		>;
+	};
+
+	audmux_aud3 {
+		fsl,audmux-port = <MX51_AUDMUX_PORT3>;
+		fsl,port-config = <
+			IMX_AUDMUX_V2_PTCR_SYN
+			IMX_AUDMUX_V2_PDCR_RXDSEL(MX51_AUDMUX_PORT2_SSI1)
+		>;
+	};
 };
 
 &ecspi1 {
@@ -339,6 +373,7 @@
 	status = "okay";
 
 	sgtl5000: codec at 0a {
+		#sound-dai-cells = <0>;
 		compatible = "fsl,sgtl5000";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_clkcodec>;
-- 
2.4.9
