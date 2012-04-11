From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Apr 2012 17:33:44 +0200
Subject: [PATCH 3/7] DRM: add sdrm layer for general embedded system support
In-Reply-To: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
References: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334158428-23735-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for creating simple drm devices. The
basic idea of this patch is that drm drivers using the sdrm layer
no longer have to implement a full drm device but instead only
register crtcs, encoders and connectors with the sdrm layer. The
sdrm layer then registers a drm device with the drm core and
takes care of the drm device.

Adding this layer has advantages especially for embedded devices.
On these type of devices there is no single device (pci card on
PCs) with which the drm core can be initialized, instead there
are multiple devices. The crtc usually is on the SoC, but
encoders and connectors are usually board specific, they can be
on the SoC, but can also be externally connected via i2c or can
be completely transparent to software. Also the components used
to compose a drm device vary from board to board.

While the components of a drm device are highly board specific
with embedded systems the the general interfacing with the drm
layer tends to be identical across most SoCs which involves a lot
of code duplication. By making the crtc/encoder/connector helpers
mandatory much of this duplication can be avoided.

This patch is based on the exynos drm driver with the exynos_
prefix replaced with a sdrm_ prefix.

The 's' in sdrm has no special meaning, depending on what you
think about it it can stand for 'Simple', 'Stupid', or 'Saschas'
drm.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/gpu/drm/Kconfig           |    2 +
 drivers/gpu/drm/Makefile          |    1 +
 drivers/gpu/drm/sdrm/Kconfig      |    8 +
 drivers/gpu/drm/sdrm/Makefile     |    2 +
 drivers/gpu/drm/sdrm/sdrm.c       |  904 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sdrm/sdrm.h       |   57 +++
 drivers/gpu/drm/sdrm/sdrm_fb.c    |  191 ++++++++
 drivers/gpu/drm/sdrm/sdrm_fbdev.c |  238 ++++++++++
 drivers/gpu/drm/sdrm/sdrm_gem.c   |  342 ++++++++++++++
 include/drm/sdrm.h                |  102 +++++
 10 files changed, 1847 insertions(+)
 create mode 100644 drivers/gpu/drm/sdrm/Kconfig
 create mode 100644 drivers/gpu/drm/sdrm/Makefile
 create mode 100644 drivers/gpu/drm/sdrm/sdrm.c
 create mode 100644 drivers/gpu/drm/sdrm/sdrm.h
 create mode 100644 drivers/gpu/drm/sdrm/sdrm_fb.c
 create mode 100644 drivers/gpu/drm/sdrm/sdrm_fbdev.c
 create mode 100644 drivers/gpu/drm/sdrm/sdrm_gem.c
 create mode 100644 include/drm/sdrm.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index e354bc0..93d9f79 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -186,3 +186,5 @@ source "drivers/gpu/drm/vmwgfx/Kconfig"
 source "drivers/gpu/drm/gma500/Kconfig"
 
 source "drivers/gpu/drm/udl/Kconfig"
+
+source "drivers/gpu/drm/sdrm/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index c20da5b..44c5949 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -42,4 +42,5 @@ obj-$(CONFIG_DRM_NOUVEAU) +=nouveau/
 obj-$(CONFIG_DRM_EXYNOS) +=exynos/
 obj-$(CONFIG_DRM_GMA500) += gma500/
 obj-$(CONFIG_DRM_UDL) += udl/
+obj-$(CONFIG_DRM_SDRM) += sdrm/
 obj-y			+= i2c/
