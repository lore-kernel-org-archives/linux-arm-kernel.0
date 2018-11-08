From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed,  7 Nov 2018 22:39:27 -0800
Subject: [PATCH v6 1/3] arm64: dts: allwinner: a64: add nodes necessary for
 analog sound support
In-Reply-To: <20181108063929.29720-1-anarsoul@gmail.com>
References: <20181108063929.29720-1-anarsoul@gmail.com>
Message-ID: <20181108063929.29720-2-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for i2s, digital and analog parts of audiocodec on A64

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index f3a66f888205..53796a3e6bf3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -173,6 +173,34 @@
 		compatible = "linux,spdif-dit";
 	};
 
+	sound: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sun50i-a64-audio";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&cpudai>;
+		simple-audio-card,bitclock-master = <&cpudai>;
+		simple-audio-card,mclk-fs = <512>;
+		simple-audio-card,aux-devs = <&codec_analog>;
+		simple-audio-card,routing =
+				"Left DAC", "AIF1 Slot 0 Left",
+				"Right DAC", "AIF1 Slot 0 Right",
+				"AIF1 Slot 0 Left ADC", "Left ADC",
+				"AIF1 Slot 0 Right ADC", "Right ADC",
+				"Left ADC", "ADC",
+				"Right ADC", "ADC",
+				"MIC1", "Mic",
+				"MIC2", "Headset Mic";
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
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
@@ -665,6 +693,30 @@
 			status = "disabled";
 		};
 
+		dai: dai@1c22c00 {
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
@@ -902,6 +954,12 @@
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
