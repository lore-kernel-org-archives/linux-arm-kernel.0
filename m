From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:46 +0100
Subject: [PATCH 20/40] arm64: dts: renesas: ebisu: Enable Audio
In-Reply-To: <cover.1543229515.git.horms+renesas@verge.net.au>
References: <cover.1543229515.git.horms+renesas@verge.net.au>
Message-ID: <56629fcba94c698d8c5be3413981506479566869.1543229515.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch enables Audio for the Ebisu board on R8A77990 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[simon: rebased]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts | 127 +++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
index 038664e0cdcb..b178f261d805 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -29,6 +29,16 @@
 		reg = <0x0 0x48000000 0x0 0x38000000>;
 	};
 
+	audio_clkout: audio-clkout {
+		/*
+		 * This is same as <&rcar_sound 0>
+		 * but needed to avoid cs2000/rcar_sound probe dead-lock
+		 */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <11289600>;
+	};
+
 	cvbs-in {
 		compatible = "composite-video-connector";
 		label = "CVBS IN";
@@ -139,6 +149,32 @@
 		enable-active-high;
 	};
 
+	rsnd_ak4613: sound {
+		compatible = "simple-scu-audio-card";
+
+		simple-audio-card,name = "rsnd-ak4613";
+		simple-audio-card,format = "left_j";
+		simple-audio-card,bitclock-master = <&sndcpu>;
+		simple-audio-card,frame-master = <&sndcpu>;
+
+		simple-audio-card,prefix = "ak4613";
+		simple-audio-card,routing = "ak4613 Playback", "DAI0 Playback",
+		"DAI0 Capture", "ak4613 Capture";
+		sndcpu: simple-audio-card,cpu {
+			sound-dai = <&rcar_sound>;
+		};
+
+		sndcodec: simple-audio-card,codec {
+			sound-dai = <&ak4613>;
+		};
+	};
+
+	x12_clk: x12 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24576000>;
+	};
+
 	x13_clk: x13 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -146,6 +182,10 @@
 	};
 };
 
+&audio_clk_a {
+	clock-frequency = <22579200>;
+};
+
 &avb {
 	pinctrl-0 = <&avb_pins>;
 	pinctrl-names = "default";
@@ -287,6 +327,37 @@
 	};
 };
 
+&i2c3 {
+	status = "okay";
+
+	ak4613: codec at 10 {
+		compatible = "asahi-kasei,ak4613";
+		#sound-dai-cells = <0>;
+		reg = <0x10>;
+		clocks = <&rcar_sound 3>;
+
+		asahi-kasei,in1-single-end;
+		asahi-kasei,in2-single-end;
+		asahi-kasei,out1-single-end;
+		asahi-kasei,out2-single-end;
+		asahi-kasei,out3-single-end;
+		asahi-kasei,out4-single-end;
+		asahi-kasei,out5-single-end;
+		asahi-kasei,out6-single-end;
+	};
+
+	cs2000: clk-multiplier at 4f {
+		#clock-cells = <0>;
+		compatible = "cirrus,cs2000-cp";
+		reg = <0x4f>;
+		clocks = <&audio_clkout>, <&x12_clk>;
+		clock-names = "clk_in", "ref_clk";
+
+		assigned-clocks = <&cs2000>;
+		assigned-clock-rates = <24576000>; /* 1/1 divide */
+	};
+};
+
 &lvds0 {
 	status = "okay";
 
@@ -339,6 +410,17 @@
 		function = "pwm5";
 	};
 
+	sound_pins: sound {
+		groups = "ssi01239_ctrl", "ssi0_data", "ssi1_data";
+		function = "ssi";
+	};
+
+	sound_clk_pins: sound_clk {
+		groups = "audio_clk_a", "audio_clk_b_a", "audio_clk_c_a",
+			 "audio_clkout_a", "audio_clkout1_a";
+		function = "audio_clk";
+	};
+
 	usb0_pins: usb {
 		groups = "usb0_b", "usb0_id";
 		function = "usb0";
@@ -364,6 +446,47 @@
 	status = "okay";
 };
 
+&rcar_sound {
+	pinctrl-0 = <&sound_pins &sound_clk_pins>;
+	pinctrl-names = "default";
+
+	/* Single DAI */
+	#sound-dai-cells = <0>;
+
+	/* audio_clkout0/1/2/3 */
+	#clock-cells = <1>;
+	clock-frequency = <12288000 11289600>;
+	clkout-lr-synchronous;
+
+	status = "okay";
+
+	/* update <audio_clk_b> to <cs2000> */
+	clocks = <&cpg CPG_MOD 1005>,
+		 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
+		 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
+		 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
+		 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
+		 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
+		 <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
+		 <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
+		 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
+		 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
+		 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
+		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
+		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
+		 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
+		 <&audio_clk_a>, <&cs2000>, <&audio_clk_c>,
+		 <&cpg CPG_CORE R8A77990_CLK_ZA2>;
+
+	rcar_sound,dai {
+		dai0 {
+			playback = <&ssi0 &src0 &dvc0>;
+			capture  = <&ssi1 &src1 &dvc1>;
+		};
+	};
+
+};
+
 &rwdt {
 	timeout-sec = <60>;
 	status = "okay";
@@ -373,6 +496,10 @@
 	status = "okay";
 };
 
+&ssi1 {
+	shared-pin;
+};
+
 &usb2_phy0 {
 	pinctrl-0 = <&usb0_pins>;
 	pinctrl-names = "default";
-- 
2.11.0
