From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 18 Sep 2017 16:58:29 +0530
Subject: [PATCH v5 1/5] ARM: dts: imx6qdl-icore: Add Sound card support
Message-ID: <1505734113-9708-1-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Linux Sound card now uses generic simple-audio-card, so add
the same along with related audmux and codec(via u2c3) for
i.CoreM6 QDL module boards.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v5:
- Add adumux
- Update simple-audio-card,widgets
- Add ssi1 fsl,mode
- Add #sound-dai-cells in codec
Changes for v4:
- Moved sgtl5000 node into dtsi instead of multiple copies of
  same in dts files
Changes for v3:
- Replace fsl,imx-audio-sgtl5000 and use simple-audio-card
Changes for v2:
- Use proper [label:] node-name[@unit-address] for codec

 arch/arm/boot/dts/imx6qdl-icore.dtsi | 97 ++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index 56d0c5d..9682ae2 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -42,6 +42,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
 	memory {
@@ -55,6 +56,25 @@
 		default-brightness-level = <7>;
 	};
 
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+
+	reg_2p5v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "2P5V";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	reg_3p3v: regulator-3p3v {
 		compatible = "regulator-fixed";
 		regulator-name = "3P3V";
@@ -87,6 +107,59 @@
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;  /* 25MHz for example */
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "imx6qdl-icore-sgtl5000";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,widgets =
+			"Microphone", "Mic Jack",
+			"Headphone", "Headphone Jack",
+			"Line", "Line In Jack",
+			"Speaker", "Line Out Jack",
+			"Speaker", "Ext Spk";
+		simple-audio-card,routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+
+		simple-audio-card,cpu {
+			sound-dai = <&ssi1>;
+		};
+
+		dailink_master: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+		};
+	};
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux>;
+	status = "okay";
+
+
+	audmux_ssi1 {
+		fsl,audmux-port = <MX51_AUDMUX_PORT1_SSI0>;
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
+			IMX_AUDMUX_V2_PDCR_RXDSEL(MX51_AUDMUX_PORT1_SSI0)
+		>;
+	};
 };
 
 &can1 {
@@ -141,6 +214,16 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
+
+	sgtl5000: codec at a {
+		#sound-dai-cells = <0>;
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_3p3v>;
+		VDDD-supply = <&reg_1p8v>;
+	};
 };
 
 &pwm3 {
@@ -149,6 +232,11 @@
 	status = "okay";
 };
 
+&ssi1 {
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4>;
@@ -178,6 +266,15 @@
 };
 
 &iomuxc {
+	pinctrl_audmux: audmux {
+		fsl,pins = <
+			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
+			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD 0x110b0
+			MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS  0x130b0
+			MX6QDL_PAD_DISP0_DAT23__AUD4_RXD  0x130b0
+		>;
+	};
+
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
 			MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN	0x1b0b0
-- 
2.7.4
