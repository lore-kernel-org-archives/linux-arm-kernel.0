From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Nov 2014 09:54:33 +0900
Subject: [PATCH 07/29] ARM: shmobile: lager: Sound PIO support on DTS
In-Reply-To: <cover.1416476366.git.horms+renesas@verge.net.au>
References: <cover.1416476366.git.horms+renesas@verge.net.au>
Message-ID: <8ea7a44a98d6c992ffc0013f7a83d9829121292d.1416476366.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 70 +++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 86fb2ee..c2b4f65 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -9,6 +9,18 @@
  * kind, whether express or implied.
  */
 
+/*
+ * SSI-AK4643
+ *
+ * SW1: 1: AK4643
+ *      2: CN22
+ *      3: ADV7511
+ *
+ * This command is required when Playback/Capture
+ *
+ *	amixer set "LINEOUT Mixer DACL" on
+ */
+
 /dts-v1/;
 #include "r8a7790.dtsi"
 #include <dt-bindings/gpio/gpio.h>
@@ -146,6 +158,23 @@
 			  1800000 0>;
 	};
 
+	sound {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,format = "left_j";
+		simple-audio-card,bitclock-master = <&sndcodec>;
+		simple-audio-card,frame-master = <&sndcodec>;
+
+		sndcpu: simple-audio-card,cpu {
+			sound-dai = <&rcar_sound>;
+		};
+
+		sndcodec: simple-audio-card,codec {
+			sound-dai = <&ak4643>;
+			system-clock-frequency = <11289600>;
+		};
+	};
+
 	vga-encoder {
 		compatible = "adi,adv7123";
 
@@ -292,6 +321,16 @@
 		renesas,groups = "vin1_data8", "vin1_clk";
 		renesas,function = "vin1";
 	};
+
+	sound_pins: sound {
+		renesas,groups = "ssi0129_ctrl", "ssi0_data", "ssi1_data";
+		renesas,function = "ssi";
+	};
+
+	sound_clk_pins: sound_clk {
+		renesas,groups = "audio_clk_a";
+		renesas,function = "audio_clk";
+	};
 };
 
 &ether {
@@ -431,6 +470,12 @@
 
 	clock-frequency = <100000>;
 
+	ak4643: sound-codec at 12 {
+		compatible = "asahi-kasei,ak4643";
+		#sound-dai-cells = <0>;
+		reg = <0x12>;
+	};
+
 	composite-in at 20 {
 		compatible = "adi,adv7180";
 		reg = <0x20>;
@@ -513,3 +558,28 @@
 		};
 	};
 };
+
+&rcar_sound {
+	pinctrl-0 = <&sound_pins &sound_clk_pins>;
+	pinctrl-names = "default";
+
+	#sound-dai-cells = <0>;
+
+	status = "okay";
+
+	rcar_sound,dai {
+		dai0 {
+			playback = <&ssi0>;
+			capture  = <&ssi1>;
+		};
+	};
+};
+
+&ssi0 {
+	pio-transfer;
+};
+
+&ssi1 {
+	pio-transfer;
+	shared-pin;
+};
-- 
2.1.1
