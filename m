From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Apr 2012 17:33:45 +0200
Subject: [PATCH 4/7] DRM: Add sdrm 1:1 encoder - connector helper
In-Reply-To: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
References: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334158428-23735-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having a 1:1 relationship between an encoder and a connector is a
very common case. This patch allows for registering a combination
of both in a single device. It should allow implementing all
necessary callbacks for both the encoder and the connector, but
most calls are optional leaving the simplest encoder - connector
which is purely dummy and only passes a drm mode to the core.
This is a common case on embedded systems where the parallel data
lines are directly connected to a single display.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/gpu/drm/sdrm/Kconfig            |    3 +
 drivers/gpu/drm/sdrm/Makefile           |    3 +
 drivers/gpu/drm/sdrm/sdrm_encon.c       |  211 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/sdrm/sdrm_encon_dummy.c |  193 ++++++++++++++++++++++++++++
 include/drm/sdrm_encon.h                |   69 ++++++++++
 5 files changed, 479 insertions(+)
 create mode 100644 drivers/gpu/drm/sdrm/sdrm_encon.c
 create mode 100644 drivers/gpu/drm/sdrm/sdrm_encon_dummy.c
 create mode 100644 include/drm/sdrm_encon.h

diff --git a/drivers/gpu/drm/sdrm/Kconfig b/drivers/gpu/drm/sdrm/Kconfig
index 2424b2c..456ac07 100644
--- a/drivers/gpu/drm/sdrm/Kconfig
+++ b/drivers/gpu/drm/sdrm/Kconfig
@@ -6,3 +6,6 @@ config DRM_SDRM
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 
+config DRM_SDRM_ENCON
+	tristate
+	depends on DRM_SDRM
diff --git a/drivers/gpu/drm/sdrm/Makefile b/drivers/gpu/drm/sdrm/Makefile
index c603f1b..cf57be2 100644
--- a/drivers/gpu/drm/sdrm/Makefile
+++ b/drivers/gpu/drm/sdrm/Makefile
@@ -1,2 +1,5 @@
 drm-sdrm-objs := sdrm.o sdrm_gem.o sdrm_fbdev.o sdrm_fb.o
 obj-$(CONFIG_DRM_SDRM) += drm-sdrm.o
