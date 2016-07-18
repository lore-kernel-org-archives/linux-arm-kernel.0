From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 18 Jul 2016 19:09:24 -0400
Subject: [PATCH V10 6/9] vfio: platform: call _RST method when using ACPI
In-Reply-To: <1468883367-2854-1-git-send-email-okaya@codeaurora.org>
References: <1468883367-2854-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1468883367-2854-7-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device tree code checks for the presence of a reset driver and calls
the of_reset function pointer by looking up the reset driver as a module.

ACPI defines _RST method to perform device level reset. After the _RST
method is executed, the OS can resume using the device. _RST method is
expected to stop DMA transfers and IRQs.

This patch introduces two functions as vfio_platform_acpi_has_reset and
vfio_platform_acpi_call_reset. The has reset method is used to declare
reset capability via the ioctl flag VFIO_DEVICE_FLAGS_RESET. The call
reset function is used to execute the _RST ACPI method.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/vfio/platform/vfio_platform_common.c | 50 +++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index f6025c9..b1e5801 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -28,6 +28,8 @@
 #define DRIVER_AUTHOR   "Antonios Motakis <a.motakis@virtualopensystems.com>"
 #define DRIVER_DESC     "VFIO platform base module"
 
+#define VFIO_PLATFORM_IS_ACPI(vdev) ((vdev)->acpihid != NULL)
+
 static LIST_HEAD(reset_list);
 static DEFINE_MUTEX(driver_lock);
 
@@ -76,13 +78,53 @@ static int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
 	return WARN_ON(!vdev->acpihid) ? -ENOENT : 0;
 }
 
+int vfio_platform_acpi_call_reset(struct vfio_platform_device *vdev,
+				  const char **extra_dbg)
+{
+#ifdef CONFIG_ACPI
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct device *dev = vdev->device;
+	acpi_handle handle = ACPI_HANDLE(dev);
+	acpi_status acpi_ret;
+
+	acpi_ret = acpi_evaluate_object(handle, "_RST", NULL, &buffer);
+	if (ACPI_FAILURE(acpi_ret)) {
+		if (extra_dbg)
+			*extra_dbg = acpi_format_exception(acpi_ret);
+		return -EINVAL;
+	}
+
+	return 0;
+#else
+	return -ENOENT;
+#endif
+}
+
+bool vfio_platform_acpi_has_reset(struct vfio_platform_device *vdev)
+{
+#ifdef CONFIG_ACPI
+	struct device *dev = vdev->device;
+	acpi_handle handle = ACPI_HANDLE(dev);
+
+	return acpi_has_method(handle, "_RST");
+#else
+	return false;
+#endif
+}
+
 static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
 {
+	if (VFIO_PLATFORM_IS_ACPI(vdev))
+		return vfio_platform_acpi_has_reset(vdev);
+
 	return vdev->of_reset ? true : false;
 }
 
 static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
 {
+	if (VFIO_PLATFORM_IS_ACPI(vdev))
+		return;
+
 	vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
 						    &vdev->reset_module);
 	if (!vdev->of_reset) {
@@ -94,6 +136,9 @@ static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
 
 static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
 {
+	if (VFIO_PLATFORM_IS_ACPI(vdev))
+		return;
+
 	if (vdev->of_reset)
 		module_put(vdev->reset_module);
 }
@@ -169,7 +214,10 @@ static void vfio_platform_regions_cleanup(struct vfio_platform_device *vdev)
 static int vfio_platform_call_reset(struct vfio_platform_device *vdev,
 				    const char **extra_dbg)
 {
-	if (vdev->of_reset) {
+	if (VFIO_PLATFORM_IS_ACPI(vdev)) {
+		dev_info(vdev->device, "reset\n");
+		return vfio_platform_acpi_call_reset(vdev, extra_dbg);
+	} else if (vdev->of_reset) {
 		dev_info(vdev->device, "reset\n");
 		return vdev->of_reset(vdev);
 	}
-- 
1.8.2.1
