From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 Aug 2016 13:47:32 -0300
Subject: [PATCH 1/3] ARM: dts: imx7s-warp: Add audio support
Message-ID: <1471279654-16711-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

warp7 has a sgtl5000 audio codec.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7s-warp.dts | 51 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index ae23781..b9b45b1 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -53,6 +53,27 @@
 	memory {
 		reg = <0x80000000 0x20000000>;
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
+};
+
+&clks {
+	assigned-clocks = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
+	assigned-clock-rates = <884736000>;
 };
 
 &cpu0 {
@@ -161,12 +182,32 @@
 	pinctrl-0 = <&pinctrl_i2c4>;
 	status = "okay";
 
+	codec: sgtl5000 at 0a {
+		#sound-dai-cells = <0>;
+		reg = <0x0a>;
+		compatible = "fsl,sgtl5000";
+		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+		VDDA-supply = <&vgen4_reg>;
+		VDDIO-supply = <&vgen4_reg>;
+		VDDD-supply = <&vgen2_reg>;
+	};
+
 	mpl3115 at 60 {
 		compatible = "fsl,mpl3115";
 		reg = <0x60>;
 	};
 };
 
+&sai1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	assigned-clocks = <&clks IMX7D_SAI1_ROOT_SRC>,
+			  <&clks IMX7D_SAI1_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
+	assigned-clock-rates = <0>, <36864000>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -208,6 +249,16 @@
 		>;
 	};
 
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			MX7D_PAD_SAI1_RX_DATA__SAI1_RX_DATA0	0x1f
+			MX7D_PAD_SAI1_TX_BCLK__SAI1_TX_BCLK	0x1f
+			MX7D_PAD_SAI1_TX_SYNC__SAI1_TX_SYNC	0x1f
+			MX7D_PAD_SAI1_TX_DATA__SAI1_TX_DATA0	0x30
+			MX7D_PAD_SAI1_MCLK__SAI1_MCLK		0x1f
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-- 
2.7.4
