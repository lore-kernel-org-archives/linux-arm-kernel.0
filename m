From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 17 Jul 2018 14:25:47 +0200
Subject: [PATCH 2/2] drm/sun4i: sun4i: Introduce a quirk for lowest plane
 alpha support
In-Reply-To: <20180717085230.17472-2-paul.kocialkowski@bootlin.com>
References: <20180717085230.17472-1-paul.kocialkowski@bootlin.com>
 <20180717085230.17472-2-paul.kocialkowski@bootlin.com>
Message-ID: <20180717122547.d5tkizuuj6676ilc@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 10:52:30AM +0200, Paul Kocialkowski wrote:
> Not all sunxi platforms with the first version of the Display Engine
> support an alpha component on the plane with the lowest z position
> (as in: lowest z-pos), that gets blended with the background color.
> 
> In particular, the A13 is known to have this limitation. However, it was
> recently discovered that the A20 and A33 are capable of having alpha on
> their lowest plane.
> 
> Thus, this introduces a specific quirk to indicate such support,
> per-platform. Since this was not tested on sun4i and sun6i platforms, a
> conservative approach is kept and this feature is not supported.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_backend.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index a3cc398d4d80..cdc4a8a91ea2 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -35,6 +35,8 @@
>  struct sun4i_backend_quirks {
>  	/* backend <-> TCON muxing selection done in backend */
>  	bool needs_output_muxing;
> +	/* alpha at the lowest z position is not always supported */
> +	bool supports_lowest_plane_alpha;
>  };
>  
>  static void sun4i_backend_apply_color_correction(struct sunxi_engine *engine)
> @@ -484,6 +486,7 @@ static void sun4i_backend_atomic_begin(struct sunxi_engine *engine,
>  static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
>  				      struct drm_crtc_state *crtc_state)
>  {
> +	struct sun4i_backend *backend = engine_to_sun4i_backend(engine);
>  	struct drm_plane_state *plane_states[SUN4I_BACKEND_NUM_LAYERS] = { 0 };

Your new variable should be here.

>  	struct drm_atomic_state *state = crtc_state->state;
>  	struct drm_device *drm = state->dev;
> @@ -584,8 +587,9 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
>  	}
>  
>  	/* We can't have an alpha plane at the lowest position */
> -	if (plane_states[0]->fb->format->has_alpha ||
> -	    (plane_states[0]->alpha != DRM_BLEND_ALPHA_OPAQUE))
> +	if ((plane_states[0]->fb->format->has_alpha ||
> +	    (plane_states[0]->alpha != DRM_BLEND_ALPHA_OPAQUE)) &&
> +	    !backend->quirks->supports_lowest_plane_alpha)
>  		return -EINVAL;

This only partially does the job. This only allows to have an alpha
plane at the lowest position, but the fact that the alpha works at the
lowest position also means you can have two alpha planes now, and you
didn't change that check.

The pipe allocation algorithm would also need to be checked.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180717/1bf69ece/attachment.sig>
