From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 05 Jul 2014 11:39:03 +0100
Subject: [PATCH RFC 14/15] drm/armada: register crtc with port
In-Reply-To: <20140705103724.GN21766@n2100.arm.linux.org.uk>
References: <20140705103724.GN21766@n2100.arm.linux.org.uk>
Message-ID: <E1X3NN1-0000Ac-M8@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the CRTC with the port node so that the DRM OF helpers can
find the appropriate CRTC.  This is important so that encoders can
identify their corresponding possible CRTCs.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/armada/armada_crtc.c | 21 +++++++++++++++++++--
 drivers/gpu/drm/armada/armada_crtc.h |  4 +++-
 drivers/gpu/drm/armada/armada_drv.c  |  2 +-
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index 7cc30475f8f3..9b06ff0f5442 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -910,6 +910,8 @@ static void armada_drm_crtc_destroy(struct drm_crtc *crtc)
 
 	writel_relaxed(0, dcrtc->base + LCD_SPU_IRQ_ENA);
 
+	of_node_put(dcrtc->crtc.port);
+
 	kfree(dcrtc);
 }
 
@@ -1050,7 +1052,8 @@ static int armada_drm_crtc_create_properties(struct drm_device *dev)
 }
 
 int armada_drm_crtc_create(struct drm_device *drm, struct device *dev,
-	struct resource *res, int irq, const struct armada_variant *variant)
+	struct resource *res, int irq, const struct armada_variant *variant,
+	struct device_node *port)
 {
 	struct armada_private *priv = drm->dev_private;
 	struct armada_crtc *dcrtc;
@@ -1123,6 +1126,7 @@ int armada_drm_crtc_create(struct drm_device *drm, struct device *dev,
 
 	priv->dcrtc[dcrtc->num] = dcrtc;
 
+	dcrtc->crtc.port = port;
 	drm_crtc_init(drm, &dcrtc->crtc, &armada_crtc_funcs);
 	drm_crtc_helper_add(&dcrtc->crtc, &armada_crtc_helper_funcs);
 
@@ -1142,6 +1146,7 @@ armada_lcd_bind(struct device *dev, struct device *master, void *data)
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	int irq = platform_get_irq(pdev, 0);
 	const struct armada_variant *variant;
+	struct device_node *port = NULL;
 
 	if (irq < 0)
 		return irq;
@@ -1156,15 +1161,27 @@ armada_lcd_bind(struct device *dev, struct device *master, void *data)
 		variant = (const struct armada_variant *)id->driver_data;
 	} else {
 		const struct of_device_id *match;
+		struct device_node *np, *parent = dev->of_node;
 
 		match = of_match_device(dev->driver->of_match_table, dev);
 		if (!match)
 			return -ENXIO;
 
+		np = of_get_child_by_name(parent, "ports");
+		if (np)
+			parent = np;
+		port = of_get_child_by_name(parent, "port");
+		of_node_put(np);
+		if (!port) {
+			dev_err(dev, "no port node found in %s\n",
+				parent->full_name);
+			return -ENXIO;
+		}
+
 		variant = match->data;
 	}
 
-	return armada_drm_crtc_create(drm, dev, res, irq, variant);
+	return armada_drm_crtc_create(drm, dev, res, irq, variant, port);
 }
 
 static void
diff --git a/drivers/gpu/drm/armada/armada_crtc.h b/drivers/gpu/drm/armada/armada_crtc.h
index 0fc50b39f129..23135aa94b50 100644
--- a/drivers/gpu/drm/armada/armada_crtc.h
+++ b/drivers/gpu/drm/armada/armada_crtc.h
@@ -75,8 +75,10 @@ struct armada_crtc {
 };
 #define drm_to_armada_crtc(c) container_of(c, struct armada_crtc, crtc)
 
+struct device_node;
 int armada_drm_crtc_create(struct drm_device *, struct device *,
-	struct resource *, int, const struct armada_variant *);
+	struct resource *, int, const struct armada_variant *,
+	struct device_node *);
 void armada_drm_crtc_gamma_set(struct drm_crtc *, u16, u16, u16, int);
 void armada_drm_crtc_gamma_get(struct drm_crtc *, u16 *, u16 *, u16 *, int);
 void armada_drm_crtc_disable_irq(struct armada_crtc *, u32);
diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index ef8aeeee1db7..082ae845d70f 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -169,7 +169,7 @@ static int armada_drm_load(struct drm_device *dev, unsigned long flags)
 			goto err_kms;
 
 		ret = armada_drm_crtc_create(dev, dev->dev, res[n], irq,
-					     variant);
+					     variant, NULL);
 		if (ret)
 			goto err_kms;
 	}
-- 
1.8.3.1
