From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu,  9 Nov 2017 21:32:53 -0500
Subject: [PATCH V3 2/4] ACPI / bus: introduce acpi_device_get_match_data()
 function
In-Reply-To: <1510281175-27173-1-git-send-email-okaya@codeaurora.org>
References: <1510281175-27173-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1510281175-27173-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OF has of_device_get_match_data() function to extract driver specific data
structure. Add a similar function for ACPI.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/bus.c   | 12 ++++++++++++
 include/linux/acpi.h |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 4d0979e..da29c10 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -785,6 +785,18 @@ const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 }
 EXPORT_SYMBOL_GPL(acpi_match_device);
 
+void *acpi_device_get_match_data(const struct device *dev)
+{
+	const struct acpi_device_id *match;
+
+	match = acpi_match_device(dev->driver->acpi_match_table, dev);
+	if (!match)
+		return NULL;
+
+	return (void *)match->driver_data;
+}
+EXPORT_SYMBOL_GPL(acpi_device_get_match_data);
+
 int acpi_match_device_ids(struct acpi_device *device,
 			  const struct acpi_device_id *ids)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 502af53..62c85a5 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -584,6 +584,7 @@ extern int acpi_nvs_for_each_region(int (*func)(__u64, __u64, void *),
 const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 					       const struct device *dev);
 
+void *acpi_device_get_match_data(const struct device *dev);
 extern bool acpi_driver_match_device(struct device *dev,
 				     const struct device_driver *drv);
 int acpi_device_uevent_modalias(struct device *, struct kobj_uevent_env *);
@@ -755,6 +756,11 @@ static inline const struct acpi_device_id *acpi_match_device(
 	return NULL;
 }
 
+static inline void *acpi_device_get_match_data(const struct device *dev)
+{
+	return NULL;
+}
+
 static inline bool acpi_driver_match_device(struct device *dev,
 					    const struct device_driver *drv)
 {
-- 
1.9.1
