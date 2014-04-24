From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 24 Apr 2014 17:40:17 +0100
Subject: [PATCH 3/4] power/reset: vexpress: Fix restart/power off operation
In-Reply-To: <1398357618-11050-1-git-send-email-pawel.moll@arm.com>
References: <1398357618-11050-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1398357618-11050-4-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The restart/power off implementation in the vexpress driver
used to obtain the config function when necessary. This was
wrong in two respects:

1. It required memory allocation with disabled interrupts
(it worked, but lockdep - when enabled - reported warnings).

2. Used jiffies-based timeout, while jiffies are not running
at this stage of system shutdown (therefore a config
transaction error - if happened - would have never be reported).

Fixed by pre-allocating the config function per device
and using mdelay for timeout.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/power/reset/vexpress-poweroff.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
index 476aa49..b95cf71 100644
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -11,7 +11,7 @@
  * Copyright (C) 2012 ARM Limited
  */
 
-#include <linux/jiffies.h>
+#include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -23,17 +23,12 @@
 static void vexpress_reset_do(struct device *dev, const char *what)
 {
 	int err = -ENOENT;
-	struct vexpress_config_func *func =
-			vexpress_config_func_get_by_dev(dev);
+	struct vexpress_config_func *func = dev_get_drvdata(dev);
 
 	if (func) {
-		unsigned long timeout;
-
 		err = vexpress_config_write(func, 0, 0);
-
-		timeout = jiffies + HZ;
-		while (time_before(jiffies, timeout))
-			cpu_relax();
+		if (!err)
+			mdelay(1000);
 	}
 
 	dev_emerg(dev, "Unable to %s (%d)\n", what, err);
@@ -96,12 +91,18 @@ static int vexpress_reset_probe(struct platform_device *pdev)
 	enum vexpress_reset_func func;
 	const struct of_device_id *match =
 			of_match_device(vexpress_reset_of_match, &pdev->dev);
+	struct vexpress_config_func *config_func;
 
 	if (match)
 		func = (enum vexpress_reset_func)match->data;
 	else
 		func = pdev->id_entry->driver_data;
 
+	config_func = vexpress_config_func_get_by_dev(&pdev->dev);
+	if (!config_func)
+		return -EINVAL;
+	dev_set_drvdata(&pdev->dev, config_func);
+
 	switch (func) {
 	case FUNC_SHUTDOWN:
 		vexpress_power_off_device = &pdev->dev;
-- 
1.8.3.2
