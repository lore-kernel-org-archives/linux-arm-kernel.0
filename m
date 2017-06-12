From: dmitry.rezvanov@yandex.ru (Dmitry Rezvanov)
Date: Tue, 13 Jun 2017 04:43:14 +0900
Subject: [PATCH] ARM: dts: at91: add support DT for AC97 driver for at91sam9g45
Message-ID: <20170612194314.19289-1-dmitry.rezvanov@yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dmitry Rezvanov <dmitry.rezvanov@yandex.ru>
---
 arch/arm/boot/dts/at91sam9g45.dtsi     | 23 +++++++++++++++++++++--
 arch/arm/boot/dts/at91sam9m10g45ek.dts | 10 +++++++---
 sound/atmel/ac97c.c                    |  3 ++-
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index e567d5fd3f9d..3e9b17935fb3 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -715,7 +715,15 @@
 							 AT91_PIOD 15 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PD15 periph A */
 					};
 				};
-
+				ac97 {
+					pinctrl_ac97: ac97-0 {
+						atmel,pins =
+							<AT91_PIOD 6 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD6 periph A AC97RX pin */
+							 AT91_PIOD 7 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD7 periph A AC97TX pin */
+							 AT91_PIOD 8 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD8 periph A AC97FS pin */
+							 AT91_PIOD 9 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PD9 periph A AC97CK pin */
+					};
+				};
 				spi0 {
 					pinctrl_spi0: spi0-0 {
 						atmel,pins =
@@ -1028,7 +1036,7 @@
 				clock-names = "pclk";
 				status = "disabled";
 			};
-
+			
 			adc0: adc at fffb0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1154,6 +1162,17 @@
 				status = "disabled";
 			};
 
+			ac97: sound at fffac000 {
+				compatible = "atmel,at91sam9g45-ac97c";
+				reg = <0xfffac000 0x4000>;
+				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 4>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_ac97>;
+				clocks = <&ac97_clk>;
+				clock-names = "ac97_clk";
+				status = "disabled";
+			};
+
 			usb2: gadget at fff78000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 2400c99134f7..1f4173a1a90b 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -151,7 +151,7 @@
 				};
 			};
 
-			spi0: spi at fffa4000{
+			spi0: spi at fffa4000 {
 				status = "okay";
 				cs-gpios = <&pioB 3 0>, <0>, <0>, <0>;
 				mtd_dataflash at 0 {
@@ -161,11 +161,15 @@
 				};
 			};
 
+			ac97: sound at fffac000 {
+				status = "okay";
+			};
+
 			usb2: gadget at fff78000 {
 				atmel,vbus-gpio = <&pioB 19 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
-
+			
 			adc0: adc at fffb0000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <
@@ -306,7 +310,7 @@
 			linux,default-trigger = "mmc0";
 		};
 	};
-
+	
 	gpio_keys {
 		compatible = "gpio-keys";
 
diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 6dad042630d8..8ffb3744e435 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -908,7 +908,8 @@ static void atmel_ac97c_reset(struct atmel_ac97c *chip)
 #ifdef CONFIG_OF
 static const struct of_device_id atmel_ac97c_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9263-ac97c", },
-	{ }
+	{ .compatible = "atmel,at91sam9g45-ac97c"},
+	{}
 };
 MODULE_DEVICE_TABLE(of, atmel_ac97c_dt_ids);
 
-- 
2.11.0
