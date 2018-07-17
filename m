From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Tue, 17 Jul 2018 15:58:45 +0200
Subject: [PATCH v2] drm/sun4i: sun8i: Avoid clearing blending order at
 each atomic commit
In-Reply-To: <20180717122522.11327-1-paul.kocialkowski@bootlin.com>
References: <20180717122522.11327-1-paul.kocialkowski@bootlin.com>
Message-ID: <a2a18893c1867f4fbb905da4f749a0e69f327103.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-07-17 at 14:25 +0200, Paul Kocialkowski wrote:
> Blending order is set based on the z position of each DRM plane. The
> blending order register is currently cleared at each atomic DRM commit,
> with the intent that each committed plane will set the appropriate
> bits (based on its z-pos) when enabling the plane.
> 
> However, it sometimes happens that a particular plane is left unchanged
> by an atomic commit and thus will not be configured again. In that
> scenario, blending order is cleared and only the bits relevant for the
> planes affected by the commit are set. This leaves the planes that did
> not change without their blending order set in the register, leading
> to that plane not being displayed.
> 
> Instead of clearing the blending order register at every atomic commit,
> this change moves the register's initial clear at bind time and only
> clears the bits for a specific plane when disabling it or changing its
> zpos.
> 
> This way, planes that are left untouched by a DRM atomic commit are
> no longer disabled.

This patch was rebased to apply on top of DRM misc. V1 had been based on
the first revision of the DE2 z-pos support patch, while a subsequent
revision of the patch made it to the kernel tree.

Cheers!

Paul

> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 15 +++------------
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 24 ++++++++++++++++++++----
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 24 ++++++++++++++++++++----
>  3 files changed, 43 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> index 8e81c24d736e..12cb7183ce51 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -260,17 +260,6 @@ const struct de2_fmt_info *sun8i_mixer_format_info(u32 format)
>  	return NULL;
>  }
>  
> -static void sun8i_mixer_atomic_begin(struct sunxi_engine *engine,
> -				     struct drm_crtc_state *old_state)
> -{
> -	/*
> -	 * Disable all pipes at the beginning. They will be enabled
> -	 * again if needed in plane update callback.
> -	 */
> -	regmap_update_bits(engine->regs, SUN8I_MIXER_BLEND_PIPE_CTL,
> -			   SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK, 0);
> -}
> -
>  static void sun8i_mixer_commit(struct sunxi_engine *engine)
>  {
>  	DRM_DEBUG_DRIVER("Committing changes\n");
> @@ -322,7 +311,6 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
>  }
>  
>  static const struct sunxi_engine_ops sun8i_engine_ops = {
> -	.atomic_begin	= sun8i_mixer_atomic_begin,
>  	.commit		= sun8i_mixer_commit,
>  	.layers_init	= sun8i_layers_init,
>  };
> @@ -449,6 +437,9 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
>  		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_MODE(i),
>  			     SUN8I_MIXER_BLEND_MODE_DEF);
>  
> +	regmap_update_bits(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL,
> +			   SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK, 0);
> +
>  	return 0;
>  
>  err_disable_bus_clk:
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> index 518e1921f47e..28c15c6ef1ef 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -27,7 +27,8 @@
>  #include "sun8i_ui_scaler.h"
>  
>  static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int channel,
> -				  int overlay, bool enable, unsigned int zpos)
> +				  int overlay, bool enable, unsigned int zpos,
> +				  unsigned int old_zpos)
>  {
>  	u32 val;
>  
> @@ -43,6 +44,18 @@ static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int channel,
>  			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(channel, overlay),
>  			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
>  
> +	if (!enable || zpos != old_zpos) {
> +		regmap_update_bits(mixer->engine.regs,
> +				   SUN8I_MIXER_BLEND_PIPE_CTL,
> +				   SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
> +				   0);
> +
> +		regmap_update_bits(mixer->engine.regs,
> +				   SUN8I_MIXER_BLEND_ROUTE,
> +				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
> +				   0);
> +	}
> +
>  	if (enable) {
>  		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
>  
> @@ -242,9 +255,11 @@ static void sun8i_ui_layer_atomic_disable(struct drm_plane *plane,
>  					  struct drm_plane_state *old_state)
>  {
>  	struct sun8i_ui_layer *layer = plane_to_sun8i_ui_layer(plane);
> +	unsigned int old_zpos = old_state->normalized_zpos;
>  	struct sun8i_mixer *mixer = layer->mixer;
>  
> -	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay, false, 0);
> +	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay, false, 0,
> +			      old_zpos);
>  }
>  
>  static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
> @@ -252,11 +267,12 @@ static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
>  {
>  	struct sun8i_ui_layer *layer = plane_to_sun8i_ui_layer(plane);
>  	unsigned int zpos = plane->state->normalized_zpos;
> +	unsigned int old_zpos = old_state->normalized_zpos;
>  	struct sun8i_mixer *mixer = layer->mixer;
>  
>  	if (!plane->state->visible) {
>  		sun8i_ui_layer_enable(mixer, layer->channel,
> -				      layer->overlay, false, 0);
> +				      layer->overlay, false, 0, old_zpos);
>  		return;
>  	}
>  
> @@ -267,7 +283,7 @@ static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
>  	sun8i_ui_layer_update_buffer(mixer, layer->channel,
>  				     layer->overlay, plane);
>  	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay,
> -			      true, zpos);
> +			      true, zpos, old_zpos);
>  }
>  
>  static struct drm_plane_helper_funcs sun8i_ui_layer_helper_funcs = {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> index 17e0d00cfd8a..f4fe97813f94 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -21,7 +21,8 @@
>  #include "sun8i_vi_scaler.h"
>  
>  static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel,
> -				  int overlay, bool enable, unsigned int zpos)
> +				  int overlay, bool enable, unsigned int zpos,
> +				  unsigned int old_zpos)
>  {
>  	u32 val;
>  
> @@ -37,6 +38,18 @@ static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel,
>  			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(channel, overlay),
>  			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN, val);
>  
> +	if (!enable || zpos != old_zpos) {
> +		regmap_update_bits(mixer->engine.regs,
> +				   SUN8I_MIXER_BLEND_PIPE_CTL,
> +				   SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
> +				   0);
> +
> +		regmap_update_bits(mixer->engine.regs,
> +				   SUN8I_MIXER_BLEND_ROUTE,
> +				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
> +				   0);
> +	}
> +
>  	if (enable) {
>  		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
>  
> @@ -270,9 +283,11 @@ static void sun8i_vi_layer_atomic_disable(struct drm_plane *plane,
>  					  struct drm_plane_state *old_state)
>  {
>  	struct sun8i_vi_layer *layer = plane_to_sun8i_vi_layer(plane);
> +	unsigned int old_zpos = old_state->normalized_zpos;
>  	struct sun8i_mixer *mixer = layer->mixer;
>  
> -	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, false, 0);
> +	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, false, 0,
> +			      old_zpos);
>  }
>  
>  static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
> @@ -280,11 +295,12 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
>  {
>  	struct sun8i_vi_layer *layer = plane_to_sun8i_vi_layer(plane);
>  	unsigned int zpos = plane->state->normalized_zpos;
> +	unsigned int old_zpos = old_state->normalized_zpos;
>  	struct sun8i_mixer *mixer = layer->mixer;
>  
>  	if (!plane->state->visible) {
>  		sun8i_vi_layer_enable(mixer, layer->channel,
> -				      layer->overlay, false, 0);
> +				      layer->overlay, false, 0, old_zpos);
>  		return;
>  	}
>  
> @@ -295,7 +311,7 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
>  	sun8i_vi_layer_update_buffer(mixer, layer->channel,
>  				     layer->overlay, plane);
>  	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay,
> -			      true, zpos);
> +			      true, zpos, old_zpos);
>  }
>  
>  static struct drm_plane_helper_funcs sun8i_vi_layer_helper_funcs = {
-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 484 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180717/b4cee451/attachment-0001.sig>
