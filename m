From: linux@roeck-us.net (Guenter Roeck)
Date: Mon,  6 Oct 2014 22:28:45 -0700
Subject: [PATCH 43/44] hwmon: (ab8500) Call kernel_power_off instead of
 pm_power_off
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Message-ID: <1412659726-29957-44-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drivers should not call pm_power_off directly; it is not guaranteed
to be non-NULL. Call kernel_power_off instead.

Cc: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ab8500.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ab8500.c b/drivers/hwmon/ab8500.c
index d844dc8..8b6a4f4 100644
--- a/drivers/hwmon/ab8500.c
+++ b/drivers/hwmon/ab8500.c
@@ -6,7 +6,7 @@
  *
  * When the AB8500 thermal warning temperature is reached (threshold cannot
  * be changed by SW), an interrupt is set, and if no further action is taken
- * within a certain time frame, pm_power off will be called.
+ * within a certain time frame, kernel_power_off will be called.
  *
  * When AB8500 thermal shutdown temperature is reached a hardware shutdown of
  * the AB8500 will occur.
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/power/ab8500.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include "abx500.h"
@@ -106,7 +107,7 @@ static void ab8500_thermal_power_off(struct work_struct *work)
 
 	dev_warn(&abx500_data->pdev->dev, "Power off due to critical temp\n");
 
-	pm_power_off();
+	kernel_power_off();
 }
 
 static ssize_t ab8500_show_name(struct device *dev,
-- 
1.9.1
