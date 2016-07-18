From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 18 Jul 2016 19:09:23 -0400
Subject: [PATCH V10 5/9] vfio: platform: add extra debug info argument to call
 reset
In-Reply-To: <1468883367-2854-1-git-send-email-okaya@codeaurora.org>
References: <1468883367-2854-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1468883367-2854-6-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Getting ready to bring out extra debug information to the caller
so that more verbose information can be printed when an error is
observed.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
---
 drivers/vfio/platform/vfio_platform_common.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index a5299f6..f6025c9 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -166,7 +166,8 @@ static void vfio_platform_regions_cleanup(struct vfio_platform_device *vdev)
 	kfree(vdev->regions);
 }
 
-static int vfio_platform_call_reset(struct vfio_platform_device *vdev)
+static int vfio_platform_call_reset(struct vfio_platform_device *vdev,
+				    const char **extra_dbg)
 {
 	if (vdev->of_reset) {
 		dev_info(vdev->device, "reset\n");
@@ -184,7 +185,7 @@ static void vfio_platform_release(void *device_data)
 	mutex_lock(&driver_lock);
 
 	if (!(--vdev->refcnt)) {
-		vfio_platform_call_reset(vdev);
+		vfio_platform_call_reset(vdev, NULL);
 		vfio_platform_regions_cleanup(vdev);
 		vfio_platform_irq_cleanup(vdev);
 	}
@@ -213,7 +214,7 @@ static int vfio_platform_open(void *device_data)
 		if (ret)
 			goto err_irq;
 
-		vfio_platform_call_reset(vdev);
+		vfio_platform_call_reset(vdev, NULL);
 	}
 
 	vdev->refcnt++;
@@ -345,7 +346,7 @@ static long vfio_platform_ioctl(void *device_data,
 		return ret;
 
 	} else if (cmd == VFIO_DEVICE_RESET) {
-		return vfio_platform_call_reset(vdev);
+		return vfio_platform_call_reset(vdev, NULL);
 	}
 
 	return -ENOTTY;
-- 
1.8.2.1
