From: jagan@openedev.com (Jagan Teki)
Date: Wed, 22 Mar 2017 23:18:13 +0530
Subject: [PATCH 08/12] ARM: dts: imx6ul-geam: Add Sound card with codec node
In-Reply-To: <1490204897-14525-1-git-send-email-jagan@openedev.com>
References: <1490204897-14525-1-git-send-email-jagan@openedev.com>
Message-ID: <1490204897-14525-9-git-send-email-jagan@openedev.com>
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
 arch/arm/boot/dts/imx6ul-geam-kit.dts | 13 +++++++++++++
 arch/arm/boot/dts/imx6ul-geam.dtsi    | 12 ++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-geam-kit.dts b/arch/arm/boot/dts/imx6ul-geam-kit.dts
index 142e60c..93c9586 100644
--- a/arch/arm/boot/dts/imx6ul-geam-kit.dts
+++ b/arch/arm/boot/dts/imx6ul-geam-kit.dts
@@ -58,6 +58,19 @@
 	status = "okay";
 };
 
+&i2c1 {
+	codec: sgtl5000 at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks IMX6UL_CLK_OSC>;
+		clock-names = "mclk";
+		wlf,shared-lrclk;
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
index eb94d95..c405e55 100644
--- a/arch/arm/boot/dts/imx6ul-geam.dtsi
+++ b/arch/arm/boot/dts/imx6ul-geam.dtsi
@@ -87,6 +87,18 @@
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	sound {
+		compatible = "fsl,imx-audio-sgtl5000";
+		model = "imx6q-geam-sgtl5000";
+		cpu-dai = <&sai2>;
+		audio-codec = <&codec>;
+		gpr = <&gpr>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+	};
 };
 
 &can1 {
-- 
1.9.1
