From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 2 Dec 2015 17:09:28 +0800
Subject: [RFC PATCH 4/4] mfd: syscon: add ACPI support
In-Reply-To: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1449047368-5768-5-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables syscon with ACPI support.
syscon_regmap_lookup_by_dev_property() function was added. With helper
device_get_reference_node() and acpi_dev_find_plat_dev(), it can be used
in both DT and ACPI.

The device driver can obtain syscon using _DSD method in DSDT, an example
is shown below.

    Device(CTL0) {
          Name(_HID, "HISI0061")
          Name(_CRS, ResourceTemplate() {
                  Memory32Fixed(ReadWrite, 0x80000000, 0x10000)
          })
    }

    Device(DEV0) {
          Name(_HID, "HISI00B1")
          Name(_CRS, ResourceTemplate() {
                  Memory32Fixed(ReadWrite, 0x8c030000, 0x10000)
                  Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive){ 192 }
          })

          Name (_DSD, Package () {
              ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
              Package () {
                  Package () {"syscon",Package() {\_SB.CTL0} }
              }
          })
    }

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/mfd/syscon.c       | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/syscon.h |  8 ++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 176bf0f..6f23418 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -12,6 +12,7 @@
  * (at your option) any later version.
  */
 
+#include <linux/acpi.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -21,6 +22,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_data/syscon.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 #include <linux/slab.h>
@@ -174,6 +176,47 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle);
 
+struct regmap *syscon_regmap_lookup_by_dev_property(struct device *dev,
+						    const char *propname)
+{
+	struct fwnode_handle *fwnode;
+	struct regmap *regmap = NULL;
+
+	fwnode = device_get_reference_node(dev, propname, 0);
+
+	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
+		struct device_node *syscon_np;
+		if (propname)
+			syscon_np = to_of_node(fwnode);
+		else
+			syscon_np = dev->of_node;
+		if (!syscon_np)
+			return ERR_PTR(-ENODEV);
+		regmap = syscon_node_to_regmap(syscon_np);
+		of_node_put(syscon_np);
+	} else if (IS_ENABLED(CONFIG_ACPI)) {
+		struct platform_device *pdev;
+		struct acpi_device *adev;
+		struct syscon *syscon;
+
+		adev = to_acpi_device_node(fwnode);
+		if (!adev)
+			return ERR_PTR(-ENODEV);
+
+		pdev = acpi_dev_find_plat_dev(adev);
+		if (!pdev)
+			return ERR_PTR(-ENODEV);
+
+		syscon = platform_get_drvdata(pdev);
+		if (!syscon)
+			return ERR_PTR(-ENODEV);
+
+		regmap = syscon->regmap;
+	}
+	return regmap;
+}
+EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_dev_property);
+
 static int syscon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -216,9 +259,16 @@ static const struct platform_device_id syscon_ids[] = {
 	{ }
 };
 
+static const struct acpi_device_id syscon_acpi_match[] = {
+	{ "HISI0061", 0 }, /* better to use generic ACPI ID */
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, syscon_acpi_match);
+
 static struct platform_driver syscon_driver = {
 	.driver = {
 		.name = "syscon",
+		.acpi_match_table = ACPI_PTR(syscon_acpi_match),
 	},
 	.probe		= syscon_probe,
 	.id_table	= syscon_ids,
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index 75e543b..db79ca2 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -17,6 +17,7 @@
 
 #include <linux/err.h>
 
+struct device;
 struct device_node;
 
 #ifdef CONFIG_MFD_SYSCON
@@ -26,6 +27,8 @@ extern struct regmap *syscon_regmap_lookup_by_pdevname(const char *s);
 extern struct regmap *syscon_regmap_lookup_by_phandle(
 					struct device_node *np,
 					const char *property);
+extern struct regmap *syscon_regmap_lookup_by_dev_property(struct device *dev,
+						      const char *propname);
 #else
 static inline struct regmap *syscon_node_to_regmap(struct device_node *np)
 {
@@ -48,6 +51,11 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle(
 {
 	return ERR_PTR(-ENOSYS);
 }
+static inline struct regmap *syscon_regmap_lookup_by_dev_property(struct device *dev,
+						      const char *propname);
+{
+	return ERR_PTR(-ENOSYS);
+}
 #endif
 
 #endif /* __LINUX_MFD_SYSCON_H__ */
-- 
1.7.12.4
