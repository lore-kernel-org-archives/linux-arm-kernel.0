From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:28:08 +0000
Subject: [PATCH RFC 28/46] imx-drm: imx-hdmi: convert to a component device
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1VypoG-0007FO-U1@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert imx-hdmi to be a component device; it will bind and unbind
at the appropriate moment in the main DRM driver's functions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-hdmi.c |   41 +++++++++++++++++++++++++----------
 1 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index 0e5e7a6f6168..d81940a8904f 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -12,6 +12,7 @@
  * Copyright (C) 2010, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
  */
 
+#include <linux/component.h>
 #include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -1586,21 +1587,22 @@ static const struct of_device_id imx_hdmi_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, imx_hdmi_dt_ids);
 
-static int imx_hdmi_platform_probe(struct platform_device *pdev)
+static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	const struct of_device_id *of_id =
-				of_match_device(imx_hdmi_dt_ids, &pdev->dev);
-	struct device_node *np = pdev->dev.of_node;
+				of_match_device(imx_hdmi_dt_ids, dev);
+	struct device_node *np = dev->of_node;
 	struct device_node *ddc_node;
 	struct imx_hdmi *hdmi;
 	struct resource *iores;
 	int ret, irq;
 
-	hdmi = devm_kzalloc(&pdev->dev, sizeof(*hdmi), GFP_KERNEL);
+	hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
 	if (!hdmi)
 		return -ENOMEM;
 
-	hdmi->dev = &pdev->dev;
+	hdmi->dev = dev;
 	hdmi->sample_rate = 48000;
 	hdmi->ratio = 100;
 
@@ -1624,13 +1626,13 @@ static int imx_hdmi_platform_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return -EINVAL;
 
-	ret = devm_request_irq(&pdev->dev, irq, imx_hdmi_irq, 0,
-			       dev_name(&pdev->dev), hdmi);
+	ret = devm_request_irq(dev, irq, imx_hdmi_irq, 0,
+			       dev_name(dev), hdmi);
 	if (ret)
 		return ret;
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hdmi->regs = devm_ioremap_resource(&pdev->dev, iores);
+	hdmi->regs = devm_ioremap_resource(dev, iores);
 	if (IS_ERR(hdmi->regs))
 		return PTR_ERR(hdmi->regs);
 
@@ -1669,7 +1671,7 @@ static int imx_hdmi_platform_probe(struct platform_device *pdev)
 	}
 
 	/* Product and revision IDs */
-	dev_info(&pdev->dev,
+	dev_info(dev,
 		"Detected HDMI controller 0x%x:0x%x:0x%x:0x%x\n",
 		hdmi_readb(hdmi, HDMI_DESIGN_ID),
 		hdmi_readb(hdmi, HDMI_REVISION_ID),
@@ -1703,7 +1705,7 @@ static int imx_hdmi_platform_probe(struct platform_device *pdev)
 
 	imx_drm_encoder_add_possible_crtcs(hdmi->imx_drm_encoder, np);
 
-	platform_set_drvdata(pdev, hdmi);
+	dev_set_drvdata(dev, hdmi);
 
 	return 0;
 
@@ -1715,9 +1717,10 @@ static int imx_hdmi_platform_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_hdmi_platform_remove(struct platform_device *pdev)
+static void imx_hdmi_unbind(struct device *dev, struct device *master,
+	void *data)
 {
-	struct imx_hdmi *hdmi = platform_get_drvdata(pdev);
+	struct imx_hdmi *hdmi = dev_get_drvdata(dev);
 	struct drm_connector *connector = &hdmi->connector;
 	struct drm_encoder *encoder = &hdmi->encoder;
 
@@ -1728,7 +1731,21 @@ static int imx_hdmi_platform_remove(struct platform_device *pdev)
 	clk_disable_unprepare(hdmi->iahb_clk);
 	clk_disable_unprepare(hdmi->isfr_clk);
 	i2c_put_adapter(hdmi->ddc);
+}
 
+static const struct component_ops hdmi_ops = {
+	.bind	= imx_hdmi_bind,
+	.unbind	= imx_hdmi_unbind,
+};
+
+static int imx_hdmi_platform_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &hdmi_ops);
+}
+
+static int imx_hdmi_platform_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &hdmi_ops);
 	return 0;
 }
 
-- 
1.7.4.4
