From: shawnguo@kernel.org (Shawn Guo)
Date: Wed,  9 Aug 2017 14:30:50 +0800
Subject: [PATCH 09/10] arm64: dts: zx296718-evb: add I2S sound card support
In-Reply-To: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
References: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1502260251-6316-10-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It enables the I2S sound card support, which is used to drive audio
through aud96p22 codec in case of TV output.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/zte/zx296718-evb.dts | 48 ++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/zte/zx296718-evb.dts b/arch/arm64/boot/dts/zte/zx296718-evb.dts
index d34d4cae38cd..cb2519ecd724 100644
--- a/arch/arm64/boot/dts/zte/zx296718-evb.dts
+++ b/arch/arm64/boot/dts/zte/zx296718-evb.dts
@@ -61,6 +61,26 @@
 		compatible = "audio-graph-card";
 		dais = <&spdif0_port>;
 	};
+
+	sound-i2s0 {
+		compatible = "audio-graph-card";
+		dais = <&i2s0_port>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&amplifier_pins>;
+		pa-gpios = <&bgpio4 0 GPIO_ACTIVE_HIGH>;
+		widgets = "Line", "Line Out Jack";
+		routing = "Amplifier", "LINEOUTL",
+			  "Amplifier", "LINEOUTR",
+			  "Line Out Jack", "Amplifier";
+	};
+};
+
+&aud96p22 {
+	port {
+		aud96p22_endpoint: endpoint {
+			remote-endpoint = <&i2s0_endpoint>;
+		};
+	};
 };
 
 &emmc {
@@ -77,6 +97,30 @@
 	};
 };
 
+&i2c0 {
+	status = "okay";
+};
+
+&i2s0 {
+	status = "okay";
+
+	i2s0_port: port {
+		i2s0_endpoint: endpoint {
+			remote-endpoint = <&aud96p22_endpoint>;
+			dai-format = "i2s";
+			frame-master;
+			bitclock-master;
+		};
+	};
+};
+
+&pmm {
+	amplifier_pins: amplifier {
+		pins = "TSI3_DATA";
+		function = "BGPIO";
+	};
+};
+
 &sd1 {
 	status = "okay";
 };
@@ -91,6 +135,10 @@
 	};
 };
 
+&tvenc {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
1.9.1
