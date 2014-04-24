From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Apr 2014 00:23:04 +0100
Subject: [PATCH] imx-drm: fix hdmi hotplug detection initial state
In-Reply-To: <CAJ+vNU0Tf6WnrRE-6FbJTFPrP6chfbaT5GTw5QbSWE2Hkemp8A@mail.gmail.com>
References: <E1Wb5Nd-0002Ef-Es@rmk-PC.arm.linux.org.uk>
 <CAJ+vNU23SE7ZumL34+6Wsv9c6rvcLx6jYQ_ed4uUY6yyGBnRBw@mail.gmail.com>
 <20140424220732.GE26756@n2100.arm.linux.org.uk>
 <CAJ+vNU0Tf6WnrRE-6FbJTFPrP6chfbaT5GTw5QbSWE2Hkemp8A@mail.gmail.com>
Message-ID: <20140424232304.GF26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 03:57:27PM -0700, Tim Harvey wrote:
> On Thu, Apr 24, 2014 at 3:07 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Apr 24, 2014 at 02:00:49PM -0700, Tim Harvey wrote:
> >> I'm still seeing issues with HDMI detect on powerup, at least on my
> >> Gateworks Ventana boards (which have no voltage devider or anything
> >> else on the HPD line to the IMX6 other than a TVS). I'm currently
> >> using your latest imx-drm-staging branch and have applied this patch
> >> on top of it. When I enable debug in imx-hdmi.c I see the following:
> >
> > So it's a similar setup to the Cubox-i.
> >
> <snip>
> >
> > which is only with imx-hdmi bound, no ldb.  The difference you will
> > notice is that there's the "Console: switching ..." line, which is
> > there because I have fbcon enabled.
> >
> > Therefore, I suspect that it is working as it should - if you enable
> > fbcon, it should automatically initialise.  If you don't have fbcon
> > enabled, then it'll probably wait for a userspace DRM driver to bring
> > it up.
> >
> 
> Russell,
> 
> Yes, your correct. If I enable fbcon it comes up at boot. But what if
> I don't want fbcon? I have CONFIG_LOGO=y and I would expect that to
> come up without needing to hotswap. Something must still be missing
> that is getting taken care of by fbcon.

Hmm.  I don't know - tracing the code paths, towards the end of the
imx-drm initialisation, we call drm_fbdev_cma_init(), which should
configure the initial modes - this will only happen if
CONFIG_DRM_IMX_FB_HELPER is enabled, which you seem to have set
already in your boot logs.

drm_fbdev_cma_init() will call drm_fb_helper_initial_config() to set
an initial configuration.  It would seem to think there are available
modes, otherwise you'd get a "No connectors reported connected with modes"
message.

That creates a fb device of the desired size for the mode by calling
back into drm_fbdev_cma_create().  That creates the fbdev device, and
back in drm_fb_helper_single_fb_probe(), the fbdev device is
registered.

And at that point, we're into the depths of the fb device layers to
decide what to do... and it's up to them to set an initial mode.

So, the question I'd put to you is: do you get an initial mode when
trying the same configuration but with a pure fb driver?  I suspect
you'll be in the same situation: without fbcon, fbdev doesn't
initialise registered framebuffers with an initial mode.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
