From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:27:43 +0000
Subject: [PATCH RFC 23/46] imx-drm: imx-drm-core: use array instead of list
 for CRTCs
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vypnr-0007F3-Aa@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DRM core indexes vblank by number, so there's little point
maintaining a list, and have to scan the list to find the appropriate
structure.  Instead, use an array of pointers to the CRTCs.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c |   57 +++++++++++++-------------------
 1 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index a402df0f3005..8aef203a017b 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -34,10 +34,12 @@ struct crtc_cookie {
 	struct list_head list;
 };
 
+struct imx_drm_crtc;
+
 struct imx_drm_device {
 	struct drm_device			*drm;
 	struct device				*dev;
-	struct list_head			crtc_list;
+	struct imx_drm_crtc			*crtc[MAX_CRTC];
 	struct list_head			encoder_list;
 	struct list_head			connector_list;
 	struct mutex				mutex;
@@ -47,7 +49,6 @@ struct imx_drm_device {
 
 struct imx_drm_crtc {
 	struct drm_crtc				*crtc;
-	struct list_head			list;
 	struct imx_drm_device			*imxdrm;
 	int					pipe;
 	struct imx_drm_crtc_helper_funcs	imx_drm_helper_funcs;
@@ -69,6 +70,8 @@ struct imx_drm_connector {
 	struct module				*owner;
 };
 
+static struct imx_drm_device *__imx_drm_device(void);
+
 int imx_drm_crtc_id(struct imx_drm_crtc *crtc)
 {
 	return crtc->pipe;
@@ -96,34 +99,28 @@ static int imx_drm_driver_unload(struct drm_device *drm)
 	return 0;
 }
 
-/*
- * We don't care at all for crtc numbers, but the core expects the
- * crtcs to be numbered
- */
-static struct imx_drm_crtc *imx_drm_crtc_by_num(struct imx_drm_device *imxdrm,
-		int num)
+struct imx_drm_crtc *imx_drm_find_crtc(struct drm_crtc *crtc)
 {
-	struct imx_drm_crtc *imx_drm_crtc;
+	struct imx_drm_device *imxdrm = __imx_drm_device();
+	unsigned i;
+
+	for (i = 0; i < MAX_CRTC; i++)
+		if (imxdrm->crtc[i] && imxdrm->crtc[i]->crtc == crtc)
+			return imxdrm->crtc[i];
 
-	list_for_each_entry(imx_drm_crtc, &imxdrm->crtc_list, list)
-		if (imx_drm_crtc->pipe == num)
-			return imx_drm_crtc;
 	return NULL;
 }
 
 int imx_drm_crtc_panel_format_pins(struct drm_crtc *crtc, u32 encoder_type,
 		u32 interface_pix_fmt, int hsync_pin, int vsync_pin)
 {
-	struct imx_drm_device *imxdrm = crtc->dev->dev_private;
-	struct imx_drm_crtc *imx_crtc;
 	struct imx_drm_crtc_helper_funcs *helper;
+	struct imx_drm_crtc *imx_crtc;
 
-	list_for_each_entry(imx_crtc, &imxdrm->crtc_list, list)
-		if (imx_crtc->crtc == crtc)
-			goto found;
+	imx_crtc = imx_drm_find_crtc(crtc);
+	if (!imx_crtc)
+		return -EINVAL;
 
-	return -EINVAL;
-found:
 	helper = &imx_crtc->imx_drm_helper_funcs;
 	if (helper->set_interface_pix_fmt)
 		return helper->set_interface_pix_fmt(crtc,
@@ -162,10 +159,9 @@ EXPORT_SYMBOL_GPL(imx_drm_handle_vblank);
 static int imx_drm_enable_vblank(struct drm_device *drm, int crtc)
 {
 	struct imx_drm_device *imxdrm = drm->dev_private;
-	struct imx_drm_crtc *imx_drm_crtc;
+	struct imx_drm_crtc *imx_drm_crtc = imxdrm->crtc[crtc];
 	int ret;
 
-	imx_drm_crtc = imx_drm_crtc_by_num(imxdrm, crtc);
 	if (!imx_drm_crtc)
 		return -EINVAL;
 
@@ -181,9 +177,8 @@ static int imx_drm_enable_vblank(struct drm_device *drm, int crtc)
 static void imx_drm_disable_vblank(struct drm_device *drm, int crtc)
 {
 	struct imx_drm_device *imxdrm = drm->dev_private;
-	struct imx_drm_crtc *imx_drm_crtc;
+	struct imx_drm_crtc *imx_drm_crtc = imxdrm->crtc[crtc];
 
-	imx_drm_crtc = imx_drm_crtc_by_num(imxdrm, crtc);
 	if (!imx_drm_crtc)
 		return;
 
@@ -509,7 +504,7 @@ int imx_drm_add_crtc(struct drm_crtc *crtc,
 
 	imx_drm_crtc->owner = owner;
 
-	list_add_tail(&imx_drm_crtc->list, &imxdrm->crtc_list);
+	imxdrm->crtc[imx_drm_crtc->pipe] = imx_drm_crtc;
 
 	*new_crtc = imx_drm_crtc;
 
@@ -532,7 +527,7 @@ int imx_drm_add_crtc(struct drm_crtc *crtc,
 	return 0;
 
 err_register:
-	list_del(&imx_drm_crtc->list);
+	imxdrm->crtc[imx_drm_crtc->pipe] = NULL;
 	kfree(imx_drm_crtc);
 err_alloc:
 err_busy:
@@ -552,7 +547,7 @@ int imx_drm_remove_crtc(struct imx_drm_crtc *imx_drm_crtc)
 
 	drm_crtc_cleanup(imx_drm_crtc->crtc);
 
-	list_del(&imx_drm_crtc->list);
+	imxdrm->crtc[imx_drm_crtc->pipe] = NULL;
 
 	drm_mode_group_reinit(imxdrm->drm);
 
@@ -659,14 +654,9 @@ EXPORT_SYMBOL_GPL(imx_drm_encoder_add_possible_crtcs);
 
 int imx_drm_encoder_get_mux_id(struct drm_encoder *encoder)
 {
-	struct imx_drm_device *imxdrm = __imx_drm_device();
-	struct imx_drm_crtc *imx_crtc;
-
-	list_for_each_entry(imx_crtc, &imxdrm->crtc_list, list)
-		if (imx_crtc->crtc == encoder->crtc)
-			return imx_crtc->mux_id;
+	struct imx_drm_crtc *imx_crtc = imx_drm_find_crtc(encoder->crtc);
 
-	return -EINVAL;
+	return imx_crtc ? imx_crtc->mux_id : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(imx_drm_encoder_get_mux_id);
 
@@ -853,7 +843,6 @@ static int __init imx_drm_init(void)
 		return -ENOMEM;
 
 	mutex_init(&imx_drm_device->mutex);
-	INIT_LIST_HEAD(&imx_drm_device->crtc_list);
 	INIT_LIST_HEAD(&imx_drm_device->connector_list);
 	INIT_LIST_HEAD(&imx_drm_device->encoder_list);
 
-- 
1.7.4.4
