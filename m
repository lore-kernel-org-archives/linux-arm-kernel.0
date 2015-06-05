From: eric.auger@linaro.org (Eric Auger)
Date: Fri,  5 Jun 2015 17:06:30 +0200
Subject: [PATCH v2 2/4] VFIO: platform: add reset callback
In-Reply-To: <1433516792-16397-1-git-send-email-eric.auger@linaro.org>
References: <1433516792-16397-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1433516792-16397-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new reset callback is introduced. If this callback is populated,
the reset is invoked on device first open/last close or upon userspace
ioctl.  The modality is exposed on VFIO_DEVICE_GET_INFO.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v1 -> v2:
- reset now is also called on first open on top of last close
- remove IS_ERR_OR_NULL
---
 drivers/vfio/platform/vfio_platform_common.c  | 15 +++++++++++++--
 drivers/vfio/platform/vfio_platform_private.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index d970776..995929b 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -106,6 +106,8 @@ static void vfio_platform_release(void *device_data)
 	mutex_lock(&driver_lock);
 
 	if (!(--vdev->refcnt)) {
+		if (vdev->reset)
+			vdev->reset(vdev);
 		vfio_platform_regions_cleanup(vdev);
 		vfio_platform_irq_cleanup(vdev);
 	}
@@ -133,6 +135,9 @@ static int vfio_platform_open(void *device_data)
 		ret = vfio_platform_irq_init(vdev);
 		if (ret)
 			goto err_irq;
+
+		if (vdev->reset)
+			vdev->reset(vdev);
 	}
 
 	vdev->refcnt++;
@@ -165,6 +170,8 @@ static long vfio_platform_ioctl(void *device_data,
 		if (info.argsz < minsz)
 			return -EINVAL;
 
+		if (vdev->reset)
+			vdev->flags |= VFIO_DEVICE_FLAGS_RESET;
 		info.flags = vdev->flags;
 		info.num_regions = vdev->num_regions;
 		info.num_irqs = vdev->num_irqs;
@@ -258,8 +265,12 @@ static long vfio_platform_ioctl(void *device_data,
 
 		return ret;
 
-	} else if (cmd == VFIO_DEVICE_RESET)
-		return -EINVAL;
+	} else if (cmd == VFIO_DEVICE_RESET) {
+		if (vdev->reset)
+			return vdev->reset(vdev);
+		else
+			return -EINVAL;
+	}
 
 	return -ENOTTY;
 }
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index d864124..cccb3ba 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -72,6 +72,7 @@ struct vfio_platform_device {
 	struct resource*
 		(*get_resource)(struct vfio_platform_device *vdev, int i);
 	int	(*get_irq)(struct vfio_platform_device *vdev, int i);
+	int	(*reset)(struct vfio_platform_device *vdev);
 };
 
 struct vfio_platform_reset_combo {
-- 
1.9.1
