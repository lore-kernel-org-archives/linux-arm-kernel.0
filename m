From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 14 Jun 2018 13:30:38 +0200
Subject: [PATCH 3/4] arm64: dts: rockchip: move core edp from rk3399-kevin to
 shared chromebook
In-Reply-To: <20180614113039.29117-1-heiko@sntech.de>
References: <20180614113039.29117-1-heiko@sntech.de>
Message-ID: <20180614113039.29117-4-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bob needs the same backlight and core edp settings, so move these node to
the shared dtsi that both will use as a base.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   | 34 ++++++++++++++++
 .../boot/dts/rockchip/rk3399-gru-kevin.dts    | 39 ++-----------------
 2 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index 32139e6910a3..8cce0f59d2ea 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -191,6 +191,23 @@
 
 		vin-supply = <&pp1800_pcie>;
 	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
+				     17 18 19 20 21 22 23 24 25 26 27 28 29 30
+				     31 32 33 34 35 36 37 38 39 40 41 42 43 44
+				     45 46 47 48 49 50 51 52 53 54 55 56 57 58
+				     59 60 61 62 63 64 65 66 67 68 69 70 71 72
+				     73 74 75 76 77 78 79 80 81 82 83 84 85 86
+				     87 88 89 90 91 92 93 94 95 96 97 98 99 100>;
+		default-brightness-level = <51>;
+		enable-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
+		power-supply = <&pp3300_disp>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bl_en>;
+		pwm-delay-us = <10000>;
+	};
 };
 
 &ppvar_bigcpu {
@@ -212,6 +229,23 @@
 	extcon = <&usbc_extcon0>, <&usbc_extcon1>;
 };
 
+&edp {
+	status = "okay";
+
+	ports {
+		edp_out: port at 1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			edp_out_panel: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&panel_in_edp>;
+			};
+		};
+	};
+};
+
 ap_i2c_mic: &i2c1 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index e582ec9fbc97..2cc7c47d6a85 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -38,24 +38,6 @@
 		vin-supply = <&pp3300>;
 	};
 
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&cros_ec_pwm 1>;
-		brightness-levels = <0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
-				     17 18 19 20 21 22 23 24 25 26 27 28 29 30
-				     31 32 33 34 35 36 37 38 39 40 41 42 43 44
-				     45 46 47 48 49 50 51 52 53 54 55 56 57 58
-				     59 60 61 62 63 64 65 66 67 68 69 70 71 72
-				     73 74 75 76 77 78 79 80 81 82 83 84 85 86
-				     87 88 89 90 91 92 93 94 95 96 97 98 99 100>;
-		default-brightness-level = <51>;
-		enable-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
-		power-supply = <&pp3300_disp>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&bl_en>;
-		pwm-delay-us = <10000>;
-	};
-
 	edp_panel: edp-panel {
 		compatible = "sharp,lq123p1jx31", "simple-panel";
 		backlight = <&backlight>;
@@ -87,6 +69,10 @@
 	};
 };
 
+&backlight {
+	pwms = <&cros_ec_pwm 1>;
+};
+
 &gpio_keys {
 	pinctrl-names = "default";
 	pinctrl-0 = <&bt_host_wake_l>, <&cpu1_pen_eject>;
@@ -243,23 +229,6 @@ ap_i2c_dig: &i2c2 {
 	};
 };
 
-&edp {
-	status = "okay";
-
-	ports {
-		edp_out: port at 1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			edp_out_panel: endpoint at 0 {
-				reg = <0>;
-				remote-endpoint = <&panel_in_edp>;
-			};
-		};
-	};
-};
-
 &ppvar_bigcpu_pwm {
 	regulator-min-microvolt = <798674>;
 	regulator-max-microvolt = <1302172>;
-- 
2.17.0
