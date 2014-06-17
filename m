From: guido@vanguardiasur.com.ar (=?UTF-8?q?Guido=20Mart=C3=ADnez?=)
Date: Tue, 17 Jun 2014 11:17:07 -0300
Subject: [PATCH/RESEND 5/9] drm/tilcdc: panel: fix leak when unloading the
 module
In-Reply-To: <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Message-ID: <1403014631-18072-6-git-send-email-guido@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver did not unregister the allocated framebuffer, which caused
memory leaks (and memory manager WARNs) when unloading. Also, the
framebuffer device under /dev still existed after unloading.

Add a call to drm_fbdev_cma_fini when unloading the module to prevent
both issues.

Signed-off-by: Guido Mart?nez <guido@vanguardiasur.com.ar>
Cc: <stable@vger.kernel.org> #v3.9+
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index b20b694..490aee7 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -122,6 +122,7 @@ static int tilcdc_unload(struct drm_device *dev)
 	struct tilcdc_drm_private *priv = dev->dev_private;
 	struct tilcdc_module *mod, *cur;
 
+	drm_fbdev_cma_fini(priv->fbdev);
 	drm_kms_helper_poll_fini(dev);
 	drm_mode_config_cleanup(dev);
 	drm_vblank_cleanup(dev);
-- 
2.0.0
