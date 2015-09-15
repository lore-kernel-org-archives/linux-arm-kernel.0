From: kong.kongxinwei@hisilicon.com (Xinwei Kong)
Date: Tue, 15 Sep 2015 17:37:09 +0800
Subject: [PATCH RFC 3/8] drm: hisilicon: Add the link to DRM/KMS interface
In-Reply-To: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
Message-ID: <1442309834-21420-4-git-send-email-kong.kongxinwei@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes the link with DRM/KMS interface by initializing the drm
plane/crtc/encoder/connector and adding the drm plane/crtc/encoder/
connector helper.

This patch is compatible with different hisilicon platform such as Hikey
series of boards and other series of boards.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Jiwen Qi <qijiwen@hisilicon.com>
Signed-off-by: Yu Gong <gongyu@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/Makefile             |   4 +
 drivers/gpu/drm/hisilicon/hisi_ade.c           |  44 +++++
 drivers/gpu/drm/hisilicon/hisi_ade_reg.h       |  27 +++
 drivers/gpu/drm/hisilicon/hisi_drm_connector.c |  90 ++++++++++
 drivers/gpu/drm/hisilicon/hisi_drm_connector.h |  25 +++
 drivers/gpu/drm/hisilicon/hisi_drm_crtc.c      | 179 ++++++++++++++++++
 drivers/gpu/drm/hisilicon/hisi_drm_crtc.h      |  45 +++++
 drivers/gpu/drm/hisilicon/hisi_drm_drv.h       |  36 ++++
 drivers/gpu/drm/hisilicon/hisi_drm_dsi.c       |  13 ++
 drivers/gpu/drm/hisilicon/hisi_drm_encoder.c   |  65 +++++++
 drivers/gpu/drm/hisilicon/hisi_drm_encoder.h   |  22 +++
 drivers/gpu/drm/hisilicon/hisi_drm_plane.c     | 240 +++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hisi_drm_plane.h     |  51 ++++++
 13 files changed, 841 insertions(+)
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_ade_reg.h
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_connector.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_connector.h
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_crtc.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_crtc.h
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_drv.h
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_encoder.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_encoder.h
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_plane.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_plane.h

diff --git a/drivers/gpu/drm/hisilicon/Makefile b/drivers/gpu/drm/hisilicon/Makefile
index 3f042fd..aa522f8 100644
--- a/drivers/gpu/drm/hisilicon/Makefile
+++ b/drivers/gpu/drm/hisilicon/Makefile
@@ -1,6 +1,10 @@
 hisi-drm-y := hisi_drm_drv.o \
 	      hisi_ade.o \
 	      hisi_drm_dsi.o \
+	      hisi_drm_plane.o \
+	      hisi_drm_crtc.o \
+	      hisi_drm_encoder.o \
+	      hisi_drm_connector.o \
 	      hisi_drm_fb.o \
 
 obj-$(CONFIG_DRM_HISI)	+= hisi-drm.o
diff --git a/drivers/gpu/drm/hisilicon/hisi_ade.c b/drivers/gpu/drm/hisilicon/hisi_ade.c
index 9b58d20..148ed2f 100644
--- a/drivers/gpu/drm/hisilicon/hisi_ade.c
+++ b/drivers/gpu/drm/hisilicon/hisi_ade.c
@@ -15,6 +15,16 @@
 
 #include <drm/drm_gem_cma_helper.h>
 
