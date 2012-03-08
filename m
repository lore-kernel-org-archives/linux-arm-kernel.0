From: bryan.wu@canonical.com (Bryan Wu)
Date: Thu,  8 Mar 2012 17:11:01 +0800
Subject: [PATCH 1/3] led-class: change back LEDS_CLASS to tristate instead of
 bool
Message-ID: <1331197863-25564-1-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After moving some core functions to led-core.c, led-class.c can be built as
module again.

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 drivers/leds/Kconfig     |    2 +-
 drivers/leds/led-class.c |   70 ----------------------------------------------
 drivers/leds/led-core.c  |   70 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 71 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 9ca28fc..3f17f0d 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -17,7 +17,7 @@ menuconfig NEW_LEDS
 if NEW_LEDS
 
 config LEDS_CLASS
-	bool "LED Class Support"
+	tristate "LED Class Support"
 	help
 	  This option enables the led sysfs class in /sys/class/leds.  You'll
 	  need this to do anything useful with LEDs.  If unsure, say N.
diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 0c8739c..5bff843 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -110,50 +110,6 @@ static void led_timer_function(unsigned long data)
 	mod_timer(&led_cdev->blink_timer, jiffies + msecs_to_jiffies(delay));
 }
 
-static void led_stop_software_blink(struct led_classdev *led_cdev)
-{
-	/* deactivate previous settings */
-	del_timer_sync(&led_cdev->blink_timer);
-	led_cdev->blink_delay_on = 0;
-	led_cdev->blink_delay_off = 0;
-}
-
-static void led_set_software_blink(struct led_classdev *led_cdev,
-				   unsigned long delay_on,
-				   unsigned long delay_off)
-{
-	int current_brightness;
-
-	current_brightness = led_get_brightness(led_cdev);
-	if (current_brightness)
-		led_cdev->blink_brightness = current_brightness;
-	if (!led_cdev->blink_brightness)
-		led_cdev->blink_brightness = led_cdev->max_brightness;
-
-	if (led_get_trigger_data(led_cdev) &&
-	    delay_on == led_cdev->blink_delay_on &&
-	    delay_off == led_cdev->blink_delay_off)
-		return;
-
-	led_stop_software_blink(led_cdev);
-
-	led_cdev->blink_delay_on = delay_on;
-	led_cdev->blink_delay_off = delay_off;
-
-	/* never on - don't blink */
-	if (!delay_on)
-		return;
-
-	/* never off - just set to brightness */
-	if (!delay_off) {
-		led_set_brightness(led_cdev, led_cdev->blink_brightness);
-		return;
-	}
-
-	mod_timer(&led_cdev->blink_timer, jiffies + 1);
-}
-
-
 /**
  * led_classdev_suspend - suspend an led_classdev.
  * @led_cdev: the led_classdev to suspend.
@@ -262,32 +218,6 @@ void led_classdev_unregister(struct led_classdev *led_cdev)
 }
 EXPORT_SYMBOL_GPL(led_classdev_unregister);
 
-void led_blink_set(struct led_classdev *led_cdev,
-		   unsigned long *delay_on,
-		   unsigned long *delay_off)
-{
-	del_timer_sync(&led_cdev->blink_timer);
-
-	if (led_cdev->blink_set &&
-	    !led_cdev->blink_set(led_cdev, delay_on, delay_off))
-		return;
-
-	/* blink with 1 Hz as default if nothing specified */
-	if (!*delay_on && !*delay_off)
-		*delay_on = *delay_off = 500;
-
-	led_set_software_blink(led_cdev, *delay_on, *delay_off);
-}
-EXPORT_SYMBOL(led_blink_set);
-
-void led_brightness_set(struct led_classdev *led_cdev,
-			enum led_brightness brightness)
-{
-	led_stop_software_blink(led_cdev);
-	led_cdev->brightness_set(led_cdev, brightness);
-}
-EXPORT_SYMBOL(led_brightness_set);
-
 static int __init leds_init(void)
 {
 	leds_class = class_create(THIS_MODULE, "leds");
diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index 016d19f..d686004 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -23,3 +23,73 @@ EXPORT_SYMBOL_GPL(leds_list_lock);
 
 LIST_HEAD(leds_list);
 EXPORT_SYMBOL_GPL(leds_list);
+
+static void led_stop_software_blink(struct led_classdev *led_cdev)
+{
+	/* deactivate previous settings */
+	del_timer_sync(&led_cdev->blink_timer);
+	led_cdev->blink_delay_on = 0;
+	led_cdev->blink_delay_off = 0;
+}
+
+static void led_set_software_blink(struct led_classdev *led_cdev,
+				   unsigned long delay_on,
+				   unsigned long delay_off)
+{
+	int current_brightness;
+
+	current_brightness = led_get_brightness(led_cdev);
+	if (current_brightness)
+		led_cdev->blink_brightness = current_brightness;
+	if (!led_cdev->blink_brightness)
+		led_cdev->blink_brightness = led_cdev->max_brightness;
+
+	if (led_get_trigger_data(led_cdev) &&
+	    delay_on == led_cdev->blink_delay_on &&
+	    delay_off == led_cdev->blink_delay_off)
+		return;
+
+	led_stop_software_blink(led_cdev);
+
+	led_cdev->blink_delay_on = delay_on;
+	led_cdev->blink_delay_off = delay_off;
+
+	/* never on - don't blink */
+	if (!delay_on)
+		return;
+
+	/* never off - just set to brightness */
+	if (!delay_off) {
+		led_set_brightness(led_cdev, led_cdev->blink_brightness);
+		return;
+	}
+
+	mod_timer(&led_cdev->blink_timer, jiffies + 1);
+}
+
+
+void led_blink_set(struct led_classdev *led_cdev,
+		   unsigned long *delay_on,
+		   unsigned long *delay_off)
+{
+	del_timer_sync(&led_cdev->blink_timer);
+
+	if (led_cdev->blink_set &&
+	    !led_cdev->blink_set(led_cdev, delay_on, delay_off))
+		return;
+
+	/* blink with 1 Hz as default if nothing specified */
+	if (!*delay_on && !*delay_off)
+		*delay_on = *delay_off = 500;
+
+	led_set_software_blink(led_cdev, *delay_on, *delay_off);
+}
+EXPORT_SYMBOL(led_blink_set);
+
+void led_brightness_set(struct led_classdev *led_cdev,
+			enum led_brightness brightness)
+{
+	led_stop_software_blink(led_cdev);
+	led_cdev->brightness_set(led_cdev, brightness);
+}
+EXPORT_SYMBOL(led_brightness_set);
-- 
1.7.9
