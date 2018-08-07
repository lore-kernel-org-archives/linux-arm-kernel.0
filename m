From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Tue, 7 Aug 2018 13:06:35 +0200
Subject: [PATCH 3/3] ARM: dts: stm32: Fix DT dtc warnings for stm32f4
In-Reply-To: <1533639995-27047-1-git-send-email-patrice.chotard@st.com>
References: <1533639995-27047-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1533639995-27047-4-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Fix the following DT dtc warnings for stm32f429 and
stm32f469 boards:

Warning (node_name_chars_strict): /soc/pin-controller/usbotg_fs at 0: Character '_' not recommended in node name
Warning (node_name_chars_strict): /soc/pin-controller/usbotg_fs at 1: Character '_' not recommended in node name
Warning (node_name_chars_strict): /soc/pin-controller/usbotg_hs at 0: Character '_' not recommended in node name
Warning (node_name_chars_strict): /soc/pin-controller/sdio_pins at 0: Character '_' not recommended in node name
Warning (node_name_chars_strict): /soc/pin-controller/sdio_pins_od at 0: Character '_' not recommended in node name
Warning (node_name_chars_strict): /gpio_keys: Character '_' not recommended in node name
Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): /soc/pin-controller: node has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): /soc/pin-controller/usart1 at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/usart3 at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/usbotg_fs at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/usbotg_fs at 1: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/usbotg_hs at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/mii at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/adc at 200: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/pwm at 1: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/pwm at 3: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/i2c1 at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/ltdc at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/dcmi at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/sdio_pins at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller/sdio_pins_od at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /gpio_keys/button at 0: node has a unit name, but no reg property
Warning (avoid_unnecessary_addr_size): /gpio_keys: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts     | 11 +++--
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi   | 30 ++++++-------
 arch/arm/boot/dts/stm32f429-disco.dts    |  7 ++-
 arch/arm/boot/dts/stm32f429-pinctrl.dtsi | 74 +++++++++++++++----------------
 arch/arm/boot/dts/stm32f429.dtsi         |  8 ++--
 arch/arm/boot/dts/stm32f469-disco.dts    | 11 +++--
 arch/arm/boot/dts/stm32f469-pinctrl.dtsi | 76 +++++++++++++++-----------------
 7 files changed, 102 insertions(+), 115 deletions(-)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 7eb786a2d624..b5af6feb95a4 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -60,7 +60,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		reg = <0x00000000 0x2000000>;
 	};
 
@@ -111,17 +111,16 @@
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
 		#size-cells = <0>;
 		autorepeat;
