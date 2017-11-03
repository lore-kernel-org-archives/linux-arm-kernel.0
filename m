From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 03 Nov 2017 17:54:45 +0100
Subject: [PATCH v2 1/2] ARM: dts: exynos: Switch to dedicated Odroid-XU3
 sound card binding
In-Reply-To: <20171103165446.15438-1-s.nawrocki@samsung.com>
References: <20171103165446.15438-1-s.nawrocki@samsung.com>
 <CGME20171103165539epcas1p48cc87811574dace9dfe91d8e9ec6f7ca@epcas1p4.samsung.com>
Message-ID: <20171103165446.15438-2-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new sound card DT binding is used for Odroid XU3 in order
to properly support the HDMI audio path.
Clocks configuration is changed so the I2S controller is now the bit
and the frame clock master with EPLL as the root clock source.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi                    |  1 +
 arch/arm/boot/dts/exynos5420.dtsi                 |  1 +
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi | 60 ++++++++++++++---------
 3 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 5739389f5bb8..f82647c0adb1 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -755,6 +755,7 @@
 		phy = <&hdmi_i2c_phy>;
 		power-domains = <&pd_tv>;
 		samsung,syscon-phandle = <&pmu_system_controller>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 88e5d6d3f901..6f0414cce854 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -618,6 +618,7 @@
 			samsung,syscon-phandle = <&pmu_system_controller>;
 			status = "disabled";
 			power-domains = <&disp_pd>;
+			#sound-dai-cells = <0>;
 		};
 
 		hdmiphy: hdmiphy at 145D0000 {
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
index da3141a307d5..fe4d8ef094d0 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
@@ -1,5 +1,5 @@
 /*
- * Hardkernel Odroid XU3 Audio Codec device tree source
+ * Hardkernel Odroid XU3 audio subsystem device tree source
  *
  * Copyright (c) 2015 Krzysztof Kozlowski
  * Copyright (c) 2014 Collabora Ltd.
@@ -15,13 +15,13 @@
 
 / {
 	sound: sound {
-		compatible = "simple-audio-card";
+		compatible = "samsung,odroid-xu3-audio";
+		model = "Odroid-XU3";
 
-		simple-audio-card,name = "Odroid-XU3";
-		simple-audio-card,widgets =
+		samsung,audio-widgets =
 			"Headphone", "Headphone Jack",
 			"Speakers", "Speakers";
-		simple-audio-card,routing =
+		samsung,audio-routing =
 			"Headphone Jack", "HPL",
 			"Headphone Jack", "HPR",
 			"Headphone Jack", "MICBIAS",
@@ -29,31 +29,47 @@
 			"Speakers", "SPKL",
 			"Speakers", "SPKR";
 
-		simple-audio-card,format = "i2s";
-		simple-audio-card,bitclock-master = <&link0_codec>;
-		simple-audio-card,frame-master = <&link0_codec>;
+		assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>,
+				<&clock CLK_MOUT_EPLL>,
+				<&clock CLK_MOUT_MAU_EPLL>,
+				<&clock CLK_MOUT_USER_MAU_EPLL>,
+				<&clock_audss EXYNOS_MOUT_AUDSS>,
+				<&clock_audss EXYNOS_MOUT_I2S>,
+				<&clock_audss EXYNOS_DOUT_SRP>,
+				<&clock_audss EXYNOS_DOUT_AUD_BUS>,
+				<&clock_audss EXYNOS_DOUT_I2S>;
 
-		simple-audio-card,cpu {
+		assigned-clock-parents = <&clock_audss EXYNOS_SCLK_I2S>,
+				<&clock CLK_FOUT_EPLL>,
+				<&clock CLK_MOUT_EPLL>,
+				<&clock CLK_MOUT_MAU_EPLL>,
+				<&clock CLK_MAU_EPLL>,
+				<&clock_audss EXYNOS_MOUT_AUDSS>;
+
+		assigned-clock-rates = <0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<196608001>,
+				<(196608002 / 2)>,
+				<196608000>;
+
+		cpu {
 			sound-dai = <&i2s0 0>;
-			system-clock-frequency = <19200000>;
 		};
-
-		link0_codec: simple-audio-card,codec {
-			sound-dai = <&max98090>;
-			clocks = <&i2s0 CLK_I2S_CDCLK>;
+		codec {
+			sound-dai = <&hdmi>, <&max98090>;
 		};
 	};
 };
 
 &clock_audss {
-	assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>,
-			<&clock_audss EXYNOS_MOUT_I2S>,
-			<&clock_audss EXYNOS_DOUT_AUD_BUS>;
-	assigned-clock-parents = <&clock CLK_FIN_PLL>,
-			<&clock_audss EXYNOS_MOUT_AUDSS>;
-	assigned-clock-rates = <0>,
-			<0>,
-			<19200000>;
+	assigned-clocks = <&clock_audss EXYNOS_DOUT_SRP>,
+			  <&clock CLK_FOUT_EPLL>;
+	assigned-clock-rates = <(196608000 / 256)>,
+			       <196608000>;
 };
 
 &hsi2c_5 {
-- 
2.14.2