+#include "hisi_drm_plane.h"
+#include "hisi_drm_crtc.h"
+#include "hisi_ade_reg.h"
+
+#define PRIMARY_CH      (ADE_CH1)
+
+struct ade_crtc {
+	struct hisi_crtc base;
+};
+
 struct ade_hardware_context {
 	void __iomem  *base;
 	void __iomem  *media_base;
@@ -30,6 +40,8 @@ struct ade_hardware_context {
 };
 
 struct hisi_ade {
+	struct ade_crtc acrtc;
+	struct hisi_plane hplane[ADE_CH_NUM];
 	struct ade_hardware_context ctx;
 };
 
@@ -99,6 +111,38 @@ static int ade_dts_parse(struct platform_device *pdev,
 
 static int ade_bind(struct device *dev, struct device *master, void *data)
 {
+	struct hisi_ade *ade = dev_get_drvdata(dev);
+	struct ade_hardware_context *ctx = &ade->ctx;
+	struct hisi_crtc *hcrtc = &ade->acrtc.base;
+	struct drm_device *drm_dev = (struct drm_device *)data;
+	struct hisi_plane *hplane;
+	enum drm_plane_type type;
+	int ret;
+	int i;
+
+	/*
+	 * plane init
+	 * TODO: Now only support primary plane, overlay planes
+	 * need to do.
+	 */
+	for (i = 0; i < 1; i++) {
+		hplane = &ade->hplane[i];
+		hplane->ch = i;
+		hplane->ctx = ctx;
+		type = i == PRIMARY_CH ? DRM_PLANE_TYPE_PRIMARY :
+			DRM_PLANE_TYPE_OVERLAY;
+
+		ret = hisi_drm_plane_init(drm_dev, hplane, type);
+		if (ret)
+			return ret;
+	}
+
+	/* crtc init */
+	hcrtc->ctx = ctx;
+	ret = hisi_drm_crtc_init(drm_dev, hcrtc, &ade->hplane[PRIMARY_CH].base);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/hisilicon/hisi_ade_reg.h b/drivers/gpu/drm/hisilicon/hisi_ade_reg.h
new file mode 100644
index 0000000..bdf3c3b
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_ade_reg.h
@@ -0,0 +1,27 @@
+/*
+ * Hisilicon Terminal SoCs drm driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Author: Xinwei Kong <kong.kongxinwei@hisilicon.com> for hisilicon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __HISI_ADE_REG_H__
+#define __HISI_ADE_REG_H__
+
+enum ade_channel {
+	ADE_CH1 = 0,	/* channel 1 for primary plane */
+	ADE_CH2,
+	ADE_CH3,
+	ADE_CH4,
+	ADE_CH5,
+	ADE_CH6,
+	ADE_DISP,
+	ADE_CH_NUM
+};
+
+#endif
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_connector.c b/drivers/gpu/drm/hisilicon/hisi_drm_connector.c
new file mode 100644
index 0000000..62efdc7
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_connector.c
@@ -0,0 +1,90 @@
+/*
+ * Hisilicon Terminal SoCs drm driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Author: Xinwei Kong <kong.kongxinwei@hisilicon.com> for hisilicon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_encoder_slave.h>
+#include <drm/drm_atomic_helper.h>
+
+#include "hisi_drm_encoder.h"
+#include "hisi_drm_connector.h"
+
+#define to_hisi_connector(connector) \
+	container_of(connector, struct hisi_connector, connector)
+
+int hisi_drm_connector_mode_valid(struct drm_connector *connector,
+				  struct drm_display_mode *mode)
+{
+	int ret = MODE_OK;
+
+	return ret;
+}
+
+struct drm_encoder *
+hisi_drm_best_encoder(struct drm_connector *connector)
+{
+	struct hisi_connector *hconnector = to_hisi_connector(connector);
+	struct drm_encoder *encoder = hconnector->encoder;
+
+	return encoder;
+}
+
+int hisi_drm_get_modes(struct drm_connector *connector)
+{
+	int count = 0;
+
+	return count;
+}
+
+static struct drm_connector_helper_funcs hisi_drm_connector_helper_funcs = {
+	.get_modes = hisi_drm_get_modes,
+	.best_encoder =  hisi_drm_best_encoder,
+	.mode_valid = hisi_drm_connector_mode_valid,
+};
+
+void hisi_drm_connector_destroy(struct drm_connector *connector)
+{
+	drm_connector_unregister(connector);
+	drm_connector_cleanup(connector);
+}
+
+enum drm_connector_status
+hisi_drm_detect(struct drm_connector *connector, bool force)
+{
+	enum drm_connector_status status = connector_status_unknown;
+
+	return status;
+}
+
+static struct drm_connector_funcs hisi_drm_connector_funcs = {
+	.dpms = drm_atomic_helper_connector_dpms,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.detect = hisi_drm_detect,
+	.destroy = hisi_drm_connector_destroy,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+void hisi_drm_connector_init(struct drm_device *dev,
+			     struct drm_encoder *encoder,
+			     struct drm_connector *connector)
+{
+	connector->polled = DRM_CONNECTOR_POLL_HPD;
+	connector->dpms = DRM_MODE_DPMS_OFF;
+	drm_connector_init(encoder->dev, connector, &hisi_drm_connector_funcs,
+			   DRM_MODE_CONNECTOR_HDMIA);
+	drm_connector_helper_add(connector, &hisi_drm_connector_helper_funcs);
+	drm_connector_register(connector);
+	drm_mode_connector_attach_encoder(connector, encoder);
+
+	drm_mode_config_reset(dev);
+}
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_connector.h b/drivers/gpu/drm/hisilicon/hisi_drm_connector.h
new file mode 100644
index 0000000..114391c
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_connector.h
@@ -0,0 +1,25 @@
+/*
+ * Hisilicon Terminal SoCs drm driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Author: Xinwei Kong <kong.kongxinwei@hisilicon.com> for hisilicon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __HISI_DRM_CONNECTOR_H__
+#define __HISI_DRM_CONNECTOR_H__
+
+struct hisi_connector {
+	struct drm_connector connector;
+	struct drm_encoder *encoder;
+};
+
+void hisi_drm_connector_init(struct drm_device *dev,
+			     struct drm_encoder *encoder,
+			     struct drm_connector *connector);
+
+#endif
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_crtc.c b/drivers/gpu/drm/hisilicon/hisi_drm_crtc.c
new file mode 100644
index 0000000..ad13614
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_crtc.c
@@ -0,0 +1,179 @@
+/*
+ * Hisilicon Terminal SoCs drm driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Author: Xinwei Kong <kong.kongxinwei@hisilicon.com> for hisilicon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_atomic_helper.h>
+
+#include "hisi_drm_drv.h"
+#include "hisi_drm_crtc.h"
+
+static void  hisi_drm_crtc_enable(struct drm_crtc *crtc)
+{
+}
+
+static void hisi_drm_crtc_disable(struct drm_crtc *crtc)
+{
+}
+
+static void hisi_drm_crtc_mode_prepare(struct drm_crtc *crtc)
+{
+}
+
+static bool hisi_drm_crtc_mode_fixup(struct drm_crtc *crtc,
+				     const struct drm_display_mode *mode,
+				     struct drm_display_mode *adj_mode)
+{
+	bool ret = true;
+
+	return ret;
+}
+
+static void hisi_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
+{
+}
+
+static void hisi_crtc_atomic_begin(struct drm_crtc *crtc)
+{
+}
+
+static void hisi_crtc_atomic_flush(struct drm_crtc *crtc)
+{
+}
+
+static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
+	.enable		= hisi_drm_crtc_enable,
+	.disable	= hisi_drm_crtc_disable,
+	.prepare	= hisi_drm_crtc_mode_prepare,
+	.mode_fixup	= hisi_drm_crtc_mode_fixup,
+	.mode_set_nofb	= hisi_drm_crtc_mode_set_nofb,
+	.atomic_begin	= hisi_crtc_atomic_begin,
+	.atomic_flush	= hisi_crtc_atomic_flush,
+};
+
+static void hisi_drm_crtc_destroy(struct drm_crtc *c)
+{
+	drm_crtc_cleanup(c);
+}
+
+static void hisi_crtc_atomic_reset(struct drm_crtc *crtc)
+{
+	struct hisi_crtc_state *state;
+
+	if (crtc->state)
+		kfree(to_hisi_crtc_state(crtc->state));
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return;
+
+	/* set to default value */
+	state->comp_type = COMPOSITION_UNKNOWN;
+
+	crtc->state = &state->base;
+	crtc->state->crtc = crtc;
+}
+
+static struct drm_crtc_state *
+hisi_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
+{
+	struct hisi_crtc_state *state;
+	struct hisi_crtc_state *copy;
+
+	if (WARN_ON(!crtc->state))
+		return NULL;
+
+	state = to_hisi_crtc_state(crtc->state);
+	copy = kmemdup(state, sizeof(*state), GFP_KERNEL);
+	if (!copy)
+		return NULL;
+
+	__drm_atomic_helper_crtc_duplicate_state(crtc, &copy->base);
+
+	return &copy->base;
+}
+
+static void hisi_crtc_atomic_destroy_state(struct drm_crtc *crtc,
+					   struct drm_crtc_state *state)
+{
+	__drm_atomic_helper_crtc_destroy_state(crtc, state);
+	kfree(to_hisi_crtc_state(state));
+}
+
+static int hisi_crtc_atomic_set_property(struct drm_crtc *crtc,
+					 struct drm_crtc_state *state,
+					 struct drm_property *property,
+					 uint64_t val)
+{
+	struct hisi_drm_private *priv = crtc->dev->dev_private;
+	struct hisi_crtc_state *hstate = to_hisi_crtc_state(state);
+
+	if (property == priv->comp_type_prop)
+		hstate->comp_type = val;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int hisi_crtc_atomic_get_property(struct drm_crtc *crtc,
+					 const struct drm_crtc_state *state,
+					 struct drm_property *property,
+					 uint64_t *val)
+{
+	struct hisi_drm_private *priv = crtc->dev->dev_private;
+	struct hisi_crtc_state *hstate = to_hisi_crtc_state(state);
+
+	if (property == priv->comp_type_prop)
+		*val =	hstate->comp_type;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct drm_crtc_funcs crtc_funcs = {
+	.destroy	= hisi_drm_crtc_destroy,
+	.set_config	= drm_atomic_helper_set_config,
+	.page_flip	= drm_atomic_helper_page_flip,
+	.reset		= hisi_crtc_atomic_reset,
+	.set_property = drm_atomic_helper_crtc_set_property,
+	.atomic_duplicate_state	= hisi_crtc_atomic_duplicate_state,
+	.atomic_destroy_state	= hisi_crtc_atomic_destroy_state,
+	.atomic_set_property = hisi_crtc_atomic_set_property,
+	.atomic_get_property = hisi_crtc_atomic_get_property,
+};
+
+int hisi_drm_crtc_init(struct drm_device *dev,
+		       struct hisi_crtc *hcrtc,
+		       struct drm_plane *plane)
+{
+	struct hisi_crtc_ops *ops = hcrtc->ops;
+	int ret;
+
+	ret = drm_crtc_init_with_planes(dev, &hcrtc->base, plane,
+					NULL, &crtc_funcs);
+	if (ret) {
+		DRM_ERROR("failed to init crtc.\n");
+		return ret;
+	}
+
+	drm_crtc_helper_add(&hcrtc->base, &crtc_helper_funcs);
+
+	if (ops->install_properties) {
+		ret = ops->install_properties(dev, hcrtc);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_crtc.h b/drivers/gpu/drm/hisilicon/hisi_drm_crtc.h
new file mode 100644
index 0000000..989cb1f
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_crtc.h
@@ -0,0 +1,45 @@
+/*
+ * Hisilicon Terminal SoCs drm driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Author: Xinwei Kong <kong.kongxinwei@hisilicon.com> for hisilicon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __HISI_DRM_CRTC_H__
+#define __HISI_DRM_CRTC_H__
+
+#define to_hisi_crtc_state(state) \
+		container_of(state, struct hisi_crtc_state, base)
+
+enum composotion_type {
+	COMPOSITION_UNKNOWN	= 0,
+	COMPOSITION_GLES	= 1,
+	COMPOSITION_HWC		= 2,
+	COMPOSITION_MIXED	= 3
+};
+
+struct hisi_crtc {
+	struct drm_crtc base;
+	void *ops;
+	void *ctx;
+};
+
+struct hisi_crtc_ops {
+	int (*install_properties)(struct drm_device *dev,
+				  struct hisi_crtc *hcrtc);
+};
+
+struct hisi_crtc_state {
+	struct drm_crtc_state base;
+	u8 comp_type;
+};
+
+int hisi_drm_crtc_init(struct drm_device *dev, struct hisi_crtc *crtc,
+		       struct drm_plane *plane);
+
+#endif
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_drv.h b/drivers/gpu/drm/hisilicon/hisi_drm_drv.h
new file mode 100644
index 0000000..0b96357
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_drv.h
@@ -0,0 +1,36 @@
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
+#ifndef __HISI_DRM_DRV_H__
+#define __HISI_DRM_DRV_H__
+
+struct hisi_drm_private {
+	struct hisi_drm_fbdev	*fbdev;
+
+	/* plane properties */
+	struct drm_property *zpos_prop;
+	struct drm_property *alpha_prop;
+	struct drm_property *blend_prop;
+
+	/*
+	* read only capabilities properties
+	* 0: unsupport
+	* 1: support
+	*/
+	struct drm_property *cap_scl_prop;
+	struct drm_property *cap_rot_prop;
+
+	/* crtc properties */
+	struct drm_property *comp_type_prop;
+};
+
+#endif /* __HISI_DRM_DRV_H__ */
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c b/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
index a8dbaad..046fd8e 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
@@ -16,9 +16,15 @@
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_encoder_slave.h>
 
+#include "hisi_drm_encoder.h"
+#include "hisi_drm_connector.h"
+
 #define DSI_24BITS_1               (5)
 
 struct hisi_dsi {
+	struct hisi_encoder hisi_encoder;
+	struct hisi_connector hisi_connector;
+
 	u32 lanes;
 	u32 format;
 	u32 date_enable_pol;
@@ -39,8 +45,15 @@ struct hisi_dsi_context {
 static int hisi_dsi_bind(struct device *dev, struct device *master,
 			 void *data)
 {
+	struct hisi_dsi_context *ctx = dev_get_drvdata(dev);
 	int ret = 0;
 
+	ctx->dev = data;
+
+	hisi_drm_encoder_init(ctx->dev, &ctx->dsi.hisi_encoder.base.base);
+
+	hisi_drm_connector_init(ctx->dev, &ctx->dsi.hisi_encoder.base.base,
+				&ctx->dsi.hisi_connector.connector);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_encoder.c b/drivers/gpu/drm/hisilicon/hisi_drm_encoder.c
new file mode 100644
index 0000000..89fc73d
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_encoder.c
@@ -0,0 +1,65 @@
+/*
+ * Hisilicon Terminal SoCs drm driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Author: Xinwei Kong <kong.kongxinwei@hisilicon.com> for hisilicon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_encoder_slave.h>
+
+#include "hisi_drm_encoder.h"
+
+void hisi_drm_encoder_disable(struct drm_encoder *encoder)
+{
+}
+
+void hisi_drm_encoder_enable(struct drm_encoder *encoder)
+{
+}
+
+void hisi_drm_encoder_mode_set(struct drm_encoder *encoder,
+			       struct drm_display_mode *mode,
+			       struct drm_display_mode *adjusted_mode)
+{
+}
+
+bool
+hisi_drm_encoder_mode_fixup(struct drm_encoder *encoder,
+			    const struct drm_display_mode *mode,
+			    struct drm_display_mode *adjusted_mode)
+{
+	bool ret = true;
+
+	return ret;
+}
+
+void hisi_drm_encoder_destroy(struct drm_encoder *encoder)
+{
+}
+
+static struct drm_encoder_helper_funcs hisi_encoder_helper_funcs = {
+	.mode_fixup	= hisi_drm_encoder_mode_fixup,
+	.mode_set	= hisi_drm_encoder_mode_set,
+	.enable		= hisi_drm_encoder_enable,
+	.disable	= hisi_drm_encoder_disable
+};
+
+static struct drm_encoder_funcs hisi_encoder_funcs = {
+	.destroy = hisi_drm_encoder_destroy
+};
+
+void hisi_drm_encoder_init(struct drm_device *dev,
+			   struct drm_encoder *encoder)
+{
+	encoder->possible_crtcs = 1;
+
+	drm_encoder_init(dev, encoder, &hisi_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS);
+	drm_encoder_helper_add(encoder, &hisi_encoder_helper_funcs);
+}
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_encoder.h b/drivers/gpu/drm/hisilicon/hisi_drm_encoder.h
new file mode 100644
index 0000000..31c04e4
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_encoder.h
@@ -0,0 +1,22 @@
+/*
+ * Hisilicon Terminal SoCs drm driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Author: Xinwei Kong <kong.kongxinwei@hisilicon.com> for hisilicon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __HISI_DRM_ENCODER_H__
+#define __HISI_DRM_ENCODER_H__
+
+struct hisi_encoder {
+	struct drm_encoder_slave base;
+};
+
+void hisi_drm_encoder_init(struct drm_device *dev, struct drm_encoder *encoder);
+
+#endif
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_plane.c b/drivers/gpu/drm/hisilicon/hisi_drm_plane.c
new file mode 100644
index 0000000..af040b6
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_plane.c
@@ -0,0 +1,240 @@
+/*
+ * Hisilicon Terminal SoCs drm driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Author: Xinwei Kong <kong.kongxinwei@hisilicon.com> for hisilicon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <drm/drmP.h>
+#include <drm/drm_plane_helper.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic.h>
+
+#include "hisi_drm_drv.h"
+#include "hisi_drm_plane.h"
+
+#define to_hisi_plane(plane) \
+		container_of(plane, struct hisi_plane, base)
+
+static void hisi_plane_atomic_disable(struct drm_plane *plane,
+				      struct drm_plane_state *old_state)
+{
+}
+
+static void hisi_plane_atomic_update(struct drm_plane *plane,
+				     struct drm_plane_state *old_state)
+{
+}
+
+int hisi_plane_atomic_check(struct drm_plane *plane,
+			    struct drm_plane_state *state)
+{
+	struct drm_framebuffer *fb = state->fb;
+	struct drm_crtc *crtc = state->crtc;
+	struct drm_crtc_state *crtc_state;
+	u32 src_x = state->src_x >> 16;
+	u32 src_y = state->src_y >> 16;
+	u32 src_w = state->src_w >> 16;
+	u32 src_h = state->src_h >> 16;
+	u32 crtc_w = state->crtc_w;
+	u32 crtc_h = state->crtc_h;
+	int crtc_x = state->crtc_x;
+	int crtc_y = state->crtc_y;
+
+	if (!crtc || !fb)
+		return 0;
+
+	if (state->rotation != BIT(DRM_ROTATE_0)) {
+		DRM_ERROR("Rotation not support!!!\n");
+		return -EINVAL;
+	}
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
+void hisi_plane_cleanup_fb(struct drm_plane *plane,
+			   struct drm_framebuffer *fb,
+			   const struct drm_plane_state *old_state)
+{
+}
+
+int hisi_plane_prepare_fb(struct drm_plane *p,
+			  struct drm_framebuffer *fb,
+			  const struct drm_plane_state *new_state)
+{
+	return 0;
+}
+
+static const struct drm_plane_helper_funcs hisi_plane_helper_funcs = {
+	.prepare_fb = hisi_plane_prepare_fb,
+	.cleanup_fb = hisi_plane_cleanup_fb,
+	.atomic_check = hisi_plane_atomic_check,
+	.atomic_update = hisi_plane_atomic_update,
+	.atomic_disable = hisi_plane_atomic_disable,
+};
+
+void hisi_plane_destroy(struct drm_plane *plane)
+{
+	drm_plane_cleanup(plane);
+}
+
+static void hisi_plane_atomic_reset(struct drm_plane *plane)
+{
+	struct hisi_plane_state *state;
+
+	if (plane->state && plane->state->fb)
+		drm_framebuffer_unreference(plane->state->fb);
+
+	if (plane->state)
+		kfree(to_hisi_plane_state(plane->state));
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return;
+
+	/* set to default value */
+	state->zpos = plane->type == DRM_PLANE_TYPE_PRIMARY ? 0 :
+		drm_plane_index(plane);
+	state->base.rotation = BIT(DRM_ROTATE_0);
+	state->alpha = 255;
+	state->blend = ALPHA_BLENDING_NONE;
+
+	plane->state = &state->base;
+	plane->state->plane = plane;
+}
+
+static struct drm_plane_state *
+hisi_plane_atomic_duplicate_state(struct drm_plane *plane)
+{
+	struct hisi_plane_state *hstate;
+	struct hisi_plane_state *copy;
+
+	if (WARN_ON(!plane->state))
+		return NULL;
+
+	hstate = to_hisi_plane_state(plane->state);
+	copy = kmemdup(hstate, sizeof(*hstate), GFP_KERNEL);
+	if (!copy)
+		return NULL;
+
+	__drm_atomic_helper_plane_duplicate_state(plane, &copy->base);
+
+	return &copy->base;
+}
+
+static void hisi_plane_atomic_destroy_state(struct drm_plane *plane,
+					    struct drm_plane_state *state)
+{
+	__drm_atomic_helper_plane_destroy_state(plane, state);
+	kfree(to_hisi_plane_state(state));
+}
+
+static int hisi_plane_atomic_set_property(struct drm_plane *plane,
+					  struct drm_plane_state *state,
+					  struct drm_property *property,
+					  uint64_t val)
+{
+	struct hisi_drm_private *priv = plane->dev->dev_private;
+	struct hisi_plane_state *hstate = to_hisi_plane_state(state);
+
+	if (property == priv->zpos_prop)
+		hstate->zpos = val;
+	else if (property == priv->alpha_prop)
+		hstate->alpha = val;
+	else if (property == priv->blend_prop)
+		hstate->blend = val;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int hisi_plane_atomic_get_property(struct drm_plane *plane,
+					  const struct drm_plane_state *state,
+					  struct drm_property *property,
+					  uint64_t *val)
+{
+	struct hisi_drm_private *priv = plane->dev->dev_private;
+	const struct hisi_plane_state *hstate = to_hisi_plane_state(state);
+
+	if (property == priv->zpos_prop)
+		*val = hstate->zpos;
+	else if (property == priv->alpha_prop)
+		*val = hstate->alpha;
+	else if (property == priv->blend_prop)
+		*val = hstate->blend;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct drm_plane_funcs hisi_plane_funcs = {
+	.update_plane	= drm_atomic_helper_update_plane,
+	.disable_plane	= drm_atomic_helper_disable_plane,
+	.set_property = drm_atomic_helper_plane_set_property,
+	.destroy = hisi_plane_destroy,
+	.reset = hisi_plane_atomic_reset,
+	.atomic_duplicate_state = hisi_plane_atomic_duplicate_state,
+	.atomic_destroy_state = hisi_plane_atomic_destroy_state,
+	.atomic_set_property = hisi_plane_atomic_set_property,
+	.atomic_get_property = hisi_plane_atomic_get_property,
+};
+
+int hisi_drm_plane_init(struct drm_device *dev,
+			struct hisi_plane *hplane,
+			enum drm_plane_type type)
+{
+	struct hisi_plane_funcs *ops = hplane->ops;
+	const u32 *fmts;
+	u32 fmts_cnt;
+	int ret = 0;
+
+	/* get  properties */
+	fmts_cnt = ops->get_properties(hplane->ch, &fmts);
+	if (ret)
+		return ret;
+	ret = drm_universal_plane_init(dev, &hplane->base, 1,
+				       &hisi_plane_funcs,
+				       fmts, fmts_cnt, type);
+	if (ret) {
+		DRM_ERROR("fail to init plane, ch: %d\n", hplane->ch);
+		return ret;
+	}
+
+	drm_plane_helper_add(&hplane->base, &hisi_plane_helper_funcs);
+
+	/* install overlay plane properties */
+	if (type == DRM_PLANE_TYPE_OVERLAY && ops->install_properties) {
+		ret = ops->install_properties(dev, hplane);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_plane.h b/drivers/gpu/drm/hisilicon/hisi_drm_plane.h
new file mode 100644
index 0000000..70ee845
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_plane.h
@@ -0,0 +1,51 @@
+/*
+ * Hisilicon Terminal SoCs drm driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Author: Xinwei Kong <kong.kongxinwei@hisilicon.com> for hisilicon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __HISI_DRM_PLANE_H__
+#define __HISI_DRM_PLANE_H__
+
+#define to_hisi_plane_state(s)  container_of(s, struct hisi_plane_state, base)
+
+enum {
+	/* no blending */
+	ALPHA_BLENDING_NONE     = 0x0100,
+	/* ONE / ONE_MINUS_SRC_ALPHA */
+	ALPHA_BLENDING_PREMULT  = 0x0105,
+	/* SRC_ALPHA / ONE_MINUS_SRC_ALPHA */
+	ALPHA_BLENDING_COVERAGE = 0x0405
+};
+
+struct hisi_plane {
+	struct drm_plane base;
+	void *ops;
+	void *ctx;
+	u8 ch; /* channel or pipe */
+};
+
+struct hisi_plane_funcs {
+	u32 (*get_properties)(u8 ch, const u32 **formats);
+	int (*install_properties)(struct drm_device *dev,
+				  struct hisi_plane *hplane);
+};
+
+int hisi_drm_plane_init(struct drm_device *dev, struct hisi_plane *hplane,
+			enum drm_plane_type type);
+
+/* plane structs  */
+struct hisi_plane_state {
+	struct drm_plane_state base;
+	u8 zpos;  /* z order */
+	u8 alpha; /* Alpha value applied to the whole plane */
+	u32 blend; /* blending cases: none, premult and coverage */
+};
+
+#endif
-- 
1.9.1
