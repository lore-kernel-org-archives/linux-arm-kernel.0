From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 24 Oct 2018 17:57:59 +0100
Subject: [PATCH 2/4] drm/panel: simple: Add support for the Lemaker BL035
 3.5" LCD
In-Reply-To: <30178c8b263656a9c285e45c78e1908927c99c48.camel@paulk.fr>
References: <20181010114134.8211-1-contact@paulk.fr>
 <20181010114134.8211-2-contact@paulk.fr>
 <20181010145850.krwe7wlqkbcpja33@flea>
 <30178c8b263656a9c285e45c78e1908927c99c48.camel@paulk.fr>
Message-ID: <20181024165759.k6cnxyzgpiiuaigs@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 12:08:17PM +0200, Paul Kocialkowski wrote:
> Hi,
> 
> Le mercredi 10 octobre 2018 ? 16:58 +0200, Maxime Ripard a ?crit :
> > On Wed, Oct 10, 2018 at 01:41:32PM +0200, Paul Kocialkowski wrote:
> > > This adds support for the 3.5" LCD panel from Lemaker, sold for use with
> > > BananaPi boards. It comes with a 24-bit RGB888 parallel interface and
> > > requires an active-low DE signal
> > > 
> > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > ---
> > >  drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
> > >  1 file changed, 27 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > > index 97964f7f2ace..229080fcf65e 100644
> > > --- a/drivers/gpu/drm/panel/panel-simple.c
> > > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > > @@ -1461,6 +1461,30 @@ static const struct panel_desc kyo_tcg121xglp = {
> > >  	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> > >  };
> > >  
> > > +static const struct drm_display_mode lemaker_bl035_mode = {
> > > +	.clock = 7000,
> > > +	.hdisplay = 320,
> > > +	.hsync_start = 320 + 20,
> > > +	.hsync_end = 320 + 20 + 30,
> > > +	.htotal = 320 + 20 + 30 + 38,
> > > +	.vdisplay = 240,
> > > +	.vsync_start = 240 + 4,
> > > +	.vsync_end = 240 + 4 + 3,
> > > +	.vtotal = 240 + 4 + 3 + 15,
> > > +	.vrefresh = 60,
> > > +};
> > > +
> > > +static const struct panel_desc lemaker_bl035 = {
> > > +	.modes = &lemaker_bl035_mode,
> > > +	.num_modes = 1,
> > > +	.size = {
> > > +		.width = 70,
> > > +		.height = 52,
> > > +	},
> > > +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> > > +	.bus_flags = DRM_BUS_FLAG_DE_LOW,
> > > +};
> > > +
> > >  static const struct drm_display_mode lg_lb070wv8_mode = {
> > >  	.clock = 33246,
> > >  	.hdisplay = 800,
> > > @@ -2456,6 +2480,9 @@ static const struct of_device_id platform_of_match[] = {
> > >  	}, {
> > >  		.compatible = "kyo,tcg121xglp",
> > >  		.data = &kyo_tcg121xglp,
> > > +	}, {
> > > +		.compatible = "lemaker,bl035",
> > > +		.data = &lemaker_bl035,
> > 
> > You should document that new compatible. Also, where is this name
> > coming from? Is it the name it's sold under? something you came up
> > with?
> 
> Oh right, I forgot to document the compatible (and add the new vendor).
> 
> The name "BL035" comes from the PCB itself, where it reads "BL035-RGB-
> 002" under the Lemaker logo. I went for "BL035" to keep it short.
> 
> The latter part seems to be the PCB revision. According to the fex
> files[0], the timings are the same for all the screens of the same size
> (regardless of revision), so that revision probably shouldn't be in the
> panel name.
> 
> As for the "RGB" part, Lemaker only makes 3.5 and 5 inch LCDs with a
> parallel RGB interface and 7 and 10.1 inch LCDs with LVDS, so there is
> no ambiguity for now.
> 
> Do you think it makes sense to keep that part in the panel name
> nevertheless?

I'd just put the full reference, to be on the safe side.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
