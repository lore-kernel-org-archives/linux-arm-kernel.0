From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 17 Jan 2017 20:34:04 +0530
Subject: [PATCH v2 2/2] arm64: dts: exynos: Add regulators for Vbus and
 Vbus-Boost
In-Reply-To: <1484665444-23365-1-git-send-email-pankaj.dubey@samsung.com>
References: <1484665444-23365-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170117150123epcas1p12709f99a0993ae58ea1fe294df5a12fe@epcas1p1.samsung.com>
Message-ID: <1484665444-23365-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vivek Gautam <gautamvivek1987@gmail.com>

Adding fixed voltage regulators for Vbus and Vbus-boost required
by USB 3.0 DRD controller on Exynos7-espresso board.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Vivek Gautam <gautamvivek1987@gmail.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 45 +++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index 9cf73cf..8d5abdd 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -13,6 +13,7 @@
 #include "exynos7.dtsi"
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/samsung,s2mps11.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Samsung Exynos7 Espresso board based on EXYNOS7";
@@ -33,6 +34,29 @@
 		device_type = "memory";
 		reg = <0x0 0x40000000 0x0 0xC0000000>;
 	};
+
+	usb30_vbus_reg: regulator-usb30 {
+		compatible = "regulator-fixed";
+		regulator-name = "VBUS_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gph1 1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb30_vbus_en>;
+		enable-active-high;
+	};
+
+	usb3drd_boost_5v: regulator-usb3drd-boost {
+		compatible = "regulator-fixed";
+		regulator-name = "VUSB_VBUS_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpf4 1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb3drd_boost_en>;
+		enable-active-high;
+	};
+
 };
 
 &fin_pll {
@@ -366,3 +390,24 @@
 	vqmmc-supply = <&ldo2_reg>;
 	disable-wp;
 };
+
+&usbdrd_phy {
+	vbus-supply = <&usb30_vbus_reg>;
+	vbus-boost-supply = <&usb3drd_boost_5v>;
+};
+
+&pinctrl_bus1 {
+	usb30_vbus_en: usb30-vbus-en {
+		samsung,pins = "gph1-1";
+		samsung,pin-function = <1>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	usb3drd_boost_en: usb3drd-boost-en {
+		samsung,pins = "gpf4-1";
+		samsung,pin-function = <1>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+};
-- 
2.7.4
