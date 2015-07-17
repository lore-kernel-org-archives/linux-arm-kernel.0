From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri, 17 Jul 2015 13:45:09 +0200
Subject: [PATCH 1/2] drm: sti: fix sub-components bind
Message-ID: <1437133510-13615-1-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix misunderstanding in how use component framework.
drm_platform_init() is now call only when all the
sub-components are register themselves instead of the
previous broken two stages mechanism.

Update bindings documentation.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 .../devicetree/bindings/gpu/st,stih4xx.txt         | 72 +++++++++++-----------
 drivers/gpu/drm/sti/sti_drm_drv.c                  | 45 ++------------
 drivers/gpu/drm/sti/sti_hdmi.c                     | 25 ++++----
 drivers/gpu/drm/sti/sti_tvout.c                    | 46 ++------------
 4 files changed, 57 insertions(+), 131 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/st,stih4xx.txt b/Documentation/devicetree/bindings/gpu/st,stih4xx.txt
index 6b1d75f..a36dfce 100644
--- a/Documentation/devicetree/bindings/gpu/st,stih4xx.txt
+++ b/Documentation/devicetree/bindings/gpu/st,stih4xx.txt
@@ -52,10 +52,9 @@ STMicroelectronics stih4xx platforms
     See ../reset/reset.txt for details.
   - reset-names: names of the resets listed in resets property in the same
     order.
-  - ranges: to allow probing of subdevices
 
 - sti-hdmi: hdmi output block
-  must be a child of sti-tvout
+  must be a child of sti-display-subsystem
   Required properties:
   - compatible: "st,stih<chip>-hdmi";
   - reg: Physical base address of the IP registers and length of memory mapped region.
@@ -72,7 +71,7 @@ STMicroelectronics stih4xx platforms
 
 sti-hda:
   Required properties:
-  must be a child of sti-tvout
+  must be a child of sti-display-subsystem
   - compatible: "st,stih<chip>-hda"
   - reg: Physical base address of the IP registers and length of memory mapped region.
   - reg-names: names of the mapped memory regions listed in regs property in
@@ -85,7 +84,7 @@ sti-hda:
 
 sti-dvo:
   Required properties:
-  must be a child of sti-tvout
+  must be a child of sti-display-subsystem
   - compatible: "st,stih<chip>-dvo"
   - reg: Physical base address of the IP registers and length of memory mapped region.
   - reg-names: names of the mapped memory regions listed in regs property in
@@ -195,38 +194,37 @@ Example:
 			reg-names	= "tvout-reg", "hda-reg", "syscfg";
 			reset-names     = "tvout";
 			resets          = <&softreset STIH416_HDTVOUT_SOFTRESET>;
