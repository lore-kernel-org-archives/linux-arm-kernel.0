From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 18 May 2012 14:27:11 +0200
Subject: [PATCH 1/2] DRM: add Freescale i.MX LCDC driver
In-Reply-To: <1337344032-25431-1-git-send-email-s.hauer@pengutronix.de>
References: <1337344032-25431-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1337344032-25431-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/gpu/drm/Kconfig                    |    2 +
 drivers/gpu/drm/Makefile                   |    1 +
 drivers/gpu/drm/imx/Kconfig                |   18 +
 drivers/gpu/drm/imx/Makefile               |    8 +
 drivers/gpu/drm/imx/imx-drm-core.c         |  745 ++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/imx-fb.c               |  179 +++++++
 drivers/gpu/drm/imx/imx-fbdev.c            |  275 ++++++++++
 drivers/gpu/drm/imx/imx-gem.c              |  343 +++++++++++++
 drivers/gpu/drm/imx/imx-lcdc-crtc.c        |  517 +++++++++++++++++++
 drivers/gpu/drm/imx/imx-parallel-display.c |  228 +++++++++
 10 files changed, 2316 insertions(+)
 create mode 100644 drivers/gpu/drm/imx/Kconfig
 create mode 100644 drivers/gpu/drm/imx/Makefile
 create mode 100644 drivers/gpu/drm/imx/imx-drm-core.c
 create mode 100644 drivers/gpu/drm/imx/imx-fb.c
 create mode 100644 drivers/gpu/drm/imx/imx-fbdev.c
 create mode 100644 drivers/gpu/drm/imx/imx-gem.c
 create mode 100644 drivers/gpu/drm/imx/imx-lcdc-crtc.c
 create mode 100644 drivers/gpu/drm/imx/imx-parallel-display.c

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index e354bc0..759502c 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -186,3 +186,5 @@ source "drivers/gpu/drm/vmwgfx/Kconfig"
 source "drivers/gpu/drm/gma500/Kconfig"
 
 source "drivers/gpu/drm/udl/Kconfig"
+
+source "drivers/gpu/drm/imx/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index c20da5b..6569d8d 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -42,4 +42,5 @@ obj-$(CONFIG_DRM_NOUVEAU) +=nouveau/
 obj-$(CONFIG_DRM_EXYNOS) +=exynos/
 obj-$(CONFIG_DRM_GMA500) += gma500/
 obj-$(CONFIG_DRM_UDL) += udl/
+obj-$(CONFIG_DRM_IMX) += imx/
 obj-y			+= i2c/
