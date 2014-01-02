From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:27:38 +0000
Subject: [PATCH RFC 22/46] imx-drm: imx-drm-core: sanitise
 imx_drm_encoder_get_mux_id()
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vypnm-0007Ez-7S@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Address the following issues:
- imx_drm_encoder_get_mux_id() searches the CRTC list for the matching
  CRTC, and returns the position within this list as the MUX programming
  value for encoders.  This is sub-optimal for two reasons:
  1. It relies upon the CRTC list not changing during the lifetime of
     the driver.
  2. It is dependent on the initialisation order of the CRTCs.

  We address (1) in this patch, leaving (2) until a better solution can
  be found, as (2) requires larger changes.

- imx_drm_encoder is unused.  Instead, pass the drm_encoder which is
  slightly more useful; all callers pass encoder->crtc as the required
  crtc, so move this inside the function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c |   17 ++++++-----------
 drivers/staging/imx-drm/imx-drm.h      |    3 +--
 drivers/staging/imx-drm/imx-hdmi.c     |    3 +--
 drivers/staging/imx-drm/imx-ldb.c      |    6 ++----
 4 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 05dd24ee80dd..a402df0f3005 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -53,6 +53,7 @@ struct imx_drm_crtc {
 	struct imx_drm_crtc_helper_funcs	imx_drm_helper_funcs;
 	struct module				*owner;
 	struct crtc_cookie			cookie;
+	int					mux_id;
 };
 
 struct imx_drm_encoder {
@@ -502,7 +503,7 @@ int imx_drm_add_crtc(struct drm_crtc *crtc,
 	imx_drm_crtc->pipe = imxdrm->pipes++;
 	imx_drm_crtc->cookie.cookie = cookie;
 	imx_drm_crtc->cookie.id = id;
-
+	imx_drm_crtc->mux_id = imx_drm_crtc->pipe;
 	imx_drm_crtc->crtc = crtc;
 	imx_drm_crtc->imxdrm = imxdrm;
 
@@ -656,22 +657,16 @@ int imx_drm_encoder_add_possible_crtcs(
 }
 EXPORT_SYMBOL_GPL(imx_drm_encoder_add_possible_crtcs);
 
-int imx_drm_encoder_get_mux_id(struct imx_drm_encoder *imx_drm_encoder,
-		struct drm_crtc *crtc)
+int imx_drm_encoder_get_mux_id(struct drm_encoder *encoder)
 {
 	struct imx_drm_device *imxdrm = __imx_drm_device();
 	struct imx_drm_crtc *imx_crtc;
-	int i = 0;
 
-	list_for_each_entry(imx_crtc, &imxdrm->crtc_list, list) {
-		if (imx_crtc->crtc == crtc)
-			goto found;
-		i++;
-	}
+	list_for_each_entry(imx_crtc, &imxdrm->crtc_list, list)
+		if (imx_crtc->crtc == encoder->crtc)
+			return imx_crtc->mux_id;
 
 	return -EINVAL;
-found:
-	return i;
 }
 EXPORT_SYMBOL_GPL(imx_drm_encoder_get_mux_id);
 
diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
index ae90c9c15312..5649f180dc44 100644
--- a/drivers/staging/imx-drm/imx-drm.h
+++ b/drivers/staging/imx-drm/imx-drm.h
@@ -64,8 +64,7 @@ void imx_drm_fb_helper_set(struct drm_fbdev_cma *fbdev_helper);
 
 struct device_node;
 
-int imx_drm_encoder_get_mux_id(struct imx_drm_encoder *imx_drm_encoder,
-		struct drm_crtc *crtc);
+int imx_drm_encoder_get_mux_id(struct drm_encoder *encoder);
 int imx_drm_encoder_add_possible_crtcs(struct imx_drm_encoder *imx_drm_encoder,
 		struct device_node *np);
 
diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index 2eb51e7ea9bb..c8152043143f 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -1471,8 +1471,7 @@ static void imx_hdmi_encoder_prepare(struct drm_encoder *encoder)
 static void imx_hdmi_encoder_commit(struct drm_encoder *encoder)
 {
 	struct imx_hdmi *hdmi = container_of(encoder, struct imx_hdmi, encoder);
-	int mux = imx_drm_encoder_get_mux_id(hdmi->imx_drm_encoder,
-					     encoder->crtc);
+	int mux = imx_drm_encoder_get_mux_id(encoder);
 
 	imx_hdmi_set_ipu_di_mux(hdmi, mux);
 
diff --git a/drivers/staging/imx-drm/imx-ldb.c b/drivers/staging/imx-drm/imx-ldb.c
index 654bf03e05ff..bbcbd52f0169 100644
--- a/drivers/staging/imx-drm/imx-ldb.c
+++ b/drivers/staging/imx-drm/imx-ldb.c
@@ -180,8 +180,7 @@ static void imx_ldb_encoder_prepare(struct drm_encoder *encoder)
 	u32 pixel_fmt;
 	unsigned long serial_clk;
 	unsigned long di_clk = mode->clock * 1000;
-	int mux = imx_drm_encoder_get_mux_id(imx_ldb_ch->imx_drm_encoder,
-					     encoder->crtc);
+	int mux = imx_drm_encoder_get_mux_id(encoder);
 
 	if (ldb->ldb_ctrl & LDB_SPLIT_MODE_EN) {
 		/* dual channel LVDS mode */
@@ -217,8 +216,7 @@ static void imx_ldb_encoder_commit(struct drm_encoder *encoder)
 	struct imx_ldb_channel *imx_ldb_ch = enc_to_imx_ldb_ch(encoder);
 	struct imx_ldb *ldb = imx_ldb_ch->ldb;
 	int dual = ldb->ldb_ctrl & LDB_SPLIT_MODE_EN;
-	int mux = imx_drm_encoder_get_mux_id(imx_ldb_ch->imx_drm_encoder,
-					     encoder->crtc);
+	int mux = imx_drm_encoder_get_mux_id(encoder);
 
 	if (dual) {
 		clk_prepare_enable(ldb->clk[0]);
-- 
1.7.4.4
