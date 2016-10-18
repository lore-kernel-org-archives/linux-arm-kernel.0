From: zourongrong@gmail.com (Rongrong Zou)
Date: Tue, 18 Oct 2016 12:01:21 +0800
Subject: [PATCH v4 6/9] drm/hisilicon/hibmc: Add encoder for VDAC
In-Reply-To: <1476763284-100508-1-git-send-email-zourongrong@gmail.com>
References: <1476763284-100508-1-git-send-email-zourongrong@gmail.com>
Message-ID: <1476763284-100508-7-git-send-email-zourongrong@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add encoder funcs and helpers for VDAC.

Signed-off-by: Rongrong Zou <zourongrong@gmail.com>
---
 drivers/gpu/drm/hisilicon/hibmc/Makefile         |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  |  6 ++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  |  2 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 90 ++++++++++++++++++++++++
 4 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c

diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
index 72e107e..e04f114 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
+++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
@@ -1,5 +1,5 @@
 ccflags-y := -Iinclude/drm
-hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_fbdev.o hibmc_drm_power.o hibmc_ttm.o
+hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_fbdev.o hibmc_drm_power.o hibmc_ttm.o
 
 obj-$(CONFIG_DRM_HISI_HIBMC)	+=hibmc-drm.o
 #obj-y	+= hibmc-drm.o
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 748f6b1..f51e5a209 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -136,6 +136,12 @@ static int hibmc_kms_init(struct hibmc_drm_device *hidev)
 		return ret;
 	}
 
+	ret = hibmc_encoder_init(hidev);
+	if (ret) {
+		DRM_ERROR("failed to init encoder\n");
+		return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 9b83201..c45449b 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -48,6 +48,7 @@ struct hibmc_drm_device {
 	struct drm_device  *dev;
 	struct drm_plane plane;
 	struct drm_crtc crtc;
+	struct drm_encoder encoder;
 	bool mode_config_initialized;
 
 	/* ttm */
@@ -88,6 +89,7 @@ static inline struct hibmc_bo *gem_to_hibmc_bo(struct drm_gem_object *gem)
 
 int hibmc_plane_init(struct hibmc_drm_device *hidev);
 int hibmc_crtc_init(struct hibmc_drm_device *hidev);
+int hibmc_encoder_init(struct hibmc_drm_device *hidev);
 int hibmc_fbdev_init(struct hibmc_drm_device *hidev);
 void hibmc_fbdev_fini(struct hibmc_drm_device *hidev);
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
new file mode 100644
index 0000000..3cdd634
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -0,0 +1,90 @@
+/* Hisilicon Hibmc SoC drm driver
+ *
+ * Based on the bochs drm driver.
+ *
+ * Copyright (c) 2016 Huawei Limited.
+ *
+ * Author:
+ *	Rongrong Zou <zourongrong@huawei.com>
+ *	Rongrong Zou <zourongrong@gmail.com>
+ *	Jianhua Li <lijianhua@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc_helper.h>
+
+#include "hibmc_drm_drv.h"
+#include "hibmc_drm_regs.h"
+
+static int defx = 800;
+static int defy = 600;
+
+module_param(defx, int, 0444);
+module_param(defy, int, 0444);
+MODULE_PARM_DESC(defx, "default x resolution");
+MODULE_PARM_DESC(defy, "default y resolution");
+
+static void hibmc_encoder_disable(struct drm_encoder *encoder)
+{
+}
+
+static void hibmc_encoder_enable(struct drm_encoder *encoder)
+{
+}
+
+static void hibmc_encoder_mode_set(struct drm_encoder *encoder,
+				   struct drm_display_mode *mode,
+				   struct drm_display_mode *adj_mode)
+{
+	u32 reg;
+	struct drm_device *dev = encoder->dev;
+	struct hibmc_drm_device *hidev = dev->dev_private;
+
+	/* just open DISPLAY_CONTROL_HISILE register bit 3:0*/
+	reg = readl(hidev->mmio + DISPLAY_CONTROL_HISILE);
+	reg |= 0xf;
+	writel(reg, hidev->mmio + DISPLAY_CONTROL_HISILE);
+}
+
+static int hibmc_encoder_atomic_check(struct drm_encoder *encoder,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_connector_state *conn_state)
+{
+	return 0;
+}
+
+static const struct drm_encoder_helper_funcs hibmc_encoder_helper_funcs = {
+	.mode_set = hibmc_encoder_mode_set,
+	.disable = hibmc_encoder_disable,
+	.enable = hibmc_encoder_enable,
+	.atomic_check = hibmc_encoder_atomic_check,
+};
+
+static const struct drm_encoder_funcs hibmc_encoder_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+int hibmc_encoder_init(struct hibmc_drm_device *hidev)
+{
+	struct drm_device *dev = hidev->dev;
+	struct drm_encoder *encoder = &hidev->encoder;
+	int ret;
+
+	encoder->possible_crtcs = 0x1;
+	ret = drm_encoder_init(dev, encoder, &hibmc_encoder_encoder_funcs,
+			       DRM_MODE_ENCODER_DAC, NULL);
+	if (ret) {
+		DRM_ERROR("failed to init encoder\n");
+		return ret;
+	}
+
+	drm_encoder_helper_add(encoder, &hibmc_encoder_helper_funcs);
+	return 0;
+}
+
-- 
1.9.1
