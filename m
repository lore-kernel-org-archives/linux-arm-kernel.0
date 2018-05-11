From: samuel@sholland.org (Samuel Holland)
Date: Thu, 10 May 2018 22:01:24 -0500
Subject: [PATCH 2/2] arm64: dts: allwinner: h5: Update Orange Pi Zero Plus
In-Reply-To: <20180511030124.9356-1-samuel@sholland.org>
References: <20180511030124.9356-1-samuel@sholland.org>
Message-ID: <20180511030124.9356-2-samuel@sholland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Orange Pi Zero Plus has an additional LED that was missing from the
device tree, and the power sequence for the SDIO Wi-Fi was missing.

The board also has UARTs 1, 2, and 3 exposed on a 26-pin GPIO header. As
the header is not populated by the manufacturer, disable the UARTs by
default.

Additionally, fix up an incorrect comment, remove an unnecessary header
inclusion, sort existing nodes, and fix some indentation issues.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../dts/allwinner/sun50i-h5-orangepi-zero-plus.dts | 58 ++++++++++++++++------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
index 1238de25a969..78edcb9d9167 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
@@ -10,23 +10,18 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Xunlong Orange Pi Zero Plus";
 	compatible = "xunlong,orangepi-zero-plus", "allwinner,sun50i-h5";
 
-	reg_vcc3v3: vcc3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
 	aliases {
 		ethernet0 = &emac;
 		ethernet1 = &rtl8189ftv;
 		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
 	};
 
 	chosen {
@@ -38,7 +33,7 @@
 
 		pwr {
 			label = "orangepi:green:pwr";
-			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PA10 */
+			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
 			default-state = "on";
 		};
 
@@ -57,6 +52,18 @@
 		enable-active-high;
 		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
 	};
+
+	reg_vcc3v3: vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
+	};
 };
 
 &ehci0 {
@@ -92,6 +99,7 @@
 
 &mmc1 {
 	vmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
 	non-removable;
 	status = "okay";
@@ -105,7 +113,15 @@
 	};
 };
 
-&spi0  {
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&spi0 {
 	status = "okay";
 
 	flash at 0 {
@@ -117,18 +133,28 @@
 	};
 };
 
-&ohci0 {
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
 	status = "okay";
 };
 
-&ohci1 {
-	status = "okay";
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "disabled";
 };
 
-&uart0 {
+&uart2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
-	status = "okay";
+	pinctrl-0 = <&uart2_pins>;
+	status = "disabled";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+	status = "disabled";
 };
 
 &usb_otg {
-- 
2.16.1
