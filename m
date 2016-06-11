From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 11 Jun 2016 08:02:21 +0300
Subject: [PATCH 3/7] ARM: dts: imx53-m53evk: Switch using simple-audio-card
 for audio support
In-Reply-To: <1465621345-12597-1-git-send-email-shc_work@mail.ru>
References: <1465621345-12597-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465621345-12597-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sound support can be handled by "simple-audio-card" instead of
use a private driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx53-m53evk.dts | 52 +++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index dcee1e0f..d04f7d7 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -10,6 +10,8 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/sound/fsl-imx-audmux.h>
+
 #include "imx53-m53.dtsi"
 
 / {
@@ -96,26 +98,57 @@
 	};
 
 	sound {
-		compatible = "fsl,imx53-m53evk-sgtl5000",
-			     "fsl,imx-audio-sgtl5000";
-		model = "imx53-m53evk-sgtl5000";
-		ssi-controller = <&ssi2>;
-		audio-codec = <&sgtl5000>;
-		audio-routing =
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "imx53-m53evk-sgtl5000";
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
 			"LINE_IN", "Line In Jack",
 			"Headphone Jack", "HP_OUT",
 			"Ext Spk", "LINE_OUT";
-		mux-int-port = <2>;
-		mux-ext-port = <4>;
-	};
+
+		simple-audio-card,cpu {
+			sound-dai = <&ssi2>;
+		};
+
+		master: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+		};
 };
 
 &audmux {
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
 
 &can1 {
@@ -151,6 +184,7 @@
 	status = "okay";
 
 	sgtl5000: codec at 0a {
+		#sound-dai-cells = <0>;
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
 		VDDA-supply = <&reg_3p2v>;
-- 
2.4.9
