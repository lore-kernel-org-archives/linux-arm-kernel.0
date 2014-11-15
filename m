From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Sat, 15 Nov 2014 15:25:08 +0530
Subject: [PATCH V8 13/14] ARM: dts: snow: represent the connection between
 bridge and panel using videoport and endpoints
In-Reply-To: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1416045309-13359-14-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define videoports and use endpoints to describe the connection between
the encoder, bridge and the panel, instead of using phandles.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 arch/arm/boot/dts/exynos5250-snow.dts |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index e51fcef..877117f 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -254,7 +254,20 @@
 			powerdown-gpios = <&gpy2 5 GPIO_ACTIVE_HIGH>;
 			reset-gpios = <&gpx1 5 GPIO_ACTIVE_HIGH>;
 			edid-emulation = <5>;
-			panel = <&panel>;
+
+			ports {
+				port at 0 {
+					bridge_out: endpoint {
+						remote-endpoint = <&panel_in>;
+					};
+				};
+
+				port at 1 {
+					bridge_in: endpoint {
+						remote-endpoint = <&dp_out>;
+					};
+				};
+			};
 		};
 	};
 
@@ -328,6 +341,12 @@
 		compatible = "auo,b116xw03";
 		power-supply = <&fet6>;
 		backlight = <&backlight>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&bridge_out>;
+			};
+		};
 	};
 
 	dp-controller at 145B0000 {
@@ -341,7 +360,14 @@
 		samsung,link-rate = <0x0a>;
 		samsung,lane-count = <2>;
 		samsung,hpd-gpio = <&gpx0 7 0>;
-		bridge = <&ptn3460>;
+
+		ports {
+			port at 0 {
+				dp_out: endpoint {
+					remote-endpoint = <&bridge_in>;
+				};
+			};
+		};
 	};
 };
 
-- 
1.7.9.5
