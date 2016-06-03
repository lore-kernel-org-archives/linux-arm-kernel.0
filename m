From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 03 Jun 2016 15:21:19 +0100
Subject: [PATCH v2 1/3] of: add common OF-based component functionality
In-Reply-To: <20160603141548.GC1041@n2100.armlinux.org.uk>
References: <20160603141548.GC1041@n2100.armlinux.org.uk>
Message-ID: <E1b8pyR-0005OJ-V3@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add common OF-based component functionality for matching devices by
device node, and releasing the device node at the appropraite time.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/of/Makefile          |  2 +-
 drivers/of/of_component.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/of_component.h | 14 ++++++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 drivers/of/of_component.c
 create mode 100644 include/linux/of_component.h

diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index d7efd9d458aa..6a4a5e2c0839 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -1,4 +1,4 @@
-obj-y = base.o device.o platform.o
+obj-y = base.o of_component.o device.o platform.o
 obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
 obj-$(CONFIG_OF_FLATTREE) += fdt.o
 obj-$(CONFIG_OF_EARLY_FLATTREE) += fdt_address.o
diff --git a/drivers/of/of_component.c b/drivers/of/of_component.c
new file mode 100644
index 000000000000..41e6e817d264
--- /dev/null
+++ b/drivers/of/of_component.c
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2016 Russell King.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/component.h>
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/of_component.h>
+#include <linux/of_graph.h>
+
+static void component_release_of(struct device *dev, void *data)
+{
+	of_node_put(data);
+}
+
+void component_match_add_of_compare(struct device *master,
+	struct component_match **matchptr,
+	int (*compare)(struct device *, void *), struct device_node *node)
+{
+	of_node_get(node);
+	component_match_add_release(master, matchptr, component_release_of,
+				    compare, node);
+}
+EXPORT_SYMBOL_GPL(component_match_add_of_compare);
+
+static void component_compare_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+void component_match_add_of(struct device *master,
+	struct component_match **matchptr, struct device_node *node)
+{
+	of_node_get(node);
+	component_match_add_release(master, matchptr, component_release_of,
+				    component_compare_of, node);
+}
+EXPORT_SYMBOL_GPL(component_match_add_of);
diff --git a/include/linux/of_component.h b/include/linux/of_component.h
new file mode 100644
index 000000000000..a8170ba3b786
--- /dev/null
+++ b/include/linux/of_component.h
@@ -0,0 +1,14 @@
+#ifndef __LINUX_COMPONENT_OF_H
+#define __LINUX_COMPONENT_OF_H
+
+struct component_match;
+struct device;
+struct device_node;
+
+void component_match_add_of_compare(struct device *master,
+	struct component_match **matchptr,
+	int (*compare)(struct device *, void *), struct device_node *node);
+void component_match_add_of(struct device *master,
+	struct component_match **matchptr, struct device_node *node);
+
+#endif
-- 
2.1.0
