From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  2 Jun 2017 18:10:18 +0800
Subject: [PATCH 13/19] drm/sun4i: hdmi: Add support for controller hardware
 variants
In-Reply-To: <20170602101024.18940-1-wens@csie.org>
References: <20170602101024.18940-1-wens@csie.org>
Message-ID: <20170602101024.18940-14-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HDMI controller found in earlier Allwinner SoCs have slight
differences:

  - Need different initial values for the PLL related registers

  - Different behavior of the DDC and TMDS clocks

  - Different register layout for the DDC portion

  - Separate DDC parent clock on the A31

  - Explicit reset control

The clock variants are supported within their implementations,
which only expose a create function for each variant.

The different layout of the DDC registers necessitates a separate
version of struct drm_connector_helper_funcs.

A new variant data structure is created to store pointers to the
above functions, structures, and the different initial values.
Another flag notates whether there is a separate DDC parent clock.
If not, the TMDS clock is passed to the DDC clock create function,
as before.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c   |   2 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi.h     |   8 +++
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 114 ++++++++++++++++++++++++++-------
 3 files changed, 100 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index 4d6078fca9ac..e48186985a51 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -610,7 +610,7 @@ static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", lcd_ch1_parents,
 
 static SUNXI_CCU_GATE(hdmi_ddc_clk, "hdmi-ddc", "osc24M", 0x150, BIT(30), 0);
 
-static SUNXI_CCU_GATE(ps_clk, "ps", "lcd1-ch1", 0x140, BIT(31), 0);
+static SUNXI_CCU_GATE(ps_clk, "ps", "lcd1-ch1", 0x154, BIT(31), 0);
 
 static const char * const mbus_parents[] = { "osc24M", "pll-periph",
 					     "pll-ddr" };
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
index c39c2a245339..c63d0bd95963 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
@@ -155,6 +155,8 @@ enum sun4i_hdmi_pkt_type {
 	SUN4I_HDMI_PKT_END = 15,
 };
 
+struct sun4i_hdmi_variant;
+
 struct sun4i_hdmi {
 	struct drm_connector	connector;
 	struct drm_encoder	encoder;
@@ -162,9 +164,13 @@ struct sun4i_hdmi {
 
 	void __iomem		*base;
 
+	/* Reset control */
+	struct reset_control	*reset;
+
 	/* Parent clocks */
 	struct clk		*bus_clk;
 	struct clk		*mod_clk;
+	struct clk		*ddc_parent_clk;
 	struct clk		*pll0_clk;
 	struct clk		*pll1_clk;
 
@@ -175,6 +181,8 @@ struct sun4i_hdmi {
 	struct sun4i_drv	*drv;
 
 	bool			hdmi_monitor;
+
+	const struct sun4i_hdmi_variant	*variant;
 };
 
 int sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *clk);
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 457614073501..9ded40aaed32 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -20,8 +20,10 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/iopoll.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 
 #include "sun4i_backend.h"
 #include "sun4i_crtc.h"
@@ -315,6 +317,56 @@ static const struct drm_connector_funcs sun4i_hdmi_connector_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 };
 
