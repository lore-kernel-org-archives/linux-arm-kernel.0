From: simon.guinot@sequanux.org (Simon Guinot)
Date: Sat, 26 Sep 2015 23:02:38 +0200
Subject: [PATCH v6 5/5] leds: netxbig: set led_classdev max_brightness
In-Reply-To: <1443301358-2131-1-git-send-email-simon.guinot@sequanux.org>
References: <1443301358-2131-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1443301358-2131-6-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sets the led_classdev max_brightness to the maximum level
value supported by hardware. This allows to get rid of the brightness
conversion operation (from software [0:LED_FULL] to hardware ranges) in
brightness_set().

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 drivers/leds/leds-netxbig.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
index b166fd9f4186..4b88b93244be 100644
--- a/drivers/leds/leds-netxbig.c
+++ b/drivers/leds/leds-netxbig.c
@@ -116,7 +116,6 @@ struct netxbig_led_data {
 	int			mode_addr;
 	int			*mode_val;
 	int			bright_addr;
-	int			bright_max;
 	struct			netxbig_led_timer *timer;
 	int			num_timer;
 	enum netxbig_led_mode	mode;
@@ -178,7 +177,7 @@ static void netxbig_led_set(struct led_classdev *led_cdev,
 	struct netxbig_led_data *led_dat =
 		container_of(led_cdev, struct netxbig_led_data, cdev);
 	enum netxbig_led_mode mode;
-	int mode_val, bright_val;
+	int mode_val;
 	int set_brightness = 1;
 	unsigned long flags;
 
@@ -204,12 +203,9 @@ static void netxbig_led_set(struct led_classdev *led_cdev,
 	 * SATA LEDs. So, change the brightness setting for a single
 	 * SATA LED will affect all the others.
 	 */
-	if (set_brightness) {
-		bright_val = DIV_ROUND_UP(value * led_dat->bright_max,
-					  LED_FULL);
+	if (set_brightness)
 		gpio_ext_set_value(led_dat->gpio_ext,
-				   led_dat->bright_addr, bright_val);
-	}
+				   led_dat->bright_addr, value);
 
 	spin_unlock_irqrestore(&led_dat->lock, flags);
 }
@@ -306,11 +302,11 @@ static int create_netxbig_led(struct platform_device *pdev,
 	 */
 	led_dat->sata = 0;
 	led_dat->cdev.brightness = LED_OFF;
+	led_dat->cdev.max_brightness = template->bright_max;
 	led_dat->cdev.flags |= LED_CORE_SUSPENDRESUME;
 	led_dat->mode_addr = template->mode_addr;
 	led_dat->mode_val = template->mode_val;
 	led_dat->bright_addr = template->bright_addr;
-	led_dat->bright_max = template->bright_max;
 	led_dat->timer = pdata->timer;
 	led_dat->num_timer = pdata->num_timer;
 	/*
-- 
2.1.4
