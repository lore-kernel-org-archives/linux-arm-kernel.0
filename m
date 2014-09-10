From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 10 Sep 2014 20:46:52 +0200
Subject: [PATCH 3/6] ARM: dts: rockchip: enable usb ports on Radxa Rock
In-Reply-To: <1410374815-20208-1-git-send-email-heiko@sntech.de>
References: <1410374815-20208-1-git-send-email-heiko@sntech.de>
Message-ID: <1410374815-20208-4-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables both the otg and host port and adds the vbus regulators
on the Radxa Rock board. As we don't have phy support yet, the vbus
regulators are added in always-on mode.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3188-radxarock.dts | 43 ++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index ff35acfa..1be0c34 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -65,6 +65,19 @@
 		pinctrl-0 = <&ir_recv_pin>;
 	};
 
+	vcc_otg: usb-otg-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&host_vbus_drv>;
+		regulator-name = "otg-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vcc_sd0: sdmmc-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "sdmmc-supply";
@@ -74,6 +87,19 @@
 		startup-delay-us = <100000>;
 		vin-supply = <&vcc_io>;
 	};
+
+	vcc_host: usb-host-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&otg_vbus_drv>;
+		regulator-name = "host-pwr";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &i2c1 {
@@ -218,6 +244,15 @@
 			rockchip,pins = <RK_GPIO0 10 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	usb {
+		host_vbus_drv: host-vbus-drv {
+			rockchip,pins = <0 3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+		otg_vbus_drv: otg-vbus-drv {
+			rockchip,pins = <2 31 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &uart0 {
@@ -236,6 +271,14 @@
 	status = "okay";
 };
 
+&usb_host {
+	status = "okay";
+};
+
+&usb_otg {
+	status = "okay";
+};
+
 &wdt {
 	status = "okay";
 };
-- 
2.0.1
