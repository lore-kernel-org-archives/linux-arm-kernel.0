From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu, 19 Oct 2017 11:48:11 +0800
Subject: [PATCH v6 09/10] drm/bridge/synopsys: dw-hdmi: Do not use device's
 drvdata
In-Reply-To: <20171019034812.13768-1-jeffy.chen@rock-chips.com>
References: <20171019034812.13768-1-jeffy.chen@rock-chips.com>
Message-ID: <20171019034812.13768-10-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let plat drivers own the drvdata, so that they could cleanup resources
in their unbind().

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---

Changes in v6: None
Changes in v5: None

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c   | 43 ++++++++++-------------------
 drivers/gpu/drm/imx/dw_hdmi-imx.c           | 22 +++++++++------
 drivers/gpu/drm/meson/meson_dw_hdmi.c       | 20 ++++++++++----
 drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c      | 14 ++++++++--
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 23 ++++++++-------
 include/drm/bridge/dw_hdmi.h                | 17 ++++++------
 6 files changed, 77 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index ff1b3d2b5d06..6fbfafc5832b 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2072,7 +2072,7 @@ static irqreturn_t dw_hdmi_hardirq(int irq, void *dev_id)
 	return ret;
 }
 
-void __dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
+void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
 {
 	mutex_lock(&hdmi->mutex);
 
@@ -2098,13 +2098,6 @@ void __dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
 	}
 	mutex_unlock(&hdmi->mutex);
 }
-
-void dw_hdmi_setup_rx_sense(struct device *dev, bool hpd, bool rx_sense)
-{
-	struct dw_hdmi *hdmi = dev_get_drvdata(dev);
-
-	__dw_hdmi_setup_rx_sense(hdmi, hpd, rx_sense);
-}
 EXPORT_SYMBOL_GPL(dw_hdmi_setup_rx_sense);
 
 static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
