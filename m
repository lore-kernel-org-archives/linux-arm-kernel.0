From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed,  5 Mar 2014 10:20:52 +0100
Subject: [PATCH v5 01/11] staging: imx-drm-core: Use OF graph to find
 components and connections between encoder and crtcs
In-Reply-To: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1394011262-16849-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <philipp.zabel@gmail.com>

This patch adds support to find the involved components connected to
the IPU display interface ports using the OF graph bindings documented
in Documentation/devicetree/bindings/media/video-interfaces.txt.
It makes use of the of_graph (formerly v4l2_of) parsing helpers and
thus depends on the patch that moves those out to drivers/of.

Each display interface needs to have an associated port node in the
device tree. We can associate this node with the crtc platform device
and use it to find the crtc corresponding to a given port node instead
of using a combination of parent device node and id number, as before.

Explicitly converting the void* cookie to the port device tree node
allows to get rid of the ipu_id and di_id fields. The multiplexer
setting on i.MX6 now can be obtained from the port id (reg property)
in the device tree.

The imx-drm node now needs a ports property that contains phandles
to each of the IPU display interface port nodes. From there, all
attached encoders are scanned and enabled encoders are added to a
waiting list.
The bind order makes sure that once all components are probed, crtcs
are bound before encoders, so that imx_drm_encoder_parse_of can be
called from the encoder bind callbacks.

For parsing the OF graph, temporary copies of the V4L2 OF graph
helpers are used, that can be removed again once those are available
at a generic place.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v4:
 - changed DT compatible string to 'fsl,imx-display-subsystem' instead
   of Linux specific 'fsl,imx-drm'
---
 drivers/staging/imx-drm/imx-drm-core.c | 217 +++++++++++++++++++++++----------
 drivers/staging/imx-drm/imx-drm.h      |   5 +-
 drivers/staging/imx-drm/imx-hdmi.c     |   2 +-
 drivers/staging/imx-drm/imx-ldb.c      |   4 +-
 drivers/staging/imx-drm/ipuv3-crtc.c   |  47 +++++--
 5 files changed, 199 insertions(+), 76 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 6b91c8e..ecfc88b 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/fb.h>
 #include <linux/module.h>
+#include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <drm/drmP.h>
 #include <drm/drm_fb_helper.h>
@@ -30,6 +31,11 @@
 
 struct imx_drm_crtc;
 
