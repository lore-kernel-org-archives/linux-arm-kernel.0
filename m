From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 28 Mar 2016 09:35:22 -0400
Subject: [PATCH V3 1/3] vfio,
 platform: add support for ACPI while detecting the reset driver
In-Reply-To: <1459172124-6730-1-git-send-email-okaya@codeaurora.org>
References: <1459172124-6730-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1459172124-6730-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code is using the compatible DT string to associate a reset driver with
the actual device itself. The compatible string does not exist on ACPI
based systems. HID is the unique identifier for a device driver instead.
The change allows a driver to register with DT compatible string or ACPI
HID and then match the object with one of these conditions.

Rules for loading the reset driver are as follow:
- ACPI HID needs match for ACPI systems
- DT compat needs to match for OF systems

Tested-by: Eric Auger <eric.auger@linaro.org> (device tree only)
Tested-by: Shanker Donthineni <shankerd@codeaurora.org> (ACPI only)
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 .../vfio/platform/reset/vfio_platform_amdxgbe.c    |   4 +-
 .../platform/reset/vfio_platform_calxedaxgmac.c    |   4 +-
 drivers/vfio/platform/vfio_platform_common.c       | 107 +++++++++++++++++----
 drivers/vfio/platform/vfio_platform_private.h      |  43 +++++----
 4 files changed, 120 insertions(+), 38 deletions(-)

diff --git a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
index d4030d0..6d87442 100644
--- a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
+++ b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
@@ -119,7 +119,9 @@ int vfio_platform_amdxgbe_reset(struct vfio_platform_device *vdev)
 	return 0;
 }
 
-module_vfio_reset_handler("amd,xgbe-seattle-v1a", vfio_platform_amdxgbe_reset);
+module_vfio_reset_handler("amd,xgbe-seattle-v1a", NULL,
+			  vfio_platform_amdxgbe_reset);
+MODULE_ALIAS_VFIO_PLATFORM_RESET("amd,xgbe-seattle-v1a");
 
 MODULE_VERSION("0.1");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
index e3d3d94..952dd55 100644
--- a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
+++ b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
@@ -77,7 +77,9 @@ int vfio_platform_calxedaxgmac_reset(struct vfio_platform_device *vdev)
 	return 0;
 }
 
