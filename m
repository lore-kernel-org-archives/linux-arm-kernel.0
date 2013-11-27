From: denis@eukrea.com (Denis Carikli)
Date: Wed, 27 Nov 2013 16:54:24 +0100
Subject: [PATCHv8][ 5/5] ARM: dts: mbimxsd53: Add sound support.
In-Reply-To: <1385567664-758-1-git-send-email-denis@eukrea.com>
References: <1385567664-758-1-git-send-email-denis@eukrea.com>
Message-ID: <1385567664-758-5-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel at alsa-project.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v7->v8:
- New patch.
---
 .../boot/dts/imx53-eukrea-mbimxsd53-baseboard.dts  |   43 ++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard.dts b/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard.dts
index 95929aa..b14cc3d 100644
--- a/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard.dts
+++ b/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard.dts
@@ -51,8 +51,21 @@
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
+
+	sound {
+		compatible = "eukrea,asoc-tlv320";
+		eukrea,model = "imx53-eukrea-tlv320aic23";
+		ssi-controller = <&ssi2>;
+		fsl,mux-int-port = <2>;
+		fsl,mux-ext-port = <4>;
+	};
 };
 
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux>;
+	status = "okay";
+};
 
 &esdhc1 {
 	pinctrl-names = "default";
@@ -63,8 +76,28 @@
 	status = "okay";
 };
 
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	tlv320aic23: codec at 1a {
+		compatible = "ti,tlv320aic23";
+		clocks = <&clks IMX5_CLK_SSI_EXT1_GATE>;
+		reg = <0x1a>;
+	};
+};
+
 &iomuxc {
 	imx53-eukrea {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <MX53_PAD_PATA_DA_0__GPIO7_6 0x80000000>;
+		};
+
+		pinctrl_audmux: audmuxgrp {
+			fsl,pins = <MX53_AUDMUX_PINGRP2>;
+		};
+
 		pinctrl_esdhc1: esdhc1 {
 			fsl,pins = <MX53_ESDHC1_PINGRP1>;
 		};
@@ -81,6 +114,10 @@
 			fsl,pins = <MX53_PAD_KEY_ROW4__GPIO4_15 0x80000000>;
 		};
 
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <MX53_I2C2_PINGRP1>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <MX53_UART1_PINGRP2>;
 		};
@@ -91,6 +128,12 @@
 	};
 };
 
+&ssi2 {
+	codec-handle = <&tlv320aic23>;
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-- 
1.7.9.5
