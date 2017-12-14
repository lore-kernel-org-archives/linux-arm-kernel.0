From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Thu, 14 Dec 2017 15:21:37 +0100
Subject: [RFC PATCH 6/7] pinctrl: at91-pio4: use strict mode if explicitly
 requested
In-Reply-To: <20171214142138.23008-1-ludovic.desroches@microchip.com>
References: <20171214142138.23008-1-ludovic.desroches@microchip.com>
Message-ID: <20171214142138.23008-7-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a property to use pinmux strict mode. It corresponds to the
legacy behavior of the controller. It was not used because there
were no solution to configure (open drain, bias, etc) a pin
requested as a GPIO.

If the strict mode is used by default, it will break several boards.
The owner of a GPIO requested by a device is not the device itself
but the pinctrl. So there is an ownership mismatch since the owner
of the pinmuxing is the device which requested it. It will lead to
an error when requesting the GPIO.

By adding a DT property, we can enable it only for DTs which are
written correctly.

The gpio_request_enable operation is needed to mux the pin as a
GPIO but it has to be used only if strict mode is enabled. If not,
a pin muxed to a device may be muxed to a GPIO silently.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 .../bindings/pinctrl/atmel,at91-pio4-pinctrl.txt   |  4 ++++
 drivers/pinctrl/pinctrl-at91-pio4.c                | 24 +++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
index 61ac75706cc9..440cb5687b4e 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
@@ -11,6 +11,10 @@ Required properties:
 - #interrupt-cells: should be two.
 - gpio-controller: mark the device node as a gpio controller.
 - #gpio-cells: should be two.
+Optional properties:
+- atmel,use-strict-mode: enable the pinmux strict mode which prevents
+simultaneous use of the same pin for GPIO and another function. It implies to
+not put a pin requested as a GPIO in the pinmux property.
 
 Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
 a general description of GPIO and interrupt bindings.
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 4b8dda770af8..6acbbcc9b4a6 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -358,6 +358,8 @@ static int atmel_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 }
 
 static struct gpio_chip atmel_gpio_chip = {
+	.request		= gpiochip_generic_request,
+	.free			= gpiochip_generic_free,
 	.direction_input        = atmel_gpio_direction_input,
 	.get                    = atmel_gpio_get,
 	.direction_output       = atmel_gpio_direction_output,
@@ -644,7 +646,22 @@ static int atmel_pmx_set_mux(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static const struct pinmux_ops atmel_pmxops = {
+static int atmel_pmx_gpio_request_enable(struct pinctrl_dev *pctldev,
+					 struct pinctrl_gpio_range *range,
+					 unsigned offset)
+{
+	u32 conf;
+
+	conf = atmel_pin_config_read(pctldev, offset);
+	conf &= (~ATMEL_PIO_CFGR_FUNC_MASK);
+	atmel_pin_config_write(pctldev, offset, conf);
+
+	dev_dbg(pctldev->dev, "enable pin %u as GPIO\n", offset);
+
+	return 0;
+}
+
+static struct pinmux_ops atmel_pmxops = {
 	.get_functions_count	= atmel_pmx_get_functions_count,
 	.get_function_name	= atmel_pmx_get_function_name,
 	.get_function_groups	= atmel_pmx_get_function_groups,
@@ -930,6 +947,11 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 	atmel_pioctrl->nbanks = atmel_pioctrl_data->nbanks;
 	atmel_pioctrl->npins = atmel_pioctrl->nbanks * ATMEL_PIO_NPINS_PER_BANK;
 
+	if (of_property_read_bool(dev->of_node, "atmel,use-strict-mode")) {
+		atmel_pmxops.strict = true;
+		atmel_pmxops.gpio_request_enable = atmel_pmx_gpio_request_enable;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "unable to get atmel pinctrl resource\n");
-- 
2.12.2
