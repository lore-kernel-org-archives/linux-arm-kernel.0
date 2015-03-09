From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 9 Mar 2015 10:31:41 +0800
Subject: [PATCH] soc/tegra: move soc_device_register call out of arch/arm
Message-ID: <1425868301-22767-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expending the usage for both Tegra & Tegra64 SoCs.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/tegra.c | 31 +------------------------------
 drivers/soc/tegra/common.c  | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 914341bcef25..95df6a97b956 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -87,36 +87,7 @@ static void __init tegra_dt_init_irq(void)
 
 static void __init tegra_dt_init(void)
 {
-	struct soc_device_attribute *soc_dev_attr;
-	struct soc_device *soc_dev;
-	struct device *parent = NULL;
-
-	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
-	if (!soc_dev_attr)
-		goto out;
-
-	soc_dev_attr->family = kasprintf(GFP_KERNEL, "Tegra");
-	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d",
-					   tegra_sku_info.revision);
-	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%u", tegra_get_chip_id());
-
-	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev)) {
-		kfree(soc_dev_attr->family);
-		kfree(soc_dev_attr->revision);
-		kfree(soc_dev_attr->soc_id);
-		kfree(soc_dev_attr);
-		goto out;
-	}
-
-	parent = soc_device_to_device(soc_dev);
-
-	/*
-	 * Finished with the static registrations now; fill in the missing
-	 * devices
-	 */
-out:
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static void __init paz00_init(void)
diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index a71cb74f3674..caf7d375eeae 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -7,8 +7,11 @@
  */
 
 #include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
 
 #include <soc/tegra/common.h>
+#include <soc/tegra/fuse.h>
 
 static const struct of_device_id tegra_machine_match[] = {
 	{ .compatible = "nvidia,tegra20", },
@@ -28,3 +31,33 @@ bool soc_is_tegra(void)
 
 	return of_match_node(tegra_machine_match, root) != NULL;
 }
+
+static int __init tegra_soc_init(void)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+
+	if (!soc_is_tegra())
+		return 0;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->family = kasprintf(GFP_KERNEL, "Tegra");
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d",
+					   tegra_sku_info.revision);
+	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%u", tegra_get_chip_id());
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->family);
+		kfree(soc_dev_attr->revision);
+		kfree(soc_dev_attr->soc_id);
+		kfree(soc_dev_attr);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+device_initcall(tegra_soc_init);
-- 
2.3.1
