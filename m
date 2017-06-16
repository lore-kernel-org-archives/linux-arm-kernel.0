From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Fri, 16 Jun 2017 12:34:40 +0530
Subject: [PATCH v4 4/4] ARM: dts: imx6ul-geam: Add Sound card with codec node
In-Reply-To: <1497596680-3186-1-git-send-email-jteki@openedev.com>
References: <1497596680-3186-1-git-send-email-jteki@openedev.com>
Message-ID: <1497596680-3186-4-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Add support for Sound card and related codec(via i2c1) nodes
on Engicam GEAM6UL variant module boards.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
- keep sound and related i2c1 on dts
Changes for v3:
- Replace fsl,imx-audio-sgtl5000 and use simple-audio-card
Changes for v2:
- Use proper [label:] node-name[@unit-address] for codec
- Remove incorrect codec property 'wlf,shared-lrclk'
- Remove 'gpr' from sound card node

 arch/arm/boot/dts/imx6ul-geam.dts | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-geam.dts b/arch/arm/boot/dts/imx6ul-geam.dts
index e251ad2..571eea7 100644
--- a/arch/arm/boot/dts/imx6ul-geam.dts
+++ b/arch/arm/boot/dts/imx6ul-geam.dts
@@ -92,6 +92,32 @@
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "imx6ul-geam-sgtl5000";
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
 
 &can1 {
@@ -151,6 +177,16 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
+
+	sgtl5000: codec at a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks IMX6UL_CLK_OSC>;
+		clock-names = "mclk";
+		VDDA-supply = <&reg_3p3v>;
+		VDDIO-supply = <&reg_3p3v>;
+		VDDD-supply = <&reg_1p8v>;
+	};
 };
 
 &i2c2 {
-- 
2.7.4
