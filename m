From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 20 Jun 2016 11:51:19 -0400
Subject: [PATCH V8 9/9] vfio: platform: check reset call return code during
 release
In-Reply-To: <1466437879-32182-1-git-send-email-okaya@codeaurora.org>
References: <1466437879-32182-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1466437879-32182-10-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Release call is ignoring the return code from reset call and can
potentially continue even though reset call failed.

If reset_required module parameter is set, this patch is going
to validate the return code and will cause stack dump with
WARN_ON and warn the user of failure.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
---
 drivers/vfio/platform/vfio_platform_common.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 8509189..900fd7f 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -243,7 +243,15 @@ static void vfio_platform_release(void *device_data)
 	mutex_lock(&driver_lock);
 
 	if (!(--vdev->refcnt)) {
-		vfio_platform_call_reset(vdev, NULL);
+		const char *extra_dbg = NULL;
+		int ret;
+
+		ret = vfio_platform_call_reset(vdev, &extra_dbg);
+		if (ret && vdev->reset_required) {
+			dev_warn(vdev->device, "reset driver is required and reset call failed in release (%d) %s\n",
+				 ret, extra_dbg ? extra_dbg : "");
+			WARN_ON(1);
+		}
 		vfio_platform_regions_cleanup(vdev);
 		vfio_platform_irq_cleanup(vdev);
 	}
-- 
1.8.2.1
