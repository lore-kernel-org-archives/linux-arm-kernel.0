From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:26:01 +0000
Subject: [PATCH RFC 03/46] imx-drm: imx-drm-core: merge
 imx_drm_crtc_register() into imx_drm_add_crtc()
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1VypmD-0007Dh-4G@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no reason for this to be a separate function; merge the
two together.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c |   33 ++++++++-----------------------
 1 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 242e8db218ac..05dd24ee80dd 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -370,29 +370,6 @@ static void imx_drm_connector_unregister(
 }
 
 /*
- * register a crtc to the drm core
- */
-static int imx_drm_crtc_register(struct imx_drm_crtc *imx_drm_crtc)
-{
-	struct imx_drm_device *imxdrm = __imx_drm_device();
-	int ret;
-
-	ret = drm_mode_crtc_set_gamma_size(imx_drm_crtc->crtc, 256);
-	if (ret)
-		return ret;
-
-	drm_crtc_helper_add(imx_drm_crtc->crtc,
-			imx_drm_crtc->imx_drm_helper_funcs.crtc_helper_funcs);
-
-	drm_crtc_init(imxdrm->drm, imx_drm_crtc->crtc,
-			imx_drm_crtc->imx_drm_helper_funcs.crtc_funcs);
-
-	drm_mode_group_reinit(imxdrm->drm);
-
-	return 0;
-}
-
-/*
  * Called by the CRTC driver when all CRTCs are registered. This
  * puts all the pieces together and initializes the driver.
  * Once this is called no more CRTCs can be registered since
@@ -535,10 +512,18 @@ int imx_drm_add_crtc(struct drm_crtc *crtc,
 
 	*new_crtc = imx_drm_crtc;
 
-	ret = imx_drm_crtc_register(imx_drm_crtc);
+	ret = drm_mode_crtc_set_gamma_size(imx_drm_crtc->crtc, 256);
 	if (ret)
 		goto err_register;
 
+	drm_crtc_helper_add(crtc,
+			imx_drm_crtc->imx_drm_helper_funcs.crtc_helper_funcs);
+
+	drm_crtc_init(imxdrm->drm, crtc,
+			imx_drm_crtc->imx_drm_helper_funcs.crtc_funcs);
+
+	drm_mode_group_reinit(imxdrm->drm);
+
 	imx_drm_update_possible_crtcs();
 
 	mutex_unlock(&imxdrm->mutex);
-- 
1.7.4.4
