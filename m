From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 24 Apr 2018 19:30:44 +0200
Subject: [PATCH 04/11] of: platform: use pdev as name for vars of type struct
 platform_device
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
Message-ID: <20180424173051.15099-5-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

It's a good convention to name struct device local variables 'dev'
and reserve 'pdev' for struct platform_device. Otherwise the code
sometimes becomes confusing to read. Rename all such instances in
of/platform.c

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/of/platform.c | 50 +++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index c00d81dfac0b..60342209fbd8 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -109,12 +109,12 @@ struct platform_device *of_device_alloc(struct device_node *np,
 				  const char *bus_id,
 				  struct device *parent)
 {
-	struct platform_device *dev;
+	struct platform_device *pdev;
 	int rc, i, num_reg = 0, num_irq;
 	struct resource *res, temp_res;
 
-	dev = platform_device_alloc("", PLATFORM_DEVID_NONE);
-	if (!dev)
+	pdev = platform_device_alloc("", PLATFORM_DEVID_NONE);
+	if (!pdev)
 		return NULL;
 
 	/* count the io and irq resources */
@@ -126,12 +126,12 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	if (num_irq || num_reg) {
 		res = kzalloc(sizeof(*res) * (num_irq + num_reg), GFP_KERNEL);
 		if (!res) {
-			platform_device_put(dev);
+			platform_device_put(pdev);
 			return NULL;
 		}
 
-		dev->num_resources = num_reg + num_irq;
-		dev->resource = res;
+		pdev->num_resources = num_reg + num_irq;
+		pdev->resource = res;
 		for (i = 0; i < num_reg; i++, res++) {
 			rc = of_address_to_resource(np, i, res);
 			WARN_ON(rc);
@@ -141,16 +141,16 @@ struct platform_device *of_device_alloc(struct device_node *np,
 				 np->name);
 	}
 
-	dev->dev.of_node = of_node_get(np);
-	dev->dev.fwnode = &np->fwnode;
-	dev->dev.parent = parent ? : &platform_bus;
+	pdev->dev.of_node = of_node_get(np);
+	pdev->dev.fwnode = &np->fwnode;
+	pdev->dev.parent = parent ? : &platform_bus;
 
 	if (bus_id)
-		dev_set_name(&dev->dev, "%s", bus_id);
+		dev_set_name(&pdev->dev, "%s", bus_id);
 	else
-		of_device_make_bus_id(&dev->dev);
+		of_device_make_bus_id(&pdev->dev);
 
-	return dev;
+	return pdev;
 }
 EXPORT_SYMBOL(of_device_alloc);
 
@@ -170,26 +170,26 @@ static struct platform_device *of_platform_device_create_pdata(
 					void *platform_data,
 					struct device *parent)
 {
-	struct platform_device *dev;
+	struct platform_device *pdev;
 
 	if (!of_device_is_available(np) ||
 	    of_node_test_and_set_flag(np, OF_POPULATED))
 		return NULL;
 
-	dev = of_device_alloc(np, bus_id, parent);
-	if (!dev)
+	pdev = of_device_alloc(np, bus_id, parent);
+	if (!pdev)
 		goto err_clear_flag;
 
-	dev->dev.bus = &platform_bus_type;
-	dev->dev.platform_data = platform_data;
-	of_msi_configure(&dev->dev, dev->dev.of_node);
+	pdev->dev.bus = &platform_bus_type;
+	pdev->dev.platform_data = platform_data;
+	of_msi_configure(&pdev->dev, pdev->dev.of_node);
 
-	if (of_device_add(dev) != 0) {
-		platform_device_put(dev);
+	if (of_device_add(pdev) != 0) {
+		platform_device_put(pdev);
 		goto err_clear_flag;
 	}
 
-	return dev;
+	return pdev;
 
 err_clear_flag:
 	of_node_clear_flag(np, OF_POPULATED);
@@ -344,7 +344,7 @@ static int of_platform_bus_create(struct device_node *bus,
 {
 	const struct of_dev_auxdata *auxdata;
 	struct device_node *child;
-	struct platform_device *dev;
+	struct platform_device *pdev;
 	const char *bus_id = NULL;
 	void *platform_data = NULL;
 	int rc = 0;
@@ -377,13 +377,13 @@ static int of_platform_bus_create(struct device_node *bus,
 		return 0;
 	}
 
-	dev = of_platform_device_create_pdata(bus, bus_id, platform_data, parent);
-	if (!dev || !of_match_node(matches, bus))
+	pdev = of_platform_device_create_pdata(bus, bus_id, platform_data, parent);
+	if (!pdev || !of_match_node(matches, bus))
 		return 0;
 
 	for_each_child_of_node(bus, child) {
 		pr_debug("   create child: %pOF\n", child);
-		rc = of_platform_bus_create(child, matches, lookup, &dev->dev, strict);
+		rc = of_platform_bus_create(child, matches, lookup, &pdev->dev, strict);
 		if (rc) {
 			of_node_put(child);
 			break;
-- 
2.17.0
