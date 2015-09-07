From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon,  7 Sep 2015 14:23:29 +0200
Subject: [PATCH v4 04/22] of: add function to allow probing a device from a OF
 node
In-Reply-To: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1441628627-5143-5-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Walks the OF tree up and finds the closest ancestor that has a struct
device associated with it, probing it if isn't bound to a driver yet.

The above should ensure that the dependency represented by the passed OF
node is available, because probing a device should cause its descendants
to be probed as well (when they get registered).

Subsystems can use this when looking up resources for drivers, to reduce
the chances of deferred probes because of the probing order of devices.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v4:
- Rename of_platform_probe to of_device_probe
- Use device_node.device instead of device_node.platform_dev

Changes in v3:
- Set and use device_node.platform_dev instead of reversing the logic to
  find the platform device that encloses a device node.
- Drop the fwnode API to probe firmware nodes and add OF-only API for
  now. I think this same scheme could be used for machines with ACPI,
  but I haven't been able to find one that had to defer its probes because
  of the device probe order.

Changes in v2: None

 drivers/of/device.c       | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/of/platform.c     |  2 ++
 include/linux/of_device.h |  3 +++
 3 files changed, 63 insertions(+)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 8b91ea241b10..c32ac7b6fbe2 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -286,3 +286,61 @@ int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
 
 	return 0;
 }
+
+/**
+ * of_device_probe() - Probe device associated with OF node
+ * @np: node to probe
+ *
+ * Probe the device associated with the passed device node.
+ */
+void of_device_probe(struct device_node *np)
+{
+	struct device_node *target;
+	struct device *dev = NULL;
+
+	if (!of_root || !of_node_check_flag(of_root, OF_POPULATED_BUS))
+		return;
+
+	if (!np)
+		return;
+
+	of_node_get(np);
+
+	/* Find the closest ancestor that has a device associated */
+	for (target = np;
+	     !of_node_is_root(target);
+	     target = of_get_next_parent(target))
+		if (target->device) {
+			dev = target->device;
+			break;
+		}
+
+	of_node_put(target);
+
+	if (!dev) {
+		pr_warn("Couldn't find a device for node '%s'\n",
+			of_node_full_name(np));
+		return;
+	}
+
+	/*
+	 * Device is bound or is being probed right now. If we have bad luck
+	 * and the dependency isn't ready when it's needed, deferred probe
+	 * will save us.
+	 */
+	if (dev->driver)
+		return;
+
+	/*
+	 * Probing a device should cause its descendants to be probed as
+	 * well, which includes the passed device node.
+	 */
+	if (device_attach(dev) != 1)
+		/*
+		 * This cannot be a warning for now because clock nodes have a
+		 * compatible string but the clock framework doesn't follow
+		 * the device/driver model yet.
+		 */
+		dev_dbg(dev, "Probe failed for %s\n", of_node_full_name(np));
+}
+EXPORT_SYMBOL_GPL(of_device_probe);
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index baf04d7249bd..f089d95ac961 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -269,6 +269,8 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 		goto err_free;
 	}
 
+	node->device = &dev->dev;
+
 	return dev;
 
 err_free:
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index cc7dd687a89d..da8d489e73ad 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -40,6 +40,7 @@ extern ssize_t of_device_get_modalias(struct device *dev,
 
 extern void of_device_uevent(struct device *dev, struct kobj_uevent_env *env);
 extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env);
+extern void of_device_probe(struct device_node *np);
 
 static inline void of_device_node_put(struct device *dev)
 {
@@ -84,6 +85,8 @@ static inline int of_device_uevent_modalias(struct device *dev,
 	return -ENODEV;
 }
 
+static inline void of_device_probe(struct device_node *np) { }
+
 static inline void of_device_node_put(struct device *dev) { }
 
 static inline const struct of_device_id *__of_match_device(
-- 
2.4.3
