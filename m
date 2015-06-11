From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 11 Jun 2015 14:08:46 +0200
Subject: [PATCH v3 3/4] VFIO: platform: populate the reset function on probe
In-Reply-To: <1434024527-13869-1-git-send-email-eric.auger@linaro.org>
References: <1434024527-13869-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1434024527-13869-4-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reset function lookup happens on vfio-platform probe. The reset
module load is requested  and a reference to the function symbol is
hold. The reference is released on vfio-platform remove.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v2 -> v3:
- vfio_platform_get_reset becomes void
- use ARRAY_SIZE
- use symbol_put_addr

v1 -> v2:
- [get,put]_reset now is called once on probe/remove
- use request_module to automatically load the reset module that
  matches the compatibility string
- lookup table is used instead of list
- remove registration mechanism: reset function name is stored in the
  lookup table.
- use device_property_read_string instead of
  device_property_read_string_array
---
 drivers/vfio/platform/vfio_platform_common.c | 37 +++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 6393581..f3391a9 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -28,6 +28,36 @@ static DEFINE_MUTEX(driver_lock);
 static const struct vfio_platform_reset_combo reset_lookup_table[] = {
 };
 
+static void vfio_platform_get_reset(struct vfio_platform_device *vdev,
+				    struct device *dev)
+{
+	const char *compat;
+	int (*reset)(struct vfio_platform_device *);
+	int ret, i;
+
+	ret = device_property_read_string(dev, "compatible", &compat);
+	if (ret)
+		return;
+
+	for (i = 0 ; i < ARRAY_SIZE(reset_lookup_table); i++) {
+		if (!strcmp(reset_lookup_table[i].compat, compat)) {
+			request_module(reset_lookup_table[i].module_name);
+			reset = __symbol_get(
+				reset_lookup_table[i].reset_function_name);
+			if (reset) {
+				vdev->reset = reset;
+				return;
+			}
+		}
+	}
+}
+
+static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
+{
+	if (vdev->reset)
+		symbol_put_addr(vdev->reset);
+}
+
 static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
 {
 	int cnt = 0, i;
@@ -516,6 +546,8 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 		return ret;
 	}
 
+	vfio_platform_get_reset(vdev, dev);
+
 	mutex_init(&vdev->igate);
 
 	return 0;
@@ -527,8 +559,11 @@ struct vfio_platform_device *vfio_platform_remove_common(struct device *dev)
 	struct vfio_platform_device *vdev;
 
 	vdev = vfio_del_group_dev(dev);
-	if (vdev)
+
+	if (vdev) {
+		vfio_platform_put_reset(vdev);
 		iommu_group_put(dev->iommu_group);
+	}
 
 	return vdev;
 }
-- 
1.9.1
