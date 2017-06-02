From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  2 Jun 2017 18:10:09 +0800
Subject: [PATCH 04/19] drm/sun4i: hdmi: Disable clks in bind function error
 path and unbind function
In-Reply-To: <20170602101024.18940-1-wens@csie.org>
References: <20170602101024.18940-1-wens@csie.org>
Message-ID: <20170602101024.18940-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HDMI driver enables the bus and mod clocks in the bind function, but
does not disable them if it then bails our due to any errors. Neither
does it disable the clocks in the unbind function.

Fix this by adding a proper error path to the bind function, and
clk_disable_unprepare calls to the unbind function.

Also rename the err_cleanup_connector label to err_cleanup_encoder,
since it is the encoder that gets cleaned up.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index d3398f6250ef..457614073501 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -350,26 +350,29 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 	hdmi->mod_clk = devm_clk_get(dev, "mod");
 	if (IS_ERR(hdmi->mod_clk)) {
 		dev_err(dev, "Couldn't get the HDMI mod clock\n");
-		return PTR_ERR(hdmi->mod_clk);
+		ret = PTR_ERR(hdmi->mod_clk);
+		goto err_disable_bus_clk;
 	}
 	clk_prepare_enable(hdmi->mod_clk);
 
 	hdmi->pll0_clk = devm_clk_get(dev, "pll-0");
 	if (IS_ERR(hdmi->pll0_clk)) {
 		dev_err(dev, "Couldn't get the HDMI PLL 0 clock\n");
-		return PTR_ERR(hdmi->pll0_clk);
+		ret = PTR_ERR(hdmi->pll0_clk);
+		goto err_disable_mod_clk;
 	}
 
 	hdmi->pll1_clk = devm_clk_get(dev, "pll-1");
 	if (IS_ERR(hdmi->pll1_clk)) {
 		dev_err(dev, "Couldn't get the HDMI PLL 1 clock\n");
-		return PTR_ERR(hdmi->pll1_clk);
+		ret = PTR_ERR(hdmi->pll1_clk);
+		goto err_disable_mod_clk;
 	}
 
 	ret = sun4i_tmds_create(hdmi);
 	if (ret) {
 		dev_err(dev, "Couldn't create the TMDS clock\n");
-		return ret;
+		goto err_disable_mod_clk;
 	}
 
 	writel(SUN4I_HDMI_CTRL_ENABLE, hdmi->base + SUN4I_HDMI_CTRL_REG);
@@ -410,7 +413,7 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 	ret = sun4i_ddc_create(hdmi, hdmi->tmds_clk);
 	if (ret) {
 		dev_err(dev, "Couldn't create the DDC clock\n");
-		return ret;
+		goto err_disable_mod_clk;
 	}
 
 	drm_encoder_helper_add(&hdmi->encoder,
@@ -428,7 +431,7 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 	hdmi->encoder.possible_crtcs = drm_of_find_possible_crtcs(drm,
 								  dev->of_node);
 	if (!hdmi->encoder.possible_crtcs)
-		return -EPROBE_DEFER;
+		goto err_disable_mod_clk;
 
 	drm_connector_helper_add(&hdmi->connector,
 				 &sun4i_hdmi_connector_helper_funcs);
@@ -438,7 +441,7 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 	if (ret) {
 		dev_err(dev,
 			"Couldn't initialise the HDMI connector\n");
-		goto err_cleanup_connector;
+		goto err_cleanup_encoder;
 	}
 
 	/* There is no HPD interrupt, so we need to poll the controller */
@@ -449,8 +452,12 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 
 	return 0;
 
-err_cleanup_connector:
+err_cleanup_encoder:
 	drm_encoder_cleanup(&hdmi->encoder);
+err_disable_mod_clk:
+	clk_disable_unprepare(hdmi->mod_clk);
+err_disable_bus_clk:
+	clk_disable_unprepare(hdmi->bus_clk);
 	return ret;
 }
 
@@ -461,6 +468,8 @@ static void sun4i_hdmi_unbind(struct device *dev, struct device *master,
 
 	drm_connector_cleanup(&hdmi->connector);
 	drm_encoder_cleanup(&hdmi->encoder);
+	clk_disable_unprepare(hdmi->mod_clk);
+	clk_disable_unprepare(hdmi->bus_clk);
 }
 
 static const struct component_ops sun4i_hdmi_ops = {
-- 
2.11.0
