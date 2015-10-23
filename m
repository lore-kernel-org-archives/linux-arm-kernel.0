From: eric.auger@linaro.org (Eric Auger)
Date: Fri, 23 Oct 2015 17:47:25 +0200
Subject: [PATCH v4 7/7] vfio: platform: add dev_info on device reset
In-Reply-To: <1445615245-31124-1-git-send-email-eric.auger@linaro.org>
References: <1445615245-31124-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1445615245-31124-8-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It might be helpful for the end-user to check the device reset
function was found by the vfio platform reset framework.

Lets store a pointer to the struct device in vfio_platform_device
and trace when the reset function is called or not found.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v3: creation
---
 drivers/vfio/platform/vfio_platform_common.c  | 14 ++++++++++++--
 drivers/vfio/platform/vfio_platform_private.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index f74836a..376d289 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -144,8 +144,12 @@ static void vfio_platform_release(void *device_data)
 	mutex_lock(&driver_lock);
 
 	if (!(--vdev->refcnt)) {
-		if (vdev->reset)
+		if (vdev->reset) {
+			dev_info(vdev->device, "reset\n");
 			vdev->reset(vdev);
+		} else {
+			dev_warn(vdev->device, "no reset function found!\n");
+		}
 		vfio_platform_regions_cleanup(vdev);
 		vfio_platform_irq_cleanup(vdev);
 	}
@@ -174,8 +178,12 @@ static int vfio_platform_open(void *device_data)
 		if (ret)
 			goto err_irq;
 
-		if (vdev->reset)
+		if (vdev->reset) {
+			dev_info(vdev->device, "reset\n");
 			vdev->reset(vdev);
+		} else {
+			dev_warn(vdev->device, "no reset function found!\n");
+		}
 	}
 
 	vdev->refcnt++;
@@ -551,6 +559,8 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 		return -EINVAL;
 	}
 
+	vdev->device = dev;
+
 	group = iommu_group_get(dev);
 	if (!group) {
 		pr_err("VFIO: No IOMMU group for device %s\n", vdev->name);
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index d1b0668..42816dd 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -59,6 +59,7 @@ struct vfio_platform_device {
 	struct module			*parent_module;
 	const char			*compat;
 	struct module			*reset_module;
+	struct device			*device;
 
 	/*
 	 * These fields should be filled by the bus specific binder
-- 
1.9.1
