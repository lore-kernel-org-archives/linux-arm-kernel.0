From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed,  5 Aug 2015 15:28:10 +0100
Subject: [PATCH 2/4] drm: Add support for ARM's HDLCD controller.
In-Reply-To: <1438784892-27888-1-git-send-email-Liviu.Dudau@arm.com>
References: <1438784892-27888-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1438784892-27888-3-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HDLCD controller is a display controller that supports resolutions
up to 4096x4096 pixels. It is present on various development boards
produced by ARM Ltd and emulated by the latest Fast Models from the
company.

Cc: David Airlie <airlied@linux.ie>
Cc: Robin Murphy <robin.murphy@arm.com>

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/gpu/drm/Kconfig          |   2 +
 drivers/gpu/drm/Makefile         |   1 +
 drivers/gpu/drm/arm/Kconfig      |  20 ++
 drivers/gpu/drm/arm/Makefile     |   2 +
 drivers/gpu/drm/arm/hdlcd_crtc.c | 265 +++++++++++++++++++++
 drivers/gpu/drm/arm/hdlcd_drv.c  | 490 +++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/arm/hdlcd_drv.h  |  51 ++++
 drivers/gpu/drm/arm/hdlcd_regs.h |  87 +++++++
 8 files changed, 918 insertions(+)
 create mode 100644 drivers/gpu/drm/arm/Kconfig
 create mode 100644 drivers/gpu/drm/arm/Makefile
 create mode 100644 drivers/gpu/drm/arm/hdlcd_crtc.c
 create mode 100644 drivers/gpu/drm/arm/hdlcd_drv.c
 create mode 100644 drivers/gpu/drm/arm/hdlcd_drv.h
 create mode 100644 drivers/gpu/drm/arm/hdlcd_regs.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index c46ca31..f819db0 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -88,6 +88,8 @@ config DRM_TDFX
 	  Choose this option if you have a 3dfx Banshee or Voodoo3 (or later),
 	  graphics card.  If M is selected, the module will be called tdfx.
 
+source "drivers/gpu/drm/arm/Kconfig"
+
 config DRM_R128
 	tristate "ATI Rage 128"
 	depends on DRM && PCI
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 5713d05..2ce474e 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -32,6 +32,7 @@ CFLAGS_drm_trace_points.o := -I$(src)
 
 obj-$(CONFIG_DRM)	+= drm.o
 obj-$(CONFIG_DRM_MIPI_DSI) += drm_mipi_dsi.o
+obj-$(CONFIG_DRM_ARM)	+= arm/
 obj-$(CONFIG_DRM_TTM)	+= ttm/
 obj-$(CONFIG_DRM_TDFX)	+= tdfx/
 obj-$(CONFIG_DRM_R128)	+= r128/
