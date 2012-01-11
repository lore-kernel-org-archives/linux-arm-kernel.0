From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 Jan 2012 16:09:57 -0700
Subject: [PATCH V2 4/4] ARM: dt: tegra: Enable audio on WM8903 boards,
 disable others
In-Reply-To: <1326323397-23931-1-git-send-email-swarren@nvidia.com>
References: <1326323397-23931-1-git-send-email-swarren@nvidia.com>
Message-ID: <1326323397-23931-4-git-send-email-swarren@nvidia.com>
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
v2: Adjusted DT content based on comments during review of ASoC-side
changes.
---
 arch/arm/boot/dts/tegra-harmony.dts   |   41 ++++++++++++++++++++++++--------
 arch/arm/boot/dts/tegra-paz00.dts     |   12 +++++++++
 arch/arm/boot/dts/tegra-seaboard.dts  |   40 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra-trimslice.dts |   12 +++++++++
 arch/arm/boot/dts/tegra-ventana.dts   |   42 +++++++++++++++++++++++++++++++++
 5 files changed, 137 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
index 80afa1b..9a52615 100644
--- a/arch/arm/boot/dts/tegra-harmony.dts
+++ b/arch/arm/boot/dts/tegra-harmony.dts
@@ -13,16 +13,18 @@
 	i2c at 7000c000 {
 		clock-frequency = <400000>;
 
-		codec: wm8903 at 1a {
+		wm8903: wm8903 at 1a {
 			compatible = "wlf,wm8903";
 			reg = <0x1a>;
-			interrupts = < 347 >;
+			interrupt-parent = <&gpio>;
+			interrupts = < 187 0x04 >;
 
 			gpio-controller;
 			#gpio-cells = <2>;
 
-			/* 0x8000 = Not configured */
-			gpio-cfg = < 0x8000 0x8000 0 0x8000 0x8000 >;
+			micdet-cfg = <0>;
+			micdet-delay = <100>;
+			gpio-cfg = < 0xffffffff 0xffffffff 0 0xffffffff 0xffffffff >;
 		};
 	};
 
@@ -38,13 +40,32 @@
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
+			     "nvidia,tegra-audio-wm8903";
+		nvidia,model = "NVIDIA Tegra Harmony";
+
+		nvidia,audio-routing =
+			"Headphone Jack", "HPOUTR",
+			"Headphone Jack", "HPOUTL",
+			"Int Spk", "ROP",
+			"Int Spk", "RON",
+			"Int Spk", "LOP",
+			"Int Spk", "LON",
+			"Mic Jack", "MICBIAS",
+			"IN1L", "Mic Jack";
+
+		nvidia,i2s-controller = <&tegra_i2s1>;
+		nvidia,audio-codec = <&wm8903>;
+
+		nvidia,spkr-en-gpios = <&wm8903 2 0>;
+		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
+		nvidia,int-mic-en-gpios = <&gpio 184 0>; /*gpio PX0 */
+		nvidia,ext-mic-en-gpios = <&gpio 185 0>; /* gpio PX1 */
 	};
 
 	serial at 70006000 {
diff --git a/arch/arm/boot/dts/tegra-paz00.dts b/arch/arm/boot/dts/tegra-paz00.dts
index 1a1d702..4d1bcdc 100644
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
index b55a02e..898084e 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -13,6 +13,20 @@
 
 	i2c at 7000c000 {
 		clock-frequency = <400000>;
+
+		wm8903: wm8903 at 1a {
+			compatible = "wlf,wm8903";
+			reg = <0x1a>;
+			interrupt-parent = <&gpio>;
+			interrupts = < 187 0x04 >;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			micdet-cfg = <0>;
+			micdet-delay = <100>;
+			gpio-cfg = < 0xffffffff 0xffffffff 0 0xffffffff 0xffffffff >;
+		};
 	};
 
 	i2c at 7000c400 {
@@ -32,6 +46,32 @@
 		};
 	};
 
+	i2s at 70002a00 {
+		status = "disable";
+	};
+
+	sound {
+		compatible = "nvidia,tegra-audio-wm8903-seaboard",
+			     "nvidia,tegra-audio-wm8903";
+		nvidia,model = "NVIDIA Tegra Seaboard";
+
+		nvidia,audio-routing =
+			"Headphone Jack", "HPOUTR",
+			"Headphone Jack", "HPOUTL",
+			"Int Spk", "ROP",
+			"Int Spk", "RON",
+			"Int Spk", "LOP",
+			"Int Spk", "LON",
+			"Mic Jack", "MICBIAS",
+			"IN1R", "Mic Jack";
+
+		nvidia,i2s-controller = <&tegra_i2s1>;
+		nvidia,audio-codec = <&wm8903>;
+
+		nvidia,spkr-en-gpios = <&wm8903 2 0>;
+		nvidia,hp-det-gpios = <&gpio 185 0>; /* gpio PX1 */
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
index c7d3b87..2dcff87 100644
--- a/arch/arm/boot/dts/tegra-ventana.dts
+++ b/arch/arm/boot/dts/tegra-ventana.dts
@@ -12,6 +12,20 @@
 
 	i2c at 7000c000 {
 		clock-frequency = <400000>;
+
+		wm8903: wm8903 at 1a {
+			compatible = "wlf,wm8903";
+			reg = <0x1a>;
+			interrupt-parent = <&gpio>;
+			interrupts = < 187 0x04 >;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			micdet-cfg = <0>;
+			micdet-delay = <100>;
+			gpio-cfg = < 0xffffffff 0xffffffff 0 0xffffffff 0xffffffff >;
+		};
 	};
 
 	i2c at 7000c400 {
@@ -26,6 +40,34 @@
 		clock-frequency = <400000>;
 	};
 
+	i2s at 70002a00 {
+		status = "disable";
+	};
+
+	sound {
+		compatible = "nvidia,tegra-audio-wm8903-ventana",
+			     "nvidia,tegra-audio-wm8903";
+		nvidia,model = "NVIDIA Tegra Ventana";
+
+		nvidia,audio-routing =
+			"Headphone Jack", "HPOUTR",
+			"Headphone Jack", "HPOUTL",
+			"Int Spk", "ROP",
+			"Int Spk", "RON",
+			"Int Spk", "LOP",
+			"Int Spk", "LON",
+			"Mic Jack", "MICBIAS",
+			"IN1L", "Mic Jack";
+
+		nvidia,i2s-controller = <&tegra_i2s1>;
+		nvidia,audio-codec = <&wm8903>;
+
+		nvidia,spkr-en-gpios = <&wm8903 2 0>;
+		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
+		nvidia,int-mic-en-gpios = <&gpio 184 0>; /*gpio PX0 */
+		nvidia,ext-mic-en-gpios = <&gpio 185 0>; /* gpio PX1 */
+	};
+
 	serial at 70006000 {
 		status = "disable";
 	};
-- 
1.7.0.4
