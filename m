From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Tue, 7 Aug 2018 13:06:34 +0200
Subject: [PATCH 2/3] ARM: dts: stm32: Fix DT dtc warnings for stm32f7
In-Reply-To: <1533639995-27047-1-git-send-email-patrice.chotard@st.com>
References: <1533639995-27047-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1533639995-27047-3-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Fix the following DT dtc warnings for stm32f746 and stm32f769
boards:

Warning (node_name_chars_strict): /soc/pin-controller/sdio_pins_a at 0: Character '_' not recommended in node name
Warning (node_name_chars_strict): /soc/pin-controller/sdio_pins_od_a at 0: Character '_' not recommended in node name
Warning (node_name_chars_strict): /soc/pin-controller/sdio_pins_b at 0: Character '_' not recommended in node name
Warning (node_name_chars_strict): /soc/pin-controller/sdio_pins_od_b at 0: Character '_' not recommended in node name
Warning (node_name_chars_strict): /gpio_keys: Character '_' not recommended in node name
Warning (node_name_chars_strict): /mmc_vcard: Character '_' not recommended in node name
Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): /soc/pin-controller: node has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): /soc/pin-controller/cec at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/usart1 at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/i2c1 at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/usbotg-hs at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/usbotg-hs at 1: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/usbotg-fs at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/sdio_pins_a at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/sdio_pins_od_a at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/sdio_pins_b at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/sdio_pins_od_b at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /gpio_keys/button at 0: node has a unit name, but no reg property
Warning (avoid_unnecessary_addr_size): /soc/timers at 40001c00: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
Warning (avoid_unnecessary_addr_size): /soc/timers at 40002000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
Warning (avoid_unnecessary_addr_size): /soc/timers at 40014400: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
Warning (avoid_unnecessary_addr_size): /soc/timers at 40014800: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stm32746g-eval.dts   |  9 ++++-----
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 24 ++++++++++++------------
 arch/arm/boot/dts/stm32f746-disco.dts  |  6 +++---
 arch/arm/boot/dts/stm32f746.dtsi       |  8 +++-----
 arch/arm/boot/dts/stm32f769-disco.dts  | 11 +++++------
 5 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index 8c081eaf20fe..a2edf6fccc2c 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -54,7 +54,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at c0000000 {
 		reg = <0xc0000000 0x2000000>;
 	};
 
@@ -73,12 +73,11 @@
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
 		#size-cells = <0>;
 		autorepeat;
