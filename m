From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:28:03 +0000
Subject: [PATCH RFC 27/46] imx-drm: convert to componentised device support
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1VypoB-0007FJ-PA@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the componentised device support for imx-drm.  This requires all
the sub-components and the master device to register with the component
device support.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx51-babbage.dts        |   10 ++-
 arch/arm/boot/dts/imx53-m53evk.dts         |    8 ++-
 arch/arm/boot/dts/imx53-mba53.dts          |    6 ++
 arch/arm/boot/dts/imx53-qsb.dts            |    8 ++-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi     |    6 ++
 drivers/staging/imx-drm/imx-drm-core.c     |  105 ++++++++++++++++++++++-----
 drivers/staging/imx-drm/imx-ldb.c          |   40 ++++++++---
 drivers/staging/imx-drm/imx-tve.c          |   63 +++++++++++------
 drivers/staging/imx-drm/ipuv3-crtc.c       |   46 +++++++++----
 drivers/staging/imx-drm/parallel-display.c |   30 ++++++--
 10 files changed, 242 insertions(+), 80 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index be1407cf5abd..6ff15a0eacb3 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -21,7 +21,7 @@
 		reg = <0x90000000 0x20000000>;
 	};
 
-	display at di0 {
+	display0: display at di0 {
 		compatible = "fsl,imx-parallel-display";
 		crtcs = <&ipu 0>;
 		interface-pix-fmt = "rgb24";
@@ -43,7 +43,7 @@
 		};
 	};
 
-	display at di1 {
+	display1: display at di1 {
 		compatible = "fsl,imx-parallel-display";
 		crtcs = <&ipu 1>;
 		interface-pix-fmt = "rgb565";
@@ -81,6 +81,12 @@
 		};
 	};
 
