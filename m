From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 15 May 2016 22:13:35 -0400
Subject: [PATCH V5 2/6] vfio: platform: move reset call to a common function
In-Reply-To: <1463364819-477-1-git-send-email-okaya@codeaurora.org>
References: <1463364819-477-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1463364819-477-3-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reset call sequence seems to replicate itself multiple times
across the file. Grouping them together for maintenance reasons.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/vfio/platform/vfio_platform_common.c | 31 ++++++++++++++--------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 08fd7c2..cb91dd3 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -134,6 +134,18 @@ static void vfio_platform_regions_cleanup(struct vfio_platform_device *vdev)
 	kfree(vdev->regions);
 }
 
+static int vfio_platform_call_reset(struct vfio_platform_device *vdev)
+{
+	if (vdev->of_reset) {
+		dev_info(vdev->device, "reset\n");
+		vdev->of_reset(vdev);
+		return 0;
+	}
+
+	dev_warn(vdev->device, "no reset function found!\n");
+	return -EINVAL;
+}
+
 static void vfio_platform_release(void *device_data)
 {
 	struct vfio_platform_device *vdev = device_data;
@@ -141,12 +153,7 @@ static void vfio_platform_release(void *device_data)
 	mutex_lock(&driver_lock);
 
 	if (!(--vdev->refcnt)) {
-		if (vdev->of_reset) {
-			dev_info(vdev->device, "reset\n");
-			vdev->of_reset(vdev);
-		} else {
-			dev_warn(vdev->device, "no reset function found!\n");
-		}
+		vfio_platform_call_reset(vdev);
 		vfio_platform_regions_cleanup(vdev);
 		vfio_platform_irq_cleanup(vdev);
 	}
@@ -175,12 +182,7 @@ static int vfio_platform_open(void *device_data)
 		if (ret)
 			goto err_irq;
 
-		if (vdev->of_reset) {
-			dev_info(vdev->device, "reset\n");
-			vdev->of_reset(vdev);
-		} else {
-			dev_warn(vdev->device, "no reset function found!\n");
-		}
+		vfio_platform_call_reset(vdev);
 	}
 
 	vdev->refcnt++;
@@ -312,10 +314,7 @@ static long vfio_platform_ioctl(void *device_data,
 		return ret;
 
 	} else if (cmd == VFIO_DEVICE_RESET) {
-		if (vdev->of_reset)
-			return vdev->of_reset(vdev);
-		else
-			return -EINVAL;
+		return vfio_platform_call_reset(vdev);
 	}
 
 	return -ENOTTY;
-- 
1.8.2.1
