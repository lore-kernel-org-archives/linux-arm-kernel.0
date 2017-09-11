From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 11 Sep 2017 14:42:20 +0530
Subject: [PATCH v4 1/6] ARM: dts: imx6qdl-icore: Add Sound card with codec node
Message-ID: <1505121145-9507-1-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Add support for Sound card and related codec(via i2c3) nodes
to i.CoreM6 QDL module boards.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
- Moved sgtl5000 node into dtsi instead of multiple copies of
  same in dts files
Changes for v3:
- Replace fsl,imx-audio-sgtl5000 and use simple-audio-card
Changes for v2:
- Use proper [label:] node-name[@unit-address] for codec

 arch/arm/boot/dts/imx6qdl-icore.dtsi | 57 ++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index 56d0c5d..5cdb93a 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -55,6 +55,25 @@
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
@@ -87,6 +106,31 @@
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
+			"Line", "Line In",
+			"Line", "Line Out",
+			"Headphone", "Headphone Jack";
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
 };
 
 &can1 {
@@ -141,6 +185,15 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
+
+	sgtl5000: codec at a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_3p3v>;
+		VDDD-supply = <&reg_1p8v>;
+	};
 };
 
 &pwm3 {
@@ -149,6 +202,10 @@
 	status = "okay";
 };
 
+&ssi1 {
+	status = "okay";
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4>;
-- 
2.7.4
