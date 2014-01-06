From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  6 Jan 2014 15:52:02 +0100
Subject: [RFC PATCH 3/3] staging: imx-drm-core: associate crtc devices with di
 port nodes
In-Reply-To: <1389019922-31992-1-git-send-email-p.zabel@pengutronix.de>
References: <1389019922-31992-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1389019922-31992-4-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To connect the graph in the device tree, each display interface
needs to have an associated port node in the device tree. We can
associate this node with the crtc device and use it to find the
crtc corresponding to a given node instead of using a combination
of parent device node and id.
Explicitly converting the void* cookie to the port device tree node
allows to get rid of the ipu_id and di_id fields. The multiplexer
setting now can be obtained from the port reg property in the
device tree.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/imx-drm-core.c | 62 +++++++++++++++++++---------------
 drivers/staging/imx-drm/imx-drm.h      |  4 +--
 drivers/staging/imx-drm/imx-hdmi.c     |  2 +-
 drivers/staging/imx-drm/imx-ldb.c      |  4 +--
 drivers/staging/imx-drm/ipuv3-crtc.c   | 36 ++++++++++++++++++--
 5 files changed, 74 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 2c20434..da34b2d 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -42,9 +42,7 @@ struct imx_drm_crtc {
 	struct drm_crtc				*crtc;
 	int					pipe;
 	struct imx_drm_crtc_helper_funcs	imx_drm_helper_funcs;
-	void					*cookie;
-	int					di_id;
-	int					ipu_id;
+	struct device_node			*port;
 };
 
 static int legacyfb_depth = 16;
