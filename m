From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 11 Jun 2016 08:02:24 +0300
Subject: [PATCH 6/7] ARM: dts: imx53-tx53: Switch using simple-audio-card for
 audio support
In-Reply-To: <1465621345-12597-1-git-send-email-shc_work@mail.ru>
References: <1465621345-12597-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465621345-12597-6-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sound support can be handled by "simple-audio-card" instead of
use a private driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx53-tx53-x03x.dts |  1 +
 arch/arm/boot/dts/imx53-tx53-x13x.dts |  1 +
 arch/arm/boot/dts/imx53-tx53.dtsi     | 57 ++++++++++++++++++++++++++---------
 3 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
index 0ecb43d..b3e742a 100644
--- a/arch/arm/boot/dts/imx53-tx53-x03x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
@@ -204,6 +204,7 @@
 	status = "okay";
 
 	sgtl5000: codec at 0a {
+		#sound-dai-cells = <0>;
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
 		VDDA-supply = <&reg_2v5>;
diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
index 3cf682a..90c0611 100644
--- a/arch/arm/boot/dts/imx53-tx53-x13x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
@@ -111,6 +111,7 @@
 	status = "okay";
 
 	sgtl5000: codec at 0a {
+		#sound-dai-cells = <0>;
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
 		VDDA-supply = <&reg_2v5>;
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index bd3dfef..97e630b 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -12,8 +12,10 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include "imx53.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/sound/fsl-imx-audmux.h>
+
+#include "imx53.dtsi"
 
 / {
 	model = "Ka-Ro electronics TX53 module";
@@ -124,17 +126,29 @@
 	};
 
 	sound {
-		compatible = "karo,tx53-audio-sgtl5000", "fsl,imx-audio-sgtl5000";
-		model = "tx53-audio-sgtl5000";
-		ssi-controller = <&ssi1>;
-		audio-codec = <&sgtl5000>;
-		audio-routing =
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "tx53-audio-sgtl5000";
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
-		/* '1' based port numbers according to datasheet names */
-		mux-int-port = <1>;
-		mux-ext-port = <5>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&ssi1>;
+		};
+
+		master: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+		};
 	};
 };
 
@@ -142,6 +156,26 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ssi1>;
 	status = "okay";
+
+	audmux_ssi0 {
+		fsl,audmux-port = <MX51_AUDMUX_PORT2_SSI0>;
+		fsl,port-config = <
+			(IMX_AUDMUX_V2_PTCR_TFSDIR |
+			IMX_AUDMUX_V2_PTCR_TFSEL(MX51_AUDMUX_PORT4) |
+			IMX_AUDMUX_V2_PTCR_TCLKDIR |
+			IMX_AUDMUX_V2_PTCR_TCSEL(MX51_AUDMUX_PORT4) |
+			IMX_AUDMUX_V2_PTCR_SYN)
+			IMX_AUDMUX_V2_PDCR_RXDSEL(MX51_AUDMUX_PORT4)
+		>;
+	};
+
+	audmux_aud4 {
+		fsl,audmux-port = <MX51_AUDMUX_PORT4>;
+		fsl,port-config = <
+			IMX_AUDMUX_V2_PTCR_SYN
+			IMX_AUDMUX_V2_PDCR_RXDSEL(MX51_AUDMUX_PORT2_SSI0)
+		>;
+	};
 };
 
 &can1 {
@@ -502,14 +536,9 @@
 };
 
 &ssi1 {
-	codec-handle = <&sgtl5000>;
 	status = "okay";
 };
 
-&ssi2 {
-	status = "disabled";
-};
-
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-- 
2.4.9
