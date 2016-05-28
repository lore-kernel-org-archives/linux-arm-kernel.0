From: okaya@codeaurora.org (Sinan Kaya)
Date: Sat, 28 May 2016 18:01:17 -0400
Subject: [PATCH V6 7/8] vfio: platform: check reset call return code during
 open
In-Reply-To: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
References: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1464472878-27176-8-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Open call is ignoring the return code from reset call and can
potentially continue even though reset call failed.

If reset_required module parameter is set, this patch is going
to validate the return code and will abort open if reset fails.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/vfio/platform/vfio_platform_common.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index e87ceab..962cfb1 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -264,6 +264,8 @@ static int vfio_platform_open(void *device_data)
 	mutex_lock(&driver_lock);
 
 	if (!vdev->refcnt) {
+		const char *extra_dbg = NULL;
+
 		ret = vfio_platform_regions_init(vdev);
 		if (ret)
 			goto err_reg;
@@ -272,7 +274,12 @@ static int vfio_platform_open(void *device_data)
 		if (ret)
 			goto err_irq;
 
-		vfio_platform_call_reset(vdev, NULL);
+		ret = vfio_platform_call_reset(vdev, &extra_dbg);
+		if (ret && vdev->reset_required) {
+			dev_warn(vdev->device, "reset driver is required and reset call failed in open (%d) %s\n",
+				 ret, extra_dbg ? extra_dbg : "");
+			goto err_irq;
+		}
 	}
 
 	vdev->refcnt++;
-- 
1.8.2.1
