From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 12 Feb 2015 15:24:38 +0100
Subject: [PATCH 1/5] serial: atmel: fix error handling when mctrl_gpio_init
 fails
Message-ID: <1423751082-15888-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mctrl_gpio_init at present doesn't return NULL. (It might be used in the
future when no gpios are to be used indicating success.) Properly pass
error returned and also make driver probing fail on error.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/atmel_serial.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 4d848a29e223..8a30342dfa7c 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2507,8 +2507,8 @@ static int atmel_init_gpios(struct atmel_uart_port *p, struct device *dev)
 	struct gpio_desc *gpiod;
 
 	p->gpios = mctrl_gpio_init(dev, 0);
-	if (IS_ERR_OR_NULL(p->gpios))
-		return -1;
+	if (IS_ERR(p->gpios))
+		return PTR_ERR(p->gpios);
 
 	for (i = 0; i < UART_GPIO_MAX; i++) {
 		gpiod = mctrl_gpio_to_gpiod(p->gpios, i);
@@ -2559,9 +2559,10 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	port->uart.line = ret;
 
 	ret = atmel_init_gpios(port, &pdev->dev);
-	if (ret < 0)
-		dev_err(&pdev->dev, "%s",
-			"Failed to initialize GPIOs. The serial port may not work as expected");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to initialize GPIOs.");
+		goto err;
+	}
 
 	ret = atmel_init_port(port, pdev);
 	if (ret)
-- 
2.1.4
