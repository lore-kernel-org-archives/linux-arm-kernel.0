From: jagan@openedev.com (Jagan Teki)
Date: Fri, 24 Mar 2017 21:48:43 +0530
Subject: [PATCH v2 08/15] ARM: dts: imx6ul-geam: Add Sound card with codec node
In-Reply-To: <1490372330-5611-1-git-send-email-jagan@openedev.com>
References: <1490372330-5611-1-git-send-email-jagan@openedev.com>
Message-ID: <1490372330-5611-9-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Add support for Sound card and related codec(via i2c1) nodes
on Engicam GEAM6UL variant module boards.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Use proper [label:] node-name[@unit-address] for codec
- Remove incorrect codec property 'wlf,shared-lrclk'
- Remove 'gpr' from sound card node

 arch/arm/boot/dts/imx6ul-geam-kit.dts | 12 ++++++++++++
 arch/arm/boot/dts/imx6ul-geam.dtsi    | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-geam-kit.dts b/arch/arm/boot/dts/imx6ul-geam-kit.dts
index 142e60c..02edcba 100644
--- a/arch/arm/boot/dts/imx6ul-geam-kit.dts
+++ b/arch/arm/boot/dts/imx6ul-geam-kit.dts
@@ -58,6 +58,18 @@
 	status = "okay";
 };
 
+&i2c1 {
+	sgtl5000: codec at a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks IMX6UL_CLK_OSC>;
+		clock-names = "mclk";
+		VDDA-supply = <&reg_3p3v>;
+		VDDIO-supply = <&reg_3p3v>;
+		VDDD-supply = <&reg_1p8v>;
+	};
+};
+
 &lcdif {
 	display = <&display0>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6ul-geam.dtsi b/arch/arm/boot/dts/imx6ul-geam.dtsi
index eb94d95..1ffca2b 100644
--- a/arch/arm/boot/dts/imx6ul-geam.dtsi
+++ b/arch/arm/boot/dts/imx6ul-geam.dtsi
@@ -87,6 +87,17 @@
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	sound {
+		compatible = "fsl,imx-audio-sgtl5000";
+		model = "imx6q-geam-sgtl5000";
+		cpu-dai = <&sai2>;
+		audio-codec = <&sgtl5000>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+	};
 };
 
 &can1 {
-- 
1.9.1
