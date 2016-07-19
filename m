From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 19 Jul 2016 09:01:49 -0400
Subject: [PATCH V11 9/9] vfio: platform: check reset call return code during
 release
In-Reply-To: <1468933309-19735-1-git-send-email-okaya@codeaurora.org>
References: <1468933309-19735-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1468933309-19735-10-git-send-email-okaya@codeaurora.org>
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
index 502e793..eaa6da1 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -230,7 +230,15 @@ static void vfio_platform_release(void *device_data)
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
