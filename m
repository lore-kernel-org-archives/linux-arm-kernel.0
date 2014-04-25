From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:49:09 +0100
Subject: [PATCH 170/222] drm: add generic ddc connector
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1Wdecv-0007Om-6i@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/Makefile            |  1 +
 drivers/staging/imx-drm/drm-ddc-connector.c | 92 +++++++++++++++++++++++++++++
 drivers/staging/imx-drm/drm-ddc-connector.h | 26 ++++++++
 drivers/staging/imx-drm/imx-hdmi.c          | 82 ++++++-------------------
 drivers/staging/imx-drm/imx-tve.c           | 63 ++++----------------
 5 files changed, 150 insertions(+), 114 deletions(-)
 create mode 100644 drivers/staging/imx-drm/drm-ddc-connector.c
 create mode 100644 drivers/staging/imx-drm/drm-ddc-connector.h

diff --git a/drivers/staging/imx-drm/Makefile b/drivers/staging/imx-drm/Makefile
index 2295a6805d69..5eabd5e4e456 100644
--- a/drivers/staging/imx-drm/Makefile
+++ b/drivers/staging/imx-drm/Makefile
@@ -3,6 +3,7 @@ imxdrm-objs := imx-drm-core.o
 
 obj-$(CONFIG_DRM_IMX) += imxdrm.o
 
+obj-$(CONFIG_DRM_IMX) += drm-ddc-connector.o
 obj-$(CONFIG_DRM_IMX_PARALLEL_DISPLAY) += parallel-display.o
 obj-$(CONFIG_DRM_IMX_TVE) += imx-tve.o
 obj-$(CONFIG_DRM_IMX_LDB) += imx-ldb.o
