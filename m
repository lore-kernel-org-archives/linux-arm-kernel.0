From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Aug 2017 16:42:17 +0200
Subject: [PATCH] soc/tegra: Register SoC device
Message-ID: <20170817144217.31346-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Move this code from arch/arm/mach-tegra and make it common among 32-bit
and 64-bit Tegra SoCs. This is slightly complicated by the fact that on
32-bit Tegra, the SoC device is used as the parent for all devices that
are instantiated from device tree.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-tegra/tegra.c         | 29 +---------------------
 drivers/soc/tegra/Kconfig           |  5 ++++
 drivers/soc/tegra/fuse/fuse-tegra.c | 48 +++++++++++++++++++++++++++++++++++--
 include/soc/tegra/fuse.h            |  2 ++
 4 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 649e9e8c7bcc..02e712d2ea30 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -84,35 +84,8 @@ static void __init tegra_dt_init_irq(void)
 
 static void __init tegra_dt_init(void)
 {
-	struct soc_device_attribute *soc_dev_attr;
-	struct soc_device *soc_dev;
-	struct device *parent = NULL;
+	struct device *parent = tegra_soc_device_register();
 
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
 	of_platform_default_populate(NULL, NULL, parent);
 }
 
diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 1beb7c347344..e9e277178c94 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -107,6 +107,11 @@ config ARCH_TEGRA_186_SOC
 endif
 endif
 
+config SOC_TEGRA_FUSE
+	def_bool y
+	depends on ARCH_TEGRA
+	select SOC_BUS
+
 config SOC_TEGRA_FLOWCTRL
 	bool
 
diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 75b38194750f..02686378dfc1 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -19,10 +19,12 @@
 #include <linux/device.h>
 #include <linux/kobject.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
 
 #include <soc/tegra/common.h>
 #include <soc/tegra/fuse.h>
@@ -213,6 +215,31 @@ static void tegra_enable_fuse_clk(void __iomem *base)
 	writel(reg, base + 0x14);
 }
 
+struct device * __init tegra_soc_device_register(void)
+{
+	struct soc_device_attribute *attr;
+	struct soc_device *dev;
+
+	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+	if (!attr)
+		return NULL;
+
+	attr->family = kasprintf(GFP_KERNEL, "Tegra");
+	attr->revision = kasprintf(GFP_KERNEL, "%d", tegra_sku_info.revision);
+	attr->soc_id = kasprintf(GFP_KERNEL, "%u", tegra_get_chip_id());
+
+	dev = soc_device_register(attr);
+	if (IS_ERR(dev)) {
+		kfree(attr->soc_id);
+		kfree(attr->revision);
+		kfree(attr->family);
+		kfree(attr);
+		return ERR_CAST(dev);
+	}
+
+	return soc_device_to_device(dev);
+}
+
 static int __init tegra_init_fuse(void)
 {
 	const struct of_device_id *match;
@@ -314,6 +341,23 @@ static int __init tegra_init_fuse(void)
 	pr_debug("Tegra CPU Speedo ID %d, SoC Speedo ID %d\n",
 		 tegra_sku_info.cpu_speedo_id, tegra_sku_info.soc_speedo_id);
 
+
 	return 0;
 }
 early_initcall(tegra_init_fuse);
+
+#ifdef CONFIG_ARM64
+static int __init tegra_init_soc(void)
+{
+	struct device *soc;
+
+	soc = tegra_soc_device_register();
+	if (IS_ERR(soc)) {
+		pr_err("failed to register SoC device: %ld\n", PTR_ERR(soc));
+		return PTR_ERR(soc);
+	}
+
+	return 0;
+}
+device_initcall(tegra_init_soc)
+#endif
diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
index b4c9219e7f95..9b6ea0c72117 100644
--- a/include/soc/tegra/fuse.h
+++ b/include/soc/tegra/fuse.h
@@ -65,6 +65,8 @@ int tegra_fuse_readl(unsigned long offset, u32 *value);
 
 extern struct tegra_sku_info tegra_sku_info;
 
+struct device *tegra_soc_device_register(void);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __SOC_TEGRA_FUSE_H__ */
-- 
2.13.3
