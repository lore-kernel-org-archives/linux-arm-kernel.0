From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:12 +0200
Subject: [PATCH 050/102] arm64: dts: renesas: r8a7796-salvator-x: enable HDMI
 sound
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <5c29ba526ca8f4e34a3f2935651f1ab4592c03a3.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index 498c9e807dc4..90cca09b9a5e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -40,6 +40,11 @@
 		      "dclkin.0", "dclkin.1", "dclkin.2";
 };
 
+&sound_card {
+	dais = <&rsnd_port0	/* ak4613 */
+		&rsnd_port1>;	/* HDMI0  */
+};
+
 &hdmi0 {
 	status = "okay";
 
@@ -50,9 +55,32 @@
 				remote-endpoint = <&hdmi0_con>;
 			};
 		};
+		port at 2 {
+			reg = <2>;
+			dw_hdmi0_snd_in: endpoint {
+				remote-endpoint = <&rsnd_endpoint1>;
+			};
+		};
 	};
 };
 
 &hdmi0_con {
 	remote-endpoint = <&rcar_dw_hdmi0_out>;
 };
+
+&rcar_sound {
+	ports {
+		/* rsnd_port0 is on salvator-common */
+		rsnd_port1: port at 1 {
+			rsnd_endpoint1: endpoint {
+				remote-endpoint = <&dw_hdmi0_snd_in>;
+
+				dai-format = "i2s";
+				bitclock-master = <&rsnd_endpoint1>;
+				frame-master = <&rsnd_endpoint1>;
+
+				playback = <&ssi2>;
+			};
+		};
+	};
+};
-- 
2.11.0
