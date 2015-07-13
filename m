From: Jianwei.Wang@freescale.com (Wang J.W.)
Date: Mon, 13 Jul 2015 10:25:22 +0000
Subject: [PATCH v8 1/4] drm/layerscape: Add Freescale DCU DRM driver
In-Reply-To: <55A36F39.1060109@rock-chips.com>
References: <1436767211-38571-1-git-send-email-jianwei.wang@freescale.com>
 <55A36F39.1060109@rock-chips.com>
Message-ID: <DM2PR0301MB1229C10ECFC6A9D8CF3BA5FF9F9C0@DM2PR0301MB1229.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Many thanks! I'll update according your comments!

From: Mark yao [mailto:mark.yao at rock-chips.com] 
Sent: Monday, July 13, 2015 3:57 PM
To: Wang Jianwei-B52261; dri-devel at lists.freedesktop.org
Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; airlied at linux.ie; daniel.vetter at ffwll.ch; Wood Scott-B07421; thierry.reding at gmail.com; Wang Huan-B18965; Xiubo Li
Subject: Re: [PATCH v8 1/4] drm/layerscape: Add Freescale DCU DRM driver

On 2015?07?13? 14:00, Jianwei Wang wrote:
This patch add support for Two Dimensional Animation and Compositing
Engine (2D-ACE) on the Freescale SoCs.

2D-ACE is a Freescale display controller. 2D-ACE describes
the functionality of the module extremely well its name is a value
that cannot be used as a token in programming languages.
Instead the valid token "DCU" is used to tag the register names and
function names.

The Display Controller Unit (DCU) module is a system master that
fetches graphics stored in internal or external memory and displays
them on a TFT LCD panel. A wide range of panel sizes is supported
and the timing of the interface signals is highly configurable.
Graphics are read directly from memory and then blended in real-time,
which allows for dynamic content creation with minimal CPU
intervention.

The features:
(1) Full RGB888 output to TFT LCD panel.
(2) For the current LCD panel, WQVGA "480x272" is supported.
(3) Blending of each pixel using up to 4 source layers
dependent on size of panel.
(4) Each graphic layer can be placed with one pixel resolution
in either axis.
(5) Each graphic layer support RGB565 and RGB888 direct colors
without alpha
channel and BGRA8888 BGRA4444 ARGB1555 direct colors with an
alpha channel and YUV422 format.
(6) Each graphic layer support alpha blending with 8-bit
resolution.

This is a simplified version, only one primary plane, one
framebuffer, one crtc, one connector and one encoder for TFT LCD panel.

Signed-off-by: Alison Wang <b18965@freescale.com>
Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Jianwei Wang <jianwei.wang@freescale.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Alison Wang <alison.wang@freescale.com>
---


hanged in V8
- Remove useless code
  #define DRIVER_NAME     "fsl-dcu-drm"
  MODULE_ALIAS("platform:fsl-dcu-drm");
Adviced by Paul Bolle

Changed in V7

- Remove redundant functions and replace deprecated hooker
Adviced by Daniel Vetter
- Replace drm_platform_init with drm_dev_alloc/register
Adviced by Daniel Vetter

Changed in V6

- Add NEC nl4827hc19_05b panel to panel-simple.c
Adviced by Mark Yao
- Add DRIVER_ATOMIC for driver_features
Adviced by Mark Yao
- check fsl_dev if it's NULL at PM suspend/resume
Adviced by Mark Yao

Changed in V5

- Update commit message
- Add layer registers initialization
- Remove unused functions
- Rename driver folder
Adviced by Stefan Agner
- Move pixel clock control functions to fsl_dcu_drm_drv.c
- remove redundant enable the clock implicitly using regmap
Adviced by Stefan Agner
- Add maintainer message

Changed in V4:

-This version doesn't have functionality changed
 Just a minor adjustment.

Changed in V3:

- Test driver on Vybrid board and add compatible string
- Remove unused functions
- set default crtc for encoder
- replace legacy functions with atomic help functions
Adviced by Daniel Vetter
- Set the unique name of the DRM device
- Implement irq handle function for vblank interrupt

Changed in v2: 
- Add atomic support
Adviced by Daniel Vetter
- Modify bindings file
- Rename node for compatibility
- Move platform related code out for compatibility
Adviced by Stefan Agner

[snip]



