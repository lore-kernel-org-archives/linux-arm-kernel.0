From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Wed, 29 Nov 2017 23:01:31 +0100
Subject: [PATCH 08/17] drm/sun4i: Add support for DE2 VI planes
In-Reply-To: <20171128210001.zhncdfkjzvwwxnnf@flea.home>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
 <20171127205750.19277-9-jernej.skrabec@siol.net>
 <20171128210001.zhncdfkjzvwwxnnf@flea.home>
Message-ID: <2148508.4McZUg54DD@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne torek, 28. november 2017 ob 22:00:01 CET je Maxime Ripard napisal(a):
> Hi,
> 
> On Mon, Nov 27, 2017 at 09:57:41PM +0100, Jernej Skrabec wrote:
> > This commit adds basic support for VI planes. They are meant for video
> > overlay and because of that they support YUV formats too. However, using
> > YUV planes is not straightforward, so only RGB support for now.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun8i_layer.c |  40 +++++++---
> >  drivers/gpu/drm/sun4i/sun8i_mixer.c | 144
> >  +++++++++++++++++++++++++++++++++--- drivers/gpu/drm/sun4i/sun8i_mixer.h
> >  |  38 ++++++++--
> >  3 files changed, 196 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_layer.c
> > b/drivers/gpu/drm/sun4i/sun8i_layer.c index 49ccdd0149bd..e1b6ad82145e
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_layer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_layer.c
> > @@ -47,13 +47,22 @@ static int sun8i_mixer_layer_atomic_check(struct
> > drm_plane *plane,> 
> >  					    true, true);
> >  
> >  }
> > 
> > +static void sun8i_mixer_layer_enable(struct sun8i_layer *layer, bool
> > enable) +{
> > +	struct sun8i_mixer *mixer = layer->mixer;
> > +
> > +	if (layer->id < mixer->cfg->vi_num)
> > +		sun8i_mixer_vi_layer_enable(mixer, layer->id, enable);
> > +	else
> > +		sun8i_mixer_ui_layer_enable(mixer, layer->id, enable);
> > +}
> > +
> > 
> >  static void sun8i_mixer_layer_atomic_disable(struct drm_plane *plane,
> >  
> >  					       struct drm_plane_state *old_state)
> >  
> >  {
> >  
> >  	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
> > 
> > -	struct sun8i_mixer *mixer = layer->mixer;
> > 
> > -	sun8i_mixer_layer_enable(mixer, layer->id, false);
> > +	sun8i_mixer_layer_enable(layer, false);
> > 
> >  }
> >  
> >  static void sun8i_mixer_layer_atomic_update(struct drm_plane *plane,
> > 
> > @@ -63,14 +72,21 @@ static void sun8i_mixer_layer_atomic_update(struct
> > drm_plane *plane,> 
> >  	struct sun8i_mixer *mixer = layer->mixer;
> >  	
> >  	if (!plane->state->visible) {
> > 
> > -		sun8i_mixer_layer_enable(mixer, layer->id, false);
> > +		sun8i_mixer_layer_enable(layer, false);
> > 
> >  		return;
> >  	
> >  	}
> > 
> > -	sun8i_mixer_update_layer_coord(mixer, layer->id, plane);
> > -	sun8i_mixer_update_layer_formats(mixer, layer->id, plane);
> > -	sun8i_mixer_update_layer_buffer(mixer, layer->id, plane);
> > -	sun8i_mixer_layer_enable(mixer, layer->id, true);
> > +	if (layer->id < mixer->cfg->vi_num) {
> > +		sun8i_mixer_update_vi_layer_coord(mixer, layer->id, plane);
> > +		sun8i_mixer_update_vi_layer_formats(mixer, layer->id, plane);
> > +		sun8i_mixer_update_vi_layer_buffer(mixer, layer->id, plane);
> > +	} else {
> > +		sun8i_mixer_update_ui_layer_coord(mixer, layer->id, plane);
> > +		sun8i_mixer_update_ui_layer_formats(mixer, layer->id, plane);
> > +		sun8i_mixer_update_ui_layer_buffer(mixer, layer->id, plane);
> > +	}
> > +
> > +	sun8i_mixer_layer_enable(layer, true);
> 
> So you can probably tell by the patches I had in my other serie, but
> we should really split the UI and VI support in two files, especially
> since it has pretty much no code path or data in common (if you
> combine this patch with the YUV support).

I guess same goes for UI and VI scalers. I will try to do some reasonable 
split in next version.

Best regards,
Jernej

> 
> Maxime
> 
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
