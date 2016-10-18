From: zourongrong@gmail.com (Rongrong Zou)
Date: Tue, 18 Oct 2016 12:01:19 +0800
Subject: [PATCH v4 4/9] drm/hisilicon/hibmc: Add plane for DE
In-Reply-To: <1476763284-100508-1-git-send-email-zourongrong@gmail.com>
References: <1476763284-100508-1-git-send-email-zourongrong@gmail.com>
Message-ID: <1476763284-100508-5-git-send-email-zourongrong@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add plane funcs and helper funcs for DE.

Signed-off-by: Rongrong Zou <zourongrong@gmail.com>
---
 drivers/gpu/drm/hisilicon/hibmc/Kconfig         |   1 +
 drivers/gpu/drm/hisilicon/hibmc/Makefile        |   2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c  | 171 ++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.h  |  29 ++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c |  54 +++++++-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |   5 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c     |   6 +
 7 files changed, 265 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.h

diff --git a/drivers/gpu/drm/hisilicon/hibmc/Kconfig b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
index bcb8c18..380622a 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/Kconfig
+++ b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
@@ -1,6 +1,7 @@
 config DRM_HISI_HIBMC
 	tristate "DRM Support for Hisilicon Hibmc"
 	depends on DRM && PCI
+	select DRM_KMS_HELPER
 	select DRM_TTM
 
 	help
diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
index 810a37e..72e107e 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
+++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
@@ -1,5 +1,5 @@
 ccflags-y := -Iinclude/drm
-hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_fbdev.o hibmc_drm_power.o hibmc_ttm.o
+hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_fbdev.o hibmc_drm_power.o hibmc_ttm.o
 
 obj-$(CONFIG_DRM_HISI_HIBMC)	+=hibmc-drm.o
 #obj-y	+= hibmc-drm.o
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
new file mode 100644
index 0000000..36c4d24
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -0,0 +1,171 @@
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
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_plane_helper.h>
+
+#include "hibmc_drm_drv.h"
+#include "hibmc_drm_regs.h"
+#include "hibmc_drm_power.h"
+
+/* ---------------------------------------------------------------------- */
+
+static int hibmc_plane_atomic_check(struct drm_plane *plane,
+				    struct drm_plane_state *state)
+{
+	struct drm_framebuffer *fb = state->fb;
+	struct drm_crtc *crtc = state->crtc;
+	struct drm_crtc_state *crtc_state;
+	u32 src_x = state->src_x >> 16;
+	u32 src_y = state->src_y >> 16;
+	u32 src_w = state->src_w >> 16;
+	u32 src_h = state->src_h >> 16;
+	int crtc_x = state->crtc_x;
+	int crtc_y = state->crtc_y;
+	u32 crtc_w = state->crtc_w;
+	u32 crtc_h = state->crtc_h;
+
+	if (!crtc || !fb)
+		return 0;
+
+	crtc_state = drm_atomic_get_crtc_state(state->state, crtc);
+	if (IS_ERR(crtc_state))
+		return PTR_ERR(crtc_state);
+
+	if (src_w != crtc_w || src_h != crtc_h) {
+		DRM_ERROR("Scale not support!!!\n");
+		return -EINVAL;
+	}
+
+	if (src_x + src_w > fb->width ||
+	    src_y + src_h > fb->height)
+		return -EINVAL;
+
+	if (crtc_x < 0 || crtc_y < 0)
+		return -EINVAL;
+
+	if (crtc_x + crtc_w > crtc_state->adjusted_mode.hdisplay ||
+	    crtc_y + crtc_h > crtc_state->adjusted_mode.vdisplay)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void hibmc_plane_atomic_update(struct drm_plane *plane,
+				      struct drm_plane_state *old_state)
+{
+	struct drm_plane_state	*state	= plane->state;
+	u32 reg;
+	int ret;
+	u64 gpu_addr = 0;
+	unsigned int line_l;
+	struct hibmc_drm_device *hidev =
+		(struct hibmc_drm_device *)plane->dev->dev_private;
+
+	struct hibmc_framebuffer *hibmc_fb;
+	struct hibmc_bo *bo;
+
+	hibmc_fb = to_hibmc_framebuffer(state->fb);
+	bo = gem_to_hibmc_bo(hibmc_fb->obj);
+	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
+	if (ret)
+		return;
+
+	hibmc_bo_pin(bo, TTM_PL_FLAG_VRAM, &gpu_addr);
+	if (ret) {
+		ttm_bo_unreserve(&bo->bo);
+		return;
+	}
+
+	ttm_bo_unreserve(&bo->bo);
+
+	writel(gpu_addr, hidev->mmio + HIBMC_CRT_FB_ADDRESS);
+
+	reg = state->fb->width * (state->fb->bits_per_pixel >> 3);
+	/* now line_pad is 16 */
+	reg = PADDING(16, reg);
+
+	line_l = state->fb->width * state->fb->bits_per_pixel / 8;
+	line_l = PADDING(16, line_l);
+	writel((HIBMC_CRT_FB_WIDTH_WIDTH(reg) & HIBMC_CRT_FB_WIDTH_WIDTH_MASK) |
+	       (HIBMC_CRT_FB_WIDTH_OFFS(line_l) & HIBMC_CRT_FB_WIDTH_OFFS_MASK),
+	       hidev->mmio + HIBMC_CRT_FB_WIDTH);
+
+	/* SET PIXEL FORMAT */
+	reg = readl(hidev->mmio + HIBMC_CRT_DISP_CTL);
+	reg = reg & ~HIBMC_CRT_DISP_CTL_FORMAT_MASK;
+	reg = reg | (HIBMC_CRT_DISP_CTL_FORMAT(state->fb->bits_per_pixel >> 4) &
+		     HIBMC_CRT_DISP_CTL_FORMAT_MASK);
+	writel(reg, hidev->mmio + HIBMC_CRT_DISP_CTL);
+}
+
+static void hibmc_plane_atomic_disable(struct drm_plane *plane,
+				       struct drm_plane_state *old_state)
+{
+}
+
+static const u32 channel_formats1[] = {
+	DRM_FORMAT_RGB565, DRM_FORMAT_BGR565, DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888, DRM_FORMAT_XRGB8888, DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_RGBA8888, DRM_FORMAT_BGRA8888, DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ABGR8888
+};
+
+static struct drm_plane_funcs hibmc_plane_funcs = {
+	.update_plane	= drm_atomic_helper_update_plane,
+	.disable_plane	= drm_atomic_helper_disable_plane,
+	.set_property = drm_atomic_helper_plane_set_property,
+	.destroy = drm_plane_cleanup,
+	.reset = drm_atomic_helper_plane_reset,
+	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+};
+
+static const struct drm_plane_helper_funcs hibmc_plane_helper_funcs = {
+	.atomic_check = hibmc_plane_atomic_check,
+	.atomic_update = hibmc_plane_atomic_update,
+	.atomic_disable = hibmc_plane_atomic_disable,
+};
+
+int hibmc_plane_init(struct hibmc_drm_device *hidev)
+{
+	struct drm_device *dev = hidev->dev;
+	struct drm_plane *plane = &hidev->plane;
+	int ret = 0;
+
+	/*
+	 * plane init
+	 * TODO: Now only support primary plane, overlay planes
+	 * need to do.
+	 */
+	ret = drm_universal_plane_init(dev, plane, 1, &hibmc_plane_funcs,
+				       channel_formats1,
+				       ARRAY_SIZE(channel_formats1),
+				       DRM_PLANE_TYPE_PRIMARY,
+				       NULL);
+	if (ret) {
+		DRM_ERROR("fail to init plane!!!\n");
+		return ret;
+	}
+
+	drm_plane_helper_add(plane, &hibmc_plane_helper_funcs);
+	return 0;
+}
+
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.h
new file mode 100644
index 0000000..4ce0d7b
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.h
@@ -0,0 +1,29 @@
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
+#ifndef HIBMC_DRM_DE_H
+#define HIBMC_DRM_DE_H
+
+struct panel_pll {
+	unsigned long M;
+	unsigned long N;
+	unsigned long OD;
+	unsigned long POD;
+};
+
+#endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 8ddb763..e90e6e9 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -18,6 +18,7 @@
 
 #include <linux/module.h>
 #include <linux/console.h>
+#include <drm/drm_crtc_helper.h>
 
 #include "hibmc_drm_drv.h"
 #include "hibmc_drm_regs.h"
@@ -47,8 +48,8 @@ static void hibmc_disable_vblank(struct drm_device *dev, unsigned int pipe)
 }
 
 static struct drm_driver hibmc_driver = {
-	.driver_features	= DRIVER_GEM,
-
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET |
+				  DRIVER_ATOMIC,
 	.fops			= &hibmc_fops,
 	.name			= "hibmc",
 	.date			= "20160828",
@@ -70,6 +71,8 @@ static int hibmc_pm_suspend(struct device *dev)
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
 	struct hibmc_drm_device *hidev = drm_dev->dev_private;
 
+	drm_kms_helper_poll_disable(drm_dev);
+
 	if (hidev->fbdev.initialized) {
 		console_lock();
 		drm_fb_helper_set_suspend(&hidev->fbdev.helper, 1);
@@ -85,12 +88,16 @@ static int hibmc_pm_resume(struct device *dev)
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
 	struct hibmc_drm_device *hidev = drm_dev->dev_private;
 
+	drm_helper_resume_force_mode(drm_dev);
+
 	if (hidev->fbdev.initialized) {
 		console_lock();
 		drm_fb_helper_set_suspend(&hidev->fbdev.helper, 0);
 		console_unlock();
 	}
 
+	drm_kms_helper_poll_enable(drm_dev);
+
 	return 0;
 }
 
@@ -99,6 +106,41 @@ static int hibmc_pm_resume(struct device *dev)
 				hibmc_pm_resume)
 };
 
