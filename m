From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 14 Jul 2014 17:12:32 +0200
Subject: [PATCH] ARM: dts: Add sound nodes for Odroid-X2/U3 boards
Message-ID: <1405350752-25795-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MAX98090 audio codec, I2S interface and the sound complex
nodes to enable audio on Odroid-X2/U3 boards.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
This patch depends on the series from Marek [1] adding dt sources
for Odroid X2/U3. My testing branch can be pulled from [2].

[1] http://www.spinics.net/lists/linux-samsung-soc/msg32544.html
[2] git://linuxtv.org/snawrocki/samsung.git v3.16-rc5-odroid-sound

 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |   27 +++++++++++++++++++++++
 arch/arm/boot/dts/exynos4412-odroidu3.dts       |   12 ++++++++++
 arch/arm/boot/dts/exynos4412-odroidx2.dts       |    9 ++++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 0bc1a9b..6d6d23c 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -32,6 +32,21 @@
 		};
 	};

+	i2s0: i2s at 03830000 {
+		pinctrl-0 = <&i2s0_bus>;
+		pinctrl-names = "default";
+		status = "okay";
+		clocks = <&clock_audss EXYNOS_I2S_BUS>,
+			 <&clock_audss EXYNOS_DOUT_AUD_BUS>;
+		clock-names = "iis", "i2s_opclk0";
+	};
+
+	sound: sound {
+		compatible = "samsung,odroidx2-audio";
+		samsung,i2s-controller = <&i2s0>;
+		samsung,audio-codec = <&max98090>;
+	};
+
 	mmc at 12550000 {
 		pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
 		pinctrl-names = "default";
@@ -321,6 +336,18 @@
 		};
 	};

+	i2c at 13870000 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c1_bus>;
+		status = "okay";
+		max98090: max98090 at 10 {
+			compatible = "maxim,max98090";
+			reg = <0x10>;
+			interrupt-parent = <&gpx0>;
+			interrupts = <0 0>;
+		};
+	};
+
 	exynos-usbphy at 125B0000 {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 287aa0d..c8a64be 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -47,3 +47,15 @@
 		status = "okay";
 	};
 };
+
+&sound {
+	compatible = "samsung,odroidu3-audio";
+	samsung,model = "Odroid-U3";
+	samsung,audio-routing =
+		"Headphone Jack", "HPL",
+		"Headphone Jack", "HPR",
+		"Headphone Jack", "MICBIAS",
+		"IN1", "Headphone Jack",
+		"Speakers", "SPKL",
+		"Speakers", "SPKR";
+};
diff --git a/arch/arm/boot/dts/exynos4412-odroidx2.dts b/arch/arm/boot/dts/exynos4412-odroidx2.dts
index e9ae161..96b43f4 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx2.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx2.dts
@@ -21,3 +21,12 @@
 		reg = <0x40000000 0x7FF00000>;
 	};
 };
+
+&sound {
+	samsung,model = "Odroid-X2";
+	samsung,audio-routing =
+		"Headphone Jack", "HPL",
+		"Headphone Jack", "HPR",
+		"IN1", "Mic Jack",
+		"Mic Jack", "MICBIAS";
+};
--
1.7.9.5
