From: stefan@agner.ch (Stefan Agner)
Date: Sun, 28 Aug 2016 22:13:24 -0700
Subject: [PATCH 3/3] ARM: dts: imx7-colibri: add Audio support
In-Reply-To: <20160829051324.2276-1-stefan@agner.ch>
References: <20160829051324.2276-1-stefan@agner.ch>
Message-ID: <20160829051324.2276-3-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add audio support via on module I2S SGTL5000 codec.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7-colibri.dtsi | 41 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 06fb567..a9cc657 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -66,6 +66,22 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "imx7-sgtl5000";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,cpu {
+			sound-dai = <&sai1>;
+		};
+
+		dailink_master: simple-audio-card,codec {
+			sound-dai = <&codec>;
+			clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+		};
+	};
 };
 
 &adc1 {
@@ -103,6 +119,18 @@
 	pinctrl-0 = <&pinctrl_i2c1 &pinctrl_i2c1_int>;
 	status = "okay";
 
+	codec: sgtl5000 at 0a {
+		compatible = "fsl,sgtl5000";
+		#sound-dai-cells = <0>;
+		reg = <0x0a>;
+		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sai1_mclk>;
+		VDDA-supply = <&reg_module_3v3_avdd>;
+		VDDIO-supply = <&reg_module_3v3>;
+		VDDD-supply = <&reg_DCDC3>;
+	};
+
 	ad7879 at 2c {
 		compatible = "adi,ad7879-1";
 		reg = <0x2c>;
@@ -223,6 +251,12 @@
 	vin-supply = <&reg_DCDC3>;
 };
 
+&sai1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	status = "okay";
+};
+
 &snvs_pwrkey {
 	status = "disabled";
 };
@@ -542,13 +576,18 @@
 
 	pinctrl_sai1: sai1-grp {
 		fsl,pins = <
-			MX7D_PAD_SAI1_MCLK__SAI1_MCLK           0x1f
 			MX7D_PAD_ENET1_RX_CLK__SAI1_TX_BCLK     0x1f
 			MX7D_PAD_SAI1_TX_SYNC__SAI1_TX_SYNC	0x1f
 			MX7D_PAD_ENET1_COL__SAI1_TX_DATA0	0x30
 			MX7D_PAD_ENET1_TX_CLK__SAI1_RX_DATA0	0x1f
 		>;
 	};
+
+	pinctrl_sai1_mclk: sai1grp_mclk {
+		fsl,pins = <
+			MX7D_PAD_SAI1_MCLK__SAI1_MCLK           0x1f
+		>;
+	};
 };
 
 &iomuxc_lpsr {
-- 
2.9.0
