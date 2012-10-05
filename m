From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Fri,  5 Oct 2012 12:16:06 +0200
Subject: [RFC PATCH v3 1/4] watchdog: core: dt: add support for the
 timeout-sec dt property
In-Reply-To: <1349432169-13006-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349432169-13006-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <1349432169-13006-2-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 Documentation/watchdog/watchdog-kernel-api.txt |  4 ++++
 drivers/watchdog/watchdog_core.c               | 27 ++++++++++++++++++++++++++
 include/linux/watchdog.h                       |  4 ++++
 3 files changed, 35 insertions(+)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 086638f..2208db7 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -212,3 +212,7 @@ driver specific data to and a pointer to the data itself.
 The watchdog_get_drvdata function allows you to retrieve driver specific data.
 The argument of this function is the watchdog device where you want to retrieve
 data from. The function returns the pointer to the driver specific data.
+
+The watchdog_init_timeout function allows you to initialize the timeout field
+using the module timeout parameter or retrieving the timeout-sec property from
+the device tree.
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 3796434..646be48 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -143,6 +143,33 @@ void watchdog_unregister_device(struct watchdog_device *wdd)
 }
 EXPORT_SYMBOL_GPL(watchdog_unregister_device);
 
+/**
+ * watchdog_init_timeout() - initialize the timeout field
+ * @parm_timeout: timeout module parameter, it takes precedence over the
+ *                timeout-sec property.
+ * @node: Retrieve the timeout-sec property only if the parm_timeout
+ *        is out of bounds.
+ */
+void watchdog_init_timeout(struct watchdog_device *wdd,
+			   unsigned int parm_timeout, struct device_node *node)
+{
+	unsigned int t = 0;
+
+	if ((parm_timeout >= wdd->min_timeout) &&
+	    (parm_timeout <= wdd->max_timeout)) {
+		wdd->timeout = parm_timeout;
+		return;
+	}
+
+	if (!node)
+		return;
+
+	of_property_read_u32(node, "timeout-sec", &t);
+	if ((t >= wdd->min_timeout) && (t <= wdd->max_timeout))
+		wdd->timeout = t;
+}
+EXPORT_SYMBOL_GPL(watchdog_init_timeout);
+
 static int __init watchdog_init(void)
 {
 	int err;
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index da70f0f..d09dda7 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -11,6 +11,7 @@
 
 #include <linux/ioctl.h>
 #include <linux/types.h>
+#include <linux/of.h>
 
 #define	WATCHDOG_IOCTL_BASE	'W'
 
@@ -177,6 +178,9 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 /* drivers/watchdog/core/watchdog_core.c */
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
+extern void watchdog_init_timeout(struct watchdog_device *wdd,
+				  unsigned int parm_timeout,
+				  struct device_node *node);
 
 #endif	/* __KERNEL__ */
 
-- 
1.7.11.3
