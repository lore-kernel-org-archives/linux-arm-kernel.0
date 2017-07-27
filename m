From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 27 Jul 2017 18:27:27 +0200
Subject: [PATCH] ARM: dts: stm32: use right compatible for stm32f469
Message-ID: <1501172847-31323-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, same stm32f429-pinctrl driver is used for stm32f429 and
stm32f469. As pin map is different between those 2 MCUs,
a stm32f469-pinctrl driver has been recently added.
This patch
 -allows to use stm32f469-pinctrl driver for stm32f469 boards
 -reworks stm32 devicetree files to fit with stm32f429 / stm32f469

In the same time it fixes an issue when only MACH_STM32F469 flag is
selected in menuconfig.

Fixes: d28bcd53fa90 ("ARM: stm32: Introduce MACH_STM32F469 flag")
Reported-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
---

Hi Arnd, Kevin and Olof,

I send this series in 4.13-rcx cycle to fix d28bcd53fa90
("ARM: stm32: Introduce MACH_STM32F469 flag").
This patch could look "huge" to fix the issue but I prefer to send
a clean patch now that send a quick fix first and a DT rework in 4.14
cycle.
Let me know, if tou disagree with that.

Thanks
Alex

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index dcda0bb..ac635b9 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -47,6 +47,7 @@
 
 /dts-v1/;
 #include "stm32f429.dtsi"
+#include "stm32f429-pinctrl.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
 
diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
new file mode 100644
index 0000000..7f3560c
--- /dev/null
+++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
@@ -0,0 +1,343 @@
+/*
+ * Copyright 2017 - Alexandre Torgue <alexandre.torgue@st.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
+#include <dt-bindings/mfd/stm32f4-rcc.h>
+
+/ {
+	soc {
+		pinctrl: pin-controller {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x40020000 0x3000>;
+			interrupt-parent = <&exti>;
+			st,syscfg = <&syscfg 0x8>;
+			pins-are-numbered;
+
+			gpioa: gpio at 40020000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x0 0x400>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOA)>;
+				st,bank-name = "GPIOA";
+			};
+
+			gpiob: gpio at 40020400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x400 0x400>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOB)>;
+				st,bank-name = "GPIOB";
+			};
+
+			gpioc: gpio at 40020800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x800 0x400>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOC)>;
+				st,bank-name = "GPIOC";
+			};
+
+			gpiod: gpio at 40020c00 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0xc00 0x400>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOD)>;
+				st,bank-name = "GPIOD";
+			};
+
+			gpioe: gpio at 40021000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x1000 0x400>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOE)>;
+				st,bank-name = "GPIOE";
+			};
+
+			gpiof: gpio at 40021400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x1400 0x400>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOF)>;
+				st,bank-name = "GPIOF";
+			};
+
+			gpiog: gpio at 40021800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x1800 0x400>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOG)>;
+				st,bank-name = "GPIOG";
+			};
+
+			gpioh: gpio at 40021c00 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x1c00 0x400>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOH)>;
+				st,bank-name = "GPIOH";
+			};
+
+			gpioi: gpio at 40022000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x2000 0x400>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOI)>;
+				st,bank-name = "GPIOI";
+			};
+
+			gpioj: gpio at 40022400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x2400 0x400>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOJ)>;
+				st,bank-name = "GPIOJ";
+			};
+
+			gpiok: gpio at 40022800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x2800 0x400>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOK)>;
+				st,bank-name = "GPIOK";
+			};
+
+			usart1_pins_a: usart1 at 0 {
+				pins1 {
+					pinmux = <STM32F429_PA9_FUNC_USART1_TX>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32F429_PA10_FUNC_USART1_RX>;
+					bias-disable;
+				};
+			};
+
+			usart3_pins_a: usart3 at 0 {
+				pins1 {
+					pinmux = <STM32F429_PB10_FUNC_USART3_TX>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32F429_PB11_FUNC_USART3_RX>;
+					bias-disable;
+				};
+			};
+
+			usbotg_fs_pins_a: usbotg_fs at 0 {
+				pins {
+					pinmux = <STM32F429_PA10_FUNC_OTG_FS_ID>,
+						 <STM32F429_PA11_FUNC_OTG_FS_DM>,
+						 <STM32F429_PA12_FUNC_OTG_FS_DP>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
+
+			usbotg_fs_pins_b: usbotg_fs at 1 {
+				pins {
+					pinmux = <STM32F429_PB12_FUNC_OTG_HS_ID>,
+						 <STM32F429_PB14_FUNC_OTG_HS_DM>,
+						 <STM32F429_PB15_FUNC_OTG_HS_DP>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
+
+			usbotg_hs_pins_a: usbotg_hs at 0 {
+				pins {
+					pinmux = <STM32F429_PH4_FUNC_OTG_HS_ULPI_NXT>,
+						 <STM32F429_PI11_FUNC_OTG_HS_ULPI_DIR>,
+						 <STM32F429_PC0_FUNC_OTG_HS_ULPI_STP>,
+						 <STM32F429_PA5_FUNC_OTG_HS_ULPI_CK>,
+						 <STM32F429_PA3_FUNC_OTG_HS_ULPI_D0>,
+						 <STM32F429_PB0_FUNC_OTG_HS_ULPI_D1>,
+						 <STM32F429_PB1_FUNC_OTG_HS_ULPI_D2>,
+						 <STM32F429_PB10_FUNC_OTG_HS_ULPI_D3>,
+						 <STM32F429_PB11_FUNC_OTG_HS_ULPI_D4>,
+						 <STM32F429_PB12_FUNC_OTG_HS_ULPI_D5>,
+						 <STM32F429_PB13_FUNC_OTG_HS_ULPI_D6>,
+						 <STM32F429_PB5_FUNC_OTG_HS_ULPI_D7>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
+
+			ethernet_mii: mii at 0 {
+				pins {
+					pinmux = <STM32F429_PG13_FUNC_ETH_MII_TXD0_ETH_RMII_TXD0>,
+						 <STM32F429_PG14_FUNC_ETH_MII_TXD1_ETH_RMII_TXD1>,
+						 <STM32F429_PC2_FUNC_ETH_MII_TXD2>,
+						 <STM32F429_PB8_FUNC_ETH_MII_TXD3>,
+						 <STM32F429_PC3_FUNC_ETH_MII_TX_CLK>,
+						 <STM32F429_PG11_FUNC_ETH_MII_TX_EN_ETH_RMII_TX_EN>,
+						 <STM32F429_PA2_FUNC_ETH_MDIO>,
+						 <STM32F429_PC1_FUNC_ETH_MDC>,
+						 <STM32F429_PA1_FUNC_ETH_MII_RX_CLK_ETH_RMII_REF_CLK>,
+						 <STM32F429_PA7_FUNC_ETH_MII_RX_DV_ETH_RMII_CRS_DV>,
+						 <STM32F429_PC4_FUNC_ETH_MII_RXD0_ETH_RMII_RXD0>,
+						 <STM32F429_PC5_FUNC_ETH_MII_RXD1_ETH_RMII_RXD1>,
+						 <STM32F429_PH6_FUNC_ETH_MII_RXD2>,
+						 <STM32F429_PH7_FUNC_ETH_MII_RXD3>;
+					slew-rate = <2>;
+				};
+			};
+
+			adc3_in8_pin: adc at 200 {
+				pins {
+					pinmux = <STM32F429_PF10_FUNC_ANALOG>;
+				};
+			};
+
+			pwm1_pins: pwm at 1 {
+				pins {
+					pinmux = <STM32F429_PA8_FUNC_TIM1_CH1>,
+						 <STM32F429_PB13_FUNC_TIM1_CH1N>,
+						 <STM32F429_PB12_FUNC_TIM1_BKIN>;
+				};
+			};
+
+			pwm3_pins: pwm at 3 {
+				pins {
+					pinmux = <STM32F429_PB4_FUNC_TIM3_CH1>,
+						 <STM32F429_PB5_FUNC_TIM3_CH2>;
+				};
+			};
+
+			i2c1_pins: i2c1 at 0 {
+				pins {
+					pinmux = <STM32F429_PB9_FUNC_I2C1_SDA>,
+						 <STM32F429_PB6_FUNC_I2C1_SCL>;
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <3>;
+				};
+			};
+
+			ltdc_pins: ltdc at 0 {
+				pins {
+					pinmux = <STM32F429_PI12_FUNC_LCD_HSYNC>,
+						 <STM32F429_PI13_FUNC_LCD_VSYNC>,
+						 <STM32F429_PI14_FUNC_LCD_CLK>,
+						 <STM32F429_PI15_FUNC_LCD_R0>,
+						 <STM32F429_PJ0_FUNC_LCD_R1>,
+						 <STM32F429_PJ1_FUNC_LCD_R2>,
+						 <STM32F429_PJ2_FUNC_LCD_R3>,
+						 <STM32F429_PJ3_FUNC_LCD_R4>,
+						 <STM32F429_PJ4_FUNC_LCD_R5>,
+						 <STM32F429_PJ5_FUNC_LCD_R6>,
+						 <STM32F429_PJ6_FUNC_LCD_R7>,
+						 <STM32F429_PJ7_FUNC_LCD_G0>,
+						 <STM32F429_PJ8_FUNC_LCD_G1>,
+						 <STM32F429_PJ9_FUNC_LCD_G2>,
+						 <STM32F429_PJ10_FUNC_LCD_G3>,
+						 <STM32F429_PJ11_FUNC_LCD_G4>,
+						 <STM32F429_PJ12_FUNC_LCD_B0>,
+						 <STM32F429_PJ13_FUNC_LCD_B1>,
+						 <STM32F429_PJ14_FUNC_LCD_B2>,
+						 <STM32F429_PJ15_FUNC_LCD_B3>,
+						 <STM32F429_PK0_FUNC_LCD_G5>,
+						 <STM32F429_PK1_FUNC_LCD_G6>,
+						 <STM32F429_PK2_FUNC_LCD_G7>,
+						 <STM32F429_PK3_FUNC_LCD_B4>,
+						 <STM32F429_PK4_FUNC_LCD_B5>,
+						 <STM32F429_PK5_FUNC_LCD_B6>,
+						 <STM32F429_PK6_FUNC_LCD_B7>,
+						 <STM32F429_PK7_FUNC_LCD_DE>;
+					slew-rate = <2>;
+				};
+			};
+
+			dcmi_pins: dcmi at 0 {
+				pins {
+					pinmux = <STM32F429_PA4_FUNC_DCMI_HSYNC>,
+						 <STM32F429_PB7_FUNC_DCMI_VSYNC>,
+						 <STM32F429_PA6_FUNC_DCMI_PIXCLK>,
+						 <STM32F429_PC6_FUNC_DCMI_D0>,
+						 <STM32F429_PC7_FUNC_DCMI_D1>,
+						 <STM32F429_PC8_FUNC_DCMI_D2>,
+						 <STM32F429_PC9_FUNC_DCMI_D3>,
+						 <STM32F429_PC11_FUNC_DCMI_D4>,
+						 <STM32F429_PD3_FUNC_DCMI_D5>,
+						 <STM32F429_PB8_FUNC_DCMI_D6>,
+						 <STM32F429_PE6_FUNC_DCMI_D7>,
+						 <STM32F429_PC10_FUNC_DCMI_D8>,
+						 <STM32F429_PC12_FUNC_DCMI_D9>,
+						 <STM32F429_PD6_FUNC_DCMI_D10>,
+						 <STM32F429_PD2_FUNC_DCMI_D11>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <3>;
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index ae47cde..a8f09a02 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -47,6 +47,7 @@
 
 /dts-v1/;
 #include "stm32f429.dtsi"
+#include "stm32f429-pinctrl.dtsi"
 #include <dt-bindings/input/input.h>
 
 / {
diff --git a/arch/arm/boot/dts/stm32f429-pinctrl.dtsi b/arch/arm/boot/dts/stm32f429-pinctrl.dtsi
new file mode 100644
index 0000000..3e7a17d
--- /dev/null
+++ b/arch/arm/boot/dts/stm32f429-pinctrl.dtsi
@@ -0,0 +1,95 @@
+/*
+ * Copyright 2017 - Alexandre Torgue <alexandre.torgue@st.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "stm32f4-pinctrl.dtsi"
+
+/ {
+	soc {
+		pinctrl: pin-controller {
+			compatible = "st,stm32f429-pinctrl";
+
+			gpioa: gpio at 40020000 {
+				gpio-ranges = <&pinctrl 0 0 16>;
+			};
+
+			gpiob: gpio at 40020400 {
+				gpio-ranges = <&pinctrl 0 16 16>;
+			};
+
+			gpioc: gpio at 40020800 {
+				gpio-ranges = <&pinctrl 0 32 16>;
+			};
+
+			gpiod: gpio at 40020c00 {
+				gpio-ranges = <&pinctrl 0 48 16>;
+			};
+
+			gpioe: gpio at 40021000 {
+				gpio-ranges = <&pinctrl 0 64 16>;
+			};
+
+			gpiof: gpio at 40021400 {
+				gpio-ranges = <&pinctrl 0 80 16>;
+			};
+
+			gpiog: gpio at 40021800 {
+				gpio-ranges = <&pinctrl 0 96 16>;
+			};
+
+			gpioh: gpio at 40021c00 {
+				gpio-ranges = <&pinctrl 0 112 16>;
+			};
+
+			gpioi: gpio at 40022000 {
+				gpio-ranges = <&pinctrl 0 128 16>;
+			};
+
+			gpioj: gpio at 40022400 {
+				gpio-ranges = <&pinctrl 0 144 16>;
+			};
+
+			gpiok: gpio at 40022800 {
+				gpio-ranges = <&pinctrl 0 160 8>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index a8113dc..37a0025 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -47,7 +47,6 @@
 
 #include "skeleton.dtsi"
 #include "armv7-m.dtsi"
-#include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
 #include <dt-bindings/clock/stm32fx-clock.h>
 #include <dt-bindings/mfd/stm32f4-rcc.h>
 
@@ -566,302 +565,6 @@
 			status = "disabled";
 		};
 
-		pinctrl: pin-controller {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "st,stm32f429-pinctrl";
-			ranges = <0 0x40020000 0x3000>;
-			interrupt-parent = <&exti>;
-			st,syscfg = <&syscfg 0x8>;
-			pins-are-numbered;
-
-			gpioa: gpio at 40020000 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				reg = <0x0 0x400>;
-				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOA)>;
-				st,bank-name = "GPIOA";
-			};
-
-			gpiob: gpio at 40020400 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				reg = <0x400 0x400>;
-				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOB)>;
-				st,bank-name = "GPIOB";
-			};
-
-			gpioc: gpio at 40020800 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				reg = <0x800 0x400>;
-				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOC)>;
-				st,bank-name = "GPIOC";
-			};
-
-			gpiod: gpio at 40020c00 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				reg = <0xc00 0x400>;
-				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOD)>;
-				st,bank-name = "GPIOD";
-			};
-
-			gpioe: gpio at 40021000 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				reg = <0x1000 0x400>;
-				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOE)>;
-				st,bank-name = "GPIOE";
-			};
-
-			gpiof: gpio at 40021400 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				reg = <0x1400 0x400>;
-				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOF)>;
-				st,bank-name = "GPIOF";
-			};
-
-			gpiog: gpio at 40021800 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				reg = <0x1800 0x400>;
-				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOG)>;
-				st,bank-name = "GPIOG";
-			};
-
-			gpioh: gpio at 40021c00 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				reg = <0x1c00 0x400>;
-				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOH)>;
-				st,bank-name = "GPIOH";
-			};
-
-			gpioi: gpio at 40022000 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				reg = <0x2000 0x400>;
-				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOI)>;
-				st,bank-name = "GPIOI";
-			};
-
-			gpioj: gpio at 40022400 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				reg = <0x2400 0x400>;
-				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOJ)>;
-				st,bank-name = "GPIOJ";
-			};
-
-			gpiok: gpio at 40022800 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				reg = <0x2800 0x400>;
-				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOK)>;
-				st,bank-name = "GPIOK";
-			};
-
-			usart1_pins_a: usart1 at 0 {
-				pins1 {
-					pinmux = <STM32F429_PA9_FUNC_USART1_TX>;
-					bias-disable;
-					drive-push-pull;
-					slew-rate = <0>;
-				};
-				pins2 {
-					pinmux = <STM32F429_PA10_FUNC_USART1_RX>;
-					bias-disable;
-				};
-			};
-
-			usart3_pins_a: usart3 at 0 {
-				pins1 {
-					pinmux = <STM32F429_PB10_FUNC_USART3_TX>;
-					bias-disable;
-					drive-push-pull;
-					slew-rate = <0>;
-				};
-				pins2 {
-					pinmux = <STM32F429_PB11_FUNC_USART3_RX>;
-					bias-disable;
-				};
-			};
-
-			usbotg_fs_pins_a: usbotg_fs at 0 {
-				pins {
-					pinmux = <STM32F429_PA10_FUNC_OTG_FS_ID>,
-						 <STM32F429_PA11_FUNC_OTG_FS_DM>,
-						 <STM32F429_PA12_FUNC_OTG_FS_DP>;
-					bias-disable;
-					drive-push-pull;
-					slew-rate = <2>;
-				};
-			};
-
-			usbotg_fs_pins_b: usbotg_fs at 1 {
-				pins {
-					pinmux = <STM32F429_PB12_FUNC_OTG_HS_ID>,
-						 <STM32F429_PB14_FUNC_OTG_HS_DM>,
-						 <STM32F429_PB15_FUNC_OTG_HS_DP>;
-					bias-disable;
-					drive-push-pull;
-					slew-rate = <2>;
-				};
-			};
-
-			usbotg_hs_pins_a: usbotg_hs at 0 {
-				pins {
-					pinmux = <STM32F429_PH4_FUNC_OTG_HS_ULPI_NXT>,
-						 <STM32F429_PI11_FUNC_OTG_HS_ULPI_DIR>,
-						 <STM32F429_PC0_FUNC_OTG_HS_ULPI_STP>,
-						 <STM32F429_PA5_FUNC_OTG_HS_ULPI_CK>,
-						 <STM32F429_PA3_FUNC_OTG_HS_ULPI_D0>,
-						 <STM32F429_PB0_FUNC_OTG_HS_ULPI_D1>,
-						 <STM32F429_PB1_FUNC_OTG_HS_ULPI_D2>,
-						 <STM32F429_PB10_FUNC_OTG_HS_ULPI_D3>,
-						 <STM32F429_PB11_FUNC_OTG_HS_ULPI_D4>,
-						 <STM32F429_PB12_FUNC_OTG_HS_ULPI_D5>,
-						 <STM32F429_PB13_FUNC_OTG_HS_ULPI_D6>,
-						 <STM32F429_PB5_FUNC_OTG_HS_ULPI_D7>;
-					bias-disable;
-					drive-push-pull;
-					slew-rate = <2>;
-				};
-			};
-
-			ethernet_mii: mii at 0 {
-				pins {
-					pinmux = <STM32F429_PG13_FUNC_ETH_MII_TXD0_ETH_RMII_TXD0>,
-						 <STM32F429_PG14_FUNC_ETH_MII_TXD1_ETH_RMII_TXD1>,
-						 <STM32F429_PC2_FUNC_ETH_MII_TXD2>,
-						 <STM32F429_PB8_FUNC_ETH_MII_TXD3>,
-						 <STM32F429_PC3_FUNC_ETH_MII_TX_CLK>,
-						 <STM32F429_PG11_FUNC_ETH_MII_TX_EN_ETH_RMII_TX_EN>,
-						 <STM32F429_PA2_FUNC_ETH_MDIO>,
-						 <STM32F429_PC1_FUNC_ETH_MDC>,
-						 <STM32F429_PA1_FUNC_ETH_MII_RX_CLK_ETH_RMII_REF_CLK>,
-						 <STM32F429_PA7_FUNC_ETH_MII_RX_DV_ETH_RMII_CRS_DV>,
-						 <STM32F429_PC4_FUNC_ETH_MII_RXD0_ETH_RMII_RXD0>,
-						 <STM32F429_PC5_FUNC_ETH_MII_RXD1_ETH_RMII_RXD1>,
-						 <STM32F429_PH6_FUNC_ETH_MII_RXD2>,
-						 <STM32F429_PH7_FUNC_ETH_MII_RXD3>;
-					slew-rate = <2>;
-				};
-			};
-
-			adc3_in8_pin: adc at 200 {
-				pins {
-					pinmux = <STM32F429_PF10_FUNC_ANALOG>;
-				};
-			};
-
-			pwm1_pins: pwm at 1 {
-				pins {
-					pinmux = <STM32F429_PA8_FUNC_TIM1_CH1>,
-						 <STM32F429_PB13_FUNC_TIM1_CH1N>,
-						 <STM32F429_PB12_FUNC_TIM1_BKIN>;
-				};
-			};
-
-			pwm3_pins: pwm at 3 {
-				pins {
-					pinmux = <STM32F429_PB4_FUNC_TIM3_CH1>,
-						 <STM32F429_PB5_FUNC_TIM3_CH2>;
-				};
-			};
-
-			i2c1_pins: i2c1 at 0 {
-				pins {
-					pinmux = <STM32F429_PB9_FUNC_I2C1_SDA>,
-						 <STM32F429_PB6_FUNC_I2C1_SCL>;
-					bias-disable;
-					drive-open-drain;
-					slew-rate = <3>;
-				};
-			};
-
-			ltdc_pins: ltdc at 0 {
-				pins {
-					pinmux = <STM32F429_PI12_FUNC_LCD_HSYNC>,
-						 <STM32F429_PI13_FUNC_LCD_VSYNC>,
-						 <STM32F429_PI14_FUNC_LCD_CLK>,
-						 <STM32F429_PI15_FUNC_LCD_R0>,
-						 <STM32F429_PJ0_FUNC_LCD_R1>,
-						 <STM32F429_PJ1_FUNC_LCD_R2>,
-						 <STM32F429_PJ2_FUNC_LCD_R3>,
-						 <STM32F429_PJ3_FUNC_LCD_R4>,
-						 <STM32F429_PJ4_FUNC_LCD_R5>,
-						 <STM32F429_PJ5_FUNC_LCD_R6>,
-						 <STM32F429_PJ6_FUNC_LCD_R7>,
-						 <STM32F429_PJ7_FUNC_LCD_G0>,
-						 <STM32F429_PJ8_FUNC_LCD_G1>,
-						 <STM32F429_PJ9_FUNC_LCD_G2>,
-						 <STM32F429_PJ10_FUNC_LCD_G3>,
-						 <STM32F429_PJ11_FUNC_LCD_G4>,
-						 <STM32F429_PJ12_FUNC_LCD_B0>,
-						 <STM32F429_PJ13_FUNC_LCD_B1>,
-						 <STM32F429_PJ14_FUNC_LCD_B2>,
-						 <STM32F429_PJ15_FUNC_LCD_B3>,
-						 <STM32F429_PK0_FUNC_LCD_G5>,
-						 <STM32F429_PK1_FUNC_LCD_G6>,
-						 <STM32F429_PK2_FUNC_LCD_G7>,
-						 <STM32F429_PK3_FUNC_LCD_B4>,
-						 <STM32F429_PK4_FUNC_LCD_B5>,
-						 <STM32F429_PK5_FUNC_LCD_B6>,
-						 <STM32F429_PK6_FUNC_LCD_B7>,
-						 <STM32F429_PK7_FUNC_LCD_DE>;
-					slew-rate = <2>;
-				};
-			};
-
-			dcmi_pins: dcmi at 0 {
-				pins {
-					pinmux = <STM32F429_PA4_FUNC_DCMI_HSYNC>,
-						 <STM32F429_PB7_FUNC_DCMI_VSYNC>,
-						 <STM32F429_PA6_FUNC_DCMI_PIXCLK>,
-						 <STM32F429_PC6_FUNC_DCMI_D0>,
-						 <STM32F429_PC7_FUNC_DCMI_D1>,
-						 <STM32F429_PC8_FUNC_DCMI_D2>,
-						 <STM32F429_PC9_FUNC_DCMI_D3>,
-						 <STM32F429_PC11_FUNC_DCMI_D4>,
-						 <STM32F429_PD3_FUNC_DCMI_D5>,
-						 <STM32F429_PB8_FUNC_DCMI_D6>,
-						 <STM32F429_PE6_FUNC_DCMI_D7>,
-						 <STM32F429_PC10_FUNC_DCMI_D8>,
-						 <STM32F429_PC12_FUNC_DCMI_D9>,
-						 <STM32F429_PD6_FUNC_DCMI_D10>,
-						 <STM32F429_PD2_FUNC_DCMI_D11>;
-					bias-disable;
-					drive-push-pull;
-					slew-rate = <3>;
-				};
-			};
-		};
-
 		crc: crc at 40023000 {
 			compatible = "st,stm32f4-crc";
 			reg = <0x40023000 0x400>;
diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 75470c3..3e575c9 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -47,6 +47,7 @@
 
 /dts-v1/;
 #include "stm32f429.dtsi"
+#include "stm32f469-pinctrl.dtsi"
 
 / {
 	model = "STMicroelectronics STM32F469i-DISCO board";
diff --git a/arch/arm/boot/dts/stm32f469-pinctrl.dtsi b/arch/arm/boot/dts/stm32f469-pinctrl.dtsi
new file mode 100644
index 0000000..fff54266
--- /dev/null
+++ b/arch/arm/boot/dts/stm32f469-pinctrl.dtsi
@@ -0,0 +1,96 @@
+/*
+ * Copyright 2017 - Alexandre Torgue <alexandre.torgue@st.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "stm32f4-pinctrl.dtsi"
+
+/ {
+	soc {
+		pinctrl: pin-controller {
+			compatible = "st,stm32f469-pinctrl";
+
+			gpioa: gpio at 40020000 {
+				gpio-ranges = <&pinctrl 0 0 16>;
+			};
+
+			gpiob: gpio at 40020400 {
+				gpio-ranges = <&pinctrl 0 16 16>;
+			};
+
+			gpioc: gpio at 40020800 {
+				gpio-ranges = <&pinctrl 0 32 16>;
+			};
+
+			gpiod: gpio at 40020c00 {
+				gpio-ranges = <&pinctrl 0 48 16>;
+			};
+
+			gpioe: gpio at 40021000 {
+				gpio-ranges = <&pinctrl 0 64 16>;
+			};
+
+			gpiof: gpio at 40021400 {
+				gpio-ranges = <&pinctrl 0 80 16>;
+			};
+
+			gpiog: gpio at 40021800 {
+				gpio-ranges = <&pinctrl 0 96 16>;
+			};
+
+			gpioh: gpio at 40021c00 {
+				gpio-ranges = <&pinctrl 0 112 16>;
+			};
+
+			gpioi: gpio at 40022000 {
+				gpio-ranges = <&pinctrl 0 128 16>;
+			};
+
+			gpioj: gpio at 40022400 {
+				gpio-ranges = <&pinctrl 0 144 6>,
+					      <&pinctrl 12 156 4>;
+			};
+
+			gpiok: gpio at 40022800 {
+				gpio-ranges = <&pinctrl 3 163 5>;
+			};
+		};
+	};
+};
-- 
2.7.4