@@ -339,14 +337,11 @@ err_kms:
 
 /*
  * imx_drm_add_crtc - add a new crtc
- *
- * The return value if !NULL is a cookie for the caller to pass to
- * imx_drm_remove_crtc later.
  */
 int imx_drm_add_crtc(struct drm_device *drm, struct drm_crtc *crtc,
 		struct imx_drm_crtc **new_crtc,
 		const struct imx_drm_crtc_helper_funcs *imx_drm_helper_funcs,
-		void *cookie, int ipu_id, int di_id)
+		struct device_node *port)
 {
 	struct imx_drm_device *imxdrm = drm->dev_private;
 	struct imx_drm_crtc *imx_drm_crtc;
@@ -368,9 +363,7 @@ int imx_drm_add_crtc(struct drm_device *drm, struct drm_crtc *crtc,
 
 	imx_drm_crtc->imx_drm_helper_funcs = *imx_drm_helper_funcs;
 	imx_drm_crtc->pipe = imxdrm->pipes++;
-	imx_drm_crtc->cookie = cookie;
-	imx_drm_crtc->di_id = di_id;
-	imx_drm_crtc->ipu_id = ipu_id;
+	imx_drm_crtc->port = port;
 	imx_drm_crtc->crtc = crtc;
 
 	imxdrm->crtc[imx_drm_crtc->pipe] = imx_drm_crtc;
@@ -414,7 +407,7 @@ int imx_drm_remove_crtc(struct imx_drm_crtc *imx_drm_crtc)
 EXPORT_SYMBOL_GPL(imx_drm_remove_crtc);
 
 /*
- * Find the DRM CRTC possible mask for the device node cookie/id.
+ * Find the DRM CRTC possible mask for the connected endpoint.
  *
  * The encoder possible masks are defined by their position in the
  * mode_config crtc_list.  This means that CRTCs must not be added
@@ -423,26 +416,17 @@ EXPORT_SYMBOL_GPL(imx_drm_remove_crtc);
 static uint32_t imx_drm_find_crtc_mask(struct imx_drm_device *imxdrm,
 	struct device_node *endpoint)
 {
-	struct device_node *remote_port;
-	void *cookie;
+	struct device_node *port;
 	unsigned i;
-	int id = 0;
 
-	remote_port = v4l2_of_get_remote_port(endpoint);
-	if (remote_port)
-		of_property_read_u32(remote_port, "reg", &id);
-	else
+	port = v4l2_of_get_remote_port(endpoint);
+	if (!port)
 		return 0;
-	cookie = remote_port->parent;
-	of_node_put(remote_port);
-
-	/* IPU specific: CSI0/1 at 0/1, DI0/1 at 2/3 */
-	id -= 2;
+	of_node_put(port);
 
 	for (i = 0; i < MAX_CRTC; i++) {
 		struct imx_drm_crtc *imx_drm_crtc = imxdrm->crtc[i];
-		if (imx_drm_crtc && imx_drm_crtc->di_id == id &&
-		    imx_drm_crtc->cookie == cookie)
+		if (imx_drm_crtc && imx_drm_crtc->port == port)
 			return drm_helper_crtc_possible_mask(imx_drm_crtc->crtc);
 	}
 
@@ -498,11 +482,35 @@ int imx_drm_encoder_parse_of(struct drm_device *drm,
 }
 EXPORT_SYMBOL_GPL(imx_drm_encoder_parse_of);
 
-int imx_drm_encoder_get_mux_id(struct drm_encoder *encoder)
+int imx_drm_encoder_get_mux_id(struct device *dev, struct drm_encoder *encoder)
 {
 	struct imx_drm_crtc *imx_crtc = imx_drm_find_crtc(encoder->crtc);
+	struct device_node *parent = dev->of_node;
+	struct device_node *ep, *last_ep = NULL;
+	struct device_node *port;
+	int id, ret;
+
+	if (!parent || !imx_crtc)
+		return -EINVAL;
+
+	do {
+		ep = v4l2_of_get_next_endpoint(parent, last_ep);
+		if (last_ep)
+			of_node_put(last_ep);
+		if (!ep)
+			break;
+
+		port = v4l2_of_get_remote_port(ep);
+		if (port == imx_crtc->port) {
+			ret = of_property_read_u32(ep->parent, "reg", &id);
+			of_node_put(ep);
+			return ret ? ret : id;
+		}
+
+		last_ep = ep;
+	} while (ep);
 
-	return imx_crtc ? imx_crtc->ipu_id * 2 + imx_crtc->di_id : -EINVAL;
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(imx_drm_encoder_get_mux_id);
 
diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
index 7d8d963..1176835 100644
--- a/drivers/staging/imx-drm/imx-drm.h
+++ b/drivers/staging/imx-drm/imx-drm.h
@@ -29,7 +29,7 @@ struct imx_drm_crtc_helper_funcs {
 int imx_drm_add_crtc(struct drm_device *drm, struct drm_crtc *crtc,
 		struct imx_drm_crtc **new_crtc,
 		const struct imx_drm_crtc_helper_funcs *imx_helper_funcs,
-		void *cookie, int ipu_id, int di_id);
+		struct device_node *port);
 int imx_drm_remove_crtc(struct imx_drm_crtc *);
 int imx_drm_init_drm(struct platform_device *pdev,
 		int preferred_bpp);
@@ -48,7 +48,7 @@ int imx_drm_panel_format_pins(struct drm_encoder *encoder,
 int imx_drm_panel_format(struct drm_encoder *encoder,
 		u32 interface_pix_fmt);
 
-int imx_drm_encoder_get_mux_id(struct drm_encoder *encoder);
+int imx_drm_encoder_get_mux_id(struct device *dev, struct drm_encoder *encoder);
 int imx_drm_encoder_parse_of(struct drm_device *drm,
 	struct drm_encoder *encoder, struct device_node *np);
 
diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index 0414a69..fb3177d 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -1475,7 +1475,7 @@ static void imx_hdmi_encoder_prepare(struct drm_encoder *encoder)
 static void imx_hdmi_encoder_commit(struct drm_encoder *encoder)
 {
 	struct imx_hdmi *hdmi = container_of(encoder, struct imx_hdmi, encoder);
-	int mux = imx_drm_encoder_get_mux_id(encoder);
+	int mux = imx_drm_encoder_get_mux_id(hdmi->dev, encoder);
 
 	imx_hdmi_set_ipu_di_mux(hdmi, mux);
 
diff --git a/drivers/staging/imx-drm/imx-ldb.c b/drivers/staging/imx-drm/imx-ldb.c
index 5168c76..1d56f6e 100644
--- a/drivers/staging/imx-drm/imx-ldb.c
+++ b/drivers/staging/imx-drm/imx-ldb.c
@@ -168,7 +168,7 @@ static void imx_ldb_encoder_prepare(struct drm_encoder *encoder)
 	u32 pixel_fmt;
 	unsigned long serial_clk;
 	unsigned long di_clk = mode->clock * 1000;
-	int mux = imx_drm_encoder_get_mux_id(encoder);
+	int mux = imx_drm_encoder_get_mux_id(ldb->dev, encoder);
 
 	if (ldb->ldb_ctrl & LDB_SPLIT_MODE_EN) {
 		/* dual channel LVDS mode */
@@ -203,7 +203,7 @@ static void imx_ldb_encoder_commit(struct drm_encoder *encoder)
 	struct imx_ldb_channel *imx_ldb_ch = enc_to_imx_ldb_ch(encoder);
 	struct imx_ldb *ldb = imx_ldb_ch->ldb;
 	int dual = ldb->ldb_ctrl & LDB_SPLIT_MODE_EN;
-	int mux = imx_drm_encoder_get_mux_id(encoder);
+	int mux = imx_drm_encoder_get_mux_id(ldb->dev, encoder);
 
 	if (dual) {
 		clk_prepare_enable(ldb->clk[0]);
diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index b2de40b..bfc5b59 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -350,8 +350,7 @@ static int ipu_crtc_init(struct ipu_crtc *ipu_crtc,
 	}
 
 	ret = imx_drm_add_crtc(drm, &ipu_crtc->base, &ipu_crtc->imx_crtc,
-			&ipu_crtc_helper_funcs, ipu_crtc->dev->parent->of_node,
-			pdata->ipu, pdata->di);
+			&ipu_crtc_helper_funcs, ipu_crtc->dev->of_node);
 	if (ret) {
 		dev_err(ipu_crtc->dev, "adding crtc failed with %d.\n", ret);
 		goto err_put_resources;
@@ -399,6 +398,28 @@ err_put_resources:
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
@@ -412,6 +433,17 @@ static int ipu_drm_bind(struct device *dev, struct device *master, void *data)
 
 	ipu_crtc->dev = dev;
 
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
 	ret = ipu_crtc_init(ipu_crtc, pdata, drm);
 	if (ret)
 		return ret;
-- 
1.8.5.2
