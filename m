From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 25 May 2015 16:53:10 +0200
Subject: [PATCH 06/21] of/platform: Add of_platform_device_ensure()
In-Reply-To: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1432565608-26036-7-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function ensures that the device that encloses the passed device
node is registered, and thus probed if the corresponding driver has been
registered already.

This function can be used by drivers to ensure that a dependency is
fulfilled.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/of/platform.c       | 51 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_platform.h |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index a01f57c..cc5d808 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -499,6 +499,57 @@ void of_platform_depopulate(struct device *parent)
 }
 EXPORT_SYMBOL_GPL(of_platform_depopulate);
 
+/**
+ * of_platform_device_ensure - Ensure that device has been registered
+ * @np: pointer to node to create device for
+ *
+ * Ensures that a device has been registered for the given node.
+ */
+void of_platform_device_ensure(struct device_node *np)
+{
+	struct device_node *iter, *node = NULL;
+	int rc;
+
+	/* Nothing to be done here */
+	if (of_node_check_flag(np, OF_POPULATED))
+		return;
+
+	/* Too early for us to do anything useful */
+	if (!platform_bus.kobj.state_initialized)
+		return;
+
+	/* Find the node of the platform device enclosing this node */
+	for (iter = np;
+	     iter && iter->parent;
+	     iter = iter->parent) {
+		if (of_get_property(iter, "compatible", NULL))
+			node = iter;
+
+		/*
+		 * If the requested and requester nodes have a common ancestor
+		 * that is being populated at this moment, register the device
+		 * associated with the child of this ancestor that includes
+		 * the requested node.
+		 */
+		if (of_node_check_flag(iter->parent, OF_POPULATED) &&
+		    of_match_node(of_default_bus_match_table, iter->parent))
+			break;
+
+		if (of_node_is_root(iter->parent))
+			break;
+	}
+
+	if (!node)
+		return;
+
+	rc = of_platform_bus_create(node, of_default_bus_match_table, NULL,
+				    NULL, true);
+	if (rc)
+		pr_debug("%s: creation of platform device failed\n",
+			 np->full_name);
+}
+EXPORT_SYMBOL_GPL(of_platform_device_ensure);
+
 #ifdef CONFIG_OF_DYNAMIC
 static int of_platform_notify(struct notifier_block *nb,
 				unsigned long action, void *arg)
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 611a691..df17890 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -73,6 +73,7 @@ extern int of_platform_populate(struct device_node *root,
 				const struct of_dev_auxdata *lookup,
 				struct device *parent);
 extern void of_platform_depopulate(struct device *parent);
+extern void of_platform_device_ensure(struct device_node *np);
 #else
 static inline int of_platform_populate(struct device_node *root,
 					const struct of_device_id *matches,
@@ -82,6 +83,7 @@ static inline int of_platform_populate(struct device_node *root,
 	return -ENODEV;
 }
 static inline void of_platform_depopulate(struct device *parent) { }
+static inline void of_platform_device_ensure(struct device_node *np) { }
 #endif
 
 #if defined(CONFIG_OF_DYNAMIC) && defined(CONFIG_OF_ADDRESS)
-- 
2.4.1
