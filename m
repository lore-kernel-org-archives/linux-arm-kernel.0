From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 5 Nov 2013 16:29:43 +0100
Subject: [PATCH] ARM/serial: at91: specify RTS in DT using gpio
In-Reply-To: <1383654959-18112-1-git-send-email-linus.walleij@linaro.org>
References: <1383654959-18112-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1383665383-5606-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 Documentation/devicetree/bindings/serial/atmel-usart.txt |  3 +++
 drivers/tty/serial/atmel_serial.c                        | 13 ++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
index 2191dcb..3adc61c 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
@@ -10,6 +10,8 @@ Required properties:
 Optional properties:
 - atmel,use-dma-rx: use of PDC or DMA for receiving data
 - atmel,use-dma-tx: use of PDC or DMA for transmitting data
+- rts-gpios: specify a GPIO for RTS line. It will use specified PIO instead of the peripheral
+  function pin for the USART RTS feature. If unsure, don't specify this property.
 - add dma bindings for dma transfer:
 	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
 		memory peripheral interface and USART DMA channel ID, FIFO configuration.
@@ -28,6 +30,7 @@ Example:
 		interrupts = <7>;
 		atmel,use-dma-rx;
 		atmel,use-dma-tx;
+		rts-gpios = <&pioD 15 0>;
 	};
 
 - use DMA:
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index b4e0794..71f8ea9 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -35,6 +35,7 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/dma-mapping.h>
 #include <linux/atmel_pdc.h>
 #include <linux/atmel_serial.h>
@@ -2327,6 +2328,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct atmel_uart_data *pdata = dev_get_platdata(&pdev->dev);
 	void *data;
+	int rts_pin = -EINVAL;
 	int ret = -ENODEV;
 
 	BUILD_BUG_ON(ATMEL_SERIAL_RINGSIZE & (ATMEL_SERIAL_RINGSIZE - 1));
@@ -2364,13 +2366,18 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	 * structs to indicate "no RTS GPIO" instead of open-coding some
 	 * invalid value everywhere.
 	 */
-	if (pdata->rts_gpio > 0) {
-		ret = devm_gpio_request(&pdev->dev, pdata->rts_gpio, "RTS");
+	if (pdata && pdata->rts_gpio > 0)
+		rts_pin = pdata->rts_gpio;
+	else if (np)
+		rts_pin = of_get_named_gpio(np, "rts-gpios", 0);
+
+	if (gpio_is_valid(rts_pin)) {
+		ret = devm_gpio_request(&pdev->dev, rts_pin, "RTS");
 		if (ret) {
 			dev_err(&pdev->dev, "error requesting RTS GPIO\n");
 			goto err;
 		}
-		port->rts_gpio = pdata->rts_gpio;
+		port->rts_gpio = rts_pin;
 		ret = gpio_direction_output(port->rts_gpio, 0);
 		if (ret) {
 			dev_err(&pdev->dev, "error setting up RTS GPIO\n");
-- 
1.8.2.2
