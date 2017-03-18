From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 18 Mar 2017 15:37:28 +0100
Subject: [RFT PATCH 1/1] ARM64: dts: meson-gxbb: convert devices to use
 pwm-leds
In-Reply-To: <20170318143728.16535-1-martin.blumenstingl@googlemail.com>
References: <20170318143728.16535-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170318143728.16535-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All supported GXBB devices have their system LED connected to GPIOAO_13.
This pin can be driven by the PWM_AO controller (PWM_AO_B). Use the
pwm-leds driver (instead of gpio-leds) for these LEDs instead to enable
dimming (setting the brightness).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 18 +++++++++++----
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 16 ++++++++++---
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      | 17 ++++++++++----
 .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts      | 19 +++++++++++----
 .../boot/dts/amlogic/meson-gxbb-wetek-play2.dts    | 27 ++++++++++++++++------
 5 files changed, 74 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index dbfa441f479e..283dad3b0be3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -65,12 +65,14 @@
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
 
-	leds {
-		compatible = "gpio-leds";
+	pwmleds {
+		compatible = "pwm-leds";
+
 		blue {
 			label = "a95x:system-status";
-			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "heartbeat";
+			pwms = <&pwm_AO_ab 1 7812500 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
 			default-state = "off";
 		};
 	};
@@ -249,6 +251,14 @@
 	vqmmc-supply = <&vddio_boot>;
 };
 
+&pwm_AO_ab {
+	status = "okay";
+	pinctrl-0 = <&pwm_ao_b_pins>;
+	pinctrl-names = "default";
+	clocks = <&clkc CLKID_FCLK_DIV4>;
+	clock-names = "clkin0";
+};
+
 &pwm_ef {
 	status = "okay";
 	pinctrl-0 = <&pwm_e_pins>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index c80d3a913907..7f9de1b236ed 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -76,11 +76,13 @@
 		enable-active-high;
 	};
 
-	leds {
-		compatible = "gpio-leds";
+	pwmleds {
+		compatible = "pwm-leds";
+
 		blue {
 			label = "c2:blue:alive";
-			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_LOW>;
+			pwms = <&pwm_AO_ab 1 7812500 0>;
+			max-brightness = <255>;
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
@@ -201,6 +203,14 @@
 	status = "okay";
 };
 
+&pwm_AO_ab {
+	status = "okay";
+	pinctrl-0 = <&pwm_ao_b_pins>;
+	pinctrl-names = "default";
+	clocks = <&clkc CLKID_FCLK_DIV4>;
+	clock-names = "clkin0";
+};
+
 /* SD */
 &sd_emmc_b {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index aefa66dff72d..6b9608e5a488 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -53,13 +53,14 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	leds {
-		compatible = "gpio-leds";
+	pwmleds {
+		compatible = "pwm-leds";
 
 		blue {
 			label = "vega-s95:blue:on";
-			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
+			pwms = <&pwm_AO_ab 1 7812500 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
 			panic-indicator;
 		};
 	};
@@ -229,6 +230,14 @@
 	vmmcq-sumpply = <&vcc_1v8>;
 };
 
+&pwm_AO_ab {
+	status = "okay";
+	pinctrl-0 = <&pwm_ao_b_pins>;
+	pinctrl-names = "default";
+	clocks = <&clkc CLKID_FCLK_DIV4>;
+	clock-names = "clkin0";
+};
+
 &pwm_ef {
 	status = "okay";
 	pinctrl-0 = <&pwm_e_pins>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
index f057fb48fee5..1d94e2d4c927 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
@@ -49,13 +49,14 @@
 	compatible = "wetek,hub", "amlogic,meson-gxbb";
 	model = "WeTek Hub";
 
-	leds {
-		compatible = "gpio-leds";
+	pwmleds {
+		compatible = "pwm-leds";
 
 		system {
-			label = "wetek-play:system-status";
-			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
+			label = "wetek-hub:system-status";
+			pwms = <&pwm_AO_ab 1 7812500 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
 			panic-indicator;
 		};
 	};
@@ -90,3 +91,11 @@
 		};
 	};
 };
+
+&pwm_AO_ab {
+	status = "okay";
+	pinctrl-0 = <&pwm_ao_b_pins>;
+	pinctrl-names = "default";
+	clocks = <&clkc CLKID_FCLK_DIV4>;
+	clock-names = "clkin0";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
index 743acb5f5d06..5114d645d733 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
@@ -53,13 +53,6 @@
 	leds {
 		compatible = "gpio-leds";
 
-		system {
-			label = "wetek-play:system-status";
-			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-			panic-indicator;
-		};
-
 		wifi {
 			label = "wetek-play:wifi-status";
 			gpios = <&gpio GPIODV_26 GPIO_ACTIVE_HIGH>;
@@ -73,6 +66,18 @@
 		};
 	};
 
+	pwmleds {
+		compatible = "pwm-leds";
+
+		system {
+			label = "wetek-play:system-status";
+			pwms = <&pwm_AO_ab 1 7812500 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
+			panic-indicator;
+		};
+	};
+
 	gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		#address-cells = <1>;
@@ -118,3 +123,11 @@
 	pinctrl-0 = <&i2c_a_pins>;
 	pinctrl-names = "default";
 };
+
+&pwm_AO_ab {
+	status = "okay";
+	pinctrl-0 = <&pwm_ao_b_pins>;
+	pinctrl-names = "default";
+	clocks = <&clkc CLKID_FCLK_DIV4>;
+	clock-names = "clkin0";
+};
-- 
2.12.0
