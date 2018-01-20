From: david@lechnology.com (David Lechner)
Date: Fri, 19 Jan 2018 21:20:19 -0600
Subject: [PATCH 1/6] mfd: syscon: Add syscon_register() function
In-Reply-To: <1516418424-28686-1-git-send-email-david@lechnology.com>
References: <1516418424-28686-1-git-send-email-david@lechnology.com>
Message-ID: <1516418424-28686-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a new syscon_register() function that creates a new syscon
regmap and adds it to the lookup list.

This function serves two purposes:

1. This is needed for platforms without device tree support where the
   syscon regmap is needed in early boot (e.g. clocks), because using a
   platform driver at this point in boot is not an option.

2. It allows other drivers to use syscon_regmap_lookup_by_compatible()
   for both device tree and non-DT platforms instead of having to have
   a separate case that calls syscon_regmap_lookup_by_pdevname().

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/mfd/syscon.c       | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/syscon.h |  9 ++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index b93fe4c..ab086b1 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -25,6 +25,8 @@
 #include <linux/mfd/syscon.h>
 #include <linux/slab.h>
 
+#define SYSCON_COMPATIBLE_SIZE 50
+
 static struct platform_driver syscon_driver;
 
 static DEFINE_SPINLOCK(syscon_list_slock);
@@ -34,6 +36,7 @@ struct syscon {
 	struct device_node *np;
 	struct regmap *regmap;
 	struct list_head list;
+	char compatible[SYSCON_COMPATIBLE_SIZE];
 };
 
 static const struct regmap_config syscon_regmap_config = {
@@ -140,9 +143,27 @@ EXPORT_SYMBOL_GPL(syscon_node_to_regmap);
 
 struct regmap *syscon_regmap_lookup_by_compatible(const char *s)
 {
+	struct syscon *entry, *syscon = NULL;
 	struct device_node *syscon_np;
 	struct regmap *regmap;
 
+	spin_lock(&syscon_list_slock);
+
+	/* Check for entries registered with syscon_register() */
+	list_for_each_entry(entry, &syscon_list, list) {
+		if (!entry->compatible)
+			continue;
+		if (!strncmp(entry->compatible, s, SYSCON_COMPATIBLE_SIZE)) {
+			syscon = entry;
+			break;
+		}
+	}
+
+	spin_unlock(&syscon_list_slock);
+
+	if (syscon)
+		return syscon->regmap;
+
 	syscon_np = of_find_compatible_node(NULL, NULL, s);
 	if (!syscon_np)
 		return ERR_PTR(-ENODEV);
@@ -196,6 +217,56 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle);
 
+/**
+ * syscon_register - Register a new syscon regmap
+ * @start: The starting memory address of the regmap
+ * @size: The size of the regmap in bytes
+ * @compatible: Compatible string used for lookup
+ *
+ * Returns: Pointer to a regmap or a negative error code.
+ */
+struct regmap *syscon_register(resource_size_t start, size_t size,
+			       const char *compatible)
+{
+	struct regmap_config syscon_config = syscon_regmap_config;
+	struct syscon *syscon;
+	void __iomem *base;
+	int err;
+
+	syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
+	if (!syscon)
+		return ERR_PTR(-ENOMEM);
+
+	base = ioremap(start, size);
+	if (!base) {
+		err = -ENOMEM;
+		goto err_free_syscon;
+	}
+
+	strncpy(syscon->compatible, compatible, SYSCON_COMPATIBLE_SIZE);
+
+	syscon_config.max_register = size - 1;
+	syscon->regmap = regmap_init_mmio(NULL, base, &syscon_config);
+	if (IS_ERR(syscon->regmap)) {
+		err = PTR_ERR(syscon->regmap);
+		goto err_iounmap;
+	}
+
+	spin_lock(&syscon_list_slock);
+	list_add_tail(&syscon->list, &syscon_list);
+	spin_unlock(&syscon_list_slock);
+
+	return syscon->regmap;
+
+err_iounmap:
+	iounmap(base);
+err_free_syscon:
+	kfree(syscon);
+
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(syscon_register);
+
 static int syscon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index 40a76b9..ce531b4 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -27,6 +27,8 @@ extern struct regmap *syscon_regmap_lookup_by_pdevname(const char *s);
 extern struct regmap *syscon_regmap_lookup_by_phandle(
 					struct device_node *np,
 					const char *property);
+extern struct regmap *syscon_register(resource_size_t start, size_t size,
+				      const char *compatible);
 #else
 static inline struct regmap *syscon_node_to_regmap(struct device_node *np)
 {
@@ -49,6 +51,13 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle(
 {
 	return ERR_PTR(-ENOTSUPP);
 }
+
+static inline struct regmap *syscon_register(resource_size_t start,
+					     size_t size,
+					     const char *id)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
 #endif
 
 #endif /* __LINUX_MFD_SYSCON_H__ */
-- 
2.7.4