+	imx-drm {
+		compatible = "fsl,imx-drm";
+		crtcs = <&ipu 0>, <&ipu 1>;
+		connectors = <&display0>, <&display1>;
+	};
+
 	sound {
 		compatible = "fsl,imx51-babbage-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index 7d304d02ed38..ee6107b6484c 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -21,7 +21,7 @@
 	};
 
 	soc {
-		display at di1 {
+		display1: display at di1 {
 			compatible = "fsl,imx-parallel-display";
 			crtcs = <&ipu 1>;
 			interface-pix-fmt = "bgr666";
@@ -53,6 +53,12 @@
 		default-brightness-level = <6>;
 	};
 
+	imx-drm {
+		compatible = "fsl,imx-drm";
+		crtcs = <&ipu 1>;
+		connectors = <&display1>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index a63090267941..9b6e76980a74 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -43,6 +43,12 @@
 		status = "disabled";
 	};
 
+	imx-drm {
+		compatible = "fsl,imx-drm";
+		crtcs = <&ipu 1>;
+		connectors = <&disp1>, <&tve>;
+	};
+
 	reg_3p2v: 3p2v {
 		compatible = "regulator-fixed";
 		regulator-name = "3P2V";
diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index 91a5935a4aac..3cb4f7791a91 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -21,7 +21,7 @@
 		reg = <0x70000000 0x40000000>;
 	};
 
-	display at di0 {
+	display0: display at di0 {
 		compatible = "fsl,imx-parallel-display";
 		crtcs = <&ipu 0>;
 		interface-pix-fmt = "rgb565";
@@ -72,6 +72,12 @@
 		};
 	};
 
+	imx-drm {
+		compatible = "fsl,imx-drm";
+		crtcs = <&ipu 0>;
+		connectors = <&display0>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index e75e11b36dff..0e005f21d241 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -62,6 +62,12 @@
 		};
 	};
 
+	imx-drm {
+		compatible = "fsl,imx-drm";
+		crtcs = <&ipu1 0>, <&ipu1 1>;
+		connectors = <&ldb>;
+	};
+
 	sound {
 		compatible = "fsl,imx6q-sabresd-wm8962",
 			   "fsl,imx-audio-wm8962";
diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 839dbb7c7b36..8ece15944569 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -13,7 +13,7 @@
  * GNU General Public License for more details.
  *
  */
-
+#include <linux/component.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <drm/drmP.h>
@@ -90,6 +90,8 @@ static int imx_drm_driver_unload(struct drm_device *drm)
 {
 	struct imx_drm_device *imxdrm = drm->dev_private;
 
+	component_unbind_all(drm->dev, drm);
+
 	imx_drm_device_put();
 
 	drm_vblank_cleanup(drm);
@@ -371,11 +373,8 @@ static void imx_drm_connector_unregister(
 }
 
 /*
- * Called by the CRTC driver when all CRTCs are registered. This
- * puts all the pieces together and initializes the driver.
- * Once this is called no more CRTCs can be registered since
- * the drm core has hardcoded the number of crtcs in several
- * places.
+ * Main DRM initialisation. This binds, initialises and registers
+ * with DRM the subcomponents of the driver.
  */
 static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
 {
@@ -427,8 +426,15 @@ static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
 	}
 
 	mutex_unlock(&imxdrm->mutex);
+
+	/* Now try and bind all our sub-components */
+	ret = component_bind_all(drm->dev, drm);
+	if (ret)
+		goto err_relock;
 	return 0;
 
+err_relock:
+	mutex_lock(&imxdrm->mutex);
 err_vblank:
 	drm_vblank_cleanup(drm);
 err_kms:
@@ -808,6 +814,70 @@ static struct drm_driver imx_drm_driver = {
 	.patchlevel		= 0,
 };
 
+static int compare_parent_of(struct device *dev, void *data)
+{
+	struct of_phandle_args *args = data;
+	return dev->parent && dev->parent->of_node == args->np;
+}
+
+static int compare_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static int imx_drm_add_components(struct device *master, struct master *m)
+{
+	struct device_node *np = master->of_node;
+	unsigned i;
+	int ret;
+
+	for (i = 0; ; i++) {
+		struct of_phandle_args args;
+
+		ret = of_parse_phandle_with_fixed_args(np, "crtcs", 1,
+						       i, &args);
+		if (ret)
+			break;
+
+		ret = component_master_add_child(m, compare_parent_of, &args);
+		of_node_put(args.np);
+
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; ; i++) {
+		struct device_node *node;
+
+		node = of_parse_phandle(np, "connectors", i);
+		if (!node)
+			break;
+
+		ret = component_master_add_child(m, compare_of, node);
+		of_node_put(node);
+
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int imx_drm_bind(struct device *dev)
+{
+	return drm_platform_init(&imx_drm_driver, to_platform_device(dev));
+}
+
+static void imx_drm_unbind(struct device *dev)
+{
+	drm_platform_exit(&imx_drm_driver, to_platform_device(dev));
+}
+
+static const struct component_master_ops imx_drm_ops = {
+	.add_components = imx_drm_add_components,
+	.bind = imx_drm_bind,
+	.unbind = imx_drm_unbind,
+};
+
 static int imx_drm_platform_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -818,27 +888,31 @@ static int imx_drm_platform_probe(struct platform_device *pdev)
 
 	imx_drm_device->dev = &pdev->dev;
 
-	return drm_platform_init(&imx_drm_driver, pdev);
+	return component_master_add(&pdev->dev, &imx_drm_ops);
 }
 
 static int imx_drm_platform_remove(struct platform_device *pdev)
 {
-	drm_platform_exit(&imx_drm_driver, pdev);
-
+	component_master_del(&pdev->dev, &imx_drm_ops);
 	return 0;
 }
 
+static const struct of_device_id imx_drm_dt_ids[] = {
+	{ .compatible = "fsl,imx-drm", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, imx_drm_dt_ids);
+
 static struct platform_driver imx_drm_pdrv = {
 	.probe		= imx_drm_platform_probe,
 	.remove		= imx_drm_platform_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "imx-drm",
+		.of_match_table = imx_drm_dt_ids,
 	},
 };
 
-static struct platform_device *imx_drm_pdev;
-
 static int __init imx_drm_init(void)
 {
 	int ret;
@@ -851,12 +925,6 @@ static int __init imx_drm_init(void)
 	INIT_LIST_HEAD(&imx_drm_device->connector_list);
 	INIT_LIST_HEAD(&imx_drm_device->encoder_list);
 
-	imx_drm_pdev = platform_device_register_simple("imx-drm", -1, NULL, 0);
-	if (IS_ERR(imx_drm_pdev)) {
-		ret = PTR_ERR(imx_drm_pdev);
-		goto err_pdev;
-	}
-
 	ret = platform_driver_register(&imx_drm_pdrv);
 	if (ret)
 		goto err_pdrv;
@@ -864,8 +932,6 @@ static int __init imx_drm_init(void)
 	return 0;
 
 err_pdrv:
-	platform_device_unregister(imx_drm_pdev);
-err_pdev:
 	kfree(imx_drm_device);
 
 	return ret;
@@ -873,7 +939,6 @@ static int __init imx_drm_init(void)
 
 static void __exit imx_drm_exit(void)
 {
-	platform_device_unregister(imx_drm_pdev);
 	platform_driver_unregister(&imx_drm_pdrv);
 
 	kfree(imx_drm_device);
diff --git a/drivers/staging/imx-drm/imx-ldb.c b/drivers/staging/imx-drm/imx-ldb.c
index 70455c4d7e48..5b71f49faa0a 100644
--- a/drivers/staging/imx-drm/imx-ldb.c
+++ b/drivers/staging/imx-drm/imx-ldb.c
@@ -20,6 +20,7 @@
 
 #include <linux/module.h>
 #include <linux/clk.h>
+#include <linux/component.h>
 #include <drm/drmP.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
@@ -451,11 +452,11 @@ static const struct of_device_id imx_ldb_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, imx_ldb_dt_ids);
 
-static int imx_ldb_probe(struct platform_device *pdev)
+static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	const struct of_device_id *of_id =
-			of_match_device(imx_ldb_dt_ids, &pdev->dev);
+			of_match_device(imx_ldb_dt_ids, dev);
 	struct device_node *child;
 	const u8 *edidp;
 	struct imx_ldb *imx_ldb;
@@ -465,17 +466,17 @@ static int imx_ldb_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
-	imx_ldb = devm_kzalloc(&pdev->dev, sizeof(*imx_ldb), GFP_KERNEL);
+	imx_ldb = devm_kzalloc(dev, sizeof(*imx_ldb), GFP_KERNEL);
 	if (!imx_ldb)
 		return -ENOMEM;
 
 	imx_ldb->regmap = syscon_regmap_lookup_by_phandle(np, "gpr");
 	if (IS_ERR(imx_ldb->regmap)) {
-		dev_err(&pdev->dev, "failed to get parent regmap\n");
+		dev_err(dev, "failed to get parent regmap\n");
 		return PTR_ERR(imx_ldb->regmap);
 	}
 
-	imx_ldb->dev = &pdev->dev;
+	imx_ldb->dev = dev;
 
 	if (of_id)
 		imx_ldb->lvds_mux = of_id->data;
@@ -513,7 +514,7 @@ static int imx_ldb_probe(struct platform_device *pdev)
 			return -EINVAL;
 
 		if (dual && i > 0) {
-			dev_warn(&pdev->dev, "dual-channel mode, ignoring second output\n");
+			dev_warn(dev, "dual-channel mode, ignoring second output\n");
 			continue;
 		}
 
@@ -552,7 +553,7 @@ static int imx_ldb_probe(struct platform_device *pdev)
 			break;
 		case LVDS_BIT_MAP_JEIDA:
 			if (datawidth == 18) {
-				dev_err(&pdev->dev, "JEIDA standard only supported in 24 bit\n");
+				dev_err(dev, "JEIDA standard only supported in 24 bit\n");
 				return -EINVAL;
 			}
 			if (i == 0 || dual)
@@ -561,7 +562,7 @@ static int imx_ldb_probe(struct platform_device *pdev)
 				imx_ldb->ldb_ctrl |= LDB_DATA_WIDTH_CH1_24 | LDB_BIT_MAP_CH1_JEIDA;
 			break;
 		default:
-			dev_err(&pdev->dev, "data mapping not specified or invalid\n");
+			dev_err(dev, "data mapping not specified or invalid\n");
 			return -EINVAL;
 		}
 
@@ -572,14 +573,15 @@ static int imx_ldb_probe(struct platform_device *pdev)
 		imx_drm_encoder_add_possible_crtcs(channel->imx_drm_encoder, child);
 	}
 
-	platform_set_drvdata(pdev, imx_ldb);
+	dev_set_drvdata(dev, imx_ldb);
 
 	return 0;
 }
 
-static int imx_ldb_remove(struct platform_device *pdev)
+static void imx_ldb_unbind(struct device *dev, struct device *master,
+	void *data)
 {
-	struct imx_ldb *imx_ldb = platform_get_drvdata(pdev);
+	struct imx_ldb *imx_ldb = dev_get_drvdata(dev);
 	int i;
 
 	for (i = 0; i < 2; i++) {
@@ -592,7 +594,21 @@ static int imx_ldb_remove(struct platform_device *pdev)
 		imx_drm_remove_connector(channel->imx_drm_connector);
 		imx_drm_remove_encoder(channel->imx_drm_encoder);
 	}
+}
 
+static const struct component_ops imx_ldb_ops = {
+	.bind	= imx_ldb_bind,
+	.unbind	= imx_ldb_unbind,
+};
+
+static int imx_ldb_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &imx_ldb_ops);
+}
+
+static int imx_ldb_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &imx_ldb_ops);
 	return 0;
 }
 
