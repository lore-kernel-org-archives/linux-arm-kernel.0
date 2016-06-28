From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 28 Jun 2016 12:51:18 +0800
Subject: [PATCH v1 3/5] ARM: dts: rockchip: add eDP/panel display device nodes
 for rk3288-evb
In-Reply-To: <1467089288-18355-1-git-send-email-ykk@rock-chips.com>
References: <1467089288-18355-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1467089478-18670-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default eDP panel on RK3288 EVB board is LG LP079QX1-SP0V TFT LCD,
we haven't declared the panel regulator in the 'panel-simple' device
node here, so the specific board like ACT8846 / RK8080 need to support
the panel power supply.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 arch/arm/boot/dts/rk3288-evb.dtsi | 43 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 963365d..f293c44 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -48,7 +48,7 @@
 		reg = <0x0 0x80000000>;
 	};
 
-	backlight {
+	backlight: backlight {
 		compatible = "pwm-backlight";
 		brightness-levels = <
 			  0   1   2   3   4   5   6   7
@@ -97,6 +97,20 @@
 		#clock-cells = <0>;
 	};
 
+	panel: panel {
+		compatible ="lg,lp079qx1-sp0v", "simple-panel";
+		backlight = <&backlight>;
+		enable-gpios = <&gpio7 4 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&lcd_cs>;
+		ports {
+			panel_in: port {
+				panel_in_edp: endpoint {
+					remote-endpoint = <&edp_out_panel>;
+				};
+			};
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
@@ -216,6 +230,27 @@
 	status = "okay";
 };
 
+&edp_phy {
+	status = "okay";
+};
+
+&edp {
+	force-hpd;
+	status = "okay";
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
 &i2c0 {
 	status = "okay";
 };
@@ -322,6 +357,12 @@
 			rockchip,pins = <0 6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	lcd {
+		lcd_cs: lcd-cs {
+			rockchip,pins = <7 4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &usbphy {
-- 
1.9.1
