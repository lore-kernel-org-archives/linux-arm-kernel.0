From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 11 Sep 2017 14:42:21 +0530
Subject: [PATCH v4 2/6] ARM: dts: imx6qdl-icore-rqs: Move Sound nodes to dtsi
In-Reply-To: <1505121145-9507-1-git-send-email-jteki@openedev.com>
References: <1505121145-9507-1-git-send-email-jteki@openedev.com>
Message-ID: <1505121145-9507-2-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

imx6q, imx6dl icore-rqs modules share common sound nodes,
so move the sound nodes from imx6q-icore-rqs into dtsi so-that
both can share the common node details.

And also replace codec: sgtl5000 at 0a => sgtl5000: codec at a
on imx6q-icore-rqs.dts to [label:] node-name[@unit-address]
according to devicetree specification from ePAPER v1.1

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
- New patch

 arch/arm/boot/dts/imx6q-icore-rqs.dts    | 24 ------------------------
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-icore-rqs.dts b/arch/arm/boot/dts/imx6q-icore-rqs.dts
index e451b4c..b81f48c 100644
--- a/arch/arm/boot/dts/imx6q-icore-rqs.dts
+++ b/arch/arm/boot/dts/imx6q-icore-rqs.dts
@@ -47,30 +47,6 @@
 / {
 	model = "Engicam i.CoreM6 Quad/Dual RQS Starter Kit";
 	compatible = "engicam,imx6-icore-rqs", "fsl,imx6q";
-
-	sound {
-		compatible = "fsl,imx-audio-sgtl5000";
-		model = "imx-audio-sgtl5000";
-		ssi-controller = <&ssi1>;
-		audio-codec = <&codec>;
-		audio-routing =
-			"MIC_IN", "Mic Jack",
-			"Mic Jack", "Mic Bias",
-			"Headphone Jack", "HP_OUT";
-		mux-int-port = <1>;
-		mux-ext-port = <4>;
-	};
-};
-
-&i2c3 {
-	codec: sgtl5000 at 0a {
-		compatible = "fsl,sgtl5000";
-		reg = <0x0a>;
-		clocks = <&clks IMX6QDL_CLK_CKO>;
-		VDDA-supply = <&reg_2p5v>;
-		VDDIO-supply = <&reg_3p3v>;
-		VDDD-supply = <&reg_1p8v>;
-	};
 };
 
 &sata {
diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
index 7ca291e..e196d1b 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -118,6 +118,19 @@
 		clocks = <&clks IMX6QDL_CLK_LVDS2_GATE>;
 		clock-names = "refclk";
 	};
+
+	sound {
+		compatible = "fsl,imx-audio-sgtl5000";
+		model = "imx-audio-sgtl5000";
+		ssi-controller = <&ssi1>;
+		audio-codec = <&sgtl5000>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+		mux-int-port = <1>;
+		mux-ext-port = <4>;
+	};
 };
 
 &clks {
@@ -174,6 +187,15 @@
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
 
 &pcie {
-- 
2.7.4
