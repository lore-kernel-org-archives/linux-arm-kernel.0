From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  3 May 2016 17:23:28 +0200
Subject: [PATCH] drm: sun4i: print DMA address correctly
Message-ID: <1462289020-774976-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added sun4i drm driver prints a dma address using the %x
format string, which cannot work when dma_addr_t is 64 bit,
and gcc warns about this configuration:

drm/sun4i/sun4i_backend.c: In function 'sun4i_backend_update_layer_buffer':
drm/sun4i/sun4i_backend.c:193:84: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'dma_addr_t {aka long long unsigned int}' [-Werror=format=]
  DRM_DEBUG_DRIVER("Using GEM @ 0x%x\n", gem->paddr);
drm/sun4i/sun4i_backend.c:201:84: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'dma_addr_t {aka long long unsigned int}' [-Werror=format=]
  DRM_DEBUG_DRIVER("Setting buffer address to 0x%x\n", paddr);

This changes the code to use the explicit %pad format string, which
always prints the right length.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index f7a15c1a93bf..3ab560450a82 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -190,7 +190,7 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 	/* Get the physical address of the buffer in memory */
 	gem = drm_fb_cma_get_gem_obj(fb, 0);
 
-	DRM_DEBUG_DRIVER("Using GEM @ 0x%x\n", gem->paddr);
+	DRM_DEBUG_DRIVER("Using GEM @ %pad\n", &gem->paddr);
 
 	/* Compute the start of the displayed memory */
 	bpp = drm_format_plane_cpp(fb->pixel_format, 0);
@@ -198,7 +198,7 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 	paddr += (state->src_x >> 16) * bpp;
 	paddr += (state->src_y >> 16) * fb->pitches[0];
 
-	DRM_DEBUG_DRIVER("Setting buffer address to 0x%x\n", paddr);
+	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
 
 	/* Write the 32 lower bits of the address (in bits) */
 	lo_paddr = paddr << 3;
-- 
2.7.0
