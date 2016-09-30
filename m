From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 30 Sep 2016 18:08:26 +0200
Subject: [PATCH] drm/sun4i: Check that the plane coordinates are not
 negative
In-Reply-To: <20160930143320.26241-1-maxime.ripard@free-electrons.com>
References: <20160930143320.26241-1-maxime.ripard@free-electrons.com>
Message-ID: <20160930180826.169e3daf@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Sep 2016 16:33:20 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Our planes cannot be set at negative coordinates. Make sure we reject such
> configuration.
> 
> Reported-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_layer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
> index f0035bf5efea..f5463c4c2cde 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> @@ -29,6 +29,9 @@ struct sun4i_plane_desc {
>  static int sun4i_backend_layer_atomic_check(struct drm_plane *plane,
>  					    struct drm_plane_state *state)
>  {
> +	if ((state->crtc_x < 0) || (state->crtc_y < 0))
> +		return -EINVAL;
> +

Hm, I think it's a perfectly valid use case from the DRM framework and
DRM user PoV: you may want to place your plane at a negative CRTC
offset (which means part of the plane will be hidden).

Maybe I'm wrong, but it seems you can support that by adapting the
start address of your framebuffer pointer and the layer size.

Have you tried doing something like that?

--->8---
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 3ab560450a82..6b68804f3035 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -110,15 +110,30 @@ int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
 {
        struct drm_plane_state *state = plane->state;
        struct drm_framebuffer *fb = state->fb;
+       int crtc_w, crtc_h, crtc_x, crtc_y;
 
        DRM_DEBUG_DRIVER("Updating layer %d\n", layer);
 
+       crtc_x = state->crtc_x;
+       crtc_y = state->crtc_y;
+       crtc_w = state->crtc_w;
+       crtc_h = state->crtc_h;
+
+       if (crtc_x < 0) {
+               crtc_w += crtx_x;
+               crtc_x = 0;
+       }
+
+       if (crtc_y < 0) {
+               crtc_h += crtx_y;
+               crtc_y = 0;
+       }
+
        if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
                DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: %u\n",
                                 state->crtc_w, state->crtc_h);
                regmap_write(backend->regs, SUN4I_BACKEND_DISSIZE_REG,
-                            SUN4I_BACKEND_DISSIZE(state->crtc_w,
-                                                  state->crtc_h));
+                            SUN4I_BACKEND_DISSIZE(crtc_w, crtc_h));
        }
 
        /* Set the line width */
@@ -130,15 +145,13 @@ int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
        DRM_DEBUG_DRIVER("Layer size W: %u H: %u\n",
                         state->crtc_w, state->crtc_h);
        regmap_write(backend->regs, SUN4I_BACKEND_LAYSIZE_REG(layer),
-                    SUN4I_BACKEND_LAYSIZE(state->crtc_w,
-                                          state->crtc_h));
+                    SUN4I_BACKEND_LAYSIZE(crtc_w, crtc_h));
 
        /* Set base coordinates */
        DRM_DEBUG_DRIVER("Layer coordinates X: %d Y: %d\n",
                         state->crtc_x, state->crtc_y);
        regmap_write(backend->regs, SUN4I_BACKEND_LAYCOOR_REG(layer),
-                    SUN4I_BACKEND_LAYCOOR(state->crtc_x,
-                                          state->crtc_y));
+                    SUN4I_BACKEND_LAYCOOR(crtc_x, crtc_y));
 
        return 0;
 }
@@ -198,6 +211,12 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
        paddr += (state->src_x >> 16) * bpp;
        paddr += (state->src_y >> 16) * fb->pitches[0];
 
+       if (state->crtc_x < 0)
+               paddr -= bpp * state->crtc_x;
+
+       if (state->crtc_y < 0)
+               paddr -= fb->pitches[0] * state->crtc_y;
+
        DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
 
        /* Write the 32 lower bits of the address (in bits) */
