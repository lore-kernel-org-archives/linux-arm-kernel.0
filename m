From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 05 Jul 2014 11:38:58 +0100
Subject: [PATCH RFC 13/15] drm/armada: permit CRTCs to be registered as
 separate devices
In-Reply-To: <20140705103724.GN21766@n2100.arm.linux.org.uk>
References: <20140705103724.GN21766@n2100.arm.linux.org.uk>
Message-ID: <E1X3NMw-0000AY-Ia@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/armada/armada_crtc.c | 114 ++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/armada/armada_crtc.h |   4 +-
 drivers/gpu/drm/armada/armada_drv.c  |   5 +-
 3 files changed, 110 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index afa497489000..7cc30475f8f3 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -7,6 +7,9 @@
  * published by the Free Software Foundation.
  */
 #include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
 #include "armada_crtc.h"
@@ -1046,19 +1049,19 @@ static int armada_drm_crtc_create_properties(struct drm_device *dev)
 	return 0;
 }
 
-int armada_drm_crtc_create(struct drm_device *dev, struct resource *res,
-	int irq, const struct armada_variant *variant)
+int armada_drm_crtc_create(struct drm_device *drm, struct device *dev,
+	struct resource *res, int irq, const struct armada_variant *variant)
 {
-	struct armada_private *priv = dev->dev_private;
+	struct armada_private *priv = drm->dev_private;
 	struct armada_crtc *dcrtc;
 	void __iomem *base;
 	int ret;
 
-	ret = armada_drm_crtc_create_properties(dev);
+	ret = armada_drm_crtc_create_properties(drm);
 	if (ret)
 		return ret;
 
-	base = devm_request_and_ioremap(dev->dev, res);
+	base = devm_request_and_ioremap(dev, res);
 	if (!base) {
 		DRM_ERROR("failed to ioremap register\n");
 		return -ENOMEM;
@@ -1070,9 +1073,12 @@ int armada_drm_crtc_create(struct drm_device *dev, struct resource *res,
 		return -ENOMEM;
 	}
 
+	if (dev != drm->dev)
+		dev_set_drvdata(dev, dcrtc);
+
 	dcrtc->variant = variant;
 	dcrtc->base = base;
-	dcrtc->num = dev->mode_config.num_crtc;
+	dcrtc->num = drm->mode_config.num_crtc;
 	dcrtc->clk = ERR_PTR(-EINVAL);
 	dcrtc->csc_yuv_mode = CSC_AUTO;
 	dcrtc->csc_rgb_mode = CSC_AUTO;
@@ -1105,7 +1111,7 @@ int armada_drm_crtc_create(struct drm_device *dev, struct resource *res,
 	}
 
 	if (dcrtc->variant->init) {
-		ret = dcrtc->variant->init(dcrtc, dev->dev);
+		ret = dcrtc->variant->init(dcrtc, dev);
 		if (ret) {
 			kfree(dcrtc);
 			return ret;
@@ -1117,7 +1123,7 @@ int armada_drm_crtc_create(struct drm_device *dev, struct resource *res,
 
 	priv->dcrtc[dcrtc->num] = dcrtc;
 
-	drm_crtc_init(dev, &dcrtc->crtc, &armada_crtc_funcs);
+	drm_crtc_init(drm, &dcrtc->crtc, &armada_crtc_funcs);
 	drm_crtc_helper_add(&dcrtc->crtc, &armada_crtc_helper_funcs);
 
 	drm_object_attach_property(&dcrtc->crtc.base, priv->csc_yuv_prop,
@@ -1125,5 +1131,95 @@ int armada_drm_crtc_create(struct drm_device *dev, struct resource *res,
 	drm_object_attach_property(&dcrtc->crtc.base, priv->csc_rgb_prop,
 				   dcrtc->csc_rgb_mode);
 
-	return armada_overlay_plane_create(dev, 1 << dcrtc->num);
+	return armada_overlay_plane_create(drm, 1 << dcrtc->num);
+}
+
+static int
+armada_lcd_bind(struct device *dev, struct device *master, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct drm_device *drm = data;
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	int irq = platform_get_irq(pdev, 0);
+	const struct armada_variant *variant;
+
+	if (irq < 0)
+		return irq;
+
+	if (!dev->of_node) {
+		const struct platform_device_id *id;
+
+		id = platform_get_device_id(pdev);
+		if (!id)
+			return -ENXIO;
+
+		variant = (const struct armada_variant *)id->driver_data;
+	} else {
+		const struct of_device_id *match;
+
+		match = of_match_device(dev->driver->of_match_table, dev);
+		if (!match)
+			return -ENXIO;
+
+		variant = match->data;
+	}
+
+	return armada_drm_crtc_create(drm, dev, res, irq, variant);
+}
+
+static void
+armada_lcd_unbind(struct device *dev, struct device *master, void *data)
+{
+	struct armada_crtc *dcrtc = dev_get_drvdata(dev);
+
+	armada_drm_crtc_destroy(&dcrtc->crtc);
+}
+
+static const struct component_ops armada_lcd_ops = {
+	.bind = armada_lcd_bind,
+	.unbind = armada_lcd_unbind,
+};
+
+static int armada_lcd_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &armada_lcd_ops);
+}
+
+static int armada_lcd_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &armada_lcd_ops);
+	return 0;
 }
+
+static struct of_device_id armada_lcd_of_match[] = {
+	{
+		.compatible	= "marvell,dove-lcd",
+		.data		= &armada510_ops,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, armada_lcd_of_match);
+
+static const struct platform_device_id armada_lcd_platform_ids[] = {
+	{
+		.name		= "armada-lcd",
+		.driver_data	= (unsigned long)&armada510_ops,
+	}, {
+		.name		= "armada-510-lcd",
+		.driver_data	= (unsigned long)&armada510_ops,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, armada_lcd_platform_ids);
+
+static struct platform_driver armada_lcd_platform_driver = {
+	.probe	= armada_lcd_probe,
+	.remove	= armada_lcd_remove,
+	.driver = {
+		.name	= "armada-lcd",
+		.owner	=  THIS_MODULE,
+		.of_match_table = armada_lcd_of_match,
+	},
+	.id_table = armada_lcd_platform_ids,
+};
+module_platform_driver(armada_lcd_platform_driver);
diff --git a/drivers/gpu/drm/armada/armada_crtc.h b/drivers/gpu/drm/armada/armada_crtc.h
index 73efcfcdf814..0fc50b39f129 100644
--- a/drivers/gpu/drm/armada/armada_crtc.h
+++ b/drivers/gpu/drm/armada/armada_crtc.h
@@ -75,8 +75,8 @@ struct armada_crtc {
 };
 #define drm_to_armada_crtc(c) container_of(c, struct armada_crtc, crtc)
 
-int armada_drm_crtc_create(struct drm_device *, struct resource *, int,
-	const struct armada_variant *);
+int armada_drm_crtc_create(struct drm_device *, struct device *,
+	struct resource *, int, const struct armada_variant *);
 void armada_drm_crtc_gamma_set(struct drm_crtc *, u16, u16, u16, int);
 void armada_drm_crtc_gamma_get(struct drm_crtc *, u16 *, u16 *, u16 *, int);
 void armada_drm_crtc_disable_irq(struct armada_crtc *, u32);
diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 2b6fc6cf62f2..ef8aeeee1db7 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -115,7 +115,7 @@ static int armada_drm_load(struct drm_device *dev, unsigned long flags)
 			return -EINVAL;
 	}
 
-	if (!res[0] || !mem)
+	if (!mem)
 		return -ENXIO;
 
 	if (!devm_request_mem_region(dev->dev, mem->start,
@@ -168,7 +168,8 @@ static int armada_drm_load(struct drm_device *dev, unsigned long flags)
 		if (irq < 0)
 			goto err_kms;
 
-		ret = armada_drm_crtc_create(dev, res[n], irq, variant);
+		ret = armada_drm_crtc_create(dev, dev->dev, res[n], irq,
+					     variant);
 		if (ret)
 			goto err_kms;
 	}
-- 
1.8.3.1