@@ -2140,9 +2133,8 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 	 */
 	if (intr_stat &
 	    (HDMI_IH_PHY_STAT0_RX_SENSE | HDMI_IH_PHY_STAT0_HPD)) {
-		__dw_hdmi_setup_rx_sense(hdmi,
-					 phy_stat & HDMI_PHY_HPD,
-					 phy_stat & HDMI_PHY_RX_SENSE);
+		dw_hdmi_setup_rx_sense(hdmi, phy_stat & HDMI_PHY_HPD,
+				       phy_stat & HDMI_PHY_RX_SENSE);
 
 		if ((phy_stat & (HDMI_PHY_RX_SENSE | HDMI_PHY_HPD)) == 0)
 			cec_notifier_set_phys_addr(hdmi->cec_notifier,
@@ -2512,8 +2504,6 @@ __dw_hdmi_probe(struct platform_device *pdev,
 	if (hdmi->i2c)
 		dw_hdmi_i2c_init(hdmi);
 
-	platform_set_drvdata(pdev, hdmi);
-
 	return hdmi;
 
 err_iahb:
@@ -2559,25 +2549,23 @@ static void __dw_hdmi_remove(struct dw_hdmi *hdmi)
 /* -----------------------------------------------------------------------------
  * Probe/remove API, used from platforms based on the DRM bridge API.
  */
-int dw_hdmi_probe(struct platform_device *pdev,
-		  const struct dw_hdmi_plat_data *plat_data)
+struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
+			      const struct dw_hdmi_plat_data *plat_data)
 {
 	struct dw_hdmi *hdmi;
 
 	hdmi = __dw_hdmi_probe(pdev, plat_data);
 	if (IS_ERR(hdmi))
-		return PTR_ERR(hdmi);
+		return hdmi;
 
 	drm_bridge_add(&hdmi->bridge);
 
-	return 0;
+	return hdmi;
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_probe);
 
-void dw_hdmi_remove(struct platform_device *pdev)
+void dw_hdmi_remove(struct dw_hdmi *hdmi)
 {
-	struct dw_hdmi *hdmi = platform_get_drvdata(pdev);
-
 	drm_bridge_remove(&hdmi->bridge);
 
 	__dw_hdmi_remove(hdmi);
@@ -2587,31 +2575,30 @@ EXPORT_SYMBOL_GPL(dw_hdmi_remove);
 /* -----------------------------------------------------------------------------
  * Bind/unbind API, used from platforms based on the component framework.
  */
-int dw_hdmi_bind(struct platform_device *pdev, struct drm_encoder *encoder,
-		 const struct dw_hdmi_plat_data *plat_data)
+struct dw_hdmi *dw_hdmi_bind(struct platform_device *pdev,
+			    struct drm_encoder *encoder,
+			    const struct dw_hdmi_plat_data *plat_data)
 {
 	struct dw_hdmi *hdmi;
 	int ret;
 
 	hdmi = __dw_hdmi_probe(pdev, plat_data);
 	if (IS_ERR(hdmi))
-		return PTR_ERR(hdmi);
+		return hdmi;
 
 	ret = drm_bridge_attach(encoder, &hdmi->bridge, NULL);
 	if (ret) {
 		__dw_hdmi_remove(hdmi);
 		DRM_ERROR("Failed to initialize bridge with drm\n");
-		return ret;
+		return ERR_PTR(ret);
 	}
 
-	return 0;
+	return hdmi;
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_bind);
 
-void dw_hdmi_unbind(struct device *dev)
+void dw_hdmi_unbind(struct dw_hdmi *hdmi)
 {
-	struct dw_hdmi *hdmi = dev_get_drvdata(dev);
-
 	__dw_hdmi_remove(hdmi);
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_unbind);
diff --git a/drivers/gpu/drm/imx/dw_hdmi-imx.c b/drivers/gpu/drm/imx/dw_hdmi-imx.c
index b62763aa8706..b01d03e02ce0 100644
--- a/drivers/gpu/drm/imx/dw_hdmi-imx.c
+++ b/drivers/gpu/drm/imx/dw_hdmi-imx.c
@@ -26,6 +26,8 @@ struct imx_hdmi {
 	struct device *dev;
 	struct drm_encoder encoder;
 	struct regmap *regmap;
+
+	struct dw_hdmi *hdmi;
 };
 
 static inline struct imx_hdmi *enc_to_imx_hdmi(struct drm_encoder *e)
@@ -239,22 +241,24 @@ static int dw_hdmi_imx_bind(struct device *dev, struct device *master,
 	drm_encoder_init(drm, encoder, &dw_hdmi_imx_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
 
-	ret = dw_hdmi_bind(pdev, encoder, plat_data);
+	hdmi->hdmi = dw_hdmi_bind(pdev, encoder, plat_data);
+	if (IS_ERR(hdmi->hdmi)) {
+		encoder->funcs->destroy(encoder);
+		return PTR_ERR(hdmi->hdmi);
+	}
 
-	/*
-	 * If dw_hdmi_bind() fails we'll never call dw_hdmi_unbind(),
-	 * which would have called the encoder cleanup.  Do it manually.
-	 */
-	if (ret)
-		drm_encoder_cleanup(encoder);
+	dev_set_drvdata(dev, hdmi);
 
-	return ret;
+	return 0;
 }
 
 static void dw_hdmi_imx_unbind(struct device *dev, struct device *master,
 			       void *data)
 {
-	return dw_hdmi_unbind(dev);
+	struct imx_hdmi *hdmi = dev_get_drvdata(dev);
+
+	dw_hdmi_unbind(hdmi->hdmi);
+	hdmi->encoder.funcs->destroy(&hdmi->encoder);
 }
 
 static const struct component_ops dw_hdmi_imx_ops = {
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index cef414466f9f..fc29f69f7108 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -138,6 +138,8 @@ struct meson_dw_hdmi {
 	struct clk *hdmi_pclk;
 	struct clk *venci_clk;
 	u32 irq_stat;
+
+	struct dw_hdmi *hdmi;
 };
 #define encoder_to_meson_dw_hdmi(x) \
 	container_of(x, struct meson_dw_hdmi, encoder)
@@ -526,7 +528,7 @@ static irqreturn_t dw_hdmi_top_thread_irq(int irq, void *dev_id)
 		if (stat & HDMITX_TOP_INTR_HPD_RISE)
 			hpd_connected = true;
 
-		dw_hdmi_setup_rx_sense(dw_hdmi->dev, hpd_connected,
+		dw_hdmi_setup_rx_sense(dw_hdmi->hdmi, hpd_connected,
 				       hpd_connected);
 
 		drm_helper_hpd_irq_event(dw_hdmi->encoder.dev);
@@ -865,9 +867,14 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	dw_plat_data->input_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
 	dw_plat_data->input_bus_encoding = V4L2_YCBCR_ENC_709;
 
-	ret = dw_hdmi_bind(pdev, encoder, &meson_dw_hdmi->dw_plat_data);
-	if (ret)
-		return ret;
+	meson_dw_hdmi->hdmi = dw_hdmi_bind(pdev, encoder,
+					   &meson_dw_hdmi->dw_plat_data);
+	if (IS_ERR(meson_dw_hdmi->hdmi)) {
+		encoder->funcs->destroy(encoder);
+		return PTR_ERR(meson_dw_hdmi->hdmi);
+	}
+
+	dev_set_drvdata(dev, meson_dw_hdmi);
 
 	DRM_DEBUG_DRIVER("HDMI controller initialized\n");
 
@@ -877,7 +884,10 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 static void meson_dw_hdmi_unbind(struct device *dev, struct device *master,
 				   void *data)
 {
-	dw_hdmi_unbind(dev);
+	struct meson_dw_hdmi *meson_dw_hdmi = dev_get_drvdata(dev);
+
+	dw_hdmi_unbind(meson_dw_hdmi->hdmi);
+	meson_dw_hdmi->encoder.funcs->destroy(&meson_dw_hdmi->encoder);
 }
 
 static const struct component_ops meson_dw_hdmi_ops = {
diff --git a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c b/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
index dc85b53d58ef..76210ae25094 100644
--- a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
+++ b/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
@@ -68,12 +68,22 @@ static const struct dw_hdmi_plat_data rcar_dw_hdmi_plat_data = {
 
 static int rcar_dw_hdmi_probe(struct platform_device *pdev)
 {
-	return dw_hdmi_probe(pdev, &rcar_dw_hdmi_plat_data);
+	struct dw_hdmi *hdmi;
+
+	hdmi = dw_hdmi_probe(pdev, &rcar_dw_hdmi_plat_data);
+	if (IS_ERR(hdmi))
+		return PTR_ERR(hdmi);
+
+	platform_set_drvdata(pdev, hdmi);
+
+	return 0;
 }
 
 static int rcar_dw_hdmi_remove(struct platform_device *pdev)
 {
-	dw_hdmi_remove(pdev);
+	struct dw_hdmi *hdmi = platform_get_drvdata(pdev);
+
+	dw_hdmi_remove(hdmi);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 1eb02a82fd91..791ab938f998 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -48,6 +48,8 @@ struct rockchip_hdmi {
 	const struct rockchip_hdmi_chip_data *chip_data;
 	struct clk *vpll_clk;
 	struct clk *grf_clk;
+
+	struct dw_hdmi *hdmi;
 };
 
 #define to_rockchip_hdmi(x)	container_of(x, struct rockchip_hdmi, x)
@@ -164,7 +166,6 @@ static const struct dw_hdmi_phy_config rockchip_phy_config[] = {
 static int rockchip_hdmi_parse_dt(struct rockchip_hdmi *hdmi)
 {
 	struct device_node *np = hdmi->dev->of_node;
-	int ret;
 
 	hdmi->regmap = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
 	if (IS_ERR(hdmi->regmap)) {
@@ -377,22 +378,24 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	drm_encoder_init(drm, encoder, &dw_hdmi_rockchip_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
 
-	ret = dw_hdmi_bind(pdev, encoder, plat_data);
+	hdmi->hdmi = dw_hdmi_bind(pdev, encoder, plat_data);
+	if (IS_ERR(hdmi->hdmi)) {
+		encoder->funcs->destroy(encoder);
+		return PTR_ERR(hdmi->hdmi);
+	}
 
-	/*
-	 * If dw_hdmi_bind() fails we'll never call dw_hdmi_unbind(),
-	 * which would have called the encoder cleanup.  Do it manually.
-	 */
-	if (ret)
-		drm_encoder_cleanup(encoder);
+	dev_set_drvdata(dev, hdmi);
 
-	return ret;
+	return 0;
 }
 
 static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *master,
 				    void *data)
 {
-	return dw_hdmi_unbind(dev);
+	struct rockchip_hdmi *hdmi = dev_get_drvdata(dev);
+
+	dw_hdmi_unbind(hdmi->hdmi);
+	hdmi->encoder.funcs->destroy(&hdmi->encoder);
 }
 
 static const struct component_ops dw_hdmi_rockchip_ops = {
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 182f83283e24..29b8900caaf7 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -143,14 +143,15 @@ struct dw_hdmi_plat_data {
 			     unsigned long mpixelclock);
 };
 
-int dw_hdmi_probe(struct platform_device *pdev,
-		  const struct dw_hdmi_plat_data *plat_data);
-void dw_hdmi_remove(struct platform_device *pdev);
-void dw_hdmi_unbind(struct device *dev);
-int dw_hdmi_bind(struct platform_device *pdev, struct drm_encoder *encoder,
-		 const struct dw_hdmi_plat_data *plat_data);
-
-void dw_hdmi_setup_rx_sense(struct device *dev, bool hpd, bool rx_sense);
+struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
+			      const struct dw_hdmi_plat_data *plat_data);
+void dw_hdmi_remove(struct dw_hdmi *hdmi);
+void dw_hdmi_unbind(struct dw_hdmi *hdmi);
+struct dw_hdmi *dw_hdmi_bind(struct platform_device *pdev,
+			     struct drm_encoder *encoder,
+			     const struct dw_hdmi_plat_data *plat_data);
+
+void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense);
 
 void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
 void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
-- 
2.11.0
