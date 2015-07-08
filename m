From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Wed, 8 Jul 2015 15:59:43 +0300
Subject: [PATCH 04/10] drm: imx-tve: use of_get_i2c_adapter_by_node interface
In-Reply-To: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1436360383-9327-1-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change is needed to properly lock I2C bus driver, which serves DDC.

Note that prior to this change put_device() coupled with
of_find_i2c_adapter_by_node() is missing on imx_tve_bind() error path
and imx_tve_unbind(), also the change fixes possibly left enabled voltage
regulator on imx_tve_bind() error path.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/gpu/drm/imx/imx-tve.c | 56 +++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
index 214ecee..f1ac927 100644
--- a/drivers/gpu/drm/imx/imx-tve.c
+++ b/drivers/gpu/drm/imx/imx-tve.c
@@ -581,14 +581,15 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 
 	ddc_node = of_parse_phandle(np, "ddc-i2c-bus", 0);
 	if (ddc_node) {
-		tve->ddc = of_find_i2c_adapter_by_node(ddc_node);
+		tve->ddc = of_get_i2c_adapter_by_node(ddc_node);
 		of_node_put(ddc_node);
 	}
 
 	tve->mode = of_get_tve_mode(np);
 	if (tve->mode != TVE_MODE_VGA) {
 		dev_err(dev, "only VGA mode supported, currently\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto i2c_release;
 	}
 
 	if (tve->mode == TVE_MODE_VGA) {
@@ -597,7 +598,7 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 
 		if (ret < 0) {
 			dev_err(dev, "failed to get vsync pin\n");
-			return ret;
+			goto i2c_release;
 		}
 
 		ret |= of_property_read_u32(np, "fsl,vsync-pin",
@@ -605,14 +606,16 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 
 		if (ret < 0) {
 			dev_err(dev, "failed to get vsync pin\n");
-			return ret;
+			goto i2c_release;
 		}
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
+		goto i2c_release;
+	}
 
 	tve_regmap_config.lock_arg = tve;
 	tve->regmap = devm_regmap_init_mmio_clk(dev, "tve", base,
@@ -620,13 +623,15 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 	if (IS_ERR(tve->regmap)) {
 		dev_err(dev, "failed to init regmap: %ld\n",
 			PTR_ERR(tve->regmap));
-		return PTR_ERR(tve->regmap);
+		ret = PTR_ERR(tve->regmap);
+		goto i2c_release;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "failed to get irq\n");
-		return irq;
+		ret = irq;
+		goto i2c_release;
 	}
 
 	ret = devm_request_threaded_irq(dev, irq, NULL,
@@ -634,7 +639,7 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 					"imx-tve", tve);
 	if (ret < 0) {
 		dev_err(dev, "failed to request irq: %d\n", ret);
-		return ret;
+		goto i2c_release;
 	}
 
 	tve->dac_reg = devm_regulator_get(dev, "dac");
@@ -642,14 +647,15 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 		regulator_set_voltage(tve->dac_reg, 2750000, 2750000);
 		ret = regulator_enable(tve->dac_reg);
 		if (ret)
-			return ret;
+			goto i2c_release;
 	}
 
 	tve->clk = devm_clk_get(dev, "tve");
 	if (IS_ERR(tve->clk)) {
 		dev_err(dev, "failed to get high speed tve clock: %ld\n",
 			PTR_ERR(tve->clk));
-		return PTR_ERR(tve->clk);
+		ret = PTR_ERR(tve->clk);
+		goto regulator_release;
 	}
 
 	/* this is the IPU DI clock input selector, can be parented to tve_di */
@@ -657,36 +663,48 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 	if (IS_ERR(tve->di_sel_clk)) {
 		dev_err(dev, "failed to get ipu di mux clock: %ld\n",
 			PTR_ERR(tve->di_sel_clk));
-		return PTR_ERR(tve->di_sel_clk);
+		ret = PTR_ERR(tve->di_sel_clk);
+		goto regulator_release;
 	}
 
 	ret = tve_clk_init(tve, base);
 	if (ret < 0)
-		return ret;
+		goto regulator_release;
 
 	ret = regmap_read(tve->regmap, TVE_COM_CONF_REG, &val);
 	if (ret < 0) {
 		dev_err(dev, "failed to read configuration register: %d\n",
 			ret);
-		return ret;
+		goto regulator_release;
 	}
 	if (val != 0x00100000) {
-		dev_err(dev, "configuration register default value indicates this is not a TVEv2\n");
-		return -ENODEV;
+		dev_err(dev,
+			"configuration register default value indicates this is not a TVEv2\n");
+		ret = -ENODEV;
+		goto regulator_release;
 	}
 
 	/* disable cable detection for VGA mode */
 	ret = regmap_write(tve->regmap, TVE_CD_CONT_REG, 0);
 	if (ret)
-		return ret;
+		goto regulator_release;
 
 	ret = imx_tve_register(drm, tve);
 	if (ret)
-		return ret;
+		goto regulator_release;
 
 	dev_set_drvdata(dev, tve);
 
 	return 0;
+
+ regulator_release:
+	if (!IS_ERR(tve->dac_reg))
+		regulator_disable(tve->dac_reg);
+
+ i2c_release:
+	i2c_put_adapter(tve->ddc);
+
+	return ret;
 }
 
 static void imx_tve_unbind(struct device *dev, struct device *master,
@@ -699,6 +717,8 @@ static void imx_tve_unbind(struct device *dev, struct device *master,
 
 	if (!IS_ERR(tve->dac_reg))
 		regulator_disable(tve->dac_reg);
+
+	i2c_put_adapter(tve->ddc);
 }
 
 static const struct component_ops imx_tve_ops = {
-- 
2.1.4
