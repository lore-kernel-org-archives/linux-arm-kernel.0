From: contact@paulk.fr (Paul Kocialkowski)
Date: Thu, 12 Apr 2018 01:12:13 +0200
Subject: [PATCH 1/3] drm/panel: Add RGB666 variant of Innolux AT070TN92
In-Reply-To: <20180411062835.oqzd34e2szrnv34b@flea>
References: <20180410213129.24049-1-contact@paulk.fr>
 <20180411062835.oqzd34e2szrnv34b@flea>
Message-ID: <e2c0a2c9442f1563865aaab310e066a18d425793.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le mercredi 11 avril 2018 ? 08:28 +0200, Maxime Ripard a ?crit :
> On Tue, Apr 10, 2018 at 11:31:27PM +0200, Paul Kocialkowski wrote:
> > This adds timings for the RGB666 variant of the Innolux AT070TN92
> > panel,
> > as found on the Ainol AW1 tablet.
> > 
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c | 26
> > ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c
> > b/drivers/gpu/drm/panel/panel-simple.c
> > index 5591984a392b..efeb2f2162bc 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -1063,6 +1063,29 @@ static const struct panel_desc
> > innolux_at070tn92 = {
> >  	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> >  };
> >  
> > +static const struct drm_display_mode innolux_at070tn92_rgb666_mode
> > = {
> > +	.clock = 40000,
> > +	.hdisplay = 800,
> > +	.hsync_start = 800 + 112,
> > +	.hsync_end = 800 + 112 + 1,
> > +	.htotal = 800 + 112 + 1 + 87,
> > +	.vdisplay = 480,
> > +	.vsync_start = 480 + 141,
> > +	.vsync_end = 480 + 141 + 1,
> > +	.vtotal = 480 + 141 + 1 + 38,
> > +	.vrefresh = 60,
> > +};
> 
> I'm not sure why you'd need different timings if the only difference
> is the bus width.

I'll try with the other timings, although it might be desirable to have
a higher clock speed thanks to the reduced number of wires on the bus.

> > +static const struct panel_desc innolux_at070tn92_rgb666 = {
> > +	.modes = &innolux_at070tn92_rgb666_mode,
> > +	.num_modes = 1,
> > +	.size = {
> > +		.width = 154,
> > +		.height = 86,
> > +	},
> > +	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> > +};
> > +
> >  static const struct display_timing innolux_g101ice_l01_timing = {
> >  	.pixelclock = { 60400000, 71100000, 74700000 },
> >  	.hactive = { 1280, 1280, 1280 },
> > @@ -2105,6 +2128,9 @@ static const struct of_device_id
> > platform_of_match[] = {
> >  	}, {
> >  		.compatible = "innolux,at070tn92",
> >  		.data = &innolux_at070tn92,
> > +	}, {
> > +		.compatible = "innolux,at070tn92-rgb666",
> > +		.data = &innolux_at070tn92_rgb666,
> 
> And this isn't a different device, it's just the integration in the
> board that is different, so you shouldn't have a different compatible
> here, but rather something like the bus-width property documented in
> the Documentation/devicetree/bindings/media/video-interfaces.txt file.

I'll take a look at it and try to craft v2 in this direction then.

Thanks for the review!

-- 
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180412/6dfda892/attachment.sig>
