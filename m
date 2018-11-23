From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:25:11 +0100
Subject: [PATCH v2 39/43] drm/sun4i: frontend: Add a quirk structure
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-40-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The ACCESS_CTRL bit is not found on all the variants of the frontend, so
let's introduce a structure that will hold whether or not we need to set
it, and associate it with the compatible.

This will be extended for further similar quirks later on.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 21 +++++++++++++++++----
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  6 ++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 2c9dcb4ffde0..368391a9e5fd 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -74,9 +75,10 @@ static void sun4i_frontend_scaler_init(struct sun4i_frontend *frontend)
 {
 	int i;
 
-	regmap_write_bits(frontend->regs, SUN4I_FRONTEND_FRM_CTRL_REG,
-			  SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL,
-			  SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL);
+	if (frontend->data->has_coef_access_ctrl)
+		regmap_write_bits(frontend->regs, SUN4I_FRONTEND_FRM_CTRL_REG,
+				  SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL,
+				  SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL);
 
 	for (i = 0; i < 32; i++) {
 		regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_HORZCOEF0_REG(i),
@@ -547,6 +549,10 @@ static int sun4i_frontend_bind(struct device *dev, struct device *master,
 	frontend->dev = dev;
 	frontend->node = dev->of_node;
 
+	frontend->data = of_device_get_match_data(dev);
+	if (!frontend->data)
+		return -ENODEV;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(regs))
@@ -659,8 +665,15 @@ static const struct dev_pm_ops sun4i_frontend_pm_ops = {
 	.runtime_suspend	= sun4i_frontend_runtime_suspend,
 };
 
+static const struct sun4i_frontend_data sun8i_a33_frontend = {
+	.has_coef_access_ctrl	= true,
+};
+
 const struct of_device_id sun4i_frontend_of_table[] = {
-	{ .compatible = "allwinner,sun8i-a33-display-frontend" },
+	{
+		.compatible = "allwinner,sun8i-a33-display-frontend",
+		.data = &sun8i_a33_frontend
+	},
 	{ }
 };
 EXPORT_SYMBOL(sun4i_frontend_of_table);
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 822d39ca4b8e..daf3fa5d01ba 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -100,6 +100,10 @@ struct drm_plane;
 struct regmap;
 struct reset_control;
 
+struct sun4i_frontend_data {
+	bool	has_coef_access_ctrl;
+};
+
 struct sun4i_frontend {
 	struct list_head	list;
 	struct device		*dev;
@@ -110,6 +114,8 @@ struct sun4i_frontend {
 	struct clk		*ram_clk;
 	struct regmap		*regs;
 	struct reset_control	*reset;
+
+	const struct sun4i_frontend_data	*data;
 };
 
 extern const struct of_device_id sun4i_frontend_of_table[];
-- 
2.19.1
