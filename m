From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Tue, 03 Jul 2018 17:43:14 +0200
Subject: [PATCH] drm/sun4i: Implement zpos for DE2
In-Reply-To: <20180627164514.4777-1-jernej.skrabec@siol.net>
References: <20180627164514.4777-1-jernej.skrabec@siol.net>
Message-ID: <933590049d8979ed2665b41fb065f8008a70a1ef.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-06-27 at 18:45 +0200, Jernej Skrabec wrote:
> Initial implementation of DE2 planes only supported fixed zpos.
> 
> Expand implementation with configurable zpos property.

Thanks for adding support for this! Tested with the Sunxi-Cedrus VPU
driver on H3 with:
https://github.com/free-electrons/cedrus-frame-test/commit/9f46aa83cae1b9fa4d4901d3d2999c8d41265532

Tested-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 15 +++++++--
>  drivers/gpu/drm/sun4i/sun8i_mixer.h    |  4 +++
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 45 ++++++++++++++++----------
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 45 ++++++++++++++++----------
>  4 files changed, 72 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> index ee8febb25903..0747a9a69654 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -260,6 +260,17 @@ const struct de2_fmt_info *sun8i_mixer_format_info(u32 format)
>  	return NULL;
>  }
>  
> +static void sun8i_mixer_atomic_begin(struct sunxi_engine *engine,
> +				     struct drm_crtc_state *old_state)
> +{
> +	/*
> +	 * Disable all pipes at the beginning. They will be enabled
> +	 * again if needed in plane update callback.
> +	 */
> +	regmap_update_bits(engine->regs, SUN8I_MIXER_BLEND_PIPE_CTL,
> +			   SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK, 0);
> +}
> +
>  static void sun8i_mixer_commit(struct sunxi_engine *engine)
>  {
>  	DRM_DEBUG_DRIVER("Committing changes\n");
> @@ -311,6 +322,7 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
>  }
>  
>  static const struct sunxi_engine_ops sun8i_engine_ops = {
> +	.atomic_begin	= sun8i_mixer_atomic_begin,
>  	.commit		= sun8i_mixer_commit,
>  	.layers_init	= sun8i_layers_init,
>  };
> @@ -432,9 +444,6 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
>  	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ATTR_FCOLOR(0),
>  		     SUN8I_MIXER_BLEND_COLOR_BLACK);
>  
> -	/* Fixed zpos for now */
> -	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ROUTE, 0x43210);
> -
>  	plane_cnt = mixer->cfg->vi_num + mixer->cfg->ui_num;
>  	for (i = 0; i < plane_cnt; i++)
>  		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_MODE(i),
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> index f34e70c42adf..406c42e752d7 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> @@ -44,6 +44,7 @@
>  #define SUN8I_MIXER_BLEND_CK_MIN(x)		(0x10e0 + 0x04 * (x))
>  #define SUN8I_MIXER_BLEND_OUTCTL		0x10fc
>  
> +#define SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK	GENMASK(12, 8)
>  #define SUN8I_MIXER_BLEND_PIPE_CTL_EN(pipe)	BIT(8 + pipe)
>  #define SUN8I_MIXER_BLEND_PIPE_CTL_FC_EN(pipe)	BIT(pipe)
>  /* colors are always in AARRGGBB format */
> @@ -51,6 +52,9 @@
>  /* The following numbers are some still unknown magic numbers */
>  #define SUN8I_MIXER_BLEND_MODE_DEF		0x03010301
>  
> +#define SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(n)	(0xf << ((n) << 2))
> +#define SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(n)	((n) << 2)
> +
>  #define SUN8I_MIXER_BLEND_OUTCTL_INTERLACED	BIT(1)
>  
>  #define SUN8I_MIXER_FBFMT_ARGB8888	0
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> index 9a540330cb79..518e1921f47e 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -27,7 +27,7 @@
>  #include "sun8i_ui_scaler.h"
>  
>  static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int channel,
> -				  int overlay, bool enable)
> +				  int overlay, bool enable, unsigned int zpos)
>  {
>  	u32 val;
>  
> @@ -43,18 +43,24 @@ static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int channel,
>  			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(channel, overlay),
>  			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
>  
> -	if (enable)
> -		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(channel);
> -	else
> -		val = 0;
> +	if (enable) {
> +		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
>  
> -	regmap_update_bits(mixer->engine.regs,
> -			   SUN8I_MIXER_BLEND_PIPE_CTL,
> -			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(channel), val);
> +		regmap_update_bits(mixer->engine.regs,
> +				   SUN8I_MIXER_BLEND_PIPE_CTL, val, val);
> +
> +		val = channel << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
> +
> +		regmap_update_bits(mixer->engine.regs,
> +				   SUN8I_MIXER_BLEND_ROUTE,
> +				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(zpos),
> +				   val);
> +	}
>  }
>  
>  static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
> -				       int overlay, struct drm_plane *plane)
> +				       int overlay, struct drm_plane *plane,
> +				       unsigned int zpos)
>  {
>  	struct drm_plane_state *state = plane->state;
>  	u32 src_w, src_h, dst_w, dst_h;
> @@ -137,10 +143,10 @@ static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
>  			 state->dst.x1, state->dst.y1);
>  	DRM_DEBUG_DRIVER("Layer destination size W: %d H: %d\n", dst_w, dst_h);
>  	regmap_write(mixer->engine.regs,
> -		     SUN8I_MIXER_BLEND_ATTR_COORD(channel),
> +		     SUN8I_MIXER_BLEND_ATTR_COORD(zpos),
>  		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
>  	regmap_write(mixer->engine.regs,
> -		     SUN8I_MIXER_BLEND_ATTR_INSIZE(channel),
> +		     SUN8I_MIXER_BLEND_ATTR_INSIZE(zpos),
>  		     outsize);
>  
>  	return 0;
> @@ -238,28 +244,30 @@ static void sun8i_ui_layer_atomic_disable(struct drm_plane *plane,
>  	struct sun8i_ui_layer *layer = plane_to_sun8i_ui_layer(plane);
>  	struct sun8i_mixer *mixer = layer->mixer;
>  
> -	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay, false);
> +	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay, false, 0);
>  }
>  
>  static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
>  					 struct drm_plane_state *old_state)
>  {
>  	struct sun8i_ui_layer *layer = plane_to_sun8i_ui_layer(plane);
> +	unsigned int zpos = plane->state->normalized_zpos;
>  	struct sun8i_mixer *mixer = layer->mixer;
>  
>  	if (!plane->state->visible) {
>  		sun8i_ui_layer_enable(mixer, layer->channel,
> -				      layer->overlay, false);
> +				      layer->overlay, false, 0);
>  		return;
>  	}
>  
>  	sun8i_ui_layer_update_coord(mixer, layer->channel,
> -				    layer->overlay, plane);
> +				    layer->overlay, plane, zpos);
>  	sun8i_ui_layer_update_formats(mixer, layer->channel,
>  				      layer->overlay, plane);
>  	sun8i_ui_layer_update_buffer(mixer, layer->channel,
>  				     layer->overlay, plane);
> -	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay, true);
> +	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay,
> +			      true, zpos);
>  }
>  
>  static struct drm_plane_helper_funcs sun8i_ui_layer_helper_funcs = {
> @@ -307,6 +315,7 @@ struct sun8i_ui_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
>  	enum drm_plane_type type = DRM_PLANE_TYPE_OVERLAY;
>  	int channel = mixer->cfg->vi_num + index;
>  	struct sun8i_ui_layer *layer;
> +	unsigned int plane_cnt;
>  	int ret;
>  
>  	layer = devm_kzalloc(drm->dev, sizeof(*layer), GFP_KERNEL);
> @@ -327,8 +336,10 @@ struct sun8i_ui_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
>  		return ERR_PTR(ret);
>  	}
>  
> -	/* fixed zpos for now */
> -	ret = drm_plane_create_zpos_immutable_property(&layer->plane, channel);
> +	plane_cnt = mixer->cfg->ui_num + mixer->cfg->vi_num;
> +
> +	ret = drm_plane_create_zpos_property(&layer->plane, channel,
> +					     0, plane_cnt - 1);
>  	if (ret) {
>  		dev_err(drm->dev, "Couldn't add zpos property\n");
>  		return ERR_PTR(ret);
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> index 5877f8ef5895..17e0d00cfd8a 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -21,7 +21,7 @@
>  #include "sun8i_vi_scaler.h"
>  
>  static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel,
> -				  int overlay, bool enable)
> +				  int overlay, bool enable, unsigned int zpos)
>  {
>  	u32 val;
>  
> @@ -37,18 +37,24 @@ static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel,
>  			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(channel, overlay),
>  			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN, val);
>  
> -	if (enable)
> -		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(channel);
> -	else
> -		val = 0;
> +	if (enable) {
> +		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
>  
> -	regmap_update_bits(mixer->engine.regs,
> -			   SUN8I_MIXER_BLEND_PIPE_CTL,
> -			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(channel), val);
> +		regmap_update_bits(mixer->engine.regs,
> +				   SUN8I_MIXER_BLEND_PIPE_CTL, val, val);
> +
> +		val = channel << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
> +
> +		regmap_update_bits(mixer->engine.regs,
> +				   SUN8I_MIXER_BLEND_ROUTE,
> +				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(zpos),
> +				   val);
> +	}
>  }
>  
>  static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
> -				       int overlay, struct drm_plane *plane)
> +				       int overlay, struct drm_plane *plane,
> +				       unsigned int zpos)
>  {
>  	struct drm_plane_state *state = plane->state;
>  	const struct drm_format_info *format = state->fb->format;
> @@ -130,10 +136,10 @@ static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
>  			 state->dst.x1, state->dst.y1);
>  	DRM_DEBUG_DRIVER("Layer destination size W: %d H: %d\n", dst_w, dst_h);
>  	regmap_write(mixer->engine.regs,
> -		     SUN8I_MIXER_BLEND_ATTR_COORD(channel),
> +		     SUN8I_MIXER_BLEND_ATTR_COORD(zpos),
>  		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
>  	regmap_write(mixer->engine.regs,
> -		     SUN8I_MIXER_BLEND_ATTR_INSIZE(channel),
> +		     SUN8I_MIXER_BLEND_ATTR_INSIZE(zpos),
>  		     outsize);
>  
>  	return 0;
> @@ -266,28 +272,30 @@ static void sun8i_vi_layer_atomic_disable(struct drm_plane *plane,
>  	struct sun8i_vi_layer *layer = plane_to_sun8i_vi_layer(plane);
>  	struct sun8i_mixer *mixer = layer->mixer;
>  
> -	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, false);
> +	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, false, 0);
>  }
>  
>  static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
>  					 struct drm_plane_state *old_state)
>  {
>  	struct sun8i_vi_layer *layer = plane_to_sun8i_vi_layer(plane);
> +	unsigned int zpos = plane->state->normalized_zpos;
>  	struct sun8i_mixer *mixer = layer->mixer;
>  
>  	if (!plane->state->visible) {
>  		sun8i_vi_layer_enable(mixer, layer->channel,
> -				      layer->overlay, false);
> +				      layer->overlay, false, 0);
>  		return;
>  	}
>  
>  	sun8i_vi_layer_update_coord(mixer, layer->channel,
> -				    layer->overlay, plane);
> +				    layer->overlay, plane, zpos);
>  	sun8i_vi_layer_update_formats(mixer, layer->channel,
>  				      layer->overlay, plane);
>  	sun8i_vi_layer_update_buffer(mixer, layer->channel,
>  				     layer->overlay, plane);
> -	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, true);
> +	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay,
> +			      true, zpos);
>  }
>  
>  static struct drm_plane_helper_funcs sun8i_vi_layer_helper_funcs = {
> @@ -351,6 +359,7 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
>  					       int index)
>  {
>  	struct sun8i_vi_layer *layer;
> +	unsigned int plane_cnt;
>  	int ret;
>  
>  	layer = devm_kzalloc(drm->dev, sizeof(*layer), GFP_KERNEL);
> @@ -368,8 +377,10 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
>  		return ERR_PTR(ret);
>  	}
>  
> -	/* fixed zpos for now */
> -	ret = drm_plane_create_zpos_immutable_property(&layer->plane, index);
> +	plane_cnt = mixer->cfg->ui_num + mixer->cfg->vi_num;
> +
> +	ret = drm_plane_create_zpos_property(&layer->plane, index,
> +					     0, plane_cnt - 1);
>  	if (ret) {
>  		dev_err(drm->dev, "Couldn't add zpos property\n");
>  		return ERR_PTR(ret);
-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180703/1da698be/attachment.sig>
