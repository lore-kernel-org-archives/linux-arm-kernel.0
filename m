From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 03 Jul 2014 17:52:57 +0100
Subject: [PATCH RFC] imx-drm: convert imx-drm to use the generic DRM OF helper
Message-ID: <E1X2kFl-0000us-GN@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the generic DRM OF helper to locate the possible CRTCs for the
encoder, thereby shrinking the imx-drm driver some more.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
This patch builds upon "drm: add of_graph endpoint helper to find
possible CRTCs", converting imx-drm to use this new helper.

 drivers/staging/imx-drm/imx-drm-core.c | 72 ++++++----------------------------
 1 file changed, 13 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 47ee6c79857a..05ba8894793d 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -24,6 +24,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_of.h>
 
 #include "imx-drm.h"
 
@@ -47,7 +48,6 @@ struct imx_drm_crtc {
 	struct drm_crtc				*crtc;
 	int					pipe;
 	struct imx_drm_crtc_helper_funcs	imx_drm_helper_funcs;
-	struct device_node			*port;
 };
 
 static int legacyfb_depth = 16;
@@ -364,9 +364,10 @@ int imx_drm_add_crtc(struct drm_device *drm, struct drm_crtc *crtc,
 
 	imx_drm_crtc->imx_drm_helper_funcs = *imx_drm_helper_funcs;
 	imx_drm_crtc->pipe = imxdrm->pipes++;
-	imx_drm_crtc->port = port;
 	imx_drm_crtc->crtc = crtc;
 
+	crtc->port = port;
+
 	imxdrm->crtc[imx_drm_crtc->pipe] = imx_drm_crtc;
 
 	*new_crtc = imx_drm_crtc;
@@ -407,33 +408,6 @@ int imx_drm_remove_crtc(struct imx_drm_crtc *imx_drm_crtc)
 }
 EXPORT_SYMBOL_GPL(imx_drm_remove_crtc);
 
-/*
- * Find the DRM CRTC possible mask for the connected endpoint.
- *
- * The encoder possible masks are defined by their position in the
- * mode_config crtc_list.  This means that CRTCs must not be added
- * or removed once the DRM device has been fully initialised.
- */
-static uint32_t imx_drm_find_crtc_mask(struct imx_drm_device *imxdrm,
-	struct device_node *endpoint)
-{
-	struct device_node *port;
-	unsigned i;
-
-	port = of_graph_get_remote_port(endpoint);
-	if (!port)
-		return 0;
-	of_node_put(port);
-
-	for (i = 0; i < MAX_CRTC; i++) {
-		struct imx_drm_crtc *imx_drm_crtc = imxdrm->crtc[i];
-		if (imx_drm_crtc && imx_drm_crtc->port == port)
-			return drm_crtc_mask(imx_drm_crtc->crtc);
-	}
-
-	return 0;
-}
-
 static struct device_node *imx_drm_of_get_next_endpoint(
 		const struct device_node *parent, struct device_node *prev)
 {
@@ -445,36 +419,16 @@ static struct device_node *imx_drm_of_get_next_endpoint(
 int imx_drm_encoder_parse_of(struct drm_device *drm,
 	struct drm_encoder *encoder, struct device_node *np)
 {
-	struct imx_drm_device *imxdrm = drm->dev_private;
-	struct device_node *ep = NULL;
-	uint32_t crtc_mask = 0;
-	int i;
-
-	for (i = 0; ; i++) {
-		u32 mask;
-
-		ep = imx_drm_of_get_next_endpoint(np, ep);
-		if (!ep)
-			break;
-
-		mask = imx_drm_find_crtc_mask(imxdrm, ep);
+	uint32_t crtc_mask = drm_of_find_possible_crtcs(drm, np);
 
-		/*
-		 * If we failed to find the CRTC(s) which this encoder is
-		 * supposed to be connected to, it's because the CRTC has
-		 * not been registered yet.  Defer probing, and hope that
-		 * the required CRTC is added later.
-		 */
-		if (mask == 0)
-			return -EPROBE_DEFER;
-
-		crtc_mask |= mask;
-	}
-
-	if (ep)
-		of_node_put(ep);
-	if (i == 0)
-		return -ENOENT;
+	/*
+	 * If we failed to find the CRTC(s) which this encoder is
+	 * supposed to be connected to, it's because the CRTC has
+	 * not been registered yet.  Defer probing, and hope that
+	 * the required CRTC is added later.
+	 */
+	if (crtc_mask == 0)
+		return -EPROBE_DEFER;
 
 	encoder->possible_crtcs = crtc_mask;
 
@@ -508,7 +462,7 @@ int imx_drm_encoder_get_mux_id(struct device_node *node,
 
 		port = of_graph_get_remote_port(ep);
 		of_node_put(port);
-		if (port == imx_crtc->port) {
+		if (port == imx_crtc->crtc->port) {
 			ret = of_graph_parse_endpoint(ep, &endpoint);
 			return ret ? ret : endpoint.port;
 		}
-- 
1.8.3.1
