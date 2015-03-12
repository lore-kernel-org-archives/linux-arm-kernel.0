From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Thu, 12 Mar 2015 19:47:19 +0100
Subject: [PATCH] drm: atmel-hlcdc: fixes wrong enabled flag used in PM
 suspend/resume support
Message-ID: <1426186039-29646-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unfortunately we used the enabled flag in struct drm_crtc instead of the
enabled flag in struct atmel_hlcdc_crtc. This obviously leads to
discrepancies on crtc enable state.

This patch fixes the issue by using the struct atmel_hlcdc_crtc enabled
flag in PM support.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
We had to move CRTC suspend and resume support from DC to CRTC because
drm_crtc_to_atmel_hlcdc_crtc() is static, this is also cleaner this
way. 

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c   | 19 ++++---------------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h   |  3 +++
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index d55c0c2..8ba98df 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -207,6 +207,27 @@ static void atmel_hlcdc_crtc_enable(struct drm_crtc *c)
 	crtc->enabled = true;
 }
 
+void atmel_hlcdc_crtc_suspend(struct drm_crtc *crtc)
+{
+	struct atmel_hlcdc_crtc *atmel_crtc = drm_crtc_to_atmel_hlcdc_crtc(crtc);
+
+	if (atmel_crtc->enabled) {
+		atmel_hlcdc_crtc_disable(crtc);
+		/* save enable state for resume */
+		atmel_crtc->enabled = true;
+	}
+}
+
+void atmel_hlcdc_crtc_resume(struct drm_crtc *crtc)
+{
+	struct atmel_hlcdc_crtc *atmel_crtc = drm_crtc_to_atmel_hlcdc_crtc(crtc);
+
+	if (atmel_crtc->enabled) {
+		atmel_crtc->enabled = false;
+		atmel_hlcdc_crtc_enable(crtc);
+	}
+}
+
 static int atmel_hlcdc_crtc_atomic_check(struct drm_crtc *c,
 					 struct drm_crtc_state *s)
 {
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index c4bb1f9..60b0c13 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -569,14 +569,8 @@ static int atmel_hlcdc_dc_drm_suspend(struct device *dev)
 		return 0;
 
 	drm_modeset_lock_all(drm_dev);
-	list_for_each_entry(crtc, &drm_dev->mode_config.crtc_list, head) {
-		struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;
-		if (crtc->enabled) {
-			crtc_funcs->disable(crtc);
-			/* save enable state for resume */
-			crtc->enabled = true;
-		}
-	}
+	list_for_each_entry(crtc, &drm_dev->mode_config.crtc_list, head)
+		atmel_hlcdc_crtc_suspend(crtc);
 	drm_modeset_unlock_all(drm_dev);
 	return 0;
 }
@@ -590,13 +584,8 @@ static int atmel_hlcdc_dc_drm_resume(struct device *dev)
 		return 0;
 
 	drm_modeset_lock_all(drm_dev);
-	list_for_each_entry(crtc, &drm_dev->mode_config.crtc_list, head) {
-		struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;
-		if (crtc->enabled) {
-			crtc->enabled = false;
-			crtc_funcs->enable(crtc);
-		}
-	}
+	list_for_each_entry(crtc, &drm_dev->mode_config.crtc_list, head)
+		atmel_hlcdc_crtc_resume(crtc);
 	drm_modeset_unlock_all(drm_dev);
 	return 0;
 }
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index 1ea9c2c..cf6b375 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -155,6 +155,9 @@ void atmel_hlcdc_crtc_irq(struct drm_crtc *c);
 void atmel_hlcdc_crtc_cancel_page_flip(struct drm_crtc *crtc,
 				       struct drm_file *file);
 
+void atmel_hlcdc_crtc_suspend(struct drm_crtc *crtc);
+void atmel_hlcdc_crtc_resume(struct drm_crtc *crtc);
+
 int atmel_hlcdc_crtc_create(struct drm_device *dev);
 
 int atmel_hlcdc_create_outputs(struct drm_device *dev);
-- 
2.1.4
