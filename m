From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:55:31 +0900
Subject: [PATCH 14/18] arm64: renesas: salvator-x: Sound SSI PIO support
In-Reply-To: <cover.1448587800.git.horms+renesas@verge.net.au>
References: <cover.1448587800.git.horms+renesas@verge.net.au>
Message-ID: <994aadf019e9ca7d16634f4e3b442950cefb4a05.1448587800.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds PIO sound support for Salvator-X board.
It can use 44.1kHz base sound only at this point, since 48kHz base
sound needs CS2000, but it is not yet upstreamed.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index d829fdae3c56..90ca7faa629c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -31,6 +31,28 @@
 		/* first 128MB is reserved for secure area. */
 		reg = <0x0 0x48000000 0x0 0x38000000>;
 	};
+
+	x12_clk: x12_clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24576000>;
+	};
+
+	rsnd_ak4613: sound {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,format = "left_j";
+		simple-audio-card,bitclock-master = <&sndcpu>;
+		simple-audio-card,frame-master = <&sndcpu>;
+
+		sndcpu: simple-audio-card,cpu {
+			sound-dai = <&rcar_sound>;
+		};
+
+		sndcodec: simple-audio-card,codec {
+			sound-dai = <&ak4613>;
+		};
+	};
 };
 
 &extal_clk {
@@ -56,6 +78,17 @@
 		renesas,groups = "avb_mdc";
 		renesas,function = "avb";
 	};
+
+	sound_pins: sound {
+		renesas,groups = "ssi01239_ctrl", "ssi0_data", "ssi1_data_a";
+		renesas,function = "ssi";
+	};
+
+	sound_clk_pins: sound_clk {
+		renesas,groups = "audio_clk_a_a", "audio_clk_b_a", "audio_clk_c_a",
+				 "audio_clkout_a", "audio_clkout3_a";
+		renesas,function = "audio_clk";
+	};
 };
 
 &scif1 {
@@ -77,6 +110,49 @@
 	pinctrl-names = "default";
 
 	status = "okay";
+
+	clock-frequency = <100000>;
+
+	ak4613: codec at 10 {
+		compatible = "asahi-kasei,ak4613";
+		#sound-dai-cells = <0>;
+		reg = <0x10>;
+		clocks = <&rcar_sound 3>;
+	};
+};
+
+&rcar_sound {
+	pinctrl-0 = <&sound_pins &sound_clk_pins>;
+	pinctrl-names = "default";
+
+	/* Single DAI */
+	#sound-dai-cells = <0>;
+
+	/* audio_clkout0/1/2/3 */
+	#clock-cells = <1>;
+	clock-frequency = <11289600>;
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
+
+&audio_clk_a {
+	clock-frequency = <22579200>;
 };
 
 &avb {
-- 
2.1.4
