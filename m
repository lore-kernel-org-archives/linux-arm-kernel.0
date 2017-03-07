From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  7 Mar 2017 11:40:22 +0100
Subject: [PATCH] ARM64: dts: meson-gx: Add Buttons to Q200 and P230 boards
Message-ID: <1488883222-23320-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the P230 and Q200 ADC laddered button and
GPIO button.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-gxl-s905d-p230.dts      | 40 ++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts     | 40 ++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
index f66939c..a97d17d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
@@ -43,12 +43,47 @@
 
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
+
 #include "meson-gxl-s905d.dtsi"
 #include "meson-gx-p23x-q20x.dtsi"
 
 / {
 	compatible = "amlogic,p230", "amlogic,s905d", "amlogic,meson-gxl";
 	model = "Amlogic Meson GXL (S905D) P230 Development Board";
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1710000>;
+
+		button-function {
+			label = "Update";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <10000>;
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <100>;
+
+		button at 0 {
+			label = "power";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
 };
 
 /* P230 has exclusive choice between internal or external PHY */
@@ -75,3 +110,8 @@
 		max-speed = <1000>;
 	};
 };
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_ao18>;
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts
index 5dbc660..a2f2908 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts
@@ -43,12 +43,47 @@
 
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
+
 #include "meson-gxm.dtsi"
 #include "meson-gx-p23x-q20x.dtsi"
 
 / {
 	compatible = "amlogic,q200", "amlogic,s912", "amlogic,meson-gxm";
 	model = "Amlogic Meson GXM (S912) Q200 Development Board";
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1710000>;
+
+		button-function {
+			label = "Update";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <10000>;
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <100>;
+
+		button at 0 {
+			label = "power";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
 };
 
 /* Q200 has exclusive choice between internal or external PHY */
@@ -75,3 +110,8 @@
 		max-speed = <1000>;
 	};
 };
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_ao18>;
+};
-- 
1.9.1
