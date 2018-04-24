From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 24 Apr 2018 19:30:50 +0200
Subject: [PATCH 10/11] of: platform: provide of_early_platform_probe()
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
Message-ID: <20180424173051.15099-11-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Implement a function that must be called from machine code early in
the bo process in order to probe all registered early devices.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/of/platform.c       | 12 ++++++++++++
 include/linux/of_platform.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 4b55e568fe77..525a466b03d1 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -541,6 +541,18 @@ int of_early_platform_populate(struct device_node *root,
 	return rc;
 }
 EXPORT_SYMBOL_GPL(of_early_platform_populate);
+
+/**
+ * of_early_platform_probe() - Probe all registered early platform devices.
+ *
+ * Returns 0 on success, a negative error code on failure.
+ */
+int of_early_platform_probe(void)
+{
+	return early_platform_driver_register_probe_all(
+				EARLY_PLATFORM_DEFAULT_CLASS, INT_MAX, 0);
+}
+EXPORT_SYMBOL_GPL(of_early_platform_probe);
 #endif /* CONFIG_EARLY_PLATFORM_DEVICES */
 
 int of_platform_default_populate(struct device_node *root,
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 2bf1013a3e89..caa08e3bf3b7 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -81,6 +81,7 @@ extern int of_early_platform_populate(struct device_node *root,
 				      const struct of_device_id *matches,
 				      const struct of_dev_auxdata *lookup,
 				      struct device *parent);
+extern int of_early_platform_probe(void);
 #else /* CONFIG_EARLY_PLATFORM_DEVICES */
 static inline int
 of_early_platform_populate(struct device_node *root,
@@ -90,6 +91,7 @@ of_early_platform_populate(struct device_node *root,
 {
 	return -ENOSYS;
 }
+static inline void int of_early_platform_probe(void) {}
 #endif /* CONFIG_EARLY_PLATFORM_DEVICES */
 
 extern int of_platform_default_populate(struct device_node *root,
-- 
2.17.0
