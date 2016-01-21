From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 21 Jan 2016 14:36:01 -0800 (PST)
Subject: [PATCH] ARM: dts: porter: add sound support
In-Reply-To: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
Message-ID: <1872468.4EonQLNEFn@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Porter board dependent part of the R8A7791 sound device node.
Add device node for Asahi Kasei AK4642 stereo codec  to the I2C2 bus.
Add the "simple-audio-card" device node to interconnect the SoC sound
device  and the codec.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-20160121-v4.4' tag of Simon Horman's
'renesas.git' repo.

 arch/arm/boot/dts/r8a7791-porter.dts |   71 +++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-porter.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-porter.dts
+++ renesas/arch/arm/boot/dts/r8a7791-porter.dts
@@ -8,6 +8,17 @@
  * kind, whether express or implied.
  */
 
+/*
+ * SSI-AK4642
+ *
+ * SW3: 1: AK4642
+ *      3: ADV7511
+ *
+ * This command is required before playback/capture:
+ *
+ *	amixer set "LINEOUT Mixer DACL" on
+ */
+
 /dts-v1/;
 #include "r8a7791.dtsi"
 #include <dt-bindings/gpio/gpio.h>
@@ -101,6 +112,30 @@
 		#clock-cells = <0>;
 		clock-frequency = <74250000>;
 	};
+
+	x14_clk: x14-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <11289600>;
+		clock-output-names = "audio_clock";
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
+			sound-dai = <&ak4642>;
+			clocks = <&x14_clk>;
+		};
+	};
 };
 
 &extal_clk {
@@ -167,6 +202,16 @@
 		renesas,groups = "du_rgb888", "du_sync", "du_disp", "du_clk_out_0";
 		renesas,function = "du";
 	};
+
+	ssi_pins: sound {
+		renesas,groups = "ssi0129_ctrl", "ssi0_data", "ssi1_data";
+		renesas,function = "ssi";
+	};
+
+	audio_clk_pins: audio_clk {
+		renesas,groups = "audio_clk_a";
+		renesas,function = "audio_clk";
+	};
 };
 
 &scif0 {
@@ -257,6 +302,12 @@
 	status = "okay";
 	clock-frequency = <400000>;
 
+	ak4642: codec at 12 {
+		compatible = "asahi-kasei,ak4642";
+		#sound-dai-cells = <0>;
+		reg = <0x12>;
+	};
+
 	composite-in at 20 {
 		compatible = "adi,adv7180";
 		reg = <0x20>;
@@ -385,3 +436,23 @@
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
