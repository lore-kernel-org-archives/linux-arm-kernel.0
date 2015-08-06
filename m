From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu,  6 Aug 2015 16:11:39 +0200
Subject: [PATCH v3 02/18] of/platform: add of_platform_probe
In-Reply-To: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438870315-18689-3-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Walks the OF tree up and finds the closest ancestor that has a platform
device associated with it, probing it if isn't bound to a driver yet.

The above should ensure that the dependency represented by the passed OF
node is available, because probing a platform device should cause its
descendants to be probed as well.

Subsystems can use this when looking up resources for drivers, to reduce
the chances of deferred probes because of the probing order of devices.

Also adds a platform_dev member to struct device_node, pointing to the
platform device that was registered based on that node, if any.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v3:
- Set and use device_node.platform_dev instead of reversing the logic to
  find the platform device that encloses a device node.
- Drop the fwnode API to probe firmware nodes and add OF-only API for
  now. I think this same scheme could be used for machines with ACPI,
  but I haven't been able to find one that had to defer its probes because
  of the device probe order.

Changes in v2: None

 drivers/of/platform.c       | 61 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h          |  1 +
 include/linux/of_platform.h |  2 ++
 3 files changed, 64 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 8a002d6151f2..a1930c0d1fee 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -192,6 +192,8 @@ static struct platform_device *of_platform_device_create_pdata(
 		goto err_clear_flag;
 	}
 
+	np->platform_dev = dev;
+
 	return dev;
 
 err_clear_flag:
@@ -501,6 +503,65 @@ void of_platform_depopulate(struct device *parent)
 }
 EXPORT_SYMBOL_GPL(of_platform_depopulate);
 
+/**
+ * of_platform_probe() - Probe platform device associated with OF node
+ * @np: node to probe
+ *
+ * Walks the OF tree up and finds the closest ancestor that has a platform
+ * device associated with it, probing it if isn't bound to a driver yet.
+ *
+ * The above should ensure that the dependency represented by the passed OF
+ * node is available, because probing a platform device should cause its
+ * descendants to be probed as well.
+ */
+void of_platform_probe(struct device_node *np)
+{
+	struct device_node *target;
+	struct platform_device *pdev = NULL;
+
+	if (!of_root || !of_node_check_flag(of_root, OF_POPULATED_BUS))
+		return;
+
+	if (!np)
+		return;
+
+	of_node_get(np);
+
+	for (target = np;
+	     !of_node_is_root(target);
+	     target = of_get_next_parent(target))
+		if (target->platform_dev) {
+			pdev = target->platform_dev;
+			break;
+		}
+
+	of_node_put(target);
+
+	if (!pdev) {
+		pr_warn("Couldn't find a platform device for node '%s'\n",
+			of_node_full_name(np));
+		return;
+	}
+
+	/*
+	 * Device is bound or is being probed right now. If we have bad luck
+	 * and the dependency isn't ready when it's needed, deferred probe
+	 * will save us.
+	 */
+	if (pdev->dev.driver)
+		return;
+
+	if (device_attach(&pdev->dev) != 1)
+		/*
+		 * This cannot be a warning for now because clock nodes have a
+		 * compatible string but the clock framework doesn't follow the
+		 * device/driver model.
+		 */
+		pr_debug("Probe failed for %s (%s)\n", of_node_full_name(np),
+			 dev_name(&pdev->dev));
+}
+EXPORT_SYMBOL_GPL(of_platform_probe);
+
 #ifdef CONFIG_OF_DYNAMIC
 static int of_platform_notify(struct notifier_block *nb,
 				unsigned long action, void *arg)
diff --git a/include/linux/of.h b/include/linux/of.h
index edc068d19c79..2ace86a5fa2d 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -52,6 +52,7 @@ struct device_node {
 	phandle phandle;
 	const char *full_name;
 	struct fwnode_handle fwnode;
+	struct platform_device *platform_dev;
 
 	struct	property *properties;
 	struct	property *deadprops;	/* removed properties */
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 611a691145c4..91ca92c7c061 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -73,6 +73,7 @@ extern int of_platform_populate(struct device_node *root,
 				const struct of_dev_auxdata *lookup,
 				struct device *parent);
 extern void of_platform_depopulate(struct device *parent);
+extern void of_platform_probe(struct device_node *np);
 #else
 static inline int of_platform_populate(struct device_node *root,
 					const struct of_device_id *matches,
@@ -82,6 +83,7 @@ static inline int of_platform_populate(struct device_node *root,
 	return -ENODEV;
 }
 static inline void of_platform_depopulate(struct device *parent) { }
+static inline void of_platform_probe(struct device_node *np) { }
 #endif
 
 #if defined(CONFIG_OF_DYNAMIC) && defined(CONFIG_OF_ADDRESS)
-- 
2.4.3
