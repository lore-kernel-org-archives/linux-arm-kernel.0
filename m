From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Sep 2013 14:31:23 +0200
Subject: [PATCH 5/7] staging: media/lirc: switch to use gpiolib
Message-ID: <1378816283-8164-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The lirc serial module has special hooks to work with NSLU2,
switch these over to use gpiolib, as that is available on the
ixp4 platform.

Not even compile tested as there is no way to select this
driver from menuconfig on the ixp4 platform.

Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Greg: I'm seeking an ACK on this patch to take it through
the GPIO tree as part of a clean-up attempt to remove custom
GPIO APIs.
---
 drivers/staging/media/lirc/lirc_serial.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/lirc/lirc_serial.c b/drivers/staging/media/lirc/lirc_serial.c
index af08e67..f6bc4c9 100644
--- a/drivers/staging/media/lirc/lirc_serial.c
+++ b/drivers/staging/media/lirc/lirc_serial.c
@@ -67,7 +67,7 @@
 #include <linux/delay.h>
 #include <linux/poll.h>
 #include <linux/platform_device.h>
-
+#include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/fcntl.h>
@@ -321,7 +321,7 @@ static void on(void)
 	 * status LED and ground
 	 */
 	if (type == LIRC_NSLU2) {
-		gpio_line_set(NSLU2_LED_GRN, IXP4XX_GPIO_LOW);
+		gpio_set_value(NSLU2_LED_GRN, 0);
 		return;
 	}
 #endif
@@ -335,7 +335,7 @@ static void off(void)
 {
 #ifdef CONFIG_LIRC_SERIAL_NSLU2
 	if (type == LIRC_NSLU2) {
-		gpio_line_set(NSLU2_LED_GRN, IXP4XX_GPIO_HIGH);
+		gpio_set_value(NSLU2_LED_GRN, 1);
 		return;
 	}
 #endif
@@ -839,6 +839,16 @@ static int lirc_serial_probe(struct platform_device *dev)
 {
 	int i, nlow, nhigh, result;
 
+#ifdef CONFIG_LIRC_SERIAL_NSLU2
+	/* This GPIO is used for a LED on the NSLU2 */
+	result = devm_gpio_request(dev, NSLU2_LED_GRN, "lirc-serial");
+	if (result)
+		return result;
+	result = gpio_direction_output(NSLU2_LED_GRN, 0);
+	if (result)
+		return result;
+#endif
+
 	result = request_irq(irq, irq_handler,
 			     (share_irq ? IRQF_SHARED : 0),
 			     LIRC_DRIVER_NAME, (void *)&hardware);
-- 
1.8.3.1
