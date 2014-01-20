From: olof@lixom.net (Olof Johansson)
Date: Sun, 19 Jan 2014 19:56:55 -0800
Subject: [PATCH 3/3] ARM: dts: exynos5250-snow: Enable wifi power-on
In-Reply-To: <1390190215-22700-1-git-send-email-olof@lixom.net>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
Message-ID: <1390190215-22700-4-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the required specifications of reset-gpios on snow to enable wifi.

The wifi module is always powered, but it has three more signals needed:
- Enable line (active high)
- Reset line (active low)
- 32kHz reference clock

The enable and reset lines are in practice quite similar (i.e. both
need to be 1 for the module to be enabled), so treat them both as
"reset gpios". The clock is specified using the new clock property on
MMC, which due to lack of append options right now has to duplicate the
first two clocks that are SoC generic.

Also, fix the pinctrl setting (that has moved from slot node to host
controller node), and add the two gpio lines to the pinctrl setup.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/boot/dts/exynos5250-cros-common.dtsi |   17 ++++++++++++++++-
 arch/arm/boot/dts/exynos5250-snow.dts         |   11 +++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
index 2c1560d..b72f342 100644
--- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
@@ -34,6 +34,20 @@
 			samsung,pin-pud = <0>;
 			samsung,pin-drv = <0>;
 		};
+
+		wifi_en: wifi-en {
+			samsung,pins = "gpx0-1";
+			samsung,pin-function = <1>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		wifi_rst: wifi-rst {
+			samsung,pins = "gpx0-2";
+			samsung,pin-function = <1>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
 	};
 
 	i2c at 12C60000 {
@@ -41,7 +55,7 @@
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <378000>;
 
-		max77686 at 09 {
+		pmic: max77686 at 09 {
 			compatible = "maxim,max77686";
 			interrupt-parent = <&gpx3>;
 			interrupts = <2 0>;
@@ -284,6 +298,7 @@
 		num-slots = <1>;
 		supports-highspeed;
 		broken-cd;
+		cap-sdio-irq;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 7e45eea..c150483 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -11,6 +11,7 @@
 /dts-v1/;
 #include "exynos5250.dtsi"
 #include "exynos5250-cros-common.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Google Snow";
@@ -186,9 +187,15 @@
 	 */
 	mmc at 12230000 {
 		status = "okay";
+		clocks = <&clock 280>, <&clock 139>, <&pmic 2>;
+		clock-names = "biu", "ciu", "card_ext_clock";
+		card-reset-gpios = <&gpx0 1 GPIO_ACTIVE_LOW>, /* WIFI_EN */
+				   <&gpx0 2 GPIO_ACTIVE_LOW>; /* WIFI_RSTn */
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4 &wifi_en &wifi_rst>;
 		slot at 0 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
+			reg = <0>;
+			bus-width = <4>;
 		};
 	};
 
-- 
1.7.10.4