diff --git a/drivers/staging/imx-drm/imx-tve.c b/drivers/staging/imx-drm/imx-tve.c
index b2f214971501..f8720f1ef86e 100644
--- a/drivers/staging/imx-drm/imx-tve.c
+++ b/drivers/staging/imx-drm/imx-tve.c
@@ -20,6 +20,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/component.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
@@ -583,9 +584,10 @@ const int of_get_tve_mode(struct device_node *np)
 	return -EINVAL;
 }
 
-static int imx_tve_probe(struct platform_device *pdev)
+static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct device_node *np = dev->of_node;
 	struct device_node *ddc_node;
 	struct imx_tve *tve;
 	struct resource *res;
@@ -594,11 +596,11 @@ static int imx_tve_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	tve = devm_kzalloc(&pdev->dev, sizeof(*tve), GFP_KERNEL);
+	tve = devm_kzalloc(dev, sizeof(*tve), GFP_KERNEL);
 	if (!tve)
 		return -ENOMEM;
 
-	tve->dev = &pdev->dev;
+	tve->dev = dev;
 	spin_lock_init(&tve->lock);
 
 	ddc_node = of_parse_phandle(np, "ddc", 0);
@@ -609,7 +611,7 @@ static int imx_tve_probe(struct platform_device *pdev)
 
 	tve->mode = of_get_tve_mode(np);
 	if (tve->mode != TVE_MODE_VGA) {
-		dev_err(&pdev->dev, "only VGA mode supported, currently\n");
+		dev_err(dev, "only VGA mode supported, currently\n");
 		return -EINVAL;
 	}
 
