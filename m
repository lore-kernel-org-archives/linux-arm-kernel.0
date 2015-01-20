From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Tue, 20 Jan 2015 22:08:54 +0530
Subject: [PATCH V9 13/14] ARM: dts: snow: represent the connection between
 bridge and panel using videoport and endpoints
In-Reply-To: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1421771935-31618-14-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define videoports and use endpoints to describe the connection between
the encoder, bridge and the panel, instead of using phandles.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
Tested-by: Rahul Sharma <rahul.sharma@samsung.com>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Tested-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5250-snow.dts |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index b9aeec4..1bd5d3a 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -183,7 +183,20 @@
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
 
@@ -228,6 +241,12 @@
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
 };
 
@@ -242,7 +261,14 @@
 	samsung,link-rate = <0x0a>;
 	samsung,lane-count = <2>;
 	samsung,hpd-gpio = <&gpx0 7 GPIO_ACTIVE_HIGH>;
-	bridge = <&ptn3460>;
+
+	ports {
+		port at 0 {
+			dp_out: endpoint {
+				remote-endpoint = <&bridge_in>;
+			};
+		};
+	};
 };
 
 &ehci {
-- 
1.7.9.5
