From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 14 May 2018 10:01:48 +0200
Subject: [PATCH v2] ARM: dts: exynos: Add support for audio over HDMI for
 Odroid X/X2/U3
References: <CGME20180514080220epcas2p110497f1deca1e9c10db9b9edb890d76b@epcas2p1.samsung.com>
Message-ID: <20180514080148.10150-1-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch switches Odroid X/X2/U3 to use dedicated Odroid audio subsystem
DT bindings instead of the simple-card in order to add support for audio
over HDMI.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 33 +++++++++++++++----------
 arch/arm/boot/dts/exynos4412-odroidu3.dts       |  6 ++---
 arch/arm/boot/dts/exynos4412-odroidx.dts        |  6 ++---
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index d7ad07fd48f9..a09e46c9dbc0 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -37,20 +37,14 @@
 	};
 
 	sound: sound {
-		compatible = "simple-audio-card";
+		compatible = "hardkernel,odroid-xu4-audio";
 
-		simple-audio-card,format = "i2s";
-		simple-audio-card,bitclock-master = <&link0_codec>;
-		simple-audio-card,frame-master = <&link0_codec>;
-
-		simple-audio-card,cpu {
+		cpu {
 			sound-dai = <&i2s0 0>;
-			system-clock-frequency = <19200000>;
 		};
 
-		link0_codec: simple-audio-card,codec {
-			sound-dai = <&max98090>;
-			clocks = <&i2s0 CLK_I2S_CDCLK>;
+		codec {
+			sound-dai = <&hdmi>, <&max98090>;
 		};
 	};
 
@@ -142,14 +136,25 @@
 	pinctrl-0 = <>;
 };
 
+&clock {
+	assigned-clocks = <&clock CLK_FOUT_EPLL>;
+	assigned-clock-rates = <45158401>;
+};
+
 &clock_audss {
 	assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>,
 			<&clock_audss EXYNOS_MOUT_I2S>,
 			<&clock_audss EXYNOS_DOUT_SRP>,
-			<&clock_audss EXYNOS_DOUT_AUD_BUS>;
+			<&clock_audss EXYNOS_DOUT_AUD_BUS>,
+			<&clock_audss EXYNOS_DOUT_I2S>;
+
 	assigned-clock-parents = <&clock CLK_FOUT_EPLL>,
-			<&clock_audss EXYNOS_MOUT_AUDSS>;
-	assigned-clock-rates = <0>, <0>, <192000000>, <19200000>;
+			  <&clock_audss EXYNOS_MOUT_AUDSS>;
+
+	assigned-clock-rates = <0>, <0>,
+			<196608001>,
+			<(196608001 / 2)>,
+			<(196608001 / 8)>;
 };
 
 &cpu0 {
@@ -498,6 +503,8 @@
 	pinctrl-0 = <&i2s0_bus>;
 	pinctrl-names = "default";
 	status = "okay";
+	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
+	assigned-clock-parents = <&clock_audss EXYNOS_SCLK_I2S>;
 };
 
 &mixer {
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index bdcd4523cc1c..459919b65df8 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -113,11 +113,11 @@
 };
 
 &sound {
-	simple-audio-card,name = "Odroid-U3";
-	simple-audio-card,widgets =
+	model = "Odroid-U3";
+	samsung,audio-widgets =
 		"Headphone", "Headphone Jack",
 		"Speakers", "Speakers";
-	simple-audio-card,routing =
+	samsung,audio-routing =
 		"Headphone Jack", "HPL",
 		"Headphone Jack", "HPR",
 		"Headphone Jack", "MICBIAS",
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 2dff129bc2ad..348556fcdd9d 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -97,12 +97,12 @@
 };
 
 &sound {
-	simple-audio-card,name = "Odroid-X";
-	simple-audio-card,widgets =
+	model = "Odroid-X";
+	samsung,audio-widgets =
 		"Headphone", "Headphone Jack",
 		"Microphone", "Mic Jack",
 		"Microphone", "DMIC";
-	simple-audio-card,routing =
+	samsung,audio-routing =
 		"Headphone Jack", "HPL",
 		"Headphone Jack", "HPR",
 		"IN1", "Mic Jack",
-- 
2.14.2
