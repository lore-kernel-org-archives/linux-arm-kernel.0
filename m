From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 11 Feb 2014 12:45:42 +0100
Subject: [RFC PATCH v2 2/4] staging: imx-drm-core: Use graph to find
 connection between crtc and encoder
In-Reply-To: <1392119144-27868-1-git-send-email-p.zabel@pengutronix.de>
References: <1392119144-27868-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1392119144-27868-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to find the connections between crtcs and encoder
using the OF graph bindings documented for video interfaces in
Documentation/devicetree/bindings/media/video-interfaces.txt

This patch uses temporary copies of the V4L2 OF graph parsers that can be
removed again once those are moved to a generic place.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/imx-drm-core.c | 43 +++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index dcba518..fecc357 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -423,9 +423,23 @@ EXPORT_SYMBOL_GPL(imx_drm_remove_crtc);
  * or removed once the DRM device has been fully initialised.
  */
 static uint32_t imx_drm_find_crtc_mask(struct imx_drm_device *imxdrm,
-	void *cookie, int id)
+	struct device_node *endpoint)
 {
+	struct device_node *remote_port;
+	void *cookie;
 	unsigned i;
+	int id = 0;
+
+	remote_port = imx_drm_of_get_remote_port(endpoint);
+	if (remote_port)
+		of_property_read_u32(remote_port, "reg", &id);
+	else
+		return 0;
+	cookie = remote_port->parent;
+	of_node_put(remote_port);
+
+	/* IPU specific: CSI0/1 at 0/1, DI0/1 at 2/3 */
+	id -= 2;
 
 	for (i = 0; i < MAX_CRTC; i++) {
 		struct imx_drm_crtc *imx_drm_crtc = imxdrm->crtc[i];
@@ -441,24 +455,18 @@ int imx_drm_encoder_parse_of(struct drm_device *drm,
 	struct drm_encoder *encoder, struct device_node *np)
 {
 	struct imx_drm_device *imxdrm = drm->dev_private;
+	struct device_node *ep = NULL;
 	uint32_t crtc_mask = 0;
-	int i, ret = 0;
+	int i;
 
-	for (i = 0; !ret; i++) {
-		struct of_phandle_args args;
+	for (i = 0; i < MAX_CRTC; i++) {
 		uint32_t mask;
-		int id;
 
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
@@ -466,12 +474,19 @@ int imx_drm_encoder_parse_of(struct drm_device *drm,
 		 * not been registered yet.  Defer probing, and hope that
 		 * the required CRTC is added later.
 		 */
-		if (mask == 0)
+		if (mask == 0) {
+			of_node_put(ep);
 			return -EPROBE_DEFER;
+		}
 
 		crtc_mask |= mask;
 	}
 
+	if (ep)
+		of_node_put(ep);
+	if (i == 0)
+		return -ENOENT;
+
 	encoder->possible_crtcs = crtc_mask;
 
 	/* FIXME: this is the mask of outputs which can clone this output. */
-- 
1.8.5.3