+static int hibmc_kms_init(struct hibmc_drm_device *hidev)
+{
+	int ret;
+
+	drm_mode_config_init(hidev->dev);
+	hidev->mode_config_initialized = true;
+
+	hidev->dev->mode_config.min_width = 0;
+	hidev->dev->mode_config.min_height = 0;
+	hidev->dev->mode_config.max_width = 1920;
+	hidev->dev->mode_config.max_height = 1440;
+
+	hidev->dev->mode_config.fb_base = hidev->fb_base;
+	hidev->dev->mode_config.preferred_depth = 24;
+	hidev->dev->mode_config.prefer_shadow = 0;
+
+	hidev->dev->mode_config.funcs = (void *)&hibmc_mode_funcs;
+
+	ret = hibmc_plane_init(hidev);
+	if (ret) {
+		DRM_ERROR("fail to init plane!!!\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void hibmc_kms_fini(struct hibmc_drm_device *hidev)
+{
+	if (hidev->mode_config_initialized) {
+		drm_mode_config_cleanup(hidev->dev);
+		hidev->mode_config_initialized = false;
+	}
+}
+
 static int hibmc_hw_config(struct hibmc_drm_device *hidev)
 {
 	unsigned int reg;
@@ -191,6 +233,7 @@ static int hibmc_unload(struct drm_device *dev)
 	struct hibmc_drm_device *hidev = dev->dev_private;
 
 	hibmc_fbdev_fini(hidev);
+	hibmc_kms_fini(hidev);
 	hibmc_hw_fini(hidev);
 	dev->dev_private = NULL;
 	return 0;
@@ -215,6 +258,13 @@ static int hibmc_load(struct drm_device *dev, unsigned long flags)
 	if (ret)
 		goto err;
 
+	ret = hibmc_kms_init(hidev);
+	if (ret)
+		goto err;
+
+	/* reset all the states of crtc/plane/encoder/connector */
+	drm_mode_config_reset(dev);
+
 	ret = hibmc_fbdev_init(hidev);
 	if (ret)
 		goto err;
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 4f5887f..6148f7f 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -46,6 +46,8 @@ struct hibmc_drm_device {
 
 	/* drm */
 	struct drm_device  *dev;
+	struct drm_plane plane;
+	bool mode_config_initialized;
 
 	/* ttm */
 	struct {
@@ -83,6 +85,7 @@ static inline struct hibmc_bo *gem_to_hibmc_bo(struct drm_gem_object *gem)
 
 #define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
 
+int hibmc_plane_init(struct hibmc_drm_device *hidev);
 int hibmc_fbdev_init(struct hibmc_drm_device *hidev);
 void hibmc_fbdev_fini(struct hibmc_drm_device *hidev);
 
@@ -102,4 +105,6 @@ int hibmc_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
 			   u32 handle, u64 *offset);
 int hibmc_mmap(struct file *filp, struct vm_area_struct *vma);
 
+extern const struct drm_mode_config_funcs hibmc_mode_funcs;
+
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
index c8f7f6c..8d6327e 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
@@ -556,3 +556,9 @@ int hibmc_framebuffer_init(struct drm_device *dev,
 	return &hibmc_fb->fb;
 }
 
+const struct drm_mode_config_funcs hibmc_mode_funcs = {
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+	.fb_create = hibmc_user_framebuffer_create,
+};
+
-- 
1.9.1
