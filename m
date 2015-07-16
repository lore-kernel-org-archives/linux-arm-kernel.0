From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Thu, 16 Jul 2015 20:55:34 +0200
Subject: [PATCH] drm: atmel-hlcdc: fix vblank initial state
Message-ID: <1437072934-21088-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

drm_vblank_on() now warns on nested use or if vblank is not properly
initialized. This patch fixes Atmel HLCDC vblank initial state.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reported-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c |  1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c   | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index f69b925..5ae5c69 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -355,6 +355,7 @@ int atmel_hlcdc_crtc_create(struct drm_device *dev)
 		planes->overlays[i]->base.possible_crtcs = 1 << crtc->id;
 
 	drm_crtc_helper_add(&crtc->base, &lcdc_crtc_helper_funcs);
+	drm_crtc_vblank_reset(&crtc->base);
 
 	dc->crtc = &crtc->base;
 
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 60b0c13..6fad1f9 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -313,20 +313,20 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 
 	pm_runtime_enable(dev->dev);
 
-	ret = atmel_hlcdc_dc_modeset_init(dev);
+	ret = drm_vblank_init(dev, 1);
 	if (ret < 0) {
-		dev_err(dev->dev, "failed to initialize mode setting\n");
+		dev_err(dev->dev, "failed to initialize vblank\n");
 		goto err_periph_clk_disable;
 	}
 
-	drm_mode_config_reset(dev);
-
-	ret = drm_vblank_init(dev, 1);
+	ret = atmel_hlcdc_dc_modeset_init(dev);
 	if (ret < 0) {
-		dev_err(dev->dev, "failed to initialize vblank\n");
+		dev_err(dev->dev, "failed to initialize mode setting\n");
 		goto err_periph_clk_disable;
 	}
 
+	drm_mode_config_reset(dev);
+
 	pm_runtime_get_sync(dev->dev);
 	ret = drm_irq_install(dev, dc->hlcdc->irq);
 	pm_runtime_put_sync(dev->dev);
-- 
2.1.4
