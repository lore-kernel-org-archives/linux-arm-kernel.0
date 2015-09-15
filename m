From: kong.kongxinwei@hisilicon.com (Xinwei Kong)
Date: Tue, 15 Sep 2015 17:37:12 +0800
Subject: [PATCH RFC 6/8] drm: hisilicon: Add support for fbdev
In-Reply-To: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
Message-ID: <1442309834-21420-7-git-send-email-kong.kongxinwei@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If you config DRM_HISI_FBDEV optional, this patch will only support fbdev
mode while also supporting double buffer.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Jiwen Qi <qijiwen@hisilicon.com>
Signed-off-by: Yu Gong <gongyu@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/Kconfig              |  13 +
 drivers/gpu/drm/hisilicon/Makefile             |   3 +-
 drivers/gpu/drm/hisilicon/hisi_drm_connector.c |   4 +
 drivers/gpu/drm/hisilicon/hisi_drm_drv.c       |   9 +
 drivers/gpu/drm/hisilicon/hisi_drm_dsi.c       |  15 +
 drivers/gpu/drm/hisilicon/hisi_drm_fb.h        |   5 +
 drivers/gpu/drm/hisilicon/hisi_drm_fbdev.c     | 395 +++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hisi_drm_fbdev.h     |  24 ++
 8 files changed, 467 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_fbdev.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_fbdev.h

diff --git a/drivers/gpu/drm/hisilicon/Kconfig b/drivers/gpu/drm/hisilicon/Kconfig
index 105dbcb..ddf43d5 100644
--- a/drivers/gpu/drm/hisilicon/Kconfig
+++ b/drivers/gpu/drm/hisilicon/Kconfig
@@ -16,4 +16,17 @@ config DRM_HISI_HAS_SLAVE_ENCODER
 	  Support slave encoder output device such as DSI interface connecting
 	  HDMI converter by i2c.
 
+config DRM_HISI_FBDEV
+	bool "Enable legacy fbdev support"
+	select DRM_KMS_FB_HELPER
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
+	default y
+	help
+	  Choose this option if you have a need for the legacy fbdev support.
+	  Note that this support also provides the Linux console on top of
+	  the hisi modesetting driver.
+
 endif
diff --git a/drivers/gpu/drm/hisilicon/Makefile b/drivers/gpu/drm/hisilicon/Makefile
index aa522f8..1877d36 100644
--- a/drivers/gpu/drm/hisilicon/Makefile
+++ b/drivers/gpu/drm/hisilicon/Makefile
@@ -5,7 +5,8 @@ hisi-drm-y := hisi_drm_drv.o \
 	      hisi_drm_crtc.o \
 	      hisi_drm_encoder.o \
 	      hisi_drm_connector.o \
-	      hisi_drm_fb.o \
+	      hisi_drm_fb.o
 
 obj-$(CONFIG_DRM_HISI)	+= hisi-drm.o
+obj-$(CONFIG_DRM_HISI_FBDEV) += hisi_drm_fbdev.o
 
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_connector.c b/drivers/gpu/drm/hisilicon/hisi_drm_connector.c
index 57ab2e8..2359ed8 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_connector.c
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_connector.c
@@ -120,5 +120,9 @@ void hisi_drm_connector_init(struct drm_device *dev,
 	drm_connector_register(connector);
 	drm_mode_connector_attach_encoder(connector, encoder);
 
+#ifndef CONFIG_DRM_HISI_FBDEV
+	drm_reinit_primary_mode_group(dev);
+#endif
+
 	drm_mode_config_reset(dev);
 }
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_drv.c b/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
index 0983ad7..53f2521 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
@@ -17,6 +17,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 
+#include "hisi_drm_drv.h"
 #include "hisi_drm_fb.h"
 
 #define DRIVER_NAME	"hisi-drm"
