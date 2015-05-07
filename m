From: eric.auger@linaro.org (Eric Auger)
Date: Thu,  7 May 2015 16:27:22 +0200
Subject: [PATCH 4/5] VFIO: platform: populate reset function according to
 compat
In-Reply-To: <1431008843-28411-1-git-send-email-eric.auger@linaro.org>
References: <1431008843-28411-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1431008843-28411-5-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the reset function lookup according to the device compat
string. This lookup is added at different places:
- on VFIO_DEVICE_GET_INFO
- on VFIO_DEVICE_RESET
- on device release

A reference to the module implementing the reset function is taken
on first reset function lookup and released on vfio platform device
release.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/vfio/platform/vfio_platform_common.c | 50 ++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 0d10018..bd7e44c 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -28,6 +28,52 @@ LIST_HEAD(reset_list);
 
 static DEFINE_MUTEX(driver_lock);
 
+static vfio_platform_reset_fn_t vfio_platform_lookup_reset(const char *compat)
+{
+	struct vfio_platform_reset_node *iter;
+
+	list_for_each_entry(iter, &reset_list, link) {
+		if (!strcmp(iter->compat, compat) &&
+			try_module_get(iter->owner))
+			return iter->reset;
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+
+static vfio_platform_reset_fn_t vfio_platform_get_reset(
+					struct vfio_platform_device *vdev)
+{
+	struct device *dev = vdev->get_device(vdev);
+	const char *compat_str_array[2];
+	vfio_platform_reset_fn_t reset;
+	int ret;
+
+	if (!IS_ERR_OR_NULL(vdev->reset))
+		return vdev->reset;
+
+	ret = device_property_read_string_array(dev, "compatible",
+						compat_str_array, 2);
+	if (!ret)
+		return ERR_PTR(ret);
+
+	reset = vfio_platform_lookup_reset(compat_str_array[0]);
+	return reset;
+}
+
+static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
+{
+	struct vfio_platform_reset_node *iter;
+
+	list_for_each_entry(iter, &reset_list, link) {
+		if (iter->reset == vdev->reset) {
+			module_put(iter->owner);
+			vdev->reset = NULL;
+			return;
+		}
+	}
+}
+
 static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
 {
 	int cnt = 0, i;
@@ -103,10 +149,12 @@ static void vfio_platform_release(void *device_data)
 	mutex_lock(&driver_lock);
 
 	if (!(--vdev->refcnt)) {
+		vdev->reset = vfio_platform_get_reset(vdev);
 		if (!IS_ERR_OR_NULL(vdev->reset))
 			vdev->reset(vdev);
 		vfio_platform_regions_cleanup(vdev);
 		vfio_platform_irq_cleanup(vdev);
+		vfio_platform_put_reset(vdev);
 	}
 
 	mutex_unlock(&driver_lock);
@@ -164,6 +212,7 @@ static long vfio_platform_ioctl(void *device_data,
 		if (info.argsz < minsz)
 			return -EINVAL;
 
+		vdev->reset = vfio_platform_get_reset(vdev);
 		if (!IS_ERR_OR_NULL(vdev->reset))
 			vdev->flags |= VFIO_DEVICE_FLAGS_RESET;
 		info.flags = vdev->flags;
@@ -260,6 +309,7 @@ static long vfio_platform_ioctl(void *device_data,
 		return ret;
 
 	} else if (cmd == VFIO_DEVICE_RESET) {
+		vdev->reset = vfio_platform_get_reset(vdev);
 		if (!IS_ERR_OR_NULL(vdev->reset))
 			return vdev->reset(vdev);
 		else
-- 
1.9.1
