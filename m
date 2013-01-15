From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 15 Jan 2013 12:55:42 +0000
Subject: [PATCH 02/26] mfd: ab8500-sysctrl: If a charger is present,
 reboot instead
In-Reply-To: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1358254566-12419-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

If a changer is attached on power off, reboot the system
into charging mode instead of powering it off.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Reviewed-by: Karl KOMIEROWSKI <karl.komierowski@stericsson.com>
---
 drivers/mfd/ab8500-sysctrl.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index 799fb5e..01b0669 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -8,7 +8,9 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/reboot.h>
 #include <linux/signal.h>
+#include <linux/power_supply.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/mfd/abx500/ab8500-sysctrl.h>
@@ -19,6 +21,31 @@ void ab8500_power_off(void)
 {
 	sigset_t old;
 	sigset_t all;
+	static char *pss[] = {"ab8500_ac", "ab8500_usb"};
+	int i;
+
+	/*
+	 * If we have a charger connected and we're powering off,
+	 * reboot into charge-only mode.
+	 */
+
+	for (i = 0; i < ARRAY_SIZE(pss); i++) {
+		union power_supply_propval val;
+		struct power_supply *psy;
+		int ret;
+
+		psy = power_supply_get_by_name(pss[i]);
+		if (!psy)
+			continue;
+		ret = psy->get_property(psy, POWER_SUPPLY_PROP_ONLINE, &val);
+
+		if (!ret && val.intval) {
+			printk(KERN_INFO
+			       "Charger \"%s\" is connected. Rebooting.\n",
+			       pss[i]);
+			machine_restart(NULL);
+		}
+	}
 
 	sigfillset(&all);
 
-- 
1.7.9.5
