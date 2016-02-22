From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Feb 2016 22:08:35 +0100
Subject: [PATCH 1/8] drm: msm: rename hdmi symbols
In-Reply-To: <1456175331-714117-1-git-send-email-arnd@arndb.de>
References: <1456175331-714117-1-git-send-email-arnd@arndb.de>
Message-ID: <1456175331-714117-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Global symbols in the kernel should be prefixed by the name
of the subsystem and/or driver to avoid conflicts when all
code is built-in.

In this case, function names like 'hdmi_register' or 'hdmi_set_mode'
are way too generic for an MSM specific DRM driver, so I'm renaming
them all to msm_hdmi_* here.

I also rename a lot of the 'static' symbols along with the global
names for consistency, even though those are relatively harmless;
they might only be slightly confusing when they show up in
backtraces.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c           |  98 +++++++++---------
 drivers/gpu/drm/msm/hdmi/hdmi.h           |  60 +++++------
 drivers/gpu/drm/msm/hdmi/hdmi_audio.c     |  10 +-
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c    |  56 +++++-----
 drivers/gpu/drm/msm/hdmi/hdmi_connector.c |  34 +++---
 drivers/gpu/drm/msm/hdmi/hdmi_hdcp.c      | 166 +++++++++++++++---------------
 drivers/gpu/drm/msm/hdmi/hdmi_i2c.c       |  20 ++--
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c       |  56 +++++-----
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.c  |   2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c  |   4 +-
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8x60.c  |   2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8x74.c  |   2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.c  |   2 +-
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.c   |   2 +-
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c   |   2 +-
 drivers/gpu/drm/msm/msm_drv.c             |   4 +-
 drivers/gpu/drm/msm/msm_drv.h             |  12 +--
 17 files changed, 266 insertions(+), 266 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 6002988951b4..3bcfb1ded8b3 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -21,7 +21,7 @@
 
 #include "hdmi.h"
 
-void hdmi_set_mode(struct hdmi *hdmi, bool power_on)
+void msm_hdmi_set_mode(struct hdmi *hdmi, bool power_on)
 {
 	uint32_t ctrl = 0;
 	unsigned long flags;
@@ -46,26 +46,26 @@ void hdmi_set_mode(struct hdmi *hdmi, bool power_on)
 			power_on ? "Enable" : "Disable", ctrl);
 }
 
-static irqreturn_t hdmi_irq(int irq, void *dev_id)
+static irqreturn_t msm_hdmi_irq(int irq, void *dev_id)
 {
 	struct hdmi *hdmi = dev_id;
 
 	/* Process HPD: */
-	hdmi_connector_irq(hdmi->connector);
+	msm_hdmi_connector_irq(hdmi->connector);
 
 	/* Process DDC: */
-	hdmi_i2c_irq(hdmi->i2c);
+	msm_hdmi_i2c_irq(hdmi->i2c);
 
 	/* Process HDCP: */
 	if (hdmi->hdcp_ctrl)
-		hdmi_hdcp_irq(hdmi->hdcp_ctrl);
+		msm_hdmi_hdcp_irq(hdmi->hdcp_ctrl);
 
 	/* TODO audio.. */
 
 	return IRQ_HANDLED;
 }
 
