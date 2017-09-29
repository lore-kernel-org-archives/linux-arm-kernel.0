From: ulrich.hecht+renesas@gmail.com (Ulrich Hecht)
Date: Fri, 29 Sep 2017 15:09:11 +0200
Subject: [RFC 09/11] drm/mediatek: add fbdev support
In-Reply-To: <1506690553-27357-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1506690553-27357-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <1506690553-27357-10-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forward-ported from chromeos-3.18 vendor kernel.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/gpu/drm/mediatek/Makefile        |   2 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c   |   9 ++
 drivers/gpu/drm/mediatek/mtk_drm_drv.h   |   4 +-
 drivers/gpu/drm/mediatek/mtk_drm_fb.c    |  13 +++
 drivers/gpu/drm/mediatek/mtk_drm_fb.h    |   3 +
 drivers/gpu/drm/mediatek/mtk_drm_fbdev.c | 184 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_fbdev.h |  32 ++++++
 7 files changed, 246 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_drm_fbdev.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_drm_fbdev.h

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index e37b55a..8306fb5 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -12,6 +12,8 @@ mediatek-drm-y := mtk_disp_color.o \
 		  mtk_mipi_tx.o \
 		  mtk_dpi.o
 
+mediatek-drm-$(CONFIG_DRM_FBDEV_EMULATION) += mtk_drm_fbdev.o
+
 obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
 
 mediatek-drm-hdmi-objs := mtk_cec.o \
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 8c92630..a69aa2f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -30,6 +30,7 @@
 #include "mtk_drm_ddp_comp.h"
 #include "mtk_drm_drv.h"
 #include "mtk_drm_fb.h"
+#include "mtk_drm_fbdev.h"
 #include "mtk_drm_gem.h"
 
 #define DRIVER_NAME "mediatek"
@@ -257,8 +258,15 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	drm_kms_helper_poll_init(drm);
 	drm_mode_config_reset(drm);
 
+	ret = mtk_fbdev_init(drm);
+	if (ret)
+		goto err_kms_helper_poll_fini;
+
 	return 0;
 
+err_kms_helper_poll_fini:
+	drm_kms_helper_poll_fini(drm);
+//	drm_vblank_cleanup(drm);
 err_component_unbind:
 	component_unbind_all(drm->dev, drm);
 err_config_cleanup:
@@ -269,6 +277,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 
 static void mtk_drm_kms_deinit(struct drm_device *drm)
 {
+	mtk_fbdev_fini(drm);
 	drm_kms_helper_poll_fini(drm);
 
 	component_unbind_all(drm->dev, drm);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index c3378c4..4edc002 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -14,6 +14,7 @@
 #ifndef MTK_DRM_DRV_H
 #define MTK_DRM_DRV_H
 
+#include <drm/drm_fb_helper.h>
 #include <linux/io.h>
 #include "mtk_drm_ddp_comp.h"
 
@@ -24,7 +25,6 @@ struct device;
 struct device_node;
 struct drm_crtc;
 struct drm_device;
-struct drm_fb_helper;
 struct drm_property;
 struct regmap;
 
@@ -56,6 +56,8 @@ struct mtk_drm_private {
 	} commit;
 
 	struct drm_atomic_state *suspend_state;
+	struct drm_fb_helper fb_helper;
+	struct drm_gem_object *fbdev_bo;
 };
 
 extern struct platform_driver mtk_ddp_driver;
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fb.c b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
index 0d8d506..ac8561d 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_fb.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
@@ -96,6 +96,19 @@ static struct mtk_drm_fb *mtk_drm_framebuffer_init(struct drm_device *dev,
 	return mtk_fb;
 }
 
