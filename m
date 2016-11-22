From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 22 Nov 2016 11:41:49 +0100
Subject: [PATCH 1/3] of: base: add support to get machine compatible string
In-Reply-To: <1479811311-3080-1-git-send-email-bgolaszewski@baylibre.com>
References: <1479811311-3080-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1479811311-3080-2-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a function allowing to retrieve the compatible string of the root
node of the device tree.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/of/base.c  | 22 ++++++++++++++++++++++
 include/linux/of.h |  6 ++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index a0bccb5..bbfe5e9 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -546,6 +546,28 @@ int of_machine_is_compatible(const char *compat)
 EXPORT_SYMBOL(of_machine_is_compatible);
 
 /**
+ * of_machine_get_compatible - Get the compatible property of the root node
+ *
+ * Returns a NULL-terminated string containing the compatible if it could
+ * be found, NULL otherwise.
+ */
+const char *of_machine_get_compatible(void)
+{
+	struct device_node *root;
+	const char *compatible;
+	int ret = -1;
+
+	root = of_find_node_by_path("/");
+	if (root) {
+		ret = of_property_read_string(root, "compatible", &compatible);
+		of_node_put(root);
+	}
+
+	return ret ? NULL : compatible;
+}
+EXPORT_SYMBOL(of_machine_get_compatible);
+
+/**
  *  __of_device_is_available - check if a device is available for use
  *
  *  @device: Node to check for availability, with locks already held
diff --git a/include/linux/of.h b/include/linux/of.h
index 299aeb1..664b734 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -367,6 +367,7 @@ extern int of_alias_get_id(struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
 
 extern int of_machine_is_compatible(const char *compat);
+extern const char *of_machine_get_compatible(void);
 
 extern int of_add_property(struct device_node *np, struct property *prop);
 extern int of_remove_property(struct device_node *np, struct property *prop);
@@ -788,6 +789,11 @@ static inline int of_machine_is_compatible(const char *compat)
 	return 0;
 }
 
+static inline const char *of_machine_get_compatible(void)
+{
+	return NULL;
+}
+
 static inline bool of_console_check(const struct device_node *dn, const char *name, int index)
 {
 	return false;
-- 
2.9.3
