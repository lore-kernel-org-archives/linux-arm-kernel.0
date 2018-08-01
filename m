From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed,  1 Aug 2018 15:40:33 +0200
Subject: [PATCH v2 3/3] arm64: dts: meson-axg: s400: add sound card
In-Reply-To: <20180801134033.21739-1-jbrunet@baylibre.com>
References: <20180801134033.21739-1-jbrunet@baylibre.com>
Message-ID: <20180801134033.21739-4-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the sound card of the s400. With it the following interface
should be working:
 * Lineout
 * Daugther card speaker 1 (same output as lineout)
 * Linein
 * SPDIF output

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 9f5d81c3ee29..d399078d1f0c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -204,6 +204,113 @@
 		status = "okay";
 		sound-name-prefix = "DIT";
 	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "AXG-S400";
+		audio-aux-devs = <&tdmin_a>, <&tdmin_b>,  <&tdmin_c>,
+				 <&tdmin_lb>, <&tdmout_c>;
+		audio-widgets = "Line", "Lineout",
+				"Line", "Linein",
+				"Speaker", "Speaker1 Left",
+				"Speaker", "Speaker1 Right";
+		audio-routing = "TDMOUT_C IN 0", "FRDDR_A OUT 2",
+				"SPDIFOUT IN 0", "FRDDR_A OUT 3",
+				"TDMOUT_C IN 1", "FRDDR_B OUT 2",
+				"SPDIFOUT IN 1", "FRDDR_B OUT 3",
+				"TDMOUT_C IN 2", "FRDDR_C OUT 2",
+				"SPDIFOUT IN 2", "FRDDR_C OUT 3",
+				"TDM_C Playback", "TDMOUT_C OUT",
+				"TDMIN_A IN 2", "TDM_C Capture",
+				"TDMIN_A IN 5", "TDM_C Loopback",
+				"TDMIN_B IN 2", "TDM_C Capture",
+				"TDMIN_B IN 5", "TDM_C Loopback",
+				"TDMIN_C IN 2", "TDM_C Capture",
+				"TDMIN_C IN 5", "TDM_C Loopback",
+				"TDMIN_LB IN 2", "TDM_C Loopback",
+				"TDMIN_LB IN 5", "TDM_C Capture",
+				"TODDR_A IN 0", "TDMIN_A OUT",
+				"TODDR_B IN 0", "TDMIN_A OUT",
+				"TODDR_C IN 0", "TDMIN_A OUT",
+				"TODDR_A IN 1", "TDMIN_B OUT",
+				"TODDR_B IN 1", "TDMIN_B OUT",
+				"TODDR_C IN 1", "TDMIN_B OUT",
+				"TODDR_A IN 2", "TDMIN_C OUT",
+				"TODDR_B IN 2", "TDMIN_C OUT",
+				"TODDR_C IN 2", "TDMIN_C OUT",
+				"TODDR_A IN 6", "TDMIN_LB OUT",
+				"TODDR_B IN 6", "TDMIN_LB OUT",
+				"TODDR_C IN 6", "TDMIN_LB OUT",
+				"Lineout", "Lineout AOUTL",
+				"Lineout", "Lineout AOUTR",
+				"Speaker1 Left", "SPK1 OUT_A",
+				"Speaker1 Left", "SPK1 OUT_B",
+				"Speaker1 Right", "SPK1 OUT_C",
+				"Speaker1 Right", "SPK1 OUT_D",
+				"Linein AINL", "Linein",
+				"Linein AINR", "Linein";
+		assigned-clocks = <&clkc CLKID_HIFI_PLL>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <589824000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link at 0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link at 1 {
+			sound-dai = <&frddr_b>;
+		};
+
+		dai-link at 2 {
+			sound-dai = <&frddr_c>;
+		};
+
+		dai-link at 3 {
+			sound-dai = <&toddr_a>;
+		};
+
+		dai-link at 4 {
+			sound-dai = <&toddr_b>;
+		};
+
+		dai-link at 5 {
+			sound-dai = <&toddr_c>;
+		};
+
+		dai-link at 6 {
+			sound-dai = <&tdmif_c>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-rx-mask-1 = <1 1>;
+			mclk-fs = <256>;
+
+			codec at 0 {
+				sound-dai = <&lineout>;
+			};
+
+			codec at 1 {
+				sound-dai = <&speaker_amp1>;
+			};
+
+			codec at 2 {
+				sound-dai = <&linein>;
+			};
+
+		};
+
+		dai-link at 7 {
+			sound-dai = <&spdifout>;
+
+			codec {
+				sound-dai = <&spdif_dit>;
+			};
+		};
+	};
 };
 
 &ethmac {
@@ -272,6 +379,7 @@
 		PVDD_B-supply = <&main_12v>;
 		PVDD_C-supply = <&main_12v>;
 		PVDD_D-supply = <&main_12v>;
+		sound-name-prefix = "SPK1";
 	};
 };
 
-- 
2.17.1
