From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Mon,  4 Apr 2016 17:22:03 -0300
Subject: [PATCH 2/5] leds: triggers: Add a led_trigger_event_nosleep API
In-Reply-To: <1459801326-5541-1-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1459801326-5541-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <1459801326-5541-3-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can mark any LED (even those in use by delayed blink
triggers) to trigger on a kernel panic, let's introduce a nosleep
led_trigger_event API.

This API is needed to skip the delayed blink path on
led_trigger_event. LEDs that are switched on a kernel panic,
might be in use by a delayed blink trigger.

This will be used by the panic LED trigger.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/leds/led-triggers.c | 26 ++++++++++++++++++++++----
 include/linux/leds.h        |  4 ++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index f5c9d7c4d181..00b9d8497777 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -307,8 +307,9 @@ EXPORT_SYMBOL_GPL(devm_led_trigger_register);
 
 /* Simple LED Tigger Interface */
 
-void led_trigger_event(struct led_trigger *trig,
-			enum led_brightness brightness)
+static void do_led_trigger_event(struct led_trigger *trig,
+				 enum led_brightness brightness,
+				 bool nosleep)
 {
 	struct led_classdev *led_cdev;
 
@@ -316,12 +317,29 @@ void led_trigger_event(struct led_trigger *trig,
 		return;
 
 	read_lock(&trig->leddev_list_lock);
-	list_for_each_entry(led_cdev, &trig->led_cdevs, trig_list)
-		led_set_brightness(led_cdev, brightness);
+	list_for_each_entry(led_cdev, &trig->led_cdevs, trig_list) {
+		if (nosleep)
+			led_set_brightness_nosleep(led_cdev, brightness);
+		else
+			led_set_brightness(led_cdev, brightness);
+	}
 	read_unlock(&trig->leddev_list_lock);
 }
+
+void led_trigger_event(struct led_trigger *trig,
+		       enum led_brightness brightness)
+{
+	do_led_trigger_event(trig, brightness, false);
+}
 EXPORT_SYMBOL_GPL(led_trigger_event);
 
+void led_trigger_event_nosleep(struct led_trigger *trig,
+			       enum led_brightness brightness)
+{
+	do_led_trigger_event(trig, brightness, true);
+}
+EXPORT_SYMBOL_GPL(led_trigger_event_nosleep);
+
 static void led_trigger_blink_setup(struct led_trigger *trig,
 			     unsigned long *delay_on,
 			     unsigned long *delay_off,
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 7f1428bb1e69..d33b230ce66d 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -259,6 +259,8 @@ extern void led_trigger_register_simple(const char *name,
 extern void led_trigger_unregister_simple(struct led_trigger *trigger);
 extern void led_trigger_event(struct led_trigger *trigger,
 				enum led_brightness event);
+extern void led_trigger_event_nosleep(struct led_trigger *trigger,
+				enum led_brightness event);
 extern void led_trigger_blink(struct led_trigger *trigger,
 			      unsigned long *delay_on,
 			      unsigned long *delay_off);
@@ -305,6 +307,8 @@ static inline void led_trigger_register_simple(const char *name,
 static inline void led_trigger_unregister_simple(struct led_trigger *trigger) {}
 static inline void led_trigger_event(struct led_trigger *trigger,
 				enum led_brightness event) {}
+static inline void led_trigger_event_nosleep(struct led_trigger *trigger,
+				enum led_brightness event) {}
 static inline void led_trigger_blink(struct led_trigger *trigger,
 				      unsigned long *delay_on,
 				      unsigned long *delay_off) {}
-- 
2.7.0
