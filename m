From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Wed, 13 Nov 2013 08:53:18 +0100
Subject: [PATCHv3 1/8] drm: Add the lacking DRM_MODE_FLAG_* for matching
 the DISPLAY_FLAGS_*
In-Reply-To: <20131112170455.GQ16735@n2100.arm.linux.org.uk>
References: <1384274965-30549-1-git-send-email-denis@eukrea.com>
 <20131112170455.GQ16735@n2100.arm.linux.org.uk>
Message-ID: <20131113085318.394991f3@e6520eb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Le Tue, 12 Nov 2013 17:04:55 +0000,
Russell King - ARM Linux <linux@arm.linux.org.uk> a ?crit :
> On Tue, Nov 12, 2013 at 05:49:18PM +0100, Denis Carikli wrote:
> > diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> > index fc2adb6..586c12f 100644
> > --- a/drivers/gpu/drm/drm_modes.c
> > +++ b/drivers/gpu/drm/drm_modes.c
> > @@ -537,6 +537,15 @@ int drm_display_mode_from_videomode(const struct videomode *vm,
> >  		dmode->flags |= DRM_MODE_FLAG_DBLSCAN;
> >  	if (vm->flags & DISPLAY_FLAGS_DOUBLECLK)
> >  		dmode->flags |= DRM_MODE_FLAG_DBLCLK;
> > +	if (vm->flags & DISPLAY_FLAGS_DE_LOW)
> > +		dmode->flags |= DRM_MODE_FLAG_DE_LOW;
> > +	if (vm->flags & DISPLAY_FLAGS_DE_HIGH)
> > +		dmode->flags |= DRM_MODE_FLAG_DE_HIGH;
> > +	if (vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
> > +		dmode->flags |= DRM_MODE_FLAG_PIXDATA_POSEDGE;
> > +	if (vm->flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
> > +		dmode->flags |= DRM_MODE_FLAG_PIXDATA_NEGEDGE;
> > +
> 
> I'm still not convinced that these should be exposed in *any* way to
> userspace - I'm with Ville Syrj?l? on this point.
> 
> Yes, you've moved their definition out of a uapi header file, but
> they're still leaking out of kernel space via calls (and with Xorg,
> they'll leak into the DisplayMode structures within the X server.)
> 
> Now, here's the thing... The polarity of the display enable signal.
> That's a property of the connected device right?  It doesn't change
> with respect to the displayed mode unlike the hsync/vsync signals.
> If that's true, it should not be here.
> 
> Same goes for the pixel clock edge.  If it's a property of the
> connected device and doesn't have a dependence on the displayed
> mode, then it should not be in the DRM mode structure.

What would be the right way to configure these settings without
exposing them to userspace ?

As explained in my answer to Fabio, these settings are currently
hardcoded into ipuv3-crtc and we need to configure them to support more
TFT panels using the IPUV3 Parallel Display Interface.

Thanks
Eric
