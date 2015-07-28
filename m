From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 28 Jul 2015 15:19:35 +0200
Subject: [PATCH v2 04/22] of/platform: add of_platform_device_find()
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438089593-7696-5-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From an arbitrary node in the tree, find the enclosing node that
corresponds to a platform device, as registered by
of_platform_populate().

This can be used to find out what device needs to be probed so the
dependency described by a given node is made available.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2:
- Move the logic for finding a platform device from its firmware node to
  of/platform.c as it's not needed for ACPI nodes.

 drivers/of/platform.c       | 60 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_platform.h |  1 +
 2 files changed, 61 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index ff27494cda8c..89c5cd513027 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -501,6 +501,66 @@ void of_platform_depopulate(struct device *parent)
 }
 EXPORT_SYMBOL_GPL(of_platform_depopulate);
 
+static bool of_is_platform(struct device_node *np)
+{
+	int count;
+
+	count = of_property_count_strings(np, "compatible");
+
+	/* The node has to have a compatible string */
+	if (!count)
+		return false;
+
+	/* But it cannot be just a simple memory-mapped bus */
+	if (count == 1 && of_match_node(of_default_bus_match_table, np))
+		return false;
+
+	/* But AMBA devices aren't platform devices */
+	if (of_device_is_compatible(np, "arm,primecell"))
+		return false;
+
+	/* Node is immediately below root */
+	if (!np->parent || !np->parent->parent)
+		return true;
+
+	/* If it's a node in a simple memory-mapped bus */
+	if (of_match_node(of_default_bus_match_table, np->parent))
+		return true;
+
+	return false;
+}
+
+/**
+ * of_platform_device_find() - Find nearest ancestor that is a platform device
+ * @np: node to find platform device for
+ *
+ * Walks the tree up and finds the closest ancestor that has match data and
+ * either is at the root of the tree or is a child of a simple memory mapped
+ * bus.
+ *
+ * Returns such a device, or NULL if none could be found.
+ */
+struct device *of_platform_device_find(struct device_node *np)
+{
+	struct device_node *target;
+	struct platform_device *pdev;
+
+	of_node_get(np);
+
+	for (target = np;
+	     !of_node_is_root(target);
+	     target = of_get_next_parent(target))
+		if (of_is_platform(target))
+			break;
+
+	pdev = of_find_device_by_node(target);
+
+	of_node_put(target);
+
+	return pdev ? &pdev->dev : NULL;
+}
+EXPORT_SYMBOL_GPL(of_platform_device_find);
+
 #ifdef CONFIG_OF_DYNAMIC
 static int of_platform_notify(struct notifier_block *nb,
 				unsigned long action, void *arg)
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 611a691145c4..baefc941fdb8 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -58,6 +58,7 @@ extern struct platform_device *of_device_alloc(struct device_node *np,
 					 const char *bus_id,
 					 struct device *parent);
 extern struct platform_device *of_find_device_by_node(struct device_node *np);
+extern struct device *of_platform_device_find(struct device_node *np);
 
 /* Platform devices and busses creation */
 extern struct platform_device *of_platform_device_create(struct device_node *np,
-- 
2.4.3
