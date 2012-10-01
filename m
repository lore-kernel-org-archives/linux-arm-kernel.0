From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Mon,  1 Oct 2012 14:24:37 +0200
Subject: [PATCH v6 1/5] watchdog: core: dt: add support for the timeout device
 tree property
In-Reply-To: <1349094281-28889-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349094281-28889-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <1349094281-28889-2-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 Documentation/watchdog/watchdog-kernel-api.txt |  3 +++
 include/linux/watchdog.h                       | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 086638f..decd981 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -212,3 +212,6 @@ driver specific data to and a pointer to the data itself.
 The watchdog_get_drvdata function allows you to retrieve driver specific data.
 The argument of this function is the watchdog device where you want to retrieve
 data from. The function returns the pointer to the driver specific data.
+
+The watchdog_probe_dt function allows you to retrieve the timeout property
+from the device tree.
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index da70f0f..06f9384 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -11,6 +11,7 @@
 
 #include <linux/ioctl.h>
 #include <linux/types.h>
+#include <linux/of.h>
 
 #define	WATCHDOG_IOCTL_BASE	'W'
 
@@ -174,6 +175,16 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 	return wdd->driver_data;
 }
 
+/* Use the following function to retrieve the timeout property from dt */
+static inline void watchdog_probe_dt(struct watchdog_device *wdd,
+				     struct device_node *node)
+{
+	if (!node)
+		return;
+
+	of_property_read_u32(node, "timeout", &wdd->timeout);
+}
+
 /* drivers/watchdog/core/watchdog_core.c */
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
-- 
1.7.11.3
