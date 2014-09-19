From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 19 Sep 2014 18:36:49 +0530
Subject: [PATCH v4] mfd: syscon: Decouple syscon interface from platform
 devices
Message-ID: <1411132009-11173-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently a syscon entity can be only registered directly through a
platform device that binds to a dedicated syscon driver. However in
certain use cases it is desirable to make a device used with another
driver a syscon interface provider.

For example, certain SoCs (e.g. Exynos) contain system controller
blocks which perform various functions such as power domain control,
CPU power management, low power mode control, but in addition contain
certain IP integration glue, such as various signal masks,
coprocessor power control, etc. In such case, there is a need to have
a dedicated driver for such system controller but also share registers
with other drivers. The latter is where the syscon interface is helpful.

In case of DT based platforms, this patch decouples syscon object from
syscon platform driver, and allows to create syscon objects first time
when it is required by calling of syscon_regmap_lookup_by APIs and keep
a list of such syscon objects along with syscon provider device_nodes
and regmap handles.

For non-DT based platforms, this patch keeps syscon platform driver
structure where is can be probed and such non-DT based drivers can use
syscon_regmap_lookup_by_pdev API and get access to regmap handles.
Once all users of "syscon_regmap_lookup_by_pdev" migrated to DT based,
we can completly remove platform driver of syscon, and keep only helper
functions to get regmap handles.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
Tested-by: Vivek Gautam <gautam.vivek@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
Changes since v3:
 - Addressed Arnd's comment for v2.
 - Updated of_syscon_register for adding dev pointer in regmap_init_mmio.
 - For early users created dummy platform device.
   
Changes since v2:
 - Added back platform device support from syscon, with one change that
   syscon will not be probed for DT based platform.
 - Added back syscon_regmap_lookup_by_pdevname API so that non-DT base
   users of syscon will not be broken.
 - Removed unwanted change in syscon.h.
 - Modified Signed-off-by list, added Suggested-by of Tomasz Figa and
   Arnd Bergmann.
 - Added Tested-by of Vivek Gautam for testing on Exynos platform.

Changes since v1:
 - Removed of_syscon_unregister function.
 - Modified of_syscon_register function and it will be used by syscon.c
   to create syscon objects whenever required.
 - Removed platform device support from syscon.
 - Removed syscon_regmap_lookup_by_pdevname API support.
 - As there are significant changes w.r.t patchset v1, I am taking over
   author for this patchset from Tomasz Figa.

[1]: https://lkml.org/lkml/2014/9/2/299
 drivers/mfd/syscon.c |  102 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 79 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index ca15878..630de0a 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/list.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
@@ -22,33 +23,100 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
+#include <linux/slab.h>
 
 static struct platform_driver syscon_driver;
 
+static DEFINE_SPINLOCK(syscon_list_slock);
+static LIST_HEAD(syscon_list);
+
 struct syscon {
+	struct device_node *np;
 	struct regmap *regmap;
+	struct list_head list;
+};
+
+static struct regmap_config syscon_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
 };
 
-static int syscon_match_node(struct device *dev, void *data)
+static struct syscon *of_syscon_register(struct device_node *np)
 {
-	struct device_node *dn = data;
+	struct platform_device *pdev = NULL;
+	struct syscon *syscon;
+	struct regmap *regmap;
+	void __iomem *base;
+
+
+	if (!of_device_is_compatible(np, "syscon"))
+		return ERR_PTR(-EINVAL);
+
+	syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
+	if (!syscon)
+		return ERR_PTR(-ENOMEM);
+
+	base = of_iomap(np, 0);
+	if (!base)
+		return ERR_PTR(-ENOMEM);
+
+	if (!of_device_is_available(np) ||
+			of_node_test_and_set_flag(np, OF_POPULATED)) {
+		/* if device is already populated and avaiable then use it */
+		pdev = of_find_device_by_node(np);
+		if (!(&pdev->dev))
+			return ERR_PTR(-ENODEV);
+
+	} else {
+		/* for early users create dummy syscon device and use it */
+		pdev = kzalloc(sizeof(*pdev), GFP_KERNEL);
+		if (!pdev)
+			return ERR_PTR(-ENOMEM);
+
+		pdev->name = "dummy-syscon";
+		pdev->id = -1;
+		device_initialize(&pdev->dev);
+		pdev->dev.of_node = np;
+	}
+
+	regmap = regmap_init_mmio(&pdev->dev, base, &syscon_regmap_config);
+	if (IS_ERR(regmap)) {
+		pr_err("regmap init failed\n");
+		return ERR_CAST(regmap);
+	}
+
+	syscon->regmap = regmap;
+	syscon->np = np;
 
-	return (dev->of_node == dn) ? 1 : 0;
+	spin_lock(&syscon_list_slock);
+	list_add_tail(&syscon->list, &syscon_list);
+	spin_unlock(&syscon_list_slock);
+
+	return syscon;
 }
 
 struct regmap *syscon_node_to_regmap(struct device_node *np)
 {
-	struct syscon *syscon;
-	struct device *dev;
+	struct syscon *entry, *syscon = NULL;
 
-	dev = driver_find_device(&syscon_driver.driver, NULL, np,
-				 syscon_match_node);
-	if (!dev)
-		return ERR_PTR(-EPROBE_DEFER);
+	spin_lock(&syscon_list_slock);
 
-	syscon = dev_get_drvdata(dev);
+	list_for_each_entry(entry, &syscon_list, list)
+		if (entry->np == np) {
+			syscon = entry;
+			break;
+		}
 
-	return syscon->regmap;
+	spin_unlock(&syscon_list_slock);
+
+	if (!syscon)
+		syscon = of_syscon_register(np);
+
+	if (!IS_ERR(syscon))
+		return syscon->regmap;
+
+	return ERR_CAST(syscon);
 }
 EXPORT_SYMBOL_GPL(syscon_node_to_regmap);
 
@@ -110,17 +178,6 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle);
 
-static const struct of_device_id of_syscon_match[] = {
-	{ .compatible = "syscon", },
-	{ },
-};
-
-static struct regmap_config syscon_regmap_config = {
-	.reg_bits = 32,
-	.val_bits = 32,
-	.reg_stride = 4,
-};
-
 static int syscon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -167,7 +224,6 @@ static struct platform_driver syscon_driver = {
 	.driver = {
 		.name = "syscon",
 		.owner = THIS_MODULE,
-		.of_match_table = of_syscon_match,
 	},
 	.probe		= syscon_probe,
 	.id_table	= syscon_ids,
-- 
1.7.9.5
