From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Wed, 03 Nov 2010 17:08:51 +0200
Subject: [PATCH 3/3] OMAP: use generic panel driver in board files
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034BE1EB1A@dbde02.ent.ti.com>
References: <1288730392-11223-1-git-send-email-bryan.wu@canonical.com>
	<1288730392-11223-4-git-send-email-bryan.wu@canonical.com>
	<FCCFB4CDC6E5564B9182F639FC356087034BE1EB1A@dbde02.ent.ti.com>
Message-ID: <1288796931.5614.199.camel@tubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-11-03 at 13:56 +0100, ext Taneja, Archit wrote:
> Hi,
> 
> linux-omap-owner at vger.kernel.org wrote:
> > Introduce some fields in struct panel, which will be used to
> > match the right panel configurations in generic panel driver.
> > 
> > Still keep sharp_ls_panel, since the sharp_ls_panel driver
> > contains blacklight control driver code which will be moved
> > out later. Then we can use generic driver for sharp_ls_panel.
> > 
> > Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> 
> [snip]
> 
> > diff --git a/arch/arm/plat-omap/include/plat/display.h
> > b/arch/arm/plat-omap/include/plat/display.h
> > index c915a66..6e1fbbd 100644
> > --- a/arch/arm/plat-omap/include/plat/display.h
> > +++ b/arch/arm/plat-omap/include/plat/display.h
> > @@ -346,6 +346,24 @@ struct omap_overlay_manager {
> >  	int (*disable)(struct omap_overlay_manager *mgr);  };
> > 
> > +struct omap_display_panel {
> > +	struct omap_video_timings timings;
> > +
> > +	int acbi;	/* ac-bias pin transitions per interrupt */ +	/* Unit: line
> > clocks */ +	int acb;	/* ac-bias pin frequency */
> > +
> > +	enum omap_panel_config config;
> > +
> > +	int power_on_delay;
> > +	int power_off_delay;
> > +	/*
> > +	 * Used to match device to panel configuration
> > +	 * when use generic panel driver
> > +	 */
> > +	const char *name;
> > +};
> > +
> >  struct omap_dss_device {
> >  	struct device dev;
> > 
> > @@ -395,15 +413,7 @@ struct omap_dss_device {
> >  		} venc;
> >  	} phy;
> > 
> > -	struct {
> > -		struct omap_video_timings timings;
> > -
> > -		int acbi;	/* ac-bias pin transitions per
> > interrupt */
> > -		/* Unit: line clocks */
> > -		int acb;	/* ac-bias pin frequency */
> > -
> > -		enum omap_panel_config config;
> > -	} panel;
> > +	struct omap_display_panel panel;
> > 
> >  	struct {
> >  		u8 pixel_size;
> 
> I don't think that changing the omap_dss_device structure is the best way
> to go about this. Members like power_on_delay and power_off_delay may not
> be required by all types of panels. Same goes for the new "name" member since
> its only used by the dummy dpi panels.
> 
> I think it would be better to go with the approach taken in panel-taal.c
> where a struct "panel_config" exists to take care of extra requirements.
> 
> The omap_dss_device struct should contain only those members which would be
> needed by the interface driver files like dsi.c, dpi.c etc. The rest should be
> taken care of the panel drivers internally.

Yes, the configuration for the panel is panel driver specific features,
and should not be in the standard structs. No need to add anything to
display.h.

In fact, there are things in display.h that should be removed, and this
configurable panel driver could do that also. omap_dss_device contains
reset_gpio, max_backlight_level, platform_enable/disable and
set/get_backlight, which should actually be in panel spesific struct.

 Tomi
