From: m.purski@samsung.com (Maciej Purski)
Date: Wed, 30 May 2018 14:16:01 +0200
Subject: [PATCH v2 10/10] ARM: dts: exynos5250-arndale: add DSI and panel nodes
In-Reply-To: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
 <CGME20180530121630eucas1p1584c59b67815a65d0747afab214979ef@eucas1p1.samsung.com>
Message-ID: <1527682561-1386-11-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrzej Hajda <a.hajda@samsung.com>

The patch adds bridge and panel nodes.
It adds also DSI properties specific for arndale board and
regulators required by the bridge.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 61 ++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 7a8a5c5..816d89d 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -71,6 +71,17 @@
 		};
 	};
 
+	panel: panel {
+		compatible = "boe,hv070wsa-100";
+		power-supply = <&vcc_3v3_reg>;
+		enable-gpios = <&gpd1 3 GPIO_ACTIVE_HIGH>;
+		port {
+			panel_ep: endpoint {
+				remote-endpoint = <&bridge_out_ep>;
+			};
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -97,6 +108,30 @@
 			reg = <2>;
 			regulator-name = "hdmi-en";
 		};
+
+		vcc_1v2_reg: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "VCC_1V2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		vcc_1v8_reg: regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "VCC_1V8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vcc_3v3_reg: regulator at 5 {
+			compatible = "regulator-fixed";
+			reg = <5>;
+			regulator-name = "VCC_3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
 	};
 
 	fixed-rate-clocks {
@@ -119,6 +154,32 @@
 	cpu0-supply = <&buck2_reg>;
 };
 
+&dsi_0 {
+	vddcore-supply = <&ldo8_reg>;
+	vddio-supply = <&ldo10_reg>;
+	samsung,pll-clock-frequency = <24000000>;
+	samsung,burst-clock-frequency = <320000000>;
+	samsung,esc-clock-frequency = <10000000>;
+	status = "okay";
+
+	bridge at 0 {
+		reg = <0>;
+		compatible = "toshiba,tc358764";
+		vddc-supply = <&vcc_1v2_reg>;
+		vddio-supply = <&vcc_1v8_reg>;
+		vddlvds-supply = <&vcc_3v3_reg>;
+		reset-gpios = <&gpd1 6 GPIO_ACTIVE_LOW>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		port at 1 {
+			reg = <1>;
+			bridge_out_ep: endpoint {
+				remote-endpoint = <&panel_ep>;
+			};
+		};
+	};
+};
+
 &dp {
 	status = "okay";
 	samsung,color-space = <0>;
-- 
2.7.4
