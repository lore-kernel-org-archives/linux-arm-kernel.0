From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:28:34 +0000
Subject: [PATCH RFC 33/46] imx-drm: imx-drm-core: provide helper function to
 parse possible crtcs
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vypog-0007Fj-FH@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a helper function to parse possible crtcs before the encoder
is registered.  The crtc mask is derived from the position of the
CRTCs registered in the drm_device.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c |   66 ++++++++++++++++++++++++++++++++
 drivers/staging/imx-drm/imx-drm.h      |    2 +
 2 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index b11568d6444b..1cfb8a18d905 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -657,6 +657,72 @@ int imx_drm_add_encoder(struct drm_encoder *encoder,
 }
 EXPORT_SYMBOL_GPL(imx_drm_add_encoder);
 
+/*
+ * Find the DRM CRTC possible mask for the device node cookie/id.
+ *
+ * The encoder possible masks are defined by their position in the
+ * mode_config crtc_list.  This means that CRTCs must not be added
+ * or removed once the DRM device has been fully initialised.
+ */
+static uint32_t imx_drm_find_crtc_mask(struct imx_drm_device *imxdrm,
+	void *cookie, int id)
+{
+	unsigned i;
+
+	for (i = 0; i < MAX_CRTC; i++) {
+		struct imx_drm_crtc *imx_drm_crtc = imxdrm->crtc[i];
+		if (imx_drm_crtc && imx_drm_crtc->cookie.id == id &&
+		    imx_drm_crtc->cookie.cookie == cookie)
+			return drm_helper_crtc_possible_mask(imx_drm_crtc->crtc);
+	}
+
+	return 0;
+}
+
+int imx_drm_encoder_parse_of(struct drm_device *drm,
+	struct drm_encoder *encoder, struct device_node *np)
+{
+	struct imx_drm_device *imxdrm = drm->dev_private;
+	uint32_t crtc_mask = 0;
+	int i, ret = 0;
+
+	for (i = 0; !ret; i++) {
+		struct of_phandle_args args;
+		uint32_t mask;
+		int id;
+
+		ret = of_parse_phandle_with_args(np, "crtcs", "#crtc-cells", i,
+						 &args);
+		if (ret == -ENOENT)
+			break;
+		if (ret < 0)
+			return ret;
+
+		id = args.args_count > 0 ? args.args[0] : 0;
+		mask = imx_drm_find_crtc_mask(imxdrm, args.np, id);
+		of_node_put(args.np);
+
+		/*
+		 * If we failed to find the CRTC(s) which this encoder is
+		 * supposed to be connected to, it's because the CRTC has
+		 * not been registered yet.  Defer probing, and hope that
+		 * the required CRTC is added later.
+		 */
+		if (mask == 0)
+			return -EPROBE_DEFER;
+
+		crtc_mask |= mask;
+	}
+
+	encoder->possible_crtcs = crtc_mask;
+
+	/* FIXME: this is the mask of outputs which can clone this output. */
+	encoder->possible_clones = ~0;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(imx_drm_encoder_parse_of);
+
 int imx_drm_encoder_add_possible_crtcs(
 		struct imx_drm_encoder *imx_drm_encoder,
 		struct device_node *np)
diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
index 78465239ed4c..49d4aaf33f97 100644
--- a/drivers/staging/imx-drm/imx-drm.h
+++ b/drivers/staging/imx-drm/imx-drm.h
@@ -64,6 +64,8 @@ struct device_node;
 int imx_drm_encoder_get_mux_id(struct drm_encoder *encoder);
 int imx_drm_encoder_add_possible_crtcs(struct imx_drm_encoder *imx_drm_encoder,
 		struct device_node *np);
+int imx_drm_encoder_parse_of(struct drm_device *drm,
+	struct drm_encoder *encoder, struct device_node *np);
 
 int imx_drm_connector_mode_valid(struct drm_connector *connector,
 	struct drm_display_mode *mode);
-- 
1.7.4.4