@@ -49,11 +50,19 @@ static void hisi_drm_mode_config_init(struct drm_device *dev)
 
 static int hisi_drm_load(struct drm_device *dev, unsigned long flags)
 {
+	struct hisi_drm_private *priv;
 	int ret;
 
 	/* debug setting
 	drm_debug = DRM_UT_DRIVER|DRM_UT_KMS; */
 
+	priv = devm_kzalloc(dev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev->dev_private = priv;
+	dev_set_drvdata(dev->dev, dev);
+
 	/* dev->mode_config initialization */
 	drm_mode_config_init(dev);
 	hisi_drm_mode_config_init(dev);
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c b/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
index 8509ced..8329734 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
@@ -16,10 +16,14 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_encoder_slave.h>
+#include <drm/drm_fb_helper.h>
 
 #include "hisi_drm_encoder.h"
 #include "hisi_drm_connector.h"
 #include "hisi_dsi_reg.h"
+#ifdef CONFIG_DRM_HISI_FBDEV
+#include "hisi_drm_fbdev.h"
+#endif
 
 #define encoder_to_dsi(encoder) \
 	container_of(encoder, struct hisi_dsi, hisi_encoder.base.base)
@@ -699,6 +703,15 @@ static int hisi_dsi_bind(struct device *dev, struct device *master,
 	hisi_drm_connector_init(ctx->dev, &ctx->dsi.hisi_encoder.base.base,
 				&ctx->dsi.hisi_connector.connector);
 
+#ifdef CONFIG_DRM_HISI_FBDEV
+	/* fbdev initialization should be put at last position */
+	ret = hisi_drm_fbdev_init(ctx->dev);
+	if (ret) {
+		DRM_ERROR("failed to initialize fbdev\n");
+		return ret;
+	}
+#endif
+
 	return ret;
 }
 
@@ -780,6 +793,8 @@ static int hisi_dsi_probe(struct platform_device *pdev)
 	dsi->hisi_connector.encoder = &dsi->hisi_encoder.base.base;
 	dsi->hisi_connector.ops = &hisi_dsi_connector_ops;
 
+	platform_set_drvdata(pdev, ctx);
+
 	return component_add(&pdev->dev, &hisi_dsi_ops);
 }
 
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_fb.h b/drivers/gpu/drm/hisilicon/hisi_drm_fb.h
index 4bd168e..652a0a9 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_fb.h
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_fb.h
@@ -24,5 +24,10 @@ struct drm_framebuffer *hisi_drm_fb_create(struct drm_device *dev,
 					   struct drm_mode_fb_cmd2 *mode_cmd);
 struct drm_gem_cma_object *
 hisi_drm_fb_get_gem_obj(struct drm_framebuffer *fb, unsigned int plane);
+void hisi_drm_fb_destroy(struct drm_framebuffer *fb);
+struct hisi_drm_fb *
+hisi_drm_fb_alloc(struct drm_device *dev, struct drm_mode_fb_cmd2 *mode_cmd,
+		  struct drm_gem_cma_object **obj, unsigned int num_planes,
+		  bool is_fbdev_fb);
 
 #endif /* __HISI_DRM_FB_H__ */
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_fbdev.c b/drivers/gpu/drm/hisilicon/hisi_drm_fbdev.c
new file mode 100644
index 0000000..7d32b87
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_fbdev.c
@@ -0,0 +1,395 @@
+/*
+ * Hisilicon Terminal SoCs drm fbdev driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Author: z.liuxinliang at huawei.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+
+#include "hisi_drm_fb.h"
+#include "hisi_drm_fbdev.h"
+#include "hisi_drm_drv.h"
+
+#define PREFERRED_BPP		32
+#define HISI_NUM_FRAMEBUFFERS   2
+
+static inline
+struct hisi_drm_fbdev *to_hisi_drm_fbdev(struct drm_fb_helper *helper)
+{
+	return container_of(helper, struct hisi_drm_fbdev, fb_helper);
+}
+
+static int hisi_drm_fb_helper_check_var(struct fb_var_screeninfo *var,
+					struct fb_info *info)
+{
+	struct drm_fb_helper *fb_helper = info->par;
+	struct drm_framebuffer *fb = fb_helper->fb;
+	int depth;
+
+	if (var->pixclock != 0 || in_dbg_master())
+		return -EINVAL;
+
+	/* Need to resize the fb object !!! */
+	if (var->bits_per_pixel > fb->bits_per_pixel ||
+	    var->xres > fb->width || var->yres > fb->height ||
+	    var->xres_virtual > fb->width || var->yres_virtual > fb->height) {
+		DRM_ERROR("fb userspace request is greater than current fb");
+		return -EINVAL;
+	}
+
+	switch (var->bits_per_pixel) {
+	case 16:
+		depth = (var->green.length == 6) ? 16 : 15;
+		break;
+	case 32:
+		depth = (var->transp.length > 0) ? 32 : 24;
+		break;
+	default:
+		depth = var->bits_per_pixel;
+		break;
+	}
+
+	switch (depth) {
+	case 8:
+		var->red.offset = 0;
+		var->green.offset = 0;
+		var->blue.offset = 0;
+		var->red.length = 8;
+		var->green.length = 8;
+		var->blue.length = 8;
+		var->transp.length = 0;
+		var->transp.offset = 0;
+		break;
+	case 15:
+		var->red.offset = 10;
+		var->green.offset = 5;
+		var->blue.offset = 0;
+		var->red.length = 5;
+		var->green.length = 5;
+		var->blue.length = 5;
+		var->transp.length = 1;
+		var->transp.offset = 15;
+		break;
+	case 16:
+		var->red.offset = 11;
+		var->green.offset = 5;
+		var->blue.offset = 0;
+		var->red.length = 5;
+		var->green.length = 6;
+		var->blue.length = 5;
+		var->transp.length = 0;
+		var->transp.offset = 0;
+		break;
+	case 24:
+		var->red.offset = 16;
+		var->green.offset = 8;
+		var->blue.offset = 0;
+		var->red.length = 8;
+		var->green.length = 8;
+		var->blue.length = 8;
+		var->transp.length = 0;
+		var->transp.offset = 0;
+		break;
+	case 32: /* RGBA8888 */
+		var->red.offset = 0;
+		var->green.offset = 8;
+		var->blue.offset = 16;
+		var->red.length = 8;
+		var->green.length = 8;
+		var->blue.length = 8;
+		var->transp.length = 8;
+		var->transp.offset = 24;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void hisi_drm_fb_helper_fill_var(struct fb_info *info,
+					struct drm_fb_helper *fb_helper,
+					u32 fb_width, u32 fb_height)
+{
+	struct drm_framebuffer *fb = fb_helper->fb;
+
+	info->pseudo_palette = fb_helper->pseudo_palette;
+	info->var.xres_virtual = fb->width;
+	info->var.yres_virtual = fb->height;
+	info->var.bits_per_pixel = fb->bits_per_pixel;
+	info->var.accel_flags = FB_ACCELF_TEXT;
+	info->var.xoffset = 0;
+	info->var.yoffset = 0;
+	info->var.activate = FB_ACTIVATE_NOW;
+	info->var.height = -1;
+	info->var.width = -1;
+
+	switch (fb->depth) {
+	case 8:
+		info->var.red.offset = 0;
+		info->var.green.offset = 0;
+		info->var.blue.offset = 0;
+		info->var.red.length = 8; /* 8bit DAC */
+		info->var.green.length = 8;
+		info->var.blue.length = 8;
+		info->var.transp.offset = 0;
+		info->var.transp.length = 0;
+		break;
+	case 15:
+		info->var.red.offset = 10;
+		info->var.green.offset = 5;
+		info->var.blue.offset = 0;
+		info->var.red.length = 5;
+		info->var.green.length = 5;
+		info->var.blue.length = 5;
+		info->var.transp.offset = 15;
+		info->var.transp.length = 1;
+		break;
+	case 16:
+		info->var.red.offset = 11;
+		info->var.green.offset = 5;
+		info->var.blue.offset = 0;
+		info->var.red.length = 5;
+		info->var.green.length = 6;
+		info->var.blue.length = 5;
+		info->var.transp.offset = 0;
+		break;
+	case 24:
+		info->var.red.offset = 16;
+		info->var.green.offset = 8;
+		info->var.blue.offset = 0;
+		info->var.red.length = 8;
+		info->var.green.length = 8;
+		info->var.blue.length = 8;
+		info->var.transp.offset = 0;
+		info->var.transp.length = 0;
+		break;
+	case 32: /* RGBA8888 */
+		info->var.red.offset = 0;
+		info->var.green.offset = 8;
+		info->var.blue.offset = 16;
+		info->var.red.length = 8;
+		info->var.green.length = 8;
+		info->var.blue.length = 8;
+		info->var.transp.length = 8;
+		info->var.transp.offset = 24;
+		break;
+	default:
+		break;
+	}
+
+	info->var.xres = fb_width;
+	info->var.yres = fb_height;
+}
+
+static struct fb_ops hisi_drm_fbdev_ops = {
+	.owner		= THIS_MODULE,
+	.fb_fillrect	= sys_fillrect,
+	.fb_copyarea	= sys_copyarea,
+	.fb_imageblit	= sys_imageblit,
+	.fb_check_var	= hisi_drm_fb_helper_check_var,
+	.fb_set_par	= drm_fb_helper_set_par,
+	.fb_blank	= drm_fb_helper_blank,
+	.fb_pan_display	= drm_fb_helper_pan_display,
+	.fb_setcmap	= drm_fb_helper_setcmap,
+};
+
+static int hisi_drm_fbdev_probe(struct drm_fb_helper *helper,
+				struct drm_fb_helper_surface_size *sizes)
+{
+	struct hisi_drm_fbdev *fbdev = to_hisi_drm_fbdev(helper);
+	struct drm_mode_fb_cmd2 mode_cmd = { 0 };
+	struct drm_device *dev = helper->dev;
+	struct drm_gem_cma_object *obj;
+	struct drm_framebuffer *fb;
+	unsigned int bytes_per_pixel;
+	unsigned long offset;
+	struct fb_info *fbi;
+	size_t size;
+	int ret;
+
+	/* TODO: Need to use ion heaps to create frame buffer?? */
+	bytes_per_pixel = DIV_ROUND_UP(sizes->surface_bpp, 8);
+	sizes->surface_depth = PREFERRED_BPP;
+
+	mode_cmd.width = sizes->surface_width;
+	mode_cmd.height = sizes->surface_height * HISI_NUM_FRAMEBUFFERS;
+	mode_cmd.pitches[0] = sizes->surface_width * bytes_per_pixel;
+	mode_cmd.pixel_format = DRM_FORMAT_ARGB8888;
+
+	size = roundup(mode_cmd.pitches[0] * mode_cmd.height, PAGE_SIZE);
+	obj = drm_gem_cma_create(dev, size);
+	if (IS_ERR(obj))
+		return -ENOMEM;
+
+	fbi = framebuffer_alloc(0, dev->dev);
+	if (!fbi) {
+		dev_err(dev->dev, "Failed to allocate framebuffer info.\n");
+		ret = -ENOMEM;
+		goto err_drm_gem_cma_free_object;
+	}
+
+	fbdev->fb = hisi_drm_fb_alloc(dev, &mode_cmd, &obj, 1, true);
+	if (IS_ERR(fbdev->fb)) {
+		dev_err(dev->dev, "Failed to allocate DRM framebuffer.\n");
+		ret = PTR_ERR(fbdev->fb);
+		goto err_framebuffer_release;
+	}
+
+	fb = &fbdev->fb->fb;
+	helper->fb = fb;
+	helper->fbdev = fbi;
+
+	fbi->par = helper;
+	fbi->flags = FBINFO_FLAG_DEFAULT;
+	fbi->fbops = &hisi_drm_fbdev_ops;
+
+	ret = fb_alloc_cmap(&fbi->cmap, 256, 0);
+	if (ret) {
+		dev_err(dev->dev, "Failed to allocate color map.\n");
+		goto err_hisi_drm_fb_destroy;
+	}
+
+	drm_fb_helper_fill_fix(fbi, fb->pitches[0], fb->depth);
+	hisi_drm_fb_helper_fill_var(fbi, helper, fb->width,
+				    fb->height / HISI_NUM_FRAMEBUFFERS);
+
+	offset = fbi->var.xoffset * bytes_per_pixel;
+	offset += fbi->var.yoffset * fb->pitches[0];
+
+	dev->mode_config.fb_base = (resource_size_t)obj->paddr;
+	fbi->screen_base = obj->vaddr + offset;
+	fbi->fix.smem_start = (unsigned long)(obj->paddr + offset);
+	fbi->screen_size = size;
+	fbi->fix.smem_len = size;
+
+	return 0;
+
+err_hisi_drm_fb_destroy:
+	drm_framebuffer_unregister_private(fb);
+	hisi_drm_fb_destroy(fb);
+err_framebuffer_release:
+	framebuffer_release(fbi);
+err_drm_gem_cma_free_object:
+	drm_gem_cma_free_object(&obj->base);
+
+	return ret;
+}
+
+static const struct drm_fb_helper_funcs hisi_fb_helper_funcs = {
+	.fb_probe = hisi_drm_fbdev_probe,
+};
+
+static struct hisi_drm_fbdev *hisi_drm_fbdev_create(struct drm_device *dev,
+						    unsigned int preferred_bpp,
+						    unsigned int num_crtc,
+						    unsigned int max_con_count)
+{
+	struct hisi_drm_fbdev *fbdev;
+	struct drm_fb_helper *helper;
+	int ret;
+
+	fbdev = kzalloc(sizeof(*fbdev), GFP_KERNEL);
+	if (!fbdev)
+		return ERR_PTR(-ENOMEM);
+
+	helper = &fbdev->fb_helper;
+
+	drm_fb_helper_prepare(dev, helper, &hisi_fb_helper_funcs);
+
+	ret = drm_fb_helper_init(dev, helper, num_crtc, max_con_count);
+	if (ret < 0) {
+		dev_err(dev->dev, "Failed to initialize drm fb helper.\n");
+		goto err_free;
+	}
+
+	ret = drm_fb_helper_single_add_all_connectors(helper);
+	if (ret < 0) {
+		dev_err(dev->dev, "Failed to add connectors.\n");
+		goto err_drm_fb_helper_fini;
+	}
+
+	/* disable all the possible outputs/crtcs before entering KMS mode */
+	drm_helper_disable_unused_functions(dev);
+
+	ret = drm_fb_helper_initial_config(helper, preferred_bpp);
+	if (ret < 0) {
+		dev_err(dev->dev, "Failed to set initial hw configuration.\n");
+		goto err_drm_fb_helper_fini;
+	}
+
+	return fbdev;
+
+err_drm_fb_helper_fini:
+	drm_fb_helper_fini(helper);
+err_free:
+	kfree(fbdev);
+
+	return ERR_PTR(ret);
+}
+
+static void hisi_drm_fbdev_fini(struct hisi_drm_fbdev *fbdev)
+{
+	if (fbdev->fb_helper.fbdev) {
+		struct fb_info *info;
+		int ret;
+
+		info = fbdev->fb_helper.fbdev;
+		ret = unregister_framebuffer(info);
+		if (ret < 0)
+			DRM_DEBUG_KMS("failed to unregister framebuffe\n");
+
+		if (info->cmap.len)
+			fb_dealloc_cmap(&info->cmap);
+
+		framebuffer_release(info);
+	}
+
+	if (fbdev->fb) {
+		drm_framebuffer_unregister_private(&fbdev->fb->fb);
+		hisi_drm_fb_destroy(&fbdev->fb->fb);
+	}
+
+	drm_fb_helper_fini(&fbdev->fb_helper);
+	kfree(fbdev);
+}
+
+/**
+ * hisi_drm_fbdev_init - create and init hisi_drm_fbdev
+ * @dev: The drm_device struct
+ */
+int hisi_drm_fbdev_init(struct drm_device *dev)
+{
+	struct hisi_drm_private *private = dev->dev_private;
+
+	private->fbdev = hisi_drm_fbdev_create(dev, PREFERRED_BPP,
+			dev->mode_config.num_crtc,
+			dev->mode_config.num_connector);
+	if (IS_ERR(private->fbdev))
+		return PTR_ERR(private->fbdev);
+
+	return 0;
+}
+
+/*
+ * hisi_drm_fbdev_exit - Free hisi_drm_fbdev struct
+ * @dev: The drm_device struct
+ */
+void hisi_drm_fbdev_exit(struct drm_device *dev)
+{
+	struct hisi_drm_private *private = dev->dev_private;
+
+	if (private->fbdev) {
+		hisi_drm_fbdev_fini(private->fbdev);
+		private->fbdev = NULL;
+	}
+}
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_fbdev.h b/drivers/gpu/drm/hisilicon/hisi_drm_fbdev.h
new file mode 100644
index 0000000..f6a8a68
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_fbdev.h
@@ -0,0 +1,24 @@
+/*
+ * Hisilicon Terminal SoCs drm driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Author:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __HISI_DRM_FBDEV_H__
+#define __HISI_DRM_FBDEV_H__
+
+struct hisi_drm_fbdev {
+	struct drm_fb_helper	fb_helper;
+	struct hisi_drm_fb	*fb;
+};
+
+int hisi_drm_fbdev_init(struct drm_device *dev);
+void hisi_drm_fbdev_exit(struct drm_device *dev);
+
+#endif /* __HISI_DRM_FBDEV_H__ */
-- 
1.9.1
