From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Aug 2016 10:55:42 +0200
Subject: [PATCH 23/26] ARM: dts: silk: add sound support
In-Reply-To: <cover.1471251169.git.horms+renesas@verge.net.au>
References: <cover.1471251169.git.horms+renesas@verge.net.au>
Message-ID: <feb13b95c3fc461bb01ef32cdb818f99d6a859db.1471251169.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the SILK board dependent part of the R8A7794 sound  device node.
Add device node for Asahi Kasei AK4643 stereo codec to the I2C1 bus.
Add the "simple-audio-card" device node to interconnect the SoC sound
device  and the codec.

This patch is based on the commit 493b4da7c10c ("ARM: dts: porter: add
sound support").

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-silk.dts | 70 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index cf24f45fff22..cf880ac06f4b 100644
--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -10,6 +10,17 @@
  * kind, whether express or implied.
  */
 
+/*
+ * SSI-AK4643
+ *
+ * SW1: 2-1: AK4643
+ *      2-3: ADV7511
+ *
+ * This command is required before playback/capture:
+ *
+ *	amixer set "LINEOUT Mixer DACL" on
+ */
+
 /dts-v1/;
 #include "r8a7794.dtsi"
 #include <dt-bindings/gpio/gpio.h>
@@ -119,6 +130,29 @@
 		#clock-cells = <0>;
 		clock-frequency = <74250000>;
 	};
+
+	x9_clk: audio_clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12288000>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,format = "left_j";
+		simple-audio-card,bitclock-master = <&soundcodec>;
+		simple-audio-card,frame-master = <&soundcodec>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&rcar_sound>;
+		};
+
+		soundcodec: simple-audio-card,codec {
+			sound-dai = <&ak4643>;
+			clocks = <&x9_clk>;
+		};
+	};
 };
 
 &extal_clk {
@@ -193,6 +227,16 @@
 		groups = "du1_rgb666", "du1_sync", "du1_disp", "du1_clk0_out";
 		function = "du1";
 	};
+
+	ssi_pins: sound {
+		groups = "ssi0129_ctrl", "ssi0_data", "ssi1_data";
+		function = "ssi";
+	};
+
+	audio_clk_pins: audio_clk {
+		groups = "audio_clkc";
+		function = "audio_clk";
+	};
 };
 
 &scif2 {
@@ -230,6 +274,12 @@
 	status = "okay";
 	clock-frequency = <400000>;
 
+	ak4643: codec at 12 {
+		compatible = "asahi-kasei,ak4643";
+		#sound-dai-cells = <0>;
+		reg = <0x12>;
+	};
+
 	composite-in at 20 {
 		compatible = "adi,adv7180";
 		reg = <0x20>;
@@ -392,3 +442,23 @@
 		};
 	};
 };
+
+&rcar_sound {
+	pinctrl-0 = <&ssi_pins &audio_clk_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	/* Single DAI */
+	#sound-dai-cells = <0>;
+
+	rcar_sound,dai {
+		dai0 {
+			playback = <&ssi0>;
+			capture  = <&ssi1>;
+		};
+	};
+};
+
+&ssi1 {
+	shared-pin;
+};
-- 
2.7.0.rc3.207.g0ac5344
