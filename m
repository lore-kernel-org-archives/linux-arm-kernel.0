From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 22 Oct 2015 11:42:02 +0200
Subject: [PATCH v2 6/6] vfio: platform: move get/put reset at open/release
In-Reply-To: <1445506922-6005-1-git-send-email-eric.auger@linaro.org>
References: <1445506922-6005-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1445506922-6005-7-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently reset lookup is done on probe. This introduces a
race with new registration mechanism in the case where the
vfio-platform driver is bound to the device before its module
is loaded: on the load, the probe happens which triggers the
reset module load which itself attempts to get the symbol for
the registration function (vfio_platform_register_reset). The
symbol is not yet available hence the lookup fails. In case we
do the lookup in the first open we are sure the vfio-platform
module is loaded and vfio_platform_register_reset is available.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/vfio/platform/vfio_platform_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 95b8294..5ebae8c 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -155,6 +155,7 @@ static void vfio_platform_release(void *device_data)
 			vdev->reset(vdev);
 		vfio_platform_regions_cleanup(vdev);
 		vfio_platform_irq_cleanup(vdev);
+		vfio_platform_put_reset(vdev);
 	}
 
 	mutex_unlock(&driver_lock);
@@ -181,6 +182,8 @@ static int vfio_platform_open(void *device_data)
 		if (ret)
 			goto err_irq;
 
+		vfio_platform_get_reset(vdev);
+
 		if (vdev->reset)
 			vdev->reset(vdev);
 	}
@@ -570,8 +573,6 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 		return ret;
 	}
 
-	vfio_platform_get_reset(vdev);
-
 	mutex_init(&vdev->igate);
 
 	return 0;
@@ -585,7 +586,6 @@ struct vfio_platform_device *vfio_platform_remove_common(struct device *dev)
 	vdev = vfio_del_group_dev(dev);
 
 	if (vdev) {
-		vfio_platform_put_reset(vdev);
 		iommu_group_put(dev->iommu_group);
 	}
 
-- 
1.9.1
