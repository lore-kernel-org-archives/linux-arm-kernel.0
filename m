From: andre.przywara@arm.com (Andre Przywara)
Date: Fri,  3 Jun 2016 17:57:31 +0100
Subject: [PATCH] drm: sun4i: fix LPAE warnings
Message-ID: <1464973051-20432-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the sun4i DRM driver is compiled with LPAE enabled, dma_addr_t turns
into a 64-bit type, which causes warnings with some debug printks:
=================
In file included from
drivers/gpu/drm/sun4i/sun4i_backend.c:13::
drivers/gpu/drm/sun4i/sun4i_backend.c: In function 'sun4i_backend_update_layer_buffer':
drivers/gpu/drm/sun4i/sun4i_backend.c:193:19: warning:
format '%x' expects argument of type 'unsigned int', but argument 3 has
type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]
  DRM_DEBUG_DRIVER("Using GEM @ 0x%x\n", gem->paddr);
                   ^
include/drm/drmP.h:207:34: note: in definition of macro
'DRM_DEBUG_DRIVER'
    drm_ut_debug_printk(__func__, fmt, ##args); \
.....

Use the proper printk format specifier [1] for dma_addr_t which takes
care of those differences.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>

[1] Documentation/printk-formats.txt
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index f7a15c1..2568e7d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -190,7 +190,7 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 	/* Get the physical address of the buffer in memory */
 	gem = drm_fb_cma_get_gem_obj(fb, 0);
 
-	DRM_DEBUG_DRIVER("Using GEM @ 0x%x\n", gem->paddr);
+	DRM_DEBUG_DRIVER("Using GEM @ 0x%pad\n", &gem->paddr);
 
 	/* Compute the start of the displayed memory */
 	bpp = drm_format_plane_cpp(fb->pixel_format, 0);
@@ -198,7 +198,7 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 	paddr += (state->src_x >> 16) * bpp;
 	paddr += (state->src_y >> 16) * fb->pitches[0];
 
-	DRM_DEBUG_DRIVER("Setting buffer address to 0x%x\n", paddr);
+	DRM_DEBUG_DRIVER("Setting buffer address to 0x%pad\n", &paddr);
 
 	/* Write the 32 lower bits of the address (in bits) */
 	lo_paddr = paddr << 3;
-- 
2.8.2