-		button at 0 {
+		button {
 			label = "Wake up";
 			linux,code = <KEY_WAKEUP>;
 			gpios = <&gpioc 13 0>;
@@ -92,7 +91,7 @@
 		clock-names = "main_clk";
 	};
 
-	mmc_vcard: mmc_vcard {
+	mmc_vcard: mmc-vcard {
 		compatible = "regulator-fixed";
 		regulator-name = "mmc_vcard";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
index 9314128df185..702f1c12c22b 100644
--- a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
@@ -9,7 +9,7 @@
 
 / {
 	soc {
-		pinctrl: pin-controller {
+		pinctrl: pin-controller at 40020000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x40020000 0x3000>;
@@ -127,7 +127,7 @@
 				st,bank-name = "GPIOK";
 			};
 
-			cec_pins_a: cec at 0 {
+			cec_pins_a: cec {
 				pins {
 					pinmux = <STM32_PINMUX('A', 15, AF4)>; /* HDMI CEC */
 					slew-rate = <0>;
@@ -136,7 +136,7 @@
 				};
 			};
 
-			usart1_pins_a: usart1 at 0 {
+			usart1_pins_a: usart1-a {
 				pins1 {
 					pinmux = <STM32_PINMUX('A', 9, AF7)>; /* USART1_TX */
 					bias-disable;
@@ -149,7 +149,7 @@
 				};
 			};
 
-			usart1_pins_b: usart1 at 1 {
+			usart1_pins_b: usart1-b {
 				pins1 {
 					pinmux = <STM32_PINMUX('A', 9, AF7)>; /* USART1_TX */
 					bias-disable;
@@ -162,7 +162,7 @@
 				};
 			};
 
-			i2c1_pins_b: i2c1 at 0 {
+			i2c1_pins_b: i2c1 {
 				pins {
 					pinmux = <STM32_PINMUX('B', 9, AF4)>, /* I2C1 SDA */
 						 <STM32_PINMUX('B', 8, AF4)>; /* I2C1 SCL */
@@ -172,7 +172,7 @@
 				};
 			};
 
-			usbotg_hs_pins_a: usbotg-hs at 0 {
+			usbotg_hs_pins_a: usbotg-hs-a {
 				pins {
 					pinmux = <STM32_PINMUX('H', 4, AF10)>, /* OTG_HS_ULPI_NXT */
 						 <STM32_PINMUX('I', 11, AF10)>, /* OTG_HS_ULPI_DIR */
@@ -192,7 +192,7 @@
 				};
 			};
 
-			usbotg_hs_pins_b: usbotg-hs at 1 {
+			usbotg_hs_pins_b: usbotg-hs-b {
 				pins {
 					pinmux = <STM32_PINMUX('H', 4, AF10)>, /* OTG_HS_ULPI_NXT */
 						 <STM32_PINMUX('C', 2, AF10)>, /* OTG_HS_ULPI_DIR */
@@ -212,7 +212,7 @@
 				};
 			};
 
-			usbotg_fs_pins_a: usbotg-fs at 0 {
+			usbotg_fs_pins_a: usbotg-fs {
 				pins {
 					pinmux = <STM32_PINMUX('A', 10, AF10)>, /* OTG_FS_ID */
 						 <STM32_PINMUX('A', 11, AF10)>, /* OTG_FS_DM */
@@ -223,7 +223,7 @@
 				};
 			};
 
-			sdio_pins_a: sdio_pins_a at 0 {
+			sdio_pins_a: sdio-pins-a {
 				pins {
 					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1 D0 */
 						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1 D1 */
@@ -236,7 +236,7 @@
 				};
 			};
 
-			sdio_pins_od_a: sdio_pins_od_a at 0 {
+			sdio_pins_od_a: sdio-pins-od-a {
 				pins1 {
 					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1 D0 */
 						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1 D1 */
@@ -254,7 +254,7 @@
 				};
 			};
 
-			sdio_pins_b: sdio_pins_b at 0 {
+			sdio_pins_b: sdio-pins-b {
 				pins {
 					pinmux = <STM32_PINMUX('G', 9, AF11)>, /* SDMMC2 D0 */
 						 <STM32_PINMUX('G', 10, AF11)>, /* SDMMC2 D1 */
@@ -267,7 +267,7 @@
 				};
 			};
 
-			sdio_pins_od_b: sdio_pins_od_b at 0 {
+			sdio_pins_od_b: sdio-pins-od-b {
 				pins1 {
 					pinmux = <STM32_PINMUX('G', 9, AF11)>, /* SDMMC2 D0 */
 						 <STM32_PINMUX('G', 10, AF11)>, /* SDMMC2 D1 */
diff --git a/arch/arm/boot/dts/stm32f746-disco.dts b/arch/arm/boot/dts/stm32f746-disco.dts
index f9ad71f7c807..ccf9321926a4 100644
--- a/arch/arm/boot/dts/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/stm32f746-disco.dts
@@ -55,8 +55,8 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
-		reg = <0xC0000000 0x800000>;
+	memory at c0000000 {
+		reg = <0xc0000000 0x800000>;
 	};
 
 	aliases {
@@ -78,7 +78,7 @@
 		regulator-always-on;
 	};
 
-	mmc_vcard: mmc_vcard {
+	mmc_vcard: mmc-vcard {
 		compatible = "regulator-fixed";
 		regulator-name = "mmc_vcard";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 1479e3eb05fa..18272dc4e2ca 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -40,12 +40,14 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 #include <dt-bindings/clock/stm32fx-clock.h>
 #include <dt-bindings/mfd/stm32f7-rcc.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	clocks {
 		clk_hse: clk-hse {
 			#clock-cells = <0>;
@@ -258,7 +260,6 @@
 		};
 
 		timers13: timers at 40001c00 {
-			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "st,stm32-timers";
 			reg = <0x40001C00 0x400>;
@@ -273,7 +274,6 @@
 		};
 
 		timers14: timers at 40002000 {
-			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "st,stm32-timers";
 			reg = <0x40002000 0x400>;
@@ -521,7 +521,6 @@
 		};
 
 		timers10: timers at 40014400 {
-			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "st,stm32-timers";
 			reg = <0x40014400 0x400>;
@@ -536,7 +535,6 @@
 		};
 
 		timers11: timers at 40014800 {
-			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "st,stm32-timers";
 			reg = <0x40014800 0x400>;
diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
index 677276ba4dbe..d77300101e09 100644
--- a/arch/arm/boot/dts/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/stm32f769-disco.dts
@@ -55,8 +55,8 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
-		reg = <0xC0000000 0x1000000>;
+	memory at c0000000 {
+		reg = <0xc0000000 0x1000000>;
 	};
 
 	aliases {
@@ -74,12 +74,11 @@
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
 		#size-cells = <0>;
 		autorepeat;
-		button at 0 {
+		button {
 			label = "User";
 			linux,code = <KEY_HOME>;
 			gpios = <&gpioa 0 GPIO_ACTIVE_HIGH>;
@@ -93,7 +92,7 @@
 		clock-names = "main_clk";
 	};
 
-	mmc_vcard: mmc_vcard {
+	mmc_vcard: mmc-vcard {
 		compatible = "regulator-fixed";
 		regulator-name = "mmc_vcard";
 		regulator-min-microvolt = <3300000>;
-- 
1.9.1
