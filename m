From: eric.auger@linaro.org (Eric Auger)
Date: Fri, 23 Oct 2015 14:37:12 +0200
Subject: [PATCH v3 4/7] vfio: platform: reset: calxedaxgmac: add reset
 function registration
In-Reply-To: <1445603835-14506-1-git-send-email-eric.auger@linaro.org>
References: <1445603835-14506-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1445603835-14506-5-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the reset function registration/unregistration.
This is handled through the module_vfio_reset_handler macro. This
latter also defines a MODULE_ALIAS which simplifies the load from
vfio-platform.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---
v2 -> v3:
- do not include vfio_platform_reset_private.h anymore (removed)
- remove pr_info
- rework commit message

v1 -> v2:
- uses the module_vfio_reset_handler macro
- add pr_info on vfio reset
- do not export vfio_platform_calxedaxgmac_reset symbol anymore
---
 drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
index 619dc7d..640f5d8 100644
--- a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
+++ b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
@@ -30,8 +30,6 @@
 #define DRIVER_AUTHOR   "Eric Auger <eric.auger@linaro.org>"
 #define DRIVER_DESC     "Reset support for Calxeda xgmac vfio platform device"
 
-#define CALXEDAXGMAC_COMPAT "calxeda,hb-xgmac"
-
 /* XGMAC Register definitions */
 #define XGMAC_CONTROL           0x00000000      /* MAC Configuration */
 
@@ -78,7 +76,8 @@ int vfio_platform_calxedaxgmac_reset(struct vfio_platform_device *vdev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(vfio_platform_calxedaxgmac_reset);
+
+module_vfio_reset_handler("calxeda,hb-xgmac", vfio_platform_calxedaxgmac_reset);
 
 MODULE_VERSION(DRIVER_VERSION);
 MODULE_LICENSE("GPL v2");
-- 
1.9.1
