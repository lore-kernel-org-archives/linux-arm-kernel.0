From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Mon, 08 Oct 2018 17:09:42 +0200
Subject: [PATCH v2 18/29] drm/sun4i: dw-hdmi: Add quirk for setting TMDS
 clock
In-Reply-To: <20181008091406.yjs2u22fmj72e4rj@flea>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-19-jernej.skrabec@siol.net>
 <20181008091406.yjs2u22fmj72e4rj@flea>
Message-ID: <8016466.hta3A6eauk@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ponedeljek, 08. oktober 2018 ob 11:14:06 CEST je Maxime Ripard napisal(a):
> Hi,
> 
> On Sun, Oct 07, 2018 at 11:38:54AM +0200, Jernej Skrabec wrote:
> > It turns out that H6 HDMI BSP kernel driver doesn't change TMDS rate at
> > all. At this point it is not clear whether it is just not necessary or
> > it would cause some kind of issues.
> > 
> > Add a quirk for it.
> > 
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 5 ++++-
> >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h | 1 +
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c index ec122136ee9d..e9e93f174b35
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > @@ -165,7 +165,9 @@ static int sun8i_dw_hdmi_bind(struct device *dev,
> > struct device *master,> 
> >  		goto err_disable_clk_tmds;
> >  	
> >  	}
> > 
> > -	drm_encoder_helper_add(encoder, &sun8i_dw_hdmi_encoder_helper_funcs);
> > +	if (hdmi->quirks->set_rate)
> > +		drm_encoder_helper_add(encoder,
> > +				       &sun8i_dw_hdmi_encoder_helper_funcs);
> 
> That seems a bit backward, it only works because we only have mode_set
> at the moment, and the only thing it does is changing the clock
> rate. As soon as we change one of these two assumptions, the code will
> break.
> 
> Why not just return in mode_set if that boolean is true?

My original intention was to optimize execution time a bit. If there is no 
helpers registered, there is no need to call callback which does nothing. But 
your way is probably more reasonable approach.

However, I'm pretty sure that even older HDMI controller doesn't need this 
rate changing code. All tests shown that changing HDMI controller divider 
doesn't have an effect on video or audio output. It's only there because BSP 
kernel driver set rate and AW engineer said it's necessary.

> 
> >  	drm_encoder_init(drm, encoder, &sun8i_dw_hdmi_encoder_funcs,
> >  	
> >  			 DRM_MODE_ENCODER_TMDS, NULL);
> > 
> > @@ -235,6 +237,7 @@ static int sun8i_dw_hdmi_remove(struct platform_device
> > *pdev)> 
> >  static const struct sun8i_dw_hdmi_quirks sun8i_a83t_quirks = {
> >  
> >  	.mode_valid = sun8i_dw_hdmi_mode_valid_a83t,
> > 
> > +	.set_rate = true,
> > 
> >  };
> >  
> >  static const struct of_device_id sun8i_dw_hdmi_dt_ids[] = {
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h index a645b8bc9f58..f9eb663865a4
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > @@ -173,6 +173,7 @@ struct sun8i_hdmi_phy {
> > 
> >  struct sun8i_dw_hdmi_quirks {
> >  
> >  	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
> >  	
> >  					   const struct drm_display_mode *mode);
> > 
> > +	bool set_rate;
> 
> This triggers a check in checkpatch. You should address them (and
> there's several in your series).

Till now we used bools in driver internal structures in spite of this 
warnings. So should we start using unsigned int? Or maybe bitfield with 
unsigned int as a base according to https://lkml.org/lkml/2017/11/21/384

As far as other issues reported by strict checkpatch go, most of them are DT 
lines over 80 charachters. This was tolerated till now. Last type of issues is 
that macro parameters weren't enclosed with braces. These issues won't be 
reported anymore in new series because sun8i_csc.h won't be touched if I drop 
patch which renames DE2 register macros (but original issue will remain).

Best regards,
Jernej

> 
> With both addressed,
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Thanks!