diff --git a/drivers/gpu/drm/imx/Kconfig b/drivers/gpu/drm/imx/Kconfig
new file mode 100644
index 0000000..5fc3a44
--- /dev/null
+++ b/drivers/gpu/drm/imx/Kconfig
@@ -0,0 +1,18 @@
+config DRM_IMX
+	tristate "DRM Support for Freescale i.MX"
+	select DRM_KMS_HELPER
+	depends on DRM && ARCH_MXC
+
+config DRM_IMX_FB_HELPER
+	tristate "provide legacy framebuffer /dev/fb0"
+	depends on DRM_IMX
+
+config DRM_IMX_LCDC
+	tristate "DRM Support for Freescale i.MX1 and i.MX2"
+	depends on DRM_IMX
+	help
+	  Choose this if you have a i.MX1, i.MX21, i.MX25 or i.MX27 processor.
+
+config DRM_IMX_PARALLEL_DISPLAY
+	tristate "Support for parallel displays"
+	depends on DRM_IMX
diff --git a/drivers/gpu/drm/imx/Makefile b/drivers/gpu/drm/imx/Makefile
new file mode 100644
index 0000000..0f7c038
--- /dev/null
+++ b/drivers/gpu/drm/imx/Makefile
@@ -0,0 +1,8 @@
+
+imxdrm-objs := imx-drm-core.o imx-fb.o imx-gem.o
+
+obj-$(CONFIG_DRM_IMX) += imxdrm.o
+
+obj-$(CONFIG_DRM_IMX_PARALLEL_DISPLAY) += imx-parallel-display.o
+obj-$(CONFIG_DRM_IMX_LCDC) += imx-lcdc-crtc.o
+obj-$(CONFIG_DRM_IMX_FB_HELPER) += imx-fbdev.o
diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
new file mode 100644
index 0000000..29f5f10
--- /dev/null
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -0,0 +1,745 @@
+/*
+ * simple drm driver
+ *
+ * Copyright (C) 2011 Sascha Hauer, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <drm/drmP.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <linux/fb.h>
+#include <asm/fb.h>
+#include <linux/module.h>
+
+#include "imx-drm.h"
+
+#define MAX_CRTC	4
+
+struct imx_drm_device {
+	struct drm_device			*drm;
+	struct device				*dev;
+	struct list_head			crtc_list;
+	struct list_head			encoder_list;
+	struct list_head			connector_list;
+	struct mutex				mutex;
+	int					references;
+};
+
+struct imx_drm_crtc {
+	struct drm_crtc				*crtc;
+	struct list_head			list;
+	struct imx_drm_device			*imxdrm;
+	int					pipe;
+	struct drm_crtc_helper_funcs		crtc_helper_funcs;
+	struct drm_crtc_funcs			crtc_funcs;
+	struct imx_drm_crtc_helper_funcs	imx_drm_helper_funcs;
+	struct module				*owner;
+};
+
+struct imx_drm_encoder {
+	struct drm_encoder			*encoder;
+	struct list_head			list;
+	struct module				*owner;
+};
+
+struct imx_drm_connector {
+	struct drm_connector			*connector;
+	struct list_head			list;
+	struct module				*owner;
+};
+
+static int imx_drm_driver_firstopen(struct drm_device *drm)
+{
+	if (!imx_drm_device_get())
+		return -EINVAL;
+
+	return 0;
+}
+
+static void imx_drm_driver_lastclose(struct drm_device *drm)
+{
+	imx_drm_device_put();
+}
+
+static int imx_drm_driver_unload(struct drm_device *drm)
+{
+	struct imx_drm_device *imxdrm = drm->dev_private;
+
+	drm_mode_config_cleanup(imxdrm->drm);
+	drm_kms_helper_poll_fini(imxdrm->drm);
+
+	return 0;
+}
+
+/*
+ * We don't care at all for crtc numbers, but the core expects the
+ * crtcs to be numbered
+ */
+static struct imx_drm_crtc *imx_drm_crtc_by_num(struct imx_drm_device *imxdrm,
+		int num)
+{
+	struct imx_drm_crtc *imx_drm_crtc;
+
+	list_for_each_entry(imx_drm_crtc, &imxdrm->crtc_list, list)
+		if (imx_drm_crtc->pipe == num)
+			return imx_drm_crtc;
+	return NULL;
+}
+
+int imx_drm_crtc_vblank_get(struct imx_drm_crtc *imx_drm_crtc)
+{
+	return drm_vblank_get(imx_drm_crtc->imxdrm->drm, imx_drm_crtc->pipe);
+}
+EXPORT_SYMBOL_GPL(imx_drm_crtc_vblank_get);
+
+void imx_drm_crtc_vblank_put(struct imx_drm_crtc *imx_drm_crtc)
+{
+	drm_vblank_put(imx_drm_crtc->imxdrm->drm, imx_drm_crtc->pipe);
+}
+EXPORT_SYMBOL_GPL(imx_drm_crtc_vblank_put);
+
+void imx_drm_handle_vblank(struct imx_drm_crtc *imx_drm_crtc)
+{
+	drm_handle_vblank(imx_drm_crtc->imxdrm->drm, imx_drm_crtc->pipe);
+}
+EXPORT_SYMBOL_GPL(imx_drm_handle_vblank);
+
+static int imx_drm_enable_vblank(struct drm_device *drm, int crtc)
+{
+	struct imx_drm_device *imxdrm = drm->dev_private;
+	struct imx_drm_crtc *imx_drm_crtc;
+	int ret;
+
+	imx_drm_crtc = imx_drm_crtc_by_num(imxdrm, crtc);
+	if (!imx_drm_crtc)
+		return -EINVAL;
+
+	if (!imx_drm_crtc->imx_drm_helper_funcs.enable_vblank)
+		return -ENOSYS;
+
+	ret = imx_drm_crtc->imx_drm_helper_funcs.enable_vblank(imx_drm_crtc->crtc);
+	return ret;
+}
+
+static void imx_drm_disable_vblank(struct drm_device *drm, int crtc)
+{
+	struct imx_drm_device *imxdrm = drm->dev_private;
+	struct imx_drm_crtc *imx_drm_crtc;
+
+	imx_drm_crtc = imx_drm_crtc_by_num(imxdrm, crtc);
+	if (!imx_drm_crtc)
+		return;
+
+	if (!imx_drm_crtc->imx_drm_helper_funcs.disable_vblank)
+		return;
+
+	imx_drm_crtc->imx_drm_helper_funcs.disable_vblank(imx_drm_crtc->crtc);
+}
+
+static struct vm_operations_struct imx_drm_gem_vm_ops = {
+	.fault = imx_drm_gem_fault,
+	.open = drm_gem_vm_open,
+	.close = drm_gem_vm_close,
+};
+
+static const struct file_operations imx_drm_driver_fops = {
+	.owner = THIS_MODULE,
+	.open = drm_open,
+	.release = drm_release,
+	.unlocked_ioctl = drm_ioctl,
+	.mmap = imx_drm_gem_mmap,
+	.poll = drm_poll,
+	.fasync = drm_fasync,
+	.read = drm_read,
+	.llseek = noop_llseek,
+};
+
+static struct imx_drm_device *imx_drm_device;
+
+static struct imx_drm_device *__imx_drm_device(void)
+{
+	return imx_drm_device;
+}
+
+struct drm_device *imx_drm_device_get(void)
+{
+	struct imx_drm_device *imxdrm = __imx_drm_device();
+	struct imx_drm_encoder *enc;
+	struct imx_drm_connector *con;
+	struct imx_drm_crtc *crtc;
+
+	mutex_lock(&imxdrm->mutex);
+
+	list_for_each_entry(enc, &imxdrm->encoder_list, list) {
+		if (!try_module_get(enc->owner)) {
+			dev_err(imxdrm->dev, "could not get module %s\n",
+					module_name(enc->owner));
+			goto unwind_enc;
+		}
+	}
+
+	list_for_each_entry(con, &imxdrm->connector_list, list) {
+		if (!try_module_get(con->owner)) {
+			dev_err(imxdrm->dev, "could not get module %s\n",
+					module_name(con->owner));
+			goto unwind_con;
+		}
+	}
+
+	list_for_each_entry(crtc, &imxdrm->crtc_list, list) {
+		if (!try_module_get(crtc->owner)) {
+			dev_err(imxdrm->dev, "could not get module %s\n",
+					module_name(crtc->owner));
+			goto unwind_crtc;
+		}
+	}
+
+	imxdrm->references++;
+
+	mutex_unlock(&imxdrm->mutex);
+
+	return imx_drm_device->drm;
+
+unwind_crtc:
+	list_for_each_entry_continue_reverse(crtc, &imxdrm->crtc_list, list)
+		module_put(crtc->owner);
+unwind_con:
+	list_for_each_entry_continue_reverse(con, &imxdrm->connector_list, list)
+		module_put(con->owner);
+unwind_enc:
+	list_for_each_entry_continue_reverse(enc, &imxdrm->encoder_list, list)
+		module_put(enc->owner);
+
+	mutex_unlock(&imxdrm->mutex);
+
+	return NULL;
+
+}
+EXPORT_SYMBOL_GPL(imx_drm_device_get);
+
+void imx_drm_device_put(void)
+{
+	struct imx_drm_device *imxdrm = __imx_drm_device();
+	struct imx_drm_encoder *enc;
+	struct imx_drm_connector *con;
+	struct imx_drm_crtc *crtc;
+
+	mutex_lock(&imxdrm->mutex);
+
+	list_for_each_entry(crtc, &imxdrm->crtc_list, list)
+		module_put(crtc->owner);
+
+	list_for_each_entry(con, &imxdrm->connector_list, list)
+		module_put(con->owner);
+
+	list_for_each_entry(enc, &imxdrm->encoder_list, list)
+		module_put(enc->owner);
+
+	imxdrm->references--;
+
+	mutex_unlock(&imxdrm->mutex);
+}
+EXPORT_SYMBOL_GPL(imx_drm_device_put);
+
+static int drm_mode_group_reinit(struct drm_device *dev)
+{
+	struct drm_mode_group *group = &dev->primary->mode_group;
+	uint32_t *id_list = group->id_list;
+	int ret;
+
+	ret = drm_mode_group_init_legacy_group(dev, group);
+	if (ret < 0)
+		return ret;
+
+	kfree(id_list);
+	return 0;
+}
+
+/*
+ * register an encoder to the drm core
+ */
+static int imx_drm_encoder_register(struct imx_drm_encoder *imx_drm_encoder)
+{
+	struct imx_drm_device *imxdrm = __imx_drm_device();
+
+	drm_encoder_init(imxdrm->drm, imx_drm_encoder->encoder,
+			imx_drm_encoder->encoder->funcs,
+			DRM_MODE_ENCODER_TMDS);
+
+	drm_mode_group_reinit(imxdrm->drm);
+
+	return 0;
+}
+
+/*
+ * unregister an encoder from the drm core
+ */
+static void imx_drm_encoder_unregister(struct imx_drm_encoder *imx_drm_encoder)
+{
+	struct imx_drm_device *imxdrm = __imx_drm_device();
+
+	drm_encoder_cleanup(imx_drm_encoder->encoder);
+
+	drm_mode_group_reinit(imxdrm->drm);
+}
+
+/*
+ * register a connector to the drm core
+ */
+static int imx_drm_connector_register(struct imx_drm_connector *imx_drm_connector)
+{
+	struct imx_drm_device *imxdrm = __imx_drm_device();
+	int ret;
+
+	drm_connector_init(imxdrm->drm, imx_drm_connector->connector,
+			imx_drm_connector->connector->funcs,
+			DRM_MODE_CONNECTOR_VGA);
+	drm_mode_group_reinit(imxdrm->drm);
+	ret = drm_sysfs_connector_add(imx_drm_connector->connector);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+
+	return ret;
+}
+
+/*
+ * unregister a connector from the drm core
+ */
+static void imx_drm_connector_unregister(struct imx_drm_connector *imx_drm_connector)
+{
+	struct imx_drm_device *imxdrm = __imx_drm_device();
+
+	drm_sysfs_connector_remove(imx_drm_connector->connector);
+	drm_connector_cleanup(imx_drm_connector->connector);
+
+	drm_mode_group_reinit(imxdrm->drm);
+}
+
+/*
+ * register a crtc to the drm core
+ */
+static int imx_drm_crtc_register(struct imx_drm_crtc *imx_drm_crtc)
+{
+	struct imx_drm_device *imxdrm = __imx_drm_device();
+	int ret;
+
+	drm_crtc_init(imxdrm->drm, imx_drm_crtc->crtc, &imx_drm_crtc->crtc_funcs);
+	ret = drm_mode_crtc_set_gamma_size(imx_drm_crtc->crtc, 256);
+	if (ret)
+		return ret;
+
+	drm_crtc_helper_add(imx_drm_crtc->crtc, &imx_drm_crtc->crtc_helper_funcs);
+
+	return 0;
+}
+
+/*
+ * Called by the CRTC driver when all CRTCs are registered. This
+ * puts all the pieces together and initializes the driver.
+ * Once this is called no more CRTCs can be registered since
+ * the drm core has hardcoded the number of crtcs in several
+ * places.
+ */
+static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
+{
+	struct imx_drm_device *imxdrm = __imx_drm_device();
+	int ret;
+
+	imxdrm->drm = drm;
+
+	drm->dev_private = imxdrm;
+
+	/*
+	 * enable drm irq mode.
+	 * - with irq_enabled = 1, we can use the vblank feature.
+	 *
+	 * P.S. note that we wouldn't use drm irq handler but
+	 *      just specific driver own one instead because
+	 *      drm framework supports only one irq handler and
+	 *      drivers can well take care of their interrupts
+	 */
+	drm->irq_enabled = 1;
+
+	drm_mode_config_init(drm);
+	imx_drm_mode_config_init(drm);
+
+	mutex_lock(&imxdrm->mutex);
+
+	drm_kms_helper_poll_init(imxdrm->drm);
+
+	/* setup the grouping for the legacy output */
+	ret = drm_mode_group_init_legacy_group(imxdrm->drm,
+			&imxdrm->drm->primary->mode_group);
+	if (ret)
+		goto err_init;
+
+	ret = drm_vblank_init(imxdrm->drm, MAX_CRTC);
+	if (ret)
+		goto err_init;
+
+	/*
+	 * with vblank_disable_allowed = 1, vblank interrupt will be disabled
+	 * by drm timer once a current process gives up ownership of
+	 * vblank event.(after drm_vblank_put function is called)
+	 */
+	imxdrm->drm->vblank_disable_allowed = 1;
+
+	ret = 0;
+
+err_init:
+	mutex_unlock(&imxdrm->mutex);
+
+	return ret;
+}
+
+/*
+ * imx_drm_add_crtc - add a new crtc
+ *
+ * The return value if !NULL is a cookie for the caller to pass to
+ * imx_drm_remove_crtc later.
+ */
+int imx_drm_add_crtc(struct drm_crtc *crtc,
+		struct imx_drm_crtc **new_crtc,
+		const struct drm_crtc_funcs *crtc_funcs,
+		const struct drm_crtc_helper_funcs *crtc_helper_funcs,
+		const struct imx_drm_crtc_helper_funcs *imx_drm_helper_funcs,
+		struct module *owner)
+{
+	struct imx_drm_device *imxdrm = __imx_drm_device();
+	struct imx_drm_crtc *imx_drm_crtc;
+	int ret;
+
+	mutex_lock(&imxdrm->mutex);
+
+	if (imxdrm->references) {
+		ret = -EBUSY;
+		goto err_busy;
+	}
+
+	imx_drm_crtc = kzalloc(sizeof(*imx_drm_crtc), GFP_KERNEL);
+	if (!imx_drm_crtc) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	imx_drm_crtc->crtc_funcs = *crtc_funcs;
+	imx_drm_crtc->crtc_helper_funcs = *crtc_helper_funcs;
+	imx_drm_crtc->imx_drm_helper_funcs = *imx_drm_helper_funcs;
+
+	WARN_ON(crtc_funcs->set_config);
+	WARN_ON(crtc_funcs->destroy);
+
+	imx_drm_crtc->crtc_funcs.set_config = drm_crtc_helper_set_config;
+	imx_drm_crtc->crtc_funcs.destroy = drm_crtc_cleanup;
+
+	imx_drm_crtc->crtc = crtc;
+	imx_drm_crtc->imxdrm = imxdrm;
+
+	imx_drm_crtc->owner = owner;
+
+	list_add_tail(&imx_drm_crtc->list, &imxdrm->crtc_list);
+
+	*new_crtc = imx_drm_crtc;
+
+	ret = imx_drm_crtc_register(imx_drm_crtc);
+	if (ret)
+		goto err_register;
+
+	mutex_unlock(&imxdrm->mutex);
+
+	return 0;
+
+err_register:
+	kfree(imx_drm_crtc);
+err_alloc:
+err_busy:
+	mutex_unlock(&imxdrm->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(imx_drm_add_crtc);
+
+/*
+ * imx_drm_remove_crtc - remove a crtc
+ */
+int imx_drm_remove_crtc(struct imx_drm_crtc *imx_drm_crtc)
+{
+	struct imx_drm_device *imxdrm = imx_drm_crtc->imxdrm;
+
+	mutex_lock(&imxdrm->mutex);
+
+	drm_crtc_cleanup(imx_drm_crtc->crtc);
+
+	list_del(&imx_drm_crtc->list);
+
+	mutex_unlock(&imxdrm->mutex);
+
+	kfree(imx_drm_crtc);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(imx_drm_remove_crtc);
+
+/*
+ * imx_drm_add_encoder - add a new encoder
+ */
+int imx_drm_add_encoder(struct drm_encoder *encoder,
+		struct imx_drm_encoder **newenc, struct module *owner)
+{
+	struct imx_drm_device *imxdrm = __imx_drm_device();
+	struct imx_drm_encoder *imx_drm_encoder;
+	int ret;
+
+	mutex_lock(&imxdrm->mutex);
+
+	if (imxdrm->references) {
+		ret = -EBUSY;
+		goto err_busy;
+	}
+
+	imx_drm_encoder = kzalloc(sizeof(struct imx_drm_encoder), GFP_KERNEL);
+	if (!imx_drm_encoder) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	imx_drm_encoder->encoder = encoder;
+	imx_drm_encoder->owner = owner;
+
+	ret = imx_drm_encoder_register(imx_drm_encoder);
+	if (ret) {
+		kfree(imx_drm_encoder);
+		ret = -ENOMEM;
+		goto err_register;
+	}
+
+	list_add_tail(&imx_drm_encoder->list, &imxdrm->encoder_list);
+
+	*newenc = imx_drm_encoder;
+
+	mutex_unlock(&imxdrm->mutex);
+
+	return 0;
+
+err_register:
+	kfree(imx_drm_encoder);
+err_alloc:
+err_busy:
+	mutex_unlock(&imxdrm->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(imx_drm_add_encoder);
+
+/*
+ * imx_drm_remove_encoder - remove an encoder
+ */
+int imx_drm_remove_encoder(struct imx_drm_encoder *imx_drm_encoder)
+{
+	struct imx_drm_device *imxdrm = __imx_drm_device();
+
+	mutex_lock(&imxdrm->mutex);
+
+	imx_drm_encoder_unregister(imx_drm_encoder);
+
+	list_del(&imx_drm_encoder->list);
+
+	mutex_unlock(&imxdrm->mutex);
+
+	kfree(imx_drm_encoder);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(imx_drm_remove_encoder);
+
+/*
+ * imx_drm_add_connector - add a connector
+ */
+int imx_drm_add_connector(struct drm_connector *connector,
+		struct imx_drm_connector **new_con,
+		struct module *owner)
+{
+	struct imx_drm_device *imxdrm = __imx_drm_device();
+	struct imx_drm_connector *imx_drm_connector;
+	int ret;
+
+	mutex_lock(&imxdrm->mutex);
+
+	if (imxdrm->references) {
+		ret = -EBUSY;
+		goto err_busy;
+	}
+
+	imx_drm_connector = kzalloc(sizeof(struct imx_drm_connector), GFP_KERNEL);
+	if (!imx_drm_connector) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	imx_drm_connector->connector = connector;
+	imx_drm_connector->owner = owner;
+
+	ret = imx_drm_connector_register(imx_drm_connector);
+	if (ret)
+		goto err_register;
+
+	list_add_tail(&imx_drm_connector->list, &imxdrm->connector_list);
+
+	*new_con = imx_drm_connector;
+
+	mutex_unlock(&imxdrm->mutex);
+
+	return 0;
+
+err_register:
+	kfree(imx_drm_connector);
+err_alloc:
+err_busy:
+	mutex_unlock(&imxdrm->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(imx_drm_add_connector);
+
+/*
+ * imx_drm_remove_connector - remove a connector
+ */
+int imx_drm_remove_connector(struct imx_drm_connector *imx_drm_connector)
+{
+	struct imx_drm_device *imxdrm = __imx_drm_device();
+
+	mutex_lock(&imxdrm->mutex);
+
+	imx_drm_connector_unregister(imx_drm_connector);
+
+	list_del(&imx_drm_connector->list);
+
+	mutex_unlock(&imxdrm->mutex);
+
+	kfree(imx_drm_connector);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(imx_drm_remove_connector);
+
+static struct drm_ioctl_desc imx_drm_ioctls[] = {
+	/* none so far */
+};
+
+static struct drm_driver imx_drm_driver = {
+	.driver_features	= DRIVER_MODESET | DRIVER_GEM,
+	.load			= imx_drm_driver_load,
+	.unload			= imx_drm_driver_unload,
+	.firstopen		= imx_drm_driver_firstopen,
+	.lastclose		= imx_drm_driver_lastclose,
+	.gem_free_object	= imx_drm_gem_free_object,
+	.gem_vm_ops		= &imx_drm_gem_vm_ops,
+	.dumb_create		= imx_drm_gem_dumb_create,
+	.dumb_map_offset	= imx_drm_gem_dumb_map_offset,
+	.dumb_destroy		= imx_drm_gem_dumb_destroy,
+
+	.get_vblank_counter	= drm_vblank_count,
+	.enable_vblank		= imx_drm_enable_vblank,
+	.disable_vblank		= imx_drm_disable_vblank,
+	.reclaim_buffers	= drm_core_reclaim_buffers,
+	.ioctls			= imx_drm_ioctls,
+	.num_ioctls		= ARRAY_SIZE(imx_drm_ioctls),
+	.fops			= &imx_drm_driver_fops,
+	.name			= "imx-drm",
+	.desc			= "i.MX DRM graphics",
+	.date			= "20120507",
+	.major			= 1,
+	.minor			= 0,
+	.patchlevel		= 0,
+};
+
+static int imx_drm_platform_probe(struct platform_device *pdev)
+{
+	imx_drm_device->dev = &pdev->dev;
+
+	return drm_platform_init(&imx_drm_driver, pdev);
+}
+
+static int imx_drm_platform_remove(struct platform_device *pdev)
+{
+	drm_platform_exit(&imx_drm_driver, pdev);
+
+	return 0;
+}
+
+static struct platform_driver imx_drm_pdrv = {
+	.probe		= imx_drm_platform_probe,
+	.remove		= __devexit_p(imx_drm_platform_remove),
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "imx-drm",
+	},
+};
+
+static struct platform_device *imx_drm_pdev;
+
+static int __init imx_drm_init(void)
+{
+	int ret;
+
+	imx_drm_device = kzalloc(sizeof(*imx_drm_device), GFP_KERNEL);
+	if (!imx_drm_device)
+		return -ENOMEM;
+
+	mutex_init(&imx_drm_device->mutex);
+	INIT_LIST_HEAD(&imx_drm_device->crtc_list);
+	INIT_LIST_HEAD(&imx_drm_device->connector_list);
+	INIT_LIST_HEAD(&imx_drm_device->encoder_list);
+
+	imx_drm_pdev = platform_device_register_simple("imx-drm", -1, NULL, 0);
+	if (!imx_drm_pdev) {
+		ret = -EINVAL;
+		goto err_pdev;
+	}
+
+	imx_drm_pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32),
+
+	ret = platform_driver_register(&imx_drm_pdrv);
+	if (ret)
+		goto err_pdrv;
+
+	return 0;
+
+err_pdev:
+	kfree(imx_drm_device);
+err_pdrv:
+	platform_device_unregister(imx_drm_pdev);
+
+	return ret;
+}
+
+static void __exit imx_drm_exit(void)
+{
+	DRM_DEBUG_DRIVER("%s\n", __FILE__);
+
+	platform_device_unregister(imx_drm_pdev);
+	platform_driver_unregister(&imx_drm_pdrv);
+
+	kfree(imx_drm_device);
+}
+
+module_init(imx_drm_init);
+module_exit(imx_drm_exit);
+
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
+MODULE_DESCRIPTION("i.MX drm driver core");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/imx/imx-fb.c b/drivers/gpu/drm/imx/imx-fb.c
new file mode 100644
index 0000000..5a08c86
--- /dev/null
+++ b/drivers/gpu/drm/imx/imx-fb.c
@@ -0,0 +1,179 @@
+/*
+ * i.MX drm driver
+ *
+ * Copyright (C) 2012 Sascha Hauer, Pengutronix
+ *
+ * Based on Samsung Exynos code
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/module.h>
+#include <drm/drmP.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+
+#include "imx-drm.h"
+
+#define to_imx_drm_fb(x)	container_of(x, struct imx_drm_fb, fb)
+
+/*
+ * imx specific framebuffer structure.
+ *
+ * @fb: drm framebuffer obejct.
+ * @imx_drm_gem_obj: drm ec specific gem object containing a gem object.
+ * @entry: pointer to ec drm buffer entry object.
+ *	- containing only the information to physically continuous memory
+ *	region allocated at default framebuffer creation.
+ */
+struct imx_drm_fb {
+	struct drm_framebuffer		fb;
+	struct imx_drm_gem_obj	*imx_drm_gem_obj;
+	struct imx_drm_buf_entry	*entry;
+};
+
+static void imx_drm_fb_destroy(struct drm_framebuffer *fb)
+{
+	struct imx_drm_fb *imx_drm_fb = to_imx_drm_fb(fb);
+
+	drm_framebuffer_cleanup(fb);
+
+	/*
+	 * default framebuffer has no gem object so
+	 * a buffer of the default framebuffer should be released at here.
+	 */
+	if (!imx_drm_fb->imx_drm_gem_obj && imx_drm_fb->entry)
+		imx_drm_buf_destroy(fb->dev, imx_drm_fb->entry);
+
+	kfree(imx_drm_fb);
+}
+
+static int imx_drm_fb_create_handle(struct drm_framebuffer *fb,
+		struct drm_file *file_priv, unsigned int *handle)
+{
+	struct imx_drm_fb *imx_drm_fb = to_imx_drm_fb(fb);
+
+	return drm_gem_handle_create(file_priv,
+			&imx_drm_fb->imx_drm_gem_obj->base, handle);
+}
+
+static struct drm_framebuffer_funcs imx_drm_fb_funcs = {
+	.destroy	= imx_drm_fb_destroy,
+	.create_handle	= imx_drm_fb_create_handle,
+};
+
+static struct drm_framebuffer *imx_drm_fb_create(struct drm_device *dev,
+		struct drm_file *file_priv, struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	struct imx_drm_fb *imx_drm_fb;
+	struct drm_framebuffer *fb;
+	struct drm_gem_object *obj;
+	unsigned int size;
+	int ret;
+	u32 bpp, depth;
+
+	drm_fb_get_bpp_depth(mode_cmd->pixel_format, &depth, &bpp);
+
+	mode_cmd->pitches[0] = max(mode_cmd->pitches[0],
+			mode_cmd->width * (bpp >> 3));
+
+	dev_dbg(dev->dev, "drm fb create(%dx%d)\n",
+			mode_cmd->width, mode_cmd->height);
+
+	imx_drm_fb = kzalloc(sizeof(*imx_drm_fb), GFP_KERNEL);
+	if (!imx_drm_fb) {
+		dev_err(dev->dev, "failed to allocate drm framebuffer.\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	fb = &imx_drm_fb->fb;
+	ret = drm_framebuffer_init(dev, fb, &imx_drm_fb_funcs);
+	if (ret) {
+		dev_err(dev->dev, "failed to initialize framebuffer.\n");
+		goto err_init;
+	}
+
+	dev_dbg(dev->dev, "create: fb id: %d\n", fb->base.id);
+
+	size = mode_cmd->pitches[0] * mode_cmd->height;
+
+	/*
+	 * without file_priv we are called from imx_drm_fbdev_create in which
+	 * case we only create a framebuffer without a handle.
+	 */
+	if (!file_priv) {
+		struct imx_drm_buf_entry *entry;
+
+		entry = imx_drm_buf_create(dev, size);
+		if (IS_ERR(entry)) {
+			ret = PTR_ERR(entry);
+			goto err_buffer;
+		}
+
+		imx_drm_fb->entry = entry;
+	} else {
+		obj = drm_gem_object_lookup(dev, file_priv, mode_cmd->handles[0]);
+		if (!obj) {
+			ret = -EINVAL;
+			goto err_buffer;
+		}
+
+		imx_drm_fb->imx_drm_gem_obj = to_imx_drm_gem_obj(obj);
+
+		drm_gem_object_unreference_unlocked(obj);
+
+		imx_drm_fb->entry = imx_drm_fb->imx_drm_gem_obj->entry;
+	}
+
+	drm_helper_mode_fill_fb_struct(fb, mode_cmd);
+
+	return fb;
+
+err_buffer:
+	drm_framebuffer_cleanup(fb);
+
+err_init:
+	kfree(imx_drm_fb);
+
+	return ERR_PTR(ret);
+}
+
+struct imx_drm_buf_entry *imx_drm_fb_get_buf(struct drm_framebuffer *fb)
+{
+	struct imx_drm_fb *imx_drm_fb = to_imx_drm_fb(fb);
+	struct imx_drm_buf_entry *entry;
+
+	entry = imx_drm_fb->entry;
+
+	return entry;
+}
+EXPORT_SYMBOL_GPL(imx_drm_fb_get_buf);
+
+static struct drm_mode_config_funcs imx_drm_mode_config_funcs = {
+	.fb_create = imx_drm_fb_create,
+};
+
+void imx_drm_mode_config_init(struct drm_device *dev)
+{
+	dev->mode_config.min_width = 64;
+	dev->mode_config.min_height = 64;
+
+	/*
+	 * set max width and height as default value(4096x4096).
+	 * this value would be used to check framebuffer size limitation
+	 * at drm_mode_addfb().
+	 */
+	dev->mode_config.max_width = 4096;
+	dev->mode_config.max_height = 4096;
+
+	dev->mode_config.funcs = &imx_drm_mode_config_funcs;
+}
diff --git a/drivers/gpu/drm/imx/imx-fbdev.c b/drivers/gpu/drm/imx/imx-fbdev.c
new file mode 100644
index 0000000..f038797
--- /dev/null
+++ b/drivers/gpu/drm/imx/imx-fbdev.c
@@ -0,0 +1,275 @@
+/*
+ * i.MX drm driver
+ *
+ * Copyright (C) 2012 Sascha Hauer, Pengutronix
+ *
+ * Based on Samsung Exynos code
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/module.h>
+#include <drm/drmP.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_crtc_helper.h>
+
+#include "imx-drm.h"
+
+#define MAX_CONNECTOR		4
+#define PREFERRED_BPP		16
+
+static struct fb_ops imx_drm_fb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+	.fb_check_var	= drm_fb_helper_check_var,
+	.fb_set_par	= drm_fb_helper_set_par,
+	.fb_blank	= drm_fb_helper_blank,
+	.fb_pan_display	= drm_fb_helper_pan_display,
+	.fb_setcmap	= drm_fb_helper_setcmap,
+};
+
+static int imx_drm_fbdev_update(struct drm_fb_helper *helper,
+				     struct drm_framebuffer *fb,
+				     unsigned int fb_width,
+				     unsigned int fb_height)
+{
+	struct fb_info *fbi = helper->fbdev;
+	struct drm_device *drm = helper->dev;
+	struct imx_drm_buf_entry *entry;
+	unsigned int size = fb_width * fb_height * (fb->bits_per_pixel >> 3);
+	unsigned long offset;
+
+	drm_fb_helper_fill_fix(fbi, fb->pitches[0], fb->depth);
+	drm_fb_helper_fill_var(fbi, helper, fb_width, fb_height);
+
+	entry = imx_drm_fb_get_buf(fb);
+	if (!entry) {
+		dev_dbg(drm->dev, "entry is null.\n");
+		return -EFAULT;
+	}
+
+	offset = fbi->var.xoffset * (fb->bits_per_pixel >> 3);
+	offset += fbi->var.yoffset * fb->pitches[0];
+
+	drm->mode_config.fb_base = entry->paddr;
+	fbi->screen_base = entry->vaddr + offset;
+	fbi->fix.smem_start = entry->paddr + offset;
+	fbi->screen_size = size;
+	fbi->fix.smem_len = size;
+	fbi->flags |= FBINFO_CAN_FORCE_OUTPUT;
+
+	return 0;
+}
+
+static int imx_drm_fbdev_create(struct drm_fb_helper *helper,
+				    struct drm_fb_helper_surface_size *sizes)
+{
+	struct drm_device *drm = helper->dev;
+	struct fb_info *fbi;
+	struct drm_framebuffer *fb;
+	struct drm_mode_fb_cmd2 mode_cmd = { 0 };
+	struct platform_device *pdev = drm->platformdev;
+	int ret;
+
+	dev_dbg(drm->dev, "surface width(%d), height(%d) and bpp(%d\n",
+			sizes->surface_width, sizes->surface_height,
+			sizes->surface_bpp);
+
+	mode_cmd.width = sizes->surface_width;
+	mode_cmd.height = sizes->surface_height;
+	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
+			sizes->surface_depth);
+
+	mutex_lock(&drm->struct_mutex);
+
+	fbi = framebuffer_alloc(0, &pdev->dev);
+	if (!fbi) {
+		ret = -ENOMEM;
+		goto err_fb_alloc;
+	}
+
+	fb = drm->mode_config.funcs->fb_create(drm, NULL, &mode_cmd);
+	if (IS_ERR(fb)) {
+		dev_err(drm->dev, "failed to create drm framebuffer.\n");
+		ret = PTR_ERR(fb);
+		goto err_fb_create;
+	}
+
+	helper->fb = fb;
+	helper->fbdev = fbi;
+
+	fbi->par = helper;
+	fbi->flags = FBINFO_FLAG_DEFAULT;
+	fbi->fbops = &imx_drm_fb_ops;
+
+	ret = fb_alloc_cmap(&fbi->cmap, 256, 0);
+	if (ret)
+		goto err_alloc_cmap;
+
+	ret = imx_drm_fbdev_update(helper, helper->fb, sizes->fb_width,
+			sizes->fb_height);
+	if (ret)
+		goto err_fbdev_update;
+
+	mutex_unlock(&drm->struct_mutex);
+
+	return 0;
+
+err_fbdev_update:
+	fb_dealloc_cmap(&fbi->cmap);
+
+err_alloc_cmap:
+	fb->funcs->destroy(fb);
+
+err_fb_create:
+	framebuffer_release(fbi);
+
+err_fb_alloc:
+	mutex_unlock(&drm->struct_mutex);
+
+	return ret;
+}
+
+static int imx_drm_fbdev_probe(struct drm_fb_helper *helper,
+				   struct drm_fb_helper_surface_size *sizes)
+{
+	int ret;
+
+	BUG_ON(helper->fb);
+
+	ret = imx_drm_fbdev_create(helper, sizes);
+	if (ret) {
+		dev_err(helper->dev->dev, "creating fbdev failed with %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * fb_helper expects a value more than 1 if succeed
+	 * because register_framebuffer() should be called.
+	 */
+	return 1;
+}
+
+static struct drm_fb_helper_funcs imx_drm_fb_helper_funcs = {
+	.fb_probe = imx_drm_fbdev_probe,
+};
+
+static struct drm_fb_helper *imx_drm_fbdev_init(struct drm_device *drm,
+		int preferred_bpp)
+{
+	struct drm_fb_helper *helper;
+	unsigned int num_crtc;
+	int ret;
+
+	helper = kzalloc(sizeof(*helper), GFP_KERNEL);
+	if (!helper)
+		return NULL;
+
+	helper->funcs = &imx_drm_fb_helper_funcs;
+
+	num_crtc = drm->mode_config.num_crtc;
+
+	ret = drm_fb_helper_init(drm, helper, num_crtc, MAX_CONNECTOR);
+	if (ret) {
+		dev_err(drm->dev, "initializing drm fb helper failed with %d\n",
+				ret);
+		goto err_init;
+	}
+
+	ret = drm_fb_helper_single_add_all_connectors(helper);
+	if (ret) {
+		dev_err(drm->dev, "registering drm_fb_helper_connector failed with %d\n",
+				ret);
+		goto err_setup;
+
+	}
+
+	ret = drm_fb_helper_initial_config(helper, preferred_bpp);
+	if (ret) {
+		dev_err(drm->dev, "initial config failed with %d\n", ret);
+		goto err_setup;
+	}
+
+	return helper;
+
+err_setup:
+	drm_fb_helper_fini(helper);
+
+err_init:
+	kfree(helper);
+
+	return NULL;
+}
+
+static void imx_drm_fbdev_fini(struct drm_fb_helper *helper)
+{
+	struct imx_drm_buf_entry *entry;
+
+	if (helper->fbdev) {
+		struct fb_info *info;
+		int ret;
+
+		info = helper->fbdev;
+		ret = unregister_framebuffer(info);
+		if (ret)
+			dev_err(helper->dev->dev, "unregister_framebuffer failed with %d\n",
+					ret);
+
+		if (info->cmap.len)
+			fb_dealloc_cmap(&info->cmap);
+
+		entry = imx_drm_fb_get_buf(helper->fb);
+
+		imx_drm_buf_destroy(helper->dev, entry);
+
+		framebuffer_release(info);
+	}
+
+	drm_fb_helper_fini(helper);
+
+	kfree(helper);
+}
+
+static struct drm_fb_helper *imx_fb_helper;
+
+static int __init imx_fb_helper_init(void)
+{
+	struct drm_device *drm = imx_drm_device_get();
+	int ret;
+
+	if (!drm)
+		return -EINVAL;
+
+	imx_fb_helper = imx_drm_fbdev_init(drm, PREFERRED_BPP);
+	if (!imx_fb_helper) {
+		imx_drm_device_put();
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void __exit imx_fb_helper_exit(void)
+{
+	imx_drm_fbdev_fini(imx_fb_helper);
+	imx_drm_device_put();
+}
+
+late_initcall(imx_fb_helper_init);
+module_exit(imx_fb_helper_exit);
+
+MODULE_DESCRIPTION("Freescale i.MX legacy fb driver");
+MODULE_AUTHOR("Sascha Hauer, Pengutronix");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/imx/imx-gem.c b/drivers/gpu/drm/imx/imx-gem.c
new file mode 100644
index 0000000..b0866fb
--- /dev/null
+++ b/drivers/gpu/drm/imx/imx-gem.c
@@ -0,0 +1,343 @@
+/*
+ * i.MX drm driver
+ *
+ * Copyright (C) 2012 Sascha Hauer, Pengutronix
+ *
+ * Based on Samsung Exynos code
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <drm/drmP.h>
+#include <drm/drm.h>
+#include <drm/drm_crtc_helper.h>
+
+#include "imx-drm.h"
+
+static int lowlevel_buffer_allocate(struct drm_device *drm,
+		struct imx_drm_buf_entry *entry)
+{
+	entry->vaddr = dma_alloc_writecombine(drm->dev, entry->size,
+			(dma_addr_t *)&entry->paddr, GFP_KERNEL);
+	if (!entry->vaddr) {
+		dev_err(drm->dev, "failed to allocate buffer.\n");
+		return -ENOMEM;
+	}
+
+	dev_dbg(drm->dev, "allocated : vaddr(0x%x), paddr(0x%x), size(0x%x)\n",
+			(unsigned int)entry->vaddr, entry->paddr, entry->size);
+
+	return 0;
+}
+
+static void lowlevel_buffer_free(struct drm_device *drm,
+		struct imx_drm_buf_entry *entry)
+{
+	dma_free_writecombine(drm->dev, entry->size, entry->vaddr,
+			entry->paddr);
+}
+
+struct imx_drm_buf_entry *imx_drm_buf_create(struct drm_device *drm,
+		unsigned int size)
+{
+	struct imx_drm_buf_entry *entry;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return ERR_PTR(-ENOMEM);
+
+	entry->size = size;
+
+	/*
+	 * allocate memory region with size and set the memory information
+	 * to vaddr and paddr of a entry object.
+	 */
+	if (lowlevel_buffer_allocate(drm, entry) < 0) {
+		kfree(entry);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return entry;
+}
+
+void imx_drm_buf_destroy(struct drm_device *drm,
+		struct imx_drm_buf_entry *entry)
+{
+	lowlevel_buffer_free(drm, entry);
+
+	kfree(entry);
+	entry = NULL;
+}
+EXPORT_SYMBOL_GPL(imx_drm_buf_destroy);
+
+static unsigned int convert_to_vm_err_msg(int msg)
+{
+	unsigned int out_msg;
+
+	switch (msg) {
+	case 0:
+	case -ERESTARTSYS:
+	case -EINTR:
+		out_msg = VM_FAULT_NOPAGE;
+		break;
+
+	case -ENOMEM:
+		out_msg = VM_FAULT_OOM;
+		break;
+
+	default:
+		out_msg = VM_FAULT_SIGBUS;
+		break;
+	}
+
+	return out_msg;
+}
+
+static unsigned int get_gem_mmap_offset(struct drm_gem_object *obj)
+{
+	return (unsigned int)obj->map_list.hash.key << PAGE_SHIFT;
+}
+
+static struct imx_drm_gem_obj *imx_drm_gem_create(struct drm_device *drm,
+		unsigned int size)
+{
+	struct imx_drm_gem_obj *imx_drm_gem_obj;
+	struct imx_drm_buf_entry *entry;
+	struct drm_gem_object *obj;
+	int ret;
+
+	size = roundup(size, PAGE_SIZE);
+
+	imx_drm_gem_obj = kzalloc(sizeof(*imx_drm_gem_obj), GFP_KERNEL);
+	if (!imx_drm_gem_obj)
+		return ERR_PTR(-ENOMEM);
+
+	/* allocate the new buffer object and memory region. */
+	entry = imx_drm_buf_create(drm, size);
+	if (!entry) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	imx_drm_gem_obj->entry = entry;
+
+	obj = &imx_drm_gem_obj->base;
+
+	ret = drm_gem_object_init(drm, obj, size);
+	if (ret) {
+		dev_err(drm->dev, "initializing GEM object failed with %d\n", ret);
+		goto err_obj_init;
+	}
+
+	ret = drm_gem_create_mmap_offset(obj);
+	if (ret) {
+		dev_err(drm->dev, "creating mmap offset failed with %d\n", ret);
+		goto err_create_mmap_offset;
+	}
+
+	return imx_drm_gem_obj;
+
+err_create_mmap_offset:
+	drm_gem_object_release(obj);
+
+err_obj_init:
+	imx_drm_buf_destroy(drm, imx_drm_gem_obj->entry);
+
+err_alloc:
+	kfree(imx_drm_gem_obj);
+
+	return ERR_PTR(ret);
+}
+
+static struct imx_drm_gem_obj *imx_drm_gem_create_with_handle(struct drm_file *file_priv,
+		struct drm_device *drm, unsigned int size,
+		unsigned int *handle)
+{
+	struct imx_drm_gem_obj *imx_drm_gem_obj;
+	struct drm_gem_object *obj;
+	int ret;
+
+	imx_drm_gem_obj = imx_drm_gem_create(drm, size);
+	if (IS_ERR(imx_drm_gem_obj))
+		return imx_drm_gem_obj;
+
+	obj = &imx_drm_gem_obj->base;
+
+	/*
+	 * allocate a id of idr table where the obj is registered
+	 * and handle has the id what user can see.
+	 */
+	ret = drm_gem_handle_create(file_priv, obj, handle);
+	if (ret)
+		goto err_handle_create;
+
+	/* drop reference from allocate - handle holds it now. */
+	drm_gem_object_unreference_unlocked(obj);
+
+	return imx_drm_gem_obj;
+
+err_handle_create:
+	imx_drm_gem_free_object(obj);
+
+	return ERR_PTR(ret);
+}
+
+static int imx_drm_gem_mmap_buffer(struct file *filp,
+		struct vm_area_struct *vma)
+{
+	struct drm_gem_object *obj = filp->private_data;
+	struct imx_drm_gem_obj *imx_drm_gem_obj = to_imx_drm_gem_obj(obj);
+	struct imx_drm_buf_entry *entry;
+	unsigned long pfn, vm_size;
+
+	vma->vm_flags |= VM_IO | VM_RESERVED;
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_file = filp;
+
+	vm_size = vma->vm_end - vma->vm_start;
+	/*
+	 * an entry contains information to physically continuous memory
+	 * allocated by user request or at framebuffer creation.
+	 */
+	entry = imx_drm_gem_obj->entry;
+
+	/* check if user-requested size is valid. */
+	if (vm_size > entry->size)
+		return -EINVAL;
+
+	/*
+	 * get page frame number to physical memory to be mapped
+	 * to user space.
+	 */
+	pfn = imx_drm_gem_obj->entry->paddr >> PAGE_SHIFT;
+
+	if (remap_pfn_range(vma, vma->vm_start, pfn, vm_size,
+				vma->vm_page_prot)) {
+		dev_err(obj->dev->dev, "failed to remap pfn range.\n");
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static const struct file_operations imx_drm_gem_fops = {
+	.mmap = imx_drm_gem_mmap_buffer,
+};
+
+int imx_drm_gem_init_object(struct drm_gem_object *obj)
+{
+	return 0;
+}
+
+void imx_drm_gem_free_object(struct drm_gem_object *gem_obj)
+{
+	struct imx_drm_gem_obj *imx_drm_gem_obj;
+
+	if (gem_obj->map_list.map)
+		drm_gem_free_mmap_offset(gem_obj);
+
+	drm_gem_object_release(gem_obj);
+
+	imx_drm_gem_obj = to_imx_drm_gem_obj(gem_obj);
+
+	imx_drm_buf_destroy(gem_obj->dev, imx_drm_gem_obj->entry);
+
+	kfree(imx_drm_gem_obj);
+}
+
+int imx_drm_gem_dumb_create(struct drm_file *file_priv,
+		struct drm_device *dev, struct drm_mode_create_dumb *args)
+{
+	struct imx_drm_gem_obj *imx_drm_gem_obj;
+
+	/* FIXME: This should be configured by the crtc driver */
+	args->pitch = args->width * args->bpp >> 3;
+	args->size = args->pitch * args->height;
+
+	imx_drm_gem_obj = imx_drm_gem_create_with_handle(file_priv, dev, args->size,
+			&args->handle);
+	if (IS_ERR(imx_drm_gem_obj))
+		return PTR_ERR(imx_drm_gem_obj);
+
+	return 0;
+}
+
+int imx_drm_gem_dumb_map_offset(struct drm_file *file_priv,
+		struct drm_device *drm, uint32_t handle, uint64_t *offset)
+{
+	struct imx_drm_gem_obj *imx_drm_gem_obj;
+	struct drm_gem_object *obj;
+
+	mutex_lock(&drm->struct_mutex);
+
+	obj = drm_gem_object_lookup(drm, file_priv, handle);
+	if (!obj) {
+		dev_err(drm->dev, "failed to lookup gem object\n");
+		mutex_unlock(&drm->struct_mutex);
+		return -EINVAL;
+	}
+
+	imx_drm_gem_obj = to_imx_drm_gem_obj(obj);
+
+	*offset = get_gem_mmap_offset(&imx_drm_gem_obj->base);
+
+	drm_gem_object_unreference(obj);
+
+	mutex_unlock(&drm->struct_mutex);
+
+	return 0;
+}
+
+int imx_drm_gem_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	struct drm_gem_object *obj = vma->vm_private_data;
+	struct imx_drm_gem_obj *imx_drm_gem_obj = to_imx_drm_gem_obj(obj);
+	struct drm_device *dev = obj->dev;
+	unsigned long pfn;
+	pgoff_t page_offset;
+	int ret;
+
+	page_offset = ((unsigned long)vmf->virtual_address -
+			vma->vm_start) >> PAGE_SHIFT;
+
+	mutex_lock(&dev->struct_mutex);
+
+	pfn = (imx_drm_gem_obj->entry->paddr >> PAGE_SHIFT) + page_offset;
+
+	ret = vm_insert_mixed(vma, (unsigned long)vmf->virtual_address, pfn);
+
+	mutex_unlock(&dev->struct_mutex);
+
+	return convert_to_vm_err_msg(ret);
+}
+
+int imx_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	int ret;
+
+	ret = drm_gem_mmap(filp, vma);
+	if (ret)
+		return ret;
+
+	vma->vm_flags &= ~VM_PFNMAP;
+	vma->vm_flags |= VM_MIXEDMAP;
+
+	return ret;
+}
+
+
+int imx_drm_gem_dumb_destroy(struct drm_file *file_priv,
+		struct drm_device *dev, unsigned int handle)
+{
+	return drm_gem_handle_delete(file_priv, handle);
+}
diff --git a/drivers/gpu/drm/imx/imx-lcdc-crtc.c b/drivers/gpu/drm/imx/imx-lcdc-crtc.c
new file mode 100644
index 0000000..e77c015
--- /dev/null
+++ b/drivers/gpu/drm/imx/imx-lcdc-crtc.c
@@ -0,0 +1,517 @@
+/*
+ * i.MX LCDC crtc driver
+ *
+ * Copyright (C) 2012 Sascha Hauer, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <drm/drmP.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <linux/fb.h>
+#include <linux/clk.h>
+#include <asm/fb.h>
+#include <linux/module.h>
+#include <mach/hardware.h>
+#include <mach/imxfb.h>
+#include <generated/mach-types.h>
+
+#include "imx-drm.h"
+
+#define LCDC_SSA		0x00
+#define LCDC_SIZE		0x04
+#define LCDC_VPW		0x08
+#define LCDC_CPOS		0x0C
+#define LCDC_LCWHB		0x10
+#define LCDC_LCHCC		0x14
+#define LCDC_PCR		0x18
+#define LCDC_HCR		0x1C
+#define LCDC_VCR		0x20
+#define LCDC_POS		0x24
+#define LCDC_LSCR1		0x28
+#define LCDC_PWMR		0x2C
+#define LCDC_DMACR		0x30
+#define LCDC_RMCR		0x34
+#define LCDC_LCDICR		0x38
+#define LCDC_LIER		0x3c
+#define LCDC_LISR		0x40
+
+#define SIZE_XMAX(x)		((((x) >> 4) & 0x3f) << 20)
+
+#define YMAX_MASK		(cpu_is_mx1() ? 0x1ff : 0x3ff)
+#define SIZE_YMAX(y)		((y) & YMAX_MASK)
+
+#define VPW_VPW(x)		((x) & 0x3ff)
+
+#define HCR_H_WIDTH(x)		(((x) & 0x3f) << 26)
+#define HCR_H_WAIT_1(x)		(((x) & 0xff) << 8)
+#define HCR_H_WAIT_2(x)		((x) & 0xff)
+
+#define VCR_V_WIDTH(x)		(((x) & 0x3f) << 26)
+#define VCR_V_WAIT_1(x)		(((x) & 0xff) << 8)
+#define VCR_V_WAIT_2(x)		((x) & 0xff)
+
+#define RMCR_LCDC_EN_MX1	(1 << 1)
+
+#define RMCR_SELF_REF		(1 << 0)
+
+#define LIER_EOF		(1 << 1)
+
+struct imx_crtc {
+	struct drm_crtc		base;
+	struct imx_drm_crtc	*imx_drm_crtc;
+	int			di_no;
+	int			enabled;
+	void __iomem		*regs;
+	u32			pwmr;
+	u32			lscr1;
+	u32			dmacr;
+	u32			pcr;
+	struct clk		*clk;
+	struct device		*dev;
+	int			vblank_enable;
+
+	struct drm_pending_vblank_event *page_flip_event;
+	struct drm_framebuffer	*newfb;
+};
+
+#define to_imx_crtc(x) container_of(x, struct imx_crtc, base)
+
+static void imx_crtc_load_lut(struct drm_crtc *crtc)
+{
+}
+
+#define PCR_BPIX_8		(3 << 25)
+#define PCR_BPIX_12		(4 << 25)
+#define PCR_BPIX_16		(5 << 25)
+#define PCR_BPIX_18		(6 << 25)
+#define PCR_END_SEL		(1 << 18)
+#define PCR_END_BYTE_SWAP	(1 << 17)
+
+const char *fourcc_to_str(u32 fourcc)
+{
+	static char buf[5];
+
+	*(u32 *)buf = fourcc;
+	buf[4] = 0;
+
+	return buf;
+}
+
+static int imx_drm_crtc_set(struct drm_crtc *crtc,
+		struct drm_display_mode *mode)
+{
+	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
+	struct drm_framebuffer *fb = crtc->fb;
+	int lower_margin = mode->vsync_start - mode->vdisplay;
+	int upper_margin = mode->vtotal - mode->vsync_end;
+	int vsync_len = mode->vsync_end - mode->vsync_start;
+	int hsync_len = mode->hsync_end - mode->hsync_start;
+	int right_margin = mode->hsync_start - mode->hdisplay;
+	int left_margin = mode->htotal - mode->hsync_end;
+	unsigned long lcd_clk;
+	u32 pcr;
+
+	lcd_clk = clk_get_rate(imx_crtc->clk) / 1000;
+
+	if (!mode->clock)
+		return -EINVAL;
+
+	pcr = DIV_ROUND_CLOSEST(lcd_clk, mode->clock);
+	if (--pcr > 0x3f)
+		pcr = 0x3f;
+
+	switch (fb->pixel_format) {
+	case DRM_FORMAT_XRGB8888:
+	case DRM_FORMAT_ARGB8888:
+		pcr |= PCR_BPIX_18;
+		pcr |= PCR_END_SEL | PCR_END_BYTE_SWAP;
+		break;
+	case DRM_FORMAT_RGB565:
+		if (cpu_is_mx1())
+			pcr |= PCR_BPIX_12;
+		else
+			pcr |= PCR_BPIX_16;
+		break;
+	case DRM_FORMAT_RGB332:
+		pcr |= PCR_BPIX_8;
+		break;
+	default:
+		dev_err(imx_crtc->dev, "unsupported pixel format %s\n",
+				fourcc_to_str(fb->pixel_format));
+		return -EINVAL;
+	}
+
+	/* add sync polarities */
+	pcr |= imx_crtc->pcr & ~(0x3f | (7 << 25));
+
+	dev_dbg(imx_crtc->dev,
+			"xres=%d hsync_len=%d left_margin=%d right_margin=%d\n",
+			mode->hdisplay, hsync_len,
+			left_margin, right_margin);
+	dev_dbg(imx_crtc->dev,
+			"yres=%d vsync_len=%d upper_margin=%d lower_margin=%d\n",
+			mode->vdisplay, vsync_len,
+			upper_margin, lower_margin);
+
+	writel(VPW_VPW(mode->hdisplay * fb->bits_per_pixel / 8 / 4),
+		imx_crtc->regs + LCDC_VPW);
+
+	writel(HCR_H_WIDTH(hsync_len - 1) |
+		HCR_H_WAIT_1(right_margin - 1) |
+		HCR_H_WAIT_2(left_margin - 3),
+		imx_crtc->regs + LCDC_HCR);
+
+	writel(VCR_V_WIDTH(vsync_len) |
+		VCR_V_WAIT_1(lower_margin) |
+		VCR_V_WAIT_2(upper_margin),
+		imx_crtc->regs + LCDC_VCR);
+
+	writel(SIZE_XMAX(mode->hdisplay) | SIZE_YMAX(mode->vdisplay),
+			imx_crtc->regs + LCDC_SIZE);
+
+	writel(pcr, imx_crtc->regs + LCDC_PCR);
+	writel(imx_crtc->pwmr, imx_crtc->regs + LCDC_PWMR);
+	writel(imx_crtc->lscr1, imx_crtc->regs + LCDC_LSCR1);
+	/* reset default */
+	writel(0x00040060, imx_crtc->regs + LCDC_DMACR);
+
+	return 0;
+}
+
+static int imx_drm_set_base(struct drm_crtc *crtc, int x, int y)
+{
+	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
+	struct imx_drm_buf_entry *entry;
+	struct drm_framebuffer *fb = crtc->fb;
+	unsigned long phys;
+
+	entry = imx_drm_fb_get_buf(fb);
+	if (!entry)
+		return -EFAULT;
+
+	phys = entry->paddr;
+	phys += x * (fb->bits_per_pixel >> 3);
+	phys += y * fb->pitches[0];
+
+	dev_dbg(imx_crtc->dev, "%s: phys: 0x%lx\n", __func__, phys);
+	dev_dbg(imx_crtc->dev, "%s: xy: %dx%d\n", __func__, x, y);
+
+	writel(phys, imx_crtc->regs + LCDC_SSA);
+
+	return 0;
+}
+
+static int imx_crtc_mode_set(struct drm_crtc *crtc,
+			       struct drm_display_mode *mode,
+			       struct drm_display_mode *adjusted_mode,
+			       int x, int y,
+			       struct drm_framebuffer *old_fb)
+{
+	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
+
+	imx_drm_set_base(crtc, x, y);
+
+	dev_dbg(imx_crtc->dev, "mode->hdisplay: %d\n", mode->hdisplay);
+	dev_dbg(imx_crtc->dev, "mode->vdisplay: %d\n", mode->vdisplay);
+
+	return imx_drm_crtc_set(crtc, mode);
+}
+
+static void imx_crtc_enable(struct imx_crtc *imx_crtc)
+{
+	if (!imx_crtc->enabled)
+		clk_enable(imx_crtc->clk);
+	imx_crtc->enabled = 1;
+}
+
+static void imx_crtc_disable(struct imx_crtc *imx_crtc)
+{
+	if (imx_crtc->enabled)
+		clk_disable(imx_crtc->clk);
+	imx_crtc->enabled = 0;
+}
+
+static void imx_crtc_dpms(struct drm_crtc *crtc, int mode)
+{
+	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
+
+	dev_dbg(imx_crtc->dev, "%s mode: %d\n", __func__, mode);
+
+	switch (mode) {
+	case DRM_MODE_DPMS_ON:
+		imx_crtc_enable(imx_crtc);
+		break;
+	default:
+		imx_crtc_disable(imx_crtc);
+		break;
+	}
+}
+
+static bool imx_crtc_mode_fixup(struct drm_crtc *crtc,
+				  struct drm_display_mode *mode,
+				  struct drm_display_mode *adjusted_mode)
+{
+	return true;
+}
+
+static void imx_crtc_prepare(struct drm_crtc *crtc)
+{
+	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
+
+	imx_crtc_disable(imx_crtc);
+}
+
+static void imx_crtc_commit(struct drm_crtc *crtc)
+{
+	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
+
+	imx_crtc_enable(imx_crtc);
+}
+
+static struct drm_crtc_helper_funcs imx_helper_funcs = {
+	.dpms = imx_crtc_dpms,
+	.mode_fixup = imx_crtc_mode_fixup,
+	.mode_set = imx_crtc_mode_set,
+	.prepare = imx_crtc_prepare,
+	.commit = imx_crtc_commit,
+	.load_lut = imx_crtc_load_lut,
+};
+
+static void imx_drm_handle_pageflip(struct imx_crtc *imx_crtc)
+{
+	struct drm_pending_vblank_event *e;
+	struct timeval now;
+	unsigned long flags;
+	struct drm_device *drm = imx_crtc->base.dev;
+
+	spin_lock_irqsave(&drm->event_lock, flags);
+
+	e = imx_crtc->page_flip_event;
+
+	if (!e) {
+		spin_unlock_irqrestore(&drm->event_lock, flags);
+		return;
+	}
+
+	do_gettimeofday(&now);
+	e->event.sequence = 0;
+	e->event.tv_sec = now.tv_sec;
+	e->event.tv_usec = now.tv_usec;
+	imx_crtc->page_flip_event = NULL;
+
+	list_add_tail(&e->base.link, &e->base.file_priv->event_list);
+
+	wake_up_interruptible(&e->base.file_priv->event_wait);
+
+	spin_unlock_irqrestore(&drm->event_lock, flags);
+}
+
+static int imx_crtc_enable_vblank(struct drm_crtc *crtc)
+{
+	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
+
+	writel(LIER_EOF, imx_crtc->regs + LCDC_LIER);
+
+	return 0;
+}
+
+static void imx_crtc_disable_vblank(struct drm_crtc *crtc)
+{
+	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
+
+	writel(0, imx_crtc->regs + LCDC_LIER);
+}
+
+static irqreturn_t imx_irq_handler(int irq, void *dev_id)
+{
+	struct imx_crtc *imx_crtc = dev_id;
+	struct drm_device *drm = imx_crtc->base.dev;
+
+	/* Acknowledge interrupt */
+	readl(imx_crtc->regs + LCDC_LISR);
+
+	drm_handle_vblank(drm, 0);
+
+	if (imx_crtc->newfb) {
+		imx_crtc->base.fb = imx_crtc->newfb;
+		imx_crtc->newfb = NULL;
+		imx_drm_set_base(&imx_crtc->base, 0, 0);
+		imx_drm_handle_pageflip(imx_crtc);
+		imx_drm_crtc_vblank_put(imx_crtc->imx_drm_crtc);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int imx_page_flip(struct drm_crtc *crtc,
+                         struct drm_framebuffer *fb,
+                         struct drm_pending_vblank_event *event)
+{
+	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
+
+	if (imx_crtc->newfb)
+		return -EBUSY;
+
+	imx_crtc->newfb = fb;
+	imx_crtc->page_flip_event = event;
+	imx_drm_crtc_vblank_get(imx_crtc->imx_drm_crtc);
+
+	return 0;
+}
+
+static const struct drm_crtc_funcs imx_crtc_funcs = {
+	.page_flip = imx_page_flip,
+};
+
+static const struct imx_drm_crtc_helper_funcs imx_imx_drm_helper = {
+	.enable_vblank = imx_crtc_enable_vblank,
+	.disable_vblank = imx_crtc_disable_vblank,
+};
+
+#define DRIVER_NAME "imx-lcdc-crtc"
+
+/*
+ * the pcr bits to be allowed to set in platform data
+ */
+#define PDATA_PCR	(PCR_PIXPOL | PCR_FLMPOL | PCR_LPPOL | \
+			PCR_CLKPOL | PCR_OEPOL | PCR_TFT | PCR_COLOR | \
+			PCR_PBSIZ_8 | PCR_ACD(0x7f) | PCR_ACD_SEL | \
+			PCR_SCLK_SEL | PCR_SHARP)
+
+static int __devinit imx_crtc_probe(struct platform_device *pdev)
+{
+	struct imx_crtc *imx_crtc;
+	struct resource *res;
+	int ret, irq;
+	u32 pcr_value = 0xf00080c0;
+	u32 lscr1_value = 0x00120300;
+	u32 pwmr_value = 0x00a903ff;
+
+	imx_crtc = devm_kzalloc(&pdev->dev, sizeof(*imx_crtc), GFP_KERNEL);
+	if (!imx_crtc)
+		return -ENOMEM;
+
+	imx_crtc->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	res = devm_request_mem_region(&pdev->dev, res->start,
+			resource_size(res), DRIVER_NAME);
+	if (!res)
+		return -EBUSY;
+
+	imx_crtc->regs = devm_ioremap(&pdev->dev, res->start,
+			resource_size(res));
+	if (!imx_crtc->regs) {
+		dev_err(&pdev->dev, "Cannot map frame buffer registers\n");
+		return -EBUSY;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	ret = devm_request_irq(&pdev->dev, irq, imx_irq_handler, 0, "imx_drm",
+			imx_crtc);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "irq request failed with %d\n", ret);
+		return ret;
+	}
+
+	imx_crtc->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(imx_crtc->clk)) {
+		ret = PTR_ERR(imx_crtc->clk);
+		dev_err(&pdev->dev, "unable to get clock: %d\n", ret);
+		return ret;
+	}
+
+	clk_prepare_enable(imx_crtc->clk);
+	imx_crtc->enabled = 1;
+
+	platform_set_drvdata(pdev, imx_crtc);
+
+	imx_crtc->pcr = pcr_value & PDATA_PCR;
+
+	if (imx_crtc->pcr != pcr_value)
+		dev_err(&pdev->dev, "invalid bits set in pcr: 0x%08x\n",
+				pcr_value & ~PDATA_PCR);
+
+	imx_crtc->lscr1 = lscr1_value;
+	imx_crtc->pwmr = pwmr_value;
+
+	ret = imx_drm_add_crtc(&imx_crtc->base,
+			&imx_crtc->imx_drm_crtc,
+			&imx_crtc_funcs, &imx_helper_funcs,
+			&imx_imx_drm_helper, THIS_MODULE);
+	if (ret)
+		goto err_init;
+
+	dev_info(&pdev->dev, "probed\n");
+
+	return 0;
+
+err_init:
+	clk_disable_unprepare(imx_crtc->clk);
+	clk_put(imx_crtc->clk);
+
+	return ret;
+}
+
+static int __devexit imx_crtc_remove(struct platform_device *pdev)
+{
+	struct imx_crtc *imx_crtc = platform_get_drvdata(pdev);
+
+	imx_drm_remove_crtc(imx_crtc->imx_drm_crtc);
+
+	writel(0, imx_crtc->regs + LCDC_LIER);
+
+	clk_disable_unprepare(imx_crtc->clk);
+	clk_put(imx_crtc->clk);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static const struct of_device_id imx_lcdc_dt_ids[] = {
+	{ .compatible = "fsl,imx1-lcdc", .data = NULL, },
+	{ .compatible = "fsl,imx21-lcdc", .data = NULL, },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver imx_crtc_driver = {
+	.remove		= __devexit_p(imx_crtc_remove),
+	.probe		= imx_crtc_probe,
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+		.of_match_table = imx_lcdc_dt_ids,
+	},
+};
+
+static int __init imx_lcdc_init(void)
+{
+	return platform_driver_register(&imx_crtc_driver);
+}
+
+static void __exit imx_lcdc_exit(void)
+{
+	platform_driver_unregister(&imx_crtc_driver);
+}
+
+module_init(imx_lcdc_init);
+module_exit(imx_lcdc_exit)
+
+MODULE_DESCRIPTION("Freescale i.MX framebuffer driver");
+MODULE_AUTHOR("Sascha Hauer, Pengutronix");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/imx/imx-parallel-display.c b/drivers/gpu/drm/imx/imx-parallel-display.c
new file mode 100644
index 0000000..8c96113
--- /dev/null
+++ b/drivers/gpu/drm/imx/imx-parallel-display.c
@@ -0,0 +1,228 @@
+/*
+ * i.MX drm driver - parallel display implementation
+ *
+ * Copyright (C) 2012 Sascha Hauer, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#include <linux/module.h>
+#include <drm/drmP.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_crtc_helper.h>
+
+#include "imx-drm.h"
+
+#define con_to_imxpd(x) container_of(x, struct imx_parallel_display, connector)
+#define enc_to_imxpd(x) container_of(x, struct imx_parallel_display, encoder)
+
+struct imx_parallel_display {
+	struct drm_connector connector;
+	struct imx_drm_connector *imx_drm_connector;
+	struct drm_encoder encoder;
+	struct imx_drm_encoder *imx_drm_encoder;
+	struct device *dev;
+	void *edid;
+	int edid_len;
+};
+
+static enum drm_connector_status imx_pd_connector_detect(struct drm_connector *connector,
+		bool force)
+{
+	return connector_status_connected;
+}
+
+static void imx_pd_connector_destroy(struct drm_connector *connector)
+{
+	/* do not free here */
+}
+
+static int imx_pd_connector_get_modes(struct drm_connector *connector)
+{
+	struct imx_parallel_display *imxpd = con_to_imxpd(connector);
+	int ret;
+
+	drm_mode_connector_update_edid_property(connector, imxpd->edid);
+	ret = drm_add_edid_modes(connector, imxpd->edid);
+	connector->display_info.raw_edid = NULL;
+
+	return ret;
+}
+
+static int imx_pd_connector_mode_valid(struct drm_connector *connector,
+			  struct drm_display_mode *mode)
+{
+	return 0;
+}
+
+static struct drm_encoder *imx_pd_connector_best_encoder(struct drm_connector *connector)
+{
+	struct imx_parallel_display *imxpd = con_to_imxpd(connector);
+
+	return &imxpd->encoder;
+}
+
+static void imx_pd_encoder_dpms(struct drm_encoder *encoder, int mode)
+{
+}
+
+static bool imx_pd_encoder_mode_fixup(struct drm_encoder *encoder,
+			   struct drm_display_mode *mode,
+			   struct drm_display_mode *adjusted_mode)
+{
+	return true;
+}
+
+static void imx_pd_encoder_prepare(struct drm_encoder *encoder)
+{
+}
+
+static void imx_pd_encoder_commit(struct drm_encoder *encoder)
+{
+}
+
+static void imx_pd_encoder_mode_set(struct drm_encoder *encoder,
+			 struct drm_display_mode *mode,
+			 struct drm_display_mode *adjusted_mode)
+{
+}
+
+static void imx_pd_encoder_disable(struct drm_encoder *encoder)
+{
+}
+
+static void imx_pd_encoder_destroy(struct drm_encoder *encoder)
+{
+	/* do not free here */
+}
+
+struct drm_connector_funcs imx_pd_connector_funcs = {
+	.dpms = drm_helper_connector_dpms,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.detect = imx_pd_connector_detect,
+	.destroy = imx_pd_connector_destroy,
+};
+
+struct drm_connector_helper_funcs imx_pd_connector_helper_funcs = {
+	.get_modes = imx_pd_connector_get_modes,
+	.best_encoder = imx_pd_connector_best_encoder,
+	.mode_valid = imx_pd_connector_mode_valid,
+};
+
+static struct drm_encoder_funcs imx_pd_encoder_funcs = {
+	.destroy = imx_pd_encoder_destroy,
+};
+
+static struct drm_encoder_helper_funcs imx_pd_encoder_helper_funcs = {
+	.dpms = imx_pd_encoder_dpms,
+	.mode_fixup = imx_pd_encoder_mode_fixup,
+	.prepare = imx_pd_encoder_prepare,
+	.commit = imx_pd_encoder_commit,
+	.mode_set = imx_pd_encoder_mode_set,
+	.disable = imx_pd_encoder_disable,
+};
+
+static int imx_pd_register(struct imx_parallel_display *imxpd)
+{
+	int ret;
+
+	drm_mode_connector_attach_encoder(&imxpd->connector, &imxpd->encoder);
+
+	imxpd->connector.funcs = &imx_pd_connector_funcs;
+	imxpd->encoder.funcs = &imx_pd_encoder_funcs;
+
+	drm_encoder_helper_add(&imxpd->encoder, &imx_pd_encoder_helper_funcs);
+	ret = imx_drm_add_encoder(&imxpd->encoder, &imxpd->imx_drm_encoder, THIS_MODULE);
+	if (ret) {
+		dev_err(imxpd->dev, "adding encoder failed with %d\n", ret);
+		return ret;
+	}
+
+	drm_connector_helper_add(&imxpd->connector, &imx_pd_connector_helper_funcs);
+
+	ret = imx_drm_add_connector(&imxpd->connector, &imxpd->imx_drm_connector,
+			THIS_MODULE);
+	if (ret) {
+		imx_drm_remove_encoder(imxpd->imx_drm_encoder);
+		dev_err(imxpd->dev, "adding connector failed with %d\n", ret);
+		return ret;
+	}
+
+	imxpd->connector.encoder = &imxpd->encoder;
+
+	return 0;
+}
+
+static int __devinit imx_pd_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const u8 *edidp;
+	struct imx_parallel_display *imxpd;
+	int ret;
+
+	imxpd = devm_kzalloc(&pdev->dev, sizeof(*imxpd), GFP_KERNEL);
+	if (!imxpd)
+		return -ENOMEM;
+
+	edidp = of_get_property(np, "edid", &imxpd->edid_len);
+
+	imxpd->edid = kmemdup(edidp, imxpd->edid_len, GFP_KERNEL);
+	imxpd->encoder.possible_crtcs = 0x1;
+	imxpd->encoder.possible_clones = 0x1;
+	imxpd->dev = &pdev->dev;
+
+	ret = imx_pd_register(imxpd);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, imxpd);
+
+	return 0;
+}
+
+static int __devexit imx_pd_remove(struct platform_device *pdev)
+{
+	struct imx_parallel_display *imxpd = platform_get_drvdata(pdev);
+	struct drm_connector *connector = &imxpd->connector;
+	struct drm_encoder *encoder = &imxpd->encoder;
+
+	drm_mode_connector_detach_encoder(connector, encoder);
+
+	imx_drm_remove_connector(imxpd->imx_drm_connector);
+	imx_drm_remove_encoder(imxpd->imx_drm_encoder);
+
+	return 0;
+}
+
+static const struct of_device_id imx_pd_dt_ids[] = {
+	{ .compatible = "fsl,imx-parallel-display", .data = NULL, },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver imx_pd_driver = {
+	.probe		= imx_pd_probe,
+	.remove		= __devexit_p(imx_pd_remove),
+	.driver		= {
+		.of_match_table = imx_pd_dt_ids,
+		.name	= "imx-parallel-display",
+		.owner	= THIS_MODULE,
+	},
+};
+
+module_platform_driver(imx_pd_driver);
+
+MODULE_DESCRIPTION("i.MX parallel display driver");
+MODULE_AUTHOR("Sascha Hauer, Pengutronix");
+MODULE_LICENSE("GPL");
-- 
1.7.10
