From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 25 Oct 2016 13:27:57 +0200
Subject: [RFC] shutdown machine when li-ion battery goes below 3V
In-Reply-To: <20161024212932.uhjz752z2cy5hohl@atomide.com>
References: <20161024212250.GA31336@amd>
 <20161024212932.uhjz752z2cy5hohl@atomide.com>
Message-ID: <20161025112757.GC25855@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2016-10-24 14:29:33, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [161024 14:24]:
> > Hi!
> > 
> > What about something like this? N900 will drain the battery down to
> > system crash, which is quite uncool.
> 
> Can't we make that generic and configurable for the voltage somehow?
> 
> Also, the shutdown voltage can depend on external devices connected.
> It could be for example 3.3V depending on eMMC on some devices while
> devices with no eMMC could have it at 3.0V.

Actually, do we need to make it configurable? It looks like we should
respect hardware telling us battery is dead, and only use (low)
hardcoded voltages as a fallback.

Currently patch looks like this. generic_protect() should work for
other batteries drivers, too.

								Pavel

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 0fe278b..04094ad 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -46,6 +46,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 
@@ -679,10 +680,10 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 	/* Unlikely but important to return first */
 	if (unlikely(bq27xxx_battery_overtemp(di, flags)))
 		return POWER_SUPPLY_HEALTH_OVERHEAT;
-	if (unlikely(bq27xxx_battery_undertemp(di, flags)))
-		return POWER_SUPPLY_HEALTH_COLD;
 	if (unlikely(bq27xxx_battery_dead(di, flags)))
 		return POWER_SUPPLY_HEALTH_DEAD;
+	if (unlikely(bq27xxx_battery_undertemp(di, flags)))
+		return POWER_SUPPLY_HEALTH_COLD;
 
 	return POWER_SUPPLY_HEALTH_GOOD;
 }
@@ -740,6 +741,49 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_update);
 
+static void shutdown(char *reason)
+{
+	pr_alert("%s Forcing shutdown\n", reason);
+	orderly_poweroff(true);
+}
+
+static int generic_protect(struct power_supply *psy)
+{
+	union power_supply_propval val;
+	int res;
+	int mV, mA, mOhm = 430, mVadj = 0;
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
+	if (mV < 2950)
+		shutdown("Battery below 2.95V.");
+
+	res = psy->desc->get_property(psy, POWER_SUPPLY_PROP_CURRENT_NOW, &val);
+	if (res)
+		return res;
+	mA = val.intval / 1000;
+	mVadj = mV + (mA * mOhm) / 1000;
+
+	if (mVadj < 3150)
+		shutdown("Battery internal voltage below 3.15.");
+	
+	printk(KERN_INFO "Main battery %d mV, internal voltage %d mV\n",
+	       mV, mVadj);
+	return 0;
+}
+
 static void bq27xxx_battery_poll(struct work_struct *work)
 {
 	struct bq27xxx_device_info *di =
@@ -747,6 +791,7 @@ static void bq27xxx_battery_poll(struct work_struct *work)
 				     work.work);
 
 	bq27xxx_battery_update(di);
+	generic_protect(di->bat);
 
 	if (poll_interval > 0)
 		schedule_delayed_work(&di->work, poll_interval * HZ);

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161025/db1c8616/attachment.sig>