+
+drm-sdrm-encon-objs := sdrm_encon_dummy.o sdrm_encon.o
+obj-$(CONFIG_DRM_SDRM_ENCON) += drm-sdrm-encon.o
diff --git a/drivers/gpu/drm/sdrm/sdrm_encon.c b/drivers/gpu/drm/sdrm/sdrm_encon.c
new file mode 100644
index 0000000..16f7e4c
--- /dev/null
+++ b/drivers/gpu/drm/sdrm/sdrm_encon.c
@@ -0,0 +1,211 @@
+/*
+ * Implementation of a 1:1 relationship for drm encoders and connectors
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+#include <linux/module.h>
+#include <drm/drmP.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_encoder_slave.h>
+#include <drm/sdrm_encon.h>
+#include <drm/sdrm.h>
+
+#define con_to_encon(x) container_of(x, struct drm_encoder_connector, connector)
+#define enc_to_encon(x) container_of(x, struct drm_encoder_connector, encoder)
+
+static enum drm_connector_status connector_detect(struct drm_connector *connector,
+		bool force)
+{
+	struct drm_encoder_connector *encon = con_to_encon(connector);
+
+	if (encon->funcs->detect)
+		return encon->funcs->detect(encon);
+
+	return connector_status_connected;
+}
+
+static int connector_set_property(struct drm_connector *connector,
+		struct drm_property *property, uint64_t val)
+{
+	struct drm_encoder_connector *encon = con_to_encon(connector);
+
+	if (encon->funcs->set_property)
+		return encon->funcs->set_property(encon, property, val);
+
+	return -EINVAL;
+}
+
+static void connector_destroy(struct drm_connector *connector)
+{
+	/* do not free here */
+}
+
+static int connector_get_modes(struct drm_connector *connector)
+{
+	struct drm_encoder_connector *encon = con_to_encon(connector);
+
+	if (encon->funcs->get_modes)
+		return encon->funcs->get_modes(encon);
+
+	return 0;
+}
+
+static int connector_mode_valid(struct drm_connector *connector,
+			  struct drm_display_mode *mode)
+{
+	struct drm_encoder_connector *encon = con_to_encon(connector);
+
+	if (encon->funcs && encon->funcs->mode_valid)
+		return encon->funcs->mode_valid(encon, mode);
+
+	return 0;
+}
+
+static struct drm_encoder *connector_best_encoder(struct drm_connector *connector)
+{
+	struct drm_encoder_connector *encon = con_to_encon(connector);
+
+	return &encon->encoder;
+}
+
+static void encoder_dpms(struct drm_encoder *encoder, int mode)
+{
+	struct drm_encoder_connector *encon = enc_to_encon(encoder);
+
+	if (encon->funcs->dpms)
+		encon->funcs->dpms(encon, mode);
+}
+
+static bool encoder_mode_fixup(struct drm_encoder *encoder,
+			   struct drm_display_mode *mode,
+			   struct drm_display_mode *adjusted_mode)
+{
+	struct drm_encoder_connector *encon = enc_to_encon(encoder);
+
+	if (encon->funcs->mode_fixup)
+		return encon->funcs->mode_fixup(encon, mode, adjusted_mode);
+
+	return true;
+}
+
+static void encoder_prepare(struct drm_encoder *encoder)
+{
+	struct drm_encoder_connector *encon = enc_to_encon(encoder);
+
+	if (encon->funcs->prepare)
+		encon->funcs->prepare(encon);
+}
+
+static void encoder_commit(struct drm_encoder *encoder)
+{
+	struct drm_encoder_connector *encon = enc_to_encon(encoder);
+
+	if (encon->funcs->commit)
+		encon->funcs->commit(encon);
+}
+
+static void encoder_mode_set(struct drm_encoder *encoder,
+			 struct drm_display_mode *mode,
+			 struct drm_display_mode *adjusted_mode)
+{
+	struct drm_encoder_connector *encon = enc_to_encon(encoder);
+
+	if (encon->funcs->mode_set)
+		encon->funcs->mode_set(encon, mode, adjusted_mode);
+}
+
+static void encoder_disable(struct drm_encoder *encoder)
+{
+}
+
+static void encoder_destroy(struct drm_encoder *encoder)
+{
+	/* do not free here */
+}
+
+struct drm_connector_funcs connector_funcs = {
+	.dpms = drm_helper_connector_dpms,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.detect = connector_detect,
+	.set_property = connector_set_property,
+	.destroy = connector_destroy,
+};
+
+struct drm_connector_helper_funcs connector_helper_funcs = {
+	.get_modes = connector_get_modes,
+	.mode_valid = connector_mode_valid,
+	.best_encoder = connector_best_encoder,
+};
+
+static struct drm_encoder_funcs encoder_funcs = {
+	.destroy = encoder_destroy,
+};
+
+static struct drm_encoder_helper_funcs encoder_helper_funcs = {
+	.dpms = encoder_dpms,
+	.mode_fixup = encoder_mode_fixup,
+	.prepare = encoder_prepare,
+	.commit = encoder_commit,
+	.mode_set = encoder_mode_set,
+	.disable = encoder_disable,
+};
+
+int drm_encoder_connector_register(const char *drm_name, struct drm_encoder_connector *encon)
+{
+	drm_mode_connector_attach_encoder(&encon->connector, &encon->encoder);
+
+	encon->connector.funcs = &connector_funcs;
+	encon->encoder.funcs = &encoder_funcs;
+	drm_encoder_helper_add(&encon->encoder, &encoder_helper_funcs);
+	encon->sdrm_encoder = sdrm_add_encoder(drm_name, &encon->encoder,
+			encon->owner);
+	if (!encon->sdrm_encoder) {
+		pr_err("%s: adding encoder failed\n", __func__);
+		return -EINVAL;
+	}
+
+	drm_connector_helper_add(&encon->connector, &connector_helper_funcs);
+
+	encon->sdrm_connector = sdrm_add_connector(drm_name, &encon->connector,
+			encon->owner);
+	if (!encon->sdrm_connector) {
+		pr_err("%s: adding connector failed\n", __func__);
+		return -EINVAL;
+	}
+
+	encon->connector.encoder = &encon->encoder;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(drm_encoder_connector_register);
+
+void drm_encoder_connector_unregister(struct drm_encoder_connector *c)
+{
+	struct drm_connector *connector = &c->connector;
+	struct drm_encoder *encoder = &c->encoder;
+
+	drm_sysfs_connector_remove(connector);
+	drm_mode_connector_detach_encoder(connector, encoder);
+	drm_encoder_cleanup(encoder);
+	drm_connector_cleanup(connector);
+}
+EXPORT_SYMBOL_GPL(drm_encoder_connector_unregister);
+
+MODULE_DESCRIPTION("drm encoder/connector driver");
+MODULE_AUTHOR("Sascha Hauer, Pengutronix");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/sdrm/sdrm_encon_dummy.c b/drivers/gpu/drm/sdrm/sdrm_encon_dummy.c
new file mode 100644
index 0000000..a88b884
--- /dev/null
+++ b/drivers/gpu/drm/sdrm/sdrm_encon_dummy.c
@@ -0,0 +1,193 @@
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <drm/drmP.h>
+#include <drm/sdrm_encon.h>
+#include <drm/sdrm.h>
+
+struct sdrm_encon_dummy_private {
+	struct drm_encoder_connector encon;
+	struct drm_display_mode *modes;
+	int num_modes;
+};
+
+static int dummy_get_modes(struct drm_encoder_connector *encon)
+{
+	struct sdrm_encon_dummy_private *priv = encon->encon_private;
+	struct drm_display_mode *mode;
+	struct drm_device *drm = encon->connector.dev;
+	int i, ret = 0;
+
+	if (!priv->num_modes)
+		return 0;
+
+	for (i = 0; i < priv->num_modes; i++) {
+		mode = drm_mode_duplicate(drm, &priv->modes[i]);
+		if (mode == NULL)
+			return 0;
+
+		mode->base.type = DRM_MODE_OBJECT_MODE;
+
+		drm_mode_probed_add(&encon->connector, mode);
+		ret++; 
+	}
+	return ret;
+}
+
+static struct drm_encoder_connector_funcs dummy_funcs = {
+	.get_modes = dummy_get_modes,
+};
+
+/*
+ * sdrm_encon_add_dummy - add a dummy encoder/connector
+ *
+ * All callbacks of a dummy encoder/connector are no-ops, only
+ * an array of modes can be provided.
+ */
+struct drm_encoder_connector *sdrm_encon_add_dummy(struct sdrm_encon_dummy *dummy)
+{
+	struct sdrm_encon_dummy_private *priv;
+	struct drm_encoder_connector *encon;
+	int ret;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return NULL;
+
+	encon = &priv->encon;
+	priv->modes = dummy->modes;
+	priv->num_modes = dummy->num_modes;
+	encon->funcs = &dummy_funcs;
+	encon->encon_private = priv;
+	encon->connector.encoder = &encon->encoder;
+	encon->encoder.possible_crtcs = dummy->possible_crtcs;
+	encon->encoder.possible_clones = dummy->possible_clones;
+	encon->owner = dummy->owner;
+
+	ret = drm_encoder_connector_register(dummy->drm_name, encon);
+	if (ret) {
+		kfree(priv);
+		return NULL;
+	}
+
+	return encon;
+}
+EXPORT_SYMBOL_GPL(sdrm_encon_add_dummy);
+
+int sdrm_encon_remove_dummy(struct drm_encoder_connector *encon)
+{
+	struct sdrm_encon_dummy_private *priv = encon->encon_private;
+
+	sdrm_remove_connector(encon->sdrm_connector);
+	sdrm_remove_encoder(encon->sdrm_encoder);
+
+	kfree(priv);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sdrm_encon_remove_dummy);
+
+struct sdrm_encon_pdev_priv {
+	struct sdrm_encon_dummy dummy;
+	struct drm_encoder_connector *encon;
+	unsigned int flags;
+	int gpio_dpms;
+	int gpio_backlight;	
+};
+
+static void sdrm_encon_pdev_gpio_dpms(struct sdrm_encon_dummy *dummy, int mode)
+{
+	struct sdrm_encon_pdev_priv *priv = container_of(dummy,
+			struct sdrm_encon_pdev_priv, dummy);
+	int gpio_backlight = 0, gpio_dpms = 0;
+
+	switch (mode) {
+	case DRM_MODE_DPMS_ON:
+		printk("%s: on\n", __func__);
+		gpio_backlight = 1;
+		gpio_dpms = 1;
+	default:
+		printk("%s: off\n", __func__);
+		break;
+	}
+
+	if (priv->flags == DRM_ENCON_DUMMY_BL_GPIO_ACTIVE_LOW)
+		gpio_backlight = !gpio_backlight;
+	if (priv->flags == DRM_ENCON_DUMMY_DPMS_GPIO_ACTIVE_LOW)
+		gpio_dpms = !gpio_dpms;
+
+	if (priv->flags & DRM_ENCON_DUMMY_USE_DPMS_GPIO)
+		gpio_direction_output(priv->gpio_dpms, gpio_dpms);
+
+	if (priv->flags & DRM_ENCON_DUMMY_USE_BL_GPIO)
+		gpio_direction_output(priv->gpio_backlight, gpio_backlight);
+}
+
+static int __devinit sdrm_encon_platform_probe(struct platform_device *pdev)
+{
+	struct sdrm_encon_dummy_pdata *pdata = pdev->dev.platform_data;
+	struct sdrm_encon_pdev_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dummy.owner = THIS_MODULE;
+	priv->dummy.drm_name = pdata->drm_name;
+	priv->dummy.possible_crtcs = pdata->possible_crtcs;
+	priv->dummy.possible_clones = pdata->possible_clones;
+	priv->dummy.modes = pdata->modes;
+	priv->dummy.num_modes = pdata->num_modes;
+	priv->flags = pdata->flags;
+
+	if (pdata->flags & DRM_ENCON_DUMMY_USE_BL_GPIO) {
+		priv->gpio_backlight = pdata->gpio_backlight;
+		ret = gpio_request(priv->gpio_backlight, "backlight");
+		if (ret)
+			return ret;
+	}
+
+	if (pdata->flags & DRM_ENCON_DUMMY_USE_DPMS_GPIO) {
+		priv->gpio_dpms = pdata->gpio_dpms;
+		priv->dummy.dpms = sdrm_encon_pdev_gpio_dpms;
+		ret = gpio_request(priv->gpio_dpms, "dpms");
+		if (ret) {
+			if (pdata->flags & DRM_ENCON_DUMMY_USE_BL_GPIO)
+				gpio_free(priv->gpio_backlight);
+			return ret;
+		}
+	}
+
+	priv->encon = sdrm_encon_add_dummy(&priv->dummy);
+	if (!priv->encon)
+		return -EINVAL;
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static int __devexit sdrm_encon_platform_remove(struct platform_device *pdev)
+{
+	struct sdrm_encon_pdev_priv *priv = platform_get_drvdata(pdev);
+
+	sdrm_encon_remove_dummy(priv->encon);
+
+	return 0;
+}
+
+static struct platform_driver sdrm_encon_driver = {
+	.probe		= sdrm_encon_platform_probe,
+	.remove		= __devexit_p(sdrm_encon_platform_remove),
+	.driver		= {
+		.name	= "drm-encon-dummy",
+		.owner	= THIS_MODULE,
+	},
+};
+
+module_platform_driver(sdrm_encon_driver);
+
+MODULE_DESCRIPTION("drm encoder/connector dummy driver");
+MODULE_AUTHOR("Sascha Hauer, Pengutronix");
+MODULE_LICENSE("GPL");
diff --git a/include/drm/sdrm_encon.h b/include/drm/sdrm_encon.h
new file mode 100644
index 0000000..6a426df
--- /dev/null
+++ b/include/drm/sdrm_encon.h
@@ -0,0 +1,69 @@
+#ifndef __DRM_ENCON_H
+#define __DRM_ENCON_H
+
+struct drm_encoder_connector;
+
+struct drm_encoder_connector_funcs {
+	int (*get_modes)(struct drm_encoder_connector *encon);
+	int (*mode_valid)(struct drm_encoder_connector *encon,
+			struct drm_display_mode *mode);
+	void (*mode_set)(struct drm_encoder_connector *encon,
+			 struct drm_display_mode *mode,
+			 struct drm_display_mode *adjusted_mode);
+	void (*dpms)(struct drm_encoder_connector *encon, int mode);
+	enum drm_connector_status (*detect)(struct drm_encoder_connector *encon);
+	void (*commit)(struct drm_encoder_connector *encon);
+	bool (*mode_fixup)(struct drm_encoder_connector *encon,
+			struct drm_display_mode *mode,
+			struct drm_display_mode *adjusted_mode);
+	void (*prepare)(struct drm_encoder_connector *encon);
+	int (*set_property)(struct drm_encoder_connector *encon,
+			struct drm_property *property, uint64_t val);
+};
+
+struct drm_encoder_connector {
+	struct drm_connector connector;
+	struct sdrm_connector *sdrm_connector;
+	struct drm_encoder encoder;
+	struct sdrm_encoder *sdrm_encoder;
+	struct drm_encoder_connector_funcs *funcs;
+	struct module *owner;
+	void *encon_private;
+};
+
+void drm_encoder_connector_cleanup(struct drm_device *drm,
+		struct drm_encoder_connector *c);
+int drm_encoder_connector_register(const char *drm_name,
+		struct drm_encoder_connector *encon);
+void drm_encoder_connector_unregister(struct drm_encoder_connector *encon);
+
+struct sdrm_encon_dummy {
+	char *drm_name;
+	u32 possible_crtcs;
+	u32 possible_clones;
+	struct drm_display_mode *modes;
+	int num_modes;
+	struct module *owner;
+	void (*dpms)(struct sdrm_encon_dummy *dummy, int mode);
+	void *driver_priv;
+};
+
+struct drm_encoder_connector *sdrm_encon_add_dummy(struct sdrm_encon_dummy *);
+int sdrm_encon_remove_dummy(struct drm_encoder_connector *encon);
+
+struct sdrm_encon_dummy_pdata {
+	char *drm_name;
+	u32 possible_crtcs;
+	u32 possible_clones;
+	struct drm_display_mode *modes;
+	int num_modes;
+	int gpio_dpms;
+	int gpio_backlight;
+#define DRM_ENCON_DUMMY_USE_BL_GPIO		(1 << 0)
+#define DRM_ENCON_DUMMY_BL_GPIO_ACTIVE_LOW	(1 << 1)
+#define DRM_ENCON_DUMMY_USE_DPMS_GPIO		(1 << 2)
+#define DRM_ENCON_DUMMY_DPMS_GPIO_ACTIVE_LOW	(1 << 3)
+	unsigned flags;
+};
+
+#endif /* __DRM_ENCON_H */
-- 
1.7.9.5
