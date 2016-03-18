From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 18 Mar 2016 02:40:06 +0100
Subject: [PATCH 10/10] ARM: dts: rockchip: enable the eDP on rk3288 veyron
 devices
In-Reply-To: <1458265206-15733-1-git-send-email-heiko@sntech.de>
References: <1458265206-15733-1-git-send-email-heiko@sntech.de>
Message-ID: <1458265206-15733-11-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After hooking up panel and backlight informations, enable the
edp on veyron chromebooks now.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 43 +++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index 7563d3d..2958c36 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -111,6 +111,14 @@
 		status = "okay";
 		power-supply = <&vcc33_lcd>;
 		backlight = <&backlight>;
+
+		ports {
+			panel_in: port {
+				panel_in_edp: endpoint {
+					remote-endpoint = <&edp_out_panel>;
+				};
+			};
+		};
 	};
 
 	/* A non-regulated voltage from power supply or battery */
@@ -154,6 +162,29 @@
 	};
 };
 
+&edp {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&edp_hpd>;
+
+	ports {
+		edp_out: port at 1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			edp_out_panel: endpoint {
+				reg = <0>;
+				remote-endpoint = <&panel_in_edp>;
+			};
+		};
+	};
+};
+
+&edp_phy {
+	status = "okay";
+};
+
 &gpio_keys {
 	pinctrl-0 = <&pwr_key_l &ap_lid_int_l>;
 	lid {
@@ -166,6 +197,10 @@
 	};
 };
 
+&pwm0 {
+	status = "okay";
+};
+
 &rk808 {
 	vcc11-supply = <&vcc_5v>;
 
@@ -219,6 +254,14 @@
 	};
 };
 
+&vopl {
+	status = "okay";
+};
+
+&vopl_mmu {
+	status = "okay";
+};
+
 &pinctrl {
 	pinctrl-0 = <
 		/* Common for sleep and wake, but no owners */
-- 
2.6.4