diff --git a/drivers/gpu/drm/arm/Kconfig b/drivers/gpu/drm/arm/Kconfig
new file mode 100644
index 0000000..9590d8e
--- /dev/null
+++ b/drivers/gpu/drm/arm/Kconfig
@@ -0,0 +1,20 @@
+config DRM_ARM
+	bool "ARM Ltd. drivers"
+	depends on DRM && OF && (ARM || ARM64)
+	select DMA_CMA
+	select DRM_KMS_HELPER
+	select DRM_KMS_CMA_HELPER
+	select DRM_GEM_CMA_HELPER
+	help
+	  Choose this option to select drivers for ARM's devices
+
+config DRM_HDLCD
+	tristate "ARM HDLCD"
+	depends on DRM_ARM
+	depends on COMMON_CLK
+	select COMMON_CLK_SCPI
+	help
+	  Choose this option if you have an ARM High Definition Colour LCD
+	  controller.
+
+	  If M is selected the module will be called hdlcd.
diff --git a/drivers/gpu/drm/arm/Makefile b/drivers/gpu/drm/arm/Makefile
new file mode 100644
index 0000000..89dcb7b
--- /dev/null
+++ b/drivers/gpu/drm/arm/Makefile
@@ -0,0 +1,2 @@
+hdlcd-y := hdlcd_drv.o hdlcd_crtc.o
+obj-$(CONFIG_DRM_HDLCD)	+= hdlcd.o
diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
new file mode 100644
index 0000000..8081238
--- /dev/null
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -0,0 +1,265 @@
+/*
+ * Copyright (C) 2013-2015 ARM Limited
+ * Author: Liviu Dudau <Liviu.Dudau@arm.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ *
+ *  Implementation of a CRTC class for the HDLCD driver.
+ */
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_of.h>
+#include <drm/drm_plane_helper.h>
+#include <linux/clk.h>
+#include <linux/of_graph.h>
+#include <linux/platform_data/simplefb.h>
+
+#include "hdlcd_drv.h"
+#include "hdlcd_regs.h"
+
+/*
+ * The HDLCD controller is a dumb RGB streamer that gets connected to
+ * a single HDMI transmitter or in the case of the ARM Models it gets
+ * emulated by the software that does the actual rendering.
+ *
+ */
+static void hdlcd_crtc_destroy(struct drm_crtc *crtc)
+{
+	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
+
+	of_node_put(hdlcd->crtc.port);
+	drm_crtc_cleanup(crtc);
+}
+
+void hdlcd_set_scanout(struct hdlcd_drm_private *hdlcd)
+{
+	struct drm_framebuffer *fb = hdlcd->crtc.primary->fb;
+	struct drm_gem_cma_object *gem;
+	unsigned int depth, bpp;
+	dma_addr_t scanout_start;
+
+	drm_fb_get_bpp_depth(fb->pixel_format, &depth, &bpp);
+	gem = drm_fb_cma_get_gem_obj(fb, 0);
+
+	scanout_start = gem->paddr + fb->offsets[0] +
+		(hdlcd->crtc.y * fb->pitches[0]) + (hdlcd->crtc.x * bpp/8);
+
+	hdlcd_write(hdlcd, HDLCD_REG_FB_BASE, scanout_start);
+}
+
+static int hdlcd_crtc_page_flip(struct drm_crtc *crtc,
+			struct drm_framebuffer *fb,
+			struct drm_pending_vblank_event *event,
+			uint32_t flags)
+{
+	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
+
+	if (hdlcd->dpms == DRM_MODE_DPMS_ON) {
+		/* don't schedule any page flipping if one is in progress */
+		if (hdlcd->event)
+			return -EBUSY;
+
+		hdlcd->event = event;
+		drm_vblank_get(crtc->dev, 0);
+	}
+
+	crtc->primary->fb = fb;
+
+	if (hdlcd->dpms != DRM_MODE_DPMS_ON) {
+		unsigned long flags;
+
+		/* not active, update registers immediately */
+		hdlcd_set_scanout(hdlcd);
+		spin_lock_irqsave(&crtc->dev->event_lock, flags);
+		if (event)
+			drm_send_vblank_event(crtc->dev, 0, event);
+		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
+	}
+
+	return 0;
+}
+
+static const struct drm_crtc_funcs hdlcd_crtc_funcs = {
+	.destroy	= hdlcd_crtc_destroy,
+	.set_config	= drm_crtc_helper_set_config,
+	.page_flip	= hdlcd_crtc_page_flip,
+};
+
+static void hdlcd_crtc_dpms(struct drm_crtc *crtc, int mode)
+{
+	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
+
+	hdlcd->dpms = mode;
+	if (mode == DRM_MODE_DPMS_ON)
+		hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 1);
+	else
+		hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 0);
+}
+
+static bool hdlcd_crtc_mode_fixup(struct drm_crtc *crtc,
+			const struct drm_display_mode *mode,
+			struct drm_display_mode *adjusted_mode)
+{
+	return true;
+}
+
+static void hdlcd_crtc_prepare(struct drm_crtc *crtc)
+{
+	hdlcd_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
+}
+
+static void hdlcd_crtc_commit(struct drm_crtc *crtc)
+{
+	drm_vblank_post_modeset(crtc->dev, 0);
+	hdlcd_crtc_dpms(crtc, DRM_MODE_DPMS_ON);
+}
+
+static struct simplefb_format supported_formats[] = SIMPLEFB_FORMATS;
+
+static int hdlcd_crtc_colour_set(struct hdlcd_drm_private *hdlcd,
+				uint32_t pixel_format)
+{
+	unsigned int depth, bpp;
+	unsigned int default_color = 0x00000000;
+	struct simplefb_format *format = NULL;
+	int i;
+
+#ifdef HDLCD_SHOW_UNDERRUN
+	default_color = 0x00ff0000;	/* show underruns in red */
+#endif
+
+	/* Calculate each colour's number of bits */
+	drm_fb_get_bpp_depth(pixel_format, &depth, &bpp);
+
+	for (i = 0; i < ARRAY_SIZE(supported_formats); i++) {
+		if (supported_formats[i].fourcc == pixel_format)
+			format = &supported_formats[i];
+	}
+
+	if (!format) {
+		DRM_ERROR("Format not supported: 0x%x\n", pixel_format);
+		return -EINVAL;
+	}
+
+	/* HDLCD uses 'bytes per pixel' */
+	bpp = (bpp + 7) / 8;
+	hdlcd_write(hdlcd, HDLCD_REG_PIXEL_FORMAT, (bpp - 1) << 3);
+
+	/*
+	 * The format of the HDLCD_REG_<color>_SELECT register is:
+	 *   - bits[23:16] - default value for that color component
+	 *   - bits[11:8]  - number of bits to extract for each color component
+	 *   - bits[4:0]   - index of the lowest bit to extract
+	 *
+	 * The default color value is used when bits[11:8] read zero, when the
+	 * pixel is outside the visible frame area or when there is a
+	 * buffer underrun.
+	 */
+	hdlcd_write(hdlcd, HDLCD_REG_RED_SELECT, default_color |
+		format->red.offset | (format->red.length & 0xf) << 8);
+	hdlcd_write(hdlcd, HDLCD_REG_GREEN_SELECT, default_color |
+		format->green.offset | (format->green.length & 0xf) << 8);
+	hdlcd_write(hdlcd, HDLCD_REG_BLUE_SELECT, default_color |
+		format->blue.offset | (format->blue.length & 0xf) << 8);
+
+	return 0;
+}
+
+static int hdlcd_crtc_mode_set(struct drm_crtc *crtc,
+			struct drm_display_mode *mode,
+			struct drm_display_mode *adjusted_mode,
+			int x, int y, struct drm_framebuffer *oldfb)
+{
+	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
+	unsigned int depth, bpp, polarities, line_length, err;
+
+	drm_vblank_pre_modeset(crtc->dev, 0);
+
+	polarities = HDLCD_POLARITY_DATAEN | HDLCD_POLARITY_DATA;
+
+	if (adjusted_mode->flags & DRM_MODE_FLAG_PHSYNC)
+		polarities |= HDLCD_POLARITY_HSYNC;
+	if (adjusted_mode->flags & DRM_MODE_FLAG_PVSYNC)
+		polarities |= HDLCD_POLARITY_VSYNC;
+
+	drm_fb_get_bpp_depth(crtc->primary->fb->pixel_format, &depth, &bpp);
+	/* switch to the more useful 'bytes per pixel' HDLCD needs */
+	bpp = (bpp + 7) / 8;
+	line_length = crtc->primary->fb->width * bpp;
+
+	/* Allow max number of outstanding requests and largest burst size */
+	hdlcd_write(hdlcd, HDLCD_REG_BUS_OPTIONS,
+		    HDLCD_BUS_MAX_OUTSTAND | HDLCD_BUS_BURST_16);
+
+	hdlcd_write(hdlcd, HDLCD_REG_FB_LINE_LENGTH, line_length);
+	hdlcd_write(hdlcd, HDLCD_REG_FB_LINE_COUNT,
+				crtc->primary->fb->height - 1);
+	hdlcd_write(hdlcd, HDLCD_REG_FB_LINE_PITCH, line_length);
+	hdlcd_write(hdlcd, HDLCD_REG_V_BACK_PORCH,
+				mode->vtotal - mode->vsync_end - 1);
+	hdlcd_write(hdlcd, HDLCD_REG_V_FRONT_PORCH,
+				mode->vsync_start - mode->vdisplay - 1);
+	hdlcd_write(hdlcd, HDLCD_REG_V_SYNC,
+				mode->vsync_end - mode->vsync_start - 1);
+	hdlcd_write(hdlcd, HDLCD_REG_V_DATA, mode->vdisplay - 1);
+	hdlcd_write(hdlcd, HDLCD_REG_H_BACK_PORCH,
+				mode->htotal - mode->hsync_end - 1);
+	hdlcd_write(hdlcd, HDLCD_REG_H_FRONT_PORCH,
+				mode->hsync_start - mode->hdisplay - 1);
+	hdlcd_write(hdlcd, HDLCD_REG_H_SYNC,
+				mode->hsync_end - mode->hsync_start - 1);
+	hdlcd_write(hdlcd, HDLCD_REG_H_DATA, mode->hdisplay - 1);
+	hdlcd_write(hdlcd, HDLCD_REG_POLARITIES, polarities);
+
+	err = hdlcd_crtc_colour_set(hdlcd, crtc->primary->fb->pixel_format);
+	if (err)
+		return err;
+
+	clk_prepare(hdlcd->clk);
+	clk_set_rate(hdlcd->clk, mode->crtc_clock * 1000);
+	clk_enable(hdlcd->clk);
+
+	hdlcd_set_scanout(hdlcd);
+
+	return 0;
+}
+
+static void hdlcd_crtc_load_lut(struct drm_crtc *crtc)
+{
+}
+
+static const struct drm_crtc_helper_funcs hdlcd_crtc_helper_funcs = {
+	.dpms		= hdlcd_crtc_dpms,
+	.mode_fixup	= hdlcd_crtc_mode_fixup,
+	.prepare	= hdlcd_crtc_prepare,
+	.commit		= hdlcd_crtc_commit,
+	.mode_set	= hdlcd_crtc_mode_set,
+	.load_lut	= hdlcd_crtc_load_lut,
+};
+
+int hdlcd_setup_crtc(struct drm_device *dev)
+{
+	struct hdlcd_drm_private *hdlcd = dev->dev_private;
+	int ret;
+
+	hdlcd->crtc.port = of_graph_get_next_endpoint(dev->platformdev->dev.of_node, NULL);
+	if (!hdlcd->crtc.port)
+		return -ENXIO;
+
+	ret = drm_crtc_init(dev, &hdlcd->crtc, &hdlcd_crtc_funcs);
+	if (ret < 0) {
+		of_node_put(hdlcd->crtc.port);
+		return ret;
+	}
+
+	drm_crtc_helper_add(&hdlcd->crtc, &hdlcd_crtc_helper_funcs);
+	return 0;
+}
+
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
new file mode 100644
index 0000000..322a429
--- /dev/null
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -0,0 +1,490 @@
+/*
+ * Copyright (C) 2013-2015 ARM Limited
+ * Author: Liviu Dudau <Liviu.Dudau@arm.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ *
+ *  ARM HDLCD Driver
+ */
+
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/of_graph.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_of.h>
+
+#include "hdlcd_drv.h"
+#include "hdlcd_regs.h"
+
+static void hdlcd_setup_mode_config(struct drm_device *dev);
+
+static int compare_dev(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static int hdlcd_unload(struct drm_device *dev)
+{
+	struct hdlcd_drm_private *hdlcd = dev->dev_private;
+
+	drm_kms_helper_poll_fini(dev);
+	if (hdlcd->fbdev)
+		drm_fbdev_cma_fini(hdlcd->fbdev);
+
+	component_unbind_all(dev->dev, dev);
+
+	drm_vblank_cleanup(dev);
+	drm_mode_config_cleanup(dev);
+
+	drm_irq_uninstall(dev);
+
+	if (!IS_ERR(hdlcd->clk))
+		clk_put(hdlcd->clk);
+
+	dma_release_declared_memory(dev->dev);
+	platform_set_drvdata(dev->platformdev, NULL);
+	dev->dev_private = NULL;
+
+	return 0;
+}
+
+static int hdlcd_load(struct drm_device *dev, unsigned long flags)
+{
+	struct platform_device *pdev = dev->platformdev;
+	struct hdlcd_drm_private *hdlcd;
+	struct resource *res;
+	u32 version;
+	int ret;
+
+	hdlcd = devm_kzalloc(dev->dev, sizeof(*hdlcd), GFP_KERNEL);
+	if (!hdlcd)
+		return -ENOMEM;
+
+#ifdef CONFIG_DEBUG_FS
+	atomic_set(&hdlcd->buffer_underrun_count, 0);
+	atomic_set(&hdlcd->bus_error_count, 0);
+	atomic_set(&hdlcd->vsync_count, 0);
+	atomic_set(&hdlcd->dma_end_count, 0);
+#endif
+	platform_set_drvdata(pdev, dev);
+	dev->dev_private = hdlcd;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hdlcd->mmio = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(hdlcd->mmio)) {
+		DRM_ERROR("failed to map control registers area\n");
+		ret = PTR_ERR(hdlcd->mmio);
+		goto fail;
+	}
+
+	version = hdlcd_read(hdlcd, HDLCD_REG_VERSION);
+	if ((version & HDLCD_PRODUCT_MASK) != HDLCD_PRODUCT_ID) {
+		DRM_ERROR("unknown product id: 0x%x\n", version);
+		ret = -EINVAL;
+		goto fail;
+	}
+	DRM_INFO("found ARM HDLCD version r%dp%d\n",
+		(version & HDLCD_VERSION_MAJOR_MASK) >> 8,
+		version & HDLCD_VERSION_MINOR_MASK);
+
+	/* Get the optional coherent memory resource */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (res) {
+		ret = dma_declare_coherent_memory(dev->dev, res->start, res->start,
+					resource_size(res), DMA_MEMORY_MAP);
+		if ((ret & DMA_MEMORY_MAP) == 0) {
+			DRM_ERROR("failed to declare coherent device memory\n");
+			ret = -ENXIO;
+			goto fail;
+		}
+	}
+
+	hdlcd_setup_mode_config(dev);
+
+	hdlcd->clk = clk_get(dev->dev, "pxlclk");
+	if (IS_ERR(hdlcd->clk)) {
+		ret = PTR_ERR(hdlcd->clk);
+		goto fail;
+	}
+
+	ret = hdlcd_setup_crtc(dev);
+	if (ret < 0) {
+		DRM_ERROR("failed to create crtc\n");
+		goto fail;
+	}
+
+	ret = component_bind_all(dev->dev, dev);
+	if (ret) {
+		DRM_ERROR("Failed to bind all components\n");
+		goto fail;
+	}
+
+	drm_kms_helper_poll_init(dev);
+	drm_mode_config_reset(dev);
+
+	ret = drm_irq_install(dev, platform_get_irq(pdev, 0));
+	if (ret < 0) {
+		DRM_ERROR("failed to install IRQ handler\n");
+		goto fail;
+	}
+
+	dev->irq_enabled = true;
+	dev->vblank_disable_allowed = true;
+
+	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
+	if (ret < 0) {
+		DRM_ERROR("failed to initialise vblank\n");
+		goto fail;
+	}
+	hdlcd->fbdev = drm_fbdev_cma_init(dev, 32,
+					dev->mode_config.num_crtc,
+					dev->mode_config.num_connector);
+
+	if (IS_ERR(hdlcd->fbdev)) {
+		DRM_ERROR("failed to initialise fbdev buffer\n");
+		ret = PTR_ERR(hdlcd->fbdev);
+		hdlcd->fbdev = NULL;
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+	hdlcd_unload(dev);
+
+	return ret;
+}
+
+static void hdlcd_fb_output_poll_changed(struct drm_device *dev)
+{
+	struct hdlcd_drm_private *hdlcd = dev->dev_private;
+
+	if (hdlcd->fbdev) {
+		drm_fbdev_cma_hotplug_event(hdlcd->fbdev);
+	}
+}
+
+static const struct drm_mode_config_funcs hdlcd_mode_config_funcs = {
+	.fb_create = drm_fb_cma_create,
+	.output_poll_changed = hdlcd_fb_output_poll_changed,
+};
+
+static void hdlcd_setup_mode_config(struct drm_device *dev)
+{
+	drm_mode_config_init(dev);
+	dev->mode_config.min_width = 0;
+	dev->mode_config.min_height = 0;
+	dev->mode_config.max_width = HDLCD_MAX_XRES;
+	dev->mode_config.max_height = HDLCD_MAX_YRES;
+	dev->mode_config.funcs = &hdlcd_mode_config_funcs;
+}
+
+static void hdlcd_preclose(struct drm_device *dev, struct drm_file *file)
+{
+}
+
+static void hdlcd_lastclose(struct drm_device *dev)
+{
+	struct hdlcd_drm_private *hdlcd = dev->dev_private;
+
+	drm_fbdev_cma_restore_mode(hdlcd->fbdev);
+}
+
+static irqreturn_t hdlcd_irq(int irq, void *arg)
+{
+	struct drm_device *dev = arg;
+	struct hdlcd_drm_private *hdlcd = dev->dev_private;
+	unsigned long irq_status;
+
+	irq_status = hdlcd_read(hdlcd, HDLCD_REG_INT_STATUS);
+
+#ifdef CONFIG_DEBUG_FS
+	if (irq_status & HDLCD_INTERRUPT_UNDERRUN) {
+		atomic_inc(&hdlcd->buffer_underrun_count);
+	}
+	if (irq_status & HDLCD_INTERRUPT_DMA_END) {
+		atomic_inc(&hdlcd->dma_end_count);
+	}
+	if (irq_status & HDLCD_INTERRUPT_BUS_ERROR) {
+		atomic_inc(&hdlcd->bus_error_count);
+	}
+	if (irq_status & HDLCD_INTERRUPT_VSYNC) {
+		atomic_inc(&hdlcd->vsync_count);
+	}
+#endif
+	if (irq_status & HDLCD_INTERRUPT_VSYNC) {
+		struct drm_pending_vblank_event *event;
+		unsigned long flags;
+
+		hdlcd_set_scanout(hdlcd);
+
+		drm_handle_vblank(dev, 0);
+
+		spin_lock_irqsave(&dev->event_lock, flags);
+		if (hdlcd->event) {
+			event = hdlcd->event;
+			hdlcd->event = NULL;
+			drm_send_vblank_event(dev, 0, event);
+			drm_vblank_put(dev, 0);
+		}
+		spin_unlock_irqrestore(&dev->event_lock, flags);
+	}
+
+	/* acknowledge interrupt(s) */
+	hdlcd_write(hdlcd, HDLCD_REG_INT_CLEAR, irq_status);
+
+	return IRQ_HANDLED;
+}
+
+static void hdlcd_irq_preinstall(struct drm_device *dev)
+{
+	struct hdlcd_drm_private *hdlcd = dev->dev_private;
+	/* Ensure interrupts are disabled */
+	hdlcd_write(hdlcd, HDLCD_REG_INT_MASK, 0);
+	hdlcd_write(hdlcd, HDLCD_REG_INT_CLEAR, ~0);
+}
+
+static int hdlcd_irq_postinstall(struct drm_device *dev)
+{
+#ifdef CONFIG_DEBUG_FS
+	struct hdlcd_drm_private *hdlcd = dev->dev_private;
+	unsigned long irq_mask = hdlcd_read(hdlcd, HDLCD_REG_INT_MASK);
+
+	/* enable debug interrupts */
+	irq_mask |= HDLCD_DEBUG_INT_MASK;
+
+	hdlcd_write(hdlcd, HDLCD_REG_INT_MASK, irq_mask);
+#endif
+	return 0;
+}
+
+static void hdlcd_irq_uninstall(struct drm_device *dev)
+{
+	struct hdlcd_drm_private *hdlcd = dev->dev_private;
+	/* disable all the interrupts that we might have enabled */
+	unsigned long irq_mask = hdlcd_read(hdlcd, HDLCD_REG_INT_MASK);
+
+#ifdef CONFIG_DEBUG_FS
+	/* disable debug interrupts */
+	irq_mask &= ~HDLCD_DEBUG_INT_MASK;
+#endif
+
+	/* disable vsync interrupts */
+	irq_mask &= ~HDLCD_INTERRUPT_VSYNC;
+
+	hdlcd_write(hdlcd, HDLCD_REG_INT_MASK, irq_mask);
+}
+
+static int hdlcd_enable_vblank(struct drm_device *dev, int crtc)
+{
+	struct hdlcd_drm_private *hdlcd = dev->dev_private;
+	unsigned int mask = hdlcd_read(hdlcd, HDLCD_REG_INT_MASK);
+
+	hdlcd_write(hdlcd, HDLCD_REG_INT_MASK, mask | HDLCD_INTERRUPT_VSYNC);
+
+	return 0;
+}
+
+static void hdlcd_disable_vblank(struct drm_device *dev, int crtc)
+{
+	struct hdlcd_drm_private *hdlcd = dev->dev_private;
+	unsigned int mask = hdlcd_read(hdlcd, HDLCD_REG_INT_MASK);
+
+	hdlcd_write(hdlcd, HDLCD_REG_INT_MASK, mask & ~HDLCD_INTERRUPT_VSYNC);
+}
+
+#ifdef CONFIG_DEBUG_FS
+static int hdlcd_show_underrun_count(struct seq_file *m, void *arg)
+{
+	struct drm_info_node *node = (struct drm_info_node *)m->private;
+	struct drm_device *dev = node->minor->dev;
+	struct hdlcd_drm_private *hdlcd = dev->dev_private;
+
+	seq_printf(m, "underrun : %d\n", atomic_read(&hdlcd->buffer_underrun_count));
+	seq_printf(m, "dma_end  : %d\n", atomic_read(&hdlcd->dma_end_count));
+	seq_printf(m, "bus_error: %d\n", atomic_read(&hdlcd->bus_error_count));
+	seq_printf(m, "vsync    : %d\n", atomic_read(&hdlcd->vsync_count));
+	return 0;
+}
+
+static struct drm_info_list hdlcd_debugfs_list[] = {
+	{ "interrupt_count", hdlcd_show_underrun_count, 0 },
+};
+
+static int hdlcd_debugfs_init(struct drm_minor *minor)
+{
+	return drm_debugfs_create_files(hdlcd_debugfs_list,
+		ARRAY_SIZE(hdlcd_debugfs_list),	minor->debugfs_root, minor);
+}
+
+static void hdlcd_debugfs_cleanup(struct drm_minor *minor)
+{
+	drm_debugfs_remove_files(hdlcd_debugfs_list,
+		ARRAY_SIZE(hdlcd_debugfs_list), minor);
+}
+#endif
+
+static const struct file_operations fops = {
+	.owner		= THIS_MODULE,
+	.open		= drm_open,
+	.release	= drm_release,
+	.unlocked_ioctl	= drm_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= drm_compat_ioctl,
+#endif
+	.poll		= drm_poll,
+	.read		= drm_read,
+	.llseek		= no_llseek,
+	.mmap		= drm_gem_cma_mmap,
+};
+
+static struct drm_driver hdlcd_driver = {
+	.driver_features	= DRIVER_HAVE_IRQ | DRIVER_GEM |
+					DRIVER_MODESET | DRIVER_PRIME,
+	.load			= hdlcd_load,
+	.unload			= hdlcd_unload,
+	.preclose		= hdlcd_preclose,
+	.lastclose		= hdlcd_lastclose,
+	.irq_handler		= hdlcd_irq,
+	.irq_preinstall		= hdlcd_irq_preinstall,
+	.irq_postinstall	= hdlcd_irq_postinstall,
+	.irq_uninstall		= hdlcd_irq_uninstall,
+	.get_vblank_counter	= drm_vblank_count,
+	.enable_vblank		= hdlcd_enable_vblank,
+	.disable_vblank		= hdlcd_disable_vblank,
+	.gem_free_object	= drm_gem_cma_free_object,
+	.gem_vm_ops		= &drm_gem_cma_vm_ops,
+	.dumb_create		= drm_gem_cma_dumb_create,
+	.dumb_map_offset	= drm_gem_cma_dumb_map_offset,
+	.dumb_destroy		= drm_gem_dumb_destroy,
+	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
+	.gem_prime_export	= drm_gem_prime_export,
+	.gem_prime_import	= drm_gem_prime_import,
+	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
+	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
+	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
+	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
+#ifdef CONFIG_DEBUG_FS
+	.debugfs_init		= hdlcd_debugfs_init,
+	.debugfs_cleanup	= hdlcd_debugfs_cleanup,
+#endif
+	.fops			= &fops,
+	.name			= "hdlcd",
+	.desc			= "ARM HDLCD Controller DRM",
+	.date			= "20130505",
+	.major			= 1,
+	.minor			= 0,
+};
+
+static int hdlcd_add_components(struct device *dev, struct master *master)
+{
+	struct device_node *port, *ep = NULL;
+	int ret = -ENXIO;
+
+	if (!dev->of_node)
+		return -ENODEV;
+
+	do {
+		ep = of_graph_get_next_endpoint(dev->of_node, ep);
+		if (!ep)
+			break;
+
+		if (!of_device_is_available(ep)) {
+			of_node_put(ep);
+			continue;
+		}
+
+		port = of_graph_get_remote_port_parent(ep);
+		of_node_put(ep);
+		if (!port || !of_device_is_available(port)) {
+			of_node_put(port);
+			continue;
+		}
+
+		ret = component_master_add_child(master, compare_dev, port);
+		of_node_put(port);
+	} while (1);
+
+	return ret;
+}
+
+static int hdlcd_drm_bind(struct device *dev)
+{
+	return drm_platform_init(&hdlcd_driver, to_platform_device(dev));
+}
+
+static void hdlcd_drm_unbind(struct device *dev)
+{
+	drm_put_dev(dev_get_drvdata(dev));
+}
+
+static const struct component_master_ops hdlcd_master_ops = {
+	.add_components	= hdlcd_add_components,
+	.bind		= hdlcd_drm_bind,
+	.unbind		= hdlcd_drm_unbind,
+};
+
+static int hdlcd_probe(struct platform_device *pdev)
+{
+	return component_master_add(&pdev->dev, &hdlcd_master_ops);
+}
+
+static int hdlcd_remove(struct platform_device *pdev)
+{
+	component_master_del(&pdev->dev, &hdlcd_master_ops);
+	return 0;
+}
+
+static const struct of_device_id  hdlcd_of_match[] = {
+	{ .compatible	= "arm,hdlcd" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, hdlcd_of_match);
+
+static struct platform_driver hdlcd_platform_driver = {
+	.probe		= hdlcd_probe,
+	.remove		= hdlcd_remove,
+	.driver	= {
+		.name		= "hdlcd",
+		.owner		= THIS_MODULE,
+		.of_match_table	= hdlcd_of_match,
+	},
+};
+
+static int __init hdlcd_init(void)
+{
+	int err = platform_driver_register(&hdlcd_platform_driver);
+
+#ifdef HDLCD_COUNT_BUFFERUNDERRUNS
+	if (!err)
+		hdlcd_underrun_init();
+#endif
+
+	return err;
+}
+
+static void __exit hdlcd_exit(void)
+{
+#ifdef HDLCD_COUNT_BUFFERUNDERRUNS
+	hdlcd_underrun_close();
+#endif
+	platform_driver_unregister(&hdlcd_platform_driver);
+}
+
+module_init(hdlcd_init);
+module_exit(hdlcd_exit);
+
+MODULE_AUTHOR("Liviu Dudau");
+MODULE_DESCRIPTION("ARM HDLCD DRM driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.h b/drivers/gpu/drm/arm/hdlcd_drv.h
new file mode 100644
index 0000000..31866fc
--- /dev/null
+++ b/drivers/gpu/drm/arm/hdlcd_drv.h
@@ -0,0 +1,51 @@
+/*
+ *  ARM HDLCD Controller register definition
+ */
+
+#ifndef __HDLCD_DRV_H__
+#define __HDLCD_DRV_H__
+
+struct hdlcd_drm_private {
+	void __iomem			*mmio;
+	struct clk			*clk;
+	struct drm_fbdev_cma		*fbdev;
+	struct drm_framebuffer		*fb;
+	struct drm_pending_vblank_event	*event;
+	struct drm_crtc			crtc;
+#ifdef CONFIG_DEBUG_FS
+	atomic_t buffer_underrun_count;
+	atomic_t bus_error_count;
+	atomic_t vsync_count;
+	atomic_t dma_end_count;
+#endif
+	int dpms;
+};
+
+#define crtc_to_hdlcd_priv(x)	container_of(x, struct hdlcd_drm_private, crtc)
+
+static inline void
+hdlcd_write(struct hdlcd_drm_private *hdlcd, unsigned int reg, u32 value)
+{
+	writel(value, hdlcd->mmio + reg);
+}
+
+static inline u32 hdlcd_read(struct hdlcd_drm_private *hdlcd, unsigned int reg)
+{
+	return readl(hdlcd->mmio + reg);
+}
+
+/*
+ * Developers using HDLCD may wish to enable these settings if
+ * display disruption is apparent and you suspect HDLCD
+ * access to RAM may be starved.
+ *
+ * Turn HDLCD default color to red instead of default black so
+ * that it's easier to see data underruns (compared to other
+ * visual disruptions)
+ */
+/* #define HDLCD_SHOW_UNDERRUN */
+
+int hdlcd_setup_crtc(struct drm_device *dev);
+void hdlcd_set_scanout(struct hdlcd_drm_private *hdlcd);
+
+#endif /* __HDLCD_DRV_H__ */
diff --git a/drivers/gpu/drm/arm/hdlcd_regs.h b/drivers/gpu/drm/arm/hdlcd_regs.h
new file mode 100644
index 0000000..66799eb
--- /dev/null
+++ b/drivers/gpu/drm/arm/hdlcd_regs.h
@@ -0,0 +1,87 @@
+/*
+ * Copyright (C) 2013,2014 ARM Limited
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ *
+ *  ARM HDLCD Controller register definition
+ */
+
+#ifndef __HDLCD_REGS_H__
+#define __HDLCD_REGS_H__
+
+/* register offsets */
+#define HDLCD_REG_VERSION		0x0000	/* ro */
+#define HDLCD_REG_INT_RAWSTAT		0x0010	/* rw */
+#define HDLCD_REG_INT_CLEAR		0x0014	/* wo */
+#define HDLCD_REG_INT_MASK		0x0018	/* rw */
+#define HDLCD_REG_INT_STATUS		0x001c	/* ro */
+#define HDLCD_REG_FB_BASE		0x0100	/* rw */
+#define HDLCD_REG_FB_LINE_LENGTH	0x0104	/* rw */
+#define HDLCD_REG_FB_LINE_COUNT		0x0108	/* rw */
+#define HDLCD_REG_FB_LINE_PITCH		0x010c	/* rw */
+#define HDLCD_REG_BUS_OPTIONS		0x0110	/* rw */
+#define HDLCD_REG_V_SYNC		0x0200	/* rw */
+#define HDLCD_REG_V_BACK_PORCH		0x0204	/* rw */
+#define HDLCD_REG_V_DATA		0x0208	/* rw */
+#define HDLCD_REG_V_FRONT_PORCH		0x020c	/* rw */
+#define HDLCD_REG_H_SYNC		0x0210	/* rw */
+#define HDLCD_REG_H_BACK_PORCH		0x0214	/* rw */
+#define HDLCD_REG_H_DATA		0x0218	/* rw */
+#define HDLCD_REG_H_FRONT_PORCH		0x021c	/* rw */
+#define HDLCD_REG_POLARITIES		0x0220	/* rw */
+#define HDLCD_REG_COMMAND		0x0230	/* rw */
+#define HDLCD_REG_PIXEL_FORMAT		0x0240	/* rw */
+#define HDLCD_REG_RED_SELECT		0x0244	/* rw */
+#define HDLCD_REG_GREEN_SELECT		0x0248	/* rw */
+#define HDLCD_REG_BLUE_SELECT		0x024c	/* rw */
+
+/* version */
+#define HDLCD_PRODUCT_ID		0x1CDC0000
+#define HDLCD_PRODUCT_MASK		0xFFFF0000
+#define HDLCD_VERSION_MAJOR_MASK	0x0000FF00
+#define HDLCD_VERSION_MINOR_MASK	0x000000FF
+
+/* interrupts */
+#define HDLCD_INTERRUPT_DMA_END		(1 << 0)
+#define HDLCD_INTERRUPT_BUS_ERROR	(1 << 1)
+#define HDLCD_INTERRUPT_VSYNC		(1 << 2)
+#define HDLCD_INTERRUPT_UNDERRUN	(1 << 3)
+#define HDLCD_DEBUG_INT_MASK		(HDLCD_INTERRUPT_DMA_END |  \
+					HDLCD_INTERRUPT_BUS_ERROR | \
+					HDLCD_INTERRUPT_UNDERRUN)
+
+/* polarities */
+#define HDLCD_POLARITY_VSYNC		(1 << 0)
+#define HDLCD_POLARITY_HSYNC		(1 << 1)
+#define HDLCD_POLARITY_DATAEN		(1 << 2)
+#define HDLCD_POLARITY_DATA		(1 << 3)
+#define HDLCD_POLARITY_PIXELCLK		(1 << 4)
+
+/* commands */
+#define HDLCD_COMMAND_DISABLE		(0 << 0)
+#define HDLCD_COMMAND_ENABLE		(1 << 0)
+
+/* pixel format */
+#define HDLCD_PIXEL_FMT_LITTLE_ENDIAN	(0 << 31)
+#define HDLCD_PIXEL_FMT_BIG_ENDIAN	(1 << 31)
+#define HDLCD_BYTES_PER_PIXEL_MASK	(3 << 3)
+
+/* bus options */
+#define HDLCD_BUS_BURST_MASK		0x01f
+#define HDLCD_BUS_MAX_OUTSTAND		0xf00
+#define HDLCD_BUS_BURST_NONE		(0 << 0)
+#define HDLCD_BUS_BURST_1		(1 << 0)
+#define HDLCD_BUS_BURST_2		(1 << 1)
+#define HDLCD_BUS_BURST_4		(1 << 2)
+#define HDLCD_BUS_BURST_8		(1 << 3)
+#define HDLCD_BUS_BURST_16		(1 << 4)
+
+/* Max resolution supported is 4096x4096, 32bpp */
+#define HDLCD_MAX_XRES			4096
+#define HDLCD_MAX_YRES			4096
+
+#define NR_PALETTE			256
+
+#endif /* __HDLCD_REGS_H__ */
-- 
2.4.6
