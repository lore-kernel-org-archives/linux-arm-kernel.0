From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Tue, 28 Nov 2017 19:49:53 +0100
Subject: [PATCH 01/17] drm/sun4i: Refactor DE2 code
In-Reply-To: <20171128155442.fpmmf4xfb3rbf67p@flea.home>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
 <20171127205750.19277-2-jernej.skrabec@siol.net>
 <20171128155442.fpmmf4xfb3rbf67p@flea.home>
Message-ID: <2003282.xphKHtc6QX@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Dne torek, 28. november 2017 ob 16:54:42 CET je Maxime Ripard napisal(a):
> Hi,
> 
> On Mon, Nov 27, 2017 at 09:57:34PM +0100, Jernej Skrabec wrote:
> > Since the time initial DE2 driver was written, some knowledge was gained
> > what setting are really necessary and what most of the magic values
> > mean.
> > 
> > This commit renames some of the macro names to better fit the real
> > meaning, replace default values with self explaining macros where
> > possible and removes settings which are not really needed.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> While those changes are quite welcome, it should be split in a number
> of patches...

You're right, I went over the changes again and now I have 8 patches instead 
of one with much more explanation why each change is needed.

I'll send v2 as soon as I get some feedback on rest of the series.

Regards,
Jernej

> 
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun8i_mixer.c | 65
> >  +++++++++++++++++++------------------
> >  drivers/gpu/drm/sun4i/sun8i_mixer.h | 31 ++++++++----------
> >  2 files changed, 47 insertions(+), 49 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > b/drivers/gpu/drm/sun4i/sun8i_mixer.c index cb193c5f1686..015943c0ed5a
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > @@ -44,7 +44,8 @@ void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
> > 
> >  	/* Currently the first UI channel is used */
> >  	int chan = mixer->cfg->vi_num;
> > 
> > -	DRM_DEBUG_DRIVER("Enabling layer %d in channel %d\n", layer, chan);
> > +	DRM_DEBUG_DRIVER("%sabling layer %d in channel %d\n",
> > +			 enable ? "En" : "Dis", layer, chan);
> > 
> >  	if (enable)
> >  	
> >  		val = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN;
> > 
> > @@ -55,15 +56,14 @@ void sun8i_mixer_layer_enable(struct sun8i_mixer
> > *mixer,> 
> >  			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
> >  			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
> > 
> > -	/* Set the alpha configuration */
> > -	regmap_update_bits(mixer->engine.regs,
> > -			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
> > -			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK,
> > -			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_DEF);
> > +	if (enable)
> > +		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(chan);
> > +	else
> > +		val = 0;
> > +
> > 
> >  	regmap_update_bits(mixer->engine.regs,
> > 
> > -			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
> > -			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK,
> > -			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_DEF);
> > +			   SUN8I_MIXER_BLEND_PIPE_CTL,
> > +			   SUN8I_MIXER_BLEND_PIPE_CTL_EN(chan), val);
> 
> ... For example, this part right here will remove the alpha setup
> part, without any justification in the commit log ...
> 
> >  }
> >  
> >  static int sun8i_mixer_drm_format_to_layer(struct drm_plane *plane,
> > 
> > @@ -71,15 +71,15 @@ static int sun8i_mixer_drm_format_to_layer(struct
> > drm_plane *plane,> 
> >  {
> >  
> >  	switch (format) {
> > 
> >  	case DRM_FORMAT_ARGB8888:
> > -		*mode = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_ARGB8888;
> > +		*mode = SUN8I_MIXER_FBFMT_ARGB8888;
> > 
> >  		break;
> >  	
> >  	case DRM_FORMAT_XRGB8888:
> > -		*mode = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_XRGB8888;
> > +		*mode = SUN8I_MIXER_FBFMT_XRGB8888;
> > 
> >  		break;
> >  	
> >  	case DRM_FORMAT_RGB888:
> > -		*mode = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_RGB888;
> > +		*mode = SUN8I_MIXER_FBFMT_RGB888;
> > 
> >  		break;
> >  	
> >  	default:
> > @@ -107,7 +107,7 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer
> > *mixer,> 
> >  					      state->crtc_h));
> >  		
> >  		DRM_DEBUG_DRIVER("Updating blender size\n");
> >  		regmap_write(mixer->engine.regs,
> > 
> > -			     SUN8I_MIXER_BLEND_ATTR_INSIZE(0),
> > +			     SUN8I_MIXER_BLEND_ATTR_INSIZE(chan),
> 
> I guess that one is fixing a bug too.
> 
> >  			     SUN8I_MIXER_SIZE(state->crtc_w,
> >  			     
> >  					      state->crtc_h));
> >  		
> >  		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_OUTSIZE,
> > 
> > @@ -173,6 +173,7 @@ int sun8i_mixer_update_layer_formats(struct
> > sun8i_mixer *mixer,> 
> >  		return ret;
> >  	
> >  	}
> > 
> > +	val <<= SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET;
> > 
> >  	regmap_update_bits(mixer->engine.regs,
> >  	
> >  			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
> >  			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK, val);
> > 
> > @@ -247,6 +248,7 @@ static int sun8i_mixer_bind(struct device *dev, struct
> > device *master,> 
> >  	struct sun8i_mixer *mixer;
> >  	struct resource *res;
> >  	void __iomem *regs;
> > 
> > +	int plane_cnt;
> > 
> >  	int i, ret;
> >  	
> >  	/*
> > 
> > @@ -325,27 +327,26 @@ static int sun8i_mixer_bind(struct device *dev,
> > struct device *master,> 
> >  	regmap_write(mixer->engine.regs, SUN8I_MIXER_GLOBAL_CTL,
> >  	
> >  		     SUN8I_MIXER_GLOBAL_CTL_RT_EN);
> > 
> > -	/* Initialize blender */
> > -	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_FCOLOR_CTL,
> > -		     SUN8I_MIXER_BLEND_FCOLOR_CTL_DEF);
> > -	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_PREMULTIPLY,
> > -		     SUN8I_MIXER_BLEND_PREMULTIPLY_DEF);
> > +	/* Set background color to black */
> > 
> >  	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_BKCOLOR,
> > 
> > -		     SUN8I_MIXER_BLEND_BKCOLOR_DEF);
> > -	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_MODE(0),
> > -		     SUN8I_MIXER_BLEND_MODE_DEF);
> > -	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_CK_CTL,
> > -		     SUN8I_MIXER_BLEND_CK_CTL_DEF);
> > +		     SUN8I_MIXER_BLEND_COLOR_BLACK);
> > 
> > -	regmap_write(mixer->engine.regs,
> > -		     SUN8I_MIXER_BLEND_ATTR_FCOLOR(0),
> > -		     SUN8I_MIXER_BLEND_ATTR_FCOLOR_DEF);
> > -
> > -	/* Select the first UI channel */
> > -	DRM_DEBUG_DRIVER("Selecting channel %d (first UI channel)\n",
> > -			 mixer->cfg->vi_num);
> > -	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ROUTE,
> > -		     mixer->cfg->vi_num);
> > +	/*
> > +	 * Set fill color of bottom plane to black. Generally not needed
> > +	 * except when VI plane is at bottom (zpos = 0) and enabled.
> > +	 */
> > +	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL,
> > +		     SUN8I_MIXER_BLEND_PIPE_CTL_FC_EN(0));
> > +	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ATTR_FCOLOR(0),
> > +		     SUN8I_MIXER_BLEND_COLOR_BLACK);
> > +
> > +	/* Fixed zpos for now */
> > +	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ROUTE, 0x43210);
> > +
> > +	plane_cnt = mixer->cfg->vi_num + mixer->cfg->ui_num;
> > +	for (i = 0; i < plane_cnt; i++)
> > +		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_MODE(i),
> > +			     SUN8I_MIXER_BLEND_MODE_DEF);
> 
> You're reworking a significant part here as well, with some part
> moving (or being removed) and no clear justifications as to why you
> need to do that.
> 
> This is not only an issue when you want to review this code, but also
> if you happen to introduce a bug, then someone bisects and finds that
> commit. It's quite difficult in that case what part is actually
> breaking stuff.
> 
> Thanks!
> Maxime
> 
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
