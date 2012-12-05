From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Tue,  4 Dec 2012 18:30:37 -0800
Subject: [PATCH] of: Output devicetree alias names in uevent
Message-ID: <1354674637-6448-1-git-send-email-stepanm@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some situations, userspace may want to resolve a
device by function and logical number (ie, "serial0")
rather than by the base address or full device path. Being
able to resolve a device by alias frees userspace from the
burden of otherwise having to maintain a mapping between
device addresses and their logical assignments on each
platform when multiple instances of the same hardware block
are present in the system.

Although the uevent device attribute contains devicetree
compatible information and the full device path, the uevent
does not list the alises that may have been defined for the
device.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
I have followed the OF_COMPATIBLE convention for adding the
uevent variables for the alias names, but I can follow some
other convention if people feel something else is more
appropriate.

 drivers/of/base.c         |   25 +++++++++++++++++++++++++
 drivers/of/device.c       |    1 +
 include/linux/of_device.h |    2 ++
 3 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 5806449..291f0a0 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -19,6 +19,7 @@
  */
 #include <linux/ctype.h>
 #include <linux/module.h>
+#include <linux/device.h>
 #include <linux/of.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -1177,6 +1178,30 @@ static void of_alias_add(struct alias_prop *ap, struct device_node *np,
 }

 /**
+ * of_device_uevent_aliases - Display OF alises in uevent
+ */
+void of_device_uevent_aliases(struct device_node *node,
+			      struct kobj_uevent_env *env)
+{
+	struct alias_prop *app;
+	int seen = 0;
+
+	mutex_lock(&of_aliases_mutex);
+	list_for_each_entry(app, &aliases_lookup, link) {
+		if (node == app->np) {
+			add_uevent_var(env, "OF_ALIAS_%d=%s%d", seen, app->stem,
+				       app->id);
+			seen++;
+		}
+	}
+
+	if (seen)
+		add_uevent_var(env, "OF_ALIAS_N=%d", seen);
+
+	mutex_unlock(&of_aliases_mutex);
+}
+
+/**
  * of_alias_scan - Scan all properties of 'aliases' node
  *
  * The function scans all the properties of 'aliases' node and populate
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 4c74e4f..06e122d 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -153,6 +153,7 @@ void of_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 		seen++;
 	}
 	add_uevent_var(env, "OF_COMPATIBLE_N=%d", seen);
+	of_device_uevent_aliases(dev->of_node, env);
 }

 int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 901b743..748056d 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -36,6 +36,8 @@ extern ssize_t of_device_get_modalias(struct device *dev,
 					char *str, ssize_t len);

 extern void of_device_uevent(struct device *dev, struct kobj_uevent_env *env);
+extern void of_device_uevent_aliases(struct device_node *node,
+					struct kobj_uevent_env *env);
 extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env);

 static inline void of_device_node_put(struct device *dev)
--
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
