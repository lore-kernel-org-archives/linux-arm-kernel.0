From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Sun, 26 Jun 2016 00:28:19 -0700
Subject: [PATCH 02/21] usb: ulpi: Support device discovery via DT
In-Reply-To: <20160626072838.28082-1-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
Message-ID: <20160626072838.28082-3-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The qcom HSIC ulpi phy doesn't have any bits set in the vendor or
product id ulpi registers. This makes it impossible to make a
ulpi driver match against the id registers. Add support to
discover the ulpi phys via DT to help alleviate this problem.
We'll look for a ulpi bus node underneath the device registering
the ulpi viewport (or the parent of that device to support
chipidea's device layout) and then match up the phy node
underneath that with the ulpi device that's created.

The side benefit of this is that we can use standard DT
properties in the phy node like clks, regulators, gpios, etc.
because we don't have firmware like ACPI to turn these things on
for us. And we can use the DT phy binding to point our phy
consumer to the phy provider.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: <devicetree@vger.kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 Documentation/devicetree/bindings/usb/ulpi.txt | 20 +++++++++
 drivers/usb/common/ulpi.c                      | 56 +++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ulpi.txt

diff --git a/Documentation/devicetree/bindings/usb/ulpi.txt b/Documentation/devicetree/bindings/usb/ulpi.txt
new file mode 100644
index 000000000000..ca179dc4bd50
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ulpi.txt
@@ -0,0 +1,20 @@
+ULPI bus binding
+----------------
+
+Phys that are behind a ULPI connection can be described with the following
+binding. The host controller shall have a "ulpi" named node as a child, and
+that node shall have one enabled node underneath it representing the ulpi
+device on the bus.
+
+EXAMPLE
+-------
+
+usb {
+	compatible = "vendor,usb-controller";
+
+	ulpi {
+		phy {
+			compatible = "vendor,phy";
+		};
+	};
+};
diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 01c0c0477a9e..980af672bfe3 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -16,6 +16,9 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/clk/clk-conf.h>
 
 /* -------------------------------------------------------------------------- */
 
@@ -39,7 +42,10 @@ static int ulpi_match(struct device *dev, struct device_driver *driver)
 	struct ulpi *ulpi = to_ulpi_dev(dev);
 	const struct ulpi_device_id *id;
 
-	for (id = drv->id_table; id->vendor; id++)
+	if (of_driver_match_device(dev, driver))
+		return 1;
+
+	for (id = drv->id_table; id && id->vendor; id++)
 		if (id->vendor == ulpi->id.vendor &&
 		    id->product == ulpi->id.product)
 			return 1;
@@ -50,6 +56,11 @@ static int ulpi_match(struct device *dev, struct device_driver *driver)
 static int ulpi_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct ulpi *ulpi = to_ulpi_dev(dev);
+	int ret;
+
+	ret = of_device_uevent_modalias(dev, env);
+	if (ret != -ENODEV)
+		return ret;
 
 	if (add_uevent_var(env, "MODALIAS=ulpi:v%04xp%04x",
 			   ulpi->id.vendor, ulpi->id.product))
@@ -60,6 +71,11 @@ static int ulpi_uevent(struct device *dev, struct kobj_uevent_env *env)
 static int ulpi_probe(struct device *dev)
 {
 	struct ulpi_driver *drv = to_ulpi_driver(dev->driver);
+	int ret;
+
+	ret = of_clk_set_defaults(dev->of_node, false);
+	if (ret < 0)
+		return ret;
 
 	return drv->probe(to_ulpi_dev(dev));
 }
@@ -87,8 +103,13 @@ static struct bus_type ulpi_bus = {
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
+	int len;
 	struct ulpi *ulpi = to_ulpi_dev(dev);
 
+	len = of_device_get_modalias(dev, buf, PAGE_SIZE - 1);
+	if (len != -ENODEV)
+		return len;
+
 	return sprintf(buf, "ulpi:v%04xp%04x\n",
 		       ulpi->id.vendor, ulpi->id.product);
 }
@@ -152,6 +173,28 @@ EXPORT_SYMBOL_GPL(ulpi_unregister_driver);
 
 /* -------------------------------------------------------------------------- */
 
+static int ulpi_of_register(struct ulpi *ulpi)
+{
+	struct device_node *np = NULL, *child;
+
+	/* Find a ulpi bus underneath the parent or the parent of the parent */
+	if (ulpi->dev.parent->of_node)
+		np = of_find_node_by_name(ulpi->dev.parent->of_node, "ulpi");
+	else if (ulpi->dev.parent->parent &&
+		 ulpi->dev.parent->parent->of_node)
+		np = of_find_node_by_name(ulpi->dev.parent->parent->of_node, "ulpi");
+	if (!np)
+		return 0;
+
+	child = of_get_next_available_child(np, NULL);
+	if (!child)
+		return -EINVAL;
+
+	ulpi->dev.of_node = child;
+
+	return 0;
+}
+
 static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 {
 	int ret;
@@ -181,7 +224,15 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 
 	ACPI_COMPANION_SET(&ulpi->dev, ACPI_COMPANION(dev));
 
-	request_module("ulpi:v%04xp%04x", ulpi->id.vendor, ulpi->id.product);
+	if (IS_ENABLED(CONFIG_OF)) {
+		ret = ulpi_of_register(ulpi);
+		if (ret)
+			return ret;
+	}
+
+	if (of_device_request_module(&ulpi->dev))
+		request_module("ulpi:v%04xp%04x", ulpi->id.vendor,
+			       ulpi->id.product);
 
 	ret = device_register(&ulpi->dev);
 	if (ret)
@@ -232,6 +283,7 @@ EXPORT_SYMBOL_GPL(ulpi_register_interface);
  */
 void ulpi_unregister_interface(struct ulpi *ulpi)
 {
+	of_node_put(ulpi->dev.of_node);
 	device_unregister(&ulpi->dev);
 }
 EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
-- 
2.9.0.rc2.8.ga28705d
