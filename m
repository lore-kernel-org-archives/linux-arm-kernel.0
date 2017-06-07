From: bo.zhang@nxp.com (Zhang Bo)
Date: Wed,  7 Jun 2017 10:50:10 +0800
Subject: [[PATCH v2]] drivers: leds/trigger: system cannot enter suspend
Message-ID: <1496803810-57154-1-git-send-email-bo.zhang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

System cannot enter suspend mode because of heartbeat led trigger.
In autosleep_wq, try_to_suspend function will try to enter suspend
mode in specific period. it will get wakeup_count then call pm_notifier
chain callback function and freeze processes.
Heartbeat_pm_notifier is called and it call led_trigger_unregister to
change the trigger of led device to none. It will send uevent message
and the wakeup source count changed.

Add suspend/resume ops to the struct led_trigger, implement these two ops
for ledtrig-heartbeat. Add led_trigger_suspend/led_trigger_resume funcitons
to iterate through all LED class devices registered on given trigger and
call their suspend/resume ops and disable/enable sysfs at the same time.

Call led_trigger_suspend{resuem} API in pm_notifier function to
suspend/resume all led devices listed in given trigger.

Signed-off-by: Zhang Bo <bo.zhang@nxp.com>
---
 drivers/leds/led-triggers.c              | 30 +++++++++++++++++++++++++++
 drivers/leds/trigger/ledtrig-heartbeat.c | 35 ++++++++++++++++++++++++++------
 include/linux/leds.h                     |  6 ++++++
 3 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index 431123b..b239907 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -333,6 +333,36 @@ void led_trigger_blink_oneshot(struct led_trigger *trig,
 }
 EXPORT_SYMBOL_GPL(led_trigger_blink_oneshot);
 
+void led_trigger_suspend(struct led_trigger *trig)
+{
+	struct led_classdev *led_cdev;
+
+	if (!trig)
+		return;
+
+	read_lock(&trig->leddev_list_lock);
+	list_for_each_entry(led_cdev, &trig->led_cdevs, trig_list)
+		if (led_cdev->trigger->suspend)
+			led_cdev->trigger->suspend(led_cdev);
+	read_unlock(&trig->leddev_list_lock);
+}
+EXPORT_SYMBOL_GPL(led_trigger_suspend);
+
+void led_trigger_resume(struct led_trigger *trig)
+{
+	struct led_classdev *led_cdev;
+
+	if (!trig)
+		return;
+
+	read_lock(&trig->leddev_list_lock);
+	list_for_each_entry(led_cdev, &trig->led_cdevs, trig_list)
+		if (led_cdev->trigger->resume)
+			led_cdev->trigger->resume(led_cdev);
+	read_unlock(&trig->leddev_list_lock);
+}
+EXPORT_SYMBOL_GPL(led_trigger_resume);
+
 void led_trigger_register_simple(const char *name, struct led_trigger **tp)
 {
 	struct led_trigger *trig;
diff --git a/drivers/leds/trigger/ledtrig-heartbeat.c b/drivers/leds/trigger/ledtrig-heartbeat.c
index afa3b40..8f779dd 100644
--- a/drivers/leds/trigger/ledtrig-heartbeat.c
+++ b/drivers/leds/trigger/ledtrig-heartbeat.c
@@ -142,6 +142,7 @@ static void heartbeat_trig_activate(struct led_classdev *led_cdev)
 	led_heartbeat_function(heartbeat_data->timer.data);
 	set_bit(LED_BLINK_SW, &led_cdev->work_flags);
 	led_cdev->activated = true;
+	led_cdev->suspended = false;
 }
 
 static void heartbeat_trig_deactivate(struct led_classdev *led_cdev)
@@ -154,6 +155,30 @@ static void heartbeat_trig_deactivate(struct led_classdev *led_cdev)
 		kfree(heartbeat_data);
 		clear_bit(LED_BLINK_SW, &led_cdev->work_flags);
 		led_cdev->activated = false;
+		led_cdev->suspended = false;
+	}
+}
+
+static void heartbeat_trig_resume(struct led_classdev *led_cdev)
+{
+	struct heartbeat_trig_data *heartbeat_data = led_cdev->trigger_data;
+
+	if (led_cdev->suspended) {
+		setup_timer(&heartbeat_data->timer,
+			    led_heartbeat_function, (unsigned long) led_cdev);
+		heartbeat_data->phase = 0;
+		led_heartbeat_function(heartbeat_data->timer.data);
+		led_cdev->suspended = false;
+	}
+}
+
+static void heartbeat_trig_suspend(struct led_classdev *led_cdev)
+{
+	struct heartbeat_trig_data *heartbeat_data = led_cdev->trigger_data;
+
+	if (led_cdev->activated && !led_cdev->suspended) {
+		del_timer_sync(&heartbeat_data->timer);
+		led_cdev->suspended = true;
 	}
 }
 
@@ -161,25 +186,23 @@ static void heartbeat_trig_deactivate(struct led_classdev *led_cdev)
 	.name     = "heartbeat",
 	.activate = heartbeat_trig_activate,
 	.deactivate = heartbeat_trig_deactivate,
+	.suspend = heartbeat_trig_suspend,
+	.resume = heartbeat_trig_resume,
 };
 
 static int heartbeat_pm_notifier(struct notifier_block *nb,
 				 unsigned long pm_event, void *unused)
 {
-	int rc;
-
 	switch (pm_event) {
 	case PM_SUSPEND_PREPARE:
 	case PM_HIBERNATION_PREPARE:
 	case PM_RESTORE_PREPARE:
-		led_trigger_unregister(&heartbeat_led_trigger);
+		led_trigger_suspend(&heartbeat_led_trigger);
 		break;
 	case PM_POST_SUSPEND:
 	case PM_POST_HIBERNATION:
 	case PM_POST_RESTORE:
-		rc = led_trigger_register(&heartbeat_led_trigger);
-		if (rc)
-			pr_err("could not re-register heartbeat trigger\n");
+		led_trigger_resume(&heartbeat_led_trigger);
 		break;
 	default:
 		break;
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 64c56d4..b792950 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -111,6 +111,7 @@ struct led_classdev {
 	void			*trigger_data;
 	/* true if activated - deactivate routine uses it to do cleanup */
 	bool			activated;
+	bool			suspended;
 #endif
 
 #ifdef CONFIG_LEDS_BRIGHTNESS_HW_CHANGED
@@ -254,6 +255,8 @@ struct led_trigger {
 	const char	 *name;
 	void		(*activate)(struct led_classdev *led_cdev);
 	void		(*deactivate)(struct led_classdev *led_cdev);
+	void		(*suspend)(struct led_classdev *led_cdev);
+	void		(*resume)(struct led_classdev *led_cdev);
 
 	/* LEDs under control by this trigger (for simple triggers) */
 	rwlock_t	  leddev_list_lock;
@@ -291,6 +294,9 @@ extern void led_trigger_set(struct led_classdev *led_cdev,
 			struct led_trigger *trigger);
 extern void led_trigger_remove(struct led_classdev *led_cdev);
 
+extern void led_trigger_suspend(struct led_trigger *trig);
+extern void led_trigger_resume(struct led_trigger *trig);
+
 static inline void *led_get_trigger_data(struct led_classdev *led_cdev)
 {
 	return led_cdev->trigger_data;
-- 
1.9.1
