From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 16 Sep 2015 17:36:58 +0200
Subject: [PATCH v2 2/7] pinctrl: dt-binding: Add DT binding documentation for
 Atmel PIO4
In-Reply-To: <1442417823-15850-1-git-send-email-ludovic.desroches@atmel.com>
References: <1442417823-15850-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1442417823-15850-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for the Atmel PIO4 controller introduced with SAMA5D2
chip family.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../bindings/pinctrl/atmel,at91-pio4-pinctrl.txt   | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
new file mode 100644
index 0000000..61ac757
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
@@ -0,0 +1,90 @@
+* Atmel PIO4 Controller
+
+The Atmel PIO4 controller is used to select the function of a pin and to
+configure it.
+
+Required properties:
+- compatible: "atmel,sama5d2-pinctrl".
+- reg: base address and length of the PIO controller.
+- interrupts: interrupt outputs from the controller, one for each bank.
+- interrupt-controller: mark the device node as an interrupt controller.
+- #interrupt-cells: should be two.
+- gpio-controller: mark the device node as a gpio controller.
+- #gpio-cells: should be two.
+
+Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
+a general description of GPIO and interrupt bindings.
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices.
+
+Subnode format
+Each node (or subnode) will list the pins it needs and how to configured these
+pins.
+
+	node {
+		pinmux = <PIN_NUMBER_PINMUX>;
+		GENERIC_PINCONFIG;
+	};
+
+Required properties:
+- pinmux: integer array. Each integer represents a pin number plus mux and
+ioset settings. Use the macros from boot/dts/<soc>-pinfunc.h file to get the
+right representation of the pin.
+
+Optional properties:
+- GENERIC_PINCONFIG: generic pinconfig options to use, bias-disable,
+bias-pull-down, bias-pull-up, drive-open-drain, input-schmitt-enable,
+input-debounce, output-low, output-high.
+
+Example:
+
+#include <sama5d2-pinfunc.h>
+
+...
+{
+	pioA: pinctrl at fc038000 {
+		compatible = "atmel,sama5d2-pinctrl";
+		reg = <0xfc038000 0x600>;
+		interrupts = <18 IRQ_TYPE_LEVEL_HIGH 7>,
+			     <68 IRQ_TYPE_LEVEL_HIGH 7>,
+			     <69 IRQ_TYPE_LEVEL_HIGH 7>,
+			     <70 IRQ_TYPE_LEVEL_HIGH 7>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		clocks = <&pioA_clk>;
+
+		pinctrl_i2c0_default: i2c0_default {
+			pinmux = <PIN_PD21__TWD0>,
+				 <PIN_PD22__TWCK0>;
+			bias-disable;
+		};
+
+		pinctrl_led_gpio_default: led_gpio_default {
+			pinmux = <PIN_PB0>,
+				 <PIN_PB5>;
+			bias-pull-up;
+		};
+
+		pinctrl_sdmmc1_default: sdmmc1_default {
+			cmd_data {
+				pinmux = <PIN_PA28__SDMMC1_CMD>,
+					 <PIN_PA18__SDMMC1_DAT0>,
+					 <PIN_PA19__SDMMC1_DAT1>,
+					 <PIN_PA20__SDMMC1_DAT2>,
+					 <PIN_PA21__SDMMC1_DAT3>;
+				bias-pull-up;
+			};
+
+			ck_cd {
+				pinmux = <PIN_PA22__SDMMC1_CK>,
+					 <PIN_PA30__SDMMC1_CD>;
+				bias-disable;
+			};
+		};
+		...
+	};
+};
+...
-- 
2.5.0
