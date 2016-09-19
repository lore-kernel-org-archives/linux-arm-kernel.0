From: ayaka@soulik.info (Randy Li)
Date: Tue, 20 Sep 2016 03:02:50 +0800
Subject: [RFC PATCH v3 1/2] ARM: dts: samsung: add rga-lvds panel in itop elite
In-Reply-To: <1474311771-23321-1-git-send-email-ayaka@soulik.info>
References: <1474311771-23321-1-git-send-email-ayaka@soulik.info>
Message-ID: <1474311771-23321-2-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is actually a lvds panel connected through a rga-lvds bridge.
The touchscreen is communicated with i2c bus but the driver is not
support now.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 arch/arm/boot/dts/exynos4412-itop-elite.dts | 54 +++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
index b08705e..5153522 100644
--- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
+++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
@@ -138,6 +138,36 @@
 		assigned-clocks = <&clock CLK_MOUT_CAM0>;
 		assigned-clock-parents = <&clock CLK_XUSBXTI>;
 	};
+
+	vcc_sys_lcd: sys-lcd {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpl0 4 GPIO_ACTIVE_HIGH>;
+	};
+
+	panel: panel at 0 {
+		compatible = "chunghwa,claa070wp03xg";
+
+		power-supply = <&vcc_sys_lcd>;
+		enable-gpios = <&gpl0 2 GPIO_ACTIVE_HIGH>;
+		backlight = <&bl>;
+
+		port {
+			lcd_ep: endpoint {
+				remote-endpoint = <&rga_lvds>;
+			};
+		};
+	};
+
+	bl: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 1 5000000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <0 5 12 16 32 64 128 255>;
+		default-brightness-level = <5>;
+		power-supply = <&vcc_sys_lcd>;
+	};
 };
 
 &adc {
@@ -171,11 +201,31 @@
 	assigned-clock-rates = <0>, <176000000>;
 };
 
+&fimd {
+	pinctrl-0 = <&lcd_clk &lcd_data24>;
+	pinctrl-names = "default";
+	status = "okay";
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		port at 3 {
+			reg = <3>;
+			rga_lvds: endpoint {
+				remote-endpoint = <&lcd_ep>;
+			};
+		};
+	};
+};
+
 &hsotg {
 	dr_mode = "peripheral";
 	status = "okay";
 };
 
+&i2c_3 {
+	status = "okay";
+};
+
 &i2c_4 {
 	samsung,i2c-sda-delay = <100>;
 	samsung,i2c-slave-addr = <0x10>;
@@ -215,9 +265,9 @@
 
 &pwm {
 	status = "okay";
-	pinctrl-0 = <&pwm0_out>;
+	pinctrl-0 = <&pwm0_out &pwm1_out>;
 	pinctrl-names = "default";
-	samsung,pwm-outputs = <0>;
+	samsung,pwm-outputs = <0>, <1>;
 };
 
 &sdhci_2 {
-- 
2.7.4
