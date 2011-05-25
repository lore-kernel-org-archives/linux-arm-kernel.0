From: robherring2@gmail.com (Rob Herring)
Date: Wed, 25 May 2011 16:31:13 -0500
Subject: [RFC PATCH v3 2/2] dt: add custom device creation to platform bus scan
In-Reply-To: <1306359073-16274-1-git-send-email-robherring2@gmail.com>
References: <1306359073-16274-1-git-send-email-robherring2@gmail.com>
Message-ID: <1306359073-16274-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add support to the platform bus scanning to call custom device creation
functions. This enables creation of non-platform devices like amba_bus.

Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: linux at arm.linux.org.uk
Cc: arnd at arndb.de
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/of/platform.c       |   27 +++++++++++++++++++--------
 include/linux/of_platform.h |   11 ++++++++---
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 9b785be..8c0f43400 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -176,9 +176,9 @@ EXPORT_SYMBOL(of_device_alloc);
  * Returns pointer to created platform device, or NULL if a device was not
  * registered.  Unavailable devices will not get registered.
  */
-struct platform_device *of_platform_device_create(struct device_node *np,
-					    const char *bus_id,
-					    struct device *parent)
+struct device *of_platform_device_create(struct device_node *np,
+					 const char *bus_id,
+					 struct device *parent)
 {
 	struct platform_device *dev;
 
@@ -205,7 +205,7 @@ struct platform_device *of_platform_device_create(struct device_node *np,
 		return NULL;
 	}
 
-	return dev;
+	return &dev->dev;
 }
 EXPORT_SYMBOL(of_platform_device_create);
 
@@ -224,7 +224,9 @@ static int of_platform_bus_create(struct device_node *bus,
 				  struct device *parent, bool strict)
 {
 	struct device_node *child;
-	struct platform_device *dev;
+	struct device *dev;
+	struct of_device_id *id;
+	struct of_platform_match_data *mdata;
 	int rc = 0;
 
 	/* Make sure it has a compatible property */
@@ -234,13 +236,22 @@ static int of_platform_bus_create(struct device_node *bus,
 		return 0;
 	}
 
-	dev = of_platform_device_create(bus, NULL, parent);
-	if (!dev || !of_match_node(matches, bus))
+	id = of_match_node(matches, bus);
+	if (!id)
+		return 0;
+
+	/* Found a matching node, so create the device */
+	mdata = id->data;
+	if (mdata && mdata->dev_create)
+		dev = mdata->dev_create(bus, parent);
+	else
+		dev = of_platform_device_create(bus, NULL, parent);
+	if (!dev)
 		return 0;
 
 	for_each_child_of_node(bus, child) {
 		pr_debug("   create child: %s\n", child->full_name);
-		rc = of_platform_bus_create(child, matches, &dev->dev, strict);
+		rc = of_platform_bus_create(child, matches, dev, strict);
 		if (rc) {
 			of_node_put(child);
 			break;
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 43c723d..f59d25e 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -40,6 +40,11 @@ struct of_platform_driver
 #define	to_of_platform_driver(drv) \
 	container_of(drv,struct of_platform_driver, driver)
 
+struct of_platform_match_data {
+	struct device *	(*dev_create)(struct device_node *node,
+				      struct device *parent);
+};
+
 /* Platform drivers register/unregister */
 extern struct platform_device *of_device_alloc(struct device_node *np,
 					 const char *bus_id,
@@ -48,9 +53,9 @@ extern struct platform_device *of_find_device_by_node(struct device_node *np);
 
 #if !defined(CONFIG_SPARC) /* SPARC has its own device registration method */
 /* Platform devices and busses creation */
-extern struct platform_device *of_platform_device_create(struct device_node *np,
-						   const char *bus_id,
-						   struct device *parent);
+extern struct device *of_platform_device_create(struct device_node *np,
+						const char *bus_id,
+						struct device *parent);
 
 extern int of_platform_bus_probe(struct device_node *root,
 				 const struct of_device_id *matches,
-- 
1.7.4.1