+struct imx_drm_component {
+	struct device_node *of_node;
+	struct list_head list;
+};
+
 struct imx_drm_device {
 	struct drm_device			*drm;
 	struct imx_drm_crtc			*crtc[MAX_CRTC];
@@ -41,9 +47,7 @@ struct imx_drm_crtc {
 	struct drm_crtc				*crtc;
 	int					pipe;
 	struct imx_drm_crtc_helper_funcs	imx_drm_helper_funcs;
-	void					*cookie;
-	int					id;
-	int					mux_id;
+	struct device_node			*port;
 };
 
 static int legacyfb_depth = 16;
@@ -341,14 +345,11 @@ err_kms:
 
 /*
  * imx_drm_add_crtc - add a new crtc
- *
- * The return value if !NULL is a cookie for the caller to pass to
- * imx_drm_remove_crtc later.
  */
 int imx_drm_add_crtc(struct drm_device *drm, struct drm_crtc *crtc,
 		struct imx_drm_crtc **new_crtc,
 		const struct imx_drm_crtc_helper_funcs *imx_drm_helper_funcs,
-		void *cookie, int id)
+		struct device_node *port)
 {
 	struct imx_drm_device *imxdrm = drm->dev_private;
 	struct imx_drm_crtc *imx_drm_crtc;
@@ -370,9 +371,7 @@ int imx_drm_add_crtc(struct drm_device *drm, struct drm_crtc *crtc,
 
 	imx_drm_crtc->imx_drm_helper_funcs = *imx_drm_helper_funcs;
 	imx_drm_crtc->pipe = imxdrm->pipes++;
-	imx_drm_crtc->cookie = cookie;
-	imx_drm_crtc->id = id;
-	imx_drm_crtc->mux_id = imx_drm_crtc->pipe;
+	imx_drm_crtc->port = port;
 	imx_drm_crtc->crtc = crtc;
 
 	imxdrm->crtc[imx_drm_crtc->pipe] = imx_drm_crtc;
@@ -416,49 +415,56 @@ int imx_drm_remove_crtc(struct imx_drm_crtc *imx_drm_crtc)
 EXPORT_SYMBOL_GPL(imx_drm_remove_crtc);
 
 /*
- * Find the DRM CRTC possible mask for the device node cookie/id.
+ * Find the DRM CRTC possible mask for the connected endpoint.
  *
  * The encoder possible masks are defined by their position in the
  * mode_config crtc_list.  This means that CRTCs must not be added
  * or removed once the DRM device has been fully initialised.
  */
 static uint32_t imx_drm_find_crtc_mask(struct imx_drm_device *imxdrm,
-	void *cookie, int id)
+	struct device_node *endpoint)
 {
+	struct device_node *port;
 	unsigned i;
 
+	port = of_graph_get_remote_port(endpoint);
+	if (!port)
+		return 0;
+	of_node_put(port);
+
 	for (i = 0; i < MAX_CRTC; i++) {
 		struct imx_drm_crtc *imx_drm_crtc = imxdrm->crtc[i];
-		if (imx_drm_crtc && imx_drm_crtc->id == id &&
-		    imx_drm_crtc->cookie == cookie)
+		if (imx_drm_crtc && imx_drm_crtc->port == port)
 			return drm_crtc_mask(imx_drm_crtc->crtc);
 	}
 
 	return 0;
 }
 
+static struct device_node *imx_drm_of_get_next_endpoint(
+		const struct device_node *parent, struct device_node *prev)
+{
+	struct device_node *node = of_graph_get_next_endpoint(parent, prev);
+	of_node_put(prev);
+	return node;
+}
+
 int imx_drm_encoder_parse_of(struct drm_device *drm,
 	struct drm_encoder *encoder, struct device_node *np)
 {
 	struct imx_drm_device *imxdrm = drm->dev_private;
+	struct device_node *ep = NULL;
 	uint32_t crtc_mask = 0;
-	int i, ret = 0;
+	int i;
 
-	for (i = 0; !ret; i++) {
-		struct of_phandle_args args;
-		uint32_t mask;
-		int id;
+	for (i = 0; ; i++) {
+		u32 mask;
 
-		ret = of_parse_phandle_with_args(np, "crtcs", "#crtc-cells", i,
-						 &args);
-		if (ret == -ENOENT)
+		ep = imx_drm_of_get_next_endpoint(np, ep);
+		if (!ep)
 			break;
-		if (ret < 0)
-			return ret;
 
-		id = args.args_count > 0 ? args.args[0] : 0;
-		mask = imx_drm_find_crtc_mask(imxdrm, args.np, id);
-		of_node_put(args.np);
+		mask = imx_drm_find_crtc_mask(imxdrm, ep);
 
 		/*
 		 * If we failed to find the CRTC(s) which this encoder is
@@ -472,6 +478,11 @@ int imx_drm_encoder_parse_of(struct drm_device *drm,
 		crtc_mask |= mask;
 	}
 
+	if (ep)
+		of_node_put(ep);
+	if (i == 0)
+		return -ENOENT;
+
 	encoder->possible_crtcs = crtc_mask;
 
 	/* FIXME: this is the mask of outputs which can clone this output. */
@@ -481,11 +492,36 @@ int imx_drm_encoder_parse_of(struct drm_device *drm,
 }
 EXPORT_SYMBOL_GPL(imx_drm_encoder_parse_of);
 
-int imx_drm_encoder_get_mux_id(struct drm_encoder *encoder)
+/*
+ * @node: device tree node containing encoder input ports
+ * @encoder: drm_encoder
+ */
+int imx_drm_encoder_get_mux_id(struct device_node *node,
+			       struct drm_encoder *encoder)
 {
 	struct imx_drm_crtc *imx_crtc = imx_drm_find_crtc(encoder->crtc);
+	struct device_node *ep = NULL;
+	struct device_node *port;
+	int id, ret;
+
+	if (!node || !imx_crtc)
+		return -EINVAL;
+
+	do {
+		ep = imx_drm_of_get_next_endpoint(node, ep);
+		if (!ep)
+			break;
+
+		port = of_graph_get_remote_port(ep);
+		of_node_put(port);
+		if (port == imx_crtc->port) {
+			ret = of_property_read_u32(ep->parent, "reg", &id);
+			of_node_put(ep);
+			return ret ? ret : id;
+		}
+	} while (ep);
 
-	return imx_crtc ? imx_crtc->mux_id : -EINVAL;
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(imx_drm_encoder_get_mux_id);
 
@@ -528,48 +564,29 @@ static struct drm_driver imx_drm_driver = {
 	.patchlevel		= 0,
 };
 
-static int compare_parent_of(struct device *dev, void *data)
-{
-	struct of_phandle_args *args = data;
-	return dev->parent && dev->parent->of_node == args->np;
-}
-
 static int compare_of(struct device *dev, void *data)
 {
-	return dev->of_node == data;
-}
-
-static int imx_drm_add_components(struct device *master, struct master *m)
-{
-	struct device_node *np = master->of_node;
-	unsigned i;
-	int ret;
+	struct device_node *np = data;
 
-	for (i = 0; ; i++) {
-		struct of_phandle_args args;
-
-		ret = of_parse_phandle_with_fixed_args(np, "crtcs", 1,
-						       i, &args);
-		if (ret)
-			break;
-
-		ret = component_master_add_child(m, compare_parent_of, &args);
-		of_node_put(args.np);
-
-		if (ret)
-			return ret;
+	/* Special case for LDB, one device for two channels */
+	if (of_node_cmp(np->name, "lvds-channel") == 0) {
+		np = of_get_parent(np);
+		of_node_put(np);
 	}
 
-	for (i = 0; ; i++) {
-		struct device_node *node;
+	return dev->of_node == np;
+}
 
-		node = of_parse_phandle(np, "connectors", i);
-		if (!node)
-			break;
+static LIST_HEAD(imx_drm_components);
 
-		ret = component_master_add_child(m, compare_of, node);
-		of_node_put(node);
+static int imx_drm_add_components(struct device *master, struct master *m)
+{
+	struct imx_drm_component *component;
+	int ret;
 
+	list_for_each_entry(component, &imx_drm_components, list) {
+		ret = component_master_add_child(m, compare_of,
+						 component->of_node);
 		if (ret)
 			return ret;
 	}
@@ -592,9 +609,81 @@ static const struct component_master_ops imx_drm_ops = {
 	.unbind = imx_drm_unbind,
 };
 
+static struct imx_drm_component *imx_drm_find_component(struct device *dev,
+		struct device_node *node)
+{
+	struct imx_drm_component *component;
+
+	list_for_each_entry(component, &imx_drm_components, list)
+		if (component->of_node == node)
+			return component;
+
+	return NULL;
+}
+
+static int imx_drm_add_component(struct device *dev, struct device_node *node)
+{
+	struct imx_drm_component *component;
+
+	if (imx_drm_find_component(dev, node))
+		return 0;
+
+	component = devm_kzalloc(dev, sizeof(*component), GFP_KERNEL);
+	if (!component)
+		return -ENOMEM;
+
+	component->of_node = node;
+	list_add_tail(&component->list, &imx_drm_components);
+
+	return 0;
+}
+
 static int imx_drm_platform_probe(struct platform_device *pdev)
 {
+	struct device_node *ep, *port, *remote;
 	int ret;
+	int i;
+
+	/*
+	 * Bind the IPU display interface ports first, so that
+	 * imx_drm_encoder_parse_of called from encoder .bind callbacks
+	 * works as expected.
+	 */
+	for (i = 0; ; i++) {
+		port = of_parse_phandle(pdev->dev.of_node, "ports", i);
+		if (!port)
+			break;
+
+		ret = imx_drm_add_component(&pdev->dev, port);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (i == 0) {
+		dev_err(&pdev->dev, "missing 'ports' property\n");
+		return -ENODEV;
+	}
+
+	/* Then bind all encoders */
+	for (i = 0; ; i++) {
+		port = of_parse_phandle(pdev->dev.of_node, "ports", i);
+		if (!port)
+			break;
+
+		for_each_child_of_node(port, ep) {
+			remote = of_graph_get_remote_port_parent(ep);
+			if (!remote || !of_device_is_available(remote)) {
+				of_node_put(remote);
+				continue;
+			}
+
+			ret = imx_drm_add_component(&pdev->dev, remote);
+			of_node_put(remote);
+			if (ret < 0)
+				return ret;
+		}
+		of_node_put(port);
+	}
 
 	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret)
@@ -610,7 +699,7 @@ static int imx_drm_platform_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx_drm_dt_ids[] = {
-	{ .compatible = "fsl,imx-drm", },
+	{ .compatible = "fsl,imx-display-subsystem", },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, imx_drm_dt_ids);
diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
index 035ab62..a322bac 100644
--- a/drivers/staging/imx-drm/imx-drm.h
+++ b/drivers/staging/imx-drm/imx-drm.h
@@ -26,7 +26,7 @@ struct imx_drm_crtc_helper_funcs {
 int imx_drm_add_crtc(struct drm_device *drm, struct drm_crtc *crtc,
 		struct imx_drm_crtc **new_crtc,
 		const struct imx_drm_crtc_helper_funcs *imx_helper_funcs,
-		void *cookie, int id);
+		struct device_node *port);
 int imx_drm_remove_crtc(struct imx_drm_crtc *);
 int imx_drm_init_drm(struct platform_device *pdev,
 		int preferred_bpp);
@@ -45,7 +45,8 @@ int imx_drm_panel_format_pins(struct drm_encoder *encoder,
 int imx_drm_panel_format(struct drm_encoder *encoder,
 		u32 interface_pix_fmt);
 
-int imx_drm_encoder_get_mux_id(struct drm_encoder *encoder);
+int imx_drm_encoder_get_mux_id(struct device_node *node,
+		struct drm_encoder *encoder);
 int imx_drm_encoder_parse_of(struct drm_device *drm,
 	struct drm_encoder *encoder, struct device_node *np);
 
diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index 8384cea..909bee4 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -1459,7 +1459,7 @@ static void imx_hdmi_encoder_prepare(struct drm_encoder *encoder)
 static void imx_hdmi_encoder_commit(struct drm_encoder *encoder)
 {
 	struct imx_hdmi *hdmi = container_of(encoder, struct imx_hdmi, encoder);
-	int mux = imx_drm_encoder_get_mux_id(encoder);
+	int mux = imx_drm_encoder_get_mux_id(hdmi->dev->of_node, encoder);
 
 	imx_hdmi_set_ipu_di_mux(hdmi, mux);
 
diff --git a/drivers/staging/imx-drm/imx-ldb.c b/drivers/staging/imx-drm/imx-ldb.c
index daa54df..33d2b883 100644
--- a/drivers/staging/imx-drm/imx-ldb.c
+++ b/drivers/staging/imx-drm/imx-ldb.c
@@ -170,7 +170,7 @@ static void imx_ldb_encoder_prepare(struct drm_encoder *encoder)
 	u32 pixel_fmt;
 	unsigned long serial_clk;
 	unsigned long di_clk = mode->clock * 1000;
-	int mux = imx_drm_encoder_get_mux_id(encoder);
+	int mux = imx_drm_encoder_get_mux_id(imx_ldb_ch->child, encoder);
 
 	if (ldb->ldb_ctrl & LDB_SPLIT_MODE_EN) {
 		/* dual channel LVDS mode */
@@ -205,7 +205,7 @@ static void imx_ldb_encoder_commit(struct drm_encoder *encoder)
 	struct imx_ldb_channel *imx_ldb_ch = enc_to_imx_ldb_ch(encoder);
 	struct imx_ldb *ldb = imx_ldb_ch->ldb;
 	int dual = ldb->ldb_ctrl & LDB_SPLIT_MODE_EN;
-	int mux = imx_drm_encoder_get_mux_id(encoder);
+	int mux = imx_drm_encoder_get_mux_id(imx_ldb_ch->child, encoder);
 
 	if (dual) {
 		clk_prepare_enable(ldb->clk[0]);
diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index e646017..a8d0178 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -350,10 +350,8 @@ static int ipu_crtc_init(struct ipu_crtc *ipu_crtc,
 		return ret;
 	}
 
-	ret = imx_drm_add_crtc(drm, &ipu_crtc->base,
-			&ipu_crtc->imx_crtc,
-			&ipu_crtc_helper_funcs,
-			ipu_crtc->dev->parent->of_node, pdata->di);
+	ret = imx_drm_add_crtc(drm, &ipu_crtc->base, &ipu_crtc->imx_crtc,
+			&ipu_crtc_helper_funcs, ipu_crtc->dev->of_node);
 	if (ret) {
 		dev_err(ipu_crtc->dev, "adding crtc failed with %d.\n", ret);
 		goto err_put_resources;
@@ -401,6 +399,28 @@ err_put_resources:
 	return ret;
 }
 
+static struct device_node *ipu_drm_get_port_by_id(struct device_node *parent,
+						  int port_id)
+{
+	struct device_node *port;
+	int id, ret;
+
+	port = of_get_child_by_name(parent, "port");
+	while (port) {
+		ret = of_property_read_u32(port, "reg", &id);
+		if (!ret && id == port_id)
+			return port;
+
+		do {
+			port = of_get_next_child(parent, port);
+			if (!port)
+				return NULL;
+		} while (of_node_cmp(port->name, "port"));
+	}
+
+	return NULL;
+}
+
 static int ipu_drm_bind(struct device *dev, struct device *master, void *data)
 {
 	struct ipu_client_platformdata *pdata = dev->platform_data;
@@ -441,16 +461,29 @@ static const struct component_ops ipu_crtc_ops = {
 
 static int ipu_drm_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct ipu_client_platformdata *pdata = dev->platform_data;
 	int ret;
 
-	if (!pdev->dev.platform_data)
+	if (!dev->platform_data)
 		return -EINVAL;
 
-	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+	if (!dev->of_node) {
+		/* Associate crtc device with the corresponding DI port node */
+		dev->of_node = ipu_drm_get_port_by_id(dev->parent->of_node,
+						      pdata->di + 2);
+		if (!dev->of_node) {
+			dev_err(dev, "missing port@%d node in %s\n",
+				pdata->di + 2, dev->parent->of_node->full_name);
+			return -ENODEV;
+		}
+	}
+
+	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
 
-	return component_add(&pdev->dev, &ipu_crtc_ops);
+	return component_add(dev, &ipu_crtc_ops);
 }
 
 static int ipu_drm_remove(struct platform_device *pdev)
-- 
1.9.0.rc3
