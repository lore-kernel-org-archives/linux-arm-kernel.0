From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon,  7 Sep 2015 14:23:28 +0200
Subject: [PATCH v4 03/22] of/platform: Point to struct device from device node
In-Reply-To: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1441628627-5143-4-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When adding a platform device, set the device node's device member to
point to it.

This speeds lookups considerably and is safe because we only create one
platform device for any given device node.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/of/platform.c | 13 +++++--------
 include/linux/of.h    |  1 +
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 1001efaedcb8..baf04d7249bd 100644
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
+	if (np->device && np->device->bus == &platform_bus_type)
+		return to_platform_device(np->device);
 
-	dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match);
-	return dev ? to_platform_device(dev) : NULL;
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
