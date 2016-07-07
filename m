From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu,  7 Jul 2016 15:20:54 -0700
Subject: [PATCH v2 03/22] usb: ulpi: Support device discovery via device
 properties
In-Reply-To: <20160707222114.1673-1-stephen.boyd@linaro.org>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
Message-ID: <20160707222114.1673-4-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The qcom HSIC ULPI phy doesn't have any bits set in the vendor or
product ID registers. This makes it impossible to make a ULPI
driver match against the ID registers. Add support to discover
the ULPI phys via DT/device properties to help alleviate this
problem. In the DT case, we'll look for a ULPI bus node
underneath the device registering the ULPI viewport (or the
parent of that device to support chipidea's device layout) and
then match up the phy node underneath that with the ULPI device
that's created.

The side benefit of this is that we can use standard properties
in the phy node like clks, regulators, gpios, etc. because we
don't have firmware like ACPI to turn these things on for us. And
we can use the DT phy binding to point our phy consumer to the
phy provider.

Furthermore, this avoids any problems with reading the ID
registers before the phy is powered up. The ULPI bus supports
native enumeration by reading the vendor ID and product ID
registers at device creation time, but we can't be certain that
those register reads will succeed if the phy is not powered.

If the ULPI spec had some generic power sequencing for these
registers we could put that into the ULPI bus layer and power up
the device before reading the ID registers. Unfortunately this
doesn't exist and the power sequence is usually device specific.
By having the vendor and product ID properties in ACPI or DT, we
can match up devices with drivers without having to read the
hardware before it's powered up and avoid this problem.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: <devicetree@vger.kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 Documentation/devicetree/bindings/usb/ulpi.txt | 35 ++++++++++++
 drivers/usb/common/ulpi.c                      | 74 +++++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ulpi.txt

diff --git a/Documentation/devicetree/bindings/usb/ulpi.txt b/Documentation/devicetree/bindings/usb/ulpi.txt
new file mode 100644
index 000000000000..c649ca5b0996
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ulpi.txt
@@ -0,0 +1,35 @@
+ULPI bus binding
+----------------
+
+Phys that are behind a ULPI connection can be described with the following
+binding. The host controller shall have a "ulpi" named node as a child, and
+that node shall have one enabled node underneath it representing the ulpi
+device on the bus.
+
+PROPERTIES
+----------
+
+- ulpi-vendor:
+    Usage: optional
+    Value type: <u16>
+    Definition: The USB-IF assigned vendor id for this device
+
+- ulpi-product:
+    Usage: required if ulpi-vendor is present
+    Value type: <u16>
+    Definition: The vendor assigned product id for this device
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
+			ulpi-vendor = /bits/ 16 <0x1d6b>;
+			ulpi-product = /bits/ 16 <0x0002>;
+		};
+	};
+};
diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 01c0c0477a9e..3e8dd7b57aaf 100644
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
 
@@ -39,6 +42,10 @@ static int ulpi_match(struct device *dev, struct device_driver *driver)
 	struct ulpi *ulpi = to_ulpi_dev(dev);
 	const struct ulpi_device_id *id;
 
+	/* Some ULPI devices don't have a product id so rely on OF match */
+	if (ulpi->id.product == 0)
+		return of_driver_match_device(dev, driver);
+
 	for (id = drv->id_table; id->vendor; id++)
 		if (id->vendor == ulpi->id.vendor &&
 		    id->product == ulpi->id.product)
@@ -50,6 +57,11 @@ static int ulpi_match(struct device *dev, struct device_driver *driver)
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
@@ -60,6 +72,11 @@ static int ulpi_uevent(struct device *dev, struct kobj_uevent_env *env)
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
@@ -87,8 +104,13 @@ static struct bus_type ulpi_bus = {
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
@@ -152,7 +174,29 @@ EXPORT_SYMBOL_GPL(ulpi_unregister_driver);
 
 /* -------------------------------------------------------------------------- */
 
-static int ulpi_register(struct device *dev, struct ulpi *ulpi)
+static int ulpi_of_register(struct ulpi *ulpi)
+{
+	struct device_node *np = NULL, *child;
+
+	/* Find a ulpi bus underneath the parent or the parent of the parent */
+	if (ulpi->dev.parent->of_node)
+		np = of_find_node_by_name(ulpi->dev.parent->of_node, "ulpi");
+	else if (ulpi->dev.parent->parent && ulpi->dev.parent->parent->of_node)
+		np = of_find_node_by_name(ulpi->dev.parent->parent->of_node,
+					  "ulpi");
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
+static int ulpi_read_id(struct ulpi *ulpi)
 {
 	int ret;
 
@@ -174,14 +218,39 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 	ulpi->id.product = ulpi_read(ulpi, ULPI_PRODUCT_ID_LOW);
 	ulpi->id.product |= ulpi_read(ulpi, ULPI_PRODUCT_ID_HIGH) << 8;
 
+	return 0;
+}
+
+static int ulpi_register(struct device *dev, struct ulpi *ulpi)
+{
+	int ret;
+
 	ulpi->dev.parent = dev;
 	ulpi->dev.bus = &ulpi_bus;
 	ulpi->dev.type = &ulpi_dev_type;
 	dev_set_name(&ulpi->dev, "%s.ulpi", dev_name(dev));
 
+	if (IS_ENABLED(CONFIG_OF)) {
+		ret = ulpi_of_register(ulpi);
+		if (ret)
+			return ret;
+	}
+
 	ACPI_COMPANION_SET(&ulpi->dev, ACPI_COMPANION(dev));
 
-	request_module("ulpi:v%04xp%04x", ulpi->id.vendor, ulpi->id.product);
+	ret = device_property_read_u16(&ulpi->dev, "ulpi-vendor",
+				       &ulpi->id.vendor);
+	ret |= device_property_read_u16(&ulpi->dev, "ulpi-product",
+					&ulpi->id.product);
+	if (ret) {
+		ret = ulpi_read_id(ulpi);
+		if (ret)
+			return ret;
+	}
+
+	if (of_device_request_module(&ulpi->dev))
+		request_module("ulpi:v%04xp%04x", ulpi->id.vendor,
+			       ulpi->id.product);
 
 	ret = device_register(&ulpi->dev);
 	if (ret)
@@ -232,6 +301,7 @@ EXPORT_SYMBOL_GPL(ulpi_register_interface);
  */
 void ulpi_unregister_interface(struct ulpi *ulpi)
 {
+	of_node_put(ulpi->dev.of_node);
 	device_unregister(&ulpi->dev);
 }
 EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
-- 
2.9.0.rc2.8.ga28705d
