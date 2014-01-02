From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:27:53 +0000
Subject: [PATCH RFC 25/46] imx-drm: simplify setup of panel format
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vypo1-0007FB-Hu@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The encoder format passed into imx_drm_crtc_panel_format*() is the
encoder format used for DRM in most cases; the HDMI encoder sets
this to none, but this is incorrect, it should be TMDS.

Since this is the case, we can pass the drm_encoder structure
directly into this function and use the supplied fields there to
configure the CRTC.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c     |   18 ++++++++----------
 drivers/staging/imx-drm/imx-drm.h          |    4 ++--
 drivers/staging/imx-drm/imx-hdmi.c         |    3 +--
 drivers/staging/imx-drm/imx-ldb.c          |    3 +--
 drivers/staging/imx-drm/imx-tve.c          |   12 +++++++-----
 drivers/staging/imx-drm/ipuv3-crtc.c       |    1 +
 drivers/staging/imx-drm/parallel-display.c |    3 +--
 7 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index d7cb0af9479a..839dbb7c7b36 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -111,32 +111,30 @@ struct imx_drm_crtc *imx_drm_find_crtc(struct drm_crtc *crtc)
 	return NULL;
 }
 
-int imx_drm_crtc_panel_format_pins(struct drm_crtc *crtc, u32 encoder_type,
+int imx_drm_panel_format_pins(struct drm_encoder *encoder,
 		u32 interface_pix_fmt, int hsync_pin, int vsync_pin)
 {
 	struct imx_drm_crtc_helper_funcs *helper;
 	struct imx_drm_crtc *imx_crtc;
 
-	imx_crtc = imx_drm_find_crtc(crtc);
+	imx_crtc = imx_drm_find_crtc(encoder->crtc);
 	if (!imx_crtc)
 		return -EINVAL;
 
 	helper = &imx_crtc->imx_drm_helper_funcs;
 	if (helper->set_interface_pix_fmt)
-		return helper->set_interface_pix_fmt(crtc,
-				encoder_type, interface_pix_fmt,
+		return helper->set_interface_pix_fmt(encoder->crtc,
+				encoder->encoder_type, interface_pix_fmt,
 				hsync_pin, vsync_pin);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(imx_drm_crtc_panel_format_pins);
+EXPORT_SYMBOL_GPL(imx_drm_panel_format_pins);
 
-int imx_drm_crtc_panel_format(struct drm_crtc *crtc, u32 encoder_type,
-		u32 interface_pix_fmt)
+int imx_drm_panel_format(struct drm_encoder *encoder, u32 interface_pix_fmt)
 {
-	return imx_drm_crtc_panel_format_pins(crtc, encoder_type,
-					      interface_pix_fmt, 2, 3);
+	return imx_drm_panel_format_pins(encoder, interface_pix_fmt, 2, 3);
 }
-EXPORT_SYMBOL_GPL(imx_drm_crtc_panel_format);
+EXPORT_SYMBOL_GPL(imx_drm_panel_format);
 
 int imx_drm_crtc_vblank_get(struct imx_drm_crtc *imx_drm_crtc)
 {
diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
index 4eb594ce9cff..e3ca0c6b6a39 100644
--- a/drivers/staging/imx-drm/imx-drm.h
+++ b/drivers/staging/imx-drm/imx-drm.h
@@ -56,9 +56,9 @@ struct drm_gem_cma_object *imx_drm_fb_get_obj(struct drm_framebuffer *fb);
 
 struct drm_device *imx_drm_device_get(void);
 void imx_drm_device_put(void);
-int imx_drm_crtc_panel_format_pins(struct drm_crtc *crtc, u32 encoder_type,
+int imx_drm_panel_format_pins(struct drm_encoder *encoder,
 		u32 interface_pix_fmt, int hsync_pin, int vsync_pin);
-int imx_drm_crtc_panel_format(struct drm_crtc *crtc, u32 encoder_type,
+int imx_drm_panel_format(struct drm_encoder *encoder,
 		u32 interface_pix_fmt);
 void imx_drm_fb_helper_set(struct drm_fbdev_cma *fbdev_helper);
 
diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index 8421c715ce14..0e5e7a6f6168 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -1457,8 +1457,7 @@ static void imx_hdmi_encoder_prepare(struct drm_encoder *encoder)
 	struct imx_hdmi *hdmi = container_of(encoder, struct imx_hdmi, encoder);
 
 	imx_hdmi_poweroff(hdmi);
-	imx_drm_crtc_panel_format(encoder->crtc, DRM_MODE_ENCODER_NONE,
-				  V4L2_PIX_FMT_RGB24);
+	imx_drm_panel_format(encoder, V4L2_PIX_FMT_RGB24);
 }
 
 static void imx_hdmi_encoder_commit(struct drm_encoder *encoder)
diff --git a/drivers/staging/imx-drm/imx-ldb.c b/drivers/staging/imx-drm/imx-ldb.c
index 81a23685b42d..70455c4d7e48 100644
--- a/drivers/staging/imx-drm/imx-ldb.c
+++ b/drivers/staging/imx-drm/imx-ldb.c
@@ -201,8 +201,7 @@ static void imx_ldb_encoder_prepare(struct drm_encoder *encoder)
 		pixel_fmt = V4L2_PIX_FMT_RGB24;
 	}
 
-	imx_drm_crtc_panel_format(encoder->crtc, DRM_MODE_ENCODER_LVDS,
-			pixel_fmt);
+	imx_drm_panel_format(encoder, pixel_fmt);
 }
 
 static void imx_ldb_encoder_commit(struct drm_encoder *encoder)
diff --git a/drivers/staging/imx-drm/imx-tve.c b/drivers/staging/imx-drm/imx-tve.c
index f315c5250fe8..b2f214971501 100644
--- a/drivers/staging/imx-drm/imx-tve.c
+++ b/drivers/staging/imx-drm/imx-tve.c
@@ -310,13 +310,11 @@ static void imx_tve_encoder_prepare(struct drm_encoder *encoder)
 
 	switch (tve->mode) {
 	case TVE_MODE_VGA:
-		imx_drm_crtc_panel_format_pins(encoder->crtc,
-				DRM_MODE_ENCODER_DAC, IPU_PIX_FMT_GBR24,
+		imx_drm_panel_format_pins(encoder, IPU_PIX_FMT_GBR24,
 				tve->hsync_pin, tve->vsync_pin);
 		break;
 	case TVE_MODE_TVOUT:
-		imx_drm_crtc_panel_format(encoder->crtc, DRM_MODE_ENCODER_TVDAC,
-					  V4L2_PIX_FMT_YUV444);
+		imx_drm_panel_format(encoder, V4L2_PIX_FMT_YUV444);
 		break;
 	}
 }
@@ -510,12 +508,16 @@ static int tve_clk_init(struct imx_tve *tve, void __iomem *base)
 
 static int imx_tve_register(struct imx_tve *tve)
 {
+	int encoder_type;
 	int ret;
 
+	encoder_type = tve->mode == TVE_MODE_VGA ?
+				DRM_MODE_ENCODER_DAC : DRM_MODE_ENCODER_TVDAC;
+
 	tve->connector.funcs = &imx_tve_connector_funcs;
 	tve->encoder.funcs = &imx_tve_encoder_funcs;
 
-	tve->encoder.encoder_type = DRM_MODE_ENCODER_NONE;
+	tve->encoder.encoder_type = encoder_type;
 	tve->connector.connector_type = DRM_MODE_CONNECTOR_VGA;
 
 	drm_encoder_helper_add(&tve->encoder, &imx_tve_encoder_helper_funcs);
diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index ce6ba987ec91..2bee6fa585f8 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -283,6 +283,7 @@ static int ipu_set_interface_pix_fmt(struct drm_crtc *crtc, u32 encoder_type,
 		ipu_crtc->di_clkflags = IPU_DI_CLKMODE_SYNC |
 			IPU_DI_CLKMODE_EXT;
 		break;
+	case DRM_MODE_ENCODER_TMDS:
 	case DRM_MODE_ENCODER_NONE:
 		ipu_crtc->di_clkflags = 0;
 		break;
diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index 789950b87b29..9ba9ca1aeb67 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -107,8 +107,7 @@ static void imx_pd_encoder_prepare(struct drm_encoder *encoder)
 {
 	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
 
-	imx_drm_crtc_panel_format(encoder->crtc, DRM_MODE_ENCODER_NONE,
-			imxpd->interface_pix_fmt);
+	imx_drm_panel_format(encoder, imxpd->interface_pix_fmt);
 }
 
 static void imx_pd_encoder_commit(struct drm_encoder *encoder)
-- 
1.7.4.4
