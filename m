From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Thu, 15 Jun 2017 17:33:38 +0530
Subject: [PATCH v4 2/3] ARM: dts: imx6ul-isiot: Add Sound card with codec node
In-Reply-To: <1497528219-20396-1-git-send-email-jteki@openedev.com>
References: <1497528219-20396-1-git-send-email-jteki@openedev.com>
Message-ID: <1497528219-20396-2-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Add support for Sound card and related codec(via i2c1) nodes
on Engicam Is.IoT MX6UL variant module boards.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
- Move i2c1 into imx6ul-isiot.dtsi
Changes for v3:
- Replace fsl,imx-audio-sgtl5000 and use simple-audio-card
Changes for v2:
- Use proper [label:] node-name[@unit-address] for codec
- Remove incorrect codec property 'wlf,shared-lrclk'
- Remove 'gpr' from sound card node

 arch/arm/boot/dts/imx6ul-isiot.dtsi | 54 +++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-isiot.dtsi b/arch/arm/boot/dts/imx6ul-isiot.dtsi
index 3c442f6..e2dacdc 100644
--- a/arch/arm/boot/dts/imx6ul-isiot.dtsi
+++ b/arch/arm/boot/dts/imx6ul-isiot.dtsi
@@ -69,6 +69,50 @@
 				    100>;
 		default-brightness-level = <100>;
 	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "imx6ul-isiot-sgtl5000";
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
+			sound-dai = <&sai2>;
+		};
+
+		dailink_master: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+			clocks = <&clks IMX6UL_CLK_SAI2>;
+		};
+	};
 };
 
 &i2c1 {
@@ -77,6 +121,16 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
+	sgtl5000: codec at a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks IMX6UL_CLK_OSC>;
+		clock-names = "mclk";
+		VDDA-supply = <&reg_3p3v>;
+		VDDIO-supply = <&reg_3p3v>;
+		VDDD-supply = <&reg_1p8v>;
+	};
+
 	stmpe811: gpio-expander at 44 {
 		compatible = "st,stmpe811";
 		reg = <0x44>;
-- 
2.7.4
