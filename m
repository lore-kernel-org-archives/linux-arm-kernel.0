From: shawnguo@kernel.org (Shawn Guo)
Date: Wed,  9 Aug 2017 14:30:49 +0800
Subject: [PATCH 08/10] arm64: dts: zx296718-evb: use audio-graph-card for HDMI
 audio
In-Reply-To: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
References: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1502260251-6316-9-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Instead of simple-audio-card, audio-graph-card is recommended for audio
bindings.  Let's change to it, so that the HDMI/SPDIF audio card can
align with the new I2S/Codec card which will be added later.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/zte/zx296718-evb.dts | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/zte/zx296718-evb.dts b/arch/arm64/boot/dts/zte/zx296718-evb.dts
index bb900d2bbcfb..d34d4cae38cd 100644
--- a/arch/arm64/boot/dts/zte/zx296718-evb.dts
+++ b/arch/arm64/boot/dts/zte/zx296718-evb.dts
@@ -57,17 +57,9 @@
 		reg = <0x40000000 0x40000000>;
 	};
 
-	sound0 {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "zx_snd_spdif0";
-
-		simple-audio-card,cpu {
-			sound-dai = <&spdif0>;
-		};
-
-		simple-audio-card,codec {
-			sound-dai = <&hdmi>;
-		};
+	sound-spdif0 {
+		compatible = "audio-graph-card";
+		dais = <&spdif0_port>;
 	};
 };
 
@@ -77,6 +69,12 @@
 
 &hdmi {
 	status = "okay";
+
+	port {
+		hdmi_endpoint: endpoint {
+			remote-endpoint = <&spdif0_endpoint>;
+		};
+	};
 };
 
 &sd1 {
@@ -85,6 +83,12 @@
 
 &spdif0 {
 	status = "okay";
+
+	spdif0_port: port {
+		spdif0_endpoint: endpoint {
+			remote-endpoint = <&hdmi_endpoint>;
+		};
+	};
 };
 
 &uart0 {
-- 
1.9.1
