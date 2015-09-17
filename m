From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 17 Sep 2015 14:56:57 +0200
Subject: [PATCH v5 03/23] of/platform: Point to struct device from device node
In-Reply-To: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1442494637-3674-4-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When adding platform and AMBA devices, set the device node's device
member to point to it.

This speeds lookups considerably and is safe because we only create one
of these devices for any given device node.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v5:
- Set the pointer to struct device also for AMBA devices
- Unset the pointer to struct device when the platform device is about
  to be unregistered
- Increase the reference count of the device before returning from
  of_find_device_by_node()

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/of/platform.c | 19 ++++++++++---------
 include/linux/of.h    |  1 +
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 1001efaedcb8..408d89f1d124 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -32,11 +32,6 @@ const struct of_device_id of_default_bus_match_table[] = {
 	{} /* Empty terminated list */
 };
 
-static int of_dev_node_match(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 /**
  * of_find_device_by_node - Find the platform_device associated with a node
  * @np: Pointer to device tree node
@@ -45,10 +40,10 @@ static int of_dev_node_match(struct device *dev, void *data)
  */
 struct platform_device *of_find_device_by_node(struct device_node *np)
 {
-	struct device *dev;
-
-	dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match);
-	return dev ? to_platform_device(dev) : NULL;
+	if (np->device && np->device->bus == &platform_bus_type &&
+	    get_device(np->device))
+		return to_platform_device(np->device);
+	return NULL;
 }
 EXPORT_SYMBOL(of_find_device_by_node);
 
@@ -192,6 +187,8 @@ static struct platform_device *of_platform_device_create_pdata(
 		goto err_clear_flag;
 	}
 
+	np->device = &dev->dev;
+
 	return dev;
 
 err_clear_flag:
@@ -272,6 +269,8 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 		goto err_free;
 	}
 
+	node->device = &dev->dev;
+
 	return dev;
 
 err_free:
@@ -476,6 +475,8 @@ static int of_platform_device_destroy(struct device *dev, void *data)
 	if (of_node_check_flag(dev->of_node, OF_POPULATED_BUS))
 		device_for_each_child(dev, NULL, of_platform_device_destroy);
 
+	dev->of_node->device = NULL;
+
 	if (dev->bus == &platform_bus_type)
 		platform_device_unregister(to_platform_device(dev));
 #ifdef CONFIG_ARM_AMBA
diff --git a/include/linux/of.h b/include/linux/of.h
index 2194b8ca41f9..eb091be0f8ee 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -52,6 +52,7 @@ struct device_node {
 	phandle phandle;
 	const char *full_name;
 	struct fwnode_handle fwnode;
+	struct device *device;
 
 	struct	property *properties;
 	struct	property *deadprops;	/* removed properties */
-- 
2.4.3
