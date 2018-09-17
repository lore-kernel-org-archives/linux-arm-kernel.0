From: katsuhiro@katsuster.net (Katsuhiro Suzuki)
Date: Mon, 17 Sep 2018 18:02:36 +0900
Subject: [PATCH] arm64: dts: rockchip: add spdif sound node for rock64
Message-ID: <20180917090236.21948-1-katsuhiro@katsuster.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds sound card node for rock64. Currently we can support
S/PDIF only. It seems the lack of codec driver of rk3328 to enable
analog audio out.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

---

NOTE: This patch depends on
[PATCH v2] arm64: dts: rockchip: add i2s and spdif endpoints of rk3328

---
 .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 5852061e497b..27c73325aee8 100644
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
+		port at 0 {
+			dit_p0_0: endpoint {
+				remote-endpoint = <&spdif_p0_0>;
+			};
+		};
+	};
 };
 
 &cpu0 {
@@ -261,6 +278,15 @@
 	status = "okay";
 };
 
+&spdif {
+	pinctrl-0 = <&spdifm0_tx>;
+	status = "okay";
+};
+
+&spdif_p0_0 {
+	remote-endpoint = <&dit_p0_0>;
+};
+
 &tsadc {
 	rockchip,hw-tshut-mode = <0>;
 	rockchip,hw-tshut-polarity = <0>;
-- 
2.18.0
