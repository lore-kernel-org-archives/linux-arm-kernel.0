From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 13 Jun 2017 17:51:42 +0800
Subject: [PATCH v2 07/11] drm: sun4i: add support for the TV encoder in H3
 SoC
In-Reply-To: <20170613074432.btwgc4e7pndtsvbf@flea.lan>
References: <20170604160149.30230-1-icenowy@aosc.io>
 <20170604160149.30230-8-icenowy@aosc.io>
 <20170607093845.cu5kk55nj72roysf@flea.lan>
 <362bb72d74cd7181ae02dbf73b0e724e@aosc.io>
 <20170613074432.btwgc4e7pndtsvbf@flea.lan>
Message-ID: <5A2149A9-CC7B-4946-9219-A4FE3228B402@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?6?13? GMT+08:00 ??3:44:32, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
>On Sun, Jun 11, 2017 at 02:43:42PM +0800, icenowy at aosc.io wrote:
>> ? 2017-06-07 17:38?Maxime Ripard ???
>> > On Mon, Jun 05, 2017 at 12:01:45AM +0800, Icenowy Zheng wrote:
>> > > Allwinner H3 features a TV encoder similar to the one in earlier
>SoCs,
>> > > but has a internal fixed clock divider that divides the TCON1
>clock
>> > > (called TVE clock in datasheet) by 11.
>> > > 
>> > > Add support for it.
>> > > 
>> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> > > ---
>> > > Changes in v2:
>> > > - Quirk part rewritten.
>> > > 
>> > >  drivers/gpu/drm/sun4i/sun4i_tv.c | 35
>> > > ++++++++++++++++++++++++++++++++++-
>> > >  1 file changed, 34 insertions(+), 1 deletion(-)
>> > > 
>> > > diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c
>> > > b/drivers/gpu/drm/sun4i/sun4i_tv.c
>> > > index 338b9e5bb2a3..b9ff6d5ea67a 100644
>> > > --- a/drivers/gpu/drm/sun4i/sun4i_tv.c
>> > > +++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
>> > > @@ -13,6 +13,7 @@
>> > >  #include <linux/clk.h>
>> > >  #include <linux/component.h>
>> > >  #include <linux/of_address.h>
>> > > +#include <linux/of_device.h>
>> > >  #include <linux/regmap.h>
>> > >  #include <linux/reset.h>
>> > > 
>> > > @@ -169,14 +170,21 @@ struct tv_mode {
>> > >  	const struct resync_parameters	*resync_params;
>> > >  };
>> > > 
>> > > +struct sun4i_tv_quirks {
>> > > +	int fixed_divider;
>> > > +};
>> > > +
>> > >  struct sun4i_tv {
>> > >  	struct drm_connector	connector;
>> > >  	struct drm_encoder	encoder;
>> > > 
>> > >  	struct clk		*clk;
>> > > +	struct clk		*mod_clk;
>> > >  	struct regmap		*regs;
>> > >  	struct reset_control	*reset;
>> > > 
>> > > +	const struct sun4i_tv_quirks *quirks;
>> > > +
>> > >  	struct sun4i_drv	*drv;
>> > >  };
>> > > 
>> > > @@ -391,6 +399,12 @@ static void sun4i_tv_mode_set(struct
>> > > drm_encoder *encoder,
>> > >  	struct sun4i_tcon *tcon = crtc->tcon;
>> > >  	const struct tv_mode *tv_mode = sun4i_tv_find_tv_by_mode(mode);
>> > > 
>> > > +	if (tv->quirks->fixed_divider) {
>> > > +		DRM_DEBUG_DRIVER("Applying fixed divider %d on TVE clock\n",
>> > > +				 tv->quirks->fixed_divider);
>> > > +		mode->crtc_clock *= tv->quirks->fixed_divider;
>> > > +	}
>> > > +
>> > 
>> > You're not allowed to change the mode in mode_set, and you
>shouldn't
>> > even change it. The output pixel clock is still 27MHz.
>> > 
>> > You should implement that using the states, as we discussed
>already.
>> 
>> After reading the comments at
>include/drm/drm_modeset_helper_vtables.h,
>> I think the atomic_check function is allowed to directly change
>> the adjust_mode of crtc_state.
>> 
>> And according to other comments at include/drm/drm_modes.h, the
>> crtc_clock in adjust_mode should be the clock to be really feed
>> to the hardware.
>> 
>> So I think I can just change this in atomic_check.
>> 
>> However, the mode_set function of sun4i_tv seems to be not
>> regarding adjusted_mode and still use original mode.
>> 
>> So my current design is:
>> - Multiply adjusted_mode in atomic_check.
>> - Feed adjust_mode to TCON code in mode_set function.
>> 
>> Is this proper?
>> 
>> (From my own understanding to the comments I think so.)
>
>No, it's not. The pixel clock in the mode is the pixel clock output
>physically by the connector. You want to use it for an intermediate
>clock in your pipeline.
>
>This is not the same clock, and not the same frequency.

So should a multiplier parameter be passed via
tcon1_mode_set function?

>
>Maxime
