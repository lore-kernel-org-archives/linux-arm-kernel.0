From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Sat,  4 Oct 2014 02:15:44 +0200
Subject: [PATCH v3 2/3] ARM: tegra: apalis/colibri t30: integrate audio support
In-Reply-To: <cover.1412381377.git.marcel@ziswiler.com>
References: <cover.1412381377.git.marcel@ziswiler.com>
Message-ID: <1202a8ec8e82b72399a3f8fdc25cbdda88302622.1412381377.git.marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Integrate Freescale SGTL5000 analogue audio codec support.

Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
Changes in v3:
- Revert to not using simple-audio-card being incompatible with tegra.
- Rebased to for-next.

Changes in v2:
- Using simple-audio-card as suggested by Fabio.

 arch/arm/boot/dts/tegra30-apalis.dtsi  | 49 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra30-colibri.dtsi | 49 ++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index a5446cb..9fe3e4d 100644
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
@@ -404,6 +422,15 @@
 		status = "okay";
 		clock-frequency = <100000>;
 
+		/* SGTL5000 audio codec */
+		sgtl5000: codec at 0a {
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
@@ -635,6 +662,12 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
+	ahub at 70080000 {
+		i2s at 70080500 {
+			status = "okay";
+		};
+	};
+
 	sdhci at 78000600 {
 		status = "okay";
 		bus-width = <8>;
@@ -684,4 +717,20 @@
 			regulator-always-on;
 		};
 	};
+
+	sound {
+		compatible = "toradex,tegra-audio-sgtl5000-apalis_t30",
+			     "nvidia,tegra-audio-sgtl5000";
+		nvidia,model = "Toradex Apalis T30";
+		nvidia,audio-routing =
+			"Headphone Jack", "HP_OUT",
+			"LINE_IN", "Line In Jack",
+			"MIC_IN", "Mic Jack";
+		nvidia,i2s-controller = <&tegra_i2s2>;
+		nvidia,audio-codec = <&sgtl5000>;
+		clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
+			 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+			 <&tegra_car TEGRA30_CLK_EXTERN1>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
+	};
 };
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index c4ed1be..e8ac72e 100644
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
@@ -182,6 +200,15 @@
 		status = "okay";
 		clock-frequency = <100000>;
 
+		/* SGTL5000 audio codec */
+		sgtl5000: codec at 0a {
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
@@ -331,6 +358,12 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
+	ahub at 70080000 {
+		i2s at 70080500 {
+			status = "okay";
+		};
+	};
+
 	emmc: sdhci at 78000600 {
 		status = "okay";
 		bus-width = <8>;
@@ -383,4 +416,20 @@
 			regulator-always-on;
 		};
 	};
+
+	sound {
+		compatible = "toradex,tegra-audio-sgtl5000-colibri_t30",
+			     "nvidia,tegra-audio-sgtl5000";
+		nvidia,model = "Toradex Colibri T30";
+		nvidia,audio-routing =
+			"Headphone Jack", "HP_OUT",
+			"LINE_IN", "Line In Jack",
+			"MIC_IN", "Mic Jack";
+		nvidia,i2s-controller = <&tegra_i2s2>;
+		nvidia,audio-codec = <&sgtl5000>;
+		clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
+			 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+			 <&tegra_car TEGRA30_CLK_EXTERN1>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
+	};
 };
-- 
1.9.3
