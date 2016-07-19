From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 19 Jul 2016 09:01:48 -0400
Subject: [PATCH V11 8/9] vfio: platform: check reset call return code during
 open
In-Reply-To: <1468933309-19735-1-git-send-email-okaya@codeaurora.org>
References: <1468933309-19735-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1468933309-19735-9-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Open call is ignoring the return code from reset call and can
potentially continue even though reset call failed.

If reset_required module parameter is set, this patch is going
to validate the return code and will abort open if reset fails.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/vfio/platform/vfio_platform_common.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 8e35b5b..502e793 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -251,6 +251,8 @@ static int vfio_platform_open(void *device_data)
 	mutex_lock(&driver_lock);
 
 	if (!vdev->refcnt) {
+		const char *extra_dbg = NULL;
+
 		ret = vfio_platform_regions_init(vdev);
 		if (ret)
 			goto err_reg;
@@ -259,7 +261,12 @@ static int vfio_platform_open(void *device_data)
 		if (ret)
 			goto err_irq;
 
-		vfio_platform_call_reset(vdev, NULL);
+		ret = vfio_platform_call_reset(vdev, &extra_dbg);
+		if (ret && vdev->reset_required) {
+			dev_warn(vdev->device, "reset driver is required and reset call failed in open (%d) %s\n",
+				 ret, extra_dbg ? extra_dbg : "");
+			goto err_rst;
+		}
 	}
 
 	vdev->refcnt++;
@@ -267,6 +274,8 @@ static int vfio_platform_open(void *device_data)
 	mutex_unlock(&driver_lock);
 	return 0;
 
+err_rst:
+	vfio_platform_irq_cleanup(vdev);
 err_irq:
 	vfio_platform_regions_cleanup(vdev);
 err_reg:
-- 
1.8.2.1
