From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Thu,  4 Oct 2012 10:26:58 +0200
Subject: [RFC PATCH v2 1/2] watchdog: core: dt: add support for the
 timeout-sec dt property
In-Reply-To: <1349339219-1467-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349339219-1467-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <1349339219-1467-2-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 Documentation/watchdog/watchdog-kernel-api.txt |  3 +++
 include/linux/watchdog.h                       | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 086638f..35057b2 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -212,3 +212,6 @@ driver specific data to and a pointer to the data itself.
 The watchdog_get_drvdata function allows you to retrieve driver specific data.
 The argument of this function is the watchdog device where you want to retrieve
 data from. The function returns the pointer to the driver specific data.
+
+The watchdog_probe_dt_timeout function allows you to retrieve the timeout-sec
+property from the device tree.
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index da70f0f..18af39f 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -11,6 +11,7 @@
 
 #include <linux/ioctl.h>
 #include <linux/types.h>
+#include <linux/of.h>
 
 #define	WATCHDOG_IOCTL_BASE	'W'
 
@@ -174,6 +175,20 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 	return wdd->driver_data;
 }
 
+/* Use the following function to retrieve the timeout-sec property from dt */
+static inline void watchdog_probe_dt_timeout(struct watchdog_device *wdd,
+					     struct device_node *node)
+{
+	unsigned int t = 0;
+
+	if (!node)
+		return;
+
+	of_property_read_u32(node, "timeout-sec", &t);
+	if ((t >= wdd->min_timeout) && (t <= wdd->max_timeout))
+		wdd->timeout = t;
+}
+
 /* drivers/watchdog/core/watchdog_core.c */
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
-- 
1.7.11.3
