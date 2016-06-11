From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 11 Jun 2016 08:02:19 +0300
Subject: [PATCH 1/7] ARM: dts: imx25-pdk: Switch using simple-audio-card for
 audio support
Message-ID: <1465621345-12597-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sound support can be handled by "simple-audio-card" instead of
use a private driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx25-pdk.dts | 51 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index 9351296..8fe2f5a 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -12,6 +12,8 @@
 /dts-v1/;
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/fsl-imx-audmux.h>
+
 #include "imx25.dtsi"
 
 / {
@@ -64,17 +66,29 @@
 	};
 
 	sound {
-		compatible = "fsl,imx25-pdk-sgtl5000",
-			     "fsl,imx-audio-sgtl5000";
-		model = "imx25-pdk-sgtl5000";
-		ssi-controller = <&ssi1>;
-		audio-codec = <&codec>;
-		audio-routing =
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "imx25-pdk-sgtl5000";
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
-		mux-int-port = <1>;
-		mux-ext-port = <4>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&ssi1>;
+		};
+
+		master: simple-audio-card,codec {
+			sound-dai = <&codec>;
+		};
 	};
 
 	wvga: display {
@@ -103,6 +117,26 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_audmux>;
 	status = "okay";
+
+	audmux_ssi0 {
+		fsl,audmux-port = <0>;
+		fsl,port-config = <
+			(IMX_AUDMUX_V2_PTCR_TFSDIR |
+			IMX_AUDMUX_V2_PTCR_TFSEL(3) |
+			IMX_AUDMUX_V2_PTCR_TCLKDIR |
+			IMX_AUDMUX_V2_PTCR_TCSEL(3) |
+			IMX_AUDMUX_V2_PTCR_SYN)
+			IMX_AUDMUX_V2_PDCR_RXDSEL(3)
+		>;
+	};
+
+	audmux_aud4 {
+		fsl,audmux-port = <3>;
+		fsl,port-config = <
+			IMX_AUDMUX_V2_PTCR_SYN
+			IMX_AUDMUX_V2_PDCR_RXDSEL(0)
+		>;
+	};
 };
 
 &can1 {
@@ -136,6 +170,7 @@
 	status = "okay";
 
 	codec: sgtl5000 at 0a {
+		#sound-dai-cells = <0>;
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
 		clocks = <&clks 129>;
-- 
2.4.9
