From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 2 Dec 2015 17:09:27 +0800
Subject: [RFC PATCH 3/4] ACPI/platform: Introduce helper
 acpi_dev_find_plat_dev()
In-Reply-To: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1449047368-5768-4-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes in a device object, we refer to another device object,
mostly in _DSD method, and we need to get platform device with
the ACPI device node from the referenced device object. So introduce
the helper acpi_dev_find_plat_dev() to do this.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/acpi/acpi_platform.c | 25 +++++++++++++++++++++++++
 include/linux/acpi.h         |  6 ++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 296b7a1..2603f9b 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -121,3 +121,28 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
 	return pdev;
 }
 EXPORT_SYMBOL_GPL(acpi_create_platform_device);
+
+static int acpi_dev_object_match(struct device *dev, void *data)
+{
+	return ACPI_COMPANION(dev) == data;
+}
+
+/*
+ * acpi_find_plat_device - Find the platform_device associated
+ * with an acpi device
+ * @adev: Pointer to the acpi device
+ *
+ * Returns platform_device pointer, or NULL if not found
+ */
+struct platform_device *acpi_dev_find_plat_dev(struct acpi_device *adev)
+{
+	struct device *dev;
+
+	if (!adev)
+		return NULL;
+
+	dev = bus_find_device(&platform_bus_type, NULL, adev,
+				acpi_dev_object_match);
+	return dev ? to_platform_device(dev) : NULL;
+}
+EXPORT_SYMBOL(acpi_dev_find_plat_dev);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d76a688..16af22f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -468,6 +468,7 @@ int acpi_device_modalias(struct device *, char *, int);
 void acpi_walk_dep_device_list(acpi_handle handle);
 
 struct platform_device *acpi_create_platform_device(struct acpi_device *);
+struct platform_device *acpi_dev_find_plat_dev(struct acpi_device *adev);
 #define ACPI_PTR(_ptr)	(_ptr)
 
 #else	/* !CONFIG_ACPI */
@@ -929,6 +930,11 @@ static inline struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
 	return NULL;
 }
 
+static inline struct platform_device *acpi_dev_find_plat_dev(struct acpi_device *adev)
+{
+	return NULL;
+}
+
 #define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable, validate, data, fn) \
 	static const void * __acpi_table_##name[]			\
 		__attribute__((unused))					\
-- 
1.7.12.4
