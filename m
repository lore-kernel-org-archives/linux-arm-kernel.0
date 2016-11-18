From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Fri, 18 Nov 2016 19:18:47 +0100
Subject: [PATCH] drm/sun4i: Fix a return value in case of error
Message-ID: <20161118181847.8436-1-christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If 'sun4i_backend_drm_format_to_layer()' does not return 0, then 'val' is
left unmodified.
As it is not initialized either, the return value can be anything.

It is likely that returning the error code was expected here.

As the only caller of 'sun4i_backend_update_layer_formats()' does not check
the return value, this fix is purely theorical.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 7eb2a965f83d..f724b8047bae 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -192,7 +192,7 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
 	ret = sun4i_backend_drm_format_to_layer(plane, fb->pixel_format, &val);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid format\n");
-		return val;
+		return ret;
 	}
 
 	regmap_update_bits(backend->regs, SUN4I_BACKEND_ATTCTL_REG1(layer),
-- 
2.9.3