-			ranges;
-
-			sti-hdmi at fe85c000 {
-				compatible	= "st,stih416-hdmi";
-				reg		= <0xfe85c000 0x1000>, <0xfe830000 0x10000>;
-				reg-names	= "hdmi-reg", "syscfg";
-				interrupts	= <GIC_SPI 173 IRQ_TYPE_NONE>;
-				interrupt-names	= "irq";
-				clock-names	= "pix", "tmds", "phy", "audio";
-				clocks          = <&clockgen_c_vcc CLK_S_PIX_HDMI>, <&clockgen_c_vcc CLK_S_TMDS_HDMI>, <&clockgen_c_vcc CLK_S_HDMI_REJECT_PLL>, <&clockgen_b1 CLK_S_PCM_0>;
-			};
-
-			sti-hda at fe85a000 {
-				compatible	= "st,stih416-hda";
-				reg		= <0xfe85a000 0x400>, <0xfe83085c 0x4>;
-				reg-names	= "hda-reg", "video-dacs-ctrl";
-				clock-names	= "pix", "hddac";
-				clocks          = <&clockgen_c_vcc CLK_S_PIX_HD>, <&clockgen_c_vcc CLK_S_HDDAC>;
-			};
-
-			sti-dvo at 8d00400 {
-				compatible	= "st,stih407-dvo";
-				reg		= <0x8d00400 0x200>;
-				reg-names	= "dvo-reg";
-				clock-names	= "dvo_pix", "dvo",
-						  "main_parent", "aux_parent";
-				clocks		= <&clk_s_d2_flexgen CLK_PIX_DVO>, <&clk_s_d2_flexgen CLK_DVO>,
-						  <&clk_s_d2_quadfs 0>, <&clk_s_d2_quadfs 1>;
-				pinctrl-names	= "default";
-				pinctrl-0	= <&pinctrl_dvo>;
-				sti,panel	= <&panel_dvo>;
-			};
+		};
+
+		sti-hdmi at fe85c000 {
+			compatible	= "st,stih416-hdmi";
+			reg		= <0xfe85c000 0x1000>, <0xfe830000 0x10000>;
+			reg-names	= "hdmi-reg", "syscfg";
+			interrupts	= <GIC_SPI 173 IRQ_TYPE_NONE>;
+			interrupt-names	= "irq";
+			clock-names	= "pix", "tmds", "phy", "audio";
+			clocks          = <&clockgen_c_vcc CLK_S_PIX_HDMI>, <&clockgen_c_vcc CLK_S_TMDS_HDMI>, <&clockgen_c_vcc CLK_S_HDMI_REJECT_PLL>, <&clockgen_b1 CLK_S_PCM_0>;
+		};
+
+		sti-hda at fe85a000 {
+			compatible	= "st,stih416-hda";
+			reg		= <0xfe85a000 0x400>, <0xfe83085c 0x4>;
+			reg-names	= "hda-reg", "video-dacs-ctrl";
+			clock-names	= "pix", "hddac";
+			clocks          = <&clockgen_c_vcc CLK_S_PIX_HD>, <&clockgen_c_vcc CLK_S_HDDAC>;
+		};
+
+		sti-dvo at 8d00400 {
+			compatible	= "st,stih407-dvo";
+			reg		= <0x8d00400 0x200>;
+			reg-names	= "dvo-reg";
+			clock-names	= "dvo_pix", "dvo",
+					  "main_parent", "aux_parent";
+			clocks		= <&clk_s_d2_flexgen CLK_PIX_DVO>, <&clk_s_d2_flexgen CLK_DVO>,
+					  <&clk_s_d2_quadfs 0>, <&clk_s_d2_quadfs 1>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_dvo>;
+			sti,panel	= <&panel_dvo>;
 		};
 
 		sti-hqvdp at 9c000000 {
@@ -237,7 +235,7 @@ Example:
 				reset-names     = "hqvdp";
 				resets          = <&softreset STIH407_HDQVDP_SOFTRESET>;
 				st,vtg		= <&vtg_main>;
-			};
+		};
 	};
 	...
 };
diff --git a/drivers/gpu/drm/sti/sti_drm_drv.c b/drivers/gpu/drm/sti/sti_drm_drv.c
index d0fb54a..60be6cd 100644
--- a/drivers/gpu/drm/sti/sti_drm_drv.c
+++ b/drivers/gpu/drm/sti/sti_drm_drv.c
@@ -245,15 +245,17 @@ static const struct component_master_ops sti_drm_ops = {
 	.unbind = sti_drm_unbind,
 };
 
-static int sti_drm_master_probe(struct platform_device *pdev)
+static int sti_drm_platform_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
+	struct device_node *node = dev->of_node;
 	struct device_node *child_np;
 	struct component_match *match = NULL;
 
 	dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
 
+	of_platform_populate(node, NULL, NULL, dev);
+
 	child_np = of_get_next_available_child(node, NULL);
 
 	while (child_np) {
@@ -265,46 +267,11 @@ static int sti_drm_master_probe(struct platform_device *pdev)
 	return component_master_add_with_match(dev, &sti_drm_ops, match);
 }
 
