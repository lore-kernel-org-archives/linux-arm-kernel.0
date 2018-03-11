From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Mon, 12 Mar 2018 00:19:09 +0100
Subject: [PATCH] drm/sun4i: Fix an error handling path in 'sun4i_drv_bind()'
Message-ID: <20180311231909.5381-1-christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 070badfab767 ("drm/sun4i: call drm_vblank_init with correct number
of crtcs") has moved some code without updating the error handling gotos
accordingly.

Branch to the correct label and remove a now unused lablel.

Fixes: 070badfab767 ("drm/sun4i: call drm_vblank_init with correct number of crtcs")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 4570da0227b4..d9a71f361b14 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -111,7 +111,7 @@ static int sun4i_drv_bind(struct device *dev)
 	/* drm_vblank_init calls kcalloc, which can fail */
 	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
 	if (ret)
-		goto free_mem_region;
+		goto cleanup_mode_config;
 
 	drm->irq_enabled = true;
 
@@ -139,7 +139,6 @@ static int sun4i_drv_bind(struct device *dev)
 	sun4i_framebuffer_free(drm);
 cleanup_mode_config:
 	drm_mode_config_cleanup(drm);
-free_mem_region:
 	of_reserved_mem_device_release(dev);
 free_drm:
 	drm_dev_unref(drm);
-- 
2.14.1


---
L'absence de virus dans ce courrier ?lectronique a ?t? v?rifi?e par le logiciel antivirus Avast.
https://www.avast.com/antivirus
