From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 05 Mar 2014 15:25:33 +0100
Subject: [PATCH v5 01/11] staging: imx-drm-core: Use OF graph to find
 components and connections between encoder and crtcs
In-Reply-To: <20140305100516.GV21483@n2100.arm.linux.org.uk>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
 <1394011262-16849-2-git-send-email-p.zabel@pengutronix.de>
 <20140305100516.GV21483@n2100.arm.linux.org.uk>
Message-ID: <1394029533.8754.21.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 05.03.2014, 10:05 +0000 schrieb Russell King - ARM
Linux:
> On Wed, Mar 05, 2014 at 10:20:52AM +0100, Philipp Zabel wrote:
> > +struct imx_drm_component {
> > +	struct device_node *of_node;
> > +	struct list_head list;
> > +};
> > +
> 
> The only thing this structure appears to be doing is ensuring that a
> single component doesn't get added twice - is that correct? 

I also think of it as an optimization. Now we scan the whole device
graph once in the probe function into a list of needed components that
can be walked quickly every time master_ops' .add_components callback is
run, instead of having to walk the device tree graph over and over.

Functionally, it only protects against duplicate addition.

> If so, (and the troublesome problem with the IPU crtcs is now gone)
> we can modify the core component code such that it does this:
> 
>                 if (c->master && c->master != master)
>                         continue;
> 
>                 if (compare(c->dev, compare_data)) {
> 			if (!c->master)
> 	                        component_attach_master(master, c);
>                         ret = 0;
>                         break;
>                 }
> 
> which will mean that you don't need to build this list anymore to track
> what will be added - though I'd like to think a little more about that
> before making that change.  Please confirm whether this will eliminate
> your list generation.

Yes, I can confirm that with this change, I can remove the list, like
this (tested on i.MX6S with a single LVDS panel):

diff --git a/drivers/staging/imx-drm/imx-drm-core.c
b/drivers/staging/imx-drm/imx-drm-core.c
index 014e546..f6135b9 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -32,11 +32,6 @@
 
 struct imx_drm_crtc;
 
-struct imx_drm_component {
-	struct device_node *of_node;
-	struct list_head list;
-};
-
 struct imx_drm_device {
 	struct drm_device			*drm;
 	struct imx_drm_crtc			*crtc[MAX_CRTC];
@@ -587,72 +582,10 @@ static int compare_of(struct device *dev, void
*data)
 	return dev->of_node == np;
 }
 
-static LIST_HEAD(imx_drm_components);
-
 static int imx_drm_add_components(struct device *master, struct master
*m)
 {
-	struct imx_drm_component *component;
-	int ret;
-
-	list_for_each_entry(component, &imx_drm_components, list) {
-		ret = component_master_add_child(m, compare_of,
-						 component->of_node);
-		if (ret)
-			return ret;
-	}
-	return 0;
-}
-
-static int imx_drm_bind(struct device *dev)
-{
-	return drm_platform_init(&imx_drm_driver, to_platform_device(dev));
-}
-
-static void imx_drm_unbind(struct device *dev)
-{
-	drm_put_dev(dev_get_drvdata(dev));
-}
-
-static const struct component_master_ops imx_drm_ops = {
-	.add_components = imx_drm_add_components,
-	.bind = imx_drm_bind,
-	.unbind = imx_drm_unbind,
-};
-
-static struct imx_drm_component *imx_drm_find_component(struct device
*dev,
-		struct device_node *node)
-{
-	struct imx_drm_component *component;
-
-	list_for_each_entry(component, &imx_drm_components, list)
-		if (component->of_node == node)
-			return component;
-
-	return NULL;
-}
-
-static int imx_drm_add_component(struct device *dev, struct device_node
*node)
-{
-	struct imx_drm_component *component;
-
-	if (imx_drm_find_component(dev, node))
-		return 0;
-
-	component = devm_kzalloc(dev, sizeof(*component), GFP_KERNEL);
-	if (!component)
-		return -ENOMEM;
-
-	component->of_node = node;
-	list_add_tail(&component->list, &imx_drm_components);
-
-	return 0;
-}
-
-static int imx_drm_platform_probe(struct platform_device *pdev)
-{
 	struct device_node *ep, *port, *remote;
-	int ret;
-	int i;
+	int i, ret;
 
 	/*
 	 * Bind the IPU display interface ports first, so that
@@ -660,23 +593,18 @@ static int imx_drm_platform_probe(struct
platform_device *pdev)
 	 * works as expected.
 	 */
 	for (i = 0; ; i++) {
-		port = of_parse_phandle(pdev->dev.of_node, "ports", i);
+		port = of_parse_phandle(master->of_node, "ports", i);
 		if (!port)
 			break;
 
-		ret = imx_drm_add_component(&pdev->dev, port);
-		if (ret < 0)
+		ret = component_master_add_child(m, compare_of, port);
+		if (ret)
 			return ret;
 	}
 
-	if (i == 0) {
-		dev_err(&pdev->dev, "missing 'ports' property\n");
-		return -ENODEV;
-	}
-
 	/* Then bind all encoders */
 	for (i = 0; ; i++) {
-		port = of_parse_phandle(pdev->dev.of_node, "ports", i);
+		port = of_parse_phandle(master->of_node, "ports", i);
 		if (!port)
 			break;
 
@@ -687,14 +615,44 @@ static int imx_drm_platform_probe(struct
platform_device *pdev)
 				continue;
 			}
 
-			ret = imx_drm_add_component(&pdev->dev, remote);
+			ret = component_master_add_child(m, compare_of, remote);
 			of_node_put(remote);
-			if (ret < 0)
+			if (ret)
 				return ret;
 		}
 		of_node_put(port);
 	}
 
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
+	drm_put_dev(dev_get_drvdata(dev));
+}
+
+static const struct component_master_ops imx_drm_ops = {
+	.add_components = imx_drm_add_components,
+	.bind = imx_drm_bind,
+	.unbind = imx_drm_unbind,
+};
+
+static int imx_drm_platform_probe(struct platform_device *pdev)
+{
+	struct device_node *port;
+	int ret;
+
+	port = of_parse_phandle(pdev->dev.of_node, "ports", 0);
+	if (!port) {
+		dev_err(&pdev->dev, "missing 'ports' property\n");
+		return -ENODEV;
+	}
+
 	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
-- 
1.9.0

regards
Philipp