+int fsl_dcu_drm_connector_create(struct fsl_dcu_drm_device *fsl_dev,
+				 struct drm_encoder *encoder)
+{
+	struct drm_connector *connector = &fsl_dev->connector.connector;
+	struct device_node *panel_node;
+	int ret;
+
+	fsl_dev->connector.encoder = encoder;
+
+	connector->display_info.width_mm = 0;
+	connector->display_info.height_mm = 0;
+
+	ret = drm_connector_init(fsl_dev->ddev, connector,
+				 &fsl_dcu_drm_connector_funcs,
+				 DRM_MODE_CONNECTOR_LVDS);
+	if (ret < 0)
+		return ret;
+
+	connector->dpms = DRM_MODE_DPMS_OFF;
+	drm_connector_helper_add(connector, &connector_helper_funcs);
+	ret = drm_connector_register(connector);
+	if (ret < 0)
+		goto err_cleanup;
+
+	ret = drm_mode_connector_attach_encoder(connector, encoder);
+	if (ret < 0)
+		goto err_sysfs;
+
+	connector->encoder = encoder;
+
+	drm_object_property_set_value
+		(&connector->base, fsl_dev->ddev->mode_config.dpms_property,
+		DRM_MODE_DPMS_OFF);
+
+	panel_node = of_parse_phandle(fsl_dev->np, "panel", 0);
+	if (panel_node) {
+		fsl_dev->connector.panel = of_drm_find_panel(panel_node);
+		if (!fsl_dev->connector.panel)
+			return -EPROBE_DEFER;
+	}
+

I think cleanup is needed before return -EPROBE_DEFER, and put node after use.

??? panel_node = of_parse_phandle(fsl_dev->np, "panel", 0);
??? if (panel_node) {
??? ??? fsl_dev->connector.panel = of_drm_find_panel(panel_node);
??? ??? if (!fsl_dev->connector.panel) {
??? ??? ??? of_node_put(panel_node);
??? ??? ??? ret = -EPROBE_DEFER;
??? ??? ??? goto err_sysfs;
??? ??? }
??? }

??? of_node_put(panel_node);

ok!!!


+	ret = drm_panel_attach(fsl_dev->connector.panel, connector);
+	if (ret) {
+		dev_err(fsl_dev->dev, "failed to attach panel\n");
+		goto err_sysfs;
+	}
+
+	return 0;
+
+err_sysfs:
+	drm_connector_unregister(connector);
+err_cleanup:
+	drm_connector_cleanup(connector);
+	return ret;
+}

[snip]



+
+static int fsl_dcu_bypass_tcon(struct fsl_dcu_drm_device *fsl_dev,
+			       struct device_node *np)
+{
+	struct device_node *tcon_np;
+	struct platform_device *pdev;
+	struct clk *tcon_clk;
+	struct resource *res;
+	void __iomem *base;
+
+	tcon_np = of_parse_phandle(np, "tcon-controller", 0);
+	if (!tcon_np)
+		return -EINVAL;
+
+	pdev = of_find_device_by_node(tcon_np);
+	if (!pdev)
+		return -EINVAL;
+
+	tcon_clk = devm_clk_get(&pdev->dev, "tcon");
+	if (IS_ERR(tcon_clk))
+		return PTR_ERR(tcon_clk);
+	clk_prepare_enable(tcon_clk);
+

clk_prepare_enable may fail, so please check the return value.


R ecommend that split clk_prepare_enable() to clk_prepare() and clk_enable(),
use clk_prepare() only at clk first init, enable/disable by clk_enable()/clk_disable().

Ok!!!!


+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	fsl_dev->tcon_regmap = devm_regmap_init_mmio(&pdev->dev,
+			base, &fsl_dcu_regmap_config);
+	if (IS_ERR(fsl_dev->tcon_regmap)) {
+		dev_err(&pdev->dev, "regmap init failed\n");
+		return PTR_ERR(fsl_dev->tcon_regmap);
+	}
+
+	regmap_write(fsl_dev->tcon_regmap, TCON_CTRL1, TCON_BYPASS_ENABLE);

Hmm, regmap_write can fail, Is that OK not check the return value?

Got it!!!

+	return 0;
+}
+

[snip]




+static int fsl_dcu_drm_remove(struct platform_device *pdev)
+{
+	struct fsl_dcu_drm_device *fsl_dev = platform_get_drvdata(pdev);
+
+	drm_put_dev(fsl_dev->ddev);
+
+	return 0;
+}
+
+static const struct of_device_id fsl_dcu_of_match[] = {
+		{ .compatible = "fsl,ls1021a-dcu", },
+		{ .compatible = "fsl,vf610-dcu", },
+		{ },
+};
+MODULE_DEVICE_TABLE(of, fsl_dcu_of_match);
+
+static struct platform_driver fsl_dcu_drm_platform_driver = {
+	.probe		= fsl_dcu_drm_probe,
+	.remove		= fsl_dcu_drm_remove,
+	.driver		= {
+		.owner	= THIS_MODULE,

remove ".owner??? = THIS_MODULE,"

platform_driver does not need to set an owner because
platform_driver_register() will set it.

Got it!!!

BR.
Jianwei

-- 
?ark