diff --git a/drivers/staging/imx-drm/drm-ddc-connector.c b/drivers/staging/imx-drm/drm-ddc-connector.c
new file mode 100644
index 000000000000..a36ed4b06ebe
--- /dev/null
+++ b/drivers/staging/imx-drm/drm-ddc-connector.c
@@ -0,0 +1,92 @@
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_edid.h>
+
+#include "drm-ddc-connector.h"
+
+static enum drm_connector_status
+drm_ddc_connector_detect(struct drm_connector *connector, bool force)
+{
+	struct drm_ddc_connector *ddc_conn = to_ddc_conn(connector);
+
+	return ddc_conn->detect ? ddc_conn->detect(connector, force) :
+		connector_status_connected;
+}
+
+int drm_ddc_connector_get_modes(struct drm_connector *connector)
+{
+	struct drm_ddc_connector *ddc_conn = to_ddc_conn(connector);
+	struct edid *edid;
+	int ret = 0;
+
+	if (!ddc_conn->ddc)
+		return 0;
+
+	edid = drm_get_edid(connector, ddc_conn->ddc);
+	if (edid) {
+		drm_mode_connector_update_edid_property(connector, edid);
+		ret = drm_add_edid_modes(connector, edid);
+		/* Store the ELD */
+		drm_edid_to_eld(connector, edid);
+		kfree(edid);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(drm_ddc_connector_get_modes);
+
+static void drm_ddc_connector_destroy(struct drm_connector *connector)
+{
+	struct drm_ddc_connector *ddc_conn = to_ddc_conn(connector);
+
+	drm_sysfs_connector_remove(connector);
+	drm_connector_cleanup(connector);
+	if (ddc_conn->ddc)
+		i2c_put_adapter(ddc_conn->ddc);
+}
+
+static const struct drm_connector_funcs drm_ddc_connector_funcs = {
+	.dpms = drm_helper_connector_dpms,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.detect = drm_ddc_connector_detect,
+	.destroy = drm_ddc_connector_destroy,
+};
+
+int drm_ddc_connector_add(struct drm_device *drm,
+	struct drm_ddc_connector *ddc_conn, int connector_type)
+{
+	drm_connector_init(drm, &ddc_conn->connector, &drm_ddc_connector_funcs,
+			   connector_type);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(drm_ddc_connector_add);
+
+struct drm_ddc_connector *drm_ddc_connector_create(struct drm_device *drm,
+	struct device_node *np, void *private)
+{
+	struct drm_ddc_connector *ddc_conn;
+	struct device_node *ddc_node;
+
+	ddc_conn = devm_kzalloc(drm->dev, sizeof(*ddc_conn), GFP_KERNEL);
+	if (!ddc_conn)
+		return ERR_PTR(-ENOMEM);
+
+	ddc_conn->private = private;
+
+	ddc_node = of_parse_phandle(np, "ddc-i2c-bus", 0);
+	if (ddc_node) {
+		ddc_conn->ddc = of_find_i2c_adapter_by_node(ddc_node);
+		of_node_put(ddc_node);
+		if (!ddc_conn->ddc)
+			return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	return ddc_conn;
+}
+EXPORT_SYMBOL_GPL(drm_ddc_connector_create);
+
+MODULE_AUTHOR("Russell King <rmk+kernel@arm.linux.org.uk>");
+MODULE_DESCRIPTION("Generic DRM DDC connector module");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/imx-drm/drm-ddc-connector.h b/drivers/staging/imx-drm/drm-ddc-connector.h
new file mode 100644
index 000000000000..38068e5105d3
--- /dev/null
+++ b/drivers/staging/imx-drm/drm-ddc-connector.h
@@ -0,0 +1,26 @@
+#ifndef DRM_DDC_CONNECTOR_H
+#define DRM_DDC_CONNECTOR_H
+
+struct drm_ddc_connector {
+	struct i2c_adapter *ddc;
+	struct drm_connector connector;
+	enum drm_connector_status (*detect)(struct drm_connector *, bool);
+	void *private;
+};
+
+#define to_ddc_conn(c) container_of(c, struct drm_ddc_connector, connector)
+
+int drm_ddc_connector_get_modes(struct drm_connector *connector);
+int drm_ddc_connector_add(struct drm_device *drm,
+	struct drm_ddc_connector *ddc_conn, int connector_type);
+struct drm_ddc_connector *drm_ddc_connector_create(struct drm_device *drm,
+	struct device_node *np, void *private);
+
+static inline void *drm_ddc_private(struct drm_connector *connector)
+{
+	struct drm_ddc_connector *ddc_conn = to_ddc_conn(connector);
+
+	return ddc_conn->private;
+}
+
+#endif
diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index c3bd89d34d40..627b4b608794 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -28,6 +28,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder_slave.h>
 
+#include "drm-ddc-connector.h"
 #include "dw-hdmi-audio.h"
 #include "dw-hdmi-cec.h"
 #include "ipu-v3/imx-ipu-v3.h"
@@ -114,7 +115,7 @@ struct hdmi_data_info {
 };
 
 struct imx_hdmi {
-	struct drm_connector connector;
+	struct drm_ddc_connector *ddc_conn;
 	struct drm_encoder encoder;
 
 	struct platform_device *audio;
@@ -135,7 +136,6 @@ struct imx_hdmi {
 	struct drm_display_mode previous_mode;
 
 	struct regmap *regmap;
-	struct i2c_adapter *ddc;
 	void __iomem *regs;
 
 	unsigned int sample_rate;
@@ -1392,45 +1392,16 @@ static void imx_hdmi_poweroff(struct imx_hdmi *hdmi)
 static enum drm_connector_status imx_hdmi_connector_detect(struct drm_connector
 							*connector, bool force)
 {
-	struct imx_hdmi *hdmi = container_of(connector, struct imx_hdmi,
-					     connector);
+	struct imx_hdmi *hdmi = drm_ddc_private(connector);
 
 	return hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_HPD ?
 		connector_status_connected : connector_status_disconnected;
 }
 
-static int imx_hdmi_connector_get_modes(struct drm_connector *connector)
-{
-	struct imx_hdmi *hdmi = container_of(connector, struct imx_hdmi,
-					     connector);
-	struct edid *edid;
-	int ret;
-
-	if (!hdmi->ddc)
-		return 0;
-
-	edid = drm_get_edid(connector, hdmi->ddc);
-	if (edid) {
-		dev_dbg(hdmi->dev, "got edid: width[%d] x height[%d]\n",
-			edid->width_cm, edid->height_cm);
-
-		drm_mode_connector_update_edid_property(connector, edid);
-		ret = drm_add_edid_modes(connector, edid);
-		/* Store the ELD */
-		drm_edid_to_eld(connector, edid);
-		kfree(edid);
-	} else {
-		dev_dbg(hdmi->dev, "failed to get edid\n");
-	}
-
-	return 0;
-}
-
 static struct drm_encoder *imx_hdmi_connector_best_encoder(struct drm_connector
 							   *connector)
 {
-	struct imx_hdmi *hdmi = container_of(connector, struct imx_hdmi,
-					     connector);
+	struct imx_hdmi *hdmi = drm_ddc_private(connector);
 
 	return &hdmi->encoder;
 }
@@ -1499,15 +1470,8 @@ static struct drm_encoder_helper_funcs imx_hdmi_encoder_helper_funcs = {
 	.disable = imx_hdmi_encoder_disable,
 };
 
-static struct drm_connector_funcs imx_hdmi_connector_funcs = {
-	.dpms = drm_helper_connector_dpms,
-	.fill_modes = drm_helper_probe_single_connector_modes,
-	.detect = imx_hdmi_connector_detect,
-	.destroy = imx_drm_connector_destroy,
-};
-
 static struct drm_connector_helper_funcs imx_hdmi_connector_helper_funcs = {
-	.get_modes = imx_hdmi_connector_get_modes,
+	.get_modes = drm_ddc_connector_get_modes,
 	.mode_valid = imx_drm_connector_mode_valid,
 	.best_encoder = imx_hdmi_connector_best_encoder,
 };
@@ -1549,7 +1513,7 @@ static irqreturn_t imx_hdmi_irq(int irq, void *dev_id)
 
 			imx_hdmi_poweroff(hdmi);
 		}
-		drm_helper_hpd_irq_event(hdmi->connector.dev);
+		drm_helper_hpd_irq_event(hdmi->ddc_conn->connector.dev);
 	}
 
 	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
@@ -1567,20 +1531,17 @@ static int imx_hdmi_register(struct drm_device *drm, struct imx_hdmi *hdmi)
 	if (ret)
 		return ret;
 
-	hdmi->connector.polled = DRM_CONNECTOR_POLL_HPD;
+	hdmi->ddc_conn->connector.polled = DRM_CONNECTOR_POLL_HPD;
 
 	drm_encoder_helper_add(&hdmi->encoder, &imx_hdmi_encoder_helper_funcs);
 	drm_encoder_init(drm, &hdmi->encoder, &imx_hdmi_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS);
 
-	drm_connector_helper_add(&hdmi->connector,
+	drm_connector_helper_add(&hdmi->ddc_conn->connector,
 			&imx_hdmi_connector_helper_funcs);
-	drm_connector_init(drm, &hdmi->connector, &imx_hdmi_connector_funcs,
-			   DRM_MODE_CONNECTOR_HDMIA);
+	drm_ddc_connector_add(drm, hdmi->ddc_conn, DRM_MODE_CONNECTOR_HDMIA);
 
-	hdmi->connector.encoder = &hdmi->encoder;
-
-	drm_mode_connector_attach_encoder(&hdmi->connector, &hdmi->encoder);
+	drm_mode_connector_attach_encoder(&hdmi->ddc_conn->connector, &hdmi->encoder);
 
 	return 0;
 }
@@ -1632,7 +1593,6 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 				of_match_device(imx_hdmi_dt_ids, dev);
 	struct drm_device *drm = data;
 	struct device_node *np = dev->of_node;
-	struct device_node *ddc_node;
 	struct dw_hdmi_audio_data audio;
 	struct dw_hdmi_cec_data cec;
 	struct imx_hdmi *hdmi;
@@ -1643,6 +1603,12 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (!hdmi)
 		return -ENOMEM;
 
+	hdmi->ddc_conn = drm_ddc_connector_create(drm, np, hdmi);
+	if (IS_ERR(hdmi->ddc_conn))
+		return PTR_ERR(hdmi->ddc_conn);
+
+	hdmi->ddc_conn->detect = imx_hdmi_connector_detect;
+
 	hdmi->dev = dev;
 	hdmi->sample_rate = 48000;
 	hdmi->ratio = 100;
@@ -1653,17 +1619,6 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 		hdmi->dev_type = device_id->driver_data;
 	}
 
-	ddc_node = of_parse_phandle(np, "ddc-i2c-bus", 0);
-	if (ddc_node) {
-		hdmi->ddc = of_find_i2c_adapter_by_node(ddc_node);
-		if (!hdmi->ddc)
-			dev_dbg(hdmi->dev, "failed to read ddc node\n");
-
-		of_node_put(ddc_node);
-	} else {
-		dev_dbg(hdmi->dev, "no ddc property found\n");
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return -EINVAL;
@@ -1757,7 +1712,7 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 	audio.base = hdmi->regs;
 	audio.irq = irq;
 	audio.hdmi = hdmi;
-	audio.eld = hdmi->connector.eld;
+	audio.eld = hdmi->ddc_conn->connector.eld;
 	audio.set_sample_rate = imx_hdmi_set_sample_rate;
 
 	pdevinfo.name = "dw-hdmi-audio";
@@ -1803,12 +1758,11 @@ static void imx_hdmi_unbind(struct device *dev, struct device *master,
 	/* Disable all interrupts */
 	hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
 
-	hdmi->connector.funcs->destroy(&hdmi->connector);
+	hdmi->ddc_conn->connector.funcs->destroy(&hdmi->ddc_conn->connector);
 	hdmi->encoder.funcs->destroy(&hdmi->encoder);
 
 	clk_disable_unprepare(hdmi->iahb_clk);
 	clk_disable_unprepare(hdmi->isfr_clk);
-	i2c_put_adapter(hdmi->ddc);
 }
 
 static const struct component_ops hdmi_ops = {
diff --git a/drivers/staging/imx-drm/imx-tve.c b/drivers/staging/imx-drm/imx-tve.c
index 575533f4fd64..6eafba5072ad 100644
--- a/drivers/staging/imx-drm/imx-tve.c
+++ b/drivers/staging/imx-drm/imx-tve.c
@@ -22,7 +22,6 @@
 #include <linux/clk-provider.h>
 #include <linux/component.h>
 #include <linux/module.h>
-#include <linux/i2c.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spinlock.h>
@@ -31,6 +30,7 @@
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
 
+#include "drm-ddc-connector.h"
 #include "ipu-v3/imx-ipu-v3.h"
 #include "imx-drm.h"
 
@@ -111,7 +111,7 @@ enum {
 };
 
 struct imx_tve {
-	struct drm_connector connector;
+	struct drm_ddc_connector *ddc_conn;
 	struct drm_encoder encoder;
 	struct device *dev;
 	spinlock_t lock;	/* register lock */
@@ -120,7 +120,6 @@ struct imx_tve {
 
 	struct regmap *regmap;
 	struct regulator *dac_reg;
-	struct i2c_adapter *ddc;
 	struct clk *clk;
 	struct clk *di_sel_clk;
 	struct clk_hw clk_hw_di;
@@ -219,35 +218,10 @@ static int tve_setup_vga(struct imx_tve *tve)
 	return 0;
 }
 
-static enum drm_connector_status imx_tve_connector_detect(
-				struct drm_connector *connector, bool force)
-{
-	return connector_status_connected;
-}
-
-static int imx_tve_connector_get_modes(struct drm_connector *connector)
-{
-	struct imx_tve *tve = con_to_tve(connector);
-	struct edid *edid;
-	int ret = 0;
-
-	if (!tve->ddc)
-		return 0;
-
-	edid = drm_get_edid(connector, tve->ddc);
-	if (edid) {
-		drm_mode_connector_update_edid_property(connector, edid);
-		ret = drm_add_edid_modes(connector, edid);
-		kfree(edid);
-	}
-
-	return ret;
-}
-
 static int imx_tve_connector_mode_valid(struct drm_connector *connector,
 					struct drm_display_mode *mode)
 {
-	struct imx_tve *tve = con_to_tve(connector);
+	struct imx_tve *tve = to_ddc_conn(connector)->private;
 	unsigned long rate;
 	int ret;
 
@@ -274,7 +248,7 @@ static int imx_tve_connector_mode_valid(struct drm_connector *connector,
 static struct drm_encoder *imx_tve_connector_best_encoder(
 		struct drm_connector *connector)
 {
-	struct imx_tve *tve = con_to_tve(connector);
+	struct imx_tve *tve = drm_ddc_private(connector);
 
 	return &tve->encoder;
 }
@@ -362,15 +336,8 @@ static void imx_tve_encoder_disable(struct drm_encoder *encoder)
 	tve_disable(tve);
 }
 
-static struct drm_connector_funcs imx_tve_connector_funcs = {
-	.dpms = drm_helper_connector_dpms,
-	.fill_modes = drm_helper_probe_single_connector_modes,
-	.detect = imx_tve_connector_detect,
-	.destroy = imx_drm_connector_destroy,
-};
-
 static struct drm_connector_helper_funcs imx_tve_connector_helper_funcs = {
-	.get_modes = imx_tve_connector_get_modes,
+	.get_modes = drm_ddc_connector_get_modes,
 	.best_encoder = imx_tve_connector_best_encoder,
 	.mode_valid = imx_tve_connector_mode_valid,
 };
@@ -513,12 +480,11 @@ static int imx_tve_register(struct drm_device *drm, struct imx_tve *tve)
 	drm_encoder_init(drm, &tve->encoder, &imx_tve_encoder_funcs,
 			 encoder_type);
 
-	drm_connector_helper_add(&tve->connector,
+	drm_connector_helper_add(&tve->ddc_conn->connector,
 			&imx_tve_connector_helper_funcs);
-	drm_connector_init(drm, &tve->connector, &imx_tve_connector_funcs,
-			   DRM_MODE_CONNECTOR_VGA);
+	drm_ddc_connector_add(drm, tve->ddc_conn, DRM_MODE_CONNECTOR_VGA);
 
-	drm_mode_connector_attach_encoder(&tve->connector, &tve->encoder);
+	drm_mode_connector_attach_encoder(&tve->ddc_conn->connector, &tve->encoder);
 
 	return 0;
 }
@@ -567,7 +533,6 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = data;
 	struct device_node *np = dev->of_node;
-	struct device_node *ddc_node;
 	struct imx_tve *tve;
 	struct resource *res;
 	void __iomem *base;
@@ -579,15 +544,13 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 	if (!tve)
 		return -ENOMEM;
 
+	tve->ddc_conn = drm_ddc_connector_create(drm, np, tve);
+	if (IS_ERR(tve->ddc_conn))
+		return PTR_ERR(tve->ddc_conn);
+
 	tve->dev = dev;
 	spin_lock_init(&tve->lock);
 
-	ddc_node = of_parse_phandle(np, "i2c-ddc-bus", 0);
-	if (ddc_node) {
-		tve->ddc = of_find_i2c_adapter_by_node(ddc_node);
-		of_node_put(ddc_node);
-	}
-
 	tve->mode = of_get_tve_mode(np);
 	if (tve->mode != TVE_MODE_VGA) {
 		dev_err(dev, "only VGA mode supported, currently\n");
@@ -694,7 +657,7 @@ static void imx_tve_unbind(struct device *dev, struct device *master,
 {
 	struct imx_tve *tve = dev_get_drvdata(dev);
 
-	tve->connector.funcs->destroy(&tve->connector);
+	tve->ddc_conn->connector.funcs->destroy(&tve->ddc_conn->connector);
 	tve->encoder.funcs->destroy(&tve->encoder);
 
 	if (!IS_ERR(tve->dac_reg))
-- 
1.8.3.1
