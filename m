From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 12 Feb 2015 15:24:42 +0100
Subject: [PATCH 5/5] serial: mctrl-gpio: simplify init routine
In-Reply-To: <1423751082-15888-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1423751082-15888-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1423751082-15888-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of ignoring errors returned by devm_gpiod_get_index use
devm_gpiod_get_index_optional which results in slightly more strict
error handling which is good.

Also use the fourth parameter to devm_gpiod_get_index_optional to be
able to drop the explicit direction setting.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/serial_mctrl_gpio.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index c0381a09f12d..5027db7b5814 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -94,27 +94,20 @@ struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int idx)
 		return ERR_PTR(-ENOMEM);
 
 	for (i = 0; i < UART_GPIO_MAX; i++) {
-		gpios->gpio[i] = devm_gpiod_get_index(dev,
-						      mctrl_gpios_desc[i].name,
-						      idx);
-
-		/*
-		 * The GPIOs are maybe not all filled,
-		 * this is not an error.
-		 */
-		if (IS_ERR_OR_NULL(gpios->gpio[i]))
-			continue;
+		enum gpiod_flags flags;
 
 		if (mctrl_gpios_desc[i].dir_out)
-			err = gpiod_direction_output(gpios->gpio[i], 0);
+			flags = GPIOD_OUT_LOW;
 		else
-			err = gpiod_direction_input(gpios->gpio[i]);
-		if (err) {
-			dev_dbg(dev, "Unable to set direction for %s GPIO",
-				mctrl_gpios_desc[i].name);
-			devm_gpiod_put(dev, gpios->gpio[i]);
-			gpios->gpio[i] = NULL;
-		}
+			flags = GPIOD_IN;
+
+		gpios->gpio[i] =
+			devm_gpiod_get_index_optional(dev,
+						      mctrl_gpios_desc[i].name,
+						      idx, flags);
+
+		if (IS_ERR(gpios->gpio[i]))
+			return PTR_ERR(gpios->gpio[i]);
 	}
 
 	return gpios;
-- 
2.1.4
