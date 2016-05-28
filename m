From: okaya@codeaurora.org (Sinan Kaya)
Date: Sat, 28 May 2016 18:01:15 -0400
Subject: [PATCH V6 5/8] vfio: platform: call _RST method when using ACPI
In-Reply-To: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
References: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1464472878-27176-6-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device tree code checks for the presence of a reset driver and calls
the of_reset function pointer by looking up the reset driver as a module.

ACPI defines _RST method to perform device level reset. After the _RST
method is executed, the OS can resume using the device. _RST method is
expected to stop DMA transfers and IRQs.

This patch checks the presence of _RST method and calls the _RST
method when reset is requested.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/vfio/platform/vfio_platform_common.c | 51 ++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index e7ce2c2..0ea8c26 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -73,21 +73,66 @@ static int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
 	}
 	return 0;
 }
+
+static int vfio_platform_acpi_call_reset(struct vfio_platform_device *vdev,
+					 const char **extra_dbg)
+{
+	struct device *dev = vdev->device;
+	acpi_handle handle = ACPI_HANDLE(dev);
+	acpi_status acpi_ret;
+	unsigned long long val;
+
+	acpi_ret = acpi_evaluate_integer(handle, "_RST", NULL, &val);
+	if (ACPI_FAILURE(acpi_ret)) {
+		if (extra_dbg)
+			*extra_dbg = acpi_format_exception(acpi_ret);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static bool vfio_platform_acpi_has_reset(struct vfio_platform_device *vdev)
+{
+	struct device *dev = vdev->device;
+	acpi_handle handle = ACPI_HANDLE(dev);
+
+	return acpi_has_method(handle, "_RST");
+}
 #else
 static inline int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
 					   struct device *dev)
 {
 	return -ENOENT;
 }
+
+static inline
+int vfio_platform_acpi_call_reset(struct vfio_platform_device *vdev,
+				  const char **extra_dbg)
+{
+	return -ENOENT;
+}
+
+static inline
+bool vfio_platform_acpi_has_reset(struct vfio_platform_device *vdev)
+{
+	return false;
+}
 #endif
 
 static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
 {
+	if (vdev->acpihid)
+		return vfio_platform_acpi_has_reset(vdev);
+
 	return vdev->of_reset ? true : false;
 }
 
 static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
 {
+	if (vdev->acpihid)
+		return;
+
 	vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
 						    &vdev->reset_module);
 	if (!vdev->of_reset) {
@@ -99,6 +144,9 @@ static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
 
 static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
 {
+	if (vdev->acpihid)
+		return;
+
 	if (vdev->of_reset)
 		module_put(vdev->reset_module);
 }
@@ -177,6 +225,9 @@ static int vfio_platform_call_reset(struct vfio_platform_device *vdev,
 	if (vdev->of_reset) {
 		dev_info(vdev->device, "reset\n");
 		return vdev->of_reset(vdev);
+	} else if (vdev->acpihid) {
+		dev_info(vdev->device, "reset\n");
+		return vfio_platform_acpi_call_reset(vdev, extra_dbg);
 	}
 
 	dev_warn(vdev->device, "no reset function found!\n");
-- 
1.8.2.1
