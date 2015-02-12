From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 12 Feb 2015 15:24:41 +0100
Subject: [PATCH 4/5] serial: mctrl-gpio: don't check for struct mctrl_gpios *
 to be invalid
In-Reply-To: <1423751082-15888-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1423751082-15888-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1423751082-15888-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drivers using mctrl-gpio must not pass invalid values for struct
mctrl_gpios *. All drivers were fixed in this regard and so some checks
can go away or be simplified.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/serial_mctrl_gpio.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index a38596c5194e..c0381a09f12d 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -48,9 +48,6 @@ void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
 	int value_array[UART_GPIO_MAX];
 	unsigned int count = 0;
 
-	if (IS_ERR_OR_NULL(gpios))
-		return;
-
 	for (i = 0; i < UART_GPIO_MAX; i++)
 		if (!IS_ERR_OR_NULL(gpios->gpio[i]) &&
 		    mctrl_gpios_desc[i].dir_out) {
@@ -65,10 +62,7 @@ EXPORT_SYMBOL_GPL(mctrl_gpio_set);
 struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
 				      enum mctrl_gpio_idx gidx)
 {
-	if (!IS_ERR_OR_NULL(gpios) && !IS_ERR_OR_NULL(gpios->gpio[gidx]))
-		return gpios->gpio[gidx];
-	else
-		return NULL;
+	return gpios->gpio[gidx];
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
 
@@ -76,15 +70,8 @@ unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl)
 {
 	enum mctrl_gpio_idx i;
 
-	/*
-	 * return it unchanged if the structure is not allocated
-	 */
-	if (IS_ERR_OR_NULL(gpios))
-		return *mctrl;
-
 	for (i = 0; i < UART_GPIO_MAX; i++) {
-		if (!IS_ERR_OR_NULL(gpios->gpio[i]) &&
-		    !mctrl_gpios_desc[i].dir_out) {
+		if (gpios->gpio[i] && !mctrl_gpios_desc[i].dir_out) {
 			if (gpiod_get_value(gpios->gpio[i]))
 				*mctrl |= mctrl_gpios_desc[i].mctrl;
 			else
@@ -138,9 +125,6 @@ void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
 {
 	enum mctrl_gpio_idx i;
 
-	if (IS_ERR_OR_NULL(gpios))
-		return;
-
 	for (i = 0; i < UART_GPIO_MAX; i++)
 		if (!IS_ERR_OR_NULL(gpios->gpio[i]))
 			devm_gpiod_put(dev, gpios->gpio[i]);
-- 
2.1.4
