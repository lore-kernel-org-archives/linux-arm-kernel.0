From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 17 Jun 2014 17:32:44 +0200
Subject: [PATCH RFC] mfd: syscon: Decouple syscon interface from syscon devices
In-Reply-To: <53A05E2D.6020702@samsung.com>
References: <53A05E2D.6020702@samsung.com>
Message-ID: <1403019164-12514-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently a syscon entity can be only registered directly through a
platform device that binds to a dedicated driver. However in certain use
cases it is desirable to make a device used with another driver a syscon
interface provider. For example, certain SoCs (e.g. Exynos) contain
system controller blocks which perform various functions such as power
domain control, CPU power management, low power mode control, but in
addition contain certain IP integration glue, such as various signal
masks, coprocessor power control, etc. In such case, there is a need to
have a dedicated driver for such system controller but also share
registers with other drivers. The latter is where the syscon interface
is helpful.

This patch decouples syscon object from syscon driver, so that it can be
registered from any driver in addition to the original "syscon" platform
driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/mfd/syscon.c       | 102 +++++++++++++++++++++++++++++----------------
 include/linux/mfd/syscon.h |   9 ++++
 2 files changed, 75 insertions(+), 36 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index ca15878..11baaae 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -14,6 +14,7 @@
 
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -23,30 +24,28 @@
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 
-static struct platform_driver syscon_driver;
+static DEFINE_SPINLOCK(syscon_list_slock);
+static LIST_HEAD(syscon_list);
 
 struct syscon {
 	struct regmap *regmap;
+	struct device *dev;
+	struct list_head list;
 };
 
-static int syscon_match_node(struct device *dev, void *data)
-{
-	struct device_node *dn = data;
-
-	return (dev->of_node == dn) ? 1 : 0;
-}
-
 struct regmap *syscon_node_to_regmap(struct device_node *np)
 {
-	struct syscon *syscon;
-	struct device *dev;
+	struct syscon *entry, *syscon = ERR_PTR(-EPROBE_DEFER);
+
+	spin_lock(&syscon_list_slock);
 
-	dev = driver_find_device(&syscon_driver.driver, NULL, np,
-				 syscon_match_node);
-	if (!dev)
-		return ERR_PTR(-EPROBE_DEFER);
+	list_for_each_entry(entry, &syscon_list, list)
+		if (entry->dev->of_node == np) {
+			syscon = entry;
+			break;
+		}
 
-	syscon = dev_get_drvdata(dev);
+	spin_unlock(&syscon_list_slock);
 
 	return syscon->regmap;
 }
@@ -68,22 +67,19 @@ struct regmap *syscon_regmap_lookup_by_compatible(const char *s)
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_compatible);
 
-static int syscon_match_pdevname(struct device *dev, void *data)
-{
-	return !strcmp(dev_name(dev), (const char *)data);
-}
-
 struct regmap *syscon_regmap_lookup_by_pdevname(const char *s)
 {
-	struct device *dev;
-	struct syscon *syscon;
+	struct syscon *entry, *syscon = ERR_PTR(-EPROBE_DEFER);
+
+	spin_lock(&syscon_list_slock);
 
-	dev = driver_find_device(&syscon_driver.driver, NULL, (void *)s,
-				 syscon_match_pdevname);
-	if (!dev)
-		return ERR_PTR(-EPROBE_DEFER);
+	list_for_each_entry(entry, &syscon_list, list)
+		if (!strcmp(dev_name(entry->dev), s)) {
+			syscon = entry;
+			break;
+		}
 
-	syscon = dev_get_drvdata(dev);
+	spin_unlock(&syscon_list_slock);
 
 	return syscon->regmap;
 }
@@ -121,17 +117,49 @@ static struct regmap_config syscon_regmap_config = {
 	.reg_stride = 4,
 };
 
+static void devm_syscon_unregister(struct device *dev, void *res)
+{
+	struct syscon *syscon = *(struct syscon **)res;
+
+	spin_lock(&syscon_list_slock);
+	list_del(&syscon->list);
+	spin_unlock(&syscon_list_slock);
+}
+
+int devm_syscon_register(struct device *dev, struct regmap *regmap)
+{
+	struct syscon **ptr, *syscon;
+
+	syscon = devm_kzalloc(dev, sizeof(*syscon), GFP_KERNEL);
+	if (!syscon)
+		return -ENOMEM;
+
+	syscon->regmap = regmap;
+	syscon->dev = dev;
+
+	ptr = devres_alloc(devm_syscon_unregister, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	spin_lock(&syscon_list_slock);
+	list_add_tail(&syscon->list, &syscon_list);
+	spin_unlock(&syscon_list_slock);
+
+	*ptr = syscon;
+	devres_add(dev, ptr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_syscon_register);
+
 static int syscon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct syscon_platform_data *pdata = dev_get_platdata(dev);
-	struct syscon *syscon;
+	struct regmap *regmap;
 	struct resource *res;
 	void __iomem *base;
-
-	syscon = devm_kzalloc(dev, sizeof(*syscon), GFP_KERNEL);
-	if (!syscon)
-		return -ENOMEM;
+	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
@@ -144,14 +172,16 @@ static int syscon_probe(struct platform_device *pdev)
 	syscon_regmap_config.max_register = res->end - res->start - 3;
 	if (pdata)
 		syscon_regmap_config.name = pdata->label;
-	syscon->regmap = devm_regmap_init_mmio(dev, base,
+	regmap = devm_regmap_init_mmio(dev, base,
 					&syscon_regmap_config);
-	if (IS_ERR(syscon->regmap)) {
+	if (IS_ERR(regmap)) {
 		dev_err(dev, "regmap init failed\n");
-		return PTR_ERR(syscon->regmap);
+		return PTR_ERR(regmap);
 	}
 
-	platform_set_drvdata(pdev, syscon);
+	ret = devm_syscon_register(dev, regmap);
+	if (ret)
+		return ret;
 
 	dev_dbg(dev, "regmap %pR registered\n", res);
 
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index 75e543b..6a1cadf 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -18,8 +18,11 @@
 #include <linux/err.h>
 
 struct device_node;
+struct regmap;
 
 #ifdef CONFIG_MFD_SYSCON
+extern int devm_syscon_register(struct device *dev, struct regmap *regmap);
+
 extern struct regmap *syscon_node_to_regmap(struct device_node *np);
 extern struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
 extern struct regmap *syscon_regmap_lookup_by_pdevname(const char *s);
@@ -27,6 +30,12 @@ extern struct regmap *syscon_regmap_lookup_by_phandle(
 					struct device_node *np,
 					const char *property);
 #else
+static inline int devm_syscon_register(struct device *dev,
+				       struct regmap *regmap)
+{
+	return -ENOSYS;
+}
+
 static inline struct regmap *syscon_node_to_regmap(struct device_node *np)
 {
 	return ERR_PTR(-ENOSYS);
-- 
1.9.3
