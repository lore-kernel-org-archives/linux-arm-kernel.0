From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:07 +0200
Subject: [PATCH 045/102] arm64: dts: renesas: salvator-common: use
 audio-graph-card for Sound
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <06a574c7ef69bd0bd26ed08e35967acb76622ab3.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current Sound is using simple-audio-card which can't support HDMI.
To use HDMI sound, we need to use audio-graph-card.
But, one note is that r8a7795 has 2 HDMI ports, but r8a7796 has 1.
Because of this mismatch, supporting HDMI on salvator-common is
impossible.
Thus, this patch exchange sound card to audio-graph-card and keep
supporting ak4613 as 1st sound node.
r8a7795/r8a7796 salvator-x{s} need to add HDMI sound individually.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 38 ++++++++++++++----------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 1642bc9c8906..9116f4caa3c6 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -93,20 +93,12 @@
 		regulator-always-on;
 	};
 
-	rsnd_ak4613: sound {
-		compatible = "simple-audio-card";
+	sound_card: sound {
+		compatible = "audio-graph-card";
 
-		simple-audio-card,format = "left_j";
-		simple-audio-card,bitclock-master = <&sndcpu>;
-		simple-audio-card,frame-master = <&sndcpu>;
+		label = "rcar-sound";
 
-		sndcpu: simple-audio-card,cpu {
-			sound-dai = <&rcar_sound>;
-		};
-
-		sndcodec: simple-audio-card,codec {
-			sound-dai = <&ak4613>;
-		};
+		dais = <&rsnd_port0>;
 	};
 
 	vbus0_usb2: regulator-vbus0-usb2 {
@@ -322,6 +314,12 @@
 		asahi-kasei,out4-single-end;
 		asahi-kasei,out5-single-end;
 		asahi-kasei,out6-single-end;
+
+		port {
+			ak4613_endpoint: endpoint {
+				remote-endpoint = <&rsnd_endpoint0>;
+			};
+		};
 	};
 
 	cs2000: clk_multiplier at 4f {
@@ -581,10 +579,18 @@
 		 <&audio_clk_c>,
 		 <&cpg CPG_CORE CPG_AUDIO_CLK_I>;
 
-	rcar_sound,dai {
-		dai0 {
-			playback = <&ssi0 &src0 &dvc0>;
-			capture  = <&ssi1 &src1 &dvc1>;
+	ports {
+		rsnd_port0: port at 0 {
+			rsnd_endpoint0: endpoint {
+				remote-endpoint = <&ak4613_endpoint>;
+
+				dai-format = "left_j";
+				bitclock-master = <&rsnd_endpoint0>;
+				frame-master = <&rsnd_endpoint0>;
+
+				playback = <&ssi0 &src0 &dvc0>;
+				capture  = <&ssi1 &src1 &dvc1>;
+			};
 		};
 	};
 };
-- 
2.11.0