-static int sti_drm_master_remove(struct platform_device *pdev)
-{
-	component_master_del(&pdev->dev, &sti_drm_ops);
-	return 0;
-}
-
-static struct platform_driver sti_drm_master_driver = {
-	.probe = sti_drm_master_probe,
-	.remove = sti_drm_master_remove,
-	.driver = {
-		.name = DRIVER_NAME "__master",
-	},
-};
-
-static int sti_drm_platform_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->of_node;
-	struct platform_device *master;
-
-	of_platform_populate(node, NULL, NULL, dev);
-
-	platform_driver_register(&sti_drm_master_driver);
-	master = platform_device_register_resndata(dev,
-			DRIVER_NAME "__master", -1,
-			NULL, 0, NULL, 0);
-	if (IS_ERR(master))
-               return PTR_ERR(master);
-
-	platform_set_drvdata(pdev, master);
-	return 0;
-}
-
 static int sti_drm_platform_remove(struct platform_device *pdev)
 {
-	struct platform_device *master = platform_get_drvdata(pdev);
-
+	component_master_del(&pdev->dev, &sti_drm_ops);
 	of_platform_depopulate(&pdev->dev);
-	platform_device_unregister(master);
-	platform_driver_unregister(&sti_drm_master_driver);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index f28a4d5..06595e9 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -693,21 +693,8 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 	struct sti_hdmi_connector *connector;
 	struct drm_connector *drm_connector;
 	struct drm_bridge *bridge;
-	struct device_node *ddc;
 	int err;
 
-	ddc = of_parse_phandle(dev->of_node, "ddc", 0);
-	if (ddc) {
-		hdmi->ddc_adapt = of_find_i2c_adapter_by_node(ddc);
-		if (!hdmi->ddc_adapt) {
-			err = -EPROBE_DEFER;
-			of_node_put(ddc);
-			return err;
-		}
-
-		of_node_put(ddc);
-	}
-
 	/* Set the drm device handle */
 	hdmi->drm_dev = drm_dev;
 
@@ -796,6 +783,7 @@ static int sti_hdmi_probe(struct platform_device *pdev)
 	struct sti_hdmi *hdmi;
 	struct device_node *np = dev->of_node;
 	struct resource *res;
+	struct device_node *ddc;
 	int ret;
 
 	DRM_INFO("%s\n", __func__);
@@ -804,6 +792,17 @@ static int sti_hdmi_probe(struct platform_device *pdev)
 	if (!hdmi)
 		return -ENOMEM;
 
+	ddc = of_parse_phandle(pdev->dev.of_node, "ddc", 0);
+	if (ddc) {
+		hdmi->ddc_adapt = of_find_i2c_adapter_by_node(ddc);
+		if (!hdmi->ddc_adapt) {
+			of_node_put(ddc);
+			return -EPROBE_DEFER;
+		}
+
+		of_node_put(ddc);
+	}
+
 	hdmi->dev = pdev->dev;
 
 	/* Get resources */
diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti_tvout.c
index 5cc5311..576b5be 100644
--- a/drivers/gpu/drm/sti/sti_tvout.c
+++ b/drivers/gpu/drm/sti/sti_tvout.c
@@ -644,7 +644,6 @@ static int sti_tvout_bind(struct device *dev, struct device *master, void *data)
 	struct sti_tvout *tvout = dev_get_drvdata(dev);
 	struct drm_device *drm_dev = data;
 	unsigned int i;
-	int ret;
 
 	tvout->drm_dev = drm_dev;
 
@@ -658,17 +657,15 @@ static int sti_tvout_bind(struct device *dev, struct device *master, void *data)
 
 	sti_tvout_create_encoders(drm_dev, tvout);
 
-	ret = component_bind_all(dev, drm_dev);
-	if (ret)
-		sti_tvout_destroy_encoders(tvout);
-
-	return ret;
+	return 0;
 }
 
 static void sti_tvout_unbind(struct device *dev, struct device *master,
 	void *data)
 {
-	/* do nothing */
+	struct sti_tvout *tvout = dev_get_drvdata(dev);
+
+	sti_tvout_destroy_encoders(tvout);
 }
 
 static const struct component_ops sti_tvout_ops = {
@@ -676,34 +673,12 @@ static const struct component_ops sti_tvout_ops = {
 	.unbind	= sti_tvout_unbind,
 };
 
-static int compare_of(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
-static int sti_tvout_master_bind(struct device *dev)
-{
-	return 0;
-}
-
-static void sti_tvout_master_unbind(struct device *dev)
-{
-	/* do nothing */
-}
-
-static const struct component_master_ops sti_tvout_master_ops = {
-	.bind = sti_tvout_master_bind,
-	.unbind = sti_tvout_master_unbind,
-};
-
 static int sti_tvout_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct sti_tvout *tvout;
 	struct resource *res;
-	struct device_node *child_np;
-	struct component_match *match = NULL;
 
 	DRM_INFO("%s\n", __func__);
 
@@ -734,24 +709,11 @@ static int sti_tvout_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tvout);
 
-	of_platform_populate(node, NULL, NULL, dev);
-
-	child_np = of_get_next_available_child(node, NULL);
-
-	while (child_np) {
-		component_match_add(dev, &match, compare_of, child_np);
-		of_node_put(child_np);
-		child_np = of_get_next_available_child(node, child_np);
-	}
-
-	component_master_add_with_match(dev, &sti_tvout_master_ops, match);
-
 	return component_add(dev, &sti_tvout_ops);
 }
 
 static int sti_tvout_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &sti_tvout_master_ops);
 	component_del(&pdev->dev, &sti_tvout_ops);
 	return 0;
 }
-- 
1.9.1
