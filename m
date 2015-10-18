From: eric.auger@linaro.org (Eric Auger)
Date: Sun, 18 Oct 2015 18:00:13 +0200
Subject: [PATCH 2/4] vfio: platform: reset: calxedaxgmac: add reset function
 registration
In-Reply-To: <1445184015-24414-1-git-send-email-eric.auger@linaro.org>
References: <1445184015-24414-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1445184015-24414-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the reset function registration/unregistration.
Also a MODULE_ALIAS is added.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 .../platform/reset/vfio_platform_calxedaxgmac.c    | 40 ++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
index 619dc7d..4f76b17 100644
--- a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
+++ b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
@@ -29,8 +29,7 @@
 #define DRIVER_VERSION  "0.1"
 #define DRIVER_AUTHOR   "Eric Auger <eric.auger@linaro.org>"
 #define DRIVER_DESC     "Reset support for Calxeda xgmac vfio platform device"
-
-#define CALXEDAXGMAC_COMPAT "calxeda,hb-xgmac"
+#define COMPAT		"calxeda,hb-xgmac"
 
 /* XGMAC Register definitions */
 #define XGMAC_CONTROL           0x00000000      /* MAC Configuration */
@@ -80,6 +79,43 @@ int vfio_platform_calxedaxgmac_reset(struct vfio_platform_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_platform_calxedaxgmac_reset);
 
+static int __init vfio_platform_calxedaxgmac_init(void)
+{
+	int (*register_reset)(struct module *, char*,
+				vfio_platform_reset_fn_t);
+	int ret;
+
+	register_reset = symbol_get(vfio_platform_register_reset);
+	if (!register_reset)
+		return -EINVAL;
+
+	ret = register_reset(THIS_MODULE, COMPAT,
+	vfio_platform_calxedaxgmac_reset);
+
+	symbol_put(vfio_platform_register_reset);
+
+	return ret;
+}
+
+static void __exit vfio_platform_calxedaxgmac_exit(void)
+{
+	int (*unregister_reset)(char *);
+	int ret;
+
+	unregister_reset = symbol_get(vfio_platform_unregister_reset);
+	if (!unregister_reset)
+		return;
+
+	ret = unregister_reset(COMPAT);
+
+	symbol_put(vfio_platform_unregister_reset);
+}
+
+module_init(vfio_platform_calxedaxgmac_init);
+module_exit(vfio_platform_calxedaxgmac_exit);
+
+MODULE_ALIAS("vfio-reset:"  COMPAT);
+
 MODULE_VERSION(DRIVER_VERSION);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR(DRIVER_AUTHOR);
-- 
1.9.1
