From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 22 Nov 2011 18:21:11 -0700
Subject: [PATCH 03/17] arm/dt: Tegra: Enable audio on WM8903 boards,
 disable others
In-Reply-To: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
Message-ID: <1322011285-4002-4-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add complete bindings to instantiate and configure the codec and
top-level audio complex on all currently supported boards using the
Tegra+WM8903 audio driver.

On those boards, disable the I2S2 controller since it isn't used.

On boards not using the WM8903 codec, disable all the audio devices;
they can be re-enabled once the relevant codec and ASoC machine drivers
have been ported to device-tree.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-harmony.dts   |   29 ++++++++++++++++++++-----
 arch/arm/boot/dts/tegra-paz00.dts     |   12 ++++++++++
 arch/arm/boot/dts/tegra-seaboard.dts  |   36 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra-trimslice.dts |   12 ++++++++++
 arch/arm/boot/dts/tegra-ventana.dts   |   38 +++++++++++++++++++++++++++++++++
 5 files changed, 121 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
index 80afa1b..5cd596f 100644
--- a/arch/arm/boot/dts/tegra-harmony.dts
+++ b/arch/arm/boot/dts/tegra-harmony.dts
@@ -21,6 +21,8 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 
+			micdet-cfg = <0>;
+			micdet-delay = <100>;
 			/* 0x8000 = Not configured */
 			gpio-cfg = < 0x8000 0x8000 0 0x8000 0x8000 >;
 		};
@@ -38,13 +40,28 @@
 		clock-frequency = <400000>;
 	};
 
-	sound {
-		compatible = "nvidia,harmony-sound", "nvidia,tegra-wm8903";
+	i2s at 70002a00 {
+		status = "disable";
+	};
 
-		spkr-en-gpios = <&codec 2 0>;
-		hp-det-gpios = <&gpio 178 0>;
-		int-mic-en-gpios = <&gpio 184 0>;
-		ext-mic-en-gpios = <&gpio 185 0>;
+	sound {
+		compatible = "nvidia,tegra-audio-wm8903-harmony",
+                             "nvidia,tegra-audio-wm8903";
+
+		nvidia,spkr-en-gpios = <&codec 2 0>;
+		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
+		nvidia,int-mic-en-gpios = <&gpio 184 0>; /*gpio PX0 */
+		nvidia,ext-mic-en-gpios = <&gpio 185 0>; /* gpio PX1 */
+
+		nvidia,routing =
+			"Headphone Jack", "HPOUTR",
+			"Headphone Jack", "HPOUTL",
+			"Int Spk", "ROP",
+			"Int Spk", "RON",
+			"Int Spk", "LOP",
+			"Int Spk", "LON",
+			"Mic Bias", "Mic Jack",
+			"IN1L", "Mic Bias";
 	};
 
 	serial at 70006000 {
diff --git a/arch/arm/boot/dts/tegra-paz00.dts b/arch/arm/boot/dts/tegra-paz00.dts
index 4f6a8aa..7010982 100644
--- a/arch/arm/boot/dts/tegra-paz00.dts
+++ b/arch/arm/boot/dts/tegra-paz00.dts
@@ -37,6 +37,18 @@
 		clock-frequency = <400000>;
 	};
 
+	i2s at 70002800 {
+		status = "disable";
+	};
+
+	i2s at 70002a00 {
+		status = "disable";
+	};
+
+	das at 70000c00 {
+		status = "disable";
+	};
+
 	serial at 70006000 {
 		clock-frequency = <216000000>;
 	};
diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index f552bcc..dfbafd8 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -13,6 +13,20 @@
 
 	i2c at 7000c000 {
 		clock-frequency = <400000>;
+
+		codec: wm8903 at 1a {
+			compatible = "wlf,wm8903";
+			reg = <0x1a>;
+			interrupts = < 347 >;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			micdet-cfg = <0>;
+			micdet-delay = <100>;
+			/* 0x8000 = Not configured */
+			gpio-cfg = < 0x8000 0x8000 0 0x8000 0x8000 >;
+		};
 	};
 
 	i2c at 7000c400 {
@@ -27,6 +41,28 @@
 		clock-frequency = <400000>;
 	};
 
+	i2s at 70002a00 {
+		status = "disable";
+	};
+
+	sound {
+		compatible = "nvidia,tegra-audio-wm8903-seaboard",
+                             "nvidia,tegra-audio-wm8903";
+
+		nvidia,spkr-en-gpios = <&codec 2 0>;
+		nvidia,hp-det-gpios = <&gpio 185 0>; /* gpio PX1 */
+
+		nvidia,routing =
+			"Headphone Jack", "HPOUTR",
+			"Headphone Jack", "HPOUTL",
+			"Int Spk", "ROP",
+			"Int Spk", "RON",
+			"Int Spk", "LOP",
+			"Int Spk", "LON",
+			"Mic Bias", "Mic Jack",
+			"IN1R", "Mic Bias";
+	};
+
 	serial at 70006000 {
 		status = "disable";
 	};
diff --git a/arch/arm/boot/dts/tegra-trimslice.dts b/arch/arm/boot/dts/tegra-trimslice.dts
index 3b3ee7d..2524768 100644
--- a/arch/arm/boot/dts/tegra-trimslice.dts
+++ b/arch/arm/boot/dts/tegra-trimslice.dts
@@ -26,6 +26,18 @@
 		status = "disable";
 	};
 
+	i2s at 70002800 {
+		status = "disable";
+	};
+
+	i2s at 70002a00 {
+		status = "disable";
+	};
+
+	das at 70000c00 {
+		status = "disable";
+	};
+
 	serial at 70006000 {
 		clock-frequency = < 216000000 >;
 	};
diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
index c7d3b87..c02534e 100644
--- a/arch/arm/boot/dts/tegra-ventana.dts
+++ b/arch/arm/boot/dts/tegra-ventana.dts
@@ -12,6 +12,20 @@
 
 	i2c at 7000c000 {
 		clock-frequency = <400000>;
+
+		codec: wm8903 at 1a {
+			compatible = "wlf,wm8903";
+			reg = <0x1a>;
+			interrupts = < 347 >;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			micdet-cfg = <0>;
+			micdet-delay = <100>;
+			/* 0x8000 = Not configured */
+			gpio-cfg = < 0x8000 0x8000 0 0x8000 0x8000 >;
+		};
 	};
 
 	i2c at 7000c400 {
@@ -26,6 +40,30 @@
 		clock-frequency = <400000>;
 	};
 
+	i2s at 70002a00 {
+		status = "disable";
+	};
+
+	sound {
+		compatible = "nvidia,tegra-audio-wm8903-ventana",
+                             "nvidia,tegra-audio-wm8903";
+
+		nvidia,spkr-en-gpios = <&codec 2 0>;
+		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
+		nvidia,int-mic-en-gpios = <&gpio 184 0>; /*gpio PX0 */
+		nvidia,ext-mic-en-gpios = <&gpio 185 0>; /* gpio PX1 */
+
+		nvidia,routing =
+			"Headphone Jack", "HPOUTR",
+			"Headphone Jack", "HPOUTL",
+			"Int Spk", "ROP",
+			"Int Spk", "RON",
+			"Int Spk", "LOP",
+			"Int Spk", "LON",
+			"Mic Bias", "Mic Jack",
+			"IN1L", "Mic Bias";
+	};
+
 	serial at 70006000 {
 		status = "disable";
 	};
-- 
1.7.0.4