+struct sun4i_hdmi_variant {
+	const struct drm_connector_helper_funcs *connector_helpers;
+	int (*ddc_create)(struct sun4i_hdmi *hdmi, struct clk *clk);
+	int (*tmds_create)(struct sun4i_hdmi *hdmi);
+	bool has_ddc_parent_clk;
+	bool has_reset_control;
+
+	u32 pad_ctrl0_init_val;
+	u32 pad_ctrl1_init_val;
+	u32 pll_ctrl_init_val;
+};
+
+#define SUN4I_HDMI_PAD_CTRL1_MASK	(GENMASK(24, 7) | GENMASK(5, 0))
+#define SUN4I_HDMI_PLL_CTRL_MASK	(GENMASK(31, 8) | GENMASK(3, 0))
+
+static const struct sun4i_hdmi_variant sun5i_variant = {
+	.connector_helpers	= &sun4i_hdmi_connector_helper_funcs,
+	.ddc_create		= sun4i_ddc_create,
+	.tmds_create		= sun4i_tmds_create,
+	.has_ddc_parent_clk	= false,
+	.has_reset_control	= false,
+	.pad_ctrl0_init_val	= SUN4I_HDMI_PAD_CTRL0_TXEN |
+				  SUN4I_HDMI_PAD_CTRL0_CKEN |
+				  SUN4I_HDMI_PAD_CTRL0_PWENG |
+				  SUN4I_HDMI_PAD_CTRL0_PWEND |
+				  SUN4I_HDMI_PAD_CTRL0_PWENC |
+				  SUN4I_HDMI_PAD_CTRL0_LDODEN |
+				  SUN4I_HDMI_PAD_CTRL0_LDOCEN |
+				  SUN4I_HDMI_PAD_CTRL0_BIASEN,
+	.pad_ctrl1_init_val	= SUN4I_HDMI_PAD_CTRL1_REG_AMP(6) |
+				  SUN4I_HDMI_PAD_CTRL1_REG_EMP(2) |
+				  SUN4I_HDMI_PAD_CTRL1_REG_DENCK |
+				  SUN4I_HDMI_PAD_CTRL1_REG_DEN |
+				  SUN4I_HDMI_PAD_CTRL1_EMPCK_OPT |
+				  SUN4I_HDMI_PAD_CTRL1_EMP_OPT |
+				  SUN4I_HDMI_PAD_CTRL1_AMPCK_OPT |
+				  SUN4I_HDMI_PAD_CTRL1_AMP_OPT,
+	.pll_ctrl_init_val	= SUN4I_HDMI_PLL_CTRL_VCO_S(8) |
+				  SUN4I_HDMI_PLL_CTRL_CS(7) |
+				  SUN4I_HDMI_PLL_CTRL_CP_S(15) |
+				  SUN4I_HDMI_PLL_CTRL_S(7) |
+				  SUN4I_HDMI_PLL_CTRL_VCO_GAIN(4) |
+				  SUN4I_HDMI_PLL_CTRL_SDIV2 |
+				  SUN4I_HDMI_PLL_CTRL_LDO2_EN |
+				  SUN4I_HDMI_PLL_CTRL_LDO1_EN |
+				  SUN4I_HDMI_PLL_CTRL_HV_IS_33 |
+				  SUN4I_HDMI_PLL_CTRL_BWS |
+				  SUN4I_HDMI_PLL_CTRL_PLL_EN,
+};
+
 static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 			   void *data)
 {
@@ -333,6 +385,10 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 	hdmi->dev = dev;
 	hdmi->drv = drv;
 
+	hdmi->variant = of_device_get_match_data(&pdev->dev);
+	if (!hdmi->variant)
+		return -EINVAL;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	hdmi->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(hdmi->base)) {
@@ -340,10 +396,25 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 		return PTR_ERR(hdmi->base);
 	}
 
+	if (hdmi->variant->has_reset_control) {
+		hdmi->reset = devm_reset_control_get(dev, NULL);
+		if (IS_ERR(hdmi->reset)) {
+			dev_err(dev, "Couldn't get the HDMI reset control\n");
+			return PTR_ERR(hdmi->reset);
+		}
+
+		ret = reset_control_deassert(hdmi->reset);
+		if (ret) {
+			dev_err(dev, "Couldn't deassert HDMI reset\n");
+			return ret;
+		}
+	}
+
 	hdmi->bus_clk = devm_clk_get(dev, "ahb");
 	if (IS_ERR(hdmi->bus_clk)) {
 		dev_err(dev, "Couldn't get the HDMI bus clock\n");
-		return PTR_ERR(hdmi->bus_clk);
+		ret = PTR_ERR(hdmi->bus_clk);
+		goto err_assert_reset;
 	}
 	clk_prepare_enable(hdmi->bus_clk);
 
@@ -369,18 +440,25 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 		goto err_disable_mod_clk;
 	}
 
-	ret = sun4i_tmds_create(hdmi);
+	ret = hdmi->variant->tmds_create(hdmi);
 	if (ret) {
 		dev_err(dev, "Couldn't create the TMDS clock\n");
 		goto err_disable_mod_clk;
 	}
 
+	if (hdmi->variant->has_ddc_parent_clk) {
+		hdmi->ddc_parent_clk = devm_clk_get(dev, "ddc");
+		if (IS_ERR(hdmi->ddc_parent_clk)) {
+			dev_err(dev, "Couldn't get the HDMI DDC clock\n");
+			return PTR_ERR(hdmi->ddc_parent_clk);
+		}
+	} else {
+		hdmi->ddc_parent_clk = hdmi->tmds_clk;
+	}
+
 	writel(SUN4I_HDMI_CTRL_ENABLE, hdmi->base + SUN4I_HDMI_CTRL_REG);
 
