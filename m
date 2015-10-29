From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 30 Oct 2015 08:27:53 +0900
Subject: [PATCH v5 07/14] arm64: renesas: salvator-x: Sound SSI PIO support
In-Reply-To: <1446161280-23097-1-git-send-email-horms+renesas@verge.net.au>
References: <1446161280-23097-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1446161280-23097-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds PIO sound support for Salvator-X board.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 95 ++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 0599b2be90ab..6a7df7e0ef7a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -30,6 +30,28 @@
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
@@ -50,6 +72,16 @@
 		renesas,groups = "i2c2_a";
 		renesas,function = "i2c2";
 	};
+
+	sound_pins: sound {
+		renesas,groups = "ssi01239_ctrl", "ssi0_data", "ssi1_data_a";
+		renesas,function = "ssi";
+	};
+
+	sound_clk_pins: sound_clk {
+		renesas,groups = "audio_clkout3_a";
+		renesas,function = "audio_clk";
+	};
 };
 
 &scif1 {
@@ -71,4 +103,67 @@
 	pinctrl-names = "default";
 
 	status = "okay";
+
+	clock-frequency = <100000>;
+
+	ak4613: codec at 0x10 {
+		compatible = "asahi-kasei,ak4613";
+		#sound-dai-cells = <0>;
+		reg = <0x10>;
+		clocks = <&rcar_sound 3>;
+	};
+
+	cs2000: clk_multiplier at 4f {
+		#clock-cells = <0>;
+		compatible = "cirrus,cs2000-cp";
+		reg = <0x4f>;
+		clocks = <&rcar_sound 0>, <&x12_clk>;
+		clock-names = "clk_in", "ref_clk";
+		clock-frequency = <24576000>; /* 1/1 divide */
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
+	clock-frequency = <12288000>;
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
+};
+
+&audio_clk_b {
+	/*
+	 * It should be below here, but it will be dead-lock
+	 * since cs2000 requests audio_clkout (= <&rcar_sound 0>)
+	 * and, rcar_sound (= audio_clk_b) requests cs2000.
+	 * Here assumes cs2000 outputs fixed clock-frequency
+	 *      clocks = <&cs2000>;
+	 */
+	clock-frequency = <24576000>;
 };
-- 
2.1.4
