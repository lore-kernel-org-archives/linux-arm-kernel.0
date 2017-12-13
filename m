From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 13 Dec 2017 17:06:14 +0100
Subject: [PATCH 4/8] drm/sun4i: crtc: Add a custom crtc atomic_check
In-Reply-To: <f7ce67ed8b926609a9d9290696a036b103be233c.1513178989.git-series.maxime.ripard@free-electrons.com>
References: <cover.63722fe4aeb908cf3c6f73874bdf69b193fe43c9.1513178989.git-series.maxime.ripard@free-electrons.com>
 <f7ce67ed8b926609a9d9290696a036b103be233c.1513178989.git-series.maxime.ripard@free-electrons.com>
Message-ID: <1907c50b-d8a9-47db-d5c6-129a430a105f@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/2017 16:33, Maxime Ripard wrote:
> We have some restrictions on what the planes and CRTC can provide that are
> tied to only one generation of display engines.
> 
> For example, on the first generation, we can only have one YUV plane or one
> plane that uses the frontend output.
> 
> Let's allow our engines to provide an atomic_check callback to validate the
> current configuration.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_crtc.c   | 14 ++++++++++++++
>  drivers/gpu/drm/sun4i/sunxi_engine.h |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
> index 5decae0069d0..2a565325714f 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
> @@ -46,6 +46,19 @@ static struct drm_encoder *sun4i_crtc_get_encoder(struct drm_crtc *crtc)
>  	return NULL;
>  }
>  
> +static int sun4i_crtc_atomic_check(struct drm_crtc *crtc,
> +				    struct drm_crtc_state *state)
> +{
> +	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
> +	struct sunxi_engine *engine = scrtc->engine;
> +	int ret = 0;
> +
> +	if (engine && engine->ops && engine->ops->atomic_check)
> +		ret = engine->ops->atomic_check(engine, state);
> +
> +	return ret;
> +}
> +
>  static void sun4i_crtc_atomic_begin(struct drm_crtc *crtc,
>  				    struct drm_crtc_state *old_state)
>  {
> @@ -125,6 +138,7 @@ static void sun4i_crtc_mode_set_nofb(struct drm_crtc *crtc)
>  }
>  
>  static const struct drm_crtc_helper_funcs sun4i_crtc_helper_funcs = {
> +	.atomic_check	= sun4i_crtc_atomic_check,
>  	.atomic_begin	= sun4i_crtc_atomic_begin,
>  	.atomic_flush	= sun4i_crtc_atomic_flush,
>  	.atomic_enable	= sun4i_crtc_atomic_enable,
> diff --git a/drivers/gpu/drm/sun4i/sunxi_engine.h b/drivers/gpu/drm/sun4i/sunxi_engine.h
> index 4cb70ae65c79..42655230aeba 100644
> --- a/drivers/gpu/drm/sun4i/sunxi_engine.h
> +++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
> @@ -16,6 +16,8 @@ struct drm_device;
>  struct sunxi_engine;
>  
>  struct sunxi_engine_ops {
> +	int (*atomic_check)(struct sunxi_engine *engine,
> +			    struct drm_crtc_state *state);
>  	void (*commit)(struct sunxi_engine *engine);
>  	struct drm_plane **(*layers_init)(struct drm_device *drm,
>  					  struct sunxi_engine *engine);
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
