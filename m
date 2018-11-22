From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 Nov 2018 18:23:23 +0800
Subject: [PATCH v9 6/8] arm64: dts: allwinner: a64: add nodes necessary for
 analog sound support
In-Reply-To: <20181122102325.29495-1-wens@csie.org>
References: <20181122102325.29495-1-wens@csie.org>
Message-ID: <20181122102325.29495-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

Add nodes for i2s, digital and analog parts of audiocodec on A64.

The routing paths listed are entries connecting the digital and analog
side of the audio codec together. Due to how device tree works, these
must be copied over to each board device tree, in addition to any board
level routes.

The oversampling rate is set to 128, so that when playing back 192 kHz
audio samples, the MCLK runs at the same rate as the module clock, at
24.576 MHz.

The user manual suggests using different oversampling rates for different
sample rates, but that's not possible without a platform-specific machine
driver.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
[wens at csie.org: Lowered oversampling rate to 128; expanded commit message]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 42abfbf56b88..384c417cb7a2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -155,6 +155,30 @@
 		method = "smc";
 	};
 
+	sound: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sun50i-a64-audio";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&cpudai>;
+		simple-audio-card,bitclock-master = <&cpudai>;
+		simple-audio-card,mclk-fs = <128>;
+		simple-audio-card,aux-devs = <&codec_analog>;
+		simple-audio-card,routing =
+				"Left DAC", "AIF1 Slot 0 Left",
+				"Right DAC", "AIF1 Slot 0 Right",
+				"AIF1 Slot 0 Left ADC", "Left ADC",
+				"AIF1 Slot 0 Right ADC", "Right ADC";
+		status = "disabled";
+
+		cpudai: simple-audio-card,cpu {
+			sound-dai = <&dai>;
+		};
+
+		link_codec: simple-audio-card,codec {
+			sound-dai = <&codec>;
+		};
+	};
+
 	sound_spdif {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "On-board SPDIF";
@@ -665,6 +689,30 @@
 			status = "disabled";
 		};
 
+		dai: dai at 1c22c00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun50i-a64-codec-i2s";
+			reg = <0x01c22c00 0x200>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_CODEC>;
+			reset-names = "rst";
+			dmas = <&dma 15>, <&dma 15>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		codec: codec at 1c22e00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-a33-codec";
+			reg = <0x01c22e00 0x600>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+			clock-names = "bus", "mod";
+			status = "disabled";
+		};
+
 		uart0: serial at 1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
@@ -924,6 +972,12 @@
 			#reset-cells = <1>;
 		};
 
+		codec_analog: codec-analog at 1f015c0 {
+			compatible = "allwinner,sun50i-a64-codec-analog";
+			reg = <0x01f015c0 0x4>;
+			status = "disabled";
+		};
+
 		r_i2c: i2c at 1f02400 {
 			compatible = "allwinner,sun50i-a64-i2c",
 				     "allwinner,sun6i-a31-i2c";
-- 
2.19.1
