From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Wed, 10 Sep 2014 22:54:55 +0200
Subject: [PATCH v2 1/2] ARM: tegra: apalis/colibri t30: integrate audio support
In-Reply-To: <cover.1410362950.git.marcel@ziswiler.com>
References: <cover.1410362950.git.marcel@ziswiler.com>
Message-ID: <00f249b3d648d3a8d550c5db0737f3aa6d93f07e.1410362950.git.marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Integrate Freescale SGTL5000 analogue audio codec support.

Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
Changes in v2:
- Using simple-audio-card as suggested by Fabio.

 arch/arm/boot/dts/tegra30-apalis.dtsi  | 65 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra30-colibri.dtsi | 65 ++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index a5446cb..fa3bc92 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -47,6 +47,24 @@
 		pinctrl-0 = <&state_default>;
 
 		state_default: pinmux {
+			/* Apalis Analogue Audio */
+			clk1_out_pw4 {
+				nvidia,pins = "clk1_out_pw4";
+				nvidia,function = "extperiph1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			dap3_fs_pp0 {
+				nvidia,pins =	"dap3_fs_pp0",
+						"dap3_sclk_pp3",
+						"dap3_din_pp1",
+						"dap3_dout_pp2";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
 			/* Apalis BKL1_ON */
 			pv2 {
 				nvidia,pins = "pv2";
@@ -404,6 +422,16 @@
 		status = "okay";
 		clock-frequency = <100000>;
 
+		/* SGTL5000 audio codec */
+		sgtl5000: codec at 0a {
+			#sound-dai-cells = <0>;
+			compatible = "fsl,sgtl5000";
+			reg = <0x0a>;
+			VDDA-supply = <&sys_3v3_reg>;
+			VDDIO-supply = <&sys_3v3_reg>;
+			clocks = <&tegra_car TEGRA30_CLK_EXTERN1>;
+		};
+
 		pmic: tps65911 at 2d {
 			compatible = "ti,tps65911";
 			reg = <0x2d>;
@@ -635,6 +663,13 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
+	ahub at 70080000 {
+		i2s at 70080500 {
+			#sound-dai-cells = <0>;
+			status = "okay";
+		};
+	};
+
 	sdhci at 78000600 {
 		status = "okay";
 		bus-width = <8>;
@@ -684,4 +719,34 @@
 			regulator-always-on;
 		};
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Toradex Apalis T30";
+		simple-audio-card,routing =
+			"Headphone Jack", "HP_OUT",
+			"LINE_IN", "Line In Jack",
+			"MIC_IN", "Microphone Jack";
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack",
+			"Line In", "Line In Jack",
+			"Microphone", "Microphone Jack";
+
+		simple-audio-card,codec {
+			bitclock-master;
+			clocks = <&tegra_car TEGRA30_CLK_EXTERN1>;
+			frame-master;
+			sound-dai = <&sgtl5000>;
+		};
+
+		simple-audio-card,cpu {
+			bitclock-master;
+			clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
+				 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>;
+			frame-master;
+			master-clkdir-out;
+			sound-dai = <&tegra_i2s2>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index c4ed1be..1f97348 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -29,6 +29,24 @@
 		pinctrl-0 = <&state_default>;
 
 		state_default: pinmux {
+			/* Colibri Analogue Audio */
+			clk1_out_pw4 {
+				nvidia,pins = "clk1_out_pw4";
+				nvidia,function = "extperiph1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			dap3_fs_pp0 {
+				nvidia,pins =	"dap3_fs_pp0",
+						"dap3_sclk_pp3",
+						"dap3_din_pp1",
+						"dap3_dout_pp2";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
 			/* Colibri BL_ON */
 			pv2 {
 				nvidia,pins = "pv2";
@@ -182,6 +200,16 @@
 		status = "okay";
 		clock-frequency = <100000>;
 
+		/* SGTL5000 audio codec */
+		sgtl5000: codec at 0a {
+			#sound-dai-cells = <0>;
+			compatible = "fsl,sgtl5000";
+			reg = <0x0a>;
+			VDDA-supply = <&sys_3v3_reg>;
+			VDDIO-supply = <&sys_3v3_reg>;
+			clocks = <&tegra_car TEGRA30_CLK_EXTERN1>;
+		};
+
 		pmic: tps65911 at 2d {
 			compatible = "ti,tps65911";
 			reg = <0x2d>;
@@ -331,6 +359,13 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
+	ahub at 70080000 {
+		i2s at 70080500 {
+			#sound-dai-cells = <0>;
+			status = "okay";
+		};
+	};
+
 	emmc: sdhci at 78000600 {
 		status = "okay";
 		bus-width = <8>;
@@ -383,4 +418,34 @@
 			regulator-always-on;
 		};
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Toradex Colibri T30";
+		simple-audio-card,routing =
+			"Headphone Jack", "HP_OUT",
+			"LINE_IN", "Line In Jack",
+			"MIC_IN", "Microphone Jack";
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack",
+			"Line In", "Line In Jack",
+			"Microphone", "Microphone Jack";
+
+		simple-audio-card,codec {
+			bitclock-master;
+			clocks = <&tegra_car TEGRA30_CLK_EXTERN1>;
+			frame-master;
+			sound-dai = <&sgtl5000>;
+		};
+
+		simple-audio-card,cpu {
+			bitclock-master;
+			clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
+				 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>;
+			frame-master;
+			master-clkdir-out;
+			sound-dai = <&tegra_i2s2>;
+		};
+	};
 };
-- 
1.9.3