@@ -618,7 +620,7 @@ static int imx_tve_probe(struct platform_device *pdev)
 					   &tve->hsync_pin);
 
 		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to get vsync pin\n");
+			dev_err(dev, "failed to get vsync pin\n");
 			return ret;
 		}
 
@@ -626,40 +628,40 @@ static int imx_tve_probe(struct platform_device *pdev)
 					    &tve->vsync_pin);
 
 		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to get vsync pin\n");
+			dev_err(dev, "failed to get vsync pin\n");
 			return ret;
 		}
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
 	tve_regmap_config.lock_arg = tve;
-	tve->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "tve", base,
+	tve->regmap = devm_regmap_init_mmio_clk(dev, "tve", base,
 						&tve_regmap_config);
 	if (IS_ERR(tve->regmap)) {
-		dev_err(&pdev->dev, "failed to init regmap: %ld\n",
+		dev_err(dev, "failed to init regmap: %ld\n",
 			PTR_ERR(tve->regmap));
 		return PTR_ERR(tve->regmap);
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
+		dev_err(dev, "failed to get irq\n");
 		return irq;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+	ret = devm_request_threaded_irq(dev, irq, NULL,
 					imx_tve_irq_handler, IRQF_ONESHOT,
 					"imx-tve", tve);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to request irq: %d\n", ret);
+		dev_err(dev, "failed to request irq: %d\n", ret);
 		return ret;
 	}
 
-	tve->dac_reg = devm_regulator_get(&pdev->dev, "dac");
+	tve->dac_reg = devm_regulator_get(dev, "dac");
 	if (!IS_ERR(tve->dac_reg)) {
 		regulator_set_voltage(tve->dac_reg, 2750000, 2750000);
 		ret = regulator_enable(tve->dac_reg);
@@ -667,17 +669,17 @@ static int imx_tve_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	tve->clk = devm_clk_get(&pdev->dev, "tve");
+	tve->clk = devm_clk_get(dev, "tve");
 	if (IS_ERR(tve->clk)) {
-		dev_err(&pdev->dev, "failed to get high speed tve clock: %ld\n",
+		dev_err(dev, "failed to get high speed tve clock: %ld\n",
 			PTR_ERR(tve->clk));
 		return PTR_ERR(tve->clk);
 	}
 
 	/* this is the IPU DI clock input selector, can be parented to tve_di */
-	tve->di_sel_clk = devm_clk_get(&pdev->dev, "di_sel");
+	tve->di_sel_clk = devm_clk_get(dev, "di_sel");
 	if (IS_ERR(tve->di_sel_clk)) {
-		dev_err(&pdev->dev, "failed to get ipu di mux clock: %ld\n",
+		dev_err(dev, "failed to get ipu di mux clock: %ld\n",
 			PTR_ERR(tve->di_sel_clk));
 		return PTR_ERR(tve->di_sel_clk);
 	}
@@ -688,11 +690,11 @@ static int imx_tve_probe(struct platform_device *pdev)
 
 	ret = regmap_read(tve->regmap, TVE_COM_CONF_REG, &val);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to read configuration register: %d\n", ret);
+		dev_err(dev, "failed to read configuration register: %d\n", ret);
 		return ret;
 	}
 	if (val != 0x00100000) {
-		dev_err(&pdev->dev, "configuration register default value indicates this is not a TVEv2\n");
+		dev_err(dev, "configuration register default value indicates this is not a TVEv2\n");
 		return -ENODEV;
 	}
 
@@ -705,14 +707,15 @@ static int imx_tve_probe(struct platform_device *pdev)
 
 	ret = imx_drm_encoder_add_possible_crtcs(tve->imx_drm_encoder, np);
 
-	platform_set_drvdata(pdev, tve);
+	dev_set_drvdata(dev, tve);
 
 	return 0;
 }
 
-static int imx_tve_remove(struct platform_device *pdev)
+static void imx_tve_unbind(struct device *dev, struct device *master,
+	void *data)
 {
-	struct imx_tve *tve = platform_get_drvdata(pdev);
+	struct imx_tve *tve = dev_get_drvdata(dev);
 	struct drm_connector *connector = &tve->connector;
 	struct drm_encoder *encoder = &tve->encoder;
 
@@ -723,7 +726,21 @@ static int imx_tve_remove(struct platform_device *pdev)
 
 	if (!IS_ERR(tve->dac_reg))
 		regulator_disable(tve->dac_reg);
+}
 
+static const struct component_ops imx_tve_ops = {
+	.bind	= imx_tve_bind,
+	.unbind	= imx_tve_unbind,
+};
+
+static int imx_tve_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &imx_tve_ops);
+}
+
+static int imx_tve_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &imx_tve_ops);
 	return 0;
 }
 
diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index 2bee6fa585f8..eb9653a5a887 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
  * MA 02110-1301, USA.
  */
+#include <linux/component.h>
 #include <linux/module.h>
 #include <linux/export.h>
 #include <linux/device.h>
@@ -399,43 +400,60 @@ static int ipu_crtc_init(struct ipu_crtc *ipu_crtc,
 	return ret;
 }
 
-static int ipu_drm_probe(struct platform_device *pdev)
+static int ipu_drm_bind(struct device *dev, struct device *master, void *data)
 {
-	struct ipu_client_platformdata *pdata = pdev->dev.platform_data;
+	struct ipu_client_platformdata *pdata = dev->platform_data;
 	struct ipu_crtc *ipu_crtc;
 	int ret;
 
-	if (!pdata)
-		return -EINVAL;
-
-	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-
-	ipu_crtc = devm_kzalloc(&pdev->dev, sizeof(*ipu_crtc), GFP_KERNEL);
+	ipu_crtc = devm_kzalloc(dev, sizeof(*ipu_crtc), GFP_KERNEL);
 	if (!ipu_crtc)
 		return -ENOMEM;
 
-	ipu_crtc->dev = &pdev->dev;
+	ipu_crtc->dev = dev;
 
 	ret = ipu_crtc_init(ipu_crtc, pdata);
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, ipu_crtc);
+	dev_set_drvdata(dev, ipu_crtc);
 
 	return 0;
 }
 
