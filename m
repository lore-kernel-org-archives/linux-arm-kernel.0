From: brian.kim@hardkernel.com (Brian Kim)
Date: Mon,  6 Mar 2017 11:52:09 +0900
Subject: [PATCH] ARM: dts: exynos: Add power button for Odroid XU3/4
Message-ID: <1488768729-9435-1-git-send-email-brian.kim@hardkernel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The power button on Odroid XU3/4 is connected with the PWRON pin of
s2mps11 PMIC. The s2mps11 sends low signal to GPIO input in exynos 5422
via ONOB pin.

This patch adds devicetree bindings for the power button of Odroid
XU3/4.

Signed-off-by: Brian Kim <brian.kim@hardkernel.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 05b9afdd..671d87f 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -13,6 +13,7 @@
 */
 
 #include <dt-bindings/clock/samsung,s2mps11.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/sound/samsung-i2s.h>
@@ -42,6 +43,22 @@
 		};
 	};
 
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_power_key>;
+
+		power_key {
+			interrupt-parent = <&gpx0>;
+			interrupts = <3 0>;
+			gpios = <&gpx0 3 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			label = "power key";
+			debounce-interval = <10>;
+			wakeup-source;
+		};
+	};
+
 	emmc_pwrseq: pwrseq {
 		pinctrl-0 = <&emmc_nrst_pin>;
 		pinctrl-names = "default";
@@ -557,6 +574,11 @@
 };
 
 &pinctrl_0 {
+	gpio_power_key: power_key {
+		samsung,pins = "gpx0-3";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
 	hdmi_hpd_irq: hdmi-hpd-irq {
 		samsung,pins = "gpx3-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
-- 
2.7.4
