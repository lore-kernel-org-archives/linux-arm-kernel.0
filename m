From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Tue, 16 Feb 2016 15:52:38 +0300
Subject: [PATCH v6 1/2] ACPI: introduce a function to find the first physical
 device
In-Reply-To: <2019009.4Y5n3ZF6bK@vostro.rjw.lan>
References: <2019009.4Y5n3ZF6bK@vostro.rjw.lan>
Message-ID: <1455627160-10299-1-git-send-email-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Factor out the code that finds the first physical device
of a given ACPI device.  It is used in several places.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/acpi/acpi_platform.c | 19 ++-----------------
 drivers/acpi/bus.c           | 26 ++++++++++++++++++++------
 drivers/acpi/internal.h      |  1 +
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 296b7a1..c3af108 100644
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
@@ -82,22 +81,8 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
 	 * attached to it, that physical device should be the parent of the
 	 * platform device we are about to create.
 	 */
-	pdevinfo.parent = NULL;
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
+	pdevinfo.parent = adev->parent ?
+		acpi_get_first_physical_node(adev->parent) : NULL;
 	pdevinfo.name = dev_name(&adev->dev);
 	pdevinfo.id = -1;
 	pdevinfo.res = resources;
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a212cef..d27e0f4 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -478,24 +478,38 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device)
                              Device Matching
    -------------------------------------------------------------------------- */
 
-static struct acpi_device *acpi_primary_dev_companion(struct acpi_device *adev,
-						      const struct device *dev)
+/**
+ * acpi_get_first_physical_node - Get first physical node of an ACPI device
+ * @adev:	ACPI device in question
+ *
+ * Return: First physical node of ACPI device @adev
+ */
+struct device *acpi_get_first_physical_node(struct acpi_device *adev)
 {
 	struct mutex *physical_node_lock = &adev->physical_node_lock;
+	struct device *phys_dev;
 
 	mutex_lock(physical_node_lock);
 	if (list_empty(&adev->physical_node_list)) {
-		adev = NULL;
+		phys_dev = NULL;
 	} else {
 		const struct acpi_device_physical_node *node;
 
 		node = list_first_entry(&adev->physical_node_list,
 					struct acpi_device_physical_node, node);
-		if (node->dev != dev)
-			adev = NULL;
+
+		phys_dev = node->dev;
 	}
 	mutex_unlock(physical_node_lock);
-	return adev;
+	return phys_dev;
+}
+
+static struct acpi_device *acpi_primary_dev_companion(struct acpi_device *adev,
+						      const struct device *dev)
+{
+	const struct device *phys_dev = acpi_get_first_physical_node(adev);
+
+	return phys_dev && phys_dev == dev ? adev : NULL;
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
2.7.1
