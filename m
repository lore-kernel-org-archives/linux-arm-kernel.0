From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:10 +0900
Subject: [PATCH 02/10] arm64: renesas: salvator-x: use CS2000 as AUDIO_CLK_B
In-Reply-To: <cover.1450401186.git.horms+renesas@verge.net.au>
References: <cover.1450401186.git.horms+renesas@verge.net.au>
Message-ID: <8a8f181d2cfdbff772ff2cc895f59bb28beafbdf.1450401186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

CS2000 needs AUDIO_CLKOUT as master clock which is generated
by Renesas sound, and Renesas sound needs CS2000 as ADUIO_CLK_B.
Because of this relationship, it will be dead-lock when driver probe.

cs2000: clk_multiplier at 4f {
        ...
        clocks = <&rcar_sound 0>, <&x12_clk>;
        ...
};

&rcar_sound {
        ...
        assigned-clocks = <&cs2000>;
        ...
};

This patch is using dummy audio_clkout to avoid this issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index beeacfaf18d0..75af5ec5a4d4 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -61,6 +61,16 @@
 		clock-frequency = <24576000>;
 	};
 
+	audio_clkout: audio_clkout {
+		/*
+		 * This is same as <&rcar_sound 0>
+		 * but needed to avoid cs2000/rcar_sound probe dead-lock
+		 */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <11289600>;
+	};
+
 	rsnd_ak4613: sound {
 		compatible = "simple-audio-card";
 
@@ -151,6 +161,17 @@
 		asahi-kasei,out5-single-end;
 		asahi-kasei,out6-single-end;
 	};
+
+	cs2000: clk_multiplier at 4f {
+		#clock-cells = <0>;
+		compatible = "cirrus,cs2000-cp";
+		reg = <0x4f>;
+		clocks = <&audio_clkout>, <&x12_clk>;
+		clock-names = "clk_in", "ref_clk";
+
+		assigned-clocks = <&cs2000>;
+		assigned-clock-rates = <24576000>; /* 1/1 divide */
+	};
 };
 
 &rcar_sound {
@@ -166,6 +187,23 @@
 
 	status = "okay";
 
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
+		 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
+		 <&audio_clk_a>, <&cs2000>,
+		 <&audio_clk_c>,
+		 <&cpg CPG_CORE R8A7795_CLK_S0D4>;
+
 	rcar_sound,dai {
 		dai0 {
 			playback = <&ssi0 &src0 &dvc0>;
-- 
2.1.4
