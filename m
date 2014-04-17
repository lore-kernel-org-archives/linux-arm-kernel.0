From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 17 Apr 2014 13:28:49 +0200
Subject: [PATCH RFC 2/3] drivers/base: provide lightweight framework for
 componentized devices
In-Reply-To: <1397734130-21019-1-git-send-email-a.hajda@samsung.com>
References: <1397734130-21019-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1397734130-21019-3-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many subsystems (eg. DRM, ALSA) requires that multiple devices should
be composed into one superdevice. The superdevice cannot start until
all components are ready and it should stop before any of its components
becomes not-ready.
This framework provides a way to track readiness of all components with
minimal impact on the code of the drivers.
The superdevice provides pending_components structure and adds all components
to it, device drivers removes themselves from the list if they becomes ready.
If the list becomes empty callback is fired which causes superdevice to start.
Later if any components wants to become not-ready it adds again itself to the
list and callback is fired to stop superdevice.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/base/Kconfig               |  3 ++
 drivers/base/Makefile              |  1 +
 drivers/base/pending_components.c  | 93 ++++++++++++++++++++++++++++++++++++++
 include/linux/pending_components.h | 30 ++++++++++++
 4 files changed, 127 insertions(+)
 create mode 100644 drivers/base/pending_components.c
 create mode 100644 include/linux/pending_components.h

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index ec36e77..71ce050 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -278,4 +278,7 @@ config CMA_AREAS
 
 endif
 
+config PENDING_COMPONENTS
+	boolean
+
 endmenu
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 04b314e..3a51654 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
 obj-$(CONFIG_REGMAP)	+= regmap/
 obj-$(CONFIG_SOC_BUS) += soc.o
 obj-$(CONFIG_PINCTRL) += pinctrl.o
+obj-$(CONFIG_PENDING_COMPONENTS) += pending_components.o
 
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
 
diff --git a/drivers/base/pending_components.c b/drivers/base/pending_components.c
new file mode 100644
index 0000000..f15104e
--- /dev/null
+++ b/drivers/base/pending_components.c
@@ -0,0 +1,93 @@
+/*
+ * Lightweight framework for handling componentized devices.
+ *
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd
+ * Andrzej Hajda <a.hajda@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * pending_components structure contains list of components which are not yet
+ * ready. Components can remove or add themselves from/to the list. If the list
+ * becomes empty/non-empty optional callback is fired.
+*/
+
+#include <linux/pending_components.h>
+#include <linux/slab.h>
+
+struct pending_components_node {
+	struct list_head list;
+	void *data;
+};
+
+int pending_components_insert(struct pending_components *set, void *item)
+{
+	struct pending_components_node *n;
+	int ret = 0;
+
+	mutex_lock(&set->lock);
+
+	list_for_each_entry(n, &set->list, list) {
+		if (n->data == item)
+			goto out;
+	}
+
+	n = kmalloc(sizeof(*n), GFP_KERNEL);
+	if (!n) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	n->data = item;
+	list_add_tail(&n->list, &set->list);
+	if (set->callback && set->list.next == set->list.prev)
+		ret = set->callback(set, false);
+
+out:
+	mutex_unlock(&set->lock);
+
+	return ret;
+}
+
+int pending_components_delete(struct pending_components *set, void *item)
+{
+	struct pending_components_node *n;
+	int ret = 0;
+
+	mutex_lock(&set->lock);
+
+	list_for_each_entry(n, &set->list, list) {
+		if (n->data == item) {
+			list_del(&n->list);
+			kfree(n);
+			if (set->callback && list_empty(&set->list))
+				ret = set->callback(set, true);
+			break;
+		}
+	}
+
+	mutex_unlock(&set->lock);
+
+	return ret;
+}
+
+void pending_components_set_callback(struct pending_components *set,
+				     pending_components_callback cb)
+{
+	mutex_lock(&set->lock);
+
+	set->callback = cb;
+
+	mutex_unlock(&set->lock);
+}
+
+void pending_components_cleanup(struct pending_components *set)
+{
+	struct pending_components_node *n, *tmp;
+
+	list_for_each_entry_safe(n, tmp, &set->list, list) {
+		list_del(&n->list);
+		kfree(n);
+	}
+}
diff --git a/include/linux/pending_components.h b/include/linux/pending_components.h
new file mode 100644
index 0000000..dd29616
--- /dev/null
+++ b/include/linux/pending_components.h
@@ -0,0 +1,30 @@
+#ifndef PENDING_COMPONENTS_H
+#define PENDING_COMPONENTS_H
+
+#include <linux/list.h>
+#include <linux/mutex.h>
+
+struct pending_components;
+
+typedef int (*pending_components_callback)(struct pending_components *set,
+					   bool empty);
+
+struct pending_components {
+	struct mutex lock;
+	struct list_head list;
+	pending_components_callback callback;
+};
+
+#define DEFINE_PENDING_COMPONENTS(set) \
+	struct pending_components set = { \
+		.lock = __MUTEX_INITIALIZER(set.lock), \
+		.list = LIST_HEAD_INIT(set.list) \
+	}
+
+int pending_components_insert(struct pending_components *set, void *item);
+int pending_components_delete(struct pending_components *set, void *item);
+void pending_components_set_callback(struct pending_components *set,
+				     pending_components_callback cb);
+void pending_components_cleanup(struct pending_components *set);
+
+#endif /* PENDING_COMPONENTS_H */
-- 
1.8.3.2
