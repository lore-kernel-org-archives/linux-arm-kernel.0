From: jagan@openedev.com (Jagan Teki)
Date: Fri, 24 Mar 2017 21:48:42 +0530
Subject: [PATCH v2 07/15] ARM: dts: imx6ul-isiot: Add Sound card with codec
 node
In-Reply-To: <1490372330-5611-1-git-send-email-jagan@openedev.com>
References: <1490372330-5611-1-git-send-email-jagan@openedev.com>
Message-ID: <1490372330-5611-8-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Add support for Sound card and related codec(via i2c1) nodes
on Engicam Is.IoT MX6UL variant module boards.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Use proper [label:] node-name[@unit-address] for codec
- Remove incorrect codec property 'wlf,shared-lrclk'
- Remove 'gpr' from sound card node

 arch/arm/boot/dts/imx6ul-isiot-common.dtsi | 10 ++++++++++
 arch/arm/boot/dts/imx6ul-isiot.dtsi        | 29 +++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-isiot-common.dtsi b/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
index 827f0dc..15dcf5f 100644
--- a/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
+++ b/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
@@ -41,6 +41,16 @@
  */
 
 &i2c1 {
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
diff --git a/arch/arm/boot/dts/imx6ul-isiot.dtsi b/arch/arm/boot/dts/imx6ul-isiot.dtsi
index ea30380..9648de9 100644
--- a/arch/arm/boot/dts/imx6ul-isiot.dtsi
+++ b/arch/arm/boot/dts/imx6ul-isiot.dtsi
@@ -69,6 +69,35 @@
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
+		compatible = "fsl,imx-audio-sgtl5000";
+		model = "imx6ul-isiot-sgtl5000";
+		cpu-dai = <&sai2>;
+		audio-codec = <&sgtl5000>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+	};
 };
 
 &i2c1 {
-- 
1.9.1
