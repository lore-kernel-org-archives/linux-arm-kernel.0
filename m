From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Sun, 19 Jun 2016 03:00:01 +0200
Subject: [PATCH v4 2/3] ARM: tegra: apalis/colibri t30: integrate audio
In-Reply-To: <1466298002-12576-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1466298002-12576-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <1466298002-12576-3-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Integrate Freescale SGTL5000 analogue audio codec support.

Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis.dtsi  | 49 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra30-colibri.dtsi | 49 ++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 192b951..96865ea 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -48,6 +48,24 @@
 		pinctrl-0 = <&state_default>;
 
 		state_default: pinmux {
+			/* Analogue Audio (On-module) */
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
@@ -429,6 +447,15 @@
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
@@ -660,6 +687,12 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
+	ahub at 70080000 {
+		i2s at 70080500 {
+			status = "okay";
+		};
+	};
+
 	/* eMMC */
 	sdhci at 78000600 {
 		status = "okay";
@@ -733,4 +766,20 @@
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
index a265534..7b7af78 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -29,6 +29,24 @@
 		pinctrl-0 = <&state_default>;
 
 		state_default: pinmux {
+			/* Analogue Audio (On-module) */
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
@@ -207,6 +225,15 @@
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
@@ -396,6 +423,12 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
+	ahub at 70080000 {
+		i2s at 70080500 {
+			status = "okay";
+		};
+	};
+
 	/* eMMC */
 	sdhci at 78000600 {
 		status = "okay";
@@ -471,4 +504,20 @@
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
2.5.5
