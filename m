From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 13 Jun 2016 00:26:40 -0400
Subject: [PATCH V7 8/9] vfio: platform: check reset call return code during
 open
In-Reply-To: <1465792001-27960-1-git-send-email-okaya@codeaurora.org>
References: <1465792001-27960-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1465792001-27960-9-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Open call is ignoring the return code from reset call and can
potentially continue even though reset call failed.

If reset_required module parameter is set, this patch is going
to validate the return code and will abort open if reset fails.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/vfio/platform/vfio_platform_common.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index d84c399..d3141e7 100644
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
+			goto err_rst;
+		}
 	}
 
 	vdev->refcnt++;
@@ -280,6 +287,8 @@ static int vfio_platform_open(void *device_data)
 	mutex_unlock(&driver_lock);
 	return 0;
 
+err_rst:
+	vfio_platform_irq_cleanup(vdev);
 err_irq:
 	vfio_platform_regions_cleanup(vdev);
 err_reg:
-- 
1.8.2.1
