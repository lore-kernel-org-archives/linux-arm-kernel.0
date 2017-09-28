From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 28 Sep 2017 15:07:28 +0200
Subject: [RFC PATCH 2/4] arm64: dts: exynos: add micro-USB connector node to
 TM2 platforms
In-Reply-To: <20170928130730.8747-1-a.hajda@samsung.com>
References: <20170928130730.8747-1-a.hajda@samsung.com>
 <CGME20170928130735eucas1p1298c683dcd7ab5f3ae7a5e19295d2a03@eucas1p1.samsung.com>
Message-ID: <20170928130730.8747-3-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since USB connector bindings are available we can describe it on TM2(e).

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 47 ++++++++++++++++++++--
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index e30bae4cf878..39b1ca0ef4cd 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -135,6 +135,28 @@
 			"RCV", "HPOUT3R";
 		status = "okay";
 	};
+
+	musb_con: musb_connector {
+		compatible = "samsung,usb-connector-11pin", "usb-connector";
+		label = "micro-usb";
+		type = "b";
+		size = "micro";
+		max-mode = "hs";
+
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			musb_con_to_muic: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&muic_to_musb_con>;
+			};
+			musb_con_to_mhl: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint = <&mhl_to_musb_con>;
+			};
+		};
+	};
 };
 
 &adc {
@@ -768,9 +790,22 @@
 		clocks = <&pmu_system_controller 0>;
 		clock-names = "xtal";
 
-		port {
-			mhl_to_hdmi: endpoint {
-				remote-endpoint = <&hdmi_to_mhl>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				mhl_to_hdmi: endpoint {
+					remote-endpoint = <&hdmi_to_mhl>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+				mhl_to_musb_con: endpoint {
+					remote-endpoint = <&musb_con_to_mhl>;
+				};
 			};
 		};
 	};
@@ -787,6 +822,12 @@
 
 		muic: max77843-muic {
 			compatible = "maxim,max77843-muic";
+
+			port {
+				muic_to_musb_con: endpoint at 0 {
+					remote-endpoint = <&musb_con_to_muic>;
+				};
+			};
 		};
 
 		regulators {
-- 
2.14.1
