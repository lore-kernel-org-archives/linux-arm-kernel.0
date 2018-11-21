From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 20 Nov 2018 21:17:51 -0800
Subject: [PATCH v8 6/7] arm64: dts: allwinner: a64: enable sound on Pine64 and
 SoPine
In-Reply-To: <20181121051752.18387-1-anarsoul@gmail.com>
References: <20181121051752.18387-1-anarsoul@gmail.com>
Message-ID: <20181121051752.18387-7-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables I2S, digital and analog parts of audiocodec on
Pine64 and SoPine boards.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 35 +++++++++++++++++++
 .../allwinner/sun50i-a64-sopine-baseboard.dts | 35 +++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index c077b6c1f458..30d0743d0d79 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -73,6 +73,24 @@
 			};
 		};
 	};
+
+	headphone_amp: headphone_amp {
+		compatible = "simple-audio-amplifier";
+		VCC-supply = <&reg_eldo1>;
+		sound-name-prefix = "HP";
+	};
+};
+
+&codec {
+	status = "okay";
+};
+
+&codec_analog {
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
 };
 
 &de {
@@ -259,6 +277,23 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&sound {
+	simple-audio-card,aux-devs = <&codec_analog>, <&headphone_amp>;
+	simple-audio-card,widgets = "Microphone", "Microphone Jack",
+				    "Headphone", "Headphone Jack";
+	simple-audio-card,routing =
+			"Left DAC", "AIF1 Slot 0 Left",
+			"Right DAC", "AIF1 Slot 0 Right",
+			"HP INL", "HP",
+			"HP INR", "HP",
+			"Headphone Jack", "HP OUTL",
+			"Headphone Jack", "HP OUTR",
+			"AIF1 Slot 0 Left ADC", "Left ADC",
+			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"MIC2", "Microphone Jack";
+	status = "okay";
+};
+
 /* On Euler connector */
 &spdif {
 	status = "disabled";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 53fcc9098df3..81d85ad127a2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -72,6 +72,12 @@
 		};
 	};
 
+	headphone_amp: headphone_amp {
+		compatible = "simple-audio-amplifier";
+		VCC-supply = <&reg_eldo1>;
+		sound-name-prefix = "HP";
+	};
+
 	reg_vcc1v8: vcc1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8";
@@ -80,6 +86,18 @@
 	};
 };
 
+&codec {
+	status = "okay";
+};
+
+&codec_analog {
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
+};
+
 &de {
 	status = "okay";
 };
@@ -164,6 +182,23 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&sound {
+	simple-audio-card,aux-devs = <&codec_analog>, <&headphone_amp>;
+	simple-audio-card,widgets = "Microphone", "Microphone Jack",
+				    "Headphone", "Headphone Jack";
+	simple-audio-card,routing =
+			"Left DAC", "AIF1 Slot 0 Left",
+			"Right DAC", "AIF1 Slot 0 Right",
+			"HP INL", "HP",
+			"HP INR", "HP",
+			"Headphone Jack", "HP OUTL",
+			"Headphone Jack", "HP OUTR",
+			"AIF1 Slot 0 Left ADC", "Left ADC",
+			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"MIC2", "Microphone Jack";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.19.1
