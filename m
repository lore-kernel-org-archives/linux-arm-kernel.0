From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 17 Jun 2015 15:42:18 +0200
Subject: [PATCH 08/13] gpio: sysfs: implement class.get_dependencies()
In-Reply-To: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1434548543-22949-9-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So the GPIO subsystem can be queried about the dependencies of nodes
that consume GPIOs, as specified in bindings/gpio/gpio.txt.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpio/gpiolib-sysfs.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index b57ed8e..d0a7fb1 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -7,6 +7,7 @@
 #include <linux/interrupt.h>
 #include <linux/kdev_t.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #include "gpiolib.h"
 
@@ -515,6 +516,85 @@ done:
 	return status ? : len;
 }
 
+static bool strends(const char *str, const char *postfix)
+{
+	if (strlen(str) < strlen(postfix))
+		return false;
+
+	return strcmp(str + strlen(str) - strlen(postfix), postfix) == 0;
+}
+
+static void add_dependency(struct fwnode_handle *fwnode,
+			   struct list_head *list)
+{
+	struct fwnode_dependency *dep;
+
+	dep = kzalloc(sizeof(*dep), GFP_KERNEL);
+	if (!dep)
+		return;
+
+	INIT_LIST_HEAD(&dep->dependency);
+	dep->fwnode = fwnode;
+
+	list_add_tail(&dep->dependency, list);
+}
+
+struct list_head *gpio_get_dependencies(struct fwnode_handle *fwnode)
+{
+	struct device_node *np = of_node(fwnode);
+	struct list_head *list = NULL;
+	struct property *pp;
+	struct of_phandle_args pspec;
+	int count, i, ret;
+
+	if (!is_of_node(fwnode))
+		return NULL;
+
+	np = of_node(fwnode);
+	if (!np)
+		return NULL;
+
+	list = kzalloc(sizeof(*list), GFP_KERNEL);
+	if (!list)
+		return NULL;
+
+	INIT_LIST_HEAD(list);
+
+	for_each_property_of_node(np, pp) {
+		if (strcmp(pp->name, "gpio") &&
+		    !strends(pp->name, "-gpios") &&
+		    !strends(pp->name, "-gpio"))
+			continue;
+
+		count = of_count_phandle_with_args(np, pp->name,
+						   "#gpio-cells");
+		for (i = 0; i < count; i++) {
+			ret = of_parse_phandle_with_args(np, pp->name,
+							 "#gpio-cells", i,
+							 &pspec);
+			if (ret || !pspec.np)
+				continue;
+
+			add_dependency(&pspec.np->fwnode, list);
+
+			of_node_put(pspec.np);
+		}
+	}
+
+	for (i = 0;; i++) {
+		ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3,
+						       i, &pspec);
+		if (ret)
+			break;
+
+		add_dependency(&pspec.np->fwnode, list);
+
+		of_node_put(pspec.np);
+	}
+
+	return list;
+}
+
 static struct class_attribute gpio_class_attrs[] = {
 	__ATTR(export, 0200, NULL, export_store),
 	__ATTR(unexport, 0200, NULL, unexport_store),
@@ -526,6 +606,7 @@ static struct class gpio_class = {
 	.owner =	THIS_MODULE,
 
 	.class_attrs =	gpio_class_attrs,
+	.get_dependencies = gpio_get_dependencies,
 };
 
 
-- 
2.4.1
