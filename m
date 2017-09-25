From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 25 Sep 2017 10:18:11 +0200
Subject: bq27xxx: add battery protection
Message-ID: <20170925081810.GA32216@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Add battery protection for bq27xxx. Note that thresholds are very low,
so this only kills system long after reasonable userspace should have
reacted.

Signed-off-by: Pavel Machek <pavel@ucw.cz>


diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 51f0961..08dc193 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -53,6 +53,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 
@@ -1580,6 +1577,56 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_update);
 
+static void shutdown(char *reason)
+{
+	pr_alert("Forcing shutdown: %s\n", reason);
+	orderly_poweroff(true);
+}
+
+static int generic_protect(struct power_supply *psy)
+{
+	union power_supply_propval val;
+	int res;
+	int mV, mA, mVadj = 0;
+	const int mOhm = 430;
+	const int mV_limit = 2950;
+	const int mV_open_limit = 3150;
+
+	res = psy->desc->get_property(psy, POWER_SUPPLY_PROP_HEALTH, &val);
+	if (res)
+		return res;
+
+	if (val.intval == POWER_SUPPLY_HEALTH_OVERHEAT)
+		shutdown("Battery overheat.");
+	if (val.intval == POWER_SUPPLY_HEALTH_DEAD)
+		shutdown("Battery dead.");
+
+	res = psy->desc->get_property(psy, POWER_SUPPLY_PROP_VOLTAGE_NOW, &val);
+	if (res)
+		return res;
+	mV = val.intval / 1000;
+
+	if (mV < mV_limit) {
+		pr_alert("Battery below %d mV.", mV_limit);
+		orderly_poweroff(true);
+	}
+
+	res = psy->desc->get_property(psy, POWER_SUPPLY_PROP_CURRENT_NOW, &val);
+	if (res)
+		return res;
+	mA = val.intval / 1000;
+	mVadj = mV + (mA * mOhm) / 1000;
+
+	if (mVadj < mV_open_limit) {
+		pr_alert("Battery open circuit voltage below %d mV.", mV_open_limit);
+		orderly_poweroff(true);
+	}
+	
+	printk(KERN_INFO "Main battery %d mV, open circuit voltage %d mV\n",
+	       mV, mVadj);
+	return 0;
+}
+
 static void bq27xxx_battery_poll(struct work_struct *work)
 {
 	struct bq27xxx_device_info *di =
@@ -1592,6 +1639,16 @@ static void bq27xxx_battery_poll(struct work_struct *work)
 		schedule_delayed_work(&di->work, poll_interval * HZ);
 }
 
+static void bq27xxx_battery_poll_protect(struct work_struct *work)
+{
+	struct bq27xxx_device_info *di =
+			container_of(work, struct bq27xxx_device_info,
+				     work.work);
+
+	bq27xxx_battery_poll(work);
+	generic_protect(di->bat);
+}
+
 /*
  * Return the battery average current in ?A
  * Note that current can be negative signed as well
@@ -1684,8 +1741,8 @@ static int bq27xxx_battery_capacity_level(struct bq27xxx_device_info *di,
 }
 
 /*
- * Return the battery Voltage in millivolts
- * Or < 0 if something fails.
+ * Set val->intval to the battery Voltage in millivolts.
+ * Return < 0 if something fails.
  */
 static int bq27xxx_battery_voltage(struct bq27xxx_device_info *di,
 				   union power_supply_propval *val)
@@ -1821,7 +1878,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 		.drv_data = di,
 	};
 
-	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
+	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll_protect);
 	mutex_init(&di->lock);
 
 	di->regs       = bq27xxx_chip_data[di->chip].regs;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170925/cdb5e439/attachment.sig>
