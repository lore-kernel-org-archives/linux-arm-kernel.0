From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:04:02 +0100
Subject: [PATCH 13/21] ARM: ux500: move GPIO key configuration to device tree
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-14-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves over the configuration of the GPIO keys (used for
proximity sensor and Hall effect sensor) from the static pin
configuration file to the device tree. As part of the exercise,
implement the GPIO keys properly in a per-UIB file as this
setup actually differs with each UIB.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-stuib.dtsi      | 41 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi | 38 +++++++++++++++++++++++++++
 arch/arm/boot/dts/ste-href.dtsi            | 11 --------
 arch/arm/boot/dts/ste-hrefv60plus.dtsi     |  6 -----
 arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi |  5 ++++
 arch/arm/mach-ux500/board-mop500-pins.c    |  8 ------
 6 files changed, 84 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-stuib.dtsi b/arch/arm/boot/dts/ste-href-stuib.dtsi
index 76704ec0ffcc..1c3574435ea8 100644
--- a/arch/arm/boot/dts/ste-href-stuib.dtsi
+++ b/arch/arm/boot/dts/ste-href-stuib.dtsi
@@ -12,6 +12,28 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		vdd-supply = <&ab8500_ldo_aux1_reg>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&prox_stuib_mode>, <&hall_stuib_mode>;
+
+		button at 139 {
+			/* Proximity sensor */
+			gpios = <&gpio6 25 0x4>;
+			linux,code = <11>; /* SW_FRONT_PROXIMITY */
+			label = "SFH7741 Proximity Sensor";
+		};
+		button at 145 {
+			/* Hall sensor */
+			gpios = <&gpio4 17 0x4>;
+			linux,code = <0>; /* SW_LID */
+			label = "HED54XXU11 Hall Effect Sensor";
+		};
+	};
+
 	soc {
 		i2c at 80004000 {
 			stmpe1601: stmpe1601 at 40 {
@@ -74,5 +96,24 @@
 				rohm,flip-y;
 			};
 		};
+
+		pinctrl {
+			prox {
+				prox_stuib_mode: prox_stuib {
+					stuib_cfg {
+						ste,pins = "GPIO217_AH12";
+						ste,config = <&gpio_in_pu>;
+					};
+				};
+			};
+			hall {
+				hall_stuib_mode: stuib_tvk {
+					stuib_cfg {
+						ste,pins = "GPIO145_C13";
+						ste,config = <&gpio_in_pu>;
+					};
+				};
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
index 3f31f9206fb3..c40565320978 100644
--- a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
+++ b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
@@ -14,6 +14,28 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		vdd-supply = <&ab8500_ldo_aux1_reg>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&prox_tvk_mode>, <&hall_tvk_mode>;
+
+		button at 139 {
+			/* Proximity sensor */
+			gpios = <&gpio6 25 0x4>;
+			linux,code = <11>; /* SW_FRONT_PROXIMITY */
+			label = "SFH7741 Proximity Sensor";
+		};
+		button at 145 {
+			/* Hall sensor */
+			gpios = <&gpio4 17 0x4>;
+			linux,code = <0>; /* SW_LID */
+			label = "HED54XXU11 Hall Effect Sensor";
+		};
+	};
+
 	soc {
 		/* Add Synaptics touch screen, TC35893 keypad etc here */
 		i2c at 80004000 {
@@ -76,6 +98,22 @@
 					};
 				};
 			};
+			prox {
+				prox_tvk_mode: prox_tvk {
+					tvk_cfg {
+						ste,pins = "GPIO217_AH12";
+						ste,config = <&gpio_in_pu>;
+					};
+				};
+			};
+			hall {
+				hall_tvk_mode: hall_tvk {
+					tvk_cfg {
+						ste,pins = "GPIO145_C13";
+						ste,config = <&gpio_in_pu>;
+					};
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 56772c3ebb28..e28242173d18 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -18,17 +18,6 @@
 		reg = <0x00000000 0x20000000>;
 	};
 
-	gpio_keys {
-		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		button at 1 {
-			linux,code = <11>;
-			label = "SFH7741 Proximity Sensor";
-		};
-	};
-
 	soc {
 		usb_per5 at a03e0000 {
 			pinctrl-names = "default", "sleep";
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
index 452f00c4f7c0..6e0105d2f461 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dtsi
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
@@ -16,12 +16,6 @@
 	model = "ST-Ericsson HREF (v60+) platform with Device Tree";
 	compatible = "st-ericsson,hrefv60+", "st-ericsson,u8500";
 
-	gpio_keys {
-		button at 1 {
-			gpios = <&gpio5 25 0x4>;
-		};
-	};
-
 	soc {
 		// External Micro SD slot
 		sdi0_per1 at 80126000 {
diff --git a/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi b/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
index ee143b0a5baa..e6f22b266420 100644
--- a/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
@@ -36,6 +36,11 @@
 		ste,input = <INPUT_PULLUP>;
 	};
 
+	gpio_in_pd: gpio_input_pull_down {
+		ste,gpio = <GPIOMODE_ENABLED>;
+		ste,input = <INPUT_PULLDOWN>;
+	};
+
 	gpio_out_lo: gpio_output_low {
 		ste,gpio = <GPIOMODE_ENABLED>;
 		ste,output = <OUTPUT_LOW>;
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 257c97a214a5..4535702a8e3f 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -382,14 +382,6 @@ static struct pinctrl_map __initdata hrefv60_pinmap[] = {
 	/* Accelerometer interrupt lines */
 	DB8500_PIN_HOG("GPIO82_C1", gpio_in_pu), /* ACC_INT1 */
 	DB8500_PIN_HOG("GPIO83_D3", gpio_in_pu), /* ACC_INT2 */
-	/*
-	 * Runtime stuff
-	 * Pull up/down of some sensor GPIO pins, for proximity, HAL sensor
-	 * etc.
-	 */
-	DB8500_PIN("GPIO217_AH12", gpio_in_pu_slpm_gpio_nopull, "gpio-keys.0"),
-	DB8500_PIN("GPIO145_C13", gpio_in_pd_slpm_gpio_nopull, "gpio-keys.0"),
-	DB8500_PIN("GPIO139_C9", gpio_in_pu_slpm_gpio_nopull, "gpio-keys.0"),
 };
 
 static struct pinctrl_map __initdata u9500_pinmap[] = {
-- 
1.8.3.1
