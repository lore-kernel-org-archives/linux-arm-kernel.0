From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 08 Feb 2018 19:44:08 +0100
Subject: [PATCH v2 3/3] ARM: dts: exynos: Add support for HDMI audio on
 exynos5433-tm2
In-Reply-To: <20180208184408.24185-1-s.nawrocki@samsung.com>
References: <20180208184408.24185-1-s.nawrocki@samsung.com>
 <CGME20180208184446epcas2p2a5a59112f29b97dad9deb820699eb741@epcas2p2.samsung.com>
Message-ID: <20180208184408.24185-3-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the sound node of the exynos5433-tm2 board
and adds clock tree configuration in order to support HDMI sound.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1:
 - dropped unnecessary assigned-clock* properties for AUD PLL
   in cmu_top node,
 - changed default AUD PLL frequency so it is withing recommended
   252...400 MHz range.
---
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 60 ++++++++++++++++++++--
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  1 +
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index a77462da4a36..5599f1941c64 100644
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
@@ -216,9 +217,56 @@
 	status = "okay";
 };
 
+#define TM2_DEF_AUD_PLL_RATE	393216003U
+
 &cmu_aud {
-	assigned-clocks = <&cmu_aud CLK_MOUT_AUD_PLL_USER>;
-	assigned-clock-parents = <&cmu_top CLK_FOUT_AUD_PLL>;
+	assigned-clocks = <&cmu_aud CLK_MOUT_AUD_PLL_USER>,
+		<&cmu_aud CLK_MOUT_SCLK_AUD_I2S>,
+		<&cmu_aud CLK_MOUT_SCLK_AUD_PCM>,
+		<&cmu_top CLK_MOUT_AUD_PLL>,
+		<&cmu_top CLK_MOUT_AUD_PLL_USER_T>,
+		<&cmu_top CLK_MOUT_SCLK_AUDIO0>,
+		<&cmu_top CLK_MOUT_SCLK_AUDIO1>,
+		<&cmu_top CLK_MOUT_SCLK_SPDIF>,
+
+		<&cmu_aud CLK_DIV_AUD_CA5>,
+		<&cmu_aud CLK_DIV_ACLK_AUD>,
+		<&cmu_aud CLK_DIV_PCLK_DBG_AUD>,
+		<&cmu_aud CLK_DIV_SCLK_AUD_I2S>,
+		<&cmu_aud CLK_DIV_SCLK_AUD_PCM>,
+		<&cmu_aud CLK_DIV_SCLK_AUD_SLIMBUS>,
+		<&cmu_aud CLK_DIV_SCLK_AUD_UART>,
+		<&cmu_top CLK_DIV_SCLK_AUDIO0>,
+		<&cmu_top CLK_DIV_SCLK_AUDIO1>,
+		<&cmu_top CLK_DIV_SCLK_PCM1>,
+		<&cmu_top CLK_DIV_SCLK_I2S1>;
+
+	assigned-clock-parents = <&cmu_top CLK_FOUT_AUD_PLL>,
+		<&cmu_aud CLK_MOUT_AUD_PLL_USER>,
+		<&cmu_aud CLK_MOUT_AUD_PLL_USER>,
+		<&cmu_top CLK_FOUT_AUD_PLL>,
+		<&cmu_top CLK_MOUT_AUD_PLL>,
+		<&cmu_top CLK_MOUT_AUD_PLL_USER_T>,
+		<&cmu_top CLK_MOUT_AUD_PLL_USER_T>,
+		<&cmu_top CLK_SCLK_AUDIO0>;
+
+	assigned-clock-rates = <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>,
+		<((TM2_DEF_AUD_PLL_RATE / 2) + 1)>,
+		<((TM2_DEF_AUD_PLL_RATE / 6) + 1)>,
+		<((TM2_DEF_AUD_PLL_RATE / 12) + 1)>,
+		<((TM2_DEF_AUD_PLL_RATE / 8) + 1)>,
+		<((TM2_DEF_AUD_PLL_RATE / 192) + 1)>,
+		<((TM2_DEF_AUD_PLL_RATE / 16) + 1)>,
+		<((TM2_DEF_AUD_PLL_RATE / 2) + 1)>,
+		<((TM2_DEF_AUD_PLL_RATE / 16) + 1)>,
+		<((TM2_DEF_AUD_PLL_RATE / 4) + 1)>,
+		<((TM2_DEF_AUD_PLL_RATE / 192) + 1)>,
+		<((TM2_DEF_AUD_PLL_RATE / 8) + 1)>;
+};
+
+&i2s1 {
+	assigned-clocks = <&i2s1 CLK_I2S_RCLK_SRC>;
+	assigned-clock-parents = <&cmu_peric CLK_SCLK_I2S1>;
 };
 
 &cmu_fsys {
@@ -838,6 +886,10 @@
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
