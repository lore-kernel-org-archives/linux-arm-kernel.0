From: vkuzmichev@mvista.com (Vitaly Kuzmichev)
Date: Tue,  5 Jul 2011 23:00:40 +0400
Subject: [PATCH V2 6/6] mpcore_wdt: Move declarations in a separate header
In-Reply-To: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
Message-ID: <1309892440-3260-7-git-send-email-vkuzmichev@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vitaly Kuzmichev <vkuzmichev@mvista.com>
---
 drivers/watchdog/mpcore_wdt.c |   26 +-------------------------
 drivers/watchdog/mpcore_wdt.h |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 25 deletions(-)
 create mode 100644 drivers/watchdog/mpcore_wdt.h

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 38b9119..1736522 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -34,34 +34,11 @@
 #include <linux/io.h>
 #include <linux/cpufreq.h>
 
-unsigned long twd_timer_get_rate(void);
-
-#define TWD_WDOG_LOAD			0x20
-#define TWD_WDOG_COUNTER		0x24
-#define TWD_WDOG_CONTROL		0x28
-#define TWD_WDOG_INTSTAT		0x2C
-#define TWD_WDOG_RESETSTAT		0x30
-#define TWD_WDOG_DISABLE		0x34
-
-#define TWD_WDOG_CONTROL_ENABLE		(1 << 0)
-#define TWD_WDOG_CONTROL_PERIODIC	(1 << 1)
-#define TWD_WDOG_CONTROL_IT_ENABLE	(1 << 2)
-#define TWD_WDOG_CONTROL_TIMER_MODE	(0 << 3)
-#define TWD_WDOG_CONTROL_WATCHDOG_MODE	(1 << 3)
-
-struct mpcore_wdt {
-	unsigned long	timer_alive;
-	struct device	*dev;
-	void __iomem	*base;
-	int		irq;
-	unsigned int	perturb;
-	char		expect_close;
-};
+#include "mpcore_wdt.h"
 
 static struct platform_device *mpcore_wdt_dev;
 static DEFINE_SPINLOCK(wdt_lock);
 
-#define TIMER_MARGIN	60
 static int mpcore_margin = TIMER_MARGIN;
 module_param(mpcore_margin, int, 0);
 MODULE_PARM_DESC(mpcore_margin,
@@ -74,7 +51,6 @@ MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-#define ONLY_TESTING	0
 static int mpcore_noboot = ONLY_TESTING;
 module_param(mpcore_noboot, int, 0);
 MODULE_PARM_DESC(mpcore_noboot, "MPcore watchdog action, "
diff --git a/drivers/watchdog/mpcore_wdt.h b/drivers/watchdog/mpcore_wdt.h
new file mode 100644
index 0000000..694e879
--- /dev/null
+++ b/drivers/watchdog/mpcore_wdt.h
@@ -0,0 +1,40 @@
+/*
+ *	Header file for the mpcore watchdog driver
+ *
+ *      2011 (c) MontaVista Software, LLC. This file is licensed under
+ *      the terms of the GNU General Public License version 2. This program
+ *      is licensed "as is" without any warranty of any kind, whether express
+ *      or implied.
+ */
+
+#ifndef __MPCORE_WATCHDOG_H
+#define __MPCORE_WATCHDOG_H
+
+#define TWD_WDOG_LOAD			0x20
+#define TWD_WDOG_COUNTER		0x24
+#define TWD_WDOG_CONTROL		0x28
+#define TWD_WDOG_INTSTAT		0x2C
+#define TWD_WDOG_RESETSTAT		0x30
+#define TWD_WDOG_DISABLE		0x34
+
+#define TWD_WDOG_CONTROL_ENABLE		(1 << 0)
+#define TWD_WDOG_CONTROL_PERIODIC	(1 << 1)
+#define TWD_WDOG_CONTROL_IT_ENABLE	(1 << 2)
+#define TWD_WDOG_CONTROL_TIMER_MODE	(0 << 3)
+#define TWD_WDOG_CONTROL_WATCHDOG_MODE	(1 << 3)
+
+#define TIMER_MARGIN	60
+#define ONLY_TESTING	0
+
+struct mpcore_wdt {
+	unsigned long	timer_alive;
+	struct device	*dev;
+	void __iomem	*base;
+	int		irq;
+	unsigned int	perturb;
+	char		expect_close;
+};
+
+unsigned long twd_timer_get_rate(void);
+
+#endif /* __MPCORE_WATCHDOG_H */
-- 
1.7.3.4