-static int ipu_drm_remove(struct platform_device *pdev)
+static void ipu_drm_unbind(struct device *dev, struct device *master,
+	void *data)
 {
-	struct ipu_crtc *ipu_crtc = platform_get_drvdata(pdev);
+	struct ipu_crtc *ipu_crtc = dev_get_drvdata(dev);
 
 	imx_drm_remove_crtc(ipu_crtc->imx_crtc);
 
 	ipu_plane_put_resources(ipu_crtc->plane[0]);
 	ipu_put_resources(ipu_crtc);
+}
+
+static const struct component_ops ipu_crtc_ops = {
+	.bind = ipu_drm_bind,
+	.unbind = ipu_drm_unbind,
+};
 
+static int ipu_drm_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	if (!pdev->dev.platform_data)
+		return -EINVAL;
+
+	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	return component_add(&pdev->dev, &ipu_crtc_ops);
+}
+
+static int ipu_drm_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &ipu_crtc_ops);
 	return 0;
 }
 
diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index 9ba9ca1aeb67..110c0021a797 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -18,6 +18,7 @@
  * MA 02110-1301, USA.
  */
 
+#include <linux/component.h>
 #include <linux/module.h>
 #include <drm/drmP.h>
 #include <drm/drm_fb_helper.h>
@@ -191,15 +192,15 @@ static int imx_pd_register(struct imx_parallel_display *imxpd)
 	return 0;
 }
 
-static int imx_pd_probe(struct platform_device *pdev)
+static int imx_pd_bind(struct device *dev, struct device *master, void *data)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	const u8 *edidp;
 	struct imx_parallel_display *imxpd;
 	int ret;
 	const char *fmt;
 
-	imxpd = devm_kzalloc(&pdev->dev, sizeof(*imxpd), GFP_KERNEL);
+	imxpd = devm_kzalloc(dev, sizeof(*imxpd), GFP_KERNEL);
 	if (!imxpd)
 		return -ENOMEM;
 
@@ -217,7 +218,7 @@ static int imx_pd_probe(struct platform_device *pdev)
 			imxpd->interface_pix_fmt = V4L2_PIX_FMT_BGR666;
 	}
 
-	imxpd->dev = &pdev->dev;
+	imxpd->dev = dev;
 
 	ret = imx_pd_register(imxpd);
 	if (ret)
@@ -225,14 +226,15 @@ static int imx_pd_probe(struct platform_device *pdev)
 
 	ret = imx_drm_encoder_add_possible_crtcs(imxpd->imx_drm_encoder, np);
 
-	platform_set_drvdata(pdev, imxpd);
+	dev_set_drvdata(dev, imxpd);
 
 	return 0;
 }
 
-static int imx_pd_remove(struct platform_device *pdev)
+static void imx_pd_unbind(struct device *dev, struct device *master,
+	void *data)
 {
-	struct imx_parallel_display *imxpd = platform_get_drvdata(pdev);
+	struct imx_parallel_display *imxpd = dev_get_drvdata(dev);
 	struct drm_connector *connector = &imxpd->connector;
 	struct drm_encoder *encoder = &imxpd->encoder;
 
@@ -240,7 +242,21 @@ static int imx_pd_remove(struct platform_device *pdev)
 
 	imx_drm_remove_connector(imxpd->imx_drm_connector);
 	imx_drm_remove_encoder(imxpd->imx_drm_encoder);
+}
 
+static const struct component_ops imx_pd_ops = {
+	.bind	= imx_pd_bind,
+	.unbind	= imx_pd_unbind,
+};
+
+static int imx_pd_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &imx_pd_ops);
+}
+
+static int imx_pd_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &imx_pd_ops);
 	return 0;
 }
 
-- 
1.7.4.4
