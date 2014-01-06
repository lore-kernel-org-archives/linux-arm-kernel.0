From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  6 Jan 2014 15:52:01 +0100
Subject: [RFC PATCH 2/3] staging: imx-drm-core: Use graph to find connection
 between crtc and encoder
In-Reply-To: <1389019922-31992-1-git-send-email-p.zabel@pengutronix.de>
References: <1389019922-31992-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1389019922-31992-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/imx-drm-core.c | 44 ++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 2490dc3..2c20434 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -23,6 +23,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_fb_cma_helper.h>
+#include <media/v4l2-of.h>
 
 #include "imx-drm.h"
 
@@ -420,9 +421,23 @@ EXPORT_SYMBOL_GPL(imx_drm_remove_crtc);
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
+	remote_port = v4l2_of_get_remote_port(endpoint);
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
@@ -438,24 +453,21 @@ int imx_drm_encoder_parse_of(struct drm_device *drm,
 	struct drm_encoder *encoder, struct device_node *np)
 {
 	struct imx_drm_device *imxdrm = drm->dev_private;
+	struct device_node *ep, *last_ep = NULL;
 	uint32_t crtc_mask = 0;
 	int i, ret = 0;
 
 	for (i = 0; !ret; i++) {
-		struct of_phandle_args args;
 		uint32_t mask;
-		int id;
 
-		ret = of_parse_phandle_with_args(np, "crtcs", "#crtc-cells", i,
-						 &args);
-		if (ret == -ENOENT)
+		ep = v4l2_of_get_next_endpoint(np, last_ep);
+		if (last_ep)
+			of_node_put(last_ep);
+		if (!ep)
 			break;
-		if (ret < 0)
-			return ret;
 
-		id = args.args_count > 0 ? args.args[0] : 0;
-		mask = imx_drm_find_crtc_mask(imxdrm, args.np, id);
-		of_node_put(args.np);
+		/* CSI */
+		mask = imx_drm_find_crtc_mask(imxdrm, ep);
 
 		/*
 		 * If we failed to find the CRTC(s) which this encoder is
@@ -463,12 +475,20 @@ int imx_drm_encoder_parse_of(struct drm_device *drm,
 		 * not been registered yet.  Defer probing, and hope that
 		 * the required CRTC is added later.
 		 */
-		if (mask == 0)
+		if (mask == 0) {
+			of_node_put(ep);
 			return -EPROBE_DEFER;
+		}
 
 		crtc_mask |= mask;
+		last_ep = ep;
 	}
 
+	if (ep)
+		of_node_put(ep);
+	if (i == 0)
+		return -ENOENT;
+
 	encoder->possible_crtcs = crtc_mask;
 
 	/* FIXME: this is the mask of outputs which can clone this output. */
-- 
1.8.5.2
