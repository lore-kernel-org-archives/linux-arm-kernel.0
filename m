From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Thu, 30 Aug 2018 23:00:11 +0200
Subject: [PATCH v2 11/12] drm/sun4i: use simpler
 remove_conflicting_framebuffers(NULL)
In-Reply-To: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
References: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
Message-ID: <e0e320790633e821a9d926ea727f280e59791e75.1535656077.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use remove_conflicting_framebuffers(NULL) instead of duplicating it.

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 50d19605c38f..555b5db8036f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -60,22 +60,6 @@ static struct drm_driver sun4i_drv_driver = {
 	/* Frame Buffer Operations */
 };
 
-static void sun4i_remove_framebuffers(void)
-{
-	struct apertures_struct *ap;
-
-	ap = alloc_apertures(1);
-	if (!ap)
-		return;
-
-	/* The framebuffer can be located anywhere in RAM */
-	ap->ranges[0].base = 0;
-	ap->ranges[0].size = ~0;
-
-	drm_fb_helper_remove_conflicting_framebuffers(ap, "sun4i-drm-fb", false);
-	kfree(ap);
-}
-
 static int sun4i_drv_bind(struct device *dev)
 {
 	struct drm_device *drm;
@@ -118,7 +102,7 @@ static int sun4i_drv_bind(struct device *dev)
 	drm->irq_enabled = true;
 
 	/* Remove early framebuffers (ie. simplefb) */
-	sun4i_remove_framebuffers();
+	drm_fb_helper_remove_conflicting_framebuffers(NULL, "sun4i-drm-fb", false);
 
 	/* Create our framebuffer */
 	ret = sun4i_framebuffer_init(drm);
-- 
2.18.0
