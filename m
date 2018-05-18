From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:11 +0200
Subject: [PATCH 049/102] arm64: dts: renesas: r8a7795-salvator-x: enable HDMI
 sound
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <a4ff9aed55eb0172291005f0b1a0174be257b892.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index af467419266a..0efbef5ea9b7 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -56,6 +56,12 @@
 	status = "okay";
 };
 
+&sound_card {
+	dais = <&rsnd_port0	/* ak4613 */
+		&rsnd_port1	/* HDMI0  */
+		&rsnd_port2>;	/* HDMI1  */
+};
+
 &hdmi0 {
 	status = "okay";
 
@@ -66,6 +72,12 @@
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
 
@@ -83,6 +95,12 @@
 				remote-endpoint = <&hdmi1_con>;
 			};
 		};
+		port at 2 {
+			reg = <2>;
+			dw_hdmi1_snd_in: endpoint {
+				remote-endpoint = <&rsnd_endpoint2>;
+			};
+		};
 	};
 };
 
@@ -94,6 +112,34 @@
 	status = "okay";
 };
 
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
+		rsnd_port2: port at 2 {
+			rsnd_endpoint2: endpoint {
+				remote-endpoint = <&dw_hdmi1_snd_in>;
+
+				dai-format = "i2s";
+				bitclock-master = <&rsnd_endpoint2>;
+				frame-master = <&rsnd_endpoint2>;
+
+				playback = <&ssi3>;
+			};
+		};
+	};
+};
+
 &pfc {
 	usb2_pins: usb2 {
 		groups = "usb2";
-- 
2.11.0
