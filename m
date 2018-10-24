From: sebastien.szymanski@armadeus.com (=?UTF-8?q?S=C3=A9bastien=20Szymanski?=)
Date: Wed, 24 Oct 2018 14:54:57 +0200
Subject: [RESEND PATCH 2/2] ARM: dts: opos6uldev: use OF graph to describe the
 display
In-Reply-To: <20181024125457.25204-1-sebastien.szymanski@armadeus.com>
References: <20181024125457.25204-1-sebastien.szymanski@armadeus.com>
Message-ID: <20181024125457.25204-2-sebastien.szymanski@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To make use of the new eLCDIF DRM driver OF graph description is
required. Describe the display using OF graph nodes.

Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/boot/dts/imx6ul-opos6uldev.dts | 37 ++++++++++++++-------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-opos6uldev.dts b/arch/arm/boot/dts/imx6ul-opos6uldev.dts
index 0e59ee57fd55..8ecdb9ad2b2e 100644
--- a/arch/arm/boot/dts/imx6ul-opos6uldev.dts
+++ b/arch/arm/boot/dts/imx6ul-opos6uldev.dts
@@ -56,7 +56,7 @@
 		stdout-path = &uart1;
 	};
 
-	backlight {
+	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm3 0 191000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
@@ -97,6 +97,18 @@
 		gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
 	};
 
+	panel: panel {
+		compatible = "armadeus,st0700-adapt";
+		power-supply = <&reg_3v3>;
+		backlight = <&backlight>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lcdif_out>;
+			};
+		};
+	};
+
 	reg_5v: regulator-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "5V";
@@ -182,28 +194,11 @@
 &lcdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcdif>;
-	display = <&display0>;
-	lcd-supply = <&reg_3v3>;
 	status = "okay";
 
-	display0: display0 {
-		bits-per-pixel = <32>;
-		bus-width = <18>;
-
-		display-timings {
-			timing0: timing0 {
-				clock-frequency = <33000033>;
-				hactive = <800>;
-				vactive = <480>;
-				hback-porch = <96>;
-				hfront-porch = <96>;
-				vback-porch = <20>;
-				vfront-porch = <21>;
-				hsync-len = <64>;
-				vsync-len = <4>;
-				de-active = <1>;
-				pixelclk-active = <0>;
-			};
+	port {
+		lcdif_out: endpoint {
+			remote-endpoint = <&panel_in>;
 		};
 	};
 };
-- 
2.16.4