-module_vfio_reset_handler("calxeda,hb-xgmac", vfio_platform_calxedaxgmac_reset);
+module_vfio_reset_handler("calxeda,hb-xgmac", NULL,
+			  vfio_platform_calxedaxgmac_reset);
+MODULE_ALIAS_VFIO_PLATFORM_RESET("calxeda,hb-xgmac");
 
 MODULE_VERSION(DRIVER_VERSION);
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index e65b142..c28883a 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/acpi.h>
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -31,14 +32,22 @@ static LIST_HEAD(reset_list);
 static DEFINE_MUTEX(driver_lock);
 
 static vfio_platform_reset_fn_t vfio_platform_lookup_reset(const char *compat,
-					struct module **module)
+				  const char *acpihid, struct module **module)
 {
 	struct vfio_platform_reset_node *iter;
 	vfio_platform_reset_fn_t reset_fn = NULL;
 
 	mutex_lock(&driver_lock);
 	list_for_each_entry(iter, &reset_list, link) {
-		if (!strcmp(iter->compat, compat) &&
+		if (acpihid && iter->acpihid &&
+		    !strcmp(iter->acpihid, acpihid) &&
+			try_module_get(iter->owner)) {
+			*module = iter->owner;
+			reset_fn = iter->reset;
+			break;
+		}
+		if (compat && iter->compat &&
+		    !strcmp(iter->compat, compat) &&
 			try_module_get(iter->owner)) {
 			*module = iter->owner;
 			reset_fn = iter->reset;
@@ -49,15 +58,30 @@ static vfio_platform_reset_fn_t vfio_platform_lookup_reset(const char *compat,
 	return reset_fn;
 }
 
-static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
+static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
 {
-	vdev->reset = vfio_platform_lookup_reset(vdev->compat,
-						&vdev->reset_module);
-	if (!vdev->reset) {
-		request_module("vfio-reset:%s", vdev->compat);
-		vdev->reset = vfio_platform_lookup_reset(vdev->compat,
-							 &vdev->reset_module);
-	}
+	int rc = -ENODEV;
+
+	vdev->reset = vfio_platform_lookup_reset(vdev->compat, vdev->acpihid,
+						 &vdev->reset_module);
+	if (vdev->reset)
+		return 0;
+
+	if (vdev->acpihid)
+		rc = request_module("vfio-reset:%s", vdev->acpihid);
+
+	if (rc && vdev->compat)
+		rc = request_module("vfio-reset:%s", vdev->compat);
+
+	if (rc)
+		return rc;
+
+	vdev->reset = vfio_platform_lookup_reset(vdev->compat, vdev->acpihid,
+						 &vdev->reset_module);
+	if (vdev->reset)
+		return 0;
+
+	return -ENODEV;
 }
 
 static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
@@ -544,6 +568,46 @@ static const struct vfio_device_ops vfio_platform_ops = {
 	.mmap		= vfio_platform_mmap,
 };
 
+#ifdef CONFIG_ACPI
+int vfio_platform_probe_acpi(struct vfio_platform_device *vdev,
+			     struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (!adev)
+		return -ENODEV;
+
+	vdev->acpihid = acpi_device_hid(adev);
+	if (!vdev->acpihid) {
+		pr_err("VFIO: cannot find ACPI HID for %s\n",
+		       vdev->name);
+		return -ENODEV;
+	}
+	return 0;
+}
+#else
+int vfio_platform_probe_acpi(struct vfio_platform_device *vdev,
+			     struct device *dev)
+{
+	return -EINVAL;
+}
+#endif
+
+int vfio_platform_probe_of(struct vfio_platform_device *vdev,
+			   struct device *dev)
+{
+	int ret;
+
+	ret = device_property_read_string(dev, "compatible",
+					  &vdev->compat);
+	if (ret) {
+		pr_err("VFIO: cannot retrieve compat for %s\n",
+			vdev->name);
+		return ret;
+	}
+	return 0;
+}
+
 int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 			       struct device *dev)
 {
@@ -553,14 +617,14 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 	if (!vdev)
 		return -EINVAL;
 
-	ret = device_property_read_string(dev, "compatible", &vdev->compat);
-	if (ret) {
-		pr_err("VFIO: cannot retrieve compat for %s\n", vdev->name);
-		return -EINVAL;
-	}
+	ret = vfio_platform_probe_acpi(vdev, dev);
+	if (ret)
+		ret = vfio_platform_probe_of(vdev, dev);
 
-	vdev->device = dev;
+	if (ret)
+		return ret;
 
+	vdev->device = dev;
 	group = iommu_group_get(dev);
 	if (!group) {
 		pr_err("VFIO: No IOMMU group for device %s\n", vdev->name);
@@ -574,7 +638,6 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 	}
 
 	vfio_platform_get_reset(vdev);
-
 	mutex_init(&vdev->igate);
 
 	return 0;
@@ -605,13 +668,21 @@ void __vfio_platform_register_reset(struct vfio_platform_reset_node *node)
 EXPORT_SYMBOL_GPL(__vfio_platform_register_reset);
 
 void vfio_platform_unregister_reset(const char *compat,
+				    const char *acpihid,
 				    vfio_platform_reset_fn_t fn)
 {
 	struct vfio_platform_reset_node *iter, *temp;
 
 	mutex_lock(&driver_lock);
 	list_for_each_entry_safe(iter, temp, &reset_list, link) {
-		if (!strcmp(iter->compat, compat) && (iter->reset == fn)) {
+		if (acpihid && iter->acpihid &&
+		    !strcmp(iter->acpihid, acpihid) && (iter->reset == fn)) {
+			list_del(&iter->link);
+			break;
+		}
+
+		if (compat && iter->compat &&
+		    !strcmp(iter->compat, compat) && (iter->reset == fn)) {
 			list_del(&iter->link);
 			break;
 		}
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 42816dd..1b95adf 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -58,6 +58,7 @@ struct vfio_platform_device {
 	struct mutex			igate;
 	struct module			*parent_module;
 	const char			*compat;
+	const char			*acpihid;
 	struct module			*reset_module;
 	struct device			*device;
 
@@ -79,6 +80,7 @@ typedef int (*vfio_platform_reset_fn_t)(struct vfio_platform_device *vdev);
 struct vfio_platform_reset_node {
 	struct list_head link;
 	char *compat;
+	char *acpihid;
 	struct module *owner;
 	vfio_platform_reset_fn_t reset;
 };
@@ -98,27 +100,32 @@ extern int vfio_platform_set_irqs_ioctl(struct vfio_platform_device *vdev,
 
 extern void __vfio_platform_register_reset(struct vfio_platform_reset_node *n);
 extern void vfio_platform_unregister_reset(const char *compat,
+					   const char *acpihid,
 					   vfio_platform_reset_fn_t fn);
-#define vfio_platform_register_reset(__compat, __reset)		\
-static struct vfio_platform_reset_node __reset ## _node = {	\
-	.owner = THIS_MODULE,					\
-	.compat = __compat,					\
-	.reset = __reset,					\
-};								\
+
+#define vfio_platform_register_reset(__compat, __acpihid, __reset)	\
+static struct vfio_platform_reset_node __reset ## _node = {		\
+	.owner = THIS_MODULE,						\
+	.compat = __compat,						\
+	.acpihid = __acpihid,						\
+	.reset = __reset,						\
+};									\
 __vfio_platform_register_reset(&__reset ## _node)
 
-#define module_vfio_reset_handler(compat, reset)		\
-MODULE_ALIAS("vfio-reset:" compat);				\
-static int __init reset ## _module_init(void)			\
-{								\
-	vfio_platform_register_reset(compat, reset);		\
-	return 0;						\
-};								\
-static void __exit reset ## _module_exit(void)			\
-{								\
-	vfio_platform_unregister_reset(compat, reset);		\
-};								\
-module_init(reset ## _module_init);				\
+#define MODULE_ALIAS_VFIO_PLATFORM_RESET(name)				\
+	MODULE_ALIAS("vfio-reset:" name)
+
+#define module_vfio_reset_handler(compat, acpihid, reset)		\
+static int __init reset ## _module_init(void)				\
+{									\
+	vfio_platform_register_reset(compat, acpihid, reset);		\
+	return 0;							\
+};									\
+static void __exit reset ## _module_exit(void)				\
+{									\
+	vfio_platform_unregister_reset(compat, acpihid, reset);		\
+};									\
+module_init(reset ## _module_init);					\
 module_exit(reset ## _module_exit)
 
 #endif /* VFIO_PLATFORM_PRIVATE_H */
-- 
1.8.2.1
