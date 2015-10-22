From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 22 Oct 2015 11:41:59 +0200
Subject: [PATCH v2 3/6] vfio: platform: reset: calxedaxgmac: add reset
 function registration
In-Reply-To: <1445506922-6005-1-git-send-email-eric.auger@linaro.org>
References: <1445506922-6005-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1445506922-6005-4-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the reset function registration/unregistration.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v1 -> v2:
- uses the module_vfio_reset_handler macro
- add pr_info on vfio reset
- do not export vfio_platform_calxedaxgmac_reset symbol anymore
---
 drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
index 619dc7d..8b2cccc 100644
--- a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
+++ b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
@@ -25,13 +25,12 @@
 #include <linux/io.h>
 
 #include "vfio_platform_private.h"
+#include "vfio_platform_reset_private.h"
 
 #define DRIVER_VERSION  "0.1"
 #define DRIVER_AUTHOR   "Eric Auger <eric.auger@linaro.org>"
 #define DRIVER_DESC     "Reset support for Calxeda xgmac vfio platform device"
 
-#define CALXEDAXGMAC_COMPAT "calxeda,hb-xgmac"
-
 /* XGMAC Register definitions */
 #define XGMAC_CONTROL           0x00000000      /* MAC Configuration */
 
@@ -70,6 +69,8 @@ int vfio_platform_calxedaxgmac_reset(struct vfio_platform_device *vdev)
 			return -ENOMEM;
 	}
 
+	pr_info("VFIO reset of %s\n", vdev->name);
+
 	/* disable IRQ */
 	writel(0, reg.ioaddr + XGMAC_DMA_INTR_ENA);
 
@@ -78,7 +79,9 @@ int vfio_platform_calxedaxgmac_reset(struct vfio_platform_device *vdev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(vfio_platform_calxedaxgmac_reset);
+
+module_vfio_reset_handler("calxeda,hb-xgmac",
+			  vfio_platform_calxedaxgmac_reset);
 
 MODULE_VERSION(DRIVER_VERSION);
 MODULE_LICENSE("GPL v2");
-- 
1.9.1
