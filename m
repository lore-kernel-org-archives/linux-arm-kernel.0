From: ideal.song@samsung.com (Inha Song)
Date: Fri, 06 Mar 2015 17:18:01 +0900
Subject: [alsa-devel] [PATCH] ARM: dts: Support audio on Exynos5422-odroidxu3
 using simple-audio-card
Message-ID: <1425629881-12944-1-git-send-email-ideal.song@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MAX98090 audio codec, I2S interface and the sound nodes to support
audio on Exynos5422 SoC Based Odroid-XU3 board. Now we can support audio
in Odroid-XU3 board using simple-audio-card DT binding.

Signed-off-by: Inha Song <ideal.song@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi          |  9 +++++
 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 57 ++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index c0e98cf..a70005e 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -411,6 +411,9 @@
 			<&clock_audss EXYNOS_I2S_BUS>,
 			<&clock_audss EXYNOS_SCLK_I2S>;
 		clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
+		#clock-cells = <1>;
+		clock-output-names = "i2s_cdclk0";
+		#sound-dai-cells = <1>;
 		samsung,idma-addr = <0x03000000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_bus>;
@@ -425,6 +428,9 @@
 		dma-names = "tx", "rx";
 		clocks = <&clock CLK_I2S1>, <&clock CLK_SCLK_I2S1>;
 		clock-names = "iis", "i2s_opclk0";
+		#clock-cells = <1>;
+		clock-output-names = "i2s_cdclk1";
+		#sound-dai-cells = <1>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s1_bus>;
 		status = "disabled";
@@ -438,6 +444,9 @@
 		dma-names = "tx", "rx";
 		clocks = <&clock CLK_I2S2>, <&clock CLK_SCLK_I2S2>;
 		clock-names = "iis", "i2s_opclk0";
+		#clock-cells = <1>;
+		clock-output-names = "i2s_cdclk2";
+		#sound-dai-cells = <1>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s2_bus>;
 		status = "disabled";
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index edc25cf..9275ad6 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -11,6 +11,7 @@
 */
 
 /dts-v1/;
+#include <dt-bindings/sound/samsung-i2s.h>
 #include "exynos5800.dtsi"
 
 / {
@@ -285,6 +286,62 @@
 	rtc at 101E0000 {
 		status = "okay";
 	};
+
+	sound: sound {
+		compatible = "simple-audio-card";
+		assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>,
+				<&clock_audss EXYNOS_MOUT_I2S>,
+				<&clock_audss EXYNOS_DOUT_AUD_BUS>;
+		assigned-clock-parents = <&clock CLK_FIN_PLL>,
+				<&clock_audss EXYNOS_MOUT_AUDSS>;
+		assigned-clock-rates = <0>,
+				<0>,
+				<19200000>;
+
+		simple-audio-card,name = "Odroid-XU3";
+
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack",
+			"Speakers", "Speakers";
+		simple-audio-card,routing =
+			"Headphone Jack", "HPL",
+			"Headphone Jack", "HPR",
+			"Headphone Jack", "MICBIAS",
+			"IN1", "Headphone Jack",
+			"Speakers", "SPKL",
+			"Speakers", "SPKR";
+
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&link0_codec>;
+		simple-audio-card,frame-master = <&link0_codec>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s0 0>;
+			system-clock-frequency = <19200000>;
+		};
+
+		link0_codec: simple-audio-card,codec {
+			sound-dai = <&max98090>;
+			clocks = <&i2s0 CLK_I2S_CDCLK>;
+		};
+	};
+};
+
+&hsi2c_5 {
+	status = "okay";
+	max98090: max98090 at 10 {
+		compatible = "maxim,max98090";
+		reg = <0x10>;
+		interrupt-parent = <&gpx3>;
+		interrupts = <2 0>;
+		clocks = <&i2s0 CLK_I2S_CDCLK>;
+		clock-names = "mclk";
+		#sound-dai-cells = <0>;
+	};
+};
+
+&i2s0 {
+	status = "okay";
 };
 
 &hdmi {
-- 
2.0.0.390.gcb682f8
