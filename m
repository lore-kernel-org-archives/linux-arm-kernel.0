From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  2 May 2016 20:56:26 -0300
Subject: [PATCH] ARM: dts: imx6ul-14x14-evk: Add audio support
Message-ID: <1462233386-23185-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx6ul-14x14-evk has a wm8960 codec connected via SAI2 port.

Add support for it.

Thanks to Petr Kulhavy <brain@jikos.cz> for the hint on initializing
the PLL4 frequency to get a correct MCLK.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Shawn,

In order to get audio functional it is still needed to get bit 20
of GPR1 register.

This is a separate patch though and I will discuss it on another thread.

 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 75 ++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index 7207280..8b4776a 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -36,6 +36,45 @@
 			enable-active-high;
 		};
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "mx6ul-wm8960";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,widgets =
+			"Microphone", "Mic Jack",
+			"Line", "Line In",
+			"Line", "Line Out",
+			"Speaker", "Speaker",
+			"Headphone", "Headphone Jack";
+		simple-audio-card,routing =
+			"Headphone Jack", "HP_L",
+			"Headphone Jack", "HP_R",
+			"Speaker", "SPK_LP",
+			"Speaker", "SPK_LN",
+			"Speaker", "SPK_RP",
+			"Speaker", "SPK_RN",
+			"LINPUT1", "Mic Jack",
+			"LINPUT3", "Mic Jack",
+			"RINPUT1", "Mic Jack",
+			"RINPUT2", "Mic Jack";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+		};
+
+		dailink_master: simple-audio-card,codec {
+			sound-dai = <&codec>;
+			clocks = <&clks IMX6UL_CLK_SAI2>;
+		};
+	};
+};
+
+&clks {
+	assigned-clocks = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
+	assigned-clock-rates = <786432000>;
 };
 
 &cpu0 {
@@ -43,6 +82,20 @@
 	soc-supply = <&reg_soc>;
 };
 
+&i2c2 {
+	clock_frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	codec: wm8960 at 1a {
+		#sound-dai-cells = <0>;
+		compatible = "wlf,wm8960";
+		reg = <0x1a>;
+		wlf,shared-lrclk;
+	};
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet1>;
@@ -86,6 +139,17 @@
 	};
 };
 
+&sai2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+
+	assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
+			  <&clks IMX6UL_CLK_SAI2>;
+	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
+	assigned-clock-rates = <0>, <12288000>;
+	status = "okay";
+};
+
 &snvs_poweroff {
 	status = "okay";
 };
@@ -272,6 +336,17 @@
 		>;
 	};
 
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK	0x17088
+			MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC	0x17088
+			MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x11088
+			MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA	0x11088
+			MX6UL_PAD_JTAG_TMS__SAI2_MCLK		0x17088
+			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x17059
+		>;
+	};
+
 	pinctrl_pwm1: pwm1grp {
 		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO08__PWM1_OUT   0x110b0
-- 
1.9.1
