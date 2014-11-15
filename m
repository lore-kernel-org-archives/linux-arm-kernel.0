From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Sat, 15 Nov 2014 15:25:09 +0530
Subject: [PATCH V8 14/14] ARM: dts: peach-pit: represent the connection between
 bridge and panel using videoport and endpoints
In-Reply-To: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1416045309-13359-15-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define videoports and use endpoints to describe the connection between
the encoder, bridge and the panel, instead of using phandles.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts |   31 ++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 82cdb74..9d06aef 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -107,6 +107,12 @@
 		compatible = "auo,b116xw03";
 		power-supply = <&tps65090_fet6>;
 		backlight = <&backlight>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&bridge_out>;
+			};
+		};
 	};
 };
 
@@ -126,7 +132,14 @@
 	samsung,link-rate = <0x06>;
 	samsung,lane-count = <2>;
 	samsung,hpd-gpio = <&gpx2 6 0>;
-	bridge = <&ps8625>;
+
+	ports {
+		port at 0 {
+			dp_out: endpoint {
+				remote-endpoint = <&bridge_in>;
+			};
+		};
+	};
 };
 
 &fimd {
@@ -504,8 +517,22 @@
 		sleep-gpios = <&gpx3 5 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&gpy7 7 GPIO_ACTIVE_HIGH>;
 		lane-count = <2>;
-		panel = <&panel>;
 		use-external-pwm;
+
+		ports {
+			port at 0 {
+				bridge_out: endpoint {
+					remote-endpoint = <&panel_in>;
+				};
+			};
+
+			port at 1 {
+				bridge_in: endpoint {
+					remote-endpoint = <&dp_out>;
+				};
+			};
+		};
+
 	};
 };
 
-- 
1.7.9.5