diff --git a/drivers/gpu/drm/sdrm/Kconfig b/drivers/gpu/drm/sdrm/Kconfig
new file mode 100644
index 0000000..2424b2c
--- /dev/null
+++ b/drivers/gpu/drm/sdrm/Kconfig
@@ -0,0 +1,8 @@
+config DRM_SDRM
+	tristate
+	depends on DRM
+	select DRM_KMS_HELPER
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+
diff --git a/drivers/gpu/drm/sdrm/Makefile b/drivers/gpu/drm/sdrm/Makefile
new file mode 100644
index 0000000..c603f1b
--- /dev/null
+++ b/drivers/gpu/drm/sdrm/Makefile
@@ -0,0 +1,2 @@
+drm-sdrm-objs := sdrm.o sdrm_gem.o sdrm_fbdev.o sdrm_fb.o
+obj-$(CONFIG_DRM_SDRM) += drm-sdrm.o
diff --git a/drivers/gpu/drm/sdrm/sdrm.c b/drivers/gpu/drm/sdrm/sdrm.c
new file mode 100644
index 0000000..2077419
--- /dev/null
+++ b/drivers/gpu/drm/sdrm/sdrm.c
@@ -0,0 +1,904 @@
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
+#include <drm/sdrm.h>
+#include "sdrm.h"
+
+#define DRIVER_NAME		"drm-generic"
+#define DRIVER_DESC		"drm generic graphics"
+#define DRIVER_DATE		"20110604"
+#define DRIVER_MAJOR		1
+#define DRIVER_MINOR		0
+#define DRIVER_PATCHLEVEL	0
+
+struct sdrm_device {
+	struct drm_device		*drm;
+	struct platform_device		*pdev;
+	struct drm_fb_helper		*fb_helper;
+	struct list_head		crtc_list;
+	struct list_head		encoder_list;
+	struct list_head		connector_list;
+	struct list_head		list;
+	const char			*name;
+	int				registered;
+	struct mutex			mutex;
+	struct drm_driver		driver;
+};
+
+struct sdrm_crtc {
+	struct drm_crtc			*crtc;
+	struct list_head		list;
+	struct sdrm_device		*sdrm;
+	int				registered;
+	int				pipe;
+	struct drm_crtc_helper_funcs	crtc_helper_funcs;
+	struct drm_crtc_funcs		crtc_funcs;
+	struct sdrm_crtc_helper_funcs	sdrm_helper_funcs;
+};
+
+struct sdrm_encoder {
+	struct drm_encoder		*encoder;
+	struct list_head		list;
+	struct sdrm_device		*sdrm;
+	int				registered;
+	struct module			*owner;
+};
+
+struct sdrm_connector {
+	struct drm_connector		*connector;
+	struct list_head		list;
+	struct sdrm_device		*sdrm;
+	int				registered;
+	struct module			*owner;
+};
+
+static int sdrm_driver_open(struct drm_device *drm, struct drm_file *file)
+{
+	struct sdrm_device *sdrm = drm->dev_private;
+
+	if (!try_module_get(sdrm->pdev->dev.driver->owner)) {
+		dev_err(drm->dev, "could not get module %s\n",
+				module_name(sdrm->pdev->dev.driver->owner));
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void sdrm_driver_lastclose(struct drm_device *drm)
+{
+	struct sdrm_device *sdrm = drm->dev_private;
+
+	module_put(sdrm->pdev->dev.driver->owner);
+
+	/*
+	 * This shouldn't be here. If multiple drm applications (i.e. two
+	 * xservers) are running and the active one crashes then we will
+	 * only restore fbdev mode when the other one exits aswell. Anyway,
+	 * this is what all other drivers so for now we do it aswell.
+	 */
+	drm_fb_helper_restore_fbdev_mode(sdrm->fb_helper);
+}
+
+static int sdrm_driver_unload(struct drm_device *drm)
+{
+	struct sdrm_device *sdrm = drm->dev_private;
+
+	sdrm_fbdev_fini(sdrm->fb_helper);
+	sdrm->fb_helper = NULL;
+
+	drm_mode_config_cleanup(sdrm->drm);
+	drm_kms_helper_poll_fini(sdrm->drm);
+
+	return 0;
+}
+
+static int sdrm_suspend(struct drm_device *drm, pm_message_t state)
+{
+	/* TODO */
+
+	return 0;
+}
+
+static int sdrm_resume(struct drm_device *drm)
+{
+	/* TODO */
+
+	return 0;
+}
+
+/*
+ * We don't care at all for crtc numbers, but the core expects the
+ * crtcs to be numbered
+ */
+static struct sdrm_crtc *sdrm_crtc_by_num(struct sdrm_device *sdrm, int num)
+{
+	struct sdrm_crtc *sdrm_crtc;
+
+	list_for_each_entry(sdrm_crtc, &sdrm->crtc_list, list)
+		if (sdrm_crtc->pipe == num)
+			return sdrm_crtc;
+	return NULL;
+}
+
+int sdrm_crtc_vblank_get(struct sdrm_crtc *sdrm_crtc)
+{
+	return drm_vblank_get(sdrm_crtc->sdrm->drm, sdrm_crtc->pipe);
+}
+EXPORT_SYMBOL_GPL(sdrm_crtc_vblank_get);
+
+void sdrm_crtc_vblank_put(struct sdrm_crtc *sdrm_crtc)
+{
+	drm_vblank_put(sdrm_crtc->sdrm->drm, sdrm_crtc->pipe);
+}
+EXPORT_SYMBOL_GPL(sdrm_crtc_vblank_put);
+
+void sdrm_handle_vblank(struct sdrm_crtc *sdrm_crtc)
+{
+	struct sdrm_device *sdrm = sdrm_crtc->sdrm;
+
+	if (sdrm->registered)
+		drm_handle_vblank(sdrm_crtc->sdrm->drm, sdrm_crtc->pipe);
+}
+EXPORT_SYMBOL_GPL(sdrm_handle_vblank);
+
+static int sdrm_enable_vblank(struct drm_device *drm, int crtc)
+{
+	struct sdrm_device *sdrm = drm->dev_private;
+	struct sdrm_crtc *sdrm_crtc;
+	int ret;
+
+	sdrm_crtc = sdrm_crtc_by_num(sdrm, crtc);
+	if (!sdrm_crtc)
+		return -EINVAL;
+
+	if (!sdrm_crtc->sdrm_helper_funcs.enable_vblank)
+		return -ENOSYS;
+
+	ret = sdrm_crtc->sdrm_helper_funcs.enable_vblank(sdrm_crtc->crtc);
+	return ret;
+}
+
+static void sdrm_disable_vblank(struct drm_device *drm, int crtc)
+{
+	struct sdrm_device *sdrm = drm->dev_private;
+	struct sdrm_crtc *sdrm_crtc;
+
+	sdrm_crtc = sdrm_crtc_by_num(sdrm, crtc);
+	if (!sdrm_crtc)
+		return;
+
+	if (!sdrm_crtc->sdrm_helper_funcs.disable_vblank)
+		return;
+
+	sdrm_crtc->sdrm_helper_funcs.disable_vblank(sdrm_crtc->crtc);
+}
+
+static struct vm_operations_struct sdrm_gem_vm_ops = {
+	.fault = sdrm_gem_fault,
+	.open = drm_gem_vm_open,
+	.close = drm_gem_vm_close,
+};
+
+static struct drm_ioctl_desc sdrm_ioctls[] = {
+	/* none so far */
+};
+
+static const struct file_operations sdrm_driver_fops = {
+	 .owner = THIS_MODULE,
+	 .open = drm_open,
+	 .release = drm_release,
+	 .unlocked_ioctl = drm_ioctl,
+	 .mmap = sdrm_gem_mmap,
+	 .poll = drm_poll,
+	 .fasync = drm_fasync,
+	 .read = drm_read,
+	 .llseek = noop_llseek,
+};
+
+static int sdrm_get_irq(struct drm_device *dev)
+{
+	/*
+	 * Return an arbitrary number to make the core happy.
+	 * We can't return anything meaningful here since drm
+	 * devices in general have multiple irqs
+	 */
+	return 1234;
+}
+
+static struct drm_bus drm_platform_bus = {
+	.bus_type = DRIVER_BUS_PLATFORM,
+	.get_irq = sdrm_get_irq,
+};
+
+static struct drm_driver sdrm_driver_template = {
+	.driver_features	= DRIVER_MODESET | DRIVER_GEM,
+	.unload			= sdrm_driver_unload,
+	.open			= sdrm_driver_open,
+	.lastclose		= sdrm_driver_lastclose,
+	.gem_free_object	= sdrm_gem_free_object,
+	.gem_vm_ops		= &sdrm_gem_vm_ops,
+	.dumb_create		= sdrm_gem_dumb_create,
+	.dumb_map_offset	= sdrm_gem_dumb_map_offset,
+	.dumb_destroy		= sdrm_gem_dumb_destroy,
+
+	.suspend		= sdrm_suspend,
+	.resume			= sdrm_resume,
+
+	.get_vblank_counter	= drm_vblank_count,
+	.enable_vblank		= sdrm_enable_vblank,
+	.disable_vblank		= sdrm_disable_vblank,
+	.reclaim_buffers	= drm_core_reclaim_buffers,
+	.ioctls			= sdrm_ioctls,
+	.num_ioctls		= ARRAY_SIZE(sdrm_ioctls),
+	.bus			= &drm_platform_bus,
+	.fops			= &sdrm_driver_fops,
+	.name			= DRIVER_NAME,
+	.desc			= DRIVER_DESC,
+	.date			= DRIVER_DATE,
+	.major			= DRIVER_MAJOR,
+	.minor			= DRIVER_MINOR,
+	.patchlevel		= DRIVER_PATCHLEVEL,
+};
+
+static LIST_HEAD(sdrm_device_list);
+static DEFINE_MUTEX(sdrm_list_mutex);
+
+/*
+ * sdrm_device_get - find or allocate sdrm device with unique name
+ *
+ * This function returns the sdrm device with the unique name 'name'
+ * If this already exists, return it, otherwise allocate a new
+ * object.
+ */
+static struct sdrm_device *sdrm_device_get(const char *name)
+{
+	struct sdrm_device *sdrm;
+
+	mutex_lock(&sdrm_list_mutex);
+
+	list_for_each_entry(sdrm, &sdrm_device_list, list)
+		if (!strcmp(sdrm->name, name))
+			goto out;
+
+	mutex_unlock(&sdrm_list_mutex);
+
+	sdrm = kzalloc(sizeof(*sdrm), GFP_KERNEL);
+	if (!sdrm)
+		goto out;
+
+	mutex_init(&sdrm->mutex);
+	INIT_LIST_HEAD(&sdrm->crtc_list);
+	INIT_LIST_HEAD(&sdrm->connector_list);
+	INIT_LIST_HEAD(&sdrm->encoder_list);
+
+	sdrm->name = kstrdup(name, GFP_KERNEL);
+	if (!sdrm->name) {
+		kfree(sdrm);
+		goto out;
+	}
+
+	mutex_lock(&sdrm_list_mutex);
+
+	list_add_tail(&sdrm->list, &sdrm_device_list);
+out:
+	mutex_unlock(&sdrm_list_mutex);
+
+	return sdrm;
+}
+
+/*
+ * sdrm_device_maybe_release - free sdrm device if noone is using it
+ *
+ * If we have no crtcs, connectors and encoders registered for this
+ * device we can free it. Caller must hold sdrm->mutex.
+ */
+static void sdrm_device_maybe_release(struct sdrm_device *sdrm)
+{
+	if (!list_empty(&sdrm->crtc_list))
+		return;
+	if (!list_empty(&sdrm->connector_list))
+		return;
+	if (!list_empty(&sdrm->encoder_list))
+		return;
+
+	mutex_lock(&sdrm_list_mutex);
+	list_del(&sdrm->list);
+	mutex_unlock(&sdrm_list_mutex);
+
+	kfree(sdrm->name);
+	kfree(sdrm);
+}
+
+/*
+ * I think this legacy modegroup handling should be removed and we
+ * have a patch for this which also defines HAVE_MODEGROUP_REMOVED
+ * For now ifdef this here to make this work with and without this
+ * patch.
+ */
+#ifndef HAVE_MODEGROUP_REMOVED
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
+#else
+static int drm_mode_group_reinit(struct drm_device *dev)
+{
+	return 0;
+}
+#endif
+
+/*
+ * register an encoder to the drm core
+ */
+static int sdrm_encoder_register(struct sdrm_encoder *sdrm_encoder)
+{
+	struct sdrm_device *sdrm = sdrm_encoder->sdrm;
+
+	if (!try_module_get(sdrm_encoder->owner))
+		return -ENODEV;
+
+	drm_encoder_init(sdrm->drm, sdrm_encoder->encoder,
+			sdrm_encoder->encoder->funcs,
+			DRM_MODE_ENCODER_TMDS);
+
+	drm_mode_group_reinit(sdrm->drm);
+
+	sdrm_encoder->registered = 1;
+
+	return 0;
+}
+
+/*
+ * unregister an encoder from the drm core
+ */
+static void sdrm_encoder_unregister(struct sdrm_encoder *sdrm_encoder)
+{
+	struct sdrm_device *sdrm = sdrm_encoder->sdrm;
+
+	if (!sdrm_encoder->registered)
+		return;
+
+	if (sdrm->registered)
+		drm_encoder_cleanup(sdrm_encoder->encoder);
+
+	drm_mode_group_reinit(sdrm->drm);
+
+	sdrm_encoder->registered = 0;
+
+	module_put(sdrm_encoder->owner);
+}
+
+/*
+ * register a connector to the drm core
+ */
+static int sdrm_connector_register(struct sdrm_connector *sdrm_connector)
+{
+	struct sdrm_device *sdrm = sdrm_connector->sdrm;
+	int ret;
+
+	if (!try_module_get(sdrm_connector->owner))
+		return -ENODEV;
+
+	drm_connector_init(sdrm->drm, sdrm_connector->connector,
+			sdrm_connector->connector->funcs,
+			DRM_MODE_CONNECTOR_VGA);
+	drm_mode_group_reinit(sdrm->drm);
+	ret = drm_sysfs_connector_add(sdrm_connector->connector);
+	if (ret)
+		goto err;
+
+	sdrm_connector->registered = 1;
+
+	return 0;
+err:
+	module_put(sdrm_connector->owner);
+
+	return ret;
+}
+
+/*
+ * unregister a connector from the drm core
+ */
+static void sdrm_connector_unregister(struct sdrm_connector *sdrm_connector)
+{
+	struct sdrm_device *sdrm = sdrm_connector->sdrm;
+
+	if (!sdrm_connector->registered)
+		return;
+
+	if (sdrm->registered) {
+		drm_sysfs_connector_remove(sdrm_connector->connector);
+		drm_connector_cleanup(sdrm_connector->connector);
+	}
+
+	drm_mode_group_reinit(sdrm->drm);
+
+	sdrm_connector->registered = 0;
+
+	module_put(sdrm_connector->owner);
+}
+
+/*
+ * register a crtc to the drm core
+ */
+static int sdrm_crtc_register(struct sdrm_crtc *sdrm_crtc)
+{
+	struct sdrm_device *sdrm = sdrm_crtc->sdrm;
+	int ret;
+
+	drm_crtc_init(sdrm->drm, sdrm_crtc->crtc, &sdrm_crtc->crtc_funcs);
+	ret = drm_mode_crtc_set_gamma_size(sdrm_crtc->crtc, 256);
+	if (ret)
+		return ret;
+
+	drm_crtc_helper_add(sdrm_crtc->crtc, &sdrm_crtc->crtc_helper_funcs);
+
+	sdrm_crtc->registered = 1;
+
+	return 0;
+}
+
+static void sdrm_crtc_unregister(struct sdrm_crtc *sdrm_crtc)
+{
+	/*
+	 * The hard work has already been done in driver unload
+	 */
+	sdrm_crtc->registered = 0;
+}
+
+/*
+ * sdrm_uninit - unitialize all crtcs, encoders, connectors
+ *
+ * This is called in case initialization fails or as a cleanup
+ * after unitializing a drm device. Caller must hold sdrm->mutex
+ */
+static void sdrm_uninit(struct sdrm_device *sdrm)
+{
+	struct sdrm_crtc *sdrm_crtc;
+	struct sdrm_encoder *sdrm_encoder;
+	struct sdrm_connector *sdrm_connector;
+
+	list_for_each_entry(sdrm_crtc, &sdrm->crtc_list, list)
+		sdrm_crtc_unregister(sdrm_crtc);
+
+	list_for_each_entry(sdrm_connector, &sdrm->connector_list, list)
+		sdrm_connector_unregister(sdrm_connector);
+
+	list_for_each_entry(sdrm_encoder, &sdrm->encoder_list, list)
+		sdrm_encoder_unregister(sdrm_encoder);
+
+	sdrm->registered = 0;
+}
+
+/*
+ * Called by the CRTC driver when all CRTCs are registered. This
+ * puts all the pieces together and initializes the driver.
+ * Once this is called no more CRTCs can be registered since
+ * the drm core has hardcoded the number of crtcs in several
+ * places.
+ */
+int sdrm_init_drm(const char *name, struct platform_device *pdev,
+		int preferred_bpp)
+{
+	struct sdrm_device *sdrm;
+	struct drm_device *drm;
+	struct sdrm_crtc *sdrm_crtc;
+	struct sdrm_encoder *sdrm_encoder;
+	struct sdrm_connector *sdrm_connector;
+	int ret;
+	int num_crtcs = 0;
+
+	sdrm = sdrm_device_get(name);
+	if (!sdrm)
+		return -ENOMEM;
+
+	drm = kzalloc(sizeof(struct drm_device), GFP_KERNEL);
+	if (!drm)
+		return -ENOMEM;
+
+	sdrm->drm = drm;
+
+	memcpy(&sdrm->driver, &sdrm_driver_template,
+			sizeof(sdrm_driver_template));
+
+	drm->dev_private = sdrm;
+
+	ret = drm_fill_in_dev(drm, NULL, &sdrm->driver);
+	if (ret) {
+		printk(KERN_ERR "DRM: Fill_in_dev failed.\n");
+		goto err_fill_in;
+	}
+
+	/*
+	 * enable drm irq mode.
+	 * - with irq_enabled = 1, we can use the vblank feature.
+	 *
+	 * P.S. note that we wouldn't use drm irq handler but
+	 *      just spsdrmific driver own one instead bsdrmause
+	 *      drm framework supports only one irq handler and
+	 *      drivers can well take care of their interrupts
+	 */
+	drm->irq_enabled = 1;
+
+	mutex_lock(&drm_global_mutex);
+
+	ret = drm_get_minor(drm, &drm->control, DRM_MINOR_CONTROL);
+	if (ret)
+		goto err_get_minor1;
+
+	ret = drm_get_minor(drm, &drm->primary, DRM_MINOR_LEGACY);
+	if (ret)
+		goto err_get_minor2;
+
+	mutex_unlock(&drm_global_mutex);
+
+	drm_mode_config_init(drm);
+	sdrm_mode_config_init(drm);
+
+	mutex_lock(&sdrm->mutex);
+
+	/* we need at least one crtc */
+	if (list_empty(&sdrm->crtc_list)) {
+		ret = -EINVAL;
+		goto err_init;
+	}
+
+	/* Register the subdevices we have so far */
+
+	list_for_each_entry(sdrm_encoder, &sdrm->encoder_list, list) {
+		ret = sdrm_encoder_register(sdrm_encoder);
+		if (ret)
+			goto err_init;
+	}
+
+	list_for_each_entry(sdrm_connector, &sdrm->connector_list, list) {
+		ret = sdrm_connector_register(sdrm_connector);
+		if (ret)
+			goto err_init;
+	}
+
+	list_for_each_entry(sdrm_crtc, &sdrm->crtc_list, list) {
+		sdrm_crtc->pipe = num_crtcs;
+		num_crtcs++;
+		ret = sdrm_crtc_register(sdrm_crtc);
+		if (ret)
+			goto err_init;
+	}
+
+	sdrm->pdev = pdev;
+	sdrm->drm->platformdev = pdev;
+	sdrm->drm->dev = &pdev->dev;
+
+	sdrm->fb_helper = sdrm_fbdev_init(sdrm->drm, preferred_bpp);
+	if (!sdrm->fb_helper) {
+		printk("sdrm_fbdev_init failed\n");
+		ret = -ENOMEM;
+		goto err_init;
+	}
+
+	drm_kms_helper_poll_init(sdrm->drm);
+
+#ifndef HAVE_MODEGROUP_REMOVED
+	mutex_lock(&drm_global_mutex);
+
+	/* setup the grouping for the legacy output */
+	ret = drm_mode_group_init_legacy_group(sdrm->drm,
+			&sdrm->drm->primary->mode_group);
+	mutex_unlock(&drm_global_mutex);
+
+	if (ret)
+		return ret;
+#endif
+	ret = drm_vblank_init(sdrm->drm, num_crtcs);
+	if (ret)
+		goto err_init;
+
+	/*
+	 * with vblank_disable_allowed = 1, vblank interrupt will be disabled
+	 * by drm timer once a current process gives up ownership of
+	 * vblank event.(after drm_vblank_put function is called)
+	 */
+	sdrm->drm->vblank_disable_allowed = 1;
+
+	sdrm->registered = 1;
+
+	mutex_unlock(&sdrm->mutex);
+
+	return 0;
+
+err_init:
+	sdrm_uninit(sdrm);
+	mutex_unlock(&sdrm->mutex);
+err_get_minor2:
+	drm_put_minor(&drm->control);
+err_get_minor1:
+err_fill_in:
+	mutex_unlock(&drm_global_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sdrm_init_drm);
+
+/*
+ * Called by the CRTC driver to uninitialize the driver.
+ */
+int sdrm_exit_drm(const char *name)
+{
+	struct sdrm_device *sdrm;
+
+	sdrm = sdrm_device_get(name);
+	if (!sdrm)
+		return -ENODEV;
+
+	sdrm_uninit(sdrm);
+	/*
+	 * The drm core never does anything with this list, yet it removes
+	 * this entry, so initialize it
+	 */
+	INIT_LIST_HEAD(&sdrm->drm->driver_item);
+	drm_put_dev(sdrm->drm);
+
+	sdrm->drm = NULL;
+	sdrm->registered = 0;
+	sdrm->pdev = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sdrm_exit_drm);
+
+/*
+ * sdrm_add_crtc - add a new crtc
+ *
+ * The return value if !NULL is a cookie for the caller to pass to
+ * sdrm_remove_crtc later.
+ */
+struct sdrm_crtc *sdrm_add_crtc(const char *name, struct drm_crtc *crtc,
+		const struct drm_crtc_funcs *crtc_funcs,
+		const struct drm_crtc_helper_funcs *crtc_helper_funcs,
+		const struct sdrm_crtc_helper_funcs *sdrm_helper_funcs)
+{
+	struct sdrm_device *sdrm;
+	struct sdrm_crtc *sdrm_crtc;
+
+	sdrm = sdrm_device_get(name);
+	if (!sdrm)
+		return NULL; /* -ENOMEM */
+
+	if (sdrm->registered)
+		return NULL; /* -EBUSY */
+
+	sdrm_crtc = kzalloc(sizeof(*sdrm_crtc), GFP_KERNEL);
+	if (!sdrm_crtc)
+		return NULL; /* -ENOMEM */
+
+	sdrm_crtc->crtc_funcs = *crtc_funcs;
+	sdrm_crtc->crtc_helper_funcs = *crtc_helper_funcs;
+	sdrm_crtc->sdrm_helper_funcs = *sdrm_helper_funcs;
+
+	WARN_ON(crtc_funcs->set_config);
+	WARN_ON(crtc_funcs->destroy);
+
+	sdrm_crtc->crtc_funcs.set_config = drm_crtc_helper_set_config;
+	sdrm_crtc->crtc_funcs.destroy = drm_crtc_cleanup;
+
+	sdrm_crtc->crtc = crtc;
+	sdrm_crtc->sdrm = sdrm;
+
+	mutex_lock(&sdrm->mutex);
+
+	list_add_tail(&sdrm_crtc->list, &sdrm->crtc_list);
+
+	mutex_unlock(&sdrm->mutex);
+
+	return sdrm_crtc;
+}
+EXPORT_SYMBOL_GPL(sdrm_add_crtc);
+
+/*
+ * sdrm_remove_crtc - remove a crtc
+ *
+ * Can only be called on inactive drm devices since the drm
+ * core can't handle dynamic crtcs
+ */
+int sdrm_remove_crtc(struct sdrm_crtc *sdrm_crtc)
+{
+	struct sdrm_device *sdrm = sdrm_crtc->sdrm;
+
+	if (sdrm->registered)
+		return -EBUSY;
+
+	mutex_lock(&sdrm->mutex);
+
+	sdrm_crtc_unregister(sdrm_crtc);
+
+	list_del(&sdrm_crtc->list);
+
+	kfree(sdrm_crtc);
+
+	sdrm_device_maybe_release(sdrm);
+
+	mutex_unlock(&sdrm->mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sdrm_remove_crtc);
+
+/*
+ * sdrm_add_encoder - add a new encoder
+ *
+ * The return value if !NULL is a cookie for the caller to pass to
+ * sdrm_remove_crtc later.
+ *
+ * Can be called on both active and inactive devices.
+ */
+struct sdrm_encoder *sdrm_add_encoder(const char *name,
+		struct drm_encoder *encoder, struct module *owner)
+{
+	struct sdrm_device *sdrm;
+	struct sdrm_encoder *sdrm_encoder;
+	int ret;
+
+	sdrm = sdrm_device_get(name);
+	if (!sdrm)
+		return NULL;
+
+	sdrm_encoder = kzalloc(sizeof(struct sdrm_encoder), GFP_KERNEL);
+	if (!sdrm_encoder)
+		return NULL;
+	sdrm_encoder->encoder = encoder;
+	sdrm_encoder->sdrm = sdrm;
+	sdrm_encoder->owner = owner;
+
+	mutex_lock(&sdrm->mutex);
+
+	if (sdrm->registered) {
+		/*
+		 * If the drm device is up register the encoder,
+		 * otherwise it will be done in sdrm_init_drm()
+		 */
+		ret = sdrm_encoder_register(sdrm_encoder);
+		if (ret) {
+			kfree(sdrm_encoder);
+			goto err;
+		}
+	}
+
+	list_add_tail(&sdrm_encoder->list, &sdrm->encoder_list);
+err:
+	mutex_unlock(&sdrm->mutex);
+
+	return sdrm_encoder;
+}
+EXPORT_SYMBOL_GPL(sdrm_add_encoder);
+
+/*
+ * sdrm_remove_encoder - remove an encoder
+ *
+ * Can be called on both active and inactive devices.
+ */
+int sdrm_remove_encoder(struct sdrm_encoder *sdrm_encoder)
+{
+	struct sdrm_device *sdrm = sdrm_encoder->sdrm;
+
+	mutex_lock(&sdrm->mutex);
+
+	sdrm_encoder_unregister(sdrm_encoder);
+
+	list_del(&sdrm_encoder->list);
+
+	kfree(sdrm_encoder);
+
+	sdrm_device_maybe_release(sdrm);
+
+	mutex_unlock(&sdrm->mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sdrm_remove_encoder);
+
+/*
+ * sdrm_add_connector - add a connector
+ *
+ * Can be called on both active and inactive devices.
+ */
+struct sdrm_connector *sdrm_add_connector(const char *name,
+		struct drm_connector *connector, struct module *owner)
+{
+	struct sdrm_device *sdrm;
+	struct sdrm_connector *sdrm_connector;
+	int ret;
+
+	sdrm = sdrm_device_get(name);
+	if (!sdrm)
+		return NULL;
+
+	sdrm_connector = kzalloc(sizeof(struct sdrm_connector), GFP_KERNEL);
+	if (!sdrm_connector)
+		return NULL;
+
+	sdrm_connector->connector = connector;
+	sdrm_connector->sdrm = sdrm;
+	sdrm_connector->owner = owner;
+
+	mutex_lock(&sdrm->mutex);
+
+	if (sdrm->registered) {
+		/*
+		 * If the drm device is up register the connector,
+		 * otherwise it will be done in sdrm_init_drm()
+		 */
+		ret = sdrm_connector_register(sdrm_connector);
+		if (ret) {
+			kfree(sdrm_connector);
+			sdrm_connector = NULL;
+			goto err;
+		}
+	}
+
+	list_add_tail(&sdrm_connector->list, &sdrm->connector_list);
+err:
+	mutex_unlock(&sdrm->mutex);
+
+	return sdrm_connector;
+}
+EXPORT_SYMBOL_GPL(sdrm_add_connector);
+
+/*
+ * sdrm_remove_connector - remove a connector
+ *
+ * Can be called on both active and inactive devices.
+ */
+int sdrm_remove_connector(struct sdrm_connector *sdrm_connector)
+{
+	struct sdrm_device *sdrm = sdrm_connector->sdrm;
+
+	mutex_lock(&sdrm->mutex);
+
+	sdrm_connector_unregister(sdrm_connector);
+
+	list_del(&sdrm_connector->list);
+
+	kfree(sdrm_connector);
+
+	sdrm_device_maybe_release(sdrm);
+
+	mutex_unlock(&sdrm->mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sdrm_remove_connector);
+
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/sdrm/sdrm.h b/drivers/gpu/drm/sdrm/sdrm.h
new file mode 100644
index 0000000..e5d3a63
--- /dev/null
+++ b/drivers/gpu/drm/sdrm/sdrm.h
@@ -0,0 +1,57 @@
+#ifndef _SDRM_H_
+#define _SDRM_H_
+
+void sdrm_mode_config_init(struct drm_device *drm);
+
+struct drm_fb_helper *sdrm_fbdev_init(struct drm_device *drm,
+		int preferred_bpp);
+void sdrm_fbdev_fini(struct drm_fb_helper *);
+
+#define to_sdrm_gem_obj(x)	container_of(x,\
+			struct sdrm_gem_obj, base)
+
+struct sdrm_gem_obj {
+	struct drm_gem_object base;
+	struct sdrm_buf_entry *entry;
+};
+
+/* unmap a buffer from user space. */
+int sdrm_gem_munmap_ioctl(struct drm_device *drm, void *data,
+		struct drm_file *file_priv);
+
+/* initialize gem object. */
+int sdrm_gem_init_object(struct drm_gem_object *obj);
+
+/* free gem object. */
+void sdrm_gem_free_object(struct drm_gem_object *gem_obj);
+
+/* create memory region for drm framebuffer. */
+int sdrm_gem_dumb_create(struct drm_file *file_priv,
+		struct drm_device *drm, struct drm_mode_create_dumb *args);
+
+/* map memory region for drm framebuffer to user space. */
+int sdrm_gem_dumb_map_offset(struct drm_file *file_priv,
+		struct drm_device *drm, uint32_t handle, uint64_t *offset);
+
+/* page fault handler and mmap fault address(virtual) to physical memory. */
+int sdrm_gem_fault(struct vm_area_struct *vma, struct vm_fault *vmf);
+
+/* set vm_flags and we can change the vm attribute to other one at here. */
+int sdrm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
+
+/*
+ * destroy memory region allocated.
+ *	- a gem handle and physical memory region pointed by a gem object
+ *	would be released by drm_gem_handle_delete().
+ */
+int sdrm_gem_dumb_destroy(struct drm_file *file_priv,
+		struct drm_device *drm, unsigned int handle);
+
+/* allocate physical memory. */
+struct sdrm_buf_entry *sdrm_buf_create(struct drm_device *drm,
+		unsigned int size);
+
+/* remove allocated physical memory. */
+void sdrm_buf_destroy(struct drm_device *drm, struct sdrm_buf_entry *entry);
+
+#endif /* _SDRM_H_ */
diff --git a/drivers/gpu/drm/sdrm/sdrm_fb.c b/drivers/gpu/drm/sdrm/sdrm_fb.c
new file mode 100644
index 0000000..7f9c69d
--- /dev/null
+++ b/drivers/gpu/drm/sdrm/sdrm_fb.c
@@ -0,0 +1,191 @@
+/*
+ * simple drm driver
+ *
+ * Copyright (C) 2011 Sascha Hauer, Pengutronix
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
+#include <drm/sdrm.h>
+
+#include "sdrm.h"
+
+#define to_sdrm_fb(x)	container_of(x, struct sdrm_fb, fb)
+
+/*
+ * sdrm specific framebuffer structure.
+ *
+ * @fb: drm framebuffer obejct.
+ * @sdrm_gem_obj: drm ec specific gem object containing a gem object.
+ * @entry: pointer to ec drm buffer entry object.
+ *	- containing only the information to physically continuous memory
+ *	region allocated at default framebuffer creation.
+ */
+struct sdrm_fb {
+	struct drm_framebuffer		fb;
+	struct sdrm_gem_obj	*sdrm_gem_obj;
+	struct sdrm_buf_entry	*entry;
+};
+
+static void sdrm_fb_destroy(struct drm_framebuffer *fb)
+{
+	struct sdrm_fb *sdrm_fb = to_sdrm_fb(fb);
+
+	drm_framebuffer_cleanup(fb);
+
+	/*
+	 * default framebuffer has no gem object so
+	 * a buffer of the default framebuffer should be released at here.
+	 */
+	if (!sdrm_fb->sdrm_gem_obj && sdrm_fb->entry)
+		sdrm_buf_destroy(fb->dev, sdrm_fb->entry);
+
+	kfree(sdrm_fb);
+}
+
+static int sdrm_fb_create_handle(struct drm_framebuffer *fb,
+		struct drm_file *file_priv, unsigned int *handle)
+{
+	struct sdrm_fb *sdrm_fb = to_sdrm_fb(fb);
+
+	return drm_gem_handle_create(file_priv,
+			&sdrm_fb->sdrm_gem_obj->base, handle);
+}
+
+static int sdrm_fb_dirty(struct drm_framebuffer *fb,
+		struct drm_file *file_priv, unsigned flags,
+		unsigned color, struct drm_clip_rect *clips,
+		unsigned num_clips)
+{
+	/* TODO */
+
+	return 0;
+}
+
+static struct drm_framebuffer_funcs sdrm_fb_funcs = {
+	.destroy	= sdrm_fb_destroy,
+	.create_handle	= sdrm_fb_create_handle,
+	.dirty		= sdrm_fb_dirty,
+};
+
+static struct drm_framebuffer *sdrm_fb_create(struct drm_device *dev,
+		struct drm_file *file_priv, struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	struct sdrm_fb *sdrm_fb;
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
+	sdrm_fb = kzalloc(sizeof(*sdrm_fb), GFP_KERNEL);
+	if (!sdrm_fb) {
+		dev_err(dev->dev, "failed to allocate drm framebuffer.\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	fb = &sdrm_fb->fb;
+	ret = drm_framebuffer_init(dev, fb, &sdrm_fb_funcs);
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
+	 * without file_priv we are called from sdrm_fbdev_create in which
+	 * case we only create a framebuffer without a handle.
+	 */
+	if (!file_priv) {
+		struct sdrm_buf_entry *entry;
+
+		entry = sdrm_buf_create(dev, size);
+		if (IS_ERR(entry)) {
+			ret = PTR_ERR(entry);
+			goto err_buffer;
+		}
+
+		sdrm_fb->entry = entry;
+	} else {
+		obj = drm_gem_object_lookup(dev, file_priv, mode_cmd->handles[0]);
+		if (!obj) {
+			ret = -EINVAL;
+			goto err_buffer;
+		}
+
+		sdrm_fb->sdrm_gem_obj = to_sdrm_gem_obj(obj);
+
+		drm_gem_object_unreference_unlocked(obj);
+
+		sdrm_fb->entry = sdrm_fb->sdrm_gem_obj->entry;
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
+	kfree(sdrm_fb);
+
+	return ERR_PTR(ret);
+}
+
+struct sdrm_buf_entry *sdrm_fb_get_buf(struct drm_framebuffer *fb)
+{
+	struct sdrm_fb *sdrm_fb = to_sdrm_fb(fb);
+	struct sdrm_buf_entry *entry;
+
+	entry = sdrm_fb->entry;
+
+	return entry;
+}
+EXPORT_SYMBOL_GPL(sdrm_fb_get_buf);
+
+static struct drm_mode_config_funcs sdrm_mode_config_funcs = {
+	.fb_create = sdrm_fb_create,
+};
+
+void sdrm_mode_config_init(struct drm_device *dev)
+{
+	dev->mode_config.min_width = 0;
+	dev->mode_config.min_height = 0;
+
+	/*
+	 * set max width and height as default value(4096x4096).
+	 * this value would be used to check framebuffer size limitation
+	 * at drm_mode_addfb().
+	 */
+	dev->mode_config.max_width = 4096;
+	dev->mode_config.max_height = 4096;
+
+	dev->mode_config.funcs = &sdrm_mode_config_funcs;
+}
diff --git a/drivers/gpu/drm/sdrm/sdrm_fbdev.c b/drivers/gpu/drm/sdrm/sdrm_fbdev.c
new file mode 100644
index 0000000..8f3e3e0
--- /dev/null
+++ b/drivers/gpu/drm/sdrm/sdrm_fbdev.c
@@ -0,0 +1,238 @@
+/*
+ * simple drm driver
+ *
+ * Copyright (C) 2011 Sascha Hauer, Pengutronix
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
+#include <drm/sdrm.h>
+
+#include "sdrm.h"
+
+#define MAX_CONNECTOR		4
+#define PREFERRED_BPP		16
+
+static struct fb_ops sdrm_fb_ops = {
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
+static int sdrm_fbdev_update(struct drm_fb_helper *helper,
+				     struct drm_framebuffer *fb,
+				     unsigned int fb_width,
+				     unsigned int fb_height)
+{
+	struct fb_info *fbi = helper->fbdev;
+	struct drm_device *drm = helper->dev;
+	struct sdrm_buf_entry *entry;
+	unsigned int size = fb_width * fb_height * (fb->bits_per_pixel >> 3);
+	unsigned long offset;
+
+	drm_fb_helper_fill_fix(fbi, fb->pitches[0], fb->depth);
+	drm_fb_helper_fill_var(fbi, helper, fb_width, fb_height);
+
+	entry = sdrm_fb_get_buf(fb);
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
+static int sdrm_fbdev_create(struct drm_fb_helper *helper,
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
+	fbi->fbops = &sdrm_fb_ops;
+
+	ret = fb_alloc_cmap(&fbi->cmap, 256, 0);
+	if (ret)
+		goto err_alloc_cmap;
+
+	ret = sdrm_fbdev_update(helper, helper->fb, sizes->fb_width,
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
+static int sdrm_fbdev_probe(struct drm_fb_helper *helper,
+				   struct drm_fb_helper_surface_size *sizes)
+{
+	int ret;
+
+	BUG_ON(helper->fb);
+
+	ret = sdrm_fbdev_create(helper, sizes);
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
+static struct drm_fb_helper_funcs sdrm_fb_helper_funcs = {
+	.fb_probe = sdrm_fbdev_probe,
+};
+
+struct drm_fb_helper *sdrm_fbdev_init(struct drm_device *drm, int preferred_bpp)
+{
+	struct drm_fb_helper *helper;
+	unsigned int num_crtc;
+	int ret;
+
+	helper = kzalloc(sizeof(*helper), GFP_KERNEL);
+	if (!helper)
+		return NULL;
+
+	helper->funcs = &sdrm_fb_helper_funcs;
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
+void sdrm_fbdev_fini(struct drm_fb_helper *helper)
+{
+	/* release linux framebuffer */
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
+		framebuffer_release(info);
+	}
+
+	drm_fb_helper_fini(helper);
+
+	kfree(helper);
+}
diff --git a/drivers/gpu/drm/sdrm/sdrm_gem.c b/drivers/gpu/drm/sdrm/sdrm_gem.c
new file mode 100644
index 0000000..4f98627
--- /dev/null
+++ b/drivers/gpu/drm/sdrm/sdrm_gem.c
@@ -0,0 +1,342 @@
+/*
+ * simple drm driver
+ *
+ * Copyright (C) 2011 Sascha Hauer, Pengutronix
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
+#include <drm/sdrm.h>
+
+#include "sdrm.h"
+
+static int lowlevel_buffer_allocate(struct drm_device *drm,
+		struct sdrm_buf_entry *entry)
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
+		struct sdrm_buf_entry *entry)
+{
+	dma_free_writecombine(drm->dev, entry->size, entry->vaddr,
+			entry->paddr);
+}
+
+struct sdrm_buf_entry *sdrm_buf_create(struct drm_device *drm,
+		unsigned int size)
+{
+	struct sdrm_buf_entry *entry;
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
+void sdrm_buf_destroy(struct drm_device *drm,
+		struct sdrm_buf_entry *entry)
+{
+	lowlevel_buffer_free(drm, entry);
+
+	kfree(entry);
+	entry = NULL;
+}
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
+static struct sdrm_gem_obj *sdrm_gem_create(struct drm_device *drm,
+		unsigned int size)
+{
+	struct sdrm_gem_obj *sdrm_gem_obj;
+	struct sdrm_buf_entry *entry;
+	struct drm_gem_object *obj;
+	int ret;
+
+	size = roundup(size, PAGE_SIZE);
+
+	sdrm_gem_obj = kzalloc(sizeof(*sdrm_gem_obj), GFP_KERNEL);
+	if (!sdrm_gem_obj)
+		return ERR_PTR(-ENOMEM);
+
+	/* allocate the new buffer object and memory region. */
+	entry = sdrm_buf_create(drm, size);
+	if (!entry) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	sdrm_gem_obj->entry = entry;
+
+	obj = &sdrm_gem_obj->base;
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
+	return sdrm_gem_obj;
+
+err_create_mmap_offset:
+	drm_gem_object_release(obj);
+
+err_obj_init:
+	sdrm_buf_destroy(drm, sdrm_gem_obj->entry);
+
+err_alloc:
+	kfree(sdrm_gem_obj);
+
+	return ERR_PTR(ret);
+}
+
+static struct sdrm_gem_obj *sdrm_gem_create_with_handle(struct drm_file *file_priv,
+		struct drm_device *drm, unsigned int size,
+		unsigned int *handle)
+{
+	struct sdrm_gem_obj *sdrm_gem_obj;
+	struct drm_gem_object *obj;
+	int ret;
+
+	sdrm_gem_obj = sdrm_gem_create(drm, size);
+	if (IS_ERR(sdrm_gem_obj))
+		return sdrm_gem_obj;
+
+	obj = &sdrm_gem_obj->base;
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
+	return sdrm_gem_obj;
+
+err_handle_create:
+	sdrm_gem_free_object(obj);
+
+	return ERR_PTR(ret);
+}
+
+static int sdrm_gem_mmap_buffer(struct file *filp,
+		struct vm_area_struct *vma)
+{
+	struct drm_gem_object *obj = filp->private_data;
+	struct sdrm_gem_obj *sdrm_gem_obj = to_sdrm_gem_obj(obj);
+	struct sdrm_buf_entry *entry;
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
+	entry = sdrm_gem_obj->entry;
+
+	/* check if user-requested size is valid. */
+	if (vm_size > entry->size)
+		return -EINVAL;
+
+	/*
+	 * get page frame number to physical memory to be mapped
+	 * to user space.
+	 */
+	pfn = sdrm_gem_obj->entry->paddr >> PAGE_SHIFT;
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
+static const struct file_operations sdrm_gem_fops = {
+	.mmap = sdrm_gem_mmap_buffer,
+};
+
+int sdrm_gem_init_object(struct drm_gem_object *obj)
+{
+	return 0;
+}
+
+void sdrm_gem_free_object(struct drm_gem_object *gem_obj)
+{
+	struct sdrm_gem_obj *sdrm_gem_obj;
+
+	if (gem_obj->map_list.map)
+		drm_gem_free_mmap_offset(gem_obj);
+
+	drm_gem_object_release(gem_obj);
+
+	sdrm_gem_obj = to_sdrm_gem_obj(gem_obj);
+
+	sdrm_buf_destroy(gem_obj->dev, sdrm_gem_obj->entry);
+
+	kfree(sdrm_gem_obj);
+}
+
+int sdrm_gem_dumb_create(struct drm_file *file_priv,
+		struct drm_device *dev, struct drm_mode_create_dumb *args)
+{
+	struct sdrm_gem_obj *sdrm_gem_obj;
+
+	/* FIXME: This should be configured by the crtc driver */
+	args->pitch = args->width * args->bpp >> 3;
+	args->size = args->pitch * args->height;
+
+	sdrm_gem_obj = sdrm_gem_create_with_handle(file_priv, dev, args->size,
+			&args->handle);
+	if (IS_ERR(sdrm_gem_obj))
+		return PTR_ERR(sdrm_gem_obj);
+
+	return 0;
+}
+
+int sdrm_gem_dumb_map_offset(struct drm_file *file_priv,
+		struct drm_device *drm, uint32_t handle, uint64_t *offset)
+{
+	struct sdrm_gem_obj *sdrm_gem_obj;
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
+	sdrm_gem_obj = to_sdrm_gem_obj(obj);
+
+	*offset = get_gem_mmap_offset(&sdrm_gem_obj->base);
+
+	drm_gem_object_unreference(obj);
+
+	mutex_unlock(&drm->struct_mutex);
+
+	return 0;
+}
+
+int sdrm_gem_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	struct drm_gem_object *obj = vma->vm_private_data;
+	struct sdrm_gem_obj *sdrm_gem_obj = to_sdrm_gem_obj(obj);
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
+	pfn = (sdrm_gem_obj->entry->paddr >> PAGE_SHIFT) + page_offset;
+
+	ret = vm_insert_mixed(vma, (unsigned long)vmf->virtual_address, pfn);
+
+	mutex_unlock(&dev->struct_mutex);
+
+	return convert_to_vm_err_msg(ret);
+}
+
+int sdrm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
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
+int sdrm_gem_dumb_destroy(struct drm_file *file_priv,
+		struct drm_device *dev, unsigned int handle)
+{
+	return drm_gem_handle_delete(file_priv, handle);
+}
diff --git a/include/drm/sdrm.h b/include/drm/sdrm.h
new file mode 100644
index 0000000..ad4f5f6
--- /dev/null
+++ b/include/drm/sdrm.h
@@ -0,0 +1,102 @@
+#ifndef __DRM_SDRM_H
+#define __DRM_SDRM_H
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+
+/**
+ * User-desired buffer creation information structure.
+ *
+ * @size: requested size for the object.
+ *	- this size value would be page-aligned internally.
+ * @flags: user request for setting memory type or cache attributes.
+ * @handle: returned handle for the object.
+ */
+struct sdrm_gem_create {
+	unsigned int size;
+	unsigned int flags;
+	unsigned int handle;
+};
+
+/**
+ * A structure for getting buffer offset.
+ *
+ * @handle: a pointer to gem object created.
+ * @pad: just padding to be 64-bit aligned.
+ * @offset: relatived offset value of the memory region allocated.
+ *	- this value should be set by user.
+ */
+struct sdrm_gem_map_off {
+	unsigned int handle;
+	unsigned int pad;
+	uint64_t offset;
+};
+
+/**
+ * A structure for mapping buffer.
+ *
+ * @handle: a handle to gem object created.
+ * @size: memory size to be mapped.
+ * @mapped: having user virtual address mmaped.
+ *	- this variable would be filled by exynos gem module
+ *	of kernel side with user virtual address which is allocated
+ *	by do_mmap().
+ */
+struct sdrm_gem_mmap {
+	unsigned int handle;
+	unsigned int size;
+	uint64_t mapped;
+};
+
+struct sdrm_device;
+struct sdrm_crtc;
+
+struct sdrm_crtc_helper_funcs {
+	int (*enable_vblank)(struct drm_crtc *crtc);
+	void (*disable_vblank)(struct drm_crtc *crtc);
+};
+
+struct sdrm_crtc *sdrm_add_crtc(const char *name, struct drm_crtc *crtc,
+		const struct drm_crtc_funcs *crtc_funcs,
+		const struct drm_crtc_helper_funcs *crtc_helper_funcs,
+		const struct sdrm_crtc_helper_funcs *ec_helper_funcs);
+int sdrm_remove_crtc(struct sdrm_crtc *);
+int sdrm_init_drm(const char *name, struct platform_device *pdev,
+		int preferred_bpp);
+int sdrm_exit_drm(const char *name);
+
+int sdrm_crtc_vblank_get(struct sdrm_crtc *sdrm_crtc);
+void sdrm_crtc_vblank_put(struct sdrm_crtc *sdrm_crtc);
+void sdrm_handle_vblank(struct sdrm_crtc *sdrm_crtc);
+
+/*
+ * sdrm drm buffer entry structure.
+ *
+ * @paddr: physical address of allocated memory.
+ * @vaddr: kernel virtual address of allocated memory.
+ * @size: size of allocated memory.
+ */
+struct sdrm_buf_entry {
+	dma_addr_t paddr;
+	void __iomem *vaddr;
+	unsigned int size;
+
+	dma_addr_t r_paddr;
+	void __iomem *r_vaddr;
+	unsigned int r_size;
+};
+
+/* get physical memory information of a drm framebuffer. */
+struct sdrm_buf_entry *sdrm_fb_get_buf(struct drm_framebuffer *fb);
+
+struct sdrm_encoder;
+struct sdrm_encoder *sdrm_add_encoder(const char *drmname,
+		struct drm_encoder *encoder, struct module *owner);
+int sdrm_remove_encoder(struct sdrm_encoder *);
+
+struct sdrm_connector;
+struct sdrm_connector *sdrm_add_connector(const char *drmname,
+		struct drm_connector *connector, struct module *owner);
+int sdrm_remove_connector(struct sdrm_connector *);
+
+#endif /* __DRM_SDRM_H */
-- 
1.7.9.5
