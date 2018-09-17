From: katsuhiro@katsuster.net (Katsuhiro Suzuki)
Date: Mon, 17 Sep 2018 21:26:33 +0900
Subject: [PATCH v2] arm64: dts: rockchip: add spdif sound node for rock64
Message-ID: <20180917122633.31401-1-katsuhiro@katsuster.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds sound card node for rock64. Currently we can support
S/PDIF only. It seems the lack of codec driver of rk3328 to enable
analog audio out.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 5852061e497b..9ee4f57557f3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -62,6 +62,23 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 	};
+
+	sound {
+		compatible = "audio-graph-card";
+		label = "rockchip,rk3328";
+		dais = <&spdif_p0>;
+	};
+
+	spdif-dit {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+
+		port {
+			dit_p0_0: endpoint {
+				remote-endpoint = <&spdif_p0_0>;
+			};
+		};
+	};
 };
 
 &cpu0 {
@@ -261,6 +278,18 @@
 	status = "okay";
 };
 
+&spdif {
+	pinctrl-0 = <&spdifm0_tx>;
+	status = "okay";
+	#sound-dai-cells = <0>;
+
+	spdif_p0: port {
+		spdif_p0_0: endpoint {
+			remote-endpoint = <&dit_p0_0>;
+		};
+	};
+};
+
 &tsadc {
 	rockchip,hw-tshut-mode = <0>;
 	rockchip,hw-tshut-polarity = <0>;
-- 
2.18.0
