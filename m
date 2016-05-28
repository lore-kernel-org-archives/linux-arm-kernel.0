From: okaya@codeaurora.org (Sinan Kaya)
Date: Sat, 28 May 2016 18:01:13 -0400
Subject: [PATCH V6 3/8] vfio: platform: add support for ACPI probe
In-Reply-To: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
References: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1464472878-27176-4-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code is using the compatible DT string to associate a reset driver
with the actual device itself. The compatible string does not exist on
ACPI based systems. HID is the unique identifier for a device driver
instead.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/vfio/platform/vfio_platform_common.c  | 57 ++++++++++++++++++++++++---
 drivers/vfio/platform/vfio_platform_private.h |  1 +
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 6be92c3..fbf4565 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/acpi.h>
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -49,6 +50,37 @@ static vfio_platform_reset_fn_t vfio_platform_lookup_reset(const char *compat,
 	return reset_fn;
 }
 
+#ifdef CONFIG_ACPI
+static int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
+				    struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	if (!adev) {
+		pr_err("VFIO: ACPI companion device not found for %s\n",
+			vdev->name);
+		return -ENODEV;
+	}
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
+static inline int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
+					   struct device *dev)
+{
+	return -ENOENT;
+}
+#endif
+
 static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
 {
 	return vdev->of_reset ? true : false;
@@ -547,6 +579,20 @@ static const struct vfio_device_ops vfio_platform_ops = {
 	.mmap		= vfio_platform_mmap,
 };
 
+int vfio_platform_of_probe(struct vfio_platform_device *vdev,
+			   struct device *dev)
+{
+	int ret;
+
+	ret = device_property_read_string(dev, "compatible",
+					  &vdev->compat);
+	if (ret)
+		pr_err("VFIO: cannot retrieve compat for %s\n",
+			vdev->name);
+
+	return ret;
+}
+
 int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 			       struct device *dev)
 {
@@ -556,11 +602,12 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 	if (!vdev)
 		return -EINVAL;
 
-	ret = device_property_read_string(dev, "compatible", &vdev->compat);
-	if (ret) {
-		pr_err("VFIO: cannot retrieve compat for %s\n", vdev->name);
-		return -EINVAL;
-	}
+	ret = vfio_platform_acpi_probe(vdev, dev);
+	if (ret)
+		ret = vfio_platform_of_probe(vdev, dev);
+
+	if (ret)
+		return ret;
 
 	vdev->device = dev;
 
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 71ed7d1..ba9e4f8 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -58,6 +58,7 @@ struct vfio_platform_device {
 	struct mutex			igate;
 	struct module			*parent_module;
 	const char			*compat;
+	const char			*acpihid;
 	struct module			*reset_module;
 	struct device			*device;
 
-- 
1.8.2.1
