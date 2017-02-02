From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Thu,  2 Feb 2017 10:24:19 +0100
Subject: [PATCH v4 5/8] ASoC: codecs: Add sun8i-a33 binding documentation
In-Reply-To: <20170202092422.5588-1-mylene.josserand@free-electrons.com>
References: <20170202092422.5588-1-mylene.josserand@free-electrons.com>
Message-ID: <20170202092422.5588-6-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the documentation for dt-binding of the digital audio codec driver
and the audio card driver for Sun8i-a33 SoCs.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/sound/sun8i-a33-codec.txt  | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt b/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
new file mode 100644
index 000000000000..399b1b4bae22
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
@@ -0,0 +1,63 @@
+Allwinner SUN8I audio codec
+------------------------------------
+
+On Sun8i-A33 SoCs, the audio is separated in different parts:
+	  - A DAI driver. It uses the "sun4i-i2s" driver which is
+	  documented here:
+	  Documentation/devicetree/bindings/sound/sun4i-i2s.txt
+	  - An analog part of the codec which is handled as PRCM registers.
+	  See Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
+	  - An digital part of the codec which is documented in this current
+	  binding documentation.
+	  - And finally, an audio card which links all the above components.
+	  The simple-audio card will be used.
+	  See Documentation/devicetree/bindings/sound/simple-card.txt
+
+This bindings documentation exposes Sun8i codec (digital part).
+
+Required properties:
+- compatible: must be "allwinner,sun8i-a33-codec"
+- reg: must contain the registers location and length
+- interrupts: must contain the codec interrupt
+- clocks: a list of phandle + clock-specifer pairs, one for each entry
+  in clock-names.
+- clock-names: should contain followings:
+   - "bus": the parent APB clock for this controller
+   - "mod": the parent module clock
+
+Here is an example to add a sound card and the codec binding on sun8i SoCs that
+are similar to A33 using simple-card:
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sun8i-a33-audio";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&link_codec>;
+		simple-audio-card,bitclock-master = <&link_codec>;
+		simple-audio-card,mclk-fs = <512>;
+		simple-audio-card,aux-devs = <&codec_analog>;
+		simple-audio-card,routing =
+				"Left DAC", "Digital Left DAC",
+				"Right DAC", "Digital Right DAC";
+
+		simple-audio-card,cpu {
+			sound-dai = <&dai>;
+		};
+
+		link_codec: simple-audio-card,codec {
+			sound-dai = <&codec>;
+		};
+
+	soc at 01c00000 {
+		[...]
+
+		audio-codec at 1c22e00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-a33-codec";
+			reg = <0x01c22e00 0x400>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+			clock-names = "bus", "mod";
+		};
+	};
+
-- 
2.11.0
