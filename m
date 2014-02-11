From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 11 Feb 2014 17:10:26 +0000
Subject: [PATCH 02/12] power/reset: vexpress: Use udelay instead of timers
In-Reply-To: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1392138636-29240-3-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At this stage of system shutdown procedure the jiffies may
not be updated anymore, so just use udelay instead.

Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/power/reset/vexpress-poweroff.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
index 37e7799..195235c 100644
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
@@ -26,13 +26,9 @@ static void vexpress_reset_do(struct device *dev, const char *what)
 	struct regmap *reg = dev_get_drvdata(dev);
 
 	if (reg) {
-		unsigned long timeout;
-
 		err = regmap_write(reg, 0, 0);
-
-		timeout = jiffies + HZ;
-		while (time_before(jiffies, timeout))
-			cpu_relax();
+		if (!err)
+			mdelay(1000);
 	}
 
 	dev_emerg(dev, "Unable to %s (%d)\n", what, err);
-- 
1.8.3.2