-		button at 0 {
+		button0 {
 			label = "Wake up";
 			linux,code = <KEY_WAKEUP>;
 			gpios = <&gpioa 0 0>;
 		};
-		button at 1 {
+		button1 {
 			label = "Tamper";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpioc 13 0>;
@@ -145,7 +144,7 @@
 		};
 	};
 
-	mmc_vcard: mmc_vcard {
+	mmc_vcard: mmc-vcard {
 		compatible = "regulator-fixed";
 		regulator-name = "mmc_vcard";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
index 35202896c093..73061fee60f6 100644
--- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
@@ -45,7 +45,7 @@
 
 / {
 	soc {
-		pinctrl: pin-controller {
+		pinctrl: pin-controller at 40020000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x40020000 0x3000>;
@@ -163,7 +163,7 @@
 				st,bank-name = "GPIOK";
 			};
 
-			usart1_pins_a: usart1 at 0 {
+			usart1_pins_a: usart1 {
 				pins1 {
 					pinmux = <STM32_PINMUX('A', 9, AF7)>; /* USART1_TX */
 					bias-disable;
@@ -176,7 +176,7 @@
 				};
 			};
 
-			usart3_pins_a: usart3 at 0 {
+			usart3_pins_a: usart3 {
 				pins1 {
 					pinmux = <STM32_PINMUX('B', 10, AF7)>; /* USART3_TX */
 					bias-disable;
@@ -189,7 +189,7 @@
 				};
 			};
 
-			usbotg_fs_pins_a: usbotg_fs at 0 {
+			usbotg_fs_pins_a: usbotg-fs-a {
 				pins {
 					pinmux = <STM32_PINMUX('A', 10, AF10)>, /* OTG_FS_ID */
 						 <STM32_PINMUX('A', 11, AF10)>, /* OTG_FS_DM */
@@ -200,7 +200,7 @@
 				};
 			};
 
-			usbotg_fs_pins_b: usbotg_fs at 1 {
+			usbotg_fs_pins_b: usbotg-fs-b {
 				pins {
 					pinmux = <STM32_PINMUX('B', 12, AF12)>, /* OTG_HS_ID */
 						 <STM32_PINMUX('B', 14, AF12)>, /* OTG_HS_DM */
@@ -211,7 +211,7 @@
 				};
 			};
 
-			usbotg_hs_pins_a: usbotg_hs at 0 {
+			usbotg_hs_pins_a: usbotg-hs {
 				pins {
 					pinmux = <STM32_PINMUX('H', 4, AF10)>, /* OTG_HS_ULPI_NXT*/
 						 <STM32_PINMUX('I', 11, AF10)>, /* OTG_HS_ULPI_DIR */
@@ -231,7 +231,7 @@
 				};
 			};
 
-			ethernet_mii: mii at 0 {
+			ethernet_mii: mii {
 				pins {
 					pinmux = <STM32_PINMUX('G', 13, AF11)>, /* ETH_MII_TXD0_ETH_RMII_TXD0 */
 						 <STM32_PINMUX('G', 14, AF11)>, /* ETH_MII_TXD1_ETH_RMII_TXD1 */
@@ -251,13 +251,13 @@
 				};
 			};
 
-			adc3_in8_pin: adc at 200 {
+			adc3_in8_pin: adc {
 				pins {
 					pinmux = <STM32_PINMUX('F', 10, ANALOG)>;
 				};
 			};
 
-			pwm1_pins: pwm at 1 {
+			pwm1_pins: pwm1 {
 				pins {
 					pinmux = <STM32_PINMUX('A', 8, AF1)>, /* TIM1_CH1 */
 						 <STM32_PINMUX('B', 13, AF1)>, /* TIM1_CH1N */
@@ -265,14 +265,14 @@
 				};
 			};
 
-			pwm3_pins: pwm at 3 {
+			pwm3_pins: pwm3 {
 				pins {
 					pinmux = <STM32_PINMUX('B', 4, AF2)>, /* TIM3_CH1 */
 						 <STM32_PINMUX('B', 5, AF2)>; /* TIM3_CH2 */
 				};
 			};
 
-			i2c1_pins: i2c1 at 0 {
+			i2c1_pins: i2c1 {
 				pins {
 					pinmux = <STM32_PINMUX('B', 9, AF4)>, /* I2C1_SDA */
 						 <STM32_PINMUX('B', 6, AF4)>; /* I2C1_SCL */
@@ -282,7 +282,7 @@
 				};
 			};
 
-			ltdc_pins: ltdc at 0 {
+			ltdc_pins: ltdc {
 				pins {
 					pinmux = <STM32_PINMUX('I', 12, AF14)>, /* LCD_HSYNC */
 						 <STM32_PINMUX('I', 13, AF14)>, /* LCD_VSYNC */
@@ -316,7 +316,7 @@
 				};
 			};
 
-			dcmi_pins: dcmi at 0 {
+			dcmi_pins: dcmi {
 				pins {
 					pinmux = <STM32_PINMUX('A', 4, AF13)>, /* DCMI_HSYNC */
 						 <STM32_PINMUX('B', 7, AF13)>, /* DCMI_VSYNC */
@@ -339,7 +339,7 @@
 				};
 			};
 
-			sdio_pins: sdio_pins at 0 {
+			sdio_pins: sdio-pins {
 				pins {
 					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDIO_D0 */
 						 <STM32_PINMUX('C', 9, AF12)>, /* SDIO_D1 */
@@ -352,7 +352,7 @@
 				};
 			};
 
-			sdio_pins_od: sdio_pins_od at 0 {
+			sdio_pins_od: sdio-pins-od {
 				pins1 {
 					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDIO_D0 */
 						 <STM32_PINMUX('C', 9, AF12)>, /* SDIO_D1 */
diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 5ceb2cf3777f..93baee7b5f61 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -59,7 +59,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 90000000 {
 		reg = <0x90000000 0x800000>;
 	};
 
@@ -78,12 +78,11 @@
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
 			gpios = <&gpioa 0 0>;
diff --git a/arch/arm/boot/dts/stm32f429-pinctrl.dtsi b/arch/arm/boot/dts/stm32f429-pinctrl.dtsi
index 3e7a17d9112e..426e4ab64e1b 100644
--- a/arch/arm/boot/dts/stm32f429-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f429-pinctrl.dtsi
@@ -42,54 +42,50 @@
 
 #include "stm32f4-pinctrl.dtsi"
 
-/ {
-	soc {
-		pinctrl: pin-controller {
-			compatible = "st,stm32f429-pinctrl";
+&pinctrl {
+	compatible = "st,stm32f429-pinctrl";
+};
 
-			gpioa: gpio at 40020000 {
-				gpio-ranges = <&pinctrl 0 0 16>;
-			};
+&gpioa {
+	gpio-ranges = <&pinctrl 0 0 16>;
+};
 
-			gpiob: gpio at 40020400 {
-				gpio-ranges = <&pinctrl 0 16 16>;
-			};
+&gpiob {
+	gpio-ranges = <&pinctrl 0 16 16>;
+};
 
-			gpioc: gpio at 40020800 {
-				gpio-ranges = <&pinctrl 0 32 16>;
-			};
+&gpioc {
+	gpio-ranges = <&pinctrl 0 32 16>;
+};
 
-			gpiod: gpio at 40020c00 {
-				gpio-ranges = <&pinctrl 0 48 16>;
-			};
+&gpiod {
+	gpio-ranges = <&pinctrl 0 48 16>;
+};
 
-			gpioe: gpio at 40021000 {
-				gpio-ranges = <&pinctrl 0 64 16>;
-			};
+&gpioe {
+	gpio-ranges = <&pinctrl 0 64 16>;
+};
 
-			gpiof: gpio at 40021400 {
-				gpio-ranges = <&pinctrl 0 80 16>;
-			};
+&gpiof {
+	gpio-ranges = <&pinctrl 0 80 16>;
+};
 
-			gpiog: gpio at 40021800 {
-				gpio-ranges = <&pinctrl 0 96 16>;
-			};
+&gpiog {
+	gpio-ranges = <&pinctrl 0 96 16>;
+};
 
-			gpioh: gpio at 40021c00 {
-				gpio-ranges = <&pinctrl 0 112 16>;
-			};
+&gpioh {
+	gpio-ranges = <&pinctrl 0 112 16>;
+};
 
-			gpioi: gpio at 40022000 {
-				gpio-ranges = <&pinctrl 0 128 16>;
-			};
+&gpioi {
+	gpio-ranges = <&pinctrl 0 128 16>;
+};
 
-			gpioj: gpio at 40022400 {
-				gpio-ranges = <&pinctrl 0 144 16>;
-			};
+&gpioj {
+	gpio-ranges = <&pinctrl 0 144 16>;
+};
 
-			gpiok: gpio at 40022800 {
-				gpio-ranges = <&pinctrl 0 160 8>;
-			};
-		};
-	};
+&gpiok {
+	gpio-ranges = <&pinctrl 0 160 8>;
 };
diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 64278e81bc08..d6f736024422 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -45,12 +45,14 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 #include <dt-bindings/clock/stm32fx-clock.h>
 #include <dt-bindings/mfd/stm32f4-rcc.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	clocks {
 		clk_hse: clk-hse {
 			#clock-cells = <0>;
@@ -263,7 +265,6 @@
 		};
 
 		timers13: timers at 40001c00 {
-			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "st,stm32-timers";
 			reg = <0x40001C00 0x400>;
@@ -278,7 +279,6 @@
 		};
 
 		timers14: timers at 40002000 {
-			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "st,stm32-timers";
 			reg = <0x40002000 0x400>;
@@ -557,7 +557,6 @@
 		};
 
 		timers10: timers at 40014400 {
-			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "st,stm32-timers";
 			reg = <0x40014400 0x400>;
@@ -572,7 +571,6 @@
 		};
 
 		timers11: timers at 40014800 {
-			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "st,stm32-timers";
 			reg = <0x40014800 0x400>;
diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 3ee768cb86fc..44f092307de3 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -60,7 +60,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		reg = <0x00000000 0x1000000>;
 	};
 
@@ -68,7 +68,7 @@
 		serial0 = &usart3;
 	};
 
-	mmc_vcard: mmc_vcard {
+	mmc_vcard: mmc-vcard {
 		compatible = "regulator-fixed";
 		regulator-name = "mmc_vcard";
 		regulator-min-microvolt = <3300000>;
@@ -96,12 +96,11 @@
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
 			linux,code = <KEY_WAKEUP>;
 			gpios = <&gpioa 0 GPIO_ACTIVE_HIGH>;
@@ -169,7 +168,7 @@
 	status = "okay";
 
 	port {
-		ltdc_out_dsi: endpoint at 0 {
+		ltdc_out_dsi: endpoint {
 			remote-endpoint = <&dsi_in>;
 		};
 	};
diff --git a/arch/arm/boot/dts/stm32f469-pinctrl.dtsi b/arch/arm/boot/dts/stm32f469-pinctrl.dtsi
index fff542662eea..2e7718a919a3 100644
--- a/arch/arm/boot/dts/stm32f469-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f469-pinctrl.dtsi
@@ -42,55 +42,51 @@
 
 #include "stm32f4-pinctrl.dtsi"
 
-/ {
-	soc {
-		pinctrl: pin-controller {
-			compatible = "st,stm32f469-pinctrl";
+&pinctrl {
+	compatible = "st,stm32f469-pinctrl";
+};
 
-			gpioa: gpio at 40020000 {
-				gpio-ranges = <&pinctrl 0 0 16>;
-			};
+&gpioa {
+	gpio-ranges = <&pinctrl 0 0 16>;
+};
 
-			gpiob: gpio at 40020400 {
-				gpio-ranges = <&pinctrl 0 16 16>;
-			};
+&gpiob {
+	gpio-ranges = <&pinctrl 0 16 16>;
+};
 
-			gpioc: gpio at 40020800 {
-				gpio-ranges = <&pinctrl 0 32 16>;
-			};
+&gpioc {
+	gpio-ranges = <&pinctrl 0 32 16>;
+};
 
-			gpiod: gpio at 40020c00 {
-				gpio-ranges = <&pinctrl 0 48 16>;
-			};
+&gpiod {
+	gpio-ranges = <&pinctrl 0 48 16>;
+};
 
-			gpioe: gpio at 40021000 {
-				gpio-ranges = <&pinctrl 0 64 16>;
-			};
+&gpioe {
+	gpio-ranges = <&pinctrl 0 64 16>;
+};
 
-			gpiof: gpio at 40021400 {
-				gpio-ranges = <&pinctrl 0 80 16>;
-			};
+&gpiof {
+	gpio-ranges = <&pinctrl 0 80 16>;
+};
 
-			gpiog: gpio at 40021800 {
-				gpio-ranges = <&pinctrl 0 96 16>;
-			};
+&gpiog {
+	gpio-ranges = <&pinctrl 0 96 16>;
+};
 
-			gpioh: gpio at 40021c00 {
-				gpio-ranges = <&pinctrl 0 112 16>;
-			};
+&gpioh {
+	gpio-ranges = <&pinctrl 0 112 16>;
+};
 
-			gpioi: gpio at 40022000 {
-				gpio-ranges = <&pinctrl 0 128 16>;
-			};
+&gpioi {
+	gpio-ranges = <&pinctrl 0 128 16>;
+};
 
-			gpioj: gpio at 40022400 {
-				gpio-ranges = <&pinctrl 0 144 6>,
-					      <&pinctrl 12 156 4>;
-			};
+&gpioj {
+	gpio-ranges = <&pinctrl 0 144 6>,
+		      <&pinctrl 12 156 4>;
+};
 
-			gpiok: gpio at 40022800 {
-				gpio-ranges = <&pinctrl 3 163 5>;
-			};
-		};
-	};
+&gpiok {
+	gpio-ranges = <&pinctrl 3 163 5>;
 };
-- 
1.9.1
