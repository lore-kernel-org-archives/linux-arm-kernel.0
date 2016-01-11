From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Mon, 11 Jan 2016 19:26:26 +0600
Subject: [PATCH v5 1/2] ACPI: introduce a function to find the first physical
 device
In-Reply-To: <1452518790-27053-1-git-send-email-aleksey.makarov@linaro.org>
References: <1452518790-27053-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1452518790-27053-2-git-send-email-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Factor out the code that finds the first physical device
of a given ACPI device.  It is used in several places.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/acpi/acpi_platform.c | 18 ++----------------
 drivers/acpi/bus.c           | 36 ++++++++++++++++++++++++------------
 drivers/acpi/internal.h      |  1 +
 3 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 296b7a1..c99aed0 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -43,7 +43,6 @@ static const struct acpi_device_id forbidden_id_list[] = {
 struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
 {
 	struct platform_device *pdev = NULL;
-	struct acpi_device *acpi_parent;
 	struct platform_device_info pdevinfo;
 	struct resource_entry *rentry;
 	struct list_head resource_list;
@@ -83,21 +82,8 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
 	 * platform device we are about to create.
 	 */
 	pdevinfo.parent = NULL;
-	acpi_parent = adev->parent;
-	if (acpi_parent) {
-		struct acpi_device_physical_node *entry;
-		struct list_head *list;
-
-		mutex_lock(&acpi_parent->physical_node_lock);
-		list = &acpi_parent->physical_node_list;
-		if (!list_empty(list)) {
-			entry = list_first_entry(list,
-					struct acpi_device_physical_node,
-					node);
-			pdevinfo.parent = entry->dev;
-		}
-		mutex_unlock(&acpi_parent->physical_node_lock);
-	}
+	if (adev->parent)
+		pdevinfo.parent = acpi_get_first_physical_node(adev->parent);
 	pdevinfo.name = dev_name(&adev->dev);
 	pdevinfo.id = -1;
 	pdevinfo.res = resources;
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a212cef..2048c69 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -478,24 +478,36 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device)
                              Device Matching
    -------------------------------------------------------------------------- */
 
-static struct acpi_device *acpi_primary_dev_companion(struct acpi_device *adev,
-						      const struct device *dev)
+/**
+ * acpi_device_fix_parent - Get first physical node of an ACPI device
+ * @adev: ACPI device in question
+ */
+struct device *acpi_get_first_physical_node(
+	struct acpi_device *adev)
 {
 	struct mutex *physical_node_lock = &adev->physical_node_lock;
+	struct device *ret = NULL;
 
 	mutex_lock(physical_node_lock);
-	if (list_empty(&adev->physical_node_list)) {
-		adev = NULL;
-	} else {
-		const struct acpi_device_physical_node *node;
 
-		node = list_first_entry(&adev->physical_node_list,
-					struct acpi_device_physical_node, node);
-		if (node->dev != dev)
-			adev = NULL;
-	}
+	if (!list_empty(&adev->physical_node_list))
+		ret = list_first_entry(&adev->physical_node_list,
+				struct acpi_device_physical_node, node)->dev;
+
 	mutex_unlock(physical_node_lock);
-	return adev;
+
+	return ret;
+}
+
+static struct acpi_device *acpi_primary_dev_companion(struct acpi_device *adev,
+						      const struct device *dev)
+{
+	const struct device *pdev = acpi_get_first_physical_node(adev);
+
+	if (pdev && pdev == dev)
+		return adev;
+
+	return NULL;
 }
 
 /**
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 11d87bf..ee9312ba 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -98,6 +98,7 @@ bool acpi_device_is_present(struct acpi_device *adev);
 bool acpi_device_is_battery(struct acpi_device *adev);
 bool acpi_device_is_first_physical_node(struct acpi_device *adev,
 					const struct device *dev);
+struct device *acpi_get_first_physical_node(struct acpi_device *adev);
 
 /* --------------------------------------------------------------------------
                      Device Matching and Notification
-- 
2.7.0
