From: simon.guinot@sequanux.org (Simon Guinot)
Date: Wed,  4 Mar 2015 15:52:18 +0100
Subject: [PATCH 3/4] leds: leds-ns2: handle can_sleep GPIOs
In-Reply-To: <1425480739-2373-1-git-send-email-simon.guinot@sequanux.org>
References: <1425480739-2373-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1425480739-2373-4-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the board n090401 (Seagate NAS 4-Bay), some of the LEDs are handled
by the leds-ns2 driver. This LEDs are connected to an I2C GPIO expander
(PCA95554PW) which means that GPIO access may sleep. This patch makes
leds-ns2 compatible with such GPIOs by using the *_cansleep() variant of
the GPIO functions. As a drawback this functions can't be used safely in
a timer context (with the timer LED trigger for example). To fix this
issue, a workqueue mechanism (copied from the leds-gpio driver) is used.

Note that this patch also updates slightly the ns2_led_sata_store
function. The LED state is now retrieved from cached values instead of
reading the GPIOs previously. This prevents ns2_led_sata_store from
working with a stale LED state (which may happen when a delayed work
is pending).

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
Signed-off-by: Vincent Donnefort <vdonnefort@gmail.com>
---
 drivers/leds/leds-ns2.c | 56 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/leds/leds-ns2.c b/drivers/leds/leds-ns2.c
index b0bc03539dbb..ea1542db9ba4 100644
--- a/drivers/leds/leds-ns2.c
+++ b/drivers/leds/leds-ns2.c
@@ -31,6 +31,7 @@
 #include <linux/platform_data/leds-kirkwood-ns2.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include "leds.h"
 
 /*
  * The Network Space v2 dual-GPIO LED is wired to a CPLD. Three different LED
@@ -43,12 +44,29 @@ struct ns2_led_data {
 	struct led_classdev	cdev;
 	unsigned		cmd;
 	unsigned		slow;
+	bool			can_sleep;
+	int			new_mode_index;
 	unsigned char		sata; /* True when SATA mode active. */
 	rwlock_t		rw_lock; /* Lock GPIOs. */
+	struct work_struct	work;
 	int			num_modes;
 	struct ns2_led_modval	*modval;
 };
 
+static void ns2_led_work(struct work_struct *work)
+{
+	struct ns2_led_data *led_dat =
+		container_of(work, struct ns2_led_data, work);
+	int i = led_dat->new_mode_index;
+
+	write_lock(&led_dat->rw_lock);
+
+	gpio_set_value_cansleep(led_dat->cmd, led_dat->modval[i].cmd_level);
+	gpio_set_value_cansleep(led_dat->slow, led_dat->modval[i].slow_level);
+
+	write_unlock(&led_dat->rw_lock);
+}
+
 static int ns2_led_get_mode(struct ns2_led_data *led_dat,
 			    enum ns2_led_modes *mode)
 {
@@ -59,8 +77,8 @@ static int ns2_led_get_mode(struct ns2_led_data *led_dat,
 
 	read_lock_irq(&led_dat->rw_lock);
 
-	cmd_level = gpio_get_value(led_dat->cmd);
-	slow_level = gpio_get_value(led_dat->slow);
+	cmd_level = gpio_get_value_cansleep(led_dat->cmd);
+	slow_level = gpio_get_value_cansleep(led_dat->slow);
 
 	for (i = 0; i < led_dat->num_modes; i++) {
 		if (cmd_level == led_dat->modval[i].cmd_level &&
@@ -85,7 +103,13 @@ static void ns2_led_set_mode(struct ns2_led_data *led_dat,
 	write_lock_irqsave(&led_dat->rw_lock, flags);
 
 	for (i = 0; i < led_dat->num_modes; i++) {
-		if (mode == led_dat->modval[i].mode) {
+		if (mode != led_dat->modval[i].mode)
+			continue;
+
+		if (led_dat->can_sleep) {
+			led_dat->new_mode_index = i;
+			schedule_work(&led_dat->work);
+		} else {
 			gpio_set_value(led_dat->cmd,
 				       led_dat->modval[i].cmd_level);
 			gpio_set_value(led_dat->slow,
@@ -122,7 +146,6 @@ static ssize_t ns2_led_sata_store(struct device *dev,
 		container_of(led_cdev, struct ns2_led_data, cdev);
 	int ret;
 	unsigned long enable;
-	enum ns2_led_modes mode;
 
 	ret = kstrtoul(buff, 10, &enable);
 	if (ret < 0)
@@ -131,19 +154,19 @@ static ssize_t ns2_led_sata_store(struct device *dev,
 	enable = !!enable;
 
 	if (led_dat->sata == enable)
-		return count;
+		goto exit;
 
-	ret = ns2_led_get_mode(led_dat, &mode);
-	if (ret < 0)
-		return ret;
+	led_dat->sata = enable;
+
+	if (!led_get_brightness(led_cdev))
+		goto exit;
 
-	if (enable && mode == NS_V2_LED_ON)
+	if (enable)
 		ns2_led_set_mode(led_dat, NS_V2_LED_SATA);
-	if (!enable && mode == NS_V2_LED_SATA)
+	else
 		ns2_led_set_mode(led_dat, NS_V2_LED_ON);
 
-	led_dat->sata = enable;
-
+exit:
 	return count;
 }
 
@@ -173,7 +196,7 @@ create_ns2_led(struct platform_device *pdev, struct ns2_led_data *led_dat,
 	enum ns2_led_modes mode;
 
 	ret = devm_gpio_request_one(&pdev->dev, template->cmd,
-			gpio_get_value(template->cmd) ?
+			gpio_get_value_cansleep(template->cmd) ?
 			GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
 			template->name);
 	if (ret) {
@@ -183,7 +206,7 @@ create_ns2_led(struct platform_device *pdev, struct ns2_led_data *led_dat,
 	}
 
 	ret = devm_gpio_request_one(&pdev->dev, template->slow,
-			gpio_get_value(template->slow) ?
+			gpio_get_value_cansleep(template->slow) ?
 			GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
 			template->name);
 	if (ret) {
@@ -202,6 +225,8 @@ create_ns2_led(struct platform_device *pdev, struct ns2_led_data *led_dat,
 	led_dat->cdev.groups = ns2_led_groups;
 	led_dat->cmd = template->cmd;
 	led_dat->slow = template->slow;
+	led_dat->can_sleep = gpio_cansleep(led_dat->cmd) |
+				gpio_cansleep(led_dat->slow);
 	led_dat->modval = template->modval;
 	led_dat->num_modes = template->num_modes;
 
@@ -214,6 +239,8 @@ create_ns2_led(struct platform_device *pdev, struct ns2_led_data *led_dat,
 	led_dat->cdev.brightness =
 		(mode == NS_V2_LED_OFF) ? LED_OFF : LED_FULL;
 
+	INIT_WORK(&led_dat->work, ns2_led_work);
+
 	ret = led_classdev_register(&pdev->dev, &led_dat->cdev);
 	if (ret < 0)
 		return ret;
@@ -224,6 +251,7 @@ create_ns2_led(struct platform_device *pdev, struct ns2_led_data *led_dat,
 static void delete_ns2_led(struct ns2_led_data *led_dat)
 {
 	led_classdev_unregister(&led_dat->cdev);
+	cancel_work_sync(&led_dat->work);
 }
 
 #ifdef CONFIG_OF_GPIO
-- 
2.1.1
