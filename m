From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 11 Feb 2014 12:45:43 +0100
Subject: [RFC PATCH v2 3/4] staging: imx-drm-core: associate crtc devices with
 di port nodes
In-Reply-To: <1392119144-27868-1-git-send-email-p.zabel@pengutronix.de>
References: <1392119144-27868-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1392119144-27868-4-git-send-email-p.zabel@pengutronix.de>
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
 drivers/staging/imx-drm/imx-drm-core.c | 63 +++++++++++++++++++---------------
 drivers/staging/imx-drm/imx-drm.h      |  5 +--
 drivers/staging/imx-drm/imx-hdmi.c     |  2 +-
 drivers/staging/imx-drm/imx-ldb.c      |  4 +--
 drivers/staging/imx-drm/ipuv3-crtc.c   | 39 ++++++++++++++++++---
 5 files changed, 77 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index fecc357..63852bb 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -41,9 +41,7 @@ struct imx_drm_crtc {
 	struct drm_crtc				*crtc;
 	int					pipe;
 	struct imx_drm_crtc_helper_funcs	imx_drm_helper_funcs;
-	void					*cookie;
-	int					id;
-	int					mux_id;
+	struct device_node			*port;
 };
 
 static int legacyfb_depth = 16;
@@ -341,14 +339,11 @@ err_kms:
 
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
@@ -370,9 +365,7 @@ int imx_drm_add_crtc(struct drm_device *drm, struct drm_crtc *crtc,
 
 	imx_drm_crtc->imx_drm_helper_funcs = *imx_drm_helper_funcs;
 	imx_drm_crtc->pipe = imxdrm->pipes++;
-	imx_drm_crtc->cookie = cookie;
-	imx_drm_crtc->id = id;
-	imx_drm_crtc->mux_id = imx_drm_crtc->pipe;
+	imx_drm_crtc->port = port;
 	imx_drm_crtc->crtc = crtc;
 
 	imxdrm->crtc[imx_drm_crtc->pipe] = imx_drm_crtc;
@@ -416,7 +409,7 @@ int imx_drm_remove_crtc(struct imx_drm_crtc *imx_drm_crtc)
 EXPORT_SYMBOL_GPL(imx_drm_remove_crtc);
 
 /*
- * Find the DRM CRTC possible mask for the device node cookie/id.
+ * Find the DRM CRTC possible mask for the connected endpoint.
  *
  * The encoder possible masks are defined by their position in the
  * mode_config crtc_list.  This means that CRTCs must not be added
@@ -425,26 +418,17 @@ EXPORT_SYMBOL_GPL(imx_drm_remove_crtc);
 static uint32_t imx_drm_find_crtc_mask(struct imx_drm_device *imxdrm,
 	struct device_node *endpoint)
 {
-	struct device_node *remote_port;
-	void *cookie;
+	struct device_node *port;
 	unsigned i;
-	int id = 0;
 
-	remote_port = imx_drm_of_get_remote_port(endpoint);
-	if (remote_port)
-		of_property_read_u32(remote_port, "reg", &id);
-	else
+	port = imx_drm_of_get_remote_port(endpoint);
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
-		if (imx_drm_crtc && imx_drm_crtc->id == id &&
-		    imx_drm_crtc->cookie == cookie)
+		if (imx_drm_crtc && imx_drm_crtc->port == port)
 			return drm_crtc_mask(imx_drm_crtc->crtc);
 	}
 
@@ -496,11 +480,36 @@ int imx_drm_encoder_parse_of(struct drm_device *drm,
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
+		port = imx_drm_of_get_remote_port(ep);
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
 
diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
index 9af4a82..4afda6b 100644
--- a/drivers/staging/imx-drm/imx-drm.h
+++ b/drivers/staging/imx-drm/imx-drm.h
@@ -30,7 +30,7 @@ struct imx_drm_crtc_helper_funcs {
 int imx_drm_add_crtc(struct drm_device *drm, struct drm_crtc *crtc,
 		struct imx_drm_crtc **new_crtc,
 		const struct imx_drm_crtc_helper_funcs *imx_helper_funcs,
-		void *cookie, int id);
+		struct device_node *port);
 int imx_drm_remove_crtc(struct imx_drm_crtc *);
 int imx_drm_init_drm(struct platform_device *pdev,
 		int preferred_bpp);
@@ -49,7 +49,8 @@ int imx_drm_panel_format_pins(struct drm_encoder *encoder,
 int imx_drm_panel_format(struct drm_encoder *encoder,
 		u32 interface_pix_fmt);
 
-int imx_drm_encoder_get_mux_id(struct drm_encoder *encoder);
+int imx_drm_encoder_get_mux_id(struct device_node *node,
+		struct drm_encoder *encoder);
 int imx_drm_encoder_parse_of(struct drm_device *drm,
 	struct drm_encoder *encoder, struct device_node *np);
 
diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index a677e33..8509814 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -1453,7 +1453,7 @@ static void imx_hdmi_encoder_prepare(struct drm_encoder *encoder)
 static void imx_hdmi_encoder_commit(struct drm_encoder *encoder)
 {
 	struct imx_hdmi *hdmi = container_of(encoder, struct imx_hdmi, encoder);
-	int mux = imx_drm_encoder_get_mux_id(encoder);
+	int mux = imx_drm_encoder_get_mux_id(hdmi->dev->of_node, encoder);
 
 	imx_hdmi_set_ipu_di_mux(hdmi, mux);
 
diff --git a/drivers/staging/imx-drm/imx-ldb.c b/drivers/staging/imx-drm/imx-ldb.c
index 5168c76..301c430 100644
--- a/drivers/staging/imx-drm/imx-ldb.c
+++ b/drivers/staging/imx-drm/imx-ldb.c
@@ -168,7 +168,7 @@ static void imx_ldb_encoder_prepare(struct drm_encoder *encoder)
 	u32 pixel_fmt;
 	unsigned long serial_clk;
 	unsigned long di_clk = mode->clock * 1000;
-	int mux = imx_drm_encoder_get_mux_id(encoder);
+	int mux = imx_drm_encoder_get_mux_id(imx_ldb_ch->child, encoder);
 
 	if (ldb->ldb_ctrl & LDB_SPLIT_MODE_EN) {
 		/* dual channel LVDS mode */
@@ -203,7 +203,7 @@ static void imx_ldb_encoder_commit(struct drm_encoder *encoder)
 	struct imx_ldb_channel *imx_ldb_ch = enc_to_imx_ldb_ch(encoder);
 	struct imx_ldb *ldb = imx_ldb_ch->ldb;
 	int dual = ldb->ldb_ctrl & LDB_SPLIT_MODE_EN;
-	int mux = imx_drm_encoder_get_mux_id(encoder);
+	int mux = imx_drm_encoder_get_mux_id(imx_ldb_ch->child, encoder);
 
 	if (dual) {
 		clk_prepare_enable(ldb->clk[0]);
diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index e646017..627515a 100644
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
@@ -414,6 +434,17 @@ static int ipu_drm_bind(struct device *dev, struct device *master, void *data)
 
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
1.8.5.3