-static void hdmi_destroy(struct hdmi *hdmi)
+static void msm_hdmi_destroy(struct hdmi *hdmi)
 {
 	/*
 	 * at this point, hpd has been disabled,
@@ -75,7 +75,7 @@ static void hdmi_destroy(struct hdmi *hdmi)
 		flush_workqueue(hdmi->workq);
 		destroy_workqueue(hdmi->workq);
 	}
-	hdmi_hdcp_destroy(hdmi);
+	msm_hdmi_hdcp_destroy(hdmi);
 
 	if (hdmi->phy_dev) {
 		put_device(hdmi->phy_dev);
@@ -84,12 +84,12 @@ static void hdmi_destroy(struct hdmi *hdmi)
 	}
 
 	if (hdmi->i2c)
-		hdmi_i2c_destroy(hdmi->i2c);
+		msm_hdmi_i2c_destroy(hdmi->i2c);
 
 	platform_set_drvdata(hdmi->pdev, NULL);
 }
 
-static int hdmi_get_phy(struct hdmi *hdmi)
+static int msm_hdmi_get_phy(struct hdmi *hdmi)
 {
 	struct platform_device *pdev = hdmi->pdev;
 	struct platform_device *phy_pdev;
@@ -121,7 +121,7 @@ static int hdmi_get_phy(struct hdmi *hdmi)
  * we are to EPROBE_DEFER we want to do it here, rather than later
  * at modeset_init() time
  */
-static struct hdmi *hdmi_init(struct platform_device *pdev)
+static struct hdmi *msm_hdmi_init(struct platform_device *pdev)
 {
 	struct hdmi_platform_config *config = pdev->dev.platform_data;
 	struct hdmi *hdmi = NULL;
@@ -240,7 +240,7 @@ static struct hdmi *hdmi_init(struct platform_device *pdev)
 
 	hdmi->workq = alloc_ordered_workqueue("msm_hdmi", 0);
 
-	hdmi->i2c = hdmi_i2c_init(hdmi);
+	hdmi->i2c = msm_hdmi_i2c_init(hdmi);
 	if (IS_ERR(hdmi->i2c)) {
 		ret = PTR_ERR(hdmi->i2c);
 		dev_err(&pdev->dev, "failed to get i2c: %d\n", ret);
@@ -248,13 +248,13 @@ static struct hdmi *hdmi_init(struct platform_device *pdev)
 		goto fail;
 	}
 
-	ret = hdmi_get_phy(hdmi);
+	ret = msm_hdmi_get_phy(hdmi);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to get phy\n");
 		goto fail;
 	}
 
-	hdmi->hdcp_ctrl = hdmi_hdcp_init(hdmi);
+	hdmi->hdcp_ctrl = msm_hdmi_hdcp_init(hdmi);
 	if (IS_ERR(hdmi->hdcp_ctrl)) {
 		dev_warn(&pdev->dev, "failed to init hdcp: disabled\n");
 		hdmi->hdcp_ctrl = NULL;
@@ -264,7 +264,7 @@ static struct hdmi *hdmi_init(struct platform_device *pdev)
 
 fail:
 	if (hdmi)
-		hdmi_destroy(hdmi);
+		msm_hdmi_destroy(hdmi);
 
 	return ERR_PTR(ret);
 }
@@ -274,10 +274,10 @@ fail:
  * driver (not hdmi sub-device's probe/bind!)
  *
  * Any resource (regulator/clk/etc) which could be missing at boot
- * should be handled in hdmi_init() so that failure happens from
+ * should be handled in msm_hdmi_init() so that failure happens from
  * hdmi sub-device's probe.
  */
-int hdmi_modeset_init(struct hdmi *hdmi,
+int msm_hdmi_modeset_init(struct hdmi *hdmi,
 		struct drm_device *dev, struct drm_encoder *encoder)
 {
 	struct msm_drm_private *priv = dev->dev_private;
@@ -289,7 +289,7 @@ int hdmi_modeset_init(struct hdmi *hdmi,
 
 	hdmi_audio_infoframe_init(&hdmi->audio.infoframe);
 
-	hdmi->bridge = hdmi_bridge_init(hdmi);
+	hdmi->bridge = msm_hdmi_bridge_init(hdmi);
 	if (IS_ERR(hdmi->bridge)) {
 		ret = PTR_ERR(hdmi->bridge);
 		dev_err(dev->dev, "failed to create HDMI bridge: %d\n", ret);
@@ -297,7 +297,7 @@ int hdmi_modeset_init(struct hdmi *hdmi,
 		goto fail;
 	}
 
-	hdmi->connector = hdmi_connector_init(hdmi);
+	hdmi->connector = msm_hdmi_connector_init(hdmi);
 	if (IS_ERR(hdmi->connector)) {
 		ret = PTR_ERR(hdmi->connector);
 		dev_err(dev->dev, "failed to create HDMI connector: %d\n", ret);
@@ -313,7 +313,7 @@ int hdmi_modeset_init(struct hdmi *hdmi,
 	}
 
 	ret = devm_request_irq(&pdev->dev, hdmi->irq,
-			hdmi_irq, IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+			msm_hdmi_irq, IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
 			"hdmi_isr", hdmi);
 	if (ret < 0) {
 		dev_err(dev->dev, "failed to request IRQ%u: %d\n",
@@ -333,7 +333,7 @@ int hdmi_modeset_init(struct hdmi *hdmi,
 fail:
 	/* bridge is normally destroyed by drm: */
 	if (hdmi->bridge) {
-		hdmi_bridge_destroy(hdmi->bridge);
+		msm_hdmi_bridge_destroy(hdmi->bridge);
 		hdmi->bridge = NULL;
 	}
 	if (hdmi->connector) {
@@ -410,7 +410,7 @@ static const struct {
 	const bool output;
 	const int value;
 	const char *label;
-} hdmi_gpio_pdata[] = {
+} msm_hdmi_gpio_pdata[] = {
 	{ "qcom,hdmi-tx-ddc-clk", true, 1, "HDMI_DDC_CLK" },
 	{ "qcom,hdmi-tx-ddc-data", true, 1, "HDMI_DDC_DATA" },
 	{ "qcom,hdmi-tx-hpd", false, 1, "HDMI_HPD" },
@@ -419,7 +419,7 @@ static const struct {
 	{ "qcom,hdmi-tx-mux-lpm", true, 1, "HDMI_MUX_LPM" },
 };
 
-static int get_gpio(struct device_node *of_node, const char *name)
+static int msm_hdmi_get_gpio(struct device_node *of_node, const char *name)
 {
 	int gpio = of_get_named_gpio(of_node, name, 0);
 	if (gpio < 0) {
@@ -434,7 +434,7 @@ static int get_gpio(struct device_node *of_node, const char *name)
 	return gpio;
 }
 
-static int hdmi_bind(struct device *dev, struct device *master, void *data)
+static int msm_hdmi_bind(struct device *dev, struct device *master, void *data)
 {
 	struct drm_device *drm = dev_get_drvdata(master);
 	struct msm_drm_private *priv = drm->dev_private;
@@ -454,16 +454,16 @@ static int hdmi_bind(struct device *dev, struct device *master, void *data)
 	hdmi_cfg->qfprom_mmio_name = "qfprom_physical";
 
 	for (i = 0; i < HDMI_MAX_NUM_GPIO; i++) {
-		hdmi_cfg->gpios[i].num = get_gpio(of_node,
-						hdmi_gpio_pdata[i].name);
-		hdmi_cfg->gpios[i].output = hdmi_gpio_pdata[i].output;
-		hdmi_cfg->gpios[i].value = hdmi_gpio_pdata[i].value;
-		hdmi_cfg->gpios[i].label = hdmi_gpio_pdata[i].label;
+		hdmi_cfg->gpios[i].num = msm_hdmi_get_gpio(of_node,
+						msm_hdmi_gpio_pdata[i].name);
+		hdmi_cfg->gpios[i].output = msm_hdmi_gpio_pdata[i].output;
+		hdmi_cfg->gpios[i].value = msm_hdmi_gpio_pdata[i].value;
+		hdmi_cfg->gpios[i].label = msm_hdmi_gpio_pdata[i].label;
 	}
 
 	dev->platform_data = hdmi_cfg;
 
-	hdmi = hdmi_init(to_platform_device(dev));
+	hdmi = msm_hdmi_init(to_platform_device(dev));
 	if (IS_ERR(hdmi))
 		return PTR_ERR(hdmi);
 	priv->hdmi = hdmi;
@@ -471,34 +471,34 @@ static int hdmi_bind(struct device *dev, struct device *master, void *data)
 	return 0;
 }
 
-static void hdmi_unbind(struct device *dev, struct device *master,
+static void msm_hdmi_unbind(struct device *dev, struct device *master,
 		void *data)
 {
 	struct drm_device *drm = dev_get_drvdata(master);
 	struct msm_drm_private *priv = drm->dev_private;
 	if (priv->hdmi) {
-		hdmi_destroy(priv->hdmi);
+		msm_hdmi_destroy(priv->hdmi);
 		priv->hdmi = NULL;
 	}
 }
 
-static const struct component_ops hdmi_ops = {
-		.bind   = hdmi_bind,
-		.unbind = hdmi_unbind,
+static const struct component_ops msm_hdmi_ops = {
+		.bind   = msm_hdmi_bind,
+		.unbind = msm_hdmi_unbind,
 };
 
-static int hdmi_dev_probe(struct platform_device *pdev)
+static int msm_hdmi_dev_probe(struct platform_device *pdev)
 {
-	return component_add(&pdev->dev, &hdmi_ops);
+	return component_add(&pdev->dev, &msm_hdmi_ops);
 }
 
-static int hdmi_dev_remove(struct platform_device *pdev)
+static int msm_hdmi_dev_remove(struct platform_device *pdev)
 {
-	component_del(&pdev->dev, &hdmi_ops);
+	component_del(&pdev->dev, &msm_hdmi_ops);
 	return 0;
 }
 
-static const struct of_device_id dt_match[] = {
+static const struct of_device_id msm_hdmi_dt_match[] = {
 	{ .compatible = "qcom,hdmi-tx-8996", .data = &hdmi_tx_8996_config },
 	{ .compatible = "qcom,hdmi-tx-8994", .data = &hdmi_tx_8994_config },
 	{ .compatible = "qcom,hdmi-tx-8084", .data = &hdmi_tx_8084_config },
@@ -508,23 +508,23 @@ static const struct of_device_id dt_match[] = {
 	{}
 };
 
-static struct platform_driver hdmi_driver = {
-	.probe = hdmi_dev_probe,
-	.remove = hdmi_dev_remove,
+static struct platform_driver msm_hdmi_driver = {
+	.probe = msm_hdmi_dev_probe,
+	.remove = msm_hdmi_dev_remove,
 	.driver = {
 		.name = "hdmi_msm",
-		.of_match_table = dt_match,
+		.of_match_table = msm_hdmi_dt_match,
 	},
 };
 
-void __init hdmi_register(void)
+void __init msm_hdmi_register(void)
 {
-	hdmi_phy_driver_register();
-	platform_driver_register(&hdmi_driver);
+	msm_hdmi_phy_driver_register();
+	platform_driver_register(&msm_hdmi_driver);
 }
 
-void __exit hdmi_unregister(void)
+void __exit msm_hdmi_unregister(void)
 {
-	platform_driver_unregister(&hdmi_driver);
-	hdmi_phy_driver_unregister();
+	platform_driver_unregister(&msm_hdmi_driver);
+	msm_hdmi_phy_driver_unregister();
 }
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index 88557e59f750..b04a64664673 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -122,7 +122,7 @@ struct hdmi_platform_config {
 	struct hdmi_gpio_data gpios[HDMI_MAX_NUM_GPIO];
 };
 
-void hdmi_set_mode(struct hdmi *hdmi, bool power_on);
+void msm_hdmi_set_mode(struct hdmi *hdmi, bool power_on);
 
 static inline void hdmi_write(struct hdmi *hdmi, u32 reg, u32 data)
 {
@@ -161,10 +161,10 @@ struct hdmi_phy_cfg {
 	int num_clks;
 };
 
-extern const struct hdmi_phy_cfg hdmi_phy_8x60_cfg;
-extern const struct hdmi_phy_cfg hdmi_phy_8960_cfg;
-extern const struct hdmi_phy_cfg hdmi_phy_8x74_cfg;
-extern const struct hdmi_phy_cfg hdmi_phy_8996_cfg;
+extern const struct hdmi_phy_cfg msm_hdmi_phy_8x60_cfg;
+extern const struct hdmi_phy_cfg msm_hdmi_phy_8960_cfg;
+extern const struct hdmi_phy_cfg msm_hdmi_phy_8x74_cfg;
+extern const struct hdmi_phy_cfg msm_hdmi_phy_8996_cfg;
 
 struct hdmi_phy {
 	struct platform_device *pdev;
@@ -185,23 +185,23 @@ static inline u32 hdmi_phy_read(struct hdmi_phy *phy, u32 reg)
 	return msm_readl(phy->mmio + reg);
 }
 
-int hdmi_phy_resource_enable(struct hdmi_phy *phy);
-void hdmi_phy_resource_disable(struct hdmi_phy *phy);
-void hdmi_phy_powerup(struct hdmi_phy *phy, unsigned long int pixclock);
-void hdmi_phy_powerdown(struct hdmi_phy *phy);
-void __init hdmi_phy_driver_register(void);
-void __exit hdmi_phy_driver_unregister(void);
+int msm_hdmi_phy_resource_enable(struct hdmi_phy *phy);
+void msm_hdmi_phy_resource_disable(struct hdmi_phy *phy);
+void msm_hdmi_phy_powerup(struct hdmi_phy *phy, unsigned long int pixclock);
+void msm_hdmi_phy_powerdown(struct hdmi_phy *phy);
+void __init msm_hdmi_phy_driver_register(void);
+void __exit msm_hdmi_phy_driver_unregister(void);
 
 #ifdef CONFIG_COMMON_CLK
-int hdmi_pll_8960_init(struct platform_device *pdev);
-int hdmi_pll_8996_init(struct platform_device *pdev);
+int msm_hdmi_pll_8960_init(struct platform_device *pdev);
+int msm_hdmi_pll_8996_init(struct platform_device *pdev);
 #else
-int hdmi_pll_8960_init(struct platform_device *pdev);
+static inline int msm_hdmi_pll_8960_init(struct platform_device *pdev);
 {
 	return -ENODEV;
 }
 
-int hdmi_pll_8996_init(struct platform_device *pdev)
+static inline int msm_hdmi_pll_8996_init(struct platform_device *pdev)
 {
 	return -ENODEV;
 }
@@ -211,42 +211,42 @@ int hdmi_pll_8996_init(struct platform_device *pdev)
  * audio:
  */
 
-int hdmi_audio_update(struct hdmi *hdmi);
-int hdmi_audio_info_setup(struct hdmi *hdmi, bool enabled,
+int msm_hdmi_audio_update(struct hdmi *hdmi);
+int msm_hdmi_audio_info_setup(struct hdmi *hdmi, bool enabled,
 	uint32_t num_of_channels, uint32_t channel_allocation,
 	uint32_t level_shift, bool down_mix);
-void hdmi_audio_set_sample_rate(struct hdmi *hdmi, int rate);
+void msm_hdmi_audio_set_sample_rate(struct hdmi *hdmi, int rate);
 
 
 /*
  * hdmi bridge:
  */
 
-struct drm_bridge *hdmi_bridge_init(struct hdmi *hdmi);
-void hdmi_bridge_destroy(struct drm_bridge *bridge);
+struct drm_bridge *msm_hdmi_bridge_init(struct hdmi *hdmi);
+void msm_hdmi_bridge_destroy(struct drm_bridge *bridge);
 
 /*
  * hdmi connector:
  */
 
-void hdmi_connector_irq(struct drm_connector *connector);
-struct drm_connector *hdmi_connector_init(struct hdmi *hdmi);
+void msm_hdmi_connector_irq(struct drm_connector *connector);
+struct drm_connector *msm_hdmi_connector_init(struct hdmi *hdmi);
 
 /*
  * i2c adapter for ddc:
  */
 
-void hdmi_i2c_irq(struct i2c_adapter *i2c);
-void hdmi_i2c_destroy(struct i2c_adapter *i2c);
-struct i2c_adapter *hdmi_i2c_init(struct hdmi *hdmi);
+void msm_hdmi_i2c_irq(struct i2c_adapter *i2c);
+void msm_hdmi_i2c_destroy(struct i2c_adapter *i2c);
+struct i2c_adapter *msm_hdmi_i2c_init(struct hdmi *hdmi);
 
 /*
  * hdcp
  */
-struct hdmi_hdcp_ctrl *hdmi_hdcp_init(struct hdmi *hdmi);
-void hdmi_hdcp_destroy(struct hdmi *hdmi);
-void hdmi_hdcp_on(struct hdmi_hdcp_ctrl *hdcp_ctrl);
-void hdmi_hdcp_off(struct hdmi_hdcp_ctrl *hdcp_ctrl);
-void hdmi_hdcp_irq(struct hdmi_hdcp_ctrl *hdcp_ctrl);
+struct hdmi_hdcp_ctrl *msm_hdmi_hdcp_init(struct hdmi *hdmi);
+void msm_hdmi_hdcp_destroy(struct hdmi *hdmi);
+void msm_hdmi_hdcp_on(struct hdmi_hdcp_ctrl *hdcp_ctrl);
+void msm_hdmi_hdcp_off(struct hdmi_hdcp_ctrl *hdcp_ctrl);
+void msm_hdmi_hdcp_irq(struct hdmi_hdcp_ctrl *hdcp_ctrl);
 
 #endif /* __HDMI_CONNECTOR_H__ */
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_audio.c b/drivers/gpu/drm/msm/hdmi/hdmi_audio.c
index df232e20c13e..a54d3bb5baad 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_audio.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_audio.c
@@ -89,7 +89,7 @@ static const struct hdmi_msm_audio_arcs *get_arcs(unsigned long int pixclock)
 	return NULL;
 }
 
-int hdmi_audio_update(struct hdmi *hdmi)
+int msm_hdmi_audio_update(struct hdmi *hdmi)
 {
 	struct hdmi_audio *audio = &hdmi->audio;
 	struct hdmi_audio_infoframe *info = &audio->infoframe;
@@ -232,7 +232,7 @@ int hdmi_audio_update(struct hdmi *hdmi)
 	return 0;
 }
 
-int hdmi_audio_info_setup(struct hdmi *hdmi, bool enabled,
+int msm_hdmi_audio_info_setup(struct hdmi *hdmi, bool enabled,
 	uint32_t num_of_channels, uint32_t channel_allocation,
 	uint32_t level_shift, bool down_mix)
 {
@@ -252,10 +252,10 @@ int hdmi_audio_info_setup(struct hdmi *hdmi, bool enabled,
 	audio->infoframe.level_shift_value = level_shift;
 	audio->infoframe.downmix_inhibit = down_mix;
 
-	return hdmi_audio_update(hdmi);
+	return msm_hdmi_audio_update(hdmi);
 }
 
-void hdmi_audio_set_sample_rate(struct hdmi *hdmi, int rate)
+void msm_hdmi_audio_set_sample_rate(struct hdmi *hdmi, int rate)
 {
 	struct hdmi_audio *audio;
 
@@ -268,5 +268,5 @@ void hdmi_audio_set_sample_rate(struct hdmi *hdmi, int rate)
 		return;
 
 	audio->rate = rate;
-	hdmi_audio_update(hdmi);
+	msm_hdmi_audio_update(hdmi);
 }
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 310d92d06229..bacbd5d8df0e 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -23,11 +23,11 @@ struct hdmi_bridge {
 };
 #define to_hdmi_bridge(x) container_of(x, struct hdmi_bridge, base)
 
-void hdmi_bridge_destroy(struct drm_bridge *bridge)
+void msm_hdmi_bridge_destroy(struct drm_bridge *bridge)
 {
 }
 
-static void power_on(struct drm_bridge *bridge)
+static void msm_hdmi_power_on(struct drm_bridge *bridge)
 {
 	struct drm_device *dev = bridge->dev;
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
@@ -86,7 +86,7 @@ static void power_off(struct drm_bridge *bridge)
 	}
 }
 
-static void hdmi_bridge_pre_enable(struct drm_bridge *bridge)
+static void msm_hdmi_bridge_pre_enable(struct drm_bridge *bridge)
 {
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
@@ -95,51 +95,51 @@ static void hdmi_bridge_pre_enable(struct drm_bridge *bridge)
 	DBG("power up");
 
 	if (!hdmi->power_on) {
-		hdmi_phy_resource_enable(phy);
-		power_on(bridge);
+		msm_hdmi_phy_resource_enable(phy);
+		msm_hdmi_power_on(bridge);
 		hdmi->power_on = true;
-		hdmi_audio_update(hdmi);
+		msm_hdmi_audio_update(hdmi);
 	}
 
-	hdmi_phy_powerup(phy, hdmi->pixclock);
+	msm_hdmi_phy_powerup(phy, hdmi->pixclock);
 
-	hdmi_set_mode(hdmi, true);
+	msm_hdmi_set_mode(hdmi, true);
 
 	if (hdmi->hdcp_ctrl)
-		hdmi_hdcp_on(hdmi->hdcp_ctrl);
+		msm_hdmi_hdcp_on(hdmi->hdcp_ctrl);
 }
 
-static void hdmi_bridge_enable(struct drm_bridge *bridge)
+static void msm_hdmi_bridge_enable(struct drm_bridge *bridge)
 {
 }
 
-static void hdmi_bridge_disable(struct drm_bridge *bridge)
+static void msm_hdmi_bridge_disable(struct drm_bridge *bridge)
 {
 }
 
-static void hdmi_bridge_post_disable(struct drm_bridge *bridge)
+static void msm_hdmi_bridge_post_disable(struct drm_bridge *bridge)
 {
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
 	struct hdmi_phy *phy = hdmi->phy;
 
 	if (hdmi->hdcp_ctrl)
-		hdmi_hdcp_off(hdmi->hdcp_ctrl);
+		msm_hdmi_hdcp_off(hdmi->hdcp_ctrl);
 
 	DBG("power down");
-	hdmi_set_mode(hdmi, false);
+	msm_hdmi_set_mode(hdmi, false);
 
-	hdmi_phy_powerdown(phy);
+	msm_hdmi_phy_powerdown(phy);
 
 	if (hdmi->power_on) {
 		power_off(bridge);
 		hdmi->power_on = false;
-		hdmi_audio_update(hdmi);
-		hdmi_phy_resource_disable(phy);
+		msm_hdmi_audio_update(hdmi);
+		msm_hdmi_phy_resource_disable(phy);
 	}
 }
 
-static void hdmi_bridge_mode_set(struct drm_bridge *bridge,
+static void msm_hdmi_bridge_mode_set(struct drm_bridge *bridge,
 		 struct drm_display_mode *mode,
 		 struct drm_display_mode *adjusted_mode)
 {
@@ -196,20 +196,20 @@ static void hdmi_bridge_mode_set(struct drm_bridge *bridge,
 	DBG("frame_ctrl=%08x", frame_ctrl);
 	hdmi_write(hdmi, REG_HDMI_FRAME_CTRL, frame_ctrl);
 
-	hdmi_audio_update(hdmi);
+	msm_hdmi_audio_update(hdmi);
 }
 
-static const struct drm_bridge_funcs hdmi_bridge_funcs = {
-		.pre_enable = hdmi_bridge_pre_enable,
-		.enable = hdmi_bridge_enable,
-		.disable = hdmi_bridge_disable,
-		.post_disable = hdmi_bridge_post_disable,
-		.mode_set = hdmi_bridge_mode_set,
+static const struct drm_bridge_funcs msm_hdmi_bridge_funcs = {
+		.pre_enable = msm_hdmi_bridge_pre_enable,
+		.enable = msm_hdmi_bridge_enable,
+		.disable = msm_hdmi_bridge_disable,
+		.post_disable = msm_hdmi_bridge_post_disable,
+		.mode_set = msm_hdmi_bridge_mode_set,
 };
 
 
 /* initialize bridge */
-struct drm_bridge *hdmi_bridge_init(struct hdmi *hdmi)
+struct drm_bridge *msm_hdmi_bridge_init(struct hdmi *hdmi)
 {
 	struct drm_bridge *bridge = NULL;
 	struct hdmi_bridge *hdmi_bridge;
@@ -225,7 +225,7 @@ struct drm_bridge *hdmi_bridge_init(struct hdmi *hdmi)
 	hdmi_bridge->hdmi = hdmi;
 
 	bridge = &hdmi_bridge->base;
-	bridge->funcs = &hdmi_bridge_funcs;
+	bridge->funcs = &msm_hdmi_bridge_funcs;
 
 	ret = drm_bridge_attach(hdmi->dev, bridge);
 	if (ret)
@@ -235,7 +235,7 @@ struct drm_bridge *hdmi_bridge_init(struct hdmi *hdmi)
 
 fail:
 	if (bridge)
-		hdmi_bridge_destroy(bridge);
+		msm_hdmi_bridge_destroy(bridge);
 
 	return ERR_PTR(ret);
 }
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_connector.c b/drivers/gpu/drm/msm/hdmi/hdmi_connector.c
index 3973d4644679..26129bff2dd6 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_connector.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_connector.c
@@ -28,7 +28,7 @@ struct hdmi_connector {
 };
 #define to_hdmi_connector(x) container_of(x, struct hdmi_connector, base)
 
-static void hdmi_phy_reset(struct hdmi *hdmi)
+static void msm_hdmi_phy_reset(struct hdmi *hdmi)
 {
 	unsigned int val;
 
@@ -179,9 +179,9 @@ static int hpd_enable(struct hdmi_connector *hdmi_connector)
 		}
 	}
 
-	hdmi_set_mode(hdmi, false);
-	hdmi_phy_reset(hdmi);
-	hdmi_set_mode(hdmi, true);
+	msm_hdmi_set_mode(hdmi, false);
+	msm_hdmi_phy_reset(hdmi);
+	msm_hdmi_set_mode(hdmi, true);
 
 	hdmi_write(hdmi, REG_HDMI_USEC_REFTIMER, 0x0001001b);
 
@@ -218,7 +218,7 @@ static void hdp_disable(struct hdmi_connector *hdmi_connector)
 	/* Disable HPD interrupt */
 	hdmi_write(hdmi, REG_HDMI_HPD_INT_CTRL, 0);
 
-	hdmi_set_mode(hdmi, false);
+	msm_hdmi_set_mode(hdmi, false);
 
 	for (i = 0; i < config->hpd_clk_cnt; i++)
 		clk_disable_unprepare(hdmi->hpd_clks[i]);
@@ -240,7 +240,7 @@ static void hdp_disable(struct hdmi_connector *hdmi_connector)
 }
 
 static void
-hotplug_work(struct work_struct *work)
+msm_hdmi_hotplug_work(struct work_struct *work)
 {
 	struct hdmi_connector *hdmi_connector =
 		container_of(work, struct hdmi_connector, hpd_work);
@@ -248,7 +248,7 @@ hotplug_work(struct work_struct *work)
 	drm_helper_hpd_irq_event(connector->dev);
 }
 
-void hdmi_connector_irq(struct drm_connector *connector)
+void msm_hdmi_connector_irq(struct drm_connector *connector)
 {
 	struct hdmi_connector *hdmi_connector = to_hdmi_connector(connector);
 	struct hdmi *hdmi = hdmi_connector->hdmi;
@@ -347,7 +347,7 @@ static void hdmi_connector_destroy(struct drm_connector *connector)
 	kfree(hdmi_connector);
 }
 
-static int hdmi_connector_get_modes(struct drm_connector *connector)
+static int msm_hdmi_connector_get_modes(struct drm_connector *connector)
 {
 	struct hdmi_connector *hdmi_connector = to_hdmi_connector(connector);
 	struct hdmi *hdmi = hdmi_connector->hdmi;
@@ -373,7 +373,7 @@ static int hdmi_connector_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
-static int hdmi_connector_mode_valid(struct drm_connector *connector,
+static int msm_hdmi_connector_mode_valid(struct drm_connector *connector,
 				 struct drm_display_mode *mode)
 {
 	struct hdmi_connector *hdmi_connector = to_hdmi_connector(connector);
@@ -403,7 +403,7 @@ static int hdmi_connector_mode_valid(struct drm_connector *connector,
 }
 
 static struct drm_encoder *
-hdmi_connector_best_encoder(struct drm_connector *connector)
+msm_hdmi_connector_best_encoder(struct drm_connector *connector)
 {
 	struct hdmi_connector *hdmi_connector = to_hdmi_connector(connector);
 	return hdmi_connector->hdmi->encoder;
@@ -419,14 +419,14 @@ static const struct drm_connector_funcs hdmi_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
-static const struct drm_connector_helper_funcs hdmi_connector_helper_funcs = {
-	.get_modes = hdmi_connector_get_modes,
-	.mode_valid = hdmi_connector_mode_valid,
-	.best_encoder = hdmi_connector_best_encoder,
+static const struct drm_connector_helper_funcs msm_hdmi_connector_helper_funcs = {
+	.get_modes = msm_hdmi_connector_get_modes,
+	.mode_valid = msm_hdmi_connector_mode_valid,
+	.best_encoder = msm_hdmi_connector_best_encoder,
 };
 
 /* initialize connector */
-struct drm_connector *hdmi_connector_init(struct hdmi *hdmi)
+struct drm_connector *msm_hdmi_connector_init(struct hdmi *hdmi)
 {
 	struct drm_connector *connector = NULL;
 	struct hdmi_connector *hdmi_connector;
@@ -439,13 +439,13 @@ struct drm_connector *hdmi_connector_init(struct hdmi *hdmi)
 	}
 
 	hdmi_connector->hdmi = hdmi;
-	INIT_WORK(&hdmi_connector->hpd_work, hotplug_work);
+	INIT_WORK(&hdmi_connector->hpd_work, msm_hdmi_hotplug_work);
 
 	connector = &hdmi_connector->base;
 
 	drm_connector_init(hdmi->dev, connector, &hdmi_connector_funcs,
 			DRM_MODE_CONNECTOR_HDMIA);
-	drm_connector_helper_add(connector, &hdmi_connector_helper_funcs);
+	drm_connector_helper_add(connector, &msm_hdmi_connector_helper_funcs);
 
 	connector->polled = DRM_CONNECTOR_POLL_CONNECT |
 			DRM_CONNECTOR_POLL_DISCONNECT;
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_hdcp.c b/drivers/gpu/drm/msm/hdmi/hdmi_hdcp.c
index 1dc9c34eb0df..0baaaaabd002 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_hdcp.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_hdcp.c
@@ -84,7 +84,7 @@ struct hdmi_hdcp_ctrl {
 	bool max_dev_exceeded;
 };
 
-static int hdmi_ddc_read(struct hdmi *hdmi, u16 addr, u8 offset,
+static int msm_hdmi_ddc_read(struct hdmi *hdmi, u16 addr, u8 offset,
 	u8 *data, u16 data_len)
 {
 	int rc;
@@ -122,7 +122,7 @@ retry:
 
 #define HDCP_DDC_WRITE_MAX_BYTE_NUM 32
 
-static int hdmi_ddc_write(struct hdmi *hdmi, u16 addr, u8 offset,
+static int msm_hdmi_ddc_write(struct hdmi *hdmi, u16 addr, u8 offset,
 	u8 *data, u16 data_len)
 {
 	int rc;
@@ -162,7 +162,7 @@ retry:
 	return rc;
 }
 
-static int hdmi_hdcp_scm_wr(struct hdmi_hdcp_ctrl *hdcp_ctrl, u32 *preg,
+static int msm_hdmi_hdcp_scm_wr(struct hdmi_hdcp_ctrl *hdcp_ctrl, u32 *preg,
 	u32 *pdata, u32 count)
 {
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
@@ -202,7 +202,7 @@ static int hdmi_hdcp_scm_wr(struct hdmi_hdcp_ctrl *hdcp_ctrl, u32 *preg,
 	return ret;
 }
 
-void hdmi_hdcp_irq(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+void msm_hdmi_hdcp_irq(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
 	u32 reg_val, hdcp_int_status;
@@ -247,7 +247,7 @@ void hdmi_hdcp_irq(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	}
 }
 
-static int hdmi_hdcp_msleep(struct hdmi_hdcp_ctrl *hdcp_ctrl, u32 ms, u32 ev)
+static int msm_hdmi_hdcp_msleep(struct hdmi_hdcp_ctrl *hdcp_ctrl, u32 ms, u32 ev)
 {
 	int rc;
 
@@ -264,7 +264,7 @@ static int hdmi_hdcp_msleep(struct hdmi_hdcp_ctrl *hdcp_ctrl, u32 ms, u32 ev)
 	return 0;
 }
 
-static int hdmi_hdcp_read_validate_aksv(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+static int msm_hdmi_hdcp_read_validate_aksv(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
 
@@ -287,7 +287,7 @@ static int hdmi_hdcp_read_validate_aksv(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	return 0;
 }
 
-static int reset_hdcp_ddc_failures(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+static int msm_reset_hdcp_ddc_failures(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
 	u32 reg_val, failure, nack0;
@@ -337,7 +337,7 @@ static int reset_hdcp_ddc_failures(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 		reg_val |= HDMI_DDC_CTRL_SW_STATUS_RESET;
 		hdmi_write(hdmi, REG_HDMI_DDC_CTRL, reg_val);
 
-		rc = hdmi_hdcp_msleep(hdcp_ctrl, 20, AUTH_ABORT_EV);
+		rc = msm_hdmi_hdcp_msleep(hdcp_ctrl, 20, AUTH_ABORT_EV);
 
 		reg_val = hdmi_read(hdmi, REG_HDMI_DDC_CTRL);
 		reg_val &= ~HDMI_DDC_CTRL_SW_STATUS_RESET;
@@ -350,7 +350,7 @@ static int reset_hdcp_ddc_failures(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 
 		/* If previous msleep is aborted, skip this msleep */
 		if (!rc)
-			rc = hdmi_hdcp_msleep(hdcp_ctrl, 20, AUTH_ABORT_EV);
+			rc = msm_hdmi_hdcp_msleep(hdcp_ctrl, 20, AUTH_ABORT_EV);
 
 		reg_val = hdmi_read(hdmi, REG_HDMI_DDC_CTRL);
 		reg_val &= ~HDMI_DDC_CTRL_SOFT_RESET;
@@ -362,7 +362,7 @@ static int reset_hdcp_ddc_failures(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	return rc;
 }
 
-static int hdmi_hdcp_hw_ddc_clean(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+static int msm_hdmi_hdcp_hw_ddc_clean(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	int rc;
 	u32 hdcp_ddc_status, ddc_hw_status;
@@ -394,7 +394,7 @@ static int hdmi_hdcp_hw_ddc_clean(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 			return -ETIMEDOUT;
 		}
 
-		rc = hdmi_hdcp_msleep(hdcp_ctrl, 20, AUTH_ABORT_EV);
+		rc = msm_hdmi_hdcp_msleep(hdcp_ctrl, 20, AUTH_ABORT_EV);
 		if (rc)
 			return rc;
 	} while (1);
@@ -402,7 +402,7 @@ static int hdmi_hdcp_hw_ddc_clean(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	return 0;
 }
 
-static void hdmi_hdcp_reauth_work(struct work_struct *work)
+static void msm_hdmi_hdcp_reauth_work(struct work_struct *work)
 {
 	struct hdmi_hdcp_ctrl *hdcp_ctrl = container_of(work,
 		struct hdmi_hdcp_ctrl, hdcp_reauth_work);
@@ -430,7 +430,7 @@ static void hdmi_hdcp_reauth_work(struct work_struct *work)
 		HDMI_HDCP_RESET_LINK0_DEAUTHENTICATE);
 
 	/* Wait to be clean on DDC HW engine */
-	if (hdmi_hdcp_hw_ddc_clean(hdcp_ctrl)) {
+	if (msm_hdmi_hdcp_hw_ddc_clean(hdcp_ctrl)) {
 		pr_info("%s: reauth work aborted\n", __func__);
 		return;
 	}
@@ -461,7 +461,7 @@ static void hdmi_hdcp_reauth_work(struct work_struct *work)
 	queue_work(hdmi->workq, &hdcp_ctrl->hdcp_auth_work);
 }
 
-static int hdmi_hdcp_auth_prepare(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+static int msm_hdmi_hdcp_auth_prepare(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
 	u32 link0_status;
@@ -470,7 +470,7 @@ static int hdmi_hdcp_auth_prepare(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	int rc;
 
 	if (!hdcp_ctrl->aksv_valid) {
-		rc = hdmi_hdcp_read_validate_aksv(hdcp_ctrl);
+		rc = msm_hdmi_hdcp_read_validate_aksv(hdcp_ctrl);
 		if (rc) {
 			pr_err("%s: ASKV validation failed\n", __func__);
 			hdcp_ctrl->hdcp_state = HDCP_STATE_NO_AKSV;
@@ -538,12 +538,12 @@ static int hdmi_hdcp_auth_prepare(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 		DBG("An not ready after enabling HDCP");
 
 	/* Clear any DDC failures from previous tries before enable HDCP*/
-	rc = reset_hdcp_ddc_failures(hdcp_ctrl);
+	rc = msm_reset_hdcp_ddc_failures(hdcp_ctrl);
 
 	return rc;
 }
 
-static void hdmi_hdcp_auth_fail(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+static void msm_hdmi_hdcp_auth_fail(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
 	u32 reg_val;
@@ -561,7 +561,7 @@ static void hdmi_hdcp_auth_fail(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	queue_work(hdmi->workq, &hdcp_ctrl->hdcp_reauth_work);
 }
 
-static void hdmi_hdcp_auth_done(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+static void msm_hdmi_hdcp_auth_done(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
 	u32 reg_val;
@@ -596,7 +596,7 @@ static void hdmi_hdcp_auth_done(struct hdmi_hdcp_ctrl *hdcp_ctrl)
  * Write An and AKSV to sink
  * Read BKSV from sink and write into HDCP engine
  */
-static int hdmi_hdcp_wait_key_an_ready(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+static int msm_hdmi_hdcp_wait_key_an_ready(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	int rc;
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
@@ -621,7 +621,7 @@ static int hdmi_hdcp_wait_key_an_ready(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 			return -ETIMEDOUT;
 		}
 
-		rc = hdmi_hdcp_msleep(hdcp_ctrl, 20, AUTH_ABORT_EV);
+		rc = msm_hdmi_hdcp_msleep(hdcp_ctrl, 20, AUTH_ABORT_EV);
 		if (rc)
 			return rc;
 	} while (1);
@@ -643,7 +643,7 @@ static int hdmi_hdcp_wait_key_an_ready(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 			return -ETIMEDOUT;
 		}
 
-		rc = hdmi_hdcp_msleep(hdcp_ctrl, 20, AUTH_ABORT_EV);
+		rc = msm_hdmi_hdcp_msleep(hdcp_ctrl, 20, AUTH_ABORT_EV);
 		if (rc)
 			return rc;
 	} while (1);
@@ -651,7 +651,7 @@ static int hdmi_hdcp_wait_key_an_ready(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	return 0;
 }
 
-static int hdmi_hdcp_send_aksv_an(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+static int msm_hdmi_hdcp_send_aksv_an(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	int rc = 0;
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
@@ -676,7 +676,7 @@ static int hdmi_hdcp_send_aksv_an(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	aksv[4] =  link0_aksv_1        & 0xFF;
 
 	/* Write An to offset 0x18 */
-	rc = hdmi_ddc_write(hdmi, HDCP_PORT_ADDR, 0x18, (u8 *)link0_an,
+	rc = msm_hdmi_ddc_write(hdmi, HDCP_PORT_ADDR, 0x18, (u8 *)link0_an,
 		(u16)sizeof(link0_an));
 	if (rc) {
 		pr_err("%s:An write failed\n", __func__);
@@ -685,7 +685,7 @@ static int hdmi_hdcp_send_aksv_an(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	DBG("Link0-An=%08x%08x", link0_an[0], link0_an[1]);
 
 	/* Write AKSV to offset 0x10 */
-	rc = hdmi_ddc_write(hdmi, HDCP_PORT_ADDR, 0x10, aksv, 5);
+	rc = msm_hdmi_ddc_write(hdmi, HDCP_PORT_ADDR, 0x10, aksv, 5);
 	if (rc) {
 		pr_err("%s:AKSV write failed\n", __func__);
 		return rc;
@@ -695,7 +695,7 @@ static int hdmi_hdcp_send_aksv_an(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	return 0;
 }
 
-static int hdmi_hdcp_recv_bksv(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+static int msm_hdmi_hdcp_recv_bksv(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	int rc = 0;
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
@@ -703,7 +703,7 @@ static int hdmi_hdcp_recv_bksv(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	u32 reg[2], data[2];
 
 	/* Read BKSV at offset 0x00 */
-	rc = hdmi_ddc_read(hdmi, HDCP_PORT_ADDR, 0x00, bksv, 5);
+	rc = msm_hdmi_ddc_read(hdmi, HDCP_PORT_ADDR, 0x00, bksv, 5);
 	if (rc) {
 		pr_err("%s:BKSV read failed\n", __func__);
 		return rc;
@@ -728,19 +728,19 @@ static int hdmi_hdcp_recv_bksv(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	data[0] = hdcp_ctrl->bksv_lsb;
 	reg[1] = REG_HDMI_HDCP_RCVPORT_DATA1;
 	data[1] = hdcp_ctrl->bksv_msb;
-	rc = hdmi_hdcp_scm_wr(hdcp_ctrl, reg, data, 2);
+	rc = msm_hdmi_hdcp_scm_wr(hdcp_ctrl, reg, data, 2);
 
 	return rc;
 }
 
-static int hdmi_hdcp_recv_bcaps(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+static int msm_hdmi_hdcp_recv_bcaps(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	int rc = 0;
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
 	u32 reg, data;
 	u8 bcaps;
 
-	rc = hdmi_ddc_read(hdmi, HDCP_PORT_ADDR, 0x40, &bcaps, 1);
+	rc = msm_hdmi_ddc_read(hdmi, HDCP_PORT_ADDR, 0x40, &bcaps, 1);
 	if (rc) {
 		pr_err("%s:BCAPS read failed\n", __func__);
 		return rc;
@@ -753,26 +753,26 @@ static int hdmi_hdcp_recv_bcaps(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	/* Write BCAPS to the hardware */
 	reg = REG_HDMI_HDCP_RCVPORT_DATA12;
 	data = (u32)bcaps;
-	rc = hdmi_hdcp_scm_wr(hdcp_ctrl, &reg, &data, 1);
+	rc = msm_hdmi_hdcp_scm_wr(hdcp_ctrl, &reg, &data, 1);
 
 	return rc;
 }
 
-static int hdmi_hdcp_auth_part1_key_exchange(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+static int msm_hdmi_hdcp_auth_part1_key_exchange(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
 	unsigned long flags;
 	int rc;
 
 	/* Wait for AKSV key and An ready */
-	rc = hdmi_hdcp_wait_key_an_ready(hdcp_ctrl);
+	rc = msm_hdmi_hdcp_wait_key_an_ready(hdcp_ctrl);
 	if (rc) {
 		pr_err("%s: wait key and an ready failed\n", __func__);
 		return rc;
 	};
 
 	/* Read BCAPS and send to HDCP engine */
-	rc = hdmi_hdcp_recv_bcaps(hdcp_ctrl);
+	rc = msm_hdmi_hdcp_recv_bcaps(hdcp_ctrl);
 	if (rc) {
 		pr_err("%s: read bcaps error, abort\n", __func__);
 		return rc;
@@ -785,14 +785,14 @@ static int hdmi_hdcp_auth_part1_key_exchange(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	hdmi_write(hdmi, REG_HDMI_HDCP_RCVPORT_DATA4, 0);
 
 	/* Send AKSV and An to sink */
-	rc = hdmi_hdcp_send_aksv_an(hdcp_ctrl);
+	rc = msm_hdmi_hdcp_send_aksv_an(hdcp_ctrl);
 	if (rc) {
 		pr_err("%s:An/Aksv write failed\n", __func__);
 		return rc;
 	}
 
 	/* Read BKSV and send to HDCP engine*/
-	rc = hdmi_hdcp_recv_bksv(hdcp_ctrl);
+	rc = msm_hdmi_hdcp_recv_bksv(hdcp_ctrl);
 	if (rc) {
 		pr_err("%s:BKSV Process failed\n", __func__);
 		return rc;
@@ -812,7 +812,7 @@ static int hdmi_hdcp_auth_part1_key_exchange(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 }
 
 /* read R0' from sink and pass it to HDCP engine */
-static int hdmi_hdcp_auth_part1_recv_r0(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+static int msm_hdmi_hdcp_auth_part1_recv_r0(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
 	int rc = 0;
@@ -822,12 +822,12 @@ static int hdmi_hdcp_auth_part1_recv_r0(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	 * HDCP Compliance Test case 1A-01:
 	 * Wait here at least 100ms before reading R0'
 	 */
-	rc = hdmi_hdcp_msleep(hdcp_ctrl, 125, AUTH_ABORT_EV);
+	rc = msm_hdmi_hdcp_msleep(hdcp_ctrl, 125, AUTH_ABORT_EV);
 	if (rc)
 		return rc;
 
 	/* Read R0' at offset 0x08 */
-	rc = hdmi_ddc_read(hdmi, HDCP_PORT_ADDR, 0x08, buf, 2);
+	rc = msm_hdmi_ddc_read(hdmi, HDCP_PORT_ADDR, 0x08, buf, 2);
 	if (rc) {
 		pr_err("%s:R0' read failed\n", __func__);
 		return rc;
@@ -842,14 +842,14 @@ static int hdmi_hdcp_auth_part1_recv_r0(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 }
 
 /* Wait for authenticating result: R0/R0' are matched or not */
-static int hdmi_hdcp_auth_part1_verify_r0(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+static int msm_hdmi_hdcp_auth_part1_verify_r0(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
 	u32 link0_status;
 	int rc;
 
 	/* wait for hdcp irq, 10 sec should be long enough */
-	rc = hdmi_hdcp_msleep(hdcp_ctrl, 10000, AUTH_RESULT_RDY_EV);
+	rc = msm_hdmi_hdcp_msleep(hdcp_ctrl, 10000, AUTH_RESULT_RDY_EV);
 	if (!rc) {
 		pr_err("%s: Wait Auth IRQ timeout\n", __func__);
 		return -ETIMEDOUT;
@@ -869,7 +869,7 @@ static int hdmi_hdcp_auth_part1_verify_r0(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	return 0;
 }
 
-static int hdmi_hdcp_recv_check_bstatus(struct hdmi_hdcp_ctrl *hdcp_ctrl,
+static int msm_hdmi_hdcp_recv_check_bstatus(struct hdmi_hdcp_ctrl *hdcp_ctrl,
 	u16 *pbstatus)
 {
 	int rc;
@@ -880,7 +880,7 @@ static int hdmi_hdcp_recv_check_bstatus(struct hdmi_hdcp_ctrl *hdcp_ctrl,
 	u8 buf[2];
 
 	/* Read BSTATUS at offset 0x41 */
-	rc = hdmi_ddc_read(hdmi, HDCP_PORT_ADDR, 0x41, buf, 2);
+	rc = msm_hdmi_ddc_read(hdmi, HDCP_PORT_ADDR, 0x41, buf, 2);
 	if (rc) {
 		pr_err("%s: BSTATUS read failed\n", __func__);
 		goto error;
@@ -936,7 +936,7 @@ error:
 	return rc;
 }
 
-static int hdmi_hdcp_auth_part2_wait_ksv_fifo_ready(
+static int msm_hdmi_hdcp_auth_part2_wait_ksv_fifo_ready(
 	struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	int rc;
@@ -953,7 +953,7 @@ static int hdmi_hdcp_auth_part2_wait_ksv_fifo_ready(
 	timeout_count = 100;
 	do {
 		/* Read BCAPS at offset 0x40 */
-		rc = hdmi_ddc_read(hdmi, HDCP_PORT_ADDR, 0x40, &bcaps, 1);
+		rc = msm_hdmi_ddc_read(hdmi, HDCP_PORT_ADDR, 0x40, &bcaps, 1);
 		if (rc) {
 			pr_err("%s: BCAPS read failed\n", __func__);
 			return rc;
@@ -968,12 +968,12 @@ static int hdmi_hdcp_auth_part2_wait_ksv_fifo_ready(
 			return -ETIMEDOUT;
 		}
 
-		rc = hdmi_hdcp_msleep(hdcp_ctrl, 20, AUTH_ABORT_EV);
+		rc = msm_hdmi_hdcp_msleep(hdcp_ctrl, 20, AUTH_ABORT_EV);
 		if (rc)
 			return rc;
 	} while (1);
 
-	rc = hdmi_hdcp_recv_check_bstatus(hdcp_ctrl, &bstatus);
+	rc = msm_hdmi_hdcp_recv_check_bstatus(hdcp_ctrl, &bstatus);
 	if (rc) {
 		pr_err("%s: bstatus error\n", __func__);
 		return rc;
@@ -982,7 +982,7 @@ static int hdmi_hdcp_auth_part2_wait_ksv_fifo_ready(
 	/* Write BSTATUS and BCAPS to HDCP registers */
 	reg = REG_HDMI_HDCP_RCVPORT_DATA12;
 	data = bcaps | (bstatus << 8);
-	rc = hdmi_hdcp_scm_wr(hdcp_ctrl, &reg, &data, 1);
+	rc = msm_hdmi_hdcp_scm_wr(hdcp_ctrl, &reg, &data, 1);
 	if (rc) {
 		pr_err("%s: BSTATUS write failed\n", __func__);
 		return rc;
@@ -997,7 +997,7 @@ static int hdmi_hdcp_auth_part2_wait_ksv_fifo_ready(
  * transfer V' from sink to HDCP engine
  * reset SHA engine
  */
-static int hdmi_hdcp_transfer_v_h(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+static int msm_hdmi_hdcp_transfer_v_h(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
 	int rc = 0;
@@ -1016,7 +1016,7 @@ static int hdmi_hdcp_transfer_v_h(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 
 	for (i = 0; i < size; i++) {
 		rd = &reg_data[i];
-		rc = hdmi_ddc_read(hdmi, HDCP_PORT_ADDR,
+		rc = msm_hdmi_ddc_read(hdmi, HDCP_PORT_ADDR,
 			rd->off, (u8 *)&data[i], (u16)sizeof(data[i]));
 		if (rc) {
 			pr_err("%s: Read %s failed\n", __func__, rd->name);
@@ -1027,13 +1027,13 @@ static int hdmi_hdcp_transfer_v_h(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 		reg[i] = reg_data[i].reg_id;
 	}
 
-	rc = hdmi_hdcp_scm_wr(hdcp_ctrl, reg, data, size);
+	rc = msm_hdmi_hdcp_scm_wr(hdcp_ctrl, reg, data, size);
 
 error:
 	return rc;
 }
 
-static int hdmi_hdcp_recv_ksv_fifo(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+static int msm_hdmi_hdcp_recv_ksv_fifo(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	int rc;
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
@@ -1041,7 +1041,7 @@ static int hdmi_hdcp_recv_ksv_fifo(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 
 	ksv_bytes = 5 * hdcp_ctrl->dev_count;
 
-	rc = hdmi_ddc_read(hdmi, HDCP_PORT_ADDR, 0x43,
+	rc = msm_hdmi_ddc_read(hdmi, HDCP_PORT_ADDR, 0x43,
 		hdcp_ctrl->ksv_list, ksv_bytes);
 	if (rc)
 		pr_err("%s: KSV FIFO read failed\n", __func__);
@@ -1049,7 +1049,7 @@ static int hdmi_hdcp_recv_ksv_fifo(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	return rc;
 }
 
-static int hdmi_hdcp_reset_sha_engine(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+static int msm_hdmi_hdcp_reset_sha_engine(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	u32 reg[2], data[2];
 	u32 rc  = 0;
@@ -1059,12 +1059,12 @@ static int hdmi_hdcp_reset_sha_engine(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	reg[1] = REG_HDMI_HDCP_SHA_CTRL;
 	data[1] = HDCP_REG_DISABLE;
 
-	rc = hdmi_hdcp_scm_wr(hdcp_ctrl, reg, data, 2);
+	rc = msm_hdmi_hdcp_scm_wr(hdcp_ctrl, reg, data, 2);
 
 	return rc;
 }
 
-static int hdmi_hdcp_auth_part2_recv_ksv_fifo(
+static int msm_hdmi_hdcp_auth_part2_recv_ksv_fifo(
 	struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	int rc;
@@ -1081,7 +1081,7 @@ static int hdmi_hdcp_auth_part2_recv_ksv_fifo(
 	 */
 	timeout_count = 100;
 	do {
-		rc = hdmi_hdcp_recv_ksv_fifo(hdcp_ctrl);
+		rc = msm_hdmi_hdcp_recv_ksv_fifo(hdcp_ctrl);
 		if (!rc)
 			break;
 
@@ -1091,19 +1091,19 @@ static int hdmi_hdcp_auth_part2_recv_ksv_fifo(
 			return -ETIMEDOUT;
 		}
 
-		rc = hdmi_hdcp_msleep(hdcp_ctrl, 25, AUTH_ABORT_EV);
+		rc = msm_hdmi_hdcp_msleep(hdcp_ctrl, 25, AUTH_ABORT_EV);
 		if (rc)
 			return rc;
 	} while (1);
 
-	rc = hdmi_hdcp_transfer_v_h(hdcp_ctrl);
+	rc = msm_hdmi_hdcp_transfer_v_h(hdcp_ctrl);
 	if (rc) {
 		pr_err("%s: transfer V failed\n", __func__);
 		return rc;
 	}
 
 	/* reset SHA engine before write ksv fifo */
-	rc = hdmi_hdcp_reset_sha_engine(hdcp_ctrl);
+	rc = msm_hdmi_hdcp_reset_sha_engine(hdcp_ctrl);
 	if (rc) {
 		pr_err("%s: fail to reset sha engine\n", __func__);
 		return rc;
@@ -1120,7 +1120,7 @@ static int hdmi_hdcp_auth_part2_recv_ksv_fifo(
  * If the last byte is written, we need to poll for
  * HDCP_SHA_COMP_DONE to wait until HW finish
  */
-static int hdmi_hdcp_write_ksv_fifo(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+static int msm_hdmi_hdcp_write_ksv_fifo(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	int i;
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
@@ -1169,7 +1169,7 @@ static int hdmi_hdcp_write_ksv_fifo(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 
 		reg = REG_HDMI_HDCP_SHA_DATA;
 		data = reg_val;
-		rc = hdmi_hdcp_scm_wr(hdcp_ctrl, &reg, &data, 1);
+		rc = msm_hdmi_hdcp_scm_wr(hdcp_ctrl, &reg, &data, 1);
 
 		if (rc)
 			return rc;
@@ -1184,7 +1184,7 @@ static int hdmi_hdcp_write_ksv_fifo(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 }
 
 /* write ksv fifo into HDCP engine */
-static int hdmi_hdcp_auth_part2_write_ksv_fifo(
+static int msm_hdmi_hdcp_auth_part2_write_ksv_fifo(
 	struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	int rc;
@@ -1193,7 +1193,7 @@ static int hdmi_hdcp_auth_part2_write_ksv_fifo(
 	hdcp_ctrl->ksv_fifo_w_index = 0;
 	timeout_count = 100;
 	do {
-		rc = hdmi_hdcp_write_ksv_fifo(hdcp_ctrl);
+		rc = msm_hdmi_hdcp_write_ksv_fifo(hdcp_ctrl);
 		if (!rc)
 			break;
 
@@ -1206,7 +1206,7 @@ static int hdmi_hdcp_auth_part2_write_ksv_fifo(
 			return -ETIMEDOUT;
 		}
 
-		rc = hdmi_hdcp_msleep(hdcp_ctrl, 20, AUTH_ABORT_EV);
+		rc = msm_hdmi_hdcp_msleep(hdcp_ctrl, 20, AUTH_ABORT_EV);
 		if (rc)
 			return rc;
 	} while (1);
@@ -1214,7 +1214,7 @@ static int hdmi_hdcp_auth_part2_write_ksv_fifo(
 	return 0;
 }
 
-static int hdmi_hdcp_auth_part2_check_v_match(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+static int msm_hdmi_hdcp_auth_part2_check_v_match(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	int rc = 0;
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
@@ -1232,7 +1232,7 @@ static int hdmi_hdcp_auth_part2_check_v_match(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 				return -ETIMEDOUT;
 		}
 
-		rc = hdmi_hdcp_msleep(hdcp_ctrl, 20, AUTH_ABORT_EV);
+		rc = msm_hdmi_hdcp_msleep(hdcp_ctrl, 20, AUTH_ABORT_EV);
 		if (rc)
 			return rc;
 	} while (1);
@@ -1240,32 +1240,32 @@ static int hdmi_hdcp_auth_part2_check_v_match(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	return 0;
 }
 
-static void hdmi_hdcp_auth_work(struct work_struct *work)
+static void msm_hdmi_hdcp_auth_work(struct work_struct *work)
 {
 	struct hdmi_hdcp_ctrl *hdcp_ctrl = container_of(work,
 		struct hdmi_hdcp_ctrl, hdcp_auth_work);
 	int rc;
 
-	rc = hdmi_hdcp_auth_prepare(hdcp_ctrl);
+	rc = msm_hdmi_hdcp_auth_prepare(hdcp_ctrl);
 	if (rc) {
 		pr_err("%s: auth prepare failed %d\n", __func__, rc);
 		goto end;
 	}
 
 	/* HDCP PartI */
-	rc = hdmi_hdcp_auth_part1_key_exchange(hdcp_ctrl);
+	rc = msm_hdmi_hdcp_auth_part1_key_exchange(hdcp_ctrl);
 	if (rc) {
 		pr_err("%s: key exchange failed %d\n", __func__, rc);
 		goto end;
 	}
 
-	rc = hdmi_hdcp_auth_part1_recv_r0(hdcp_ctrl);
+	rc = msm_hdmi_hdcp_auth_part1_recv_r0(hdcp_ctrl);
 	if (rc) {
 		pr_err("%s: receive r0 failed %d\n", __func__, rc);
 		goto end;
 	}
 
-	rc = hdmi_hdcp_auth_part1_verify_r0(hdcp_ctrl);
+	rc = msm_hdmi_hdcp_auth_part1_verify_r0(hdcp_ctrl);
 	if (rc) {
 		pr_err("%s: verify r0 failed %d\n", __func__, rc);
 		goto end;
@@ -1275,25 +1275,25 @@ static void hdmi_hdcp_auth_work(struct work_struct *work)
 		goto end;
 
 	/* HDCP PartII */
-	rc = hdmi_hdcp_auth_part2_wait_ksv_fifo_ready(hdcp_ctrl);
+	rc = msm_hdmi_hdcp_auth_part2_wait_ksv_fifo_ready(hdcp_ctrl);
 	if (rc) {
 		pr_err("%s: wait ksv fifo ready failed %d\n", __func__, rc);
 		goto end;
 	}
 
-	rc = hdmi_hdcp_auth_part2_recv_ksv_fifo(hdcp_ctrl);
+	rc = msm_hdmi_hdcp_auth_part2_recv_ksv_fifo(hdcp_ctrl);
 	if (rc) {
 		pr_err("%s: recv ksv fifo failed %d\n", __func__, rc);
 		goto end;
 	}
 
-	rc = hdmi_hdcp_auth_part2_write_ksv_fifo(hdcp_ctrl);
+	rc = msm_hdmi_hdcp_auth_part2_write_ksv_fifo(hdcp_ctrl);
 	if (rc) {
 		pr_err("%s: write ksv fifo failed %d\n", __func__, rc);
 		goto end;
 	}
 
-	rc = hdmi_hdcp_auth_part2_check_v_match(hdcp_ctrl);
+	rc = msm_hdmi_hdcp_auth_part2_check_v_match(hdcp_ctrl);
 	if (rc)
 		pr_err("%s: check v match failed %d\n", __func__, rc);
 
@@ -1304,13 +1304,13 @@ end:
 		pr_info("%s: hdcp is not supported\n", __func__);
 	} else if (rc) {
 		pr_err("%s: hdcp authentication failed\n", __func__);
-		hdmi_hdcp_auth_fail(hdcp_ctrl);
+		msm_hdmi_hdcp_auth_fail(hdcp_ctrl);
 	} else {
-		hdmi_hdcp_auth_done(hdcp_ctrl);
+		msm_hdmi_hdcp_auth_done(hdcp_ctrl);
 	}
 }
 
-void hdmi_hdcp_on(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+void msm_hdmi_hdcp_on(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
 	u32 reg_val;
@@ -1335,7 +1335,7 @@ void hdmi_hdcp_on(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	queue_work(hdmi->workq, &hdcp_ctrl->hdcp_auth_work);
 }
 
-void hdmi_hdcp_off(struct hdmi_hdcp_ctrl *hdcp_ctrl)
+void msm_hdmi_hdcp_off(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 {
 	struct hdmi *hdmi = hdcp_ctrl->hdmi;
 	unsigned long flags;
@@ -1399,7 +1399,7 @@ void hdmi_hdcp_off(struct hdmi_hdcp_ctrl *hdcp_ctrl)
 	DBG("HDCP: Off");
 }
 
-struct hdmi_hdcp_ctrl *hdmi_hdcp_init(struct hdmi *hdmi)
+struct hdmi_hdcp_ctrl *msm_hdmi_hdcp_init(struct hdmi *hdmi)
 {
 	struct hdmi_hdcp_ctrl *hdcp_ctrl = NULL;
 
@@ -1413,8 +1413,8 @@ struct hdmi_hdcp_ctrl *hdmi_hdcp_init(struct hdmi *hdmi)
 	if (!hdcp_ctrl)
 		return ERR_PTR(-ENOMEM);
 
-	INIT_WORK(&hdcp_ctrl->hdcp_auth_work, hdmi_hdcp_auth_work);
-	INIT_WORK(&hdcp_ctrl->hdcp_reauth_work, hdmi_hdcp_reauth_work);
+	INIT_WORK(&hdcp_ctrl->hdcp_auth_work, msm_hdmi_hdcp_auth_work);
+	INIT_WORK(&hdcp_ctrl->hdcp_reauth_work, msm_hdmi_hdcp_reauth_work);
 	init_waitqueue_head(&hdcp_ctrl->auth_event_queue);
 	hdcp_ctrl->hdmi = hdmi;
 	hdcp_ctrl->hdcp_state = HDCP_STATE_INACTIVE;
@@ -1428,7 +1428,7 @@ struct hdmi_hdcp_ctrl *hdmi_hdcp_init(struct hdmi *hdmi)
 	return hdcp_ctrl;
 }
 
-void hdmi_hdcp_destroy(struct hdmi *hdmi)
+void msm_hdmi_hdcp_destroy(struct hdmi *hdmi)
 {
 	if (hdmi && hdmi->hdcp_ctrl) {
 		kfree(hdmi->hdcp_ctrl);
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c b/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
index f4ab7f70fed1..de9007e72f4e 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
@@ -97,7 +97,7 @@ static bool sw_done(struct hdmi_i2c_adapter *hdmi_i2c)
 	return hdmi_i2c->sw_done;
 }
 
-static int hdmi_i2c_xfer(struct i2c_adapter *i2c,
+static int msm_hdmi_i2c_xfer(struct i2c_adapter *i2c,
 		struct i2c_msg *msgs, int num)
 {
 	struct hdmi_i2c_adapter *hdmi_i2c = to_hdmi_i2c_adapter(i2c);
@@ -216,17 +216,17 @@ static int hdmi_i2c_xfer(struct i2c_adapter *i2c,
 	return i;
 }
 
-static u32 hdmi_i2c_func(struct i2c_adapter *adapter)
+static u32 msm_hdmi_i2c_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
-static const struct i2c_algorithm hdmi_i2c_algorithm = {
-	.master_xfer	= hdmi_i2c_xfer,
-	.functionality	= hdmi_i2c_func,
+static const struct i2c_algorithm msm_hdmi_i2c_algorithm = {
+	.master_xfer	= msm_hdmi_i2c_xfer,
+	.functionality	= msm_hdmi_i2c_func,
 };
 
-void hdmi_i2c_irq(struct i2c_adapter *i2c)
+void msm_hdmi_i2c_irq(struct i2c_adapter *i2c)
 {
 	struct hdmi_i2c_adapter *hdmi_i2c = to_hdmi_i2c_adapter(i2c);
 
@@ -234,14 +234,14 @@ void hdmi_i2c_irq(struct i2c_adapter *i2c)
 		wake_up_all(&hdmi_i2c->ddc_event);
 }
 
-void hdmi_i2c_destroy(struct i2c_adapter *i2c)
+void msm_hdmi_i2c_destroy(struct i2c_adapter *i2c)
 {
 	struct hdmi_i2c_adapter *hdmi_i2c = to_hdmi_i2c_adapter(i2c);
 	i2c_del_adapter(i2c);
 	kfree(hdmi_i2c);
 }
 
-struct i2c_adapter *hdmi_i2c_init(struct hdmi *hdmi)
+struct i2c_adapter *msm_hdmi_i2c_init(struct hdmi *hdmi)
 {
 	struct drm_device *dev = hdmi->dev;
 	struct hdmi_i2c_adapter *hdmi_i2c;
@@ -264,7 +264,7 @@ struct i2c_adapter *hdmi_i2c_init(struct hdmi *hdmi)
 	i2c->class = I2C_CLASS_DDC;
 	snprintf(i2c->name, sizeof(i2c->name), "msm hdmi i2c");
 	i2c->dev.parent = &hdmi->pdev->dev;
-	i2c->algo = &hdmi_i2c_algorithm;
+	i2c->algo = &msm_hdmi_i2c_algorithm;
 
 	ret = i2c_add_adapter(i2c);
 	if (ret) {
@@ -276,6 +276,6 @@ struct i2c_adapter *hdmi_i2c_init(struct hdmi *hdmi)
 
 fail:
 	if (i2c)
-		hdmi_i2c_destroy(i2c);
+		msm_hdmi_i2c_destroy(i2c);
 	return ERR_PTR(ret);
 }
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
index ce981c11c3b5..5530631e2d49 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
@@ -15,7 +15,7 @@
 
 #include "hdmi.h"
 
-static int hdmi_phy_resource_init(struct hdmi_phy *phy)
+static int msm_hdmi_phy_resource_init(struct hdmi_phy *phy)
 {
 	struct hdmi_phy_cfg *cfg = phy->cfg;
 	struct device *dev = &phy->pdev->dev;
@@ -62,7 +62,7 @@ static int hdmi_phy_resource_init(struct hdmi_phy *phy)
 	return 0;
 }
 
-int hdmi_phy_resource_enable(struct hdmi_phy *phy)
+int msm_hdmi_phy_resource_enable(struct hdmi_phy *phy)
 {
 	struct hdmi_phy_cfg *cfg = phy->cfg;
 	struct device *dev = &phy->pdev->dev;
@@ -87,7 +87,7 @@ int hdmi_phy_resource_enable(struct hdmi_phy *phy)
 	return ret;
 }
 
-void hdmi_phy_resource_disable(struct hdmi_phy *phy)
+void msm_hdmi_phy_resource_disable(struct hdmi_phy *phy)
 {
 	struct hdmi_phy_cfg *cfg = phy->cfg;
 	struct device *dev = &phy->pdev->dev;
@@ -102,7 +102,7 @@ void hdmi_phy_resource_disable(struct hdmi_phy *phy)
 	pm_runtime_put_sync(dev);
 }
 
-void hdmi_phy_powerup(struct hdmi_phy *phy, unsigned long int pixclock)
+void msm_hdmi_phy_powerup(struct hdmi_phy *phy, unsigned long int pixclock)
 {
 	if (!phy || !phy->cfg->powerup)
 		return;
@@ -110,7 +110,7 @@ void hdmi_phy_powerup(struct hdmi_phy *phy, unsigned long int pixclock)
 	phy->cfg->powerup(phy, pixclock);
 }
 
-void hdmi_phy_powerdown(struct hdmi_phy *phy)
+void msm_hdmi_phy_powerdown(struct hdmi_phy *phy)
 {
 	if (!phy || !phy->cfg->powerdown)
 		return;
@@ -118,17 +118,17 @@ void hdmi_phy_powerdown(struct hdmi_phy *phy)
 	phy->cfg->powerdown(phy);
 }
 
-static int hdmi_phy_pll_init(struct platform_device *pdev,
+static int msm_hdmi_phy_pll_init(struct platform_device *pdev,
 			     enum hdmi_phy_type type)
 {
 	int ret;
 
 	switch (type) {
 	case MSM_HDMI_PHY_8960:
-		ret = hdmi_pll_8960_init(pdev);
+		ret = msm_hdmi_pll_8960_init(pdev);
 		break;
 	case MSM_HDMI_PHY_8996:
-		ret = hdmi_pll_8996_init(pdev);
+		ret = msm_hdmi_pll_8996_init(pdev);
 		break;
 	/*
 	 * we don't have PLL support for these, don't report an error for now
@@ -143,7 +143,7 @@ static int hdmi_phy_pll_init(struct platform_device *pdev,
 	return ret;
 }
 
-static int hdmi_phy_probe(struct platform_device *pdev)
+static int msm_hdmi_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct hdmi_phy *phy;
@@ -165,64 +165,64 @@ static int hdmi_phy_probe(struct platform_device *pdev)
 
 	phy->pdev = pdev;
 
-	ret = hdmi_phy_resource_init(phy);
+	ret = msm_hdmi_phy_resource_init(phy);
 	if (ret)
 		return ret;
 
 	pm_runtime_enable(&pdev->dev);
 
-	ret = hdmi_phy_resource_enable(phy);
+	ret = msm_hdmi_phy_resource_enable(phy);
 	if (ret)
 		return ret;
 
-	ret = hdmi_phy_pll_init(pdev, phy->cfg->type);
+	ret = msm_hdmi_phy_pll_init(pdev, phy->cfg->type);
 	if (ret) {
 		dev_err(dev, "couldn't init PLL\n");
-		hdmi_phy_resource_disable(phy);
+		msm_hdmi_phy_resource_disable(phy);
 		return ret;
 	}
 
-	hdmi_phy_resource_disable(phy);
+	msm_hdmi_phy_resource_disable(phy);
 
 	platform_set_drvdata(pdev, phy);
 
 	return 0;
 }
 
-static int hdmi_phy_remove(struct platform_device *pdev)
+static int msm_hdmi_phy_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
 
-static const struct of_device_id hdmi_phy_dt_match[] = {
+static const struct of_device_id msm_hdmi_phy_dt_match[] = {
 	{ .compatible = "qcom,hdmi-phy-8x60",
-	  .data = &hdmi_phy_8x60_cfg },
+	  .data = &msm_hdmi_phy_8x60_cfg },
 	{ .compatible = "qcom,hdmi-phy-8960",
-	  .data = &hdmi_phy_8960_cfg },
+	  .data = &msm_hdmi_phy_8960_cfg },
 	{ .compatible = "qcom,hdmi-phy-8x74",
-	  .data = &hdmi_phy_8x74_cfg },
+	  .data = &msm_hdmi_phy_8x74_cfg },
 	{ .compatible = "qcom,hdmi-phy-8996",
-	  .data = &hdmi_phy_8996_cfg },
+	  .data = &msm_hdmi_phy_8996_cfg },
 	{}
 };
 
-static struct platform_driver hdmi_phy_platform_driver = {
-	.probe      = hdmi_phy_probe,
-	.remove     = hdmi_phy_remove,
+static struct platform_driver msm_hdmi_phy_platform_driver = {
+	.probe      = msm_hdmi_phy_probe,
+	.remove     = msm_hdmi_phy_remove,
 	.driver     = {
 		.name   = "msm_hdmi_phy",
-		.of_match_table = hdmi_phy_dt_match,
+		.of_match_table = msm_hdmi_phy_dt_match,
 	},
 };
 
-void __init hdmi_phy_driver_register(void)
+void __init msm_hdmi_phy_driver_register(void)
 {
-	platform_driver_register(&hdmi_phy_platform_driver);
+	platform_driver_register(&msm_hdmi_phy_platform_driver);
 }
 
-void __exit hdmi_phy_driver_unregister(void)
+void __exit msm_hdmi_phy_driver_unregister(void)
 {
-	platform_driver_unregister(&hdmi_phy_platform_driver);
+	platform_driver_unregister(&msm_hdmi_phy_platform_driver);
 }
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.c
index 46d449e84d71..e6ee6b745ab7 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.c
@@ -51,7 +51,7 @@ static const char * const hdmi_phy_8960_clk_names[] = {
 	"slave_iface_clk",
 };
 
-const struct hdmi_phy_cfg hdmi_phy_8960_cfg = {
+const struct hdmi_phy_cfg msm_hdmi_phy_8960_cfg = {
 	.type = MSM_HDMI_PHY_8960,
 	.powerup = hdmi_phy_8960_powerup,
 	.powerdown = hdmi_phy_8960_powerdown,
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
index ed38976e599a..aa94a553794f 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
@@ -704,7 +704,7 @@ static struct clk_init_data pll_init = {
 	.num_parents = ARRAY_SIZE(hdmi_pll_parents),
 };
 
-int hdmi_pll_8996_init(struct platform_device *pdev)
+int msm_hdmi_pll_8996_init(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct hdmi_pll_8996 *pll;
@@ -757,7 +757,7 @@ static const char * const hdmi_phy_8996_clk_names[] = {
 	"ref_clk",
 };
 
-const struct hdmi_phy_cfg hdmi_phy_8996_cfg = {
+const struct hdmi_phy_cfg msm_hdmi_phy_8996_cfg = {
 	.type = MSM_HDMI_PHY_8996,
 	.reg_names = hdmi_phy_8996_reg_names,
 	.num_regs = ARRAY_SIZE(hdmi_phy_8996_reg_names),
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8x60.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8x60.c
index 38022b3af8c1..a68eea4153fc 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8x60.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8x60.c
@@ -131,7 +131,7 @@ static void hdmi_phy_8x60_powerdown(struct hdmi_phy *phy)
 		       HDMI_8x60_PHY_REG2_PD_DESER);
 }
 
-const struct hdmi_phy_cfg hdmi_phy_8x60_cfg = {
+const struct hdmi_phy_cfg msm_hdmi_phy_8x60_cfg = {
 	.type = MSM_HDMI_PHY_8x60,
 	.powerup = hdmi_phy_8x60_powerup,
 	.powerdown = hdmi_phy_8x60_powerdown,
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8x74.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8x74.c
index 145e38eb17e2..c4a61e537851 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8x74.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8x74.c
@@ -45,7 +45,7 @@ static const char * const hdmi_phy_8x74_clk_names[] = {
 	"alt_iface_clk"
 };
 
-const struct hdmi_phy_cfg hdmi_phy_8x74_cfg = {
+const struct hdmi_phy_cfg msm_hdmi_phy_8x74_cfg = {
 	.type = MSM_HDMI_PHY_8x74,
 	.powerup = hdmi_phy_8x74_powerup,
 	.powerdown = hdmi_phy_8x74_powerdown,
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.c b/drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.c
index 35830a9ab615..92da69aa6187 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.c
@@ -426,7 +426,7 @@ static struct clk_init_data pll_init = {
 	.num_parents = ARRAY_SIZE(hdmi_pll_parents),
 };
 
-int hdmi_pll_8960_init(struct platform_device *pdev)
+int msm_hdmi_pll_8960_init(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct hdmi_pll_8960 *pll;
diff --git a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.c
index 54b9d9b79bba..76e1dfb5d25e 100644
--- a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.c
@@ -326,7 +326,7 @@ static int mdp4_modeset_init_intf(struct mdp4_kms *mdp4_kms,
 
 		if (priv->hdmi) {
 			/* Construct bridge/connector for HDMI: */
-			ret = hdmi_modeset_init(priv->hdmi, dev, encoder);
+			ret = msm_hdmi_modeset_init(priv->hdmi, dev, encoder);
 			if (ret) {
 				dev_err(dev->dev, "failed to initialize HDMI: %d\n", ret);
 				return ret;
diff --git a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
index 5e4d16b399c7..484b4d15e71d 100644
--- a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
@@ -284,7 +284,7 @@ static int modeset_init_intf(struct mdp5_kms *mdp5_kms, int intf_num)
 			break;
 		}
 
-		ret = hdmi_modeset_init(priv->hdmi, dev, encoder);
+		ret = msm_hdmi_modeset_init(priv->hdmi, dev, encoder);
 		break;
 	case INTF_DSI:
 	{
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 280503e19bfd..d52910e2c26c 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1121,7 +1121,7 @@ static int __init msm_drm_register(void)
 	DBG("init");
 	msm_dsi_register();
 	msm_edp_register();
-	hdmi_register();
+	msm_hdmi_register();
 	adreno_register();
 	return platform_driver_register(&msm_platform_driver);
 }
@@ -1130,7 +1130,7 @@ static void __exit msm_drm_unregister(void)
 {
 	DBG("fini");
 	platform_driver_unregister(&msm_platform_driver);
-	hdmi_unregister();
+	msm_hdmi_unregister();
 	adreno_unregister();
 	msm_edp_unregister();
 	msm_dsi_unregister();
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 6980aa4510cb..a2755b4a0d86 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -244,22 +244,22 @@ void msm_fbdev_free(struct drm_device *dev);
 
 struct hdmi;
 #ifdef CONFIG_DRM_MSM_HDMI
-int hdmi_modeset_init(struct hdmi *hdmi, struct drm_device *dev,
+int msm_hdmi_modeset_init(struct hdmi *hdmi, struct drm_device *dev,
 		struct drm_encoder *encoder);
-void __init hdmi_register(void);
-void __exit hdmi_unregister(void);
+void __init msm_hdmi_register(void);
+void __exit msm_hdmi_unregister(void);
 #else
-static inline int hdmi_modeset_init(struct hdmi *hdmi, struct drm_device *dev,
+static inline int msm_hdmi_modeset_init(struct hdmi *hdmi, struct drm_device *dev,
 				    struct drm_encoder *encoder)
 {
 	return -EINVAL;
 }
 
-static inline void __init hdmi_register(void)
+static inline void __init msm_hdmi_register(void)
 {
 }
 
-static inline void __exit hdmi_unregister(void)
+static inline void __exit msm_hdmi_unregister(void)
 {
 }
 #endif
-- 
2.7.0
