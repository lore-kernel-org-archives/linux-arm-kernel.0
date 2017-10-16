From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 16 Oct 2017 17:46:24 +0530
Subject: [PATCH 6/9] ARM: dts: rockchip: Add usb host for rk3288-vyasa
In-Reply-To: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
References: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1508156187-27519-7-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb host support for rk3288-vyasa, board support hub power
through phy_pwr_en and usb2 host power through usb2_pwr_en and
naming conversion followed as per schematic.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/rk3288-vyasa.dts     | 48 ++++++++++++++++++++++++++++++++++
 include/dt-bindings/pinctrl/rockchip.h |  1 +
 2 files changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index c79a4c7..c22d674 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -105,6 +105,30 @@
 		vin-supply = <&dc12_vbat>;
 	};
 
+	vsus_5v: vsus-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "vsus_5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc_io>;
+	};
+
+	vusb2_5v: vusb2-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "vusb2_5v";
+		enable-active-high;
+		gpio = <&gpio8 RK_PB1 GPIO_ACTIVE_HIGH>; /* USB2_PWR_EN */
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb2_pwr_en>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vsus_5v>;
+	};
+
 	ext_gmac: external-gmac-clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -363,6 +387,20 @@
 	status = "okay";
 };
 
+&usbphy {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&phy_pwr_en>;
+	status = "okay";
+};
+
 &vopb {
 	status = "okay";
 };
@@ -407,4 +445,14 @@
 			rockchip,pins = <RK_GPIO0 4 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
+
+	usb_host {
+		phy_pwr_en: phy-pwr-en {
+			rockchip,pins = <RK_GPIO2 RK_PB1 RK_FUNC_GPIO &pcfg_output_high>;
+		};
+
+		usb2_pwr_en: usb2-pwr-en {
+			rockchip,pins = <RK_GPIO8 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
diff --git a/include/dt-bindings/pinctrl/rockchip.h b/include/dt-bindings/pinctrl/rockchip.h
index aaec8ba..dc3d661 100644
--- a/include/dt-bindings/pinctrl/rockchip.h
+++ b/include/dt-bindings/pinctrl/rockchip.h
@@ -24,6 +24,7 @@
 #define RK_GPIO3	3
 #define RK_GPIO4	4
 #define RK_GPIO6	6
+#define RK_GPIO8	8
 
 #define RK_PA0		0
 #define RK_PA1		1
-- 
2.7.4
