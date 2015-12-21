From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 21 Dec 2015 10:24:11 +0100
Subject: [PATCH 4/5] ARM: at91/dt: sama5d2 Xplained: enable the adc device
In-Reply-To: <1450689852-22763-1-git-send-email-ludovic.desroches@atmel.com>
References: <1450689852-22763-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1450689852-22763-5-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the adc on the sama5d2 Xplained board.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index c2fcc29..6b263d4 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -251,7 +251,29 @@
 				};
 			};
 
+			adc: adc at fc030000 {
+				vddana-supply = <&vdd_3v3_lp_reg>;
+				vref-supply = <&vdd_3v3_lp_reg>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_adc_default>;
+				status = "okay";
+			};
+
 			pinctrl at fc038000 {
+				/*
+				 * There is no real pinmux for ADC, if the pin
+				 * is not requested by another peripheral then
+				 * the muxing is done when channel is enabled.
+				 * Requesting pins for ADC is GPIO is
+				 * encouraged to prevent conflicts and to
+				 * disable bias in order to be in the same
+				 * state when the pin is not muxed to the adc.
+				 */
+				pinctrl_adc_default: adc_default {
+					pinmux = <PIN_PD23__GPIO>;
+					bias-disable;
+				};
+
 				pinctrl_flx0_default: flx0_default {
 					pinmux = <PIN_PB28__FLEXCOM0_IO0>,
 						 <PIN_PB29__FLEXCOM0_IO1>;
-- 
2.5.0
