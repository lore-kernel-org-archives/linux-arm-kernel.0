From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 24 Oct 2016 23:22:50 +0200
Subject: [RFC] shutdown machine when li-ion battery goes below 3V
Message-ID: <20161024212250.GA31336@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

What about something like this? N900 will drain the battery down to
system crash, which is quite uncool.

									Pavel


diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 0fe278b..8eb2f8f 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -46,6 +46,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 
@@ -740,6 +741,9 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_update);
 
+static int bq27xxx_battery_protect(struct bq27xxx_device_info *di);
+
+
 static void bq27xxx_battery_poll(struct work_struct *work)
 {
 	struct bq27xxx_device_info *di =
@@ -747,6 +751,7 @@ static void bq27xxx_battery_poll(struct work_struct *work)
 				     work.work);
 
 	bq27xxx_battery_update(di);
+	bq27xxx_battery_protect(di);
 
 	if (poll_interval > 0)
 		schedule_delayed_work(&di->work, poll_interval * HZ);
@@ -958,6 +963,41 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	return ret;
 }
 
+static int bq27xxx_battery_protect(struct bq27xxx_device_info *di)
+{
+	union power_supply_propval val;
+	int mV, mA, mOhm = 430, mVadj;
+	int res;
+
+	printk(KERN_INFO "Main battery check\n");
+
+	res = bq27xxx_battery_voltage(di, &val);
+	if (res)
+		return res;
+
+	mV = val.intval / 1000;
+	
+	if (mV < 2950) {
+		printk(KERN_ALERT "Main battery below 2.95V, forcing shutdown.\n");
+		orderly_poweroff(true);
+	}
+
+	res = bq27xxx_battery_current(di, &val);
+	if (res)
+		return res;
+	
+	mA = val.intval / 1000;
+	mVadj = mV + (mA * mOhm) / 1000;
+
+	if (mVadj < 3150) {
+		printk(KERN_ALERT "Main battery internal voltage below 3.15, shutdown.\n");
+		orderly_poweroff(true);
+	}
+	printk(KERN_INFO "Main battery %d mV, internal voltage %d mV\n",
+	       mV, mVadj);
+	return 0;
+}
+
 static void bq27xxx_external_power_changed(struct power_supply *psy)
 {
 	struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 226b0b4ac..bcdc1f8 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -444,7 +444,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 
 	if (trip_type == THERMAL_TRIP_CRITICAL) {
 		dev_emerg(&tz->device,
-			  "critical temperature reached(%d C),shutting down\n",
+			  "critical temperature reached(%d C), shutting down\n",
 			  tz->temperature / 1000);
 		orderly_poweroff(true);
 	}

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161024/5e57183f/attachment.sig>
