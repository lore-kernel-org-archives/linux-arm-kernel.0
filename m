From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 05 Feb 2018 18:21:10 +0100
Subject: [PATCH 2/2] ARM: dts: exynos: Add support for HDMI audio on
 exynos5433-tm2
In-Reply-To: <20180205172110.9897-1-s.nawrocki@samsung.com>
References: <20180205172110.9897-1-s.nawrocki@samsung.com>
 <CGME20180205172216epcas2p3be603e84df81b28ee4c04c9b1c1c551f@epcas2p3.samsung.com>
Message-ID: <20180205172110.9897-2-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the sound node of the exynos5433-tm2 board
and adds clock tree configuration in order to support HDMI sound.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 67 ++++++++++++++++++++--
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  1 +
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index a77462da4a36..37fb477a2d23 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/sound/samsung-i2s.h>
 
 / {
 	aliases {
@@ -112,8 +113,8 @@
 
 	sound {
 		compatible = "samsung,tm2-audio";
-		audio-codec = <&wm5110>;
-		i2s-controller = <&i2s0>;
+		audio-codec = <&wm5110>, <&hdmi>;
+		i2s-controller = <&i2s0 0>, <&i2s1 0>;
 		audio-amplifier = <&max98504>;
 		mic-bias-gpios = <&gpr3 2 GPIO_ACTIVE_HIGH>;
 		model = "wm5110";
@@ -216,9 +217,63 @@
 	status = "okay";
 };
 
+&cmu_top {
+	assigned-clocks = <&cmu_top CLK_FOUT_AUD_PLL>;
+	assigned-clock-rates = <(196608009 + 1)>;
+};
+
 &cmu_aud {
-	assigned-clocks = <&cmu_aud CLK_MOUT_AUD_PLL_USER>;
-	assigned-clock-parents = <&cmu_top CLK_FOUT_AUD_PLL>;
+	assigned-clocks = <&cmu_aud CLK_MOUT_AUD_PLL_USER>,
+			  <&cmu_aud CLK_MOUT_SCLK_AUD_I2S>,
+			  <&cmu_aud CLK_MOUT_SCLK_AUD_PCM>,
+			  <&cmu_top CLK_MOUT_AUD_PLL>,
+
+			  <&cmu_top CLK_MOUT_AUD_PLL_USER_T>,
+			  <&cmu_top CLK_MOUT_SCLK_AUDIO0>,
+			  <&cmu_top CLK_MOUT_SCLK_AUDIO1>,
+			  <&cmu_top CLK_MOUT_SCLK_SPDIF>,
+
+			  <&cmu_aud CLK_DIV_AUD_CA5>,
+			  <&cmu_aud CLK_DIV_ACLK_AUD>,
+			  <&cmu_aud CLK_DIV_PCLK_DBG_AUD>,
+			  <&cmu_aud CLK_DIV_SCLK_AUD_I2S>,
+			  <&cmu_aud CLK_DIV_SCLK_AUD_PCM>,
+			  <&cmu_aud CLK_DIV_SCLK_AUD_SLIMBUS>,
+			  <&cmu_aud CLK_DIV_SCLK_AUD_UART>,
+
+			  <&cmu_top CLK_DIV_SCLK_AUDIO0>,
+			  <&cmu_top CLK_DIV_SCLK_AUDIO1>,
+			  <&cmu_top CLK_DIV_SCLK_PCM1>,
+			  <&cmu_top CLK_DIV_SCLK_I2S1>;
+
+	assigned-clock-parents = <&cmu_top CLK_FOUT_AUD_PLL>,
+				<&cmu_aud CLK_MOUT_AUD_PLL_USER>,
+				<&cmu_aud CLK_MOUT_AUD_PLL_USER>,
+				<&cmu_top CLK_FOUT_AUD_PLL>,
+
+				<&cmu_top CLK_MOUT_AUD_PLL>,
+				<&cmu_top CLK_MOUT_AUD_PLL_USER_T>,
+				<&cmu_top CLK_MOUT_AUD_PLL_USER_T>,
+				<&cmu_top CLK_SCLK_AUDIO0>;
+
+	assigned-clock-rates = <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>,
+				<(196608009 + 1)>,
+				<((196608009 / 3) + 1)>,
+				<((196608009 / 6) + 1)>,
+				<((196608009 / 4) + 1)>,
+				<((196608009 / 96) + 1)>,
+				<((196608009 / 8) + 1)>,
+				<(196608010 + 1)>,
+
+				<((196608009 / 8) + 1)>,
+				<((196608009 / 2) + 1)>,
+				<((196608009 / 96) + 1)>,
+				<((196608009 / 4) + 1)>;
+};
+
+&i2s1 {
+	assigned-clocks = <&i2s1 CLK_I2S_RCLK_SRC>;
+	assigned-clock-parents = <&cmu_peric CLK_SCLK_I2S1>;
 };
 
 &cmu_fsys {
@@ -838,6 +893,10 @@
 	status = "okay";
 };
 
+&i2s1 {
+	status = "okay";
+};
+
 &mshc_0 {
 	status = "okay";
 	mmc-hs200-1_8v;
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 2b73bd86bc56..c0231d077fa6 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -969,6 +969,7 @@
 			ddc = <&hsi2c_11>;
 			samsung,syscon-phandle = <&pmu_system_controller>;
 			samsung,sysreg-phandle = <&syscon_disp>;
+			#sound-dai-cells = <0>;
 			status = "disabled";
 		};
 
-- 
2.14.2
