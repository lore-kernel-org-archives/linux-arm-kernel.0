From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 15 Apr 2014 13:07:43 +0200
Subject: [PATCH 2/2] ARM: at91/dt: add peripherals to the at91sam9rlek board
In-Reply-To: <1397560063-7439-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1397560063-7439-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1397560063-7439-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for:
 - SPI
 - Dataflash
 - LCD
 - i2c
 - ADC
 - Touchscreen
 - USB gadget
 - PWM

Also it switches the ds1 and ds2 leds to PWM control.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9rlek.dts | 90 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/at91sam9rlek.dts
index cddb37825fad..f148fa4b3ab9 100644
--- a/arch/arm/boot/dts/at91sam9rlek.dts
+++ b/arch/arm/boot/dts/at91sam9rlek.dts
@@ -32,6 +32,37 @@
 	};
 
 	ahb {
+		fb0: fb at 00500000 {
+			display = <&display0>;
+			status = "okay";
+
+			display0: display {
+				bits-per-pixel = <16>;
+				atmel,lcdcon-backlight;
+				atmel,dmacon = <0x1>;
+				atmel,lcdcon2 = <0x80008002>;
+				atmel,guard-time = <1>;
+				atmel,lcd-wiring-mode = "RGB";
+
+				display-timings {
+					native-mode = <&timing0>;
+					timing0: timing0 {
+						clock-frequency = <4965000>;
+						hactive = <240>;
+						vactive = <320>;
+						hback-porch = <1>;
+						hfront-porch = <33>;
+						vback-porch = <1>;
+						vfront-porch = <0>;
+						hsync-len = <5>;
+						vsync-len = <1>;
+						hsync-active = <1>;
+						vsync-active = <1>;
+					};
+				};
+			};
+		};
+
 		nand0: nand at 40000000 {
 			nand-bus-width = <8>;
 			nand-ecc-mode = "soft";
@@ -92,6 +123,43 @@
 				status = "okay";
 			};
 
+			adc0: adc at fffd0000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <
+					&pinctrl_adc0_ad0
+					&pinctrl_adc0_ad1
+					&pinctrl_adc0_ad2
+					&pinctrl_adc0_ad3
+					&pinctrl_adc0_ad4
+					&pinctrl_adc0_ad5
+					&pinctrl_adc0_adtrg>;
+				atmel,adc-ts-wires = <4>;
+				status = "okay";
+			};
+
+			usb0: gadget at fffd4000 {
+				atmel,vbus-gpio = <&pioA 8 GPIO_ACTIVE_HIGH>;
+				status = "okay";
+			};
+
+			spi0: spi at fffcc000 {
+				status = "okay";
+				cs-gpios = <&pioA 28 0>, <0>, <0>, <0>;
+				mtd_dataflash at 0 {
+					compatible = "atmel,at45", "atmel,dataflash";
+					spi-max-frequency = <15000000>;
+					reg = <0>;
+				};
+			};
+
+			pwm0: pwm at fffc8000 {
+				status = "okay";
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_pwm0_pwm1_2>,
+					<&pinctrl_pwm0_pwm2_2>;
+			};
+
 			dbgu: serial at fffff200 {
 				status = "okay";
 			};
@@ -117,18 +185,24 @@
 		};
 	};
 
-	leds {
-		compatible = "gpio-leds";
+	pwmleds {
+		compatible = "pwm-leds";
 
 		ds1 {
 			label = "ds1";
-			gpios = <&pioD 15 GPIO_ACTIVE_LOW>;
+			pwms = <&pwm0 1 5000 PWM_POLARITY_INVERTED>;
+			max-brightness = <255>;
 		};
 
 		ds2 {
 			label = "ds2";
-			gpios = <&pioD 16 GPIO_ACTIVE_LOW>;
+			pwms = <&pwm0 2 5000 PWM_POLARITY_INVERTED>;
+			max-brightness = <255>;
 		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
 
 		ds3 {
 			label = "ds3";
@@ -154,4 +228,12 @@
 			gpio-key,wakeup;
 		};
 	};
+
+	i2c at 0 {
+		status = "okay";
+	};
+
+	i2c at 1 {
+		status = "okay";
+	};
 };
-- 
1.8.3.2
