From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Thu, 14 Dec 2017 15:21:38 +0100
Subject: [RFC PATCH 7/7] ARM: dts: at91-sama5d2_xplained: remove gpios from
 pinmux
In-Reply-To: <20171214142138.23008-1-ludovic.desroches@microchip.com>
References: <20171214142138.23008-1-ludovic.desroches@microchip.com>
Message-ID: <20171214142138.23008-8-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we can setup the pin configuration of a GPIO through the gpiolib,
enable the pinmuxing strict mode and remove GPIOs from the pinmuxing.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 45 +++++------------------------
 1 file changed, 7 insertions(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 56de21de2779..9e0bf162e6bd 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -68,20 +68,16 @@
 
 	ahb {
 		usb0: gadget at 300000 {
-			atmel,vbus-gpio = <&pioA PIN_PA31 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_usba_vbus>;
+			atmel,vbus-gpio = <&pioA PIN_PA31 (GPIO_ACTIVE_LOW | GPIO_BIAS_PULL_UP)>;
 			status = "okay";
 		};
 
 		usb1: ohci at 400000 {
 			num-ports = <3>;
 			atmel,vbus-gpio = <0 /* &pioA PIN_PB9 GPIO_ACTIVE_HIGH */
-					   &pioA PIN_PB10 GPIO_ACTIVE_HIGH
+					   &pioA PIN_PB10 (GPIO_ACTIVE_LOW | GPIO_BIAS_PULL_UP)
 					   0
 					  >;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_usb_default>;
 			status = "okay";
 		};
 
@@ -325,6 +321,7 @@
 			};
 
 			pinctrl at fc038000 {
+				atmel,use-strict-mode;
 				/*
 				 * There is no real pinmux for ADC, if the pin
 				 * is not requested by another peripheral then
@@ -412,18 +409,6 @@
 					bias-disable;
 				};
 
-				pinctrl_key_gpio_default: key_gpio_default {
-					pinmux = <PIN_PB9__GPIO>;
-					bias-pull-up;
-				};
-
-				pinctrl_led_gpio_default: led_gpio_default {
-					pinmux = <PIN_PB0__GPIO>,
-						 <PIN_PB5__GPIO>,
-						 <PIN_PB6__GPIO>;
-					bias-pull-up;
-				};
-
 				pinctrl_macb0_default: macb0_default {
 					pinmux = <PIN_PB14__GTXCK>,
 						 <PIN_PB15__GTXEN>,
@@ -509,16 +494,6 @@
 					bias-disable;
 				};
 
-				pinctrl_usb_default: usb_default {
-					pinmux = <PIN_PB10__GPIO>;
-					bias-disable;
-				};
-
-				pinctrl_usba_vbus: usba_vbus {
-					pinmux = <PIN_PA31__GPIO>;
-					bias-disable;
-				};
-
 				pinctrl_pwm0_pwm2_default: pwm0_pwm2_default {
 					pinmux = <PIN_PB5__PWMH2>,
 						 <PIN_PB6__PWML2>;
@@ -544,13 +519,9 @@
 
 	gpio_keys {
 		compatible = "gpio-keys";
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_key_gpio_default>;
-
 		bp1 {
 			label = "PB_USER";
-			gpios = <&pioA PIN_PB9 GPIO_ACTIVE_LOW>;
+			gpios = <&pioA PIN_PB9 (GPIO_ACTIVE_LOW | GPIO_BIAS_PULL_UP)>;
 			linux,code = <0x104>;
 			wakeup-source;
 		};
@@ -558,24 +529,22 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_led_gpio_default>;
 		status = "okay"; /* conflict with pwm0 */
 
 		red {
 			label = "red";
-			gpios = <&pioA PIN_PB6 GPIO_ACTIVE_LOW>;
+			gpios = <&pioA PIN_PB6 (GPIO_ACTIVE_LOW | GPIO_BIAS_PULL_UP)>;
 		};
 
 
 		green {
 			label = "green";
-			gpios = <&pioA PIN_PB5 GPIO_ACTIVE_LOW>;
+			gpios = <&pioA PIN_PB5 (GPIO_ACTIVE_LOW | GPIO_BIAS_PULL_UP)>;
 		};
 
 		blue {
 			label = "blue";
-			gpios = <&pioA PIN_PB0 GPIO_ACTIVE_LOW>;
+			gpios = <&pioA PIN_PB0 (GPIO_ACTIVE_LOW | GPIO_BIAS_PULL_UP)>;
 			linux,default-trigger = "heartbeat";
 		};
 	};
-- 
2.12.2