-	writel(SUN4I_HDMI_PAD_CTRL0_TXEN | SUN4I_HDMI_PAD_CTRL0_CKEN |
-	       SUN4I_HDMI_PAD_CTRL0_PWENG | SUN4I_HDMI_PAD_CTRL0_PWEND |
-	       SUN4I_HDMI_PAD_CTRL0_PWENC | SUN4I_HDMI_PAD_CTRL0_LDODEN |
-	       SUN4I_HDMI_PAD_CTRL0_LDOCEN | SUN4I_HDMI_PAD_CTRL0_BIASEN,
+	writel(hdmi->variant->pad_ctrl0_init_val,
 	       hdmi->base + SUN4I_HDMI_PAD_CTRL0_REG);
 
 	/*
@@ -390,27 +468,15 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 	 */
 	reg = readl(hdmi->base + SUN4I_HDMI_PAD_CTRL1_REG);
 	reg &= SUN4I_HDMI_PAD_CTRL1_HALVE_CLK;
-	reg |= SUN4I_HDMI_PAD_CTRL1_REG_AMP(6) |
-		SUN4I_HDMI_PAD_CTRL1_REG_EMP(2) |
-		SUN4I_HDMI_PAD_CTRL1_REG_DENCK |
-		SUN4I_HDMI_PAD_CTRL1_REG_DEN |
-		SUN4I_HDMI_PAD_CTRL1_EMPCK_OPT |
-		SUN4I_HDMI_PAD_CTRL1_EMP_OPT |
-		SUN4I_HDMI_PAD_CTRL1_AMPCK_OPT |
-		SUN4I_HDMI_PAD_CTRL1_AMP_OPT;
+	reg |= hdmi->variant->pad_ctrl1_init_val;
 	writel(reg, hdmi->base + SUN4I_HDMI_PAD_CTRL1_REG);
 
 	reg = readl(hdmi->base + SUN4I_HDMI_PLL_CTRL_REG);
 	reg &= SUN4I_HDMI_PLL_CTRL_DIV_MASK;
-	reg |= SUN4I_HDMI_PLL_CTRL_VCO_S(8) | SUN4I_HDMI_PLL_CTRL_CS(7) |
-		SUN4I_HDMI_PLL_CTRL_CP_S(15) | SUN4I_HDMI_PLL_CTRL_S(7) |
-		SUN4I_HDMI_PLL_CTRL_VCO_GAIN(4) | SUN4I_HDMI_PLL_CTRL_SDIV2 |
-		SUN4I_HDMI_PLL_CTRL_LDO2_EN | SUN4I_HDMI_PLL_CTRL_LDO1_EN |
-		SUN4I_HDMI_PLL_CTRL_HV_IS_33 | SUN4I_HDMI_PLL_CTRL_BWS |
-		SUN4I_HDMI_PLL_CTRL_PLL_EN;
+	reg |= hdmi->variant->pll_ctrl_init_val;
 	writel(reg, hdmi->base + SUN4I_HDMI_PLL_CTRL_REG);
 
-	ret = sun4i_ddc_create(hdmi, hdmi->tmds_clk);
+	ret = hdmi->variant->ddc_create(hdmi, hdmi->ddc_parent_clk);
 	if (ret) {
 		dev_err(dev, "Couldn't create the DDC clock\n");
 		goto err_disable_mod_clk;
@@ -434,7 +500,7 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 		goto err_disable_mod_clk;
 
 	drm_connector_helper_add(&hdmi->connector,
-				 &sun4i_hdmi_connector_helper_funcs);
+				 hdmi->variant->connector_helpers);
 	ret = drm_connector_init(drm, &hdmi->connector,
 				 &sun4i_hdmi_connector_funcs,
 				 DRM_MODE_CONNECTOR_HDMIA);
@@ -458,6 +524,8 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 	clk_disable_unprepare(hdmi->mod_clk);
 err_disable_bus_clk:
 	clk_disable_unprepare(hdmi->bus_clk);
+err_assert_reset:
+	reset_control_assert(hdmi->reset);
 	return ret;
 }
 
@@ -490,7 +558,7 @@ static int sun4i_hdmi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sun4i_hdmi_of_table[] = {
-	{ .compatible = "allwinner,sun5i-a10s-hdmi" },
+	{ .compatible = "allwinner,sun5i-a10s-hdmi", .data = &sun5i_variant, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_hdmi_of_table);
-- 
2.11.0
