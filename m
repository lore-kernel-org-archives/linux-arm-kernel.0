From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 21 Feb 2018 09:55:39 +0100
Subject: [PATCH v4 4/6] arm64: dts: exynos: add OF graph between MHL and USB
 connector
In-Reply-To: <20180221085541.14556-1-a.hajda@samsung.com>
References: <20180221085541.14556-1-a.hajda@samsung.com>
 <CGME20180221085607eucas1p1a08c82fac832049d79705b4222422fa9@eucas1p1.samsung.com>
Message-ID: <20180221085541.14556-5-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OF graph describes MHL data lanes between MHL and respective USB
connector.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
v4:
- added missing reg property in connector's port node (Krzysztof)
---
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 32 ++++++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index f604f6b1a9c2..2ed506df94d0 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -817,9 +817,22 @@
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
@@ -842,6 +855,19 @@
 					     "usb-b-connector";
 				label = "micro-USB";
 				type = "micro";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port at 3 {
+						reg = <3>;
+						musb_con_to_mhl: endpoint {
+							remote-endpoint = <&mhl_to_musb_con>;
+						};
+					};
+				};
+			};
 			};
 		};
 
-- 
2.16.1
