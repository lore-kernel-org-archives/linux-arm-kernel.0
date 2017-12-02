From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri,  1 Dec 2017 23:27:39 -0500
Subject: [PATCH V5 2/7] ACPI / bus: Introduce acpi_get_match_data() function
In-Reply-To: <1512188864-773-1-git-send-email-okaya@codeaurora.org>
References: <1512188864-773-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1512188864-773-3-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OF has of_device_get_match_data() function to extract driver specific data
structure. Add a similar function for ACPI.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/bus.c   | 13 +++++++++++++
 include/linux/acpi.h |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 4d0979e..05d8d9a 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -785,6 +785,19 @@ const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 }
 EXPORT_SYMBOL_GPL(acpi_match_device);
 
+void *acpi_get_match_data(struct acpi_device *device,
+			  const struct acpi_device_id *ids)
+{
+	const struct acpi_device_id *match;
+
+	match =  __acpi_match_device(device, ids, NULL);
+	if (!match)
+		return NULL;
+
+	return (void *)match->driver_data;
+}
+EXPORT_SYMBOL_GPL(acpi_get_match_data);
+
 int acpi_match_device_ids(struct acpi_device *device,
 			  const struct acpi_device_id *ids)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 502af53..196bc7a 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -584,6 +584,8 @@ extern int acpi_nvs_for_each_region(int (*func)(__u64, __u64, void *),
 const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 					       const struct device *dev);
 
+void *acpi_get_match_data(struct acpi_device *device,
+			  const struct acpi_device_id *ids);
 extern bool acpi_driver_match_device(struct device *dev,
 				     const struct device_driver *drv);
 int acpi_device_uevent_modalias(struct device *, struct kobj_uevent_env *);
@@ -755,6 +757,12 @@ static inline const struct acpi_device_id *acpi_match_device(
 	return NULL;
 }
 
+static inline void *acpi_get_match_data(struct acpi_device *device,
+					const struct acpi_device_id *ids)
+{
+	return NULL;
+}
+
 static inline bool acpi_driver_match_device(struct device *dev,
 					    const struct device_driver *drv)
 {
-- 
1.9.1
