From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:29:15 +0000
Subject: [PATCH RFC 41/46] imx-drm: imx-drm-core: various cleanups
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1VyppL-0007GG-D3@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Various cleanups are possible after the previous round of changes; these
have no real functional bearing other than tidying up the code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c |   47 +++++++++++--------------------
 drivers/staging/imx-drm/imx-drm.h      |    5 +--
 2 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 8e257c5fb041..33c020867ed0 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -15,12 +15,12 @@
  */
 #include <linux/component.h>
 #include <linux/device.h>
+#include <linux/fb.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <drm/drmP.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
-#include <linux/fb.h>
-#include <linux/module.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 
@@ -28,12 +28,6 @@
 
 #define MAX_CRTC	4
 
-struct crtc_cookie {
-	void *cookie;
-	int id;
-	struct list_head list;
-};
-
 struct imx_drm_crtc;
 
 struct imx_drm_device {
@@ -47,7 +41,8 @@ struct imx_drm_crtc {
 	struct drm_crtc				*crtc;
 	int					pipe;
 	struct imx_drm_crtc_helper_funcs	imx_drm_helper_funcs;
-	struct crtc_cookie			cookie;
+	void					*cookie;
+	int					id;
 	int					mux_id;
 };
 
@@ -271,9 +266,9 @@ static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
 		goto err_kms;
 
 	/*
-	 * with vblank_disable_allowed = true, vblank interrupt will be disabled
-	 * by drm timer once a current process gives up ownership of
-	 * vblank event.(after drm_vblank_put function is called)
+	 * with vblank_disable_allowed = true, vblank interrupt will be
+	 * disabled by drm timer once a current process gives up ownership
+	 * of vblank event. (after drm_vblank_put function is called)
 	 */
 	drm->vblank_disable_allowed = true;
 
@@ -348,26 +343,20 @@ int imx_drm_add_crtc(struct drm_device *drm, struct drm_crtc *crtc,
 	 * The vblank arrays are dimensioned by MAX_CRTC - we can't
 	 * pass IDs greater than this to those functions.
 	 */
-	if (imxdrm->pipes >= MAX_CRTC) {
-		ret = -EINVAL;
-		goto err_busy;
-	}
+	if (imxdrm->pipes >= MAX_CRTC)
+		return -EINVAL;
 
-	if (imxdrm->drm->open_count) {
-		ret = -EBUSY;
-		goto err_busy;
-	}
+	if (imxdrm->drm->open_count)
+		return -EBUSY;
 
 	imx_drm_crtc = kzalloc(sizeof(*imx_drm_crtc), GFP_KERNEL);
-	if (!imx_drm_crtc) {
-		ret = -ENOMEM;
-		goto err_alloc;
-	}
+	if (!imx_drm_crtc)
+		return -ENOMEM;
 
 	imx_drm_crtc->imx_drm_helper_funcs = *imx_drm_helper_funcs;
 	imx_drm_crtc->pipe = imxdrm->pipes++;
-	imx_drm_crtc->cookie.cookie = cookie;
-	imx_drm_crtc->cookie.id = id;
+	imx_drm_crtc->cookie = cookie;
+	imx_drm_crtc->id = id;
 	imx_drm_crtc->mux_id = imx_drm_crtc->pipe;
 	imx_drm_crtc->crtc = crtc;
 
@@ -390,8 +379,6 @@ int imx_drm_add_crtc(struct drm_device *drm, struct drm_crtc *crtc,
 err_register:
 	imxdrm->crtc[imx_drm_crtc->pipe] = NULL;
 	kfree(imx_drm_crtc);
-err_alloc:
-err_busy:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(imx_drm_add_crtc);
@@ -427,8 +414,8 @@ static uint32_t imx_drm_find_crtc_mask(struct imx_drm_device *imxdrm,
 
 	for (i = 0; i < MAX_CRTC; i++) {
 		struct imx_drm_crtc *imx_drm_crtc = imxdrm->crtc[i];
-		if (imx_drm_crtc && imx_drm_crtc->cookie.id == id &&
-		    imx_drm_crtc->cookie.cookie == cookie)
+		if (imx_drm_crtc && imx_drm_crtc->id == id &&
+		    imx_drm_crtc->cookie == cookie)
 			return drm_helper_crtc_possible_mask(imx_drm_crtc->crtc);
 	}
 
diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
index c5b97e9ce9a0..0a26222ec539 100644
--- a/drivers/staging/imx-drm/imx-drm.h
+++ b/drivers/staging/imx-drm/imx-drm.h
@@ -5,13 +5,14 @@
 
 #define IPU_PIX_FMT_GBR24	v4l2_fourcc('G', 'B', 'R', '3')
 
+struct device_node;
 struct drm_crtc;
 struct drm_connector;
 struct drm_device;
 struct drm_encoder;
-struct imx_drm_crtc;
 struct drm_fbdev_cma;
 struct drm_framebuffer;
+struct imx_drm_crtc;
 struct platform_device;
 
 int imx_drm_crtc_id(struct imx_drm_crtc *crtc);
@@ -47,8 +48,6 @@ int imx_drm_panel_format_pins(struct drm_encoder *encoder,
 int imx_drm_panel_format(struct drm_encoder *encoder,
 		u32 interface_pix_fmt);
 
-struct device_node;
-
 int imx_drm_encoder_get_mux_id(struct drm_encoder *encoder);
 int imx_drm_encoder_parse_of(struct drm_device *drm,
 	struct drm_encoder *encoder, struct device_node *np);
-- 
1.7.4.4
