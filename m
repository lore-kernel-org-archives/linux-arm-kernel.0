From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 23 Apr 2014 20:00:49 +0530
Subject: [PATCH v5 7/9] dts: exynos5420-smdk5420: Add Vbus regulator for USB
 3.0
In-Reply-To: <1398263451-18023-1-git-send-email-gautam.vivek@samsung.com>
References: <1398263451-18023-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1398263451-18023-8-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add required fixed-regulator for VBUS supply for USB 3.0
controller phy.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---

This is first version of the patch for VBUS support for USB3DRD phy.
v5 is just and indicative of the patch-series.

 arch/arm/boot/dts/exynos5420-smdk5420.dts |   46 +++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 6910485..96d99e1 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -147,6 +147,52 @@
 		pinctrl-0 = <&hdmi_hpd_irq>;
 	};
 
+	pinctrl at 14000000 {
+		usb300_vbus_en: usb300-vbus-en {
+			samsung,pins = "gpg0-5";
+			samsung,pin-function = <1>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		usb301_vbus_en: usb301-vbus-en {
+			samsung,pins = "gpg1-4";
+			samsung,pin-function = <1>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+	};
+
+	usb300_vbus_reg: regulator-usb300 {
+		compatible = "regulator-fixed";
+		regulator-name = "VBUS0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpg0 5 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb300_vbus_en>;
+		enable-active-high;
+	};
+
+	usb301_vbus_reg: regulator-usb301 {
+		compatible = "regulator-fixed";
+		regulator-name = "VBUS1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpg1 4 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb301_vbus_en>;
+		enable-active-high;
+	};
+
+	phy at 12100000 {
+		vbus-supply = <&usb300_vbus_reg>;
+	};
+
+	phy at 12500000 {
+		vbus-supply = <&usb301_vbus_reg>;
+	};
+
 	i2c_2: i2c at 12C80000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
-- 
1.7.10.4