+struct drm_framebuffer *mtk_drm_framebuffer_create(struct drm_device *dev,
+		const struct drm_mode_fb_cmd2 *mode,
+		struct drm_gem_object *obj)
+{
+	struct mtk_drm_fb *mtk_fb;
+
+	mtk_fb = mtk_drm_framebuffer_init(dev, mode, obj);
+	if (IS_ERR(mtk_fb))
+		return ERR_CAST(mtk_fb);
+
+	return &mtk_fb->base;
+}
+
 /*
  * Wait for any exclusive fence in fb's gem object's reservation object.
  *
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fb.h b/drivers/gpu/drm/mediatek/mtk_drm_fb.h
index 9b2ae34..9ee1ac2 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_fb.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_fb.h
@@ -19,5 +19,8 @@ int mtk_fb_wait(struct drm_framebuffer *fb);
 struct drm_framebuffer *mtk_drm_mode_fb_create(struct drm_device *dev,
 					       struct drm_file *file,
 					       const struct drm_mode_fb_cmd2 *cmd);
+struct drm_framebuffer *mtk_drm_framebuffer_create(struct drm_device *dev,
+		const struct drm_mode_fb_cmd2 *mode,
+		struct drm_gem_object *obj);
 
 #endif /* MTK_DRM_FB_H */
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fbdev.c b/drivers/gpu/drm/mediatek/mtk_drm_fbdev.c
new file mode 100644
index 0000000..1e46216
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_drm_fbdev.c
@@ -0,0 +1,184 @@
+/*
+ * Copyright (c) 2016 MediaTek Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_gem.h>
+
+#include "mtk_drm_drv.h"
+#include "mtk_drm_fb.h"
+#include "mtk_drm_gem.h"
+
+#define to_drm_private(x) \
+		container_of(x, struct mtk_drm_private, fb_helper)
+
+#if 1
+static int mtk_drm_fbdev_mmap(struct fb_info *info, struct vm_area_struct *vma)
+{
+	struct drm_fb_helper *helper = info->par;
+	struct mtk_drm_private *private = helper->dev->dev_private;//to_drm_private(helper);
+
+	return mtk_drm_gem_mmap_buf(private->fbdev_bo, vma);
+}
+#endif
+
+static struct fb_ops mtk_fbdev_ops = {
+	.owner = THIS_MODULE,
+	.fb_fillrect = drm_fb_helper_cfb_fillrect,
+	.fb_copyarea = drm_fb_helper_cfb_copyarea,
+	.fb_imageblit = drm_fb_helper_cfb_imageblit,
+	.fb_check_var = drm_fb_helper_check_var,
+	.fb_set_par = drm_fb_helper_set_par,
+	.fb_blank = drm_fb_helper_blank,
+	.fb_pan_display = drm_fb_helper_pan_display,
+	.fb_setcmap = drm_fb_helper_setcmap,
+	.fb_mmap = mtk_drm_fbdev_mmap,
+};
+
+static int mtk_fbdev_probe(struct drm_fb_helper *helper,
+			   struct drm_fb_helper_surface_size *sizes)
+{
+	struct drm_device *dev = helper->dev;
+	struct mtk_drm_private *private = helper->dev->dev_private;//to_drm_private(helper);
+	struct drm_mode_fb_cmd2 mode = { 0 };
+	struct mtk_drm_gem_obj *mtk_gem;
+	struct fb_info *info;
+	struct drm_framebuffer *fb;
+	unsigned int bytes_per_pixel;
+	unsigned long offset;
+	size_t size;
+	int err;
+
+	bytes_per_pixel = DIV_ROUND_UP(sizes->surface_bpp, 8);
+
+	mode.width = sizes->surface_width;
+	mode.height = sizes->surface_height;
+	mode.pitches[0] = sizes->surface_width * bytes_per_pixel;
+	mode.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
+						      sizes->surface_depth);
+
+	size = mode.pitches[0] * mode.height;
+
+	mtk_gem = mtk_drm_gem_create(dev, size, true);
+	if (IS_ERR(mtk_gem))
+		return PTR_ERR(mtk_gem);
+
+	private->fbdev_bo = &mtk_gem->base;
+
+	info = drm_fb_helper_alloc_fbi(helper);
+	if (IS_ERR(info)) {
+		err = PTR_ERR(info);
+		dev_err(dev->dev, "failed to allocate framebuffer info, %d\n",
+			err);
+		goto err_gem_free_object;
+	}
+
+	fb = mtk_drm_framebuffer_create(dev, &mode, private->fbdev_bo);
+	if (IS_ERR(fb)) {
+		err = PTR_ERR(fb);
+		dev_err(dev->dev, "failed to allocate DRM framebuffer, %d\n",
+			err);
+		goto err_release_fbi;
+	}
+	helper->fb = fb;
+
+	info->par = helper;
+	info->flags = FBINFO_FLAG_DEFAULT;
+	info->fbops = &mtk_fbdev_ops;
+
+	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
+	drm_fb_helper_fill_var(info, helper, sizes->fb_width, sizes->fb_height);
+
+	offset = info->var.xoffset * bytes_per_pixel;
+	offset += info->var.yoffset * fb->pitches[0];
+
+	dev->mode_config.fb_base = 0;
+	info->screen_base = mtk_gem->kvaddr + offset;
+	info->screen_size = size;
+	info->fix.smem_len = size;
+
+	DRM_DEBUG_KMS("FB [%ux%u]-%u offset=%lu size=%zd\n",
+		      fb->width, fb->height, fb->format->depth, offset, size);
+
+	info->skip_vt_switch = true;
+
+	return 0;
+
+err_release_fbi:
+err_gem_free_object:
+	mtk_drm_gem_free_object(&mtk_gem->base);
+	return err;
+}
+
+static const struct drm_fb_helper_funcs mtk_drm_fb_helper_funcs = {
+	.fb_probe = mtk_fbdev_probe,
+};
+
+int mtk_fbdev_init(struct drm_device *dev)
+{
+	struct mtk_drm_private *priv = dev->dev_private;
+	struct drm_fb_helper *helper = &priv->fb_helper;
+	int ret;
+
+	if (!dev->mode_config.num_crtc || !dev->mode_config.num_connector)
+		return -EINVAL;
+
+	drm_fb_helper_prepare(dev, helper, &mtk_drm_fb_helper_funcs);
+
+	ret = drm_fb_helper_init(dev, helper, /*dev->mode_config.num_crtc,*/
+				 dev->mode_config.num_connector);
+	if (ret) {
+		dev_err(dev->dev, "failed to initialize DRM FB helper, %d\n",
+			ret);
+		goto fini;
+	}
+
+	ret = drm_fb_helper_single_add_all_connectors(helper);
+	if (ret) {
+		dev_err(dev->dev, "failed to add connectors, %d\n", ret);
+		goto fini;
+	}
+
+	/* disable all the possible outputs/crtcs before entering KMS mode */
+//	drm_helper_disable_unused_functions(dev);
+
+	ret = drm_fb_helper_initial_config(helper, 32);
+	if (ret) {
+		dev_err(dev->dev, "failed to set initial configuration, %d\n",
+			ret);
+		goto fini;
+	}
+
+	return 0;
+
+fini:
+	drm_fb_helper_fini(helper);
+
+	return ret;
+}
+
+void mtk_fbdev_fini(struct drm_device *dev)
+{
+	struct mtk_drm_private *priv = dev->dev_private;
+	struct drm_fb_helper *helper = &priv->fb_helper;
+
+	drm_fb_helper_unregister_fbi(helper);
+
+	if (helper->fb) {
+		drm_framebuffer_unregister_private(helper->fb);
+		drm_framebuffer_remove(helper->fb);
+	}
+
+	drm_fb_helper_fini(helper);
+}
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fbdev.h b/drivers/gpu/drm/mediatek/mtk_drm_fbdev.h
new file mode 100644
index 0000000..f3e0949
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_drm_fbdev.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (c) 2016 MediaTek Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef MTK_DRM_FBDEV_H
+#define MTK_DRM_FBDEV_H
+
+#ifdef CONFIG_DRM_FBDEV_EMULATION
+int mtk_fbdev_init(struct drm_device *dev);
+void mtk_fbdev_fini(struct drm_device *dev);
+#else
+int mtk_fbdev_init(struct drm_device *dev)
+{
+	return 0;
+}
+
+void mtk_fbdev_fini(struct drm_device *dev)
+{
+
+}
+#endif /* CONFIG_DRM_FBDEV_EMULATION */
+
+#endif /* MTK_DRM_FBDEV_H */
-- 
2.7.4
